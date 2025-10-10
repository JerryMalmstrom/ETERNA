# User Configuration

ETERNA allows administrators to extend user profiles with additional custom fields beyond the standard user information. This feature is particularly useful for organizations that need to collect specific information about their users for compliance, organizational, or administrative purposes.

## Overview

User extra fields are additional metadata fields that can be added to user profiles. These fields appear in the user creation and editing forms and are stored as part of the user's profile data.

### Key Features

- **Custom Fields**: Add any number of additional fields to user profiles
- **Field Types**: Support for text, textarea, date, and dropdown list fields
- **Internationalization**: Centralized translations with fallback support
- **Flexible Configuration**: Easy to modify and extend without code changes

## Configuration Files

User extra fields are configured through several files:

### Template File
**Location**: `roda-ui/roda-wui/src/main/resources/config/users/user_extra.xml.hbs`

This Handlebars template defines the structure and configuration of all user extra fields.

### Translation Files
**English**: `roda-ui/roda-wui/src/main/resources/config/i18n/ServerMessages.properties`

**Swedish**: `roda-ui/roda-wui/src/main/resources/config/i18n/ServerMessages_sv_SE.properties`

These files contain the centralized translations for field labels.

## Field Configuration

Each field in the template is defined using the `field` helper with the following attributes:

### Basic Attributes
- `name`: Unique identifier for the field
- `order`: Display order (numeric)
- `type`: Field type (`text`, `textarea`, `date`, `list`, `separator`)
- `label`: Inline JSON translations (fallback)
- `labeli18n`: Server-side translation key (primary)
- `xpath`: XML path for data storage

### Field Types

#### Text Field
```handlebars
{{~field
name="fieldName"
order="10"
label='{"en": "Field Label", "sv_SE": "Fältetikett"}'
labeli18n="user.extra.field.name"
xpath="//*:fieldName/string()"
~}}
```

#### Textarea Field
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

#### Date Field
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

#### Dropdown List
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

#### Separator
```handlebars
{{~field
name="sectionHeader"
order="50"
type="separator"
label='{"en": "Section Header", "sv_SE": "Avsnittsrubrik"}'
labeli18n="user.extra.section.header"
~}}
```

## Translation System

ETERNA uses a dual translation system for maximum reliability:

### Primary Translation (Server-side)
- Uses `labeli18n` attribute with keys from ServerMessages files
- Centralized management in `ServerMessages.properties` and `ServerMessages_sv_SE.properties`
- Processed server-side during template rendering

### Fallback Translation (Client-side)
- Uses `label` attribute with inline JSON
- Contains translations for all supported locales
- Processed client-side if server translation fails

### Translation Key Naming Convention
```
user.extra.[field.identifier]
```

Examples:
- `user.extra.identification.area`
- `user.extra.phone.number`
- `user.extra.business.category`

## Adding New Fields

### Step 1: Add Translation Keys
Add entries to both ServerMessages files:

**ServerMessages.properties**:
```
user.extra.new.field = New Field Label
```

**ServerMessages_sv_SE.properties**:
```
user.extra.new.field = Ny fältetikett
```

### Step 2: Update Template
Add the field definition to `user_extra.xml.hbs`:

```handlebars
{{~field
name="newField"
order="XX"
label='{"en": "New Field", "sv_SE": "Nytt fält"}'
labeli18n="user.extra.new.field"
xpath="//*:newField/string()"
~}}
```

### Step 3: Update XML Output
Add the corresponding XML element to the template's XML output section:

```xml
<newField>{{newField}}</newField>
```

## System User Restrictions

**Important**: System users (`admin` and `guest`) are intentionally excluded from having configurable extra fields. This is a security and stability measure to prevent modification of critical system accounts.

- ✅ **Regular users**: Can have extra fields configured
- ❌ **System users** (`admin`, `guest`): Extra fields are not displayed or configurable

## Current Implementation

The current user extra fields configuration includes:

### Identification Area
- Document type (dropdown)
- Identification number (text)
- Date of issue (date)
- Locality of issue (text)
- Fiscal ID (text)

### Personal Information Area
- Country of birth (text)
- Postal address (textarea)
- Postal code (text)
- Locality (text)
- Country of residence (text)

### Business Information Area
- Area of activity (dropdown with 15 options)

### Contact Area
- Phone number (text)
- Fax (text)

### Notes Area
- Notes (textarea)

## Troubleshooting

### Fields Not Displaying
1. Check that the template syntax is correct
2. Verify JSON parsing (especially for `optionsLabels`)
3. Ensure translation keys exist in ServerMessages files
4. Check browser console for JavaScript errors

### Translation Issues
1. Verify `labeli18n` keys exist in ServerMessages files
2. Check that inline JSON in `label` is valid
3. Confirm locale settings in the application

### Form Validation
- Use `mandatory="true"` attribute for required fields
- Custom validation can be implemented in the client-side form handling

## Best Practices

1. **Use Descriptive Names**: Choose clear, descriptive field names and labels
2. **Consistent Ordering**: Use logical numeric ordering for fields
3. **Translation Coverage**: Always provide both server-side and fallback translations
4. **Field Validation**: Mark required fields appropriately
5. **Testing**: Test field display in both English and Swedish locales

## Related Files

- Template: `config/users/user_extra.xml.hbs`
- English translations: `config/i18n/ServerMessages.properties`
- Swedish translations: `config/i18n/ServerMessages_sv_SE.properties`
- Processing code: `BrowserHelper.java` (server-side translation)
