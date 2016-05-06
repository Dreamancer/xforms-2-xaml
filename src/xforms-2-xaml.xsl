<?xml version="1.0" encoding="UTF-8"?>

<!--
	Document   : xforms-2-xaml.xsl
	Created on : 29. dubna 2016, 0:50
	Author     : Marek Cepcek, Riva Nathans Kepych, add your name here
	Description:
		Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes" />

	<xsl:template match="/">
		<Window x:Class="Resources.MainWindow" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="MainWindow" Height="400" Width="600"> 

			<Grid> 
				<!-- examples of how to make form elements in XAML: delete later -->

				<!-- XAML: example button -->
				<Button x:Name="button_name" Content="button"/>

				<!-- XAML: example checkbox -->
				<CheckBox x:Name="checkbox_name" Content="checkbox"/>

				<!-- XAML: example date -->
				<Calendar x:Name="calendar_name" SelectionMode="MultipleRange"/>  

				<!-- XAML: example password -->
				<PasswordBox x:Name="password_name"/>

				<!-- XAML: example textbox -->
				<TextBox x:Name="textbox_name"/>

				<!-- XAML: example read-only text -->
				<TextBlock>some read-only text</TextBlock>

				<!-- actual project code here -->

				<!-- select form elements using namespace -->
				<xsl:apply-templates select="//*[namespace-uri()="http://www.w3.org/2002/xforms"]"/>
			</Grid> 

		</Window>
	</xsl:template>

	<!-- template to apply to form elements: should determine what
	type the element is and transform it to its equivalent in XAML -->
	<xsl:template match="//*[namespace-uri()="http://www.w3.org/2002/xforms"]">

		<!-- process element here -->

	</xsl:template>

</xsl:stylesheet>
