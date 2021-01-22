<?php


namespace OpenEMR\Billing\BillingProcessor\Tasks;

use OpenEMR\Billing\BillingProcessor\GeneratorCanValidateInterface;
use OpenEMR\Billing\BillingProcessor\GeneratorInterface;
use OpenEMR\Billing\BillingProcessor\LoggerInterface;
use OpenEMR\Billing\BillingProcessor\BillingClaim;
use OpenEMR\Billing\Hcfa1500;

class GeneratorHCFA_PDF_IMG extends GeneratorHCFA_PDF implements GeneratorInterface, GeneratorCanValidateInterface, LoggerInterface
{
    /**
     * The only difference between this and the parent PDF generator
     * is that this overlays the data on an image of the HCFA 1500
     * claim form.
     *
     * Whether this action is available is configured in Globals > Billing
     * withe checkbox "Prints the CMS 1500 on the Preprinted form"
     *
     * @param BillingClaim $claim
     */
    protected function updateBatch(BillingClaim $claim)
    {
        $log = '';
        $hcfa = new Hcfa1500();
        $lines = $hcfa->genHcfa1500($claim->getPid(), $claim->getEncounter(), $log);
        $hcfa_image = $GLOBALS['images_static_absolute'] . "/cms1500.png";
        $this->appendToLog($log);
        $alines = explode("\014", $lines); // form feeds may separate pages
        foreach ($alines as $tmplines) {
            if ($claim_count++) {
                $this->pdf->ezNewPage();
            }
            $this->pdf->ezSetY($this->pdf->ez['pageHeight'] - $this->pdf->ez['topMargin']);
            $this->pdf->addPngFromFile("$hcfa_image", 0, 0, 612, 792);
            $this->pdf->ezText($tmplines, 12, array(
                'justification' => 'left',
                'leading' => 12
            ));
        }
    }


}
