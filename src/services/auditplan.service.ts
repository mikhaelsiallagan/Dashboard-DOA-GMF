import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import {
  CreateAuditPlanDto,
  EditAuditPlanDto,
  UpdateAuditPlanDto,
} from '../dtos/auditplan.dto';

@Injectable()
export class AuditPlanService {
  constructor(private prisma: PrismaService) {}

  async addAuditPlan(createAuditPlanDto: CreateAuditPlanDto) {
    const { accountid, docdate, subject, audittype } = createAuditPlanDto;
    return this.prisma.auditplan.create({
      data: {
        accountid,
        docdate: new Date(docdate),
        subject,
        audittype,
      },
    });
  }

  async editAuditPlan(editAuditPlanDto: EditAuditPlanDto) {
    const { docno } = editAuditPlanDto;
    return this.prisma.auditplan.delete({
      where: { docno },
    });
  }

  async updateAuditPlan(updateAuditPlanDto: UpdateAuditPlanDto) {
    const { accountid, docdate, subject, audittype, docno } =
      updateAuditPlanDto;
    return this.prisma.auditplan.update({
      where: { docno },
      data: {
        accountid,
        docdate: new Date(docdate),
        subject,
        audittype,
      },
    });
  }
}
