import { Controller, Post, Get, Body } from '@nestjs/common';
import { AccountService } from 'src/services/account.service';
import {
  AddAccountDto,
  LoginDto,
  UpdatePasswordDto,
  ShowAccountDto,
  DeleteAccountDto,
} from 'src/dtos/account.dto';

@Controller('account')
export class AccountController {
  constructor(private readonly accountService: AccountService) {}

  @Post('login')
  async login(@Body() loginDto: LoginDto) {
    return this.accountService.login(loginDto);
  }

  @Post('add')
  async addAccount(@Body() addAccountDto: AddAccountDto) {
    return this.accountService.addAccount(addAccountDto);
  }

  @Get('show')
  async showAccount(@Body() showAccountDto: ShowAccountDto) {
    return this.accountService.showAccount(showAccountDto);
  }

  @Get('show-all')
  async showAllAccounts() {
    return this.accountService.showAllAccounts();
  }

  @Post('update-password')
  async updatePassword(@Body() updatePasswordDto: UpdatePasswordDto) {
    return this.accountService.updatePassword(updatePasswordDto);
  }

  @Post('delete')
  async deleteAccount(@Body() deleteAccountDto: DeleteAccountDto) {
    return this.accountService.deleteAccount(deleteAccountDto);
  }
}
