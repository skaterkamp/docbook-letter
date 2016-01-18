<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db ng exsl"
                version='0.8'>
<xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl"/>
<xsl:output method="xml" indent="no"/>

	<!-- 
	Stylesheet for DIN 5008 Form B.
	See https://de.wikipedia.org/wiki/DIN_5008

	Copyright 2016 Stefan Katerkamp.
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	http://www.apache.org/licenses/LICENSE-2.0
	-->

	<!--
	When printing: make sure the page is printed without shrinking ("fit to printable
	area").  http://xmlgraphics.apache.org/fop/faq.html#pdf-print-contortion
	There is no double sided option with this format.
	-->

	<!-- support letter root element -->
	<xsl:variable name="root.elements" select="' appendix article bibliography book chapter colophon dedication glossary index part preface qandaset refentry reference sect1 section set setindex letter '"/>

	<xsl:param name="admon.graphics" select="1"/>
	<xsl:param name="admon.graphics.path">/usr/share/xml/docbook/stylesheet/docbook-xsl/images/</xsl:param>
	<xsl:param name="admon.graphics.extension">.svg</xsl:param>
	<xsl:param name="admon.textlabel" select="0"/>


	<xsl:param name="body.font.master">11</xsl:param>
	<xsl:param name="body.font.family">sans-serif</xsl:param>
	<xsl:param name="paper.type">A4</xsl:param>
	<xsl:param name="page.margin.top">10mm</xsl:param>
	<xsl:param name="page.margin.bottom">10mm</xsl:param>
	<xsl:param name="test.drawframes">0</xsl:param>
	<xsl:param name="test.frame.color">
		<xsl:choose>
			<xsl:when test="$test.drawframes != 0">blue</xsl:when>
			<xsl:otherwise>white</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="test.frame.linewidth">
		<xsl:choose>
			<xsl:when test="$test.drawframes != 0">0.5mm</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<!-- asciidoctor creates section titles -->
	<xsl:attribute-set name="section.title.level1.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level2.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level3.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level4.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level5.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.level6.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="section.title.properties">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.fontset"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="text-align">start</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:value-of select="$title.margin.left"/>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:param name="section.autolabel" select="1"/>
	<xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="admonition.title.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	<!-- indent lists to differentiate between numbered headings -->
	<xsl:attribute-set name="list.block.properties">
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="count(ancestor::listitem)">inherit</xsl:when>
				<xsl:otherwise>5mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template match="footnote">
		<xsl:choose>
			<xsl:when test="ancestor::table or ancestor::informaltable">
				<xsl:call-template name="format.footnote.mark">
					<xsl:with-param name="mark">
						<xsl:apply-templates select="." mode="footnote.number"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<fo:footnote>
					<fo:inline>
						<xsl:call-template name="format.footnote.mark">
							<xsl:with-param name="mark">
								<xsl:apply-templates select="." mode="footnote.number"/>
							</xsl:with-param>
						</xsl:call-template>
					</fo:inline>
					<fo:footnote-body xsl:use-attribute-sets="footnote.properties">
						<fo:block margin-top="3mm">
							<xsl:apply-templates/>
						</fo:block>
					</fo:footnote-body>
				</fo:footnote>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="user.pagemasters">

		<fo:simple-page-master master-name="hauptseite"
							   page-width="{$page.width}"
							   page-height="{$page.height}"
							   margin-top="{$page.margin.top}"
							   margin-bottom="{$page.margin.bottom}">
			<!-- starts at 98,4mm from top -->
			<fo:region-body region-name="bodyregion" 
							margin-top="88.46mm" 
							margin-left="25mm" 
							margin-bottom="20mm" 
							margin-right="20mm" /> 
			<fo:region-before region-name="beforeregion" extent="80mm"/>
			<fo:region-after region-name="afterregion" extent="15mm" /> 
			<fo:region-start region-name="startregion" extent="25mm"/>
		</fo:simple-page-master>
		
		<fo:simple-page-master master-name="folgeseite"
							   page-width="{$page.width}"
							   page-height="{$page.height}"
							   margin-top="{$page.margin.top}"
							   margin-bottom="{$page.margin.bottom}" >
			<fo:region-body region-name="bodyregion"
							margin-bottom="{$body.margin.bottom}"
							margin-top="{$body.margin.top}"
							margin-left="25mm"
							margin-right="20mm" />
			<fo:region-before region-name="beforeregion-folgeseite" extent="20mm"/>
			<fo:region-start region-name="startregion" extent="25mm"/>
		</fo:simple-page-master>

		<fo:page-sequence-master master-name="dinbriefB">
			<fo:repeatable-page-master-alternatives>
				<fo:conditional-page-master-reference master-reference="hauptseite"
													  page-position="first"/>
				<fo:conditional-page-master-reference master-reference="folgeseite"
													  page-position="rest"/>
			</fo:repeatable-page-master-alternatives>
		</fo:page-sequence-master>
	</xsl:template>

	<xsl:template match="letter">
		<xsl:message>DIN 5008 Form B.</xsl:message>
		<xsl:call-template name="fop1-document-info"/>
		<fo:page-sequence master-reference="dinbriefB" id="sequence1">
			<fo:static-content flow-name="startregion"> 
				<xsl:if test="$test.drawframes != 0">
					<xsl:call-template name="seitenrahmen"/>
					<xsl:call-template name="fensterrahmen"/>
				</xsl:if>
				<xsl:call-template name="lochmarke"/>
				<xsl:call-template name="faltmarken"/>
			</fo:static-content>

			<fo:static-content flow-name="beforeregion-folgeseite"> 
				<xsl:call-template name="pagenumber"/>
			</fo:static-content>

			<fo:static-content flow-name="beforeregion"> 
				<xsl:call-template name="briefkopf"/>
				<xsl:call-template name="ruecksendeangabe"/>
				<xsl:call-template name="anschriftzone"/>
				<xsl:call-template name="datumetc"/>
			</fo:static-content>

			<fo:static-content flow-name="afterregion"> 
				<xsl:call-template name="pagenumber"/>
				<xsl:call-template name="footerzone"/>
			</fo:static-content>

			<fo:flow flow-name="bodyregion">
				<fo:block text-align="start">
					<fo:inline>
						<xsl:for-each select="letterinfo/subjectterm">
							<xsl:apply-templates/>
						</xsl:for-each>
					</fo:inline>
				</fo:block>
				<fo:block text-align="start"
						  space-after="5mm" 
						  space-before="5mm"> 
					<xsl:for-each select="letterinfo/salutation">
						<xsl:apply-templates/>
					</xsl:for-each>
				</fo:block>

				<xsl:apply-templates/>

				<fo:block page-break-inside="avoid">
					<fo:block space-before.optimum="1em" 
							  margin-bottom="12mm" 
							  space-before="14pt" >
						<xsl:for-each select="letterinfo/closing">
							<xsl:apply-templates/>
						</xsl:for-each>
					</fo:block>
					<fo:block space-before.optimum="1em"
							  margin-bottom="0mm" 
							  margin-top="20mm"
							  margin-left="0" >
						<xsl:for-each select="letterinfo/sender/personname">
							<xsl:apply-templates/>
						</xsl:for-each>
					</fo:block>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>	
	</xsl:template>

	<xsl:template match="letterinfo"/>
	<!-- asciidoctor xml elements to be ignored -->
	<xsl:template match="info"/>
	<xsl:template match="/letter/title"/>

	<xsl:template name="briefkopf">
		<fo:block-container
			border-color="{$test.frame.color}" 
			border-width="{$test.frame.linewidth}"
			border-style="solid" 
			width="165mm"
			height="35mm" top="0" left="0" padding="0mm" position="absolute"
			display-align="center" >
			<fo:table>
				<fo:table-column />
				<fo:table-column />

				<fo:table-body>
					<fo:table-row>
						<fo:table-cell display-align="before">
							<fo:block text-align="start" 
									  font-weight="bold">
								<xsl:value-of select="letterinfo/sender/personname"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<xsl:for-each select="letterinfo/sender/address/*">
								<xsl:choose>
									<xsl:when test="name(.) = 'city'"></xsl:when>
									<xsl:when test="name(.) = 'postcode'">
										<fo:block text-align="end">
											<xsl:value-of select="."/>
											<xsl:value-of select="' '"/>
											<xsl:value-of select="../city"/>
										</fo:block>
									</xsl:when>
									<xsl:when test="name(.) = 'phone'">
										<fo:block text-align="end">
											Telefon: <xsl:value-of select="."/>
										</fo:block>
									</xsl:when>
									<xsl:when test="name(.) = 'fax'">
										<fo:block text-align="end">
											Fax: <xsl:value-of select="."/>
										</fo:block>
									</xsl:when>
									<xsl:when test="name(.) = 'email'">
										<fo:block text-align="end">
											E-Mail: <xsl:value-of select="."/>
										</fo:block>
									</xsl:when>
									<xsl:otherwise>
										<fo:block text-align="end">
											<xsl:apply-templates/>
										</fo:block>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block-container>
	</xsl:template>

	<!-- Zusatz und Vermerkzone 45mm vom oberen Rand -->
	<xsl:template name="ruecksendeangabe">
		<fo:block-container 
			border-color="{$test.frame.color}" 
			border-width="{$test.frame.linewidth}"
			border-style="solid" 
			space-before="0mm"
			position="absolute"
			height="17.7mm" width="80mm" top="35mm"
			display-align="center" >
			<fo:block text-align="start" font-size="8pt"
					  border-color="grey"
					  border-style="solid"
					  border-top-width="0"
					  border-bottom-width="0.3mm"
					  border-left-width="0"
					  border-right-width="0"
					  padding-bottom="1mm" >
				<xsl:value-of select="letterinfo/sender/personname"/>, 
				<xsl:value-of select="letterinfo/sender/address/street"/>, 
				<xsl:value-of select="letterinfo/sender/address/postcode"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="letterinfo/sender/address/city"/>
				<xsl:if test="letterinfo/sender/address/country">, <xsl:value-of 
						select="letterinfo/sender/address/country"/>
				</xsl:if>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- Anschriftzone 45mm + 17,7mm vom oberen Rand -->
	<xsl:template name="anschriftzone">
		<fo:block-container 
			border-color="{$test.frame.color}" 
			border-width="{$test.frame.linewidth}"
			border-style="solid" 
			position="absolute"
			top="52.7mm" height="27.3mm" width="80mm"
			display-align="before" >

			<fo:block  padding-top="1mm" padding-top.minimum="0mm" >
				<xsl:value-of select="letterinfo/recipient/orgname"/> 
			</fo:block>
			<fo:block  padding-top="1mm" padding-top.minimum="0mm" >
				<xsl:value-of select="letterinfo/recipient/personname"/> 
			</fo:block>
			<xsl:for-each select="letterinfo/recipient/address/*">
				<xsl:choose>
					<xsl:when test="name(.) = 'city'"/>
					<xsl:when test="name(.) = 'postcode'">
						<fo:block text-align="start" >
							<xsl:value-of select="."/>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="../city"/>
						</fo:block>
					</xsl:when>
					<xsl:otherwise>
						<fo:block text-align="start" >
							<xsl:apply-templates/>
						</fo:block>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</fo:block-container>
	</xsl:template>
        
	<xsl:template name="datumetc">
		<fo:block-container 
			border-color="{$test.frame.color}" 
			border-width="{$test.frame.linewidth}"
			border-style="solid" 
			position="absolute"
			top="40mm" left="100mm" height="40mm" width="65mm">
			<fo:block text-align="start">
				<xsl:value-of select="letterinfo/date"/> 
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<xsl:template name="pagenumber">
		<fo:block margin-right="20mm" text-align="end">
			<fo:inline>
				Seite <fo:page-number/> von <fo:page-number-citation-last ref-id="sequence1"/>
			</fo:inline>
		</fo:block>
	</xsl:template>

	<xsl:template name="footerzone">
		<fo:block text-align="center" margin-top="5mm">
			<xsl:for-each select="letterinfo/sender/footer-info/*">
				<xsl:apply-templates/>
			</xsl:for-each>
		</fo:block>
	</xsl:template>

	<!-- Seitenrahmen mit 10mm Rand -->
	<xsl:template name="seitenrahmen">
		<fo:block-container position="absolute"
							top="0" 
							left="10mm"
							height="277mm"
							width="190mm"
							border-color="red"
							border-style="solid"
							border-width="0.5mm">
			<fo:block />
		</fo:block-container>
	</xsl:template>

	<!-- Sichtfenster 45mm hoch, Unterkante 15mm oberhalb Faltmarke1 -->
	<xsl:template name="fensterrahmen">
		<fo:block-container position="absolute"
							top="35mm" 
							left="20mm"
							height="45mm"
							width="90mm"
							border-color="red"
							border-style="solid"
							border-width="0.5mm">
			<fo:block />
		</fo:block-container>
	</xsl:template>

	<!-- 148.5mm vom oberen Rand -->
	<xsl:template name="lochmarke">
		<fo:block-container position="absolute"
							top="138.5mm"
							left="6mm"
							height="0"
							width="7mm"
							border-color="gray"
							border-style="solid"
							border-top-width="0.3mm"
							border-bottom-width="0"
							border-left-width="0"
							border-right-width="0">
			<fo:block />
		</fo:block-container>
	</xsl:template>

	<!-- 105mm vom oberen Rand + 105mm von 1. Marke -->
	<xsl:template name="faltmarken">
		<fo:block-container position="absolute"
							top="95mm"
							left="6mm"
							height="105mm"
							width="4mm"
							border-color="gray"
							border-style="solid"
							border-top-width="0.3mm"
							border-bottom-width="0.3mm"
							border-left-width="0"
							border-right-width="0">
			<fo:block />
		</fo:block-container>
	</xsl:template>


	<!-- Metadata support ("Document Properties" in Adobe Reader) TODO -->
	<xsl:template name="fop1-document-info">

		<xsl:variable name="authors" select="(//author|//editor|//corpauthor|//authorgroup)[1]"/>
		<xsl:variable name="title">DIN Brief Form B</xsl:variable>

		<fo:declarations>
			<x:xmpmeta xmlns:x="adobe:ns:meta/">
				<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
					<rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
						<!-- Dublin Core properties go here -->

						<!-- Title -->
						<dc:title>
							<xsl:value-of select="normalize-space($title)"/>
						</dc:title>

						<!-- Author -->
						<xsl:if test="$authors">
							<xsl:variable name="author">

								<xsl:choose>
									<xsl:when test="$authors[self::authorgroup]">
										<xsl:call-template name="person.name.list">
											<xsl:with-param name="person.list"
															select="$authors/*[self::author|self::corpauthor|self::othercredit|self::editor]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="$authors[self::corpauthor]">
										<xsl:value-of select="$authors"/>
									</xsl:when>
									<xsl:when test="$authors[orgname]">
										<xsl:value-of select="$authors/orgname"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="person.name">
											<xsl:with-param name="node" select="$authors"/>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>

							<dc:creator>
								<xsl:value-of select="normalize-space($author)"/>
							</dc:creator>
						</xsl:if>

						<!-- Subject -->
						<xsl:if test="//subjectterm">
							<dc:description>
								<xsl:for-each select="//subjectterm">
									<xsl:value-of select="normalize-space(.)"/>
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</dc:description>
						</xsl:if>
					</rdf:Description>

					<rdf:Description rdf:about="" xmlns:pdf="http://ns.adobe.com/pdf/1.3/">
						<!-- PDF properties go here -->

						<!-- Keywords -->
						<xsl:if test="//keyword">
							<pdf:Keywords>
								<xsl:for-each select="//keyword">
									<xsl:value-of select="normalize-space(.)"/>
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</pdf:Keywords>
						</xsl:if>
					</rdf:Description>

					<rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
						<!-- XMP properties go here -->
						<!-- Creator Tool -->
						<xmp:CreatorTool>DocBook XSL Stylesheets with Apache FOP</xmp:CreatorTool>
					</rdf:Description>
				</rdf:RDF>
			</x:xmpmeta>
		</fo:declarations>
	</xsl:template>
</xsl:stylesheet>
