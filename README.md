WHO essential medicines lists: where are the drugs to treat neuropathic pain?
================

This repo contains the clean [data file](./data/2015-neml-data.csv) containing information on the listing of drugs (and their indication) recommended as first- or second-line treatments for the management of neuropathic pain on national essential medicines lists. The repo also includes the *R* [analysis scripts](./scripts), [figure](./figures) outputs, and the non-English [drug](./data/2015-search-terms-drug-names.csv) and [disease](./data/2015-search-terms-conditions.csv) names used in the data extraction process. The work was done under the auspicies of the Neuropathic Pain Special Interest Group [(NeuPSIG)](//www.iasp-pain.org/SIG/NeuropathicPain?navItemNumber=5270) of the International Association for the Study of Pain (IASP).

The 112 national essential medicine lists included in the analysis were obtained from the [WHO](http://www.who.int/selection_medicines/country_lists/en/). Copies of the documents can be located [here](https://www.dropbox.com/sh/b9ava7m6bkoxqsz/AAAOjZVK4Gqda9E7a6QCji6Ga?dl=0).

Citation
--------

### Dataset
Kamerman PR, Wadley AL, Davis KD, Hietaharju A, Jain P, Kopf A, Meyer A-C, Raja SN, Rice ASC, Smith BH, Treede R-D, Wiffen PJ. Data and analysis scripts: Inclusion of medicines to treat neuropathic pain on national essential medicines lists. DOI: [10.6084/m9.figshare.4644412](//dx.doi.org/10.6084/m9.figshare.4644412)

### Manuscript
Kamerman PR, Wadley AL, Davis KD, Hietaharju A, Jain P, Kopf A, Meyer A-C, Raja SN, Rice ASC, Smith BH, Treede R-D, Wiffen PJ. World Health Organization essential medicines lists: where are the drugs to treat neuropathic pain? *PAIN* **156**:793–797, 2015. DOI: [10.1097/01.j.pain.0000460356.94374.a1](//dx.doi.org/10.1097/01.j.pain.0000460356.94374.a1)

Licenses
--------
_See: [LICENSE](LICENSE.md) file for details_

### Data license
Open Data Commons Attribution License

### Code license
The MIT License (MIT) 

Codebook
--------

[***2015-neml-data.csv***](./data/2015-neml-data.csv)

<table style="width:100%;">
<colgroup>
<col width="18%" />
<col width="81%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Code</th>
<th align="left">Key</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Country</td>
<td align="left">Country of origin</td>
</tr>
<tr class="even">
<td align="left">Region</td>
<td align="left">United Nations (UN) geographic region</td>
</tr>
<tr class="odd">
<td align="left">Subregion</td>
<td align="left">UN geographic subregion</td>
</tr>
<tr class="even">
<td align="left">World.Bank</td>
<td align="left">World Bank income category classification</td>
</tr>
<tr class="odd">
<td align="left">IMF</td>
<td align="left">International Monetary Fund (IMF) classification of developmental status</td>
</tr>
<tr class="even">
<td align="left">Year</td>
<td align="left">Year the essential medicines list (EML) was published</td>
</tr>
<tr class="odd">
<td align="left">Language</td>
<td align="left">Language in which the EML was published</td>
</tr>
<tr class="even">
<td align="left">Type</td>
<td align="left">WHO drug listing format</td>
</tr>
<tr class="odd">
<td align="left">Class</td>
<td align="left">Drug class</td>
</tr>
<tr class="even">
<td align="left">Drug</td>
<td align="left">Drug name (generic name)</td>
</tr>
<tr class="odd">
<td align="left">Listed</td>
<td align="left">Was the drug included on the EML?</td>
</tr>
<tr class="even">
<td align="left">Any.NeuP</td>
<td align="left">If listed, was it indicated for any neuropathic pain conditions?</td>
</tr>
<tr class="odd">
<td align="left">Central.NeuP</td>
<td align="left">If listed, was it indicated for any central causes of neuropathic pain?</td>
</tr>
<tr class="even">
<td align="left">Peripheral.NeuP</td>
<td align="left">If listed, was it indicated for any peripheral causes of neuropathic pain?</td>
</tr>
<tr class="odd">
<td align="left">DPN</td>
<td align="left">If listed, was it indicated for painful diabetic polyneuropathy?</td>
</tr>
<tr class="even">
<td align="left">PHN</td>
<td align="left">If listed, was it indicated for post-herpetic neuralgia?</td>
</tr>
<tr class="odd">
<td align="left">HIV</td>
<td align="left">If listed, was it indicated for painful HIV-associated sensory neuropathy?</td>
</tr>
<tr class="even">
<td align="left">TGN</td>
<td align="left">If listed, was it indicated for trigeminal neuralgia?</td>
</tr>
</tbody>
</table>

Extra notes recorded during data extraction
-------------------------------------------

### General comments

**Mexico:** Phenytoin tablets and buprenorphen patches recommended for neuropathic pain (any). Oxcarbazepine recommended for neuropathic pain (any). Low-dose capsaicin cream, which is recommended for treating neuropathy (0.035%).

**Bahrain:** Phenytoin recommended for neuropathic pain (any) including TGN. Amantadine hydrochloride recommended for PHN.

**Mongolia:** Needs translation.

**Togo:** Amitriptyline recommended for palliative care.

**Ukraine:** Phenytoin indicated second-line for TGN, and suggests carbamazepine for MS pain.

**Uruguay:** Amitriptyline for fibromyalgia. Phenytoin indicated for TGN.

**Zambia:** TCA = Clomipramine

**Syria and Vietnam:** Capsaicin cream listed, but no concentration given.

**Central African Republic, Dominican Republic, Gabon, Bangladesh, Thailand, Vietnam:** Countries not stating topical lidocaine % concentration

### Uncertainties (and resolution)

**Bahrain:** Oxycodone listed in the preface under narcotic agonists but is not mentioned in the body of the document. *CONSENSUS: OXYCODONE NOT LISTED*.

**Lesotho:** Paracetamol listed for Guillan Barr$é. Should it be classified as 'neuropathic pain'? *CONSENSUS: YES GB CAN BE PAINFUL, AND WOULD FALL UNDER PERIPHERAL NEUROPATHY*.

**Nicaragua:** Unique coding (rather than A/ATC/NTG). *CONSENSUS: CLASS list type as "UNKNOWN"*.

**Peru:** 2012 edition used ATC coding, but 2011 version used more detailed NTG coding. Which version should be used? *CONSENSUS: FOLLOW EXTRACTION PROTOCOL AND USE MOST RECENT VERSION*.

**Slovakia:** Paracetamol/acetaminophen is not listed, but ibuprofen is. *CONSENSUS: REASSESS USING ATC CODES (IN CASE DRUG TRADE NAME RATHER THAN GENERIC NAME USED ON LIST)*.

**Poland:** 2009 list does not include paracetamol. *CONSENSUS: IDENTIFIED UPDATED, 2011, LIST. NO PARACETAMOL LISTED*.

**Ukraine:** Indicate tramadol for "severe neuralgia". *CONSENSUS: RECORD AS BEING INDICATED FOR "ANY NEUROPATHY", BUT NOT TRIGEMINAL OR POST-HERPETIC NEURALGIA SPECIFICALLY*.

**Mexico:** Discrepancy in extraction for ibuprofen. *CONSENSUS: IBUPROFEN NOT LISTED*.
