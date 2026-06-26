-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('normal', 'candidate', 'admin', 'developer');

-- CreateEnum
CREATE TYPE "ApplicationStatus" AS ENUM ('active', 'under_review', 'interview', 'pending', 'accepted', 'hired', 'rejected');

-- CreateEnum
CREATE TYPE "InterviewStatus" AS ENUM ('scheduled', 'completed', 'canceled');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('active', 'inactive');

-- CreateEnum
CREATE TYPE "AssessmentStatus" AS ENUM ('passed', 'failed');

-- CreateEnum
CREATE TYPE "QuestionType" AS ENUM ('multiple_choice', 'true_false', 'open_ended');

-- CreateEnum
CREATE TYPE "DifficultyLevel" AS ENUM ('easy', 'medium', 'hard');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('application', 'interview', 'subscription');

-- CreateEnum
CREATE TYPE "ProficiencyLevel" AS ENUM ('beginner', 'intermediate', 'advanced');

-- CreateEnum
CREATE TYPE "LogStatus" AS ENUM ('success', 'failure');

-- CreateEnum
CREATE TYPE "ReportStatus" AS ENUM ('pending', 'resolved', 'dismissed');

-- CreateEnum
CREATE TYPE "DeviceType" AS ENUM ('desktop', 'mobile', 'tablet');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('pending', 'completed', 'failed');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('bank_transfer', 'credit_card', 'paypal');

-- CreateEnum
CREATE TYPE "InterviewType" AS ENUM ('in_person', 'virtual');

-- CreateEnum
CREATE TYPE "EducationLevel" AS ENUM ('HIGH_SCHOOL', 'ASSOCIATES', 'BACHELORS', 'MASTERS', 'DOCTORATE', 'DIPLOMA', 'VOCATIONAL', 'CERTIFICATION', 'SOME_COLLEGE', 'POSTGRADUATE');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "JobType" AS ENUM ('fullTime', 'partTime', 'freelance', 'contractor');

-- CreateEnum
CREATE TYPE "CountryCode" AS ENUM ('ID', 'SG', 'MY', 'US', 'GB', 'DE', 'JP', 'CN');

-- CreateEnum
CREATE TYPE "JobEducationLevel" AS ENUM ('high_school', 'intermediate', 'graduate', 'bachelor_degree', 'master_degree', 'doctor_degree');

-- CreateEnum
CREATE TYPE "JobExperience" AS ENUM ('entry_level', 'mid_level', 'senior_level', 'expert');

-- CreateEnum
CREATE TYPE "JobCategory" AS ENUM ('software_engineering', 'data_science', 'machine_learning', 'artificial_intelligence', 'cybersecurity', 'business_intelligence', 'cyber_security', 'product_management', 'marketing', 'design', 'finance', 'accounting', 'legal', 'management', 'human_resources', 'customer_service', 'sales', 'legal_and_compliance', 'management_and_leadership', 'public_relations');

-- CreateEnum
CREATE TYPE "IndustryType" AS ENUM ('TECHNOLOGY', 'FINANCE', 'HEALTHCARE', 'EDUCATION', 'RETAIL', 'HOSPITALITY', 'TRANSPORTATION', 'CONSTRUCTION', 'REAL_ESTATE', 'CONSULTING', 'GOVERNMENT', 'ENERGY', 'TELECOMMUNICATIONS', 'ENTERTAINMENT', 'AGRICULTURE', 'MANUFACTURING', 'INSURANCE', 'LEGAL', 'MARKETING', 'ADVERTISING', 'MEDIA', 'NON_PROFIT', 'RESEARCH', 'AUTOMOTIVE', 'PHARMACEUTICALS');

-- CreateTable
CREATE TABLE "User" (
    "user_id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "profile_picture" TEXT,
    "phone" TEXT,
    "website" TEXT,
    "linkedin" TEXT,
    "github" TEXT,
    "twitter" TEXT,
    "facebook" TEXT,
    "instagram" TEXT,
    "title" TEXT,
    "education" "EducationLevel",
    "biography" TEXT,
    "skills" TEXT,
    "languages" TEXT,
    "nationality" TEXT,
    "country" "CountryCode",
    "location" TEXT,
    "gender" "Gender",
    "tempat_lahir" TEXT,
    "DateOfBirth" TIMESTAMP(3),
    "resume" TEXT,
    "years_of_experience" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_verified" BOOLEAN NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "Company" (
    "company_id" SERIAL NOT NULL,
    "company_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "aboutUs" TEXT,
    "website" TEXT,
    "linkedin" TEXT,
    "instagram" TEXT,
    "twitter" TEXT,
    "facebook" TEXT,
    "yearOfEstablish" TEXT,
    "IndustryType" "IndustryType",
    "TeamSize" TEXT,
    "country" "CountryCode" NOT NULL,
    "address" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "description" TEXT,
    "logo" TEXT,
    "banner" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("company_id")
);

-- CreateTable
CREATE TABLE "Job" (
    "job_id" SERIAL NOT NULL,
    "job_title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "responsibility" TEXT,
    "country" "CountryCode" NOT NULL,
    "location" TEXT,
    "salary" INTEGER,
    "jobType" "JobType",
    "jobCategory" "JobCategory",
    "jobEducationLevel" "JobEducationLevel",
    "jobExperience" "JobExperience",
    "jobExpired_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "company_id" INTEGER NOT NULL,
    "user_id" INTEGER,

    CONSTRAINT "Job_pkey" PRIMARY KEY ("job_id")
);

-- CreateTable
CREATE TABLE "Favorite" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "job_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Favorite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "application_id" SERIAL NOT NULL,
    "resume" TEXT,
    "coverLetter" TEXT,
    "expected_salary" DECIMAL(65,30),
    "status" "ApplicationStatus" NOT NULL,
    "applied_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "interview_date" TIMESTAMP(3),
    "interview_time" TIMESTAMP(3),
    "interview_status" "InterviewStatus",
    "job_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("application_id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "notification_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "subject" TEXT,
    "message" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL,
    "type" "NotificationType" NOT NULL,
    "related_id" INTEGER,
    "link" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("notification_id")
);

-- CreateTable
CREATE TABLE "UserSkill" (
    "user_skill_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "skill_name" TEXT NOT NULL,
    "years_of_experience" INTEGER,
    "proficiency_level" "ProficiencyLevel",
    "certification" TEXT,
    "description" TEXT,
    "is_verified" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserSkill_pkey" PRIMARY KEY ("user_skill_id")
);

-- CreateTable
CREATE TABLE "AdminLog" (
    "log_id" SERIAL NOT NULL,
    "action" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "details" TEXT,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "status" "LogStatus",
    "affected_user_id" INTEGER,
    "admin_id" INTEGER NOT NULL,
    "affected_job_id" INTEGER,

    CONSTRAINT "AdminLog_pkey" PRIMARY KEY ("log_id")
);

-- CreateTable
CREATE TABLE "JobReport" (
    "report_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,
    "status" "ReportStatus" NOT NULL,
    "admin_response" TEXT,
    "is_anonymous" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "resolution_date" TIMESTAMP(3),

    CONSTRAINT "JobReport_pkey" PRIMARY KEY ("report_id")
);

-- CreateTable
CREATE TABLE "JobView" (
    "view_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "user_id" INTEGER,
    "viewed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "location" TEXT,
    "device_type" "DeviceType",
    "referrer" TEXT,
    "session_id" TEXT,

    CONSTRAINT "JobView_pkey" PRIMARY KEY ("view_id")
);

-- CreateTable
CREATE TABLE "JobSave" (
    "save_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "saved_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_favorite" BOOLEAN NOT NULL,
    "notes" TEXT,
    "expiration_date" TIMESTAMP(3),
    "reminder_set" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobSave_pkey" PRIMARY KEY ("save_id")
);

-- CreateTable
CREATE TABLE "Interview" (
    "interview_id" SERIAL NOT NULL,
    "application_id" INTEGER NOT NULL,
    "scheduled_time" TIMESTAMP(3) NOT NULL,
    "status" "InterviewStatus" NOT NULL,
    "feedback" TEXT,
    "interviewer_name" TEXT,
    "interview_link" TEXT,
    "interview_type" "InterviewType",
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("interview_id")
);

-- CreateTable
CREATE TABLE "PreSelectionTest" (
    "test_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,

    CONSTRAINT "PreSelectionTest_pkey" PRIMARY KEY ("test_id")
);

-- CreateTable
CREATE TABLE "TestQuestion" (
    "question_id" SERIAL NOT NULL,
    "test_id" INTEGER NOT NULL,
    "question_text" TEXT NOT NULL,
    "correct_answer" INTEGER NOT NULL,

    CONSTRAINT "TestQuestion_pkey" PRIMARY KEY ("question_id")
);

-- CreateTable
CREATE TABLE "TestResult" (
    "result_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "job_id" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,
    "completed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TestResult_pkey" PRIMARY KEY ("result_id")
);

-- CreateTable
CREATE TABLE "TestOption" (
    "option_id" SERIAL NOT NULL,
    "question_id" INTEGER NOT NULL,
    "option_text" TEXT NOT NULL,

    CONSTRAINT "TestOption_pkey" PRIMARY KEY ("option_id")
);

-- CreateTable
CREATE TABLE "TestAnswer" (
    "answer_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "question_id" INTEGER NOT NULL,
    "test_id" INTEGER NOT NULL,
    "selected_option" INTEGER NOT NULL,
    "is_correct" BOOLEAN NOT NULL,
    "answered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TestAnswer_pkey" PRIMARY KEY ("answer_id")
);

-- CreateTable
CREATE TABLE "SubscriptionType" (
    "subs_type_id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "features" JSONB NOT NULL,
    "User_id" INTEGER,
    "is_recomend" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SubscriptionType_pkey" PRIMARY KEY ("subs_type_id")
);

-- CreateTable
CREATE TABLE "Subscription" (
    "subscription_id" SERIAL NOT NULL,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "status" "SubscriptionStatus",
    "payment_proof" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "amount" DECIMAL(65,30),
    "user_id" INTEGER,
    "subscription_type_id" INTEGER NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("subscription_id")
);

-- CreateTable
CREATE TABLE "Review" (
    "review_id" SERIAL NOT NULL,
    "rating" DECIMAL(65,30),
    "comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "salary_estimate" DECIMAL(65,30),
    "position" TEXT,
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "careerOpportunitiesRating" INTEGER NOT NULL,
    "facilitiesRating" INTEGER NOT NULL,
    "workCultureRating" INTEGER NOT NULL,
    "workLifeBalanceRating" INTEGER NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("review_id")
);

-- CreateTable
CREATE TABLE "SkillAssessment" (
    "assessment_id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "assessment_data" JSONB,
    "start_date" TIMESTAMP(3),
    "feedback" TEXT,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "SkillAssessment_pkey" PRIMARY KEY ("assessment_id")
);

-- CreateTable
CREATE TABLE "AssessmentQuestion" (
    "question_id" SERIAL NOT NULL,
    "question_text" TEXT NOT NULL,
    "question_type" "QuestionType" NOT NULL DEFAULT 'multiple_choice',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "difficulty_level" "DifficultyLevel",
    "points" INTEGER,
    "assessment_id" INTEGER NOT NULL,

    CONSTRAINT "AssessmentQuestion_pkey" PRIMARY KEY ("question_id")
);

-- CreateTable
CREATE TABLE "AssessmentAnswer" (
    "answer_id" SERIAL NOT NULL,
    "answer_text" TEXT NOT NULL,
    "is_correct" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "question_id" INTEGER NOT NULL,

    CONSTRAINT "AssessmentAnswer_pkey" PRIMARY KEY ("answer_id")
);

-- CreateTable
CREATE TABLE "UserAssessmentResponse" (
    "response_id" SERIAL NOT NULL,
    "answer_text" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "question_id" INTEGER NOT NULL,
    "answer_id" INTEGER,
    "assessment_id" INTEGER NOT NULL,

    CONSTRAINT "UserAssessmentResponse_pkey" PRIMARY KEY ("response_id")
);

-- CreateTable
CREATE TABLE "UserAssessmentScore" (
    "score_id" SERIAL NOT NULL,
    "badge" TEXT,
    "score" INTEGER DEFAULT 0,
    "status" "AssessmentStatus" NOT NULL DEFAULT 'failed',
    "unique_code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "assessment_id" INTEGER NOT NULL,
    "assessmentQuestionQuestion_id" INTEGER,
    "assessmentAnswerAnswer_id" INTEGER,

    CONSTRAINT "UserAssessmentScore_pkey" PRIMARY KEY ("score_id")
);

-- CreateTable
CREATE TABLE "FeatureUsage" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "feature_name" TEXT NOT NULL,
    "used_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FeatureUsage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CV" (
    "cv_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "template" TEXT NOT NULL DEFAULT 'ATS',
    "content" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CV_pkey" PRIMARY KEY ("cv_id")
);

-- CreateTable
CREATE TABLE "PaymentTransaction" (
    "transaction_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "transaction_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "TransactionStatus" NOT NULL DEFAULT 'pending',
    "payment_method" "PaymentMethod" DEFAULT 'bank_transfer',
    "receipt" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "subscription_id" INTEGER,
    "subscription_type_id" INTEGER NOT NULL,

    CONSTRAINT "PaymentTransaction_pkey" PRIMARY KEY ("transaction_id")
);

-- CreateTable
CREATE TABLE "_UserCompanies" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_UserCompanies_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Company_email_key" ON "Company"("email");

-- CreateIndex
CREATE INDEX "Company_email_idx" ON "Company"("email");

-- CreateIndex
CREATE INDEX "Job_company_id_idx" ON "Job"("company_id");

-- CreateIndex
CREATE INDEX "Job_is_active_jobCategory_idx" ON "Job"("is_active", "jobCategory");

-- CreateIndex
CREATE INDEX "Job_userUser_id_fkey" ON "Job"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Favorite_user_id_job_id_key" ON "Favorite"("user_id", "job_id");

-- CreateIndex
CREATE INDEX "Application_job_id_idx" ON "Application"("job_id");

-- CreateIndex
CREATE INDEX "Application_user_id_idx" ON "Application"("user_id");

-- CreateIndex
CREATE INDEX "Notification_user_id_idx" ON "Notification"("user_id");

-- CreateIndex
CREATE INDEX "UserSkill_user_id_idx" ON "UserSkill"("user_id");

-- CreateIndex
CREATE INDEX "AdminLog_admin_id_idx" ON "AdminLog"("admin_id");

-- CreateIndex
CREATE INDEX "JobReport_job_id_idx" ON "JobReport"("job_id");

-- CreateIndex
CREATE INDEX "JobReport_user_id_idx" ON "JobReport"("user_id");

-- CreateIndex
CREATE INDEX "JobView_job_id_idx" ON "JobView"("job_id");

-- CreateIndex
CREATE INDEX "JobSave_job_id_idx" ON "JobSave"("job_id");

-- CreateIndex
CREATE INDEX "JobSave_user_id_idx" ON "JobSave"("user_id");

-- CreateIndex
CREATE INDEX "Interview_application_id_idx" ON "Interview"("application_id");

-- CreateIndex
CREATE UNIQUE INDEX "PreSelectionTest_job_id_key" ON "PreSelectionTest"("job_id");

-- CreateIndex
CREATE INDEX "SubscriptionType_User_id_idx" ON "SubscriptionType"("User_id");

-- CreateIndex
CREATE INDEX "Subscription_user_id_idx" ON "Subscription"("user_id");

-- CreateIndex
CREATE INDEX "Subscription_status_end_date_idx" ON "Subscription"("status", "end_date");

-- CreateIndex
CREATE INDEX "Subscription_subscription_type_id_idx" ON "Subscription"("subscription_type_id");

-- CreateIndex
CREATE INDEX "Review_company_id_idx" ON "Review"("company_id");

-- CreateIndex
CREATE INDEX "Review_user_id_idx" ON "Review"("user_id");

-- CreateIndex
CREATE INDEX "SkillAssessment_user_id_idx" ON "SkillAssessment"("user_id");

-- CreateIndex
CREATE INDEX "AssessmentQuestion_assessment_id_idx" ON "AssessmentQuestion"("assessment_id");

-- CreateIndex
CREATE INDEX "AssessmentAnswer_question_id_idx" ON "AssessmentAnswer"("question_id");

-- CreateIndex
CREATE INDEX "UserAssessmentResponse_user_id_idx" ON "UserAssessmentResponse"("user_id");

-- CreateIndex
CREATE INDEX "UserAssessmentResponse_question_id_idx" ON "UserAssessmentResponse"("question_id");

-- CreateIndex
CREATE INDEX "UserAssessmentResponse_assessment_id_idx" ON "UserAssessmentResponse"("assessment_id");

-- CreateIndex
CREATE UNIQUE INDEX "UserAssessmentScore_unique_code_key" ON "UserAssessmentScore"("unique_code");

-- CreateIndex
CREATE INDEX "UserAssessmentScore_user_id_idx" ON "UserAssessmentScore"("user_id");

-- CreateIndex
CREATE INDEX "UserAssessmentScore_assessment_id_idx" ON "UserAssessmentScore"("assessment_id");

-- CreateIndex
CREATE INDEX "FeatureUsage_user_id_feature_name_idx" ON "FeatureUsage"("user_id", "feature_name");

-- CreateIndex
CREATE INDEX "CV_user_id_idx" ON "CV"("user_id");

-- CreateIndex
CREATE INDEX "PaymentTransaction_user_id_idx" ON "PaymentTransaction"("user_id");

-- CreateIndex
CREATE INDEX "PaymentTransaction_subscription_id_idx" ON "PaymentTransaction"("subscription_id");

-- CreateIndex
CREATE INDEX "PaymentTransaction_subscription_type_id_idx" ON "PaymentTransaction"("subscription_type_id");

-- CreateIndex
CREATE INDEX "_UserCompanies_B_index" ON "_UserCompanies"("B");

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("company_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSkill" ADD CONSTRAINT "UserSkill_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdminLog" ADD CONSTRAINT "AdminLog_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobReport" ADD CONSTRAINT "JobReport_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobReport" ADD CONSTRAINT "JobReport_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobView" ADD CONSTRAINT "JobView_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobView" ADD CONSTRAINT "JobView_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobSave" ADD CONSTRAINT "JobSave_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobSave" ADD CONSTRAINT "JobSave_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "Application"("application_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PreSelectionTest" ADD CONSTRAINT "PreSelectionTest_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestQuestion" ADD CONSTRAINT "TestQuestion_test_id_fkey" FOREIGN KEY ("test_id") REFERENCES "PreSelectionTest"("test_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestResult" ADD CONSTRAINT "TestResult_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestResult" ADD CONSTRAINT "TestResult_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestOption" ADD CONSTRAINT "TestOption_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "TestQuestion"("question_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestAnswer" ADD CONSTRAINT "TestAnswer_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestAnswer" ADD CONSTRAINT "TestAnswer_test_id_fkey" FOREIGN KEY ("test_id") REFERENCES "PreSelectionTest"("test_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestAnswer" ADD CONSTRAINT "TestAnswer_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "TestQuestion"("question_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubscriptionType" ADD CONSTRAINT "SubscriptionType_User_id_fkey" FOREIGN KEY ("User_id") REFERENCES "User"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_subscription_type_id_fkey" FOREIGN KEY ("subscription_type_id") REFERENCES "SubscriptionType"("subs_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("company_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillAssessment" ADD CONSTRAINT "SkillAssessment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssessmentQuestion" ADD CONSTRAINT "AssessmentQuestion_assessment_id_fkey" FOREIGN KEY ("assessment_id") REFERENCES "SkillAssessment"("assessment_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssessmentAnswer" ADD CONSTRAINT "AssessmentAnswer_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "AssessmentQuestion"("question_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentResponse" ADD CONSTRAINT "UserAssessmentResponse_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentResponse" ADD CONSTRAINT "UserAssessmentResponse_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "AssessmentQuestion"("question_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentResponse" ADD CONSTRAINT "UserAssessmentResponse_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "AssessmentAnswer"("answer_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentResponse" ADD CONSTRAINT "UserAssessmentResponse_assessment_id_fkey" FOREIGN KEY ("assessment_id") REFERENCES "SkillAssessment"("assessment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentScore" ADD CONSTRAINT "UserAssessmentScore_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentScore" ADD CONSTRAINT "UserAssessmentScore_assessment_id_fkey" FOREIGN KEY ("assessment_id") REFERENCES "SkillAssessment"("assessment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentScore" ADD CONSTRAINT "UserAssessmentScore_assessmentQuestionQuestion_id_fkey" FOREIGN KEY ("assessmentQuestionQuestion_id") REFERENCES "AssessmentQuestion"("question_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAssessmentScore" ADD CONSTRAINT "UserAssessmentScore_assessmentAnswerAnswer_id_fkey" FOREIGN KEY ("assessmentAnswerAnswer_id") REFERENCES "AssessmentAnswer"("answer_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatureUsage" ADD CONSTRAINT "FeatureUsage_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CV" ADD CONSTRAINT "CV_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentTransaction" ADD CONSTRAINT "PaymentTransaction_subscription_id_fkey" FOREIGN KEY ("subscription_id") REFERENCES "Subscription"("subscription_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentTransaction" ADD CONSTRAINT "PaymentTransaction_subscription_type_id_fkey" FOREIGN KEY ("subscription_type_id") REFERENCES "SubscriptionType"("subs_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentTransaction" ADD CONSTRAINT "PaymentTransaction_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserCompanies" ADD CONSTRAINT "_UserCompanies_A_fkey" FOREIGN KEY ("A") REFERENCES "Company"("company_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserCompanies" ADD CONSTRAINT "_UserCompanies_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

