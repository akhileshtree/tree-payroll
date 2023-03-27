<?php
// Zend/Filter/File/Resize/Adapter/Abstract.php
/**
 * Zend Framework addition by Zend
 * 
 * @category   Zend
 * @package    Zend_Filter
 * @license    http://opensource.org/licenses/gpl-license.php GNU Public License
 * @author     Stefan Koch <cct@stefan-koch.name>
 */


/**
 * Resizes a given file and saves the created file
 *
 * @category   Zend
 * @package    Zend_Filter
 */
abstract class Zend_Filter_File_Resize_Adapter_Abstract
{
    abstract public function resize($width, $height, $keepRatio, $file, $target, $keepSmaller = true);

    protected function _calculateWidth($oldWidth, $oldHeight, $width, $height)
    {
        // now we need the resize factor
        // use the bigger one of both and apply them on both
        $factor = max(($oldWidth/$width), ($oldHeight/$height));
        return array($oldWidth/$factor, $oldHeight/$factor);
    }
}