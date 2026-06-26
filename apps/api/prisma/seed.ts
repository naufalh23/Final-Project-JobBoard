import { PrismaClient } from '@prisma/client';
import { genSalt, hash } from 'bcrypt';

const prisma = new PrismaClient();

async function hashPassword(password: string) {
  return hash(password, await genSalt(10));
}

async function main() {
  const developerPassword = await hashPassword('Developer123!');
  const candidatePassword = await hashPassword('Candidate123!');
  const adminPassword = await hashPassword('Admin123!');

  const developer = await prisma.user.upsert({
    where: { email: 'developer@example.com' },
    update: {},
    create: {
      email: 'developer@example.com',
      password: developerPassword,
      role: 'developer',
      first_name: 'Dewi',
      last_name: 'Pratama',
      is_verified: true,
    },
  });

  const candidate = await prisma.user.upsert({
    where: { email: 'candidate@example.com' },
    update: {},
    create: {
      email: 'candidate@example.com',
      password: candidatePassword,
      role: 'candidate',
      first_name: 'Budi',
      last_name: 'Santoso',
      is_verified: true,
      country: 'ID',
      education: 'BACHELORS',
      gender: 'MALE',
    },
  });

  await prisma.user.upsert({
    where: { email: 'admin@example.com' },
    update: {},
    create: {
      email: 'admin@example.com',
      password: adminPassword,
      role: 'admin',
      first_name: 'Admin',
      last_name: 'Utama',
      is_verified: true,
    },
  });

  const company = await prisma.company.upsert({
    where: { email: 'hr@nusantaratech.com' },
    update: {},
    create: {
      company_name: 'Nusantara Tech',
      email: 'hr@nusantaratech.com',
      country: 'ID',
      IndustryType: 'TECHNOLOGY',
      aboutUs: 'A growing technology company based in Indonesia.',
      users: { connect: { user_id: developer.user_id } },
    },
  });

  // Job/SubscriptionType have no natural unique key besides their
  // autoincrement id, and hardcoding an explicit id here would desync
  // PostgreSQL's underlying SERIAL sequence (unlike MySQL's AUTO_INCREMENT,
  // it does not adjust itself when a value is inserted explicitly).
  // So we look the row up first and only create it if it's missing.
  let job = await prisma.job.findFirst({
    where: { job_title: 'Frontend Engineer', company_id: company.company_id },
  });
  if (!job) {
    job = await prisma.job.create({
      data: {
        job_title: 'Frontend Engineer',
        description: 'Build and maintain our Next.js job board frontend.',
        country: 'ID',
        location: 'Jakarta',
        salary: 12000000,
        jobType: 'fullTime',
        jobCategory: 'software_engineering',
        jobEducationLevel: 'bachelor_degree',
        jobExperience: 'mid_level',
        is_active: true,
        company_id: company.company_id,
        user_id: developer.user_id,
      },
    });
  }

  for (const subscriptionType of [
    {
      type: 'Standard',
      description: 'Access to CV generator and skill assessments.',
      price: 25000,
      features: ['cv_generator', 'skill_assessment'],
    },
    {
      type: 'Professional',
      description: 'Standard features plus priority support.',
      price: 100000,
      features: ['cv_generator', 'skill_assessment', 'priority_support'],
      is_recomend: true,
    },
  ]) {
    const exists = await prisma.subscriptionType.findFirst({
      where: { type: subscriptionType.type },
    });
    if (!exists) {
      await prisma.subscriptionType.create({ data: subscriptionType });
    }
  }

  await prisma.preSelectionTest.upsert({
    where: { job_id: job.job_id },
    update: {},
    create: {
      job_id: job.job_id,
      questions: {
        create: [
          {
            question_text: 'What does CSS stand for?',
            correct_answer: 1,
            options: {
              create: [
                { option_text: 'Cascading Style Sheets' },
                { option_text: 'Computer Style Sheets' },
                { option_text: 'Creative Style Sheets' },
              ],
            },
          },
        ],
      },
    },
  });

  const existingApplication = await prisma.application.findFirst({
    where: { job_id: job.job_id, user_id: candidate.user_id },
  });
  if (!existingApplication) {
    await prisma.application.create({
      data: {
        job_id: job.job_id,
        user_id: candidate.user_id,
        status: 'active',
        expected_salary: 12000000,
      },
    });
  }

  console.log('Seed data created:');
  console.log({ developer: developer.email, candidate: candidate.email, company: company.company_name });
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
