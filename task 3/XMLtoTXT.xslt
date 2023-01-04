<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:text>Malgorzata Komorowska xslt to txt&#xA;</xsl:text>
        <xsl:for-each select="Music/Composer/composer">
		<xsl:value-of select="substring(concat(@first_name,''),1,45)"/>
		<xsl:value-of select="'&#x20;'"/>
			<xsl:value-of select="substring(concat(@surname,''),1,15)"/>
		<xsl:value-of select="'&#13;'"/>
		<xsl:text>&#xA;Pieces&#xA;</xsl:text>
		<xsl:text>Title:                        Tonation:      level:         Name of publisher:       Price:   Currency: Price netto: Currency:&#xA;</xsl:text>
        <xsl:for-each select="../Pieces/Piece">
			<xsl:value-of select="substring(concat(.,''),1,0)"/>
			<xsl:value-of select="substring(concat(name,'                              '),1,30)"/>
			<xsl:value-of select="substring(concat(tonation,'               '),1,15)"/>
			<xsl:value-of select="substring(concat(level,'                 '),1,15)"/>
			<xsl:value-of select="substring(concat(publisherName,'                   '),1,25)"/>
			<xsl:value-of select="substring(concat(price,'         '),1,10)"/>
			<xsl:value-of select="substring(concat(price/@cur,'          '),1,10)"/>
			<xsl:value-of select="substring(concat(nettoPrice,'             '),1,15)"/>
			<xsl:value-of select="substring(concat(nettoPrice/@cur,'          '),1,10)"/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#xA;Books&#xA;</xsl:text>
		<xsl:text>Title:                        Amount of pages:    ISBN:                         Name of publisher:       Price:   Currency: Price netto: Currency:&#xA;</xsl:text>
        <xsl:for-each select="../Books/Book">
			<xsl:value-of select="substring(concat(.,''),1,0)"/>
			<xsl:value-of select="substring(concat(content,'                              '),1,30)"/>
			<xsl:value-of select="substring(concat(amount_of_pages,'                  '),1,20)"/>
			<xsl:value-of select="substring(concat(ISBN,'                              '),1,30)"/>
			<xsl:value-of select="substring(concat(publisherName,'                         '),1,25)"/>
			<xsl:value-of select="substring(concat(price,'         '),1,10)"/>
			<xsl:value-of select="substring(concat(price/@cur,'          '),1,10)"/>
			<xsl:value-of select="substring(concat(nettoPrice,'             '),1,15)"/>
			<xsl:value-of select="substring(concat(nettoPrice/@cur,'          '),1,10)"/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		
		
		<xsl:text>&#xA;</xsl:text>
		<xsl:text>&#xA;Publishers&#xA;</xsl:text>
		<xsl:text>Name:                        &#xA;</xsl:text>
        <xsl:for-each select="Music/Publisher">
			<xsl:value-of select="substring(concat(.,''),1,0)"/>
			<xsl:value-of select="substring(concat(namePublisher,'                              '),1,30)"/>

			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		
		
		<xsl:text>&#xA;</xsl:text>
		<xsl:text>&#xA;Statistics&#xA;</xsl:text>
		<xsl:text>Name: 			                      			                 Value: 		     &#xA;</xsl:text>
        
		<xsl:for-each select="Music/Statistics/Statistic">
			<xsl:value-of select="substring(concat(.,''),1,0)"/>
			<xsl:value-of select="substring(concat(name,'                                                                   '),1,65)"/>
			<xsl:value-of select="substring(concat(value,'       		     '),1,25)"/>

			<xsl:text>&#xA;</xsl:text>
			</xsl:for-each>
		
		
		
    </xsl:template>
	
</xsl:stylesheet>
