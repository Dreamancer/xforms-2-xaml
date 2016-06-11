package xforms2xaml;

//We are using saxon package because the transformation contains features from XSLT 2.0.
import net.sf.saxon.TransformerFactoryImpl;
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
 * Transformer class that provides methods for validating XForms files and
 * transforming them into XAML files.
 *
 * @author cepi
 */
public class XFormsTransformer {

	//Filename of the stylesheet used for the transformation.
	public static final String XFORMS_2_XAML_TRANSFORMATION_FILENAME = "xforms-2-xaml.xsl";
	//Filename of the XSD schema used for validation.
	public static final String XFORMS_XSD_FILENAME = "xforms.xsd";

	/**
	 * Provides transformation from XForms to XAML.
	 *
	 * @param xFormsFilename input XForms filename
	 * @param xamlFilename output XAML filename
	 * @throws TransformerException
	 * @throws IOException
	 */
	public void transformToXAML(String xFormsFilename, String xamlFilename) throws TransformerException, IOException {
		//Attempt the transformation.
		try {
			//Create a transformer factory.
			TransformerFactory transformerFactory = new TransformerFactoryImpl();
			//Create a transformer with a given name.
			Transformer transformer = transformerFactory.newTransformer(new StreamSource(new File(XFORMS_2_XAML_TRANSFORMATION_FILENAME)));
			//Use a transform method on the transformer.
			transformer.transform(new StreamSource(new FileReader(new File(xFormsFilename))), new StreamResult(new File(xamlFilename)));
		} catch (TransformerConfigurationException ex) {
			//Log a thrown exception.
			Logger.getGlobal().log(Level.SEVERE, null, ex);
		}
	}

	/**
	 * Validates XForms file using standard Java XMLparser.
	 *
	 * @param xFormsFilename input XForms filename
	 * @return result of validation
	 * @throws IOException
	 */
	public boolean validate(String xFormsFilename) throws IOException {
		//Attempt the validation.
		try {
			//Create a new DOMParser.
			DOMParser parser = new DOMParser();
			//Create a new XSDBuilder.
			XSDBuilder builder = new XSDBuilder();
			//Create a schema with a given name.
			XMLSchema schema = (XMLSchema) builder.build(new FileReader(new File(XFORMS_XSD_FILENAME)), XMLUtil.createURL(XMLConstants.W3C_XML_SCHEMA_NS_URI));

			//Set the schema on a parser.
			parser.setXMLSchema(schema);
			//Use LAX validation due to a combination of XForms with other XML formats.
			parser.setValidationMode(XMLParser.SCHEMA_LAX_VALIDATION);

			//Parse the input file.
			parser.parse(new FileReader(new File(xFormsFilename)));
			//Parsing has been successful.
			return true;
		} catch (SAXException ex) {
			//Log a SAXException.
			Logger.getGlobal().log(Level.WARNING, null, ex);
		} catch (XSDException ex) {
			//Log an XSDException
			Logger.getGlobal().log(Level.SEVERE, null, ex);
		}
		//The validation has not been successful.
		return false;
	}
}
