<?xml version="1.0" encoding="UTF-8"?>

<!--
	Document   : xforms-2-xaml.xsl
	Created on : 29. dubna 2016, 0:50
	Author     : Marek Cepcek, Riva Nathans Kepych, Jakub Horniak, Lucia Sittova
	Description:
		Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                version="2.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

	<!-- XForms namespace uri-->
	<xsl:variable name="xf-namespace-uri">http://www.w3.org/2002/xforms</xsl:variable>
	<!-- XAML namespace uri-->
	<xsl:variable name="xaml-namespace-uri">http://schemas.microsoft.com/winfx/2006/xaml/presentation</xsl:variable>

	<xsl:template match="/">
		<!-- x:Class="Resources.MainWindow" keeping this here just in case. -->
		<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
                        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
                        xmlns:local="clr-namespace:XAML_loader"
                        mc:Ignorable="d"
                        Title="MainWindow" Height="400" Width="600">
			<Border Padding="10">
			<WrapPanel Orientation="Vertical">
				
				<!-- select form elements using namespace and element names-->
				<xsl:apply-templates select="//*[namespace-uri()=$xf-namespace-uri
                                                            and (local-name()='input'
                                                            or local-name()='textarea'
                                                            or local-name()='secret'
                                                            or local-name()='trigger'
                                                            or local-name()='select'
                                                            or local-name()='select1'
                                                            or local-name()='output')]"/>
				
			</WrapPanel>
			</Border>
		</Window>
	</xsl:template>

	<!-- templates to apply to form elements: should determine what
	type the element is and transform it to its equivalent in XAML -->

	<!-- template for label element used within other templates-->
	<xsl:template match="//*[local-name()='label' and namespace-uri()=$xf-namespace-uri]">
		<xsl:element name="Label" namespace="{$xaml-namespace-uri}">
			<xsl:attribute name="Content">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- template for input element -->
	<xsl:template match="//*[local-name()='input' and namespace-uri()=$xf-namespace-uri]">

            <!--without the namespace attr. the output element has an xmlns="" attr.
            which would cause an exception loading it in the xaml loader. -->
		<xsl:apply-templates select="./*[local-name()='label' and namespace-uri()=$xf-namespace-uri]"/>
		<xsl:variable name="ref" select="./@ref"/>
		<xsl:variable name="bind" select="./@bind"/>
		<xsl:variable name="bindType" select="//*[local-name()='bind' 
                                          and namespace-uri()=$xf-namespace-uri 
                                          and (@nodeset = $ref or  (@ref = $ref or @id = $bind))]/@type"/>
		<xsl:choose>
			<!-- create date picker xaml element -->
			<xsl:when test="ends-with($bindType, 'date')">
				<xsl:element name="Calendar" namespace="{$xaml-namespace-uri}">
					<!-- test if there is a nonempty ref or bind attr in the xforms input element 
					generating an empty name attr would cause an exception loading it in the xaml loader -->
					<xsl:choose>
						<xsl:when test="boolean(@ref) and (@ref != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@ref"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="boolean(@bind) and (@bind != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@bind"/>
							</xsl:attribute>
						</xsl:when>
					</xsl:choose>
					<xsl:attribute name="SelectionMode">
						SingleDate
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<!-- create checkbox xaml element -->
			<xsl:when test="ends-with($bindType, 'boolean')">
				<xsl:element name="CheckBox" namespace="{$xaml-namespace-uri}">
					<!-- test if there is a nonempty ref or bind attr in the xforms input element 
						generating an empty name attr would cause an exception loading it in the xaml loader -->
					<xsl:choose>					
						<xsl:when test="boolean(@ref) and (@ref != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@ref"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="boolean(@bind) and (@bind != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@bind"/>
							</xsl:attribute>
						</xsl:when>
					</xsl:choose>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<!-- create textbox xaml element -->
				<xsl:element name="TextBox" namespace="{$xaml-namespace-uri}">
					<xsl:choose>
						<!-- test if there is a nonempty ref or bind attr in the xforms input element 
						generating an empty name attr would cause an exception loading it in the xaml loader -->
						<xsl:when test="boolean(@ref) and (@ref != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@ref"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:when test="boolean(@bind) and (@bind != '')">
							<xsl:attribute name="x:Name">
								<xsl:value-of select="./@bind"/>
							</xsl:attribute>
						</xsl:when>
					</xsl:choose>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="//*[local-name()='output' and namespace-uri()=$xf-namespace-uri]">
		<xsl:if test="boolean(@value)">
			<xsl:element name="TextBlock" namespace="{$xaml-namespace-uri}">
			<!-- Value of the output element is determined programmatically in xforms but that can't be achieved with pure xaml.
			A comment containing text of the original expression is generated instead. -->
				<xsl:comment>Content of this control should be generated in code behind. Hint: <xsl:value-of select="./@value"/></xsl:comment>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="//*[local-name()='textarea' and namespace-uri()=$xf-namespace-uri]">            
		<xsl:apply-templates select="./*[local-name()='label' and namespace-uri()=$xf-namespace-uri]"/>
		<!--without the namespace attr. the output element has an xmlns="" attr.
            which would cause an exception loading it in the xaml loader. -->
		<xsl:element name="TextBox" namespace="{$xaml-namespace-uri}">
			<!-- test if there is a nonempty ref attr in the xforms input element
			 empty name attr. would cause an exception loading it in the xaml loader -->
			<xsl:if test="boolean(@ref) and (@ref != '')">
				<xsl:attribute name="x:Name">
					<xsl:value-of select="./@ref"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="AcceptsReturn">True</xsl:attribute>
			<xsl:attribute name="TextWrapping">Wrap</xsl:attribute>
			<xsl:attribute name="MinHeight">100</xsl:attribute>
			<xsl:attribute name="MinWidth">200</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- template for secret element -->
	<xsl:template match="//*[local-name()='secret' and namespace-uri()=$xf-namespace-uri]">		
		<xsl:apply-templates select="./*[local-name()='label' and namespace-uri()=$xf-namespace-uri]"/>
		<!--without the namespace attr. the output element has an xmlns="" attr.
        which would cause an exception loading it in the xaml loader. -->
		<xsl:element name="PasswordBox" namespace="{$xaml-namespace-uri}">
			<!-- test if there is a nonempty ref attr in the xforms input element
			 empty name attr. would cause an exception loading it in the xaml loader -->
			<xsl:if test="boolean(@ref) and (@ref != '')">
				<xsl:attribute name="x:Name">
					<xsl:value-of select="./@ref"/>
				</xsl:attribute>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<!-- template for trigger element -->
	<xsl:template match="//*[local-name()='trigger' and namespace-uri()=$xf-namespace-uri]">
		<!--without the namespace attr. the output element has an xmlns="" attr.
        which would cause an exception loading it in the xaml loader. -->
		<xsl:element name="Button" namespace="{$xaml-namespace-uri}">
			<xsl:attribute name="Content">
				<xsl:value-of select="./*[local-name()='label']"/>
			</xsl:attribute>
			<!-- test if there is a nonempty ref attr in the xforms input element
			 empty name attr. would cause an exception loading it in the xaml loader -->
			<xsl:if test="boolean(@ref) and (@ref != '')">
				<xsl:attribute name="x:Name">
					<xsl:value-of select="./@ref"/>
				</xsl:attribute>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<!-- template for select element -->
	<xsl:template match="//*[local-name()='select' and namespace-uri()=$xf-namespace-uri]">
		<xsl:apply-templates select="./*[local-name()='label' and namespace-uri()=$xf-namespace-uri]"/>
		<xsl:choose>
		<!-- if appearance of the input xf:select is 'full' transform it into multiple checkboxes -->
			<xsl:when test="./@appearance = 'full'">
				<xsl:apply-templates select="./*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="checkbox"/>
			</xsl:when>
			<!-- otherwise transform it into a ListBox control -->
			<xsl:otherwise>
				<xsl:element name="ListBox" namespace="{$xaml-namespace-uri}">
					<xsl:attribute name="SelectionMode">Multiple</xsl:attribute>
					<!-- test if there is a nonempty ref attr in the xforms input element
					 empty name attr. would cause an exception loading it in the xaml loader -->
					<xsl:if test="boolean(@ref) and (@ref != '')">
						<xsl:attribute name="x:Name">
							<xsl:value-of select="./@ref"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="./*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="list"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- template for select1 element -->
	<xsl:template match="//*[local-name()='select1' and namespace-uri()=$xf-namespace-uri]">
		<xsl:apply-templates select="./*[local-name()='label' and namespace-uri()=$xf-namespace-uri]"/>
		<xsl:choose>
		<!-- if appearance of the input xf:select1 is 'full' transform it into radio button group -->
			<xsl:when test="./@appearance = 'full'">
				<xsl:apply-templates select="./*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="radio">
					<xsl:with-param name="group" select="./@ref" />
				</xsl:apply-templates>
			</xsl:when>
			<!-- if appearance of the input xf:select1 is 'compact'
			transform it into a Listbox control with multiple selections -->
			<xsl:when test="./@appearance = 'compact'">
				<xsl:element name="ListBox" namespace="{$xaml-namespace-uri}">
					<!-- test if there is a nonempty ref attr in the xforms input element
					empty name attr. would cause an exception loading it in the xaml loader -->
					<xsl:if test="boolean(@ref) and (@ref != '')">
						<xsl:attribute name="x:Name">
							<xsl:value-of select="./@ref"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="./*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="list"/>
				</xsl:element>
			</xsl:when>
			<!-- otherwise transform it into a ComboBox control (@appearence='minimal') -->
			<xsl:otherwise>
				<xsl:element name="ComboBox" namespace="{$xaml-namespace-uri}">
					<!-- test if there is a nonempty ref attr in the xforms input element
					 empty name attr. would cause an exception loading it in the xaml loader -->
					<xsl:if test="boolean(@ref) and (@ref != '')">
						<xsl:attribute name="x:Name">
							<xsl:value-of select="./@ref"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="SelectedIndex">0</xsl:attribute>
					<xsl:apply-templates select="./*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="combo"/>					
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- templates for a selection item (both select and select1) -->

	<!-- template for item as a CheckBox control -->
	<xsl:template match="//*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="checkbox">
		<xsl:element name="CheckBox" namespace="{$xaml-namespace-uri}">
			<xsl:value-of select="./*[local-name()='label']"/>
		</xsl:element>
	</xsl:template>

	<!-- template for item in a ListBox control -->
	<xsl:template match="//*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="list">
		<xsl:element name="TextBlock" namespace="{$xaml-namespace-uri}">
			<xsl:value-of select="./*[local-name()='label']"/>
		</xsl:element>
	</xsl:template>

	<!-- template for item in a ComboBox control -->
	<xsl:template match="//*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="combo">
		<xsl:element name="ComboBoxItem" namespace="{$xaml-namespace-uri}">
			<xsl:value-of select="./*[local-name()='label']"/>
		</xsl:element>
	</xsl:template>

	<!-- template for item as a RadioButton control -->
	<xsl:template match="//*[local-name()='item' and namespace-uri()=$xf-namespace-uri]" mode="radio">
		<xsl:param name="group" />
		<xsl:element name="RadioButton" namespace="{$xaml-namespace-uri}">
			<xsl:attribute name="GroupName">
				<xsl:value-of select="$group"/>
			</xsl:attribute>
			<xsl:value-of select="./*[local-name()='label']"/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
