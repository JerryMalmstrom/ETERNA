<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="http://ead3.archivists.org/schema/"
	exclude-result-prefixes="ead">
	<xsl:output method="xml" indent="yes" encoding="UTF-8"
		omit-xml-declaration="yes" />

	<xsl:template match="/">
		<doc>
			<xsl:choose>
				<xsl:when test="//ead:control/ead:recordid/text()">
					<field name="unitId_txt">
						<xsl:value-of select="//ead:control/ead:recordid/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:archdesc/ead:did/ead:unitid/text()">
					<field name="unitId_txt">
						<xsl:value-of select="//ead:archdesc/ead:did/ead:unitid/text()" />
					</field>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="//ead:control/ead:filedesc/ead:titlestmt/ead:titleproper/text()">
					<field name="title">
						<xsl:value-of select="//ead:control/ead:filedesc/ead:titlestmt/ead:titleproper/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:archdesc/ead:did/ead:unittitle/text()">
					<field name="title">
						<xsl:value-of select="//ead:archdesc/ead:did/ead:unittitle/text()" />
					</field>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="//ead:control/ead:conventiondeclaration/ead:citation/text()">
					<field name="rules_txt">
						<xsl:value-of select="//ead:control/ead:conventiondeclaration/ead:citation/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:profiledesc/ead:descrules/text()">
					<field name="rules_txt">
						<xsl:value-of select="//ead:profiledesc/ead:descrules/text()" />
					</field>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="//ead:control/ead:maintenancehistory/ead:maintenanceevent/ead:eventdatetime/@standarddate/text()">
					<field name="descriptiveDate_txt">
						<xsl:value-of select="//ead:control/ead:maintenancehistory/ead:maintenanceevent/ead:eventdatetime/@standarddate/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:control/ead:maintenancehistory/ead:maintenanceevent/ead:eventdatetime/text()">
					<field name="descriptiveDate_txt">
						<xsl:value-of select="//ead:control/ead:maintenancehistory/ead:maintenanceevent/ead:eventdatetime/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:archdesc/ead:did/ead:unitdate/text()">
					<field name="descriptiveDate_txt">
						<xsl:value-of select="//ead:archdesc/ead:did/ead:unitdate/text()" />
					</field>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="//ead:control/ead:sources/ead:source/ead:sourceentry/text()">
					<field name="sources_txt">
						<xsl:value-of select="//ead:control/ead:sources/ead:source/ead:sourceentry/text()" />
					</field>
				</xsl:when>
				<xsl:when test="//ead:archdesc/ead:did/ead:didnote[@localtype='sourcesdescription']/text()">
					<field name="sources_txt">
						<xsl:value-of select="//ead:archdesc/ead:did/ead:didnote[@type='sourcesdescription']/text()" />
					</field>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="//ead:did/ead:unitdatestructured">
					<xsl:if test="//ead:did/ead:unitdatestructured/ead:daterange/ead:fromdate/@standarddate">
						<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:fromdate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateInitial">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
						<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:fromdate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateInitial">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>-01T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
						<xsl:analyze-string regex="^(\d{{4}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:fromdate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateInitial">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>-01-01T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:if>
					<xsl:if test="//ead:did/ead:unitdatestructured/ead:daterange/ead:todate/@standarddate">
						<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:todate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateFinal">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
						<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:todate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateFinal">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>-01T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
						<xsl:analyze-string regex="^(\d{{4}})$" select="normalize-space(//ead:did/ead:unitdatestructured/ead:daterange/ead:todate/@standarddate)">
							<xsl:matching-substring>
								<field name="dateFinal">
									<xsl:value-of select="regex-group(1)" />
									<xsl:text>-01-01T00:00:00Z</xsl:text>
								</field>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:if>
				</xsl:when>
				<xsl:when test="//ead:did/ead:unitdate/@normal">
					<xsl:choose>
						<xsl:when test="contains(//ead:did/ead:unitdate/@normal, '/')">	<!-- initial/final -->
							<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$"
								select="normalize-space(substring-before(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateInitial">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$"
								select="normalize-space(substring-before(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateInitial">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-01T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})$"
								select="normalize-space(substring-before(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateInitial">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-01-01T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})(\d{{2}})$"
								select="normalize-space(substring-before(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateInitial">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(3)" />
										<xsl:text>T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})$"
								select="normalize-space(substring-before(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateInitial">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-01T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
		
							<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}}-02)$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-28T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}}-(0[469]|11))$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-30T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-31T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-12-31T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})(\d{{2}})$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(3)" />
										<xsl:text>T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(02)$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-28T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(0[469]|11)$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-30T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
							<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})$"
								select="normalize-space(substring-after(//ead:did/ead:unitdate/@normal, '/'))">
								<xsl:matching-substring>
									<field name="dateFinal">
										<xsl:value-of select="regex-group(1)" />
										<xsl:text>-</xsl:text>
										<xsl:value-of select="regex-group(2)" />
										<xsl:text>-31T00:00:00Z</xsl:text>
									</field>
								</xsl:matching-substring>
							</xsl:analyze-string>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="//ead:did/ead:unitdate[@label='UnitDateInitial']">	<!-- initial date. internal 'hack' -->
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												-01-01T00:00:00Z
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												-
												<xsl:value-of select="regex-group(3)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
								<xsl:when test="//ead:did/ead:unitdate[@label='UnitDateFinal']">	<!-- final date. internal 'hack' -->
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateFinal">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateFinal">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateFinal">
												<xsl:value-of select="regex-group(1)" />
												-01-01T00:00:00Z
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateFinal">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												-
												<xsl:value-of select="regex-group(3)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateFinal">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
								<xsl:otherwise> <!-- fallback to date initial -->
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}}-\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												-01-01T00:00:00Z
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												-
												<xsl:value-of select="regex-group(3)" />
												<xsl:text>T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
									<xsl:analyze-string regex="^(\d{{4}})(\d{{2}})$"
										select="normalize-space(//ead:did/ead:unitdate/@normal)">
										<xsl:matching-substring>
											<field name="dateInitial">
												<xsl:value-of select="regex-group(1)" />
												<xsl:text>-</xsl:text>
												<xsl:value-of select="regex-group(2)" />
												<xsl:text>-01T00:00:00Z</xsl:text>
											</field>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>

			<xsl:if test="//ead:archdesc/ead:did/ead:unitid/@countrycode">
				<field name="countryCode_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:unitid/@countrycode" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/@level">
				<xsl:choose>
					<xsl:when test="//ead:archdesc/@level = 'otherlevel'">
						<field name="level">
							<xsl:value-of select="//ead:archdesc/@otherlevel" />
						</field>
					</xsl:when>
					<xsl:otherwise>
						<field name="level">
							<xsl:value-of select="//ead:archdesc/@level" />
						</field>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:materialspec/text()">
				<field name="materialSpec_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:materialspec/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:origination[not(*)]/text()">
				<field name="origination_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:origination[not(*)]/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:physdesc/text()">
				<field name="physdesc_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdesc/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:physdesc/ead:extent/text()">
				<field name="extent_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdesc/ead:extent/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:physdescstructured/ead:quantity/text()">
				<field name="quantity_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdescstructured/ead:quantity/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:physdescstructured/ead:unittype/text()">
				<field name="unittype_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdescstructured/ead:unittype/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:physdescstructured/ead:physfacet/text()">
				<field name="physfacet_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdescstructured/ead:physfacet/text()" />
				</field>
			</xsl:if> 
			<xsl:if test="//ead:archdesc/ead:did/ead:physdescstructured/ead:dimensions/text()">
				<field name="dimensions_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:physdescstructured/ead:dimensions/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:prefercite/ead:p/text()">
				<field name="quote_txt">
					<xsl:value-of select="//ead:archdesc/ead:prefercite/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:bioghist/ead:p/text()">
				<field name="bioghist_txt">
					<xsl:value-of select="//ead:archdesc/ead:bioghist/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:origination[lower-case(@label)='creator']/ead:persname/ead:part/text()">
				<field name="creator_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:origination[lower-case(@label)='creator']/ead:persname/ead:part/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:origination[lower-case(@label)='producer']/ead:corpname/ead:part/text()">
				<field name="producer_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:origination[lower-case(@label)='producer']/ead:corpname/ead:part/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:unitid/@repositorycode">
				<field name="repositoryCode_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:unitid/@repositorycode" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:repository/ead:corpname/text()">
				<field name="repository_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:repository/ead:corpname/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:custodhist/ead:p/text()">
				<field name="custodHist_txt">
					<xsl:value-of select="//ead:archdesc/ead:custodhist/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:acqinfo/ead:p/text()">
				<field name="acqInfo_txt">
					<xsl:value-of select="//ead:archdesc/ead:acqinfo/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:scopecontent/ead:p/text()">
				<field name="description">
					<xsl:value-of select="//ead:archdesc/ead:scopecontent/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:appraisal/ead:p/text()">
				<field name="appraisal_txt">
					<xsl:value-of select="//ead:archdesc/ead:appraisal/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:accruals/ead:p/text()">
				<field name="accruals_txt">
					<xsl:value-of select="//ead:archdesc/ead:accruals/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:arrangement/ead:p/text()">
				<field name="systemOfArrangement_txt">
					<xsl:value-of select="//ead:archdesc/ead:arrangement/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:phystech/ead:p/text()">
				<field name="phystech_txt">
					<xsl:value-of select="//ead:archdesc/ead:phystech/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:accessrestrict/ead:p/text()">
				<field name="accessRestrict_txt">
					<xsl:value-of select="//ead:archdesc/ead:accessrestrict/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:userestrict/ead:p/text()">
				<field name="useRestrict_txt">
					<xsl:value-of select="//ead:archdesc/ead:userestrict/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:langmaterial/ead:language/text()[normalize-space()]">
				<field name="language_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:langmaterial/ead:language/text()[normalize-space()]" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:langmaterial/text()[normalize-space()]">
				<field name="languageScriptNotes_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:langmaterial/text()[normalize-space()]" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:originalsloc/ead:p/text()">
				<field name="originalsLoc_txt">
					<xsl:value-of select="//ead:archdesc/ead:originalsloc/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:altformavail/ead:p/text()">
				<field name="altFormAvail_txt">
					<xsl:value-of select="//ead:archdesc/ead:altformavail/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:relatedmaterial/ead:p/text()">
				<field name="relatedMaterial_txt">
					<xsl:value-of select="//ead:archdesc/ead:relatedmaterial/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:bibliography/ead:p/text()">
				<field name="bibliography_txt">
					<xsl:value-of select="//ead:archdesc/ead:bibliography/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:otherfindaid/ead:p/text()">
				<field name="otherFindAid_txt">
					<xsl:value-of select="//ead:archdesc/ead:otherfindaid/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:did/ead:didnote[@localtype='generalnote']/text()">
				<field name="notes_txt">
					<xsl:value-of select="//ead:archdesc/ead:did/ead:didnote[@localtype='generalnote']/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:odd[@localtype='statusdescription']/ead:p/text()">
				<field name="statusDescription_txt">
					<xsl:value-of select="//ead:archdesc/ead:odd[@localtype='statusdescription']/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:odd[@localtype='levelofdetail']/ead:p/text()">
				<field name="levelOfDetail_txt">
					<xsl:value-of select="//ead:archdesc/ead:odd[@localtype='levelofdetail']/ead:p/text()" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:processinfo/ead:p/ead:date/string()[normalize-space()]">
				<field name="processDates_txt">
					<xsl:value-of select="//ead:archdesc/ead:processinfo/ead:p/ead:date/string()[normalize-space()]" />
				</field>
			</xsl:if>
			<xsl:if test="//ead:archdesc/ead:processinfo/ead:p/text()[normalize-space()]">
				<field name="archivistNotes_txt">
					<xsl:value-of select="//ead:archdesc/ead:processinfo/ead:p/text()[normalize-space()]" />
				</field>
			</xsl:if>
		</doc>
	</xsl:template>
</xsl:stylesheet>
