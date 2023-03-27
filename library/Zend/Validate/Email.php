<?
class Zend_Validate_Email extends Zend_Validate_Abstract
{

    const INVALID = 'Email is required';
    protected $_messageTemplates = array(
    self::INVALID => "Invalid Email Address",
   // self::ALREADYUSED => "Email is already registered"
    );

     public function isValid($value)
     {
         if(filter_var($value, FILTER_VALIDATE_EMAIL) === false) {
            $this->_error(self::INVALID);
            return false;
        } else {
            // We only check the presence of a dot on the domain part
            $components = explode("@", $value);
            $domain = $components[1];
            if (strpos($domain, ".") === false) {
                $this->_error(self::INVALID);
                return false;
            }
            return true;
        }
     }
}
?>