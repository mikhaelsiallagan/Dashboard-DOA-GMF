import { Controller, Post, Body, Put, Delete } from '@nestjs/common';
import { AuditPlanService } from '../services/auditplan.service';
import {
  CreateAuditPlanDto,
  EditAuditPlanDto,
  UpdateAuditPlanDto,
} from '../dtos/auditplan.dto';

@Controller('audit-plan')
export class AuditPlanController {
  constructor(private readonly auditPlanService: AuditPlanService) {}

  @Post('add')
  async addAuditPlan(@Body() createAuditPlanDto: CreateAuditPlanDto) {
    return this.auditPlanService.addAuditPlan(createAuditPlanDto);
  }

  @Delete('edit')
  async editAuditPlan(@Body() editAuditPlanDto: EditAuditPlanDto) {
    return this.auditPlanService.editAuditPlan(editAuditPlanDto);
  }

  @Put('update')
  async updateAuditPlan(@Body() updateAuditPlanDto: UpdateAuditPlanDto) {
    return this.auditPlanService.updateAuditPlan(updateAuditPlanDto);
  }
}
