package xforms2xaml;

import net.sf.saxon.TransformerFactoryImpl; // use saxon package because transformation contains features from XSLT 2.0
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.xml.XMLConstants;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import oracle.xml.parser.schema.XMLSchema;
import oracle.xml.parser.schema.XSDBuilder;
import oracle.xml.parser.schema.XSDException;
import oracle.xml.parser.v2.DOMParser;
import oracle.xml.parser.v2.XMLParser;
import oracle.xml.util.XMLUtil;
import org.xml.sax.SAXException;

/**
 *
 * @author cepi
 */
public class XFormsTransformer {

	public static final String XFORMS_2_XAML_TRANSFORMATION_FILENAME = "xforms-2-xaml.xsl";

	public static final String XFORMS_XSD_FILENAME = "xforms.xsd";

	/**
	 * Provide transformation from XForms to XAML
	 *
	 * @param xFormsFilename input XForms filename
	 * @param xamlFilename output XAML filename
	 * @throws TransformerException
	 * @throws IOException
	 */
	public void transformToXAML(String xFormsFilename, String xamlFilename) throws TransformerException, IOException {
		try {
			TransformerFactory transformerFactory = new TransformerFactoryImpl();

			Transformer transformer = transformerFactory.newTransformer(new StreamSource(new File(XFORMS_2_XAML_TRANSFORMATION_FILENAME)));

			transformer.transform(new StreamSource(new FileReader(new File(xFormsFilename))), new StreamResult(new File(xamlFilename)));
		} catch (TransformerConfigurationException ex) {
			Logger.getGlobal().log(Level.SEVERE, null, ex);
		}
    }

	/**
	 * Validate XForms file
	 *
	 * @param xFormsFilename input XForms filename
	 * @return result of validation
	 * @throws IOException
	 */
	public boolean validate(String xFormsFilename) throws IOException {
		try {
			DOMParser parser  = new DOMParser();

			XSDBuilder builder = new XSDBuilder();
			XMLSchema schema = (XMLSchema)builder.build(new FileReader(new File(XFORMS_XSD_FILENAME)), XMLUtil.createURL(XMLConstants.W3C_XML_SCHEMA_NS_URI));

			parser.setXMLSchema(schema);
			parser.setValidationMode(XMLParser.SCHEMA_LAX_VALIDATION); // lax validation due to combination XForms with other XML Formats

			parser.parse(new FileReader(new File(xFormsFilename)));

			return true;
        } catch (SAXException ex) {
			Logger.getGlobal().log(Level.WARNING, null, ex);
        } catch (XSDException ex) {
			Logger.getGlobal().log(Level.SEVERE, null, ex);
		}

        return false;
	}
}
