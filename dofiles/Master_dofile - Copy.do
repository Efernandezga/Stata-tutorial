
********************************************************************************
/*
	PROYECTO: HIEP Endline Survey	
	AUTOR:	Innovations for Poverty Action (IPA)
	FECHA:	Enero 2022
	MASTER DO FILE, CORRE  TODOS LOS DO FILES DE TODOS LOS STAGES
	*/
********************************************************************************
clear all
gl n=1	//Cambiar n de acuerdo al usuario 
{
	if $n==1 {
		gl user "C:\Users\Gabriela Perez\Box\3_Ongoing_Projects\WBG - HIEP Endline Survey" //Enrique
	}
	if $n==2 {
		gl user "Y:\Box\WBG - HIEP Endline Survey" //Julia
	}
}

* For master data set
gl root	"$user/05. Questionnaires & Data"
gl raw_data "$root\03 Do files\04 Stage 2\01 Import"
gl data_raw "$root\04 Data\02 Stage 2\00 Import"
gl data_rawdta "$root\04 Data\02 Stage 2\001 Dta"

gl dta "$root\04 Data\02 Stage 2\001 Dta"
gl labeled "$root\04 Data\02 Stage 2\01 Labeled"
gl dolabel "$root\03 Do files\04 Stage 2\02 Label cleaning"

gl dofile  "$root\03 Do files\04 Stage 2\03 Cleaning"
gl clean "$root\04 Data\02 Stage 2\02 Clean"
gl auxiliar "$root\04 Data\02 Stage 2\Auxiliares"

gl rawaudit "$root/04 Data\02 Stage 2\03 Audits\00 Raw"
gl dtaaudit "$root\04 Data\02 Stage 2\03 Audits\01 Dta"
gl doreplace "$root\03 Do files\04 Stage 2\04 Replacement"
gl cleanaudit "$root\04 Data\02 Stage 2\03 Audits\02 Clean data after audit"

gl m_s2_online "$root\04 Data\04 Merging data sets"
gl domerge "$root\03 Do files\04 Stage 2\06 Merge"

gl data_prep "$root\03 Do files\07 Data Prep"
gl final_data "$root\04 Data\02 Stage 2\05 For sharing"
gl analysis "$root\03 Do files\08 Analysis"


* Extra docs
gl casos "$root\asos\Casos Stage 1"
gl casos_letter "$root\Casos\Invitation letter"
gl status_letter "$casos_letter\Status p2 p3"
gl social_media "$root\Casos\Social Media"


* Do files 
/*
*do"$raw_data/Master import all forms.do"
	do "$raw_data\import_form_stage2.do"
	do "$raw_data\import_formulario_online.do"
	do "$raw_data\import_formulario_online2.do"
	do "$raw_data\import_formulario3_stage2.do"
	do "$raw_data\import_stage2_online.do"
	*@enrique new ones
	do "$raw_data\import_shortsvy.do"
	do "$raw_data\import_shortsvy_encuestadores.do"
	
*do "$dolabel/Master label all forms.do"
	do "$dolabel\Label cleaning form_stage2.do"
	do "$dolabel\Label cleaning formulario_online.do"
	do "$dolabel\Label cleaning formulario_online2.do"
	do "$dolabel\Label cleaning formulario3_stage2.do"
	do "$dolabel\Label cleaning stage2_online.do"
*/	
*do "$dofile/Master clean all forms.do"
	do "$dofile\Cleaning form_stage2.do" //Revised
	do "$dofile\Cleaning formulario online.do" // Revised
	do "$dofile\Cleaning formulario3_stage2.do" // Revised one duplicate id pending
	do "$dofile\Cleaning stage2_online.do" // Revised
	*Why do we have cleaning formulario3_stage2 and it is not here? lo mismo con razon social from baseline //ahí está en formulario3 ? razón social no se utiliza en estos do files, era un file que tenías, talves va como extra files
	
	
	***REPLACEMENTS FROM AUDIT DATA
*do "$doaudit/Master audit all forms.do" //audita individual con comentarios
	do "$doreplace\replacement Form_stage2.do" // there's no audit for the online survey, there's no way to audit since its self applied-> Then this is more of a replacements dofile // no porque son cambios con los comentarios de auditoría 
	do "$doreplace\replacement formulario3_stage2.do"
	do "$doreplace\replacement stage2_online.do"

do "$domerge/merge_append s2_EF request.do" // Revised
*do "$domerge/Master merge and appends.do" // merges append y audit a la base maestra con el form de audit cantidades // do's separados
	*do "$domerge\Merge online_s2.do"
	*do "$domerge\Append_allforms.do"
	*do "$domerge\audits_allforms.do"

do "$data_prep/Data prep_master data" //Revised
do "$analysis/Analysis.do"
	
* Extra do files for reports and tracking
	do "$dofile\02 Cleans status.do"
	do "$dofile/03 Report.do" 
	* El report es de llamadas por grupo y status
	do "$dofile/04 Tracking data clean.do"
	
	
*if there's a change on audit excel doc run:
* do "$doaudit/01 Import audit"

*Only if necessary // for now is turned off
 * do "$domerge\Merge stage 1&2.do"

**Erases all auxiliary data sets created. 
	
	
	
	
	/* 
-99: Mentioned in the interview they didn't want to share that data due to distrust, confidentiality issues, INADEM, etc.
-88: Does not know, didn't have information in handy and after the follow up to recover this data, they didn't provide it for X reasons (i.e. didn't answer, distrust,etc)
0: Only for those firms who explicitely said their financial variables/registrees equal 0
N/A: Question doesn't apply (i.e. because of the treatment/closed firm/fusion or adquisition meaning for example that if firm closed in 2017, all financial variables, employees, etc would be N/A. 
-99999: Question does not apply.
-88888: Enumerator didn't ask question.
*
	
