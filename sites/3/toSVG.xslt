<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" media-type="image/svg"
		doctype-public="-//W3C//DTD SVG 1.1//EN" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11-basic.dtd" />
    <xsl:template match="Music">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%" style="background-color:#71afde">

            <text font-size="35" fill="#ffa561">

                Average price of pieces

            <animateMotion path="M 600 100 L 1100 100 L 600 100" dur="6s" repeatCount="indefinite"/>
            </text>


            <text onmouseover="big(evt)" onmouseout="small(evt)" x="30" y="60" font-family="Georgia" font-size="35" fill="#0c2538">
                Music summary
            </text>
			
			
           <xsl:for-each select="Statistics/Statistic[6]">
			<xsl:variable name="avgEURpieceDesc" select="name"/>
			<xsl:variable name="avgEURpiece" select="value"/>
			 <xsl:variable name="order" select="(position()-1) * 70"/>
			 <xsl:variable name="amount" select="count(../../Composer/Pieces/Piece/price[@cur='EUR'])"/>
			 
			 
			 <rect onclick="changeColor(evt)" x="{$order + 450}" y="{300-$avgEURpiece}" height="220" width="30" fill="#65bf80" stroke="#1c4a2a" stroke-width="2">
                    <animate attributeType="XML" attributeName="height" from="0" to="{$avgEURpiece + 100}"
                             dur="2s" fill="freeze"/>
                </rect>
                <text onclick="alert('There are {$amount} pieces in EUR')" writing-mode="tb-rl" x="{$order + 465}" y="180" font-family="Times New Roman" font-size="20" fill="#111111">
				<xsl:value-of select="$avgEURpiece"/>
				<xsl:text> EUR</xsl:text>
                   
                </text>
			</xsl:for-each>
			
			<xsl:for-each select="Statistics/Statistic[7]">
            
			<xsl:variable name="avgEURpieceDesc" select="name"/>
			<xsl:variable name="avgEURpiece" select="value"/>
			 <xsl:variable name="order" select="(position()-1) * 70"/>
			 <xsl:variable name="amount" select="count(../../Composer/Pieces/Piece/price[@cur='PLN'])"/>
			 
			 
			 <rect onclick="changeColor(evt)" x="{$order + 650}" y="{300-$avgEURpiece}" height="220" width="30" fill="#65bf80" stroke="#1c4a2a" stroke-width="2">
                    <animate attributeType="XML" attributeName="height" from="0" to="{$avgEURpiece + 100}"
                             dur="2s" fill="freeze"/>
                </rect>
                <text onclick="alert('There are {$amount} pieces in PLN')" writing-mode="tb-rl" x="{$order + 665}" y="180" font-family="Times New Roman" font-size="20" fill="#111111">
				<xsl:value-of select="$avgEURpiece"/>
				<xsl:text> PLN</xsl:text>
                   
                </text>
			 
			 
			</xsl:for-each>
			<xsl:for-each select="Statistics/Statistic[8]">
			<xsl:variable name="avgEURpieceDesc" select="name"/>
			<xsl:variable name="avgEURpiece" select="value"/>
			 <xsl:variable name="order" select="(position()-1) * 70"/>
			 <xsl:variable name="amount" select="count(../../Composer/Pieces/Piece/price[@cur='USD'])"/>
			 
			 
			 <rect onclick="changeColor(evt)" x="{$order + 850}" y="{300-$avgEURpiece}" height="220" width="30" fill="#65bf80" stroke="#1c4a2a" stroke-width="2">
                    <animate attributeType="XML" attributeName="height" from="0" to="{$avgEURpiece + 100}"
                             dur="2s" fill="freeze"/>
                </rect>
                <text onclick="alert('There are {$amount} pieces in USD')" writing-mode="tb-rl" x="{$order + 865}" y="180" font-family="Times New Roman" font-size="20" fill="#111111">
				<xsl:value-of select="$avgEURpiece"/>
				<xsl:text> USD</xsl:text>
                   
                </text>
			 
			 
			</xsl:for-each>
			

            <script type="text/ecmascript"> <![CDATA[
		    function big(evt) {
		    	var text = evt.target;
		    	text.setAttribute("font-size", 45);
	    	}
	        ]]> </script>

            <script type="text/ecmascript"> <![CDATA[
	    	function small(evt) {
                var text = evt.target;
                text.setAttribute("font-size", 35);
	    	}
	        ]]> </script>

            <script type="text/ecmascript"> <![CDATA[
            function changeColor(evt) {
                var rect = evt.target;
                var Fill = rect.getAttribute("fill");
                if (Fill=="#65bf80")
                    rect.setAttribute("fill", "#be65bf");
                if (Fill=="#be65bf")
                    rect.setAttribute("fill", "#e6d77a");
                if (Fill=="#e6d77a")
                    rect.setAttribute("fill", "#65bf80");
            }
            ]]> </script>

        </svg>

    </xsl:template>

</xsl:stylesheet>