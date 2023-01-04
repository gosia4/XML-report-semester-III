<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Music</title>
                <style type="text/css">
                    body {
                    background-image: url("christmas.png");
                    background-color: #cccccc;
                    }
                    
                    table {
                    font-family: 'Century Gothic';
                    border-collapse: collapse;
                    text-align: center;
                    padding: 10px;                       
                    background-color: rgba(232, 240, 255, 0.5);
                    }
                    
                    table.center {
                    margin-left:auto; 
                    margin-right:auto;
                    }
                    
                    tr#r01, tr#r02{
                    background-color: #d1e1ff;
                    }					
                    
                    table, th, td {
                    border: 1px solid #003293;
                    text-align: center;
                    padding: 10px;
                    }
                    
                    h1{
                    font-family: Helvetica;
                    color: #003293; 
                    font-size: 40px;
                    text-align: center;
                    }
                    
                    h2{
                    font-family: Helvetica;
                    color: #002670;
                    font-size: 12pt;
                    text-align: left;
                    margin-left: 2%;
                    }
                    h3{
                    font-family: Helvetica;
                    color: #003293; 
                    font-size: 20pt;
                    text-align: center;
                    }
					h4{
                    font-family: Helvetica;
                    color: #000000; 
                    font-size: 12pt;
                    text-align: left;
                    }
                    
                </style>
            </head>
            <body>
            <p><img src="index.jpg" alt="There is an image with a christmas tree, because we have Christmas soon."></img></p>
             <h4>There is a music shop whera are pieces, which are seperately and combined in books. Each piece and book are created by one publisher.</h4>
               
                <h1>Music shop</h1>
                <h2>Małgorzata Komorowska</h2>
                <xsl:apply-templates select="Music/Composer"/>
				<h3>List of publishers</h3>
                <xsl:apply-templates select="Music/Publisher"/>
                <xsl:apply-templates select="Music/Statistics"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="Music/Composer">
        <xsl:for-each select="composer">
  
                    <h3><xsl:value-of select="@first_name"/>&#160;
                    <xsl:value-of select="@surname"/></h3>
            
        
        <table style="text-align: center" class="center">
            <tr>
                <th>Title</th>
                <th>Tonation</th>
                <th>Op</th>
                <th>No</th>
                <th>Level</th>
                <th>Name of publisher</th>
                <th>Price</th>
                <th>Netto price</th>
            </tr>
            <xsl:for-each select="../Pieces/Piece">
                <tr>
                    <td>
                        <xsl:value-of select="name"/>
                    </td>
                    <td>
                        <xsl:value-of select="tonation"/>
                        
                    </td>
                    <td>
                        <xsl:value-of select="op"/>
                    </td>
                    <td>
                        <xsl:value-of select="nr"/>
                    </td>
                    <td>
                        <xsl:value-of select="level"/>
                    </td>
                    <td>
                        <xsl:value-of select="publisherName"/>
                    </td>
                    <td>
                        <xsl:value-of select="price"/>
                    </td>
                    <td>
                        <xsl:value-of select="nettoPrice"/>
                        
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <table style="text-align: center" class="center">
            <tr>
                <th>Title</th>
                <th>Amount of pages</th>
                <th>ISBN</th>
                <th>Name of publisher</th>
                <th>Price</th>
                <th>Netto price</th>
            </tr>
            <xsl:for-each select="../Books/Book">
                <tr>
                    <td>
                        <xsl:value-of select="content"/>
                    </td>
                    <td>
                        <xsl:value-of select="amount_of_pages"/>
                        
                    </td>
                    <td>
                        <xsl:value-of select="ISBN"/>
                    </td>
                    <td>
                        <xsl:value-of select="publisherName"/>
                    </td>
                    <td>
                        <xsl:value-of select="price"/>
                    </td>
                    <td>
                        <xsl:value-of select="nettoPrice"/>
                        
                    </td>
                </tr>
            </xsl:for-each>
            
        </table>
</xsl:for-each>
		</xsl:template>
<xsl:template match="Music/Publisher">
        
    
        <table style="text-align: center" class="center">
            <tr>
                <th>Name of publisher</th>
                
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="namePublisher"/>
                </td>
            </tr>
        </table>
    </xsl:template>


<xsl:template match="Music/Statistics">
        <table style="text-align: center" class="center">
            <caption>
                <b>
                    <br/>Statistics</b>
            </caption>
            <tr>
            <th>Statistic name</th>
        	<th>Statistic value</th>
            </tr>
            <xsl:for-each select="Statistic">
                
            <tr style="text-align:left">
                <td style="font-weight:bold"> <xsl:value-of select="name" /></td>
                <td>
                        <xsl:value-of select="value" />
                </td>
                
            </tr>
            
            </xsl:for-each>

        </table>
    </xsl:template>
</xsl:stylesheet>

