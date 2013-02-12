<?php
/**
 * class.php
 *
 * @package ts-krinkle-wmfPrefStats
 */
class KrWmfPrefStats extends KrToolBaseClass {

	public static function getFormHtml() {
		global $kgBaseTool, $kgReq;

		$checkedAttr = ' checked';
		$formHtml =
			'<form action="' . $kgBaseTool->remoteBasePath . '" method="get" class="colly ns"><fieldset>'
		.	'<legend>' . _( 'form-legend-settings', 'krinkle' ) . '</legend>'

				// Select wiki
				. kfGetAllWikiSelect( array( 'current' => $kgReq->getVal( 'wikidb' ) ) )
				. '<br>'

				// Update form
				. '<label></label><input type="submit" nof value="' . _( 'update' ) . '"><br>'

				// Select talk space
				. "$talkSelect<br>"

				// Toggle redirects
				. '<label for="hideredirects">' . _( 'hideredirects' ) . '</label>'
				. '<input type="checkbox" name="hideredirects" value="on" ' . ( $kgReq->getCheck( 'hideredirects' ) ? $checkedAttr : '' ) . '>'
				. '<br>'

				// Toggle subpages
				. '<label for="hidesubpages">' . _( 'hidesubpages' ) . '</label>'
				. '<input type="checkbox" name="hidesubpages" value="on" ' . ( $kgReq->getCheck( 'hidesubpages' ) ? $checkedAttr : '' ) . '>'
				. '<br>'

				// Select limit
				. "$limitSelect<br>"

				// Submit form
				. '<label></label><input type="submit" nof value="' . _g( 'form-submit' ) . '"><br>'
		

		. '</fieldset></form>';

		return $formHtml;
	}


}
