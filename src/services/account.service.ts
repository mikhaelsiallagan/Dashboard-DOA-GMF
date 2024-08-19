import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service'; // Assuming you have Prisma set up
import {
  AddAccountDto,
  LoginDto,
  UpdatePasswordDto,
  ShowAccountDto,
  DeleteAccountDto,
} from 'src/dtos/account.dto';
import { HelperService } from 'src/utils/hash.util';
//import { office_code, user_role } from '@prisma/client'; // Import the enum from Prisma

@Injectable()
export class AccountService {
  constructor(
    private prisma: PrismaService,
    private helperService: HelperService,
  ) {}

  async login(loginDto: LoginDto) {
    const { email, password } = loginDto;
    const user = await this.prisma.account.findUnique({ where: { email } });

    if (
      user &&
      (await this.helperService.comparePassword(password, user.password))
    ) {
      const userWithStringId = {
        ...user,
        accountid: user.accountid.toString(), // Convert BigInt to String
      };

      return {
        status: 200,
        message: 'Login successful',
        user: userWithStringId,
      };
    } else {
      return { status: 401, message: 'Email/Password is not correct' };
    }
  }

  async addAccount(addAccountDto: AddAccountDto) {
    const { name, unit, password, role, email } = addAccountDto;
    const hashedPassword = await this.helperService.hashPassword(password);

    try {
      // Check if email already exists
      const existingUser = await this.prisma.account.findUnique({
        where: { email },
      });

      if (existingUser) {
        return {
          status: 400,
          message: 'Email already exists',
        };
      }

      // Create new account
      const newUser = await this.prisma.account.create({
        data: {
          name,
          unit,
          password: hashedPassword,
          role,
          email,
        },
      });

      const userWithStringId = {
        ...newUser,
        accountid: newUser.accountid.toString(), // Convert BigInt to String
      };

      return {
        status: 200,
        message: 'Account created successfully',
        user: userWithStringId,
      };
    } catch (error) {
      console.error('Error creating account:', error);
      throw new Error('Error creating account');
    }
  }

  async updatePassword(updatePasswordDto: UpdatePasswordDto) {
    const { email, currentPass, newPass } = updatePasswordDto;
    const user = await this.prisma.account.findUnique({ where: { email } });
    if (
      user &&
      (await this.helperService.comparePassword(currentPass, user.password))
    ) {
      const hashedNewPass = await this.helperService.hashPassword(newPass);
      await this.prisma.account.update({
        where: { email },
        data: { password: hashedNewPass },
      });
      return { status: 200, message: 'Password updated successfully' };
    } else {
      return { status: 401, message: 'Current password is incorrect' };
    }
  }

  async showAccount(showAccountDto: ShowAccountDto) {
    const { accountid } = showAccountDto;
    const account = await this.prisma.account.findUnique({
      where: { accountid: BigInt(accountid) }, // Convert to BigInt if necessary
    });
    if (account) {
      return { status: 200, message: 'Account found', account };
    } else {
      return { status: 404, message: 'Account not found' };
    }
  }

  async showAllAccounts() {
    const accounts = await this.prisma.account.findMany();
    return {
      status: 200,
      message: 'Accounts retrieved successfully',
      accounts,
    };
  }

  async deleteAccount(deleteAccountDto: DeleteAccountDto) {
    const { email, password } = deleteAccountDto;
    const user = await this.prisma.account.findUnique({ where: { email } });
    if (
      user &&
      (await this.helperService.comparePassword(password, user.password))
    ) {
      await this.prisma.account.delete({ where: { email } });
      return { status: 200, message: 'Account deleted successfully' };
    } else {
      return { status: 401, message: 'Invalid email or password' };
    }
  }
}
