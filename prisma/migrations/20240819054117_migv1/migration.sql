-- CreateEnum
CREATE TYPE "audit_type" AS ENUM ('Procedure Audit', 'Product Audit');

-- CreateEnum
CREATE TYPE "auditscope" AS ENUM ('Authority', 'Internal', 'External', 'Subcontractor');

-- CreateEnum
CREATE TYPE "audittype" AS ENUM ('Procedure', 'Product', 'Surveillance');

-- CreateEnum
CREATE TYPE "effective" AS ENUM ('Effective', 'Not Effective');

-- CreateEnum
CREATE TYPE "enum_stat" AS ENUM ('Open', 'Monitor', 'Closed');

-- CreateEnum
CREATE TYPE "level" AS ENUM ('1', '2', '3');

-- CreateEnum
CREATE TYPE "office_code" AS ENUM ('TE', 'TEC-1', 'TEA', 'TEA-1', 'TEA-2', 'TEA-3', 'TEA-4', 'TED', 'TED-1', 'TED-2', 'TED-3', 'TED-4', 'TER', 'TER-1', 'TER-2', 'TER-3', 'TER-4', 'TER-5', 'TEL', 'TEL-1', 'TEL-2', 'TEJ', 'TEJ-1', 'TEJ-2', 'TEJ-3', 'TEM', 'TEM-1', 'TEM-2', 'TEM-3');

-- CreateEnum
CREATE TYPE "probanalis" AS ENUM ('Required', 'Not Required');

-- CreateEnum
CREATE TYPE "reg_based" AS ENUM ('DGCA', 'EASA');

-- CreateEnum
CREATE TYPE "responoffice" AS ENUM ('AO: Airworthiness Office', 'DO: Design Office', 'IM: Independent Monitoring', 'PR: Partner', 'SC: Subcontractor', 'BR: BRIN', 'GF: GMF AeroAsia', 'BA: BIFA Flying School', 'EL: Elang Lintas Indonesia');

-- CreateEnum
CREATE TYPE "uic" AS ENUM ('Chief Design Office', 'Chief Airworthiness Office', 'Chief Independent Monitoring', 'Head of DOA');

-- CreateEnum
CREATE TYPE "user_role" AS ENUM ('Admin', 'DO', 'AO', 'IM');

-- CreateEnum
CREATE TYPE "work_station" AS ENUM ('AO: Airworthiness Office', 'DO: Design Office', 'IM: Independent Monitoring', 'PR: Partner', 'SC: Subcontractor', 'BR: BRIN', 'GF: GMF AeroAsia', 'BA: BIFA Flying School', 'EL: Elang Lintas Indonesia');

-- CreateTable
CREATE TABLE "account" (
    "accountid" BIGSERIAL NOT NULL,
    "name" VARCHAR(255),
    "unit" "office_code",
    "password" VARCHAR(255) DEFAULT 'admin',
    "role" "user_role",
    "email" VARCHAR(255),

    CONSTRAINT "account_pkey" PRIMARY KEY ("accountid")
);

-- CreateTable
CREATE TABLE "apdetail" (
    "docno" BIGSERIAL NOT NULL,
    "accountid" BIGSERIAL NOT NULL,
    "noitem" BIGSERIAL NOT NULL,
    "requirement" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "audittype" "audit_type",
    "subdescription" TEXT NOT NULL,
    "workstation" "work_station",
    "plannedweek" DATE NOT NULL,
    "actualvisitdate" DATE NOT NULL,
    "auditreportevidencenbr" VARCHAR(255) NOT NULL
);

-- CreateTable
CREATE TABLE "assignpic" (
    "pic_id" BIGSERIAL NOT NULL,
    "do_project_id" BIGSERIAL NOT NULL,
    "name" TEXT,
    "role" TEXT,
    "authorizedlettervalidity" DATE,

    CONSTRAINT "assignpic_pkey" PRIMARY KEY ("pic_id")
);

-- CreateTable
CREATE TABLE "auditplan" (
    "accountid" BIGSERIAL NOT NULL,
    "docno" BIGSERIAL NOT NULL,
    "docdate" DATE NOT NULL,
    "subject" TEXT NOT NULL,
    "audittype" "audit_type",

    CONSTRAINT "auditplan_pkey" PRIMARY KEY ("docno")
);

-- CreateTable
CREATE TABLE "closureandperformance" (
    "closure" TEXT,
    "numberofextension" VARCHAR(1),
    "wasfindingeveroverdue" VARCHAR(30)
);

-- CreateTable
CREATE TABLE "commercialaspect" (
    "cost_id" BIGSERIAL NOT NULL,
    "do_project_id" BIGSERIAL NOT NULL,
    "budget" TEXT,
    "costspend" TEXT,
    "postproject" TEXT,
    "billingprocess" TEXT,

    CONSTRAINT "commercialaspect_pkey" PRIMARY KEY ("cost_id")
);

-- CreateTable
CREATE TABLE "findingclosureclosingthefinding" (
    "itemnumber" VARCHAR(2),
    "doaholderdatecomment" DATE,
    "doaholderdescribe" TEXT,
    "easaresponsedate" DATE,
    "easaresponse" TEXT
);

-- CreateTable
CREATE TABLE "findingclosurecorrectiveactionplan" (
    "itemnumber" VARCHAR(2),
    "doaholderdatecomment" DATE,
    "doaholderdescribe" TEXT,
    "easaresponsedate" DATE,
    "easaresponsefeedback" TEXT
);

-- CreateTable
CREATE TABLE "findingclosurelogevents" (
    "datelog" DATE,
    "descriptiontype" VARCHAR(60),
    "descriptiontext" TEXT
);

-- CreateTable
CREATE TABLE "findingclosurerootcauseextensions" (
    "itemnumber" VARCHAR(2),
    "doaholderdatecomment" DATE,
    "doaholderdescribe" TEXT,
    "easaresponsedate" DATE,
    "easaresponse" TEXT
);

-- CreateTable
CREATE TABLE "findingidentification" (
    "organisationname" VARCHAR(60) NOT NULL,
    "doano" VARCHAR(7) NOT NULL,
    "doacoreprocess" VARCHAR(30) NOT NULL,
    "keysubject" VARCHAR(60) NOT NULL,
    "handbookprocedure" VARCHAR(80) NOT NULL,
    "findingno" VARCHAR(4),
    "part21" VARCHAR(30),
    "initialdeadline" DATE,
    "currentdeadline" DATE,
    "level" VARCHAR(15) NOT NULL,
    "status" VARCHAR(6) NOT NULL,
    "finding" TEXT,
    "notes" TEXT,
    "evidences" TEXT,
    "name" VARCHAR(20),
    "position" VARCHAR(20),
    "dateofnotification" DATE,
    "doaholderfocalpointemail" TEXT
);

-- CreateTable
CREATE TABLE "highlightissue" (
    "highlight_id" BIGSERIAL NOT NULL,
    "do_project_id" BIGSERIAL NOT NULL,
    "date" DATE,
    "problemissue" TEXT,
    "correctiveaction" TEXT,
    "pic" TEXT,
    "status" VARCHAR(5),
    "remark" TEXT,

    CONSTRAINT "highlightissue_pkey" PRIMARY KEY ("highlight_id")
);

-- CreateTable
CREATE TABLE "issuence" (
    "docno" BIGSERIAL NOT NULL,
    "accountid" BIGSERIAL NOT NULL,
    "issuenbr" BIGSERIAL NOT NULL,
    "issuedate" DATE NOT NULL,
    "issuedesc" TEXT NOT NULL,
    "issuedby" TEXT NOT NULL,
    "hdoapprove" TEXT
);

-- CreateTable
CREATE TABLE "ncr_followresult" (
    "accountid" BIGSERIAL NOT NULL,
    "ncr_init_id" BIGSERIAL NOT NULL,
    "close_corrective_actions" TEXT,
    "proposed_close_auditee" TEXT NOT NULL,
    "proposed_close_date" DATE NOT NULL,
    "is_close" BOOLEAN NOT NULL,
    "effectiveness" "effective" NOT NULL,
    "refer_verification" VARCHAR(10),
    "sheet_no" VARCHAR(50),
    "new_ncr_issue_nbr" VARCHAR(10),
    "close_approved_by" TEXT NOT NULL,
    "close_approved_date" DATE NOT NULL,
    "verified_chief_im" TEXT NOT NULL,
    "verified_date" DATE NOT NULL,
    "temporarylink" TEXT
);

-- CreateTable
CREATE TABLE "ncr_initial" (
    "accountid" BIGSERIAL NOT NULL,
    "ncr_init_id" BIGSERIAL NOT NULL,
    "regulationbased" "reg_based" NOT NULL,
    "subject" TEXT NOT NULL,
    "audit_plan_no" VARCHAR(10) NOT NULL,
    "ncr_no" VARCHAR(11) NOT NULL,
    "issued_date" DATE NOT NULL,
    "responsibility_office" "responoffice" NOT NULL,
    "audit_type" "audittype" NOT NULL,
    "audit_scope" "auditscope" NOT NULL,
    "to_uic" "uic" NOT NULL,
    "attention" TEXT NOT NULL,
    "require_condition_reference" TEXT NOT NULL,
    "level_finding" "level" NOT NULL,
    "problem_analysis" "probanalis" NOT NULL,
    "answer_due_date" DATE NOT NULL,
    "issue_ian" BOOLEAN NOT NULL,
    "ian_no" TEXT NOT NULL,
    "encountered_condition" TEXT NOT NULL,
    "audit_by" TEXT NOT NULL,
    "audit_date" DATE NOT NULL,
    "acknowledge_by" TEXT NOT NULL,
    "acknowledge_date" DATE NOT NULL,
    "status" "enum_stat" NOT NULL,
    "temporarylink" TEXT,

    CONSTRAINT "ncr_initial_pkey" PRIMARY KEY ("ncr_init_id")
);

-- CreateTable
CREATE TABLE "ncr_reply" (
    "accountid" BIGSERIAL NOT NULL,
    "ncr_init_id" BIGSERIAL NOT NULL,
    "rca_problem" TEXT NOT NULL,
    "corrective_action" TEXT NOT NULL,
    "preventive_action" TEXT NOT NULL,
    "identified_by_auditee" TEXT NOT NULL,
    "identified_date" DATE NOT NULL,
    "accept_by_auditor" TEXT NOT NULL,
    "auditor_accept_date" DATE NOT NULL,
    "temporarylink" TEXT,
    "recommend_corrective_action" TEXT
);

-- CreateTable
CREATE TABLE "requireddocuments" (
    "doc_id" BIGSERIAL NOT NULL,
    "do_project_id" BIGSERIAL NOT NULL,
    "documenttype" TEXT,
    "documentname" TEXT,
    "documentnumber" TEXT,
    "documentcreatedby" TEXT,
    "documentcreateddate" DATE,
    "documentcheckby" TEXT,
    "documentcheckdate" DATE,
    "documentapproveby" TEXT,
    "documentapprovedate" DATE,
    "status" VARCHAR(5),
    "remark" TEXT,

    CONSTRAINT "requireddocuments_pkey" PRIMARY KEY ("doc_id")
);

-- CreateTable
CREATE TABLE "tbl_category_ior" (
    "id_ior" BIGSERIAL NOT NULL,
    "id_ior_category" BIGSERIAL NOT NULL,
    "number_cat" VARCHAR(2),
    "occur_nbr" VARCHAR(60),

    CONSTRAINT "tbl_category_ior_pkey" PRIMARY KEY ("id_ior_category")
);

-- CreateTable
CREATE TABLE "tbl_do_project" (
    "do_project_id" BIGSERIAL NOT NULL,
    "regulationbased" VARCHAR(5),
    "projecttitle" TEXT,
    "projectnumber" TEXT,
    "projectdescription" TEXT,
    "projectcreateddate" DATE,
    "eststartdate" DATE,
    "estfinishdate" DATE,
    "actstartdate" DATE,
    "actfinishdate" DATE,
    "aircrafttypeenginetypepart" TEXT,
    "numberofaircraftenginepart" TEXT,
    "customername" TEXT,
    "projectclassification" VARCHAR(5),
    "subclassification" VARCHAR(10),

    CONSTRAINT "tbl_do_project_pkey" PRIMARY KEY ("do_project_id")
);

-- CreateTable
CREATE TABLE "tbl_follupoccur" (
    "id_follup" BIGSERIAL NOT NULL,
    "id_ior" BIGSERIAL NOT NULL,
    "follup_detail" TEXT,
    "follupby" VARCHAR(75),
    "follup_uic" VARCHAR(4),
    "follup_date" DATE,
    "follup_datarefer" BOOLEAN,
    "follup_status" VARCHAR(8),
    "nextuic_follup" VARCHAR(4),
    "current_probability" VARCHAR(1),
    "current_severity" VARCHAR(1),
    "current_riskindex" VARCHAR(40),

    CONSTRAINT "tbl_follupoccur_pkey" PRIMARY KEY ("id_follup")
);

-- CreateTable
CREATE TABLE "tbl_occurrence" (
    "id_ior" BIGSERIAL NOT NULL,
    "subject_ior" TEXT,
    "occur_nbr" VARCHAR(15),
    "occur_date" DATE,
    "reference_ior" VARCHAR(80),
    "to_uic" VARCHAR(4),
    "cc_uic" VARCHAR(4),
    "category_occur" VARCHAR(1),
    "type_or_pnbr" VARCHAR(15),
    "level_type" VARCHAR(10),
    "detail_occurance" TEXT,
    "reportedby" VARCHAR(75),
    "reporter_uic" VARCHAR(4),
    "report_date" DATE,
    "reporter_identity" VARCHAR(8),
    "data_reference" VARCHAR(8),
    "hirac_process" VARCHAR(8),
    "initial_probability" VARCHAR(1),
    "initial_severity" VARCHAR(1),
    "initial_riskindex" VARCHAR(40),

    CONSTRAINT "tbl_occurrence_pkey" PRIMARY KEY ("id_ior")
);

-- CreateIndex
CREATE UNIQUE INDEX "account_email_key" ON "account"("email");

-- CreateIndex
CREATE UNIQUE INDEX "apdetail_noitem_key" ON "apdetail"("noitem");

-- AddForeignKey
ALTER TABLE "apdetail" ADD CONSTRAINT "apdetail_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "apdetail" ADD CONSTRAINT "apdetail_docno_fkey" FOREIGN KEY ("docno") REFERENCES "auditplan"("docno") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "assignpic" ADD CONSTRAINT "assignpic_do_project_id_fkey" FOREIGN KEY ("do_project_id") REFERENCES "tbl_do_project"("do_project_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auditplan" ADD CONSTRAINT "auditplan_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "commercialaspect" ADD CONSTRAINT "commercialaspect_do_project_id_fkey" FOREIGN KEY ("do_project_id") REFERENCES "tbl_do_project"("do_project_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "highlightissue" ADD CONSTRAINT "highlightissue_do_project_id_fkey" FOREIGN KEY ("do_project_id") REFERENCES "tbl_do_project"("do_project_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "issuence" ADD CONSTRAINT "issuence_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "issuence" ADD CONSTRAINT "issuence_docno_fkey" FOREIGN KEY ("docno") REFERENCES "auditplan"("docno") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ncr_followresult" ADD CONSTRAINT "ncr_followresult_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ncr_followresult" ADD CONSTRAINT "ncr_followresult_ncr_init_id_fkey" FOREIGN KEY ("ncr_init_id") REFERENCES "ncr_initial"("ncr_init_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ncr_initial" ADD CONSTRAINT "ncr_initial_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ncr_reply" ADD CONSTRAINT "ncr_reply_accountid_fkey" FOREIGN KEY ("accountid") REFERENCES "account"("accountid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ncr_reply" ADD CONSTRAINT "ncr_reply_ncr_init_id_fkey" FOREIGN KEY ("ncr_init_id") REFERENCES "ncr_initial"("ncr_init_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "requireddocuments" ADD CONSTRAINT "requireddocuments_do_project_id_fkey" FOREIGN KEY ("do_project_id") REFERENCES "tbl_do_project"("do_project_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbl_category_ior" ADD CONSTRAINT "tbl_category_ior_id_ior_fkey" FOREIGN KEY ("id_ior") REFERENCES "tbl_occurrence"("id_ior") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbl_follupoccur" ADD CONSTRAINT "tbl_follupoccur_id_ior_fkey" FOREIGN KEY ("id_ior") REFERENCES "tbl_occurrence"("id_ior") ON DELETE NO ACTION ON UPDATE NO ACTION;
