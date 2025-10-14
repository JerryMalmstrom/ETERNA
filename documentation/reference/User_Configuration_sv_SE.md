# Användarkonfiguration

ETERNA tillåter administratörer att utöka användarprofiler med ytterligare anpassade fält utöver standardanvändarinformationen. Denna funktion är särskilt användbar för organisationer som behöver samla in specifik information om sina användare för efterlevnad, organisatoriska eller administrativa ändamål.

## Översikt

Användarextrafält är ytterligare metadatafält som kan läggas till användarprofiler. Dessa fält visas i användarskapande- och redigeringsformulären och lagras som en del av användarens profildata.

### Viktiga funktioner

- **Anpassade fält**: Lägg till valfritt antal ytterligare fält till användarprofiler
- **Fälttyper**: Stöd för text, textarea, datum och rullgardinslistor
- **Internationalisering**: Centraliserade översättningar med fallback-stöd
- **Flexibel konfiguration**: Enkelt att modifiera och utöka utan kodändringar

## Konfigurationsfiler

Användarextrafält konfigureras genom flera filer:

### Mallfil
**Plats**: `roda-ui/roda-wui/src/main/resources/config/users/user_extra.xml.hbs`

Denna Handlebars-mall definierar strukturen och konfigurationen av alla användarextrafält.

### Översättningsfiler
**Engelska**: `roda-ui/roda-wui/src/main/resources/config/i18n/ServerMessages.properties`

**Svenska**: `roda-ui/roda-wui/src/main/resources/config/i18n/ServerMessages_sv_SE.properties`

Dessa filer innehåller de centraliserade översättningarna för fältetiketter.

## Fältkonfiguration

Varje fält i mallen definieras med hjälp av `field`-helpern med följande attribut:

### Grundläggande attribut
- `name`: Unik identifierare för fältet
- `order`: Visningsordning (numerisk)
- `type`: Fälttyp (`text`, `textarea`, `date`, `list`, `separator`)
- `label`: Inline JSON-översättningar (fallback)
- `labeli18n`: Server-side översättningsnyckel (primär)
- `xpath`: XML-sökväg för datalagring

### Fälttyper

#### Textfält
```handlebars
{{~field
name="fieldName"
order="10"
label='{"en": "Fältetikett", "sv_SE": "Fältetikett"}'
labeli18n="user.extra.field.name"
xpath="//*:fieldName/string()"
~}}
```

#### Textarea-fält
```handlebars
{{~field
name="description"
order="20"
type="textarea"
label='{"en": "Description", "sv_SE": "Beskrivning"}'
labeli18n="user.extra.description"
xpath="//*:description/string()"
~}}
```

#### Datumfält
```handlebars
{{~field
name="birthDate"
order="30"
type="date"
label='{"en": "Birth Date", "sv_SE": "Födelsedatum"}'
labeli18n="user.extra.birth.date"
xpath="//*:birthDate/string()"
~}}
```

#### Rullgardinslista
```handlebars
{{~field
name="category"
order="40"
type="list"
options='["option1","option2","option3"]'
optionsLabels='{"option1":{"en":"Option 1","sv_SE":"Alternativ 1"},"option2":{"en":"Option 2","sv_SE":"Alternativ 2"}}'
label='{"en": "Category", "sv_SE": "Kategori"}'
labeli18n="user.extra.category"
xpath="//*:category/string()"
~}}
```

#### Avskiljare
```handlebars
{{~field
name="sectionHeader"
order="50"
type="separator"
label='{"en": "Section Header", "sv_SE": "Avsnittsrubrik"}'
labeli18n="user.extra.section.header"
~}}
```

## Översättningssystem

ETERNA använder ett dualt översättningssystem för maximal tillförlitlighet:

### Primär översättning (Server-side)
- Använder `labeli18n`-attribut med nycklar från ServerMessages-filer
- Centraliserad hantering i `ServerMessages.properties` och `ServerMessages_sv_SE.properties`
- Bearbetas server-side under mallrendering

### Fallback-översättning (Client-side)
- Använder `label`-attribut med inline JSON
- Innehåller översättningar för alla supporterade lokaleringar
- Bearbetas client-side om server-översättning misslyckas

### Översättningsnyckelnamnkonvention
```
user.extra.[field.identifier]
```

Exempel:
- `user.extra.identification.area`
- `user.extra.phone.number`
- `user.extra.business.category`

## Lägga till nya fält

### Steg 1: Lägg till översättningsnycklar
Lägg till poster i båda ServerMessages-filer:

**ServerMessages.properties**:
```
user.extra.new.field = New Field Label
```

**ServerMessages_sv_SE.properties**:
```
user.extra.new.field = Ny fältetikett
```

### Steg 2: Uppdatera mall
Lägg till fältdefinitionen i `user_extra.xml.hbs`:

```handlebars
{{~field
name="newField"
order="XX"
label='{"en": "New Field", "sv_SE": "Nytt fält"}'
labeli18n="user.extra.new.field"
xpath="//*:newField/string()"
~}}
```

### Steg 3: Uppdatera XML-utdata
Lägg till motsvarande XML-element i mallens XML-utdatasektion:

```xml
<newField>{{newField}}</newField>
```

## Systemanvändarbegränsningar

**Viktigt**: Systemanvändare (`admin` och `guest`) är avsiktligt undantagna från att ha konfigurerbara extrafält. Detta är en säkerhets- och stabilitetsåtgärd för att förhindra modifiering av kritiska systemkonton.

- ✅ **Vanliga användare**: Kan ha extrafält konfigurerade
- ❌ **Systemanvändare** (`admin`, `guest`): Extrafält visas inte och kan inte konfigureras

## Nuvarande implementation

Den nuvarande användarextrafältkonfigurationen inkluderar:

### Identifikationsområde
- Dokumenttyp (rullgardinsmeny)
- Identifikationsnummer (text)
- Utfärdandedatum (datum)
- Utfärdandeort (text)
- Skatte-ID (text)

### Personlig informationsområde
- Födelseland (text)
- Postadress (textarea)
- Postnummer (text)
- Ort (text)
- Bosättningsland (text)

### Verksamhetsinformationsområde
- Verksamhetsområde (rullgardinsmeny med 15 alternativ)

### Kontaktområde
- Telefonnummer (text)
- Fax (text)

### Anteckningsområde
- Anteckningar (textarea)

## Felsökning

### Fält visas inte
1. Kontrollera att mallsyntaxen är korrekt
2. Verifiera JSON-tolkning (särskilt för `optionsLabels`)
3. Säkerställ att översättningsnycklar finns i ServerMessages-filer
4. Kontrollera webbläsarkonsolen för JavaScript-fel

### Översättningsproblem
1. Verifiera att `labeli18n`-nycklar finns i ServerMessages-filer
2. Kontrollera att inline JSON i `label` är giltig
3. Bekräfta språkinställningar i applikationen

### Formulärvalidering
- Använd `mandatory="true"`-attribut för obligatoriska fält
- Anpassad validering kan implementeras i client-side formulärhantering

## Bästa praxis

1. **Använd beskrivande namn**: Välj tydliga, beskrivande fältnamn och etiketter
2. **Konsekvent ordning**: Använd logisk numerisk ordning för fält
3. **Översättningstäckning**: Tillhandahåll alltid både server-side och fallback-översättningar
4. **Fältvalidering**: Markera obligatoriska fält på lämpligt sätt
5. **Testning**: Testa fältvisning i både engelska och svenska språkområden

## Relaterade filer

- Mall: `config/users/user_extra.xml.hbs`
- Engelska översättningar: `config/i18n/ServerMessages.properties`
- Svenska översättningar: `config/i18n/ServerMessages_sv_SE.properties`
- Bearbetningskod: `BrowserHelper.java` (server-side översättning)
