/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/david/ee201/FlappyFPGA/Flappy-Xilinx/X_RAM.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {2, 0};
static int ng4[] = {3, 0};
static int ng5[] = {4, 0};
static int ng6[] = {640, 0};
static int ng7[] = {240, 0};
static unsigned int ng8[] = {1U, 0U};



static void Always_45_0(char *t0)
{
    char t15[8];
    char t16[8];
    char t32[8];
    char t34[8];
    char t35[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t17;
    char *t18;
    int t19;
    char *t20;
    int t21;
    int t22;
    int t23;
    int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t33;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    unsigned int t46;
    char *t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;

LAB0:    t1 = (t0 + 4616U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(45, ng0);
    t2 = (t0 + 5184);
    *((int *)t2) = 1;
    t3 = (t0 + 4648);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(46, ng0);

LAB5:    t4 = (t0 + 280);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 4424);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(48, ng0);
    t6 = (t0 + 2344U);
    t7 = *((char **)t6);
    t6 = (t7 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 2504U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t8 = *((unsigned int *)t2);
    t9 = (~(t8));
    t10 = *((unsigned int *)t3);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB20;

LAB21:
LAB22:
LAB10:    t2 = (t0 + 280);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 4424);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(49, ng0);

LAB11:    xsi_set_current_line(50, ng0);
    t13 = ((char*)((ng1)));
    t14 = (t0 + 3384);
    xsi_vlogvar_wait_assign_value(t14, t13, 0, 0, 4, 0LL);
    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1064);
    t3 = *((char **)t2);
    t2 = (t0 + 3544);
    t4 = (t0 + 3544);
    t5 = (t4 + 72U);
    t6 = *((char **)t5);
    t7 = (t0 + 3544);
    t13 = (t7 + 64U);
    t14 = *((char **)t13);
    t17 = ((char*)((ng1)));
    xsi_vlog_generic_convert_array_indices(t15, t16, t6, t14, 2, 1, t17, 32, 1);
    t18 = (t15 + 4);
    t8 = *((unsigned int *)t18);
    t19 = (!(t8));
    t20 = (t16 + 4);
    t9 = *((unsigned int *)t20);
    t21 = (!(t9));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB12;

LAB13:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1200);
    t3 = *((char **)t2);
    t2 = (t0 + 3544);
    t4 = (t0 + 3544);
    t5 = (t4 + 72U);
    t6 = *((char **)t5);
    t7 = (t0 + 3544);
    t13 = (t7 + 64U);
    t14 = *((char **)t13);
    t17 = ((char*)((ng2)));
    xsi_vlog_generic_convert_array_indices(t15, t16, t6, t14, 2, 1, t17, 32, 1);
    t18 = (t15 + 4);
    t8 = *((unsigned int *)t18);
    t19 = (!(t8));
    t20 = (t16 + 4);
    t9 = *((unsigned int *)t20);
    t21 = (!(t9));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB14;

LAB15:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1336);
    t3 = *((char **)t2);
    t2 = (t0 + 3544);
    t4 = (t0 + 3544);
    t5 = (t4 + 72U);
    t6 = *((char **)t5);
    t7 = (t0 + 3544);
    t13 = (t7 + 64U);
    t14 = *((char **)t13);
    t17 = ((char*)((ng3)));
    xsi_vlog_generic_convert_array_indices(t15, t16, t6, t14, 2, 1, t17, 32, 1);
    t18 = (t15 + 4);
    t8 = *((unsigned int *)t18);
    t19 = (!(t8));
    t20 = (t16 + 4);
    t9 = *((unsigned int *)t20);
    t21 = (!(t9));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB16;

LAB17:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 1472);
    t3 = *((char **)t2);
    t2 = (t0 + 3544);
    t4 = (t0 + 3544);
    t5 = (t4 + 72U);
    t6 = *((char **)t5);
    t7 = (t0 + 3544);
    t13 = (t7 + 64U);
    t14 = *((char **)t13);
    t17 = ((char*)((ng4)));
    xsi_vlog_generic_convert_array_indices(t15, t16, t6, t14, 2, 1, t17, 32, 1);
    t18 = (t15 + 4);
    t8 = *((unsigned int *)t18);
    t19 = (!(t8));
    t20 = (t16 + 4);
    t9 = *((unsigned int *)t20);
    t21 = (!(t9));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB18;

LAB19:    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3224);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    goto LAB10;

LAB12:    t10 = *((unsigned int *)t15);
    t11 = *((unsigned int *)t16);
    t23 = (t10 - t11);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, *((unsigned int *)t16), t24, 0LL);
    goto LAB13;

LAB14:    t10 = *((unsigned int *)t15);
    t11 = *((unsigned int *)t16);
    t23 = (t10 - t11);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, *((unsigned int *)t16), t24, 0LL);
    goto LAB15;

LAB16:    t10 = *((unsigned int *)t15);
    t11 = *((unsigned int *)t16);
    t23 = (t10 - t11);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, *((unsigned int *)t16), t24, 0LL);
    goto LAB17;

LAB18:    t10 = *((unsigned int *)t15);
    t11 = *((unsigned int *)t16);
    t23 = (t10 - t11);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, *((unsigned int *)t16), t24, 0LL);
    goto LAB19;

LAB20:    xsi_set_current_line(58, ng0);

LAB23:    t4 = (t0 + 576);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB24);
    t5 = (t0 + 4424);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB25:    xsi_set_current_line(60, ng0);
    xsi_set_current_line(60, ng0);
    t6 = ((char*)((ng1)));
    t7 = (t0 + 3704);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);

LAB26:    t2 = (t0 + 3704);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng5)));
    memset(t15, 0, 8);
    xsi_vlog_signed_less(t15, 32, t4, 32, t5, 32);
    t6 = (t15 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t15);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 3544);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3544);
    t6 = (t5 + 72U);
    t7 = *((char **)t6);
    t13 = (t0 + 3544);
    t14 = (t13 + 64U);
    t17 = *((char **)t14);
    t18 = (t0 + 3224);
    t20 = (t18 + 56U);
    t25 = *((char **)t20);
    xsi_vlog_generic_get_array_select_value(t15, 32, t4, t7, t17, 2, 1, t25, 2, 2);
    t26 = ((char*)((ng7)));
    memset(t16, 0, 8);
    t27 = (t15 + 4);
    if (*((unsigned int *)t27) != 0)
        goto LAB43;

LAB42:    t28 = (t26 + 4);
    if (*((unsigned int *)t28) != 0)
        goto LAB43;

LAB46:    if (*((unsigned int *)t15) < *((unsigned int *)t26))
        goto LAB44;

LAB45:    t30 = (t16 + 4);
    t8 = *((unsigned int *)t30);
    t9 = (~(t8));
    t10 = *((unsigned int *)t16);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB47;

LAB48:
LAB49:    t2 = (t0 + 576);
    xsi_vlog_namedbase_popprocess(t2);

LAB24:    t3 = (t0 + 4424);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB22;

LAB27:    xsi_set_current_line(61, ng0);

LAB29:    xsi_set_current_line(62, ng0);
    t7 = (t0 + 3544);
    t13 = (t7 + 56U);
    t14 = *((char **)t13);
    t17 = (t0 + 3544);
    t18 = (t17 + 72U);
    t20 = *((char **)t18);
    t25 = (t0 + 3544);
    t26 = (t25 + 64U);
    t27 = *((char **)t26);
    t28 = (t0 + 3704);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    xsi_vlog_generic_get_array_select_value(t16, 32, t14, t20, t27, 2, 1, t30, 32, 1);
    t31 = ((char*)((ng2)));
    memset(t32, 0, 8);
    xsi_vlog_unsigned_minus(t32, 32, t16, 32, t31, 32);
    t33 = (t0 + 3544);
    t36 = (t0 + 3544);
    t37 = (t36 + 72U);
    t38 = *((char **)t37);
    t39 = (t0 + 3544);
    t40 = (t39 + 64U);
    t41 = *((char **)t40);
    t42 = (t0 + 3704);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    xsi_vlog_generic_convert_array_indices(t34, t35, t38, t41, 2, 1, t44, 32, 1);
    t45 = (t34 + 4);
    t46 = *((unsigned int *)t45);
    t19 = (!(t46));
    t47 = (t35 + 4);
    t48 = *((unsigned int *)t47);
    t21 = (!(t48));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB30;

LAB31:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 3544);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3544);
    t6 = (t5 + 72U);
    t7 = *((char **)t6);
    t13 = (t0 + 3544);
    t14 = (t13 + 64U);
    t17 = *((char **)t14);
    t18 = (t0 + 3704);
    t20 = (t18 + 56U);
    t25 = *((char **)t20);
    xsi_vlog_generic_get_array_select_value(t15, 32, t4, t7, t17, 2, 1, t25, 32, 1);
    t26 = ((char*)((ng1)));
    memset(t16, 0, 8);
    t27 = (t15 + 4);
    t28 = (t26 + 4);
    t8 = *((unsigned int *)t15);
    t9 = *((unsigned int *)t26);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t27);
    t12 = *((unsigned int *)t28);
    t46 = (t11 ^ t12);
    t48 = (t10 | t46);
    t49 = *((unsigned int *)t27);
    t50 = *((unsigned int *)t28);
    t51 = (t49 | t50);
    t52 = (~(t51));
    t53 = (t48 & t52);
    if (t53 != 0)
        goto LAB35;

LAB32:    if (t51 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t16) = 1;

LAB35:    t30 = (t16 + 4);
    t54 = *((unsigned int *)t30);
    t55 = (~(t54));
    t56 = *((unsigned int *)t16);
    t57 = (t56 & t55);
    t58 = (t57 != 0);
    if (t58 > 0)
        goto LAB36;

LAB37:
LAB38:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 3704);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t15, 0, 8);
    xsi_vlog_signed_add(t15, 32, t4, 32, t5, 32);
    t6 = (t0 + 3704);
    xsi_vlogvar_assign_value(t6, t15, 0, 0, 32);
    goto LAB26;

LAB30:    t49 = *((unsigned int *)t34);
    t50 = *((unsigned int *)t35);
    t23 = (t49 - t50);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t33, t32, 0, *((unsigned int *)t35), t24, 0LL);
    goto LAB31;

LAB34:    t29 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB35;

LAB36:    xsi_set_current_line(65, ng0);

LAB39:    xsi_set_current_line(66, ng0);
    t31 = ((char*)((ng6)));
    t33 = (t0 + 3544);
    t36 = (t0 + 3544);
    t37 = (t36 + 72U);
    t38 = *((char **)t37);
    t39 = (t0 + 3544);
    t40 = (t39 + 64U);
    t41 = *((char **)t40);
    t42 = (t0 + 3704);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    xsi_vlog_generic_convert_array_indices(t32, t34, t38, t41, 2, 1, t44, 32, 1);
    t45 = (t32 + 4);
    t59 = *((unsigned int *)t45);
    t19 = (!(t59));
    t47 = (t34 + 4);
    t60 = *((unsigned int *)t47);
    t21 = (!(t60));
    t22 = (t19 && t21);
    if (t22 == 1)
        goto LAB40;

LAB41:    goto LAB38;

LAB40:    t61 = *((unsigned int *)t32);
    t62 = *((unsigned int *)t34);
    t23 = (t61 - t62);
    t24 = (t23 + 1);
    xsi_vlogvar_wait_assign_value(t33, t31, 0, *((unsigned int *)t34), t24, 0LL);
    goto LAB41;

LAB43:    t29 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB45;

LAB44:    *((unsigned int *)t16) = 1;
    goto LAB45;

LAB47:    xsi_set_current_line(71, ng0);

LAB50:    xsi_set_current_line(72, ng0);
    t31 = (t0 + 3224);
    t33 = (t31 + 56U);
    t36 = *((char **)t33);
    t37 = ((char*)((ng4)));
    memset(t32, 0, 8);
    t38 = (t36 + 4);
    t39 = (t37 + 4);
    t46 = *((unsigned int *)t36);
    t48 = *((unsigned int *)t37);
    t49 = (t46 ^ t48);
    t50 = *((unsigned int *)t38);
    t51 = *((unsigned int *)t39);
    t52 = (t50 ^ t51);
    t53 = (t49 | t52);
    t54 = *((unsigned int *)t38);
    t55 = *((unsigned int *)t39);
    t56 = (t54 | t55);
    t57 = (~(t56));
    t58 = (t53 & t57);
    if (t58 != 0)
        goto LAB54;

LAB51:    if (t56 != 0)
        goto LAB53;

LAB52:    *((unsigned int *)t32) = 1;

LAB54:    t41 = (t32 + 4);
    t59 = *((unsigned int *)t41);
    t60 = (~(t59));
    t61 = *((unsigned int *)t32);
    t62 = (t61 & t60);
    t63 = (t62 != 0);
    if (t63 > 0)
        goto LAB55;

LAB56:    xsi_set_current_line(75, ng0);

LAB58:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 3224);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng8)));
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 2, t4, 2, t5, 2);
    t6 = (t0 + 3224);
    xsi_vlogvar_wait_assign_value(t6, t15, 0, 0, 2, 0LL);

LAB57:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 2664U);
    t3 = *((char **)t2);
    memset(t15, 0, 8);
    t2 = (t3 + 4);
    t8 = *((unsigned int *)t2);
    t9 = (~(t8));
    t10 = *((unsigned int *)t3);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB62;

LAB60:    if (*((unsigned int *)t2) == 0)
        goto LAB59;

LAB61:    t4 = (t15 + 4);
    *((unsigned int *)t15) = 1;
    *((unsigned int *)t4) = 1;

LAB62:    t5 = (t15 + 4);
    t6 = (t3 + 4);
    t46 = *((unsigned int *)t3);
    t48 = (~(t46));
    *((unsigned int *)t15) = t48;
    *((unsigned int *)t5) = 0;
    if (*((unsigned int *)t6) != 0)
        goto LAB64;

LAB63:    t53 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t53 & 1U);
    t54 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t54 & 1U);
    t7 = (t15 + 4);
    t55 = *((unsigned int *)t7);
    t56 = (~(t55));
    t57 = *((unsigned int *)t15);
    t58 = (t57 & t56);
    t59 = (t58 != 0);
    if (t59 > 0)
        goto LAB65;

LAB66:
LAB67:    goto LAB49;

LAB53:    t40 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB54;

LAB55:    xsi_set_current_line(73, ng0);
    t42 = ((char*)((ng1)));
    t43 = (t0 + 3224);
    xsi_vlogvar_wait_assign_value(t43, t42, 0, 0, 2, 0LL);
    goto LAB57;

LAB59:    *((unsigned int *)t15) = 1;
    goto LAB62;

LAB64:    t49 = *((unsigned int *)t15);
    t50 = *((unsigned int *)t6);
    *((unsigned int *)t15) = (t49 | t50);
    t51 = *((unsigned int *)t5);
    t52 = *((unsigned int *)t6);
    *((unsigned int *)t5) = (t51 | t52);
    goto LAB63;

LAB65:    xsi_set_current_line(78, ng0);
    t13 = (t0 + 3384);
    t14 = (t13 + 56U);
    t17 = *((char **)t14);
    t18 = ((char*)((ng2)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t17, 4, t18, 32);
    t20 = (t0 + 3384);
    xsi_vlogvar_wait_assign_value(t20, t16, 0, 0, 4, 0LL);
    goto LAB67;

}

static void Cont_84_1(char *t0)
{
    char t5[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;

LAB0:    t1 = (t0 + 4864U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 3544);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = (t0 + 3544);
    t7 = (t6 + 72U);
    t8 = *((char **)t7);
    t9 = (t0 + 3544);
    t10 = (t9 + 64U);
    t11 = *((char **)t10);
    t12 = (t0 + 3224);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    xsi_vlog_generic_get_array_select_value(t5, 10, t4, t8, t11, 2, 1, t14, 2, 2);
    t15 = (t0 + 5280);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t19, 0, 8);
    t20 = 1023U;
    t21 = t20;
    t22 = (t5 + 4);
    t23 = *((unsigned int *)t5);
    t20 = (t20 & t23);
    t24 = *((unsigned int *)t22);
    t21 = (t21 & t24);
    t25 = (t19 + 4);
    t26 = *((unsigned int *)t19);
    *((unsigned int *)t19) = (t26 | t20);
    t27 = *((unsigned int *)t25);
    *((unsigned int *)t25) = (t27 | t21);
    xsi_driver_vfirst_trans(t15, 0, 9);
    t28 = (t0 + 5200);
    *((int *)t28) = 1;

LAB1:    return;
}


extern void work_m_04599436002880948278_2806091913_init()
{
	static char *pe[] = {(void *)Always_45_0,(void *)Cont_84_1};
	xsi_register_didat("work_m_04599436002880948278_2806091913", "isim/X_RAM_tb_isim_beh.exe.sim/work/m_04599436002880948278_2806091913.didat");
	xsi_register_executes(pe);
}
