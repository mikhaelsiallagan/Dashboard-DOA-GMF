import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma.module';
import { HelperService } from './utils/hash.util';
import { AccountService } from './services/account.service';
import { AccountController } from './controllers/account.controller';

@Module({
  imports: [PrismaModule],
  controllers: [AppController, AccountController],
  providers: [AppService, AccountService, HelperService],
})
export class AppModule {}
