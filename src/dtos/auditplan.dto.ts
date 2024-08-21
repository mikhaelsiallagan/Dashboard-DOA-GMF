import {
  IsNotEmpty,
  IsString,
  IsOptional,
  IsEnum,
  IsInt,
  IsDateString,
} from 'class-validator';
import { audittype } from '@prisma/client';

export class CreateAuditPlanDto {
  @IsNotEmpty()
  @IsInt()
  accountid: number;

  @IsNotEmpty()
  @IsDateString()
  docdate: string;

  @IsNotEmpty()
  @IsString()
  subject: string;

  @IsOptional()
  @IsEnum(audittype) // Replace with actual audit types
  audittype: audittype;
}

export class EditAuditPlanDto {
  @IsNotEmpty()
  @IsInt()
  docno: number;
}

export class UpdateAuditPlanDto {
  @IsNotEmpty()
  @IsInt()
  accountid: number;

  @IsNotEmpty()
  @IsDateString()
  docdate: string;

  @IsNotEmpty()
  @IsString()
  subject: string;

  @IsNotEmpty()
  @IsEnum(audittype) // Replace with actual audit types
  audittype: audittype;

  @IsNotEmpty()
  @IsInt()
  docno: number;
}
