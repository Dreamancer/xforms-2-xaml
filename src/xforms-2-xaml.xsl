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
		<Window x:Class = "Resources.MainWindow" 
		xmlns = "http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
		xmlns:x = "http://schemas.microsoft.com/winfx/2006/xaml" Title = "MainWindow" Height = "400" Width = "600"> 

			<Grid> 
				<!-- examples of how to make form elements in XAML: delete later -->
				<TextBlock Text = "example text"/> 
				<Button Content = "example button"/>
			</Grid> 

		</Window> 
	</xsl:template>

</xsl:stylesheet>
