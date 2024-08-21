import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma.module';
import { HelperService } from './utils/hash.util';
import { AccountService } from './services/account.service';
import { AccountController } from './controllers/account.controller';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), PrismaModule, AuthModule],
  controllers: [AppController, AccountController],
  providers: [AppService, AccountService, HelperService],
})
export class AppModule {}
