<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	
	<xsl:key name="publisherid" match="/composers/publisher" use="@id" />
	
	<xsl:template match="/composers">
		<Music>
			<xsl:apply-templates select="/composers/composer"/>				
			<xsl:apply-templates select="/composers/publisher"/>
			<xsl:call-template name="Statistics"></xsl:call-template>
		</Music>
	</xsl:template>
	
	
	<xsl:template match="/composers/composer">
		<Composer>
			<composer first_name="{first_name}" surname="{surname}"/>
			<xsl:for-each select="pieces">
				<Pieces>
					<xsl:for-each select="piece">
					<xsl:sort select="name"/>
						<!--<xsl:variable name="nr" select="publisher/@nr"/> -->
						<Piece>							
							<xsl:copy-of select="name"/>
							<xsl:copy-of select="tonation"/>
							<xsl:if test="op">
								<xsl:element name="op">
									<xsl:value-of select="op"/>
								</xsl:element>
							</xsl:if>
							<xsl:if test="nr">
								<xsl:element name="nr">
									<xsl:value-of select="nr"/>
								</xsl:element>
							</xsl:if>
							<xsl:copy-of select="level"/>
							
							<xsl:for-each select="publisher">
								<xsl:element name="publisherName">
								<xsl:value-of select="key('publisherid', @nr)" />	
									<!-- <xsl:value-of select="../../../../../composers/publisher/namePublisher[../@id=$nr]"/> -->
								</xsl:element>
								<xsl:copy-of select="price"/>
								<xsl:element name="nettoPrice">
									<xsl:attribute name="cur">
										<xsl:value-of select="price/@cur"/>
									</xsl:attribute>
									<xsl:value-of select="format-number(price/. div 1.23, '#.00')"></xsl:value-of>
								</xsl:element>
							</xsl:for-each>
						</Piece>
					</xsl:for-each>
				</Pieces>
			</xsl:for-each>
			<xsl:for-each select="books">
				<Books>
					<xsl:for-each select="book">
					<xsl:sort select="content"/>
						<!-- <xsl:variable name="nr" select="publisher/@nr"/> -->
						<Book>
							<xsl:copy-of select="content"/>
							<xsl:copy-of select="amount_of_pages"/>
							<xsl:copy-of select="ISBN"/>
							<xsl:for-each select="publisher">		
							<xsl:element name="publisherName">
								<xsl:value-of select="key('publisherid', @nr)" />	
									<!-- <xsl:value-of select="../../../../../composers/publisher/namePublisher[../@id=$nr]"/> -->
								</xsl:element>
								<xsl:copy-of select="price"/>
								<xsl:element name="nettoPrice">
									<xsl:attribute name="cur">
										<xsl:value-of select="price/@cur"/>
									</xsl:attribute>
									<xsl:value-of select="format-number(price/. div 1.23, '#.00')"></xsl:value-of>
								</xsl:element>
							</xsl:for-each>
						</Book>
					</xsl:for-each>
				</Books>
			</xsl:for-each>
		</Composer>
	</xsl:template>			
	
	
	
	<xsl:template match="/composers/publisher">
		
		<Publisher>
			<!--to coś sprawia, że pojawia się np. publisher 1 namePublisher PWM
								<xsl:value-of select="key('publisher', @id)/@id" />
			--><xsl:copy-of select="namePublisher"/>
		</Publisher>
		
	</xsl:template>
	<!--to jest źle-->
	<!--	<xsl:variable name="least" select="math:min(/composers/pieces/piece/publisher/price[@cur = 'EUR'])"/>
	-->
	
	<xsl:template name="Statistics">
		<Statistics>
		<Statistic>
			<xsl:element name="name">Date of generation</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-date(current-date(),'[M01]/[D01]/[Y0001]')"></xsl:value-of>
			</xsl:element>
			</Statistic>
			<Statistic>
			<xsl:element name="name">Amount of pieces</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="count(/composers/composer/pieces/piece)"></xsl:value-of>
			</xsl:element>
			</Statistic>

<Statistic>
			<xsl:element name="name">The sum of prices of pieces which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="sum(/composers/composer/pieces/piece/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The sum of prices of pieces which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="sum(/composers/composer/pieces/piece/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The sum of prices of pieces which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="sum(/composers/composer/pieces/piece/publisher/price[@cur='USD'])"></xsl:value-of>
			</xsl:element></Statistic>
			
			<Statistic>
			<xsl:element name="name">The average price of pieces which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(avg(/composers/composer/pieces/piece/publisher/price[@cur='EUR']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
				<xsl:element name="name">The average price of pieces which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="avg(/composers/composer/pieces/piece/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The average price of pieces which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(avg(/composers/composer/pieces/piece/publisher/price[@cur='USD']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>
			
			<Statistic>
			<xsl:element name="name">The lowest price of piece which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/pieces/piece/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The lowest price of piece which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/pieces/piece/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The lowest price of piece which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/pieces/piece/publisher/price[@cur='USD'])"></xsl:value-of>
			</xsl:element></Statistic>

<Statistic>
			<xsl:element name="name">The highest price of piece which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/pieces/piece/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic><xsl:element name="name">The highest price of piece which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/pieces/piece/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The highest price of piece which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/pieces/piece/publisher/price[@cur='USD'])"></xsl:value-of>
			</xsl:element></Statistic>
			
			<Statistic>
			<xsl:element name="name">Price of the last piece of each composer in original data set</xsl:element>
					<xsl:element name="value">
						<xsl:value-of select="/composers/composer/pieces/piece[position() = last()]/publisher/price"></xsl:value-of>
					</xsl:element></Statistic>
			
			<Statistic>
			<xsl:element name="name">Amount of books</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="count(/composers/composer/books/book)"></xsl:value-of>
			</xsl:element></Statistic>

<Statistic>
			<xsl:element name="name">The sum of prices of books which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="sum(/composers/composer/books/book/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The sum of prices of books which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(sum(/composers/composer/books/book/publisher/price[@cur='PLN']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The sum of prices of books which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(sum(/composers/composer/books/book/publisher/price[@cur='PLN']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>

			
			<Statistic>
			<xsl:element name="name">The average price of books which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(avg(/composers/composer/books/book/publisher/price[@cur='EUR']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
				<xsl:element name="name">The average price of books which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="avg(/composers/composer/books/book/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The average price of books which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="format-number(avg(/composers/composer/books/book/publisher/price[@cur='USD']), '#.00')"></xsl:value-of>
			</xsl:element></Statistic>
			
			<Statistic>
			<xsl:element name="name">The lowest price of book which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/books/book/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The lowest price of book which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/books/book/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The lowest price of book which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="min(/composers/composer/books/book/publisher/price[@cur='USD'])"></xsl:value-of>
			</xsl:element></Statistic>

<Statistic>
			<xsl:element name="name">The highest price of book which are in EUR</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/books/book/publisher/price[@cur='EUR'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic><xsl:element name="name">The highest price of book which are in PLN</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/books/book/publisher/price[@cur='PLN'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			<xsl:element name="name">The highest price of book which are in USD</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="max(/composers/composer/books/book/publisher/price[@cur='USD'])"></xsl:value-of>
			</xsl:element></Statistic>
			<Statistic>
			
			<xsl:element name="name">Price of the last book of each composer in original data set</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="/composers/composer/books/book[position() = last()]/publisher/price"></xsl:value-of>
			</xsl:element></Statistic>

<Statistic>
			<xsl:element name="name">Amount of publishers</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="count(/composers/publisher)"></xsl:value-of>
			</xsl:element></Statistic>

		</Statistics>
	</xsl:template>
</xsl:stylesheet>
