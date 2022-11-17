Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D4C4332F
	for <selinux@archiver.kernel.org>; Thu, 17 Nov 2022 21:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiKQV2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQV2j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Nov 2022 16:28:39 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F613F88
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 13:28:35 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k19so4445616lji.2
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqX8oPcXf2MNrF0+ihQD07g8LXGTy7vr13WPLqrItt0=;
        b=Lv0Elg82xR6vL+FkIYs48VRqYSMv8ry6UkOkbvaZiZfvUB+NPEoK1Jfifn9TqFMXOA
         jV1UOBWcHKcQ6argTMGKXP0Kyh0yGMW/5yVir7ooRffGP5U3mq4iBaFaanScEzfKDWtd
         wNaFW4xxN7Vb4ENCW+e6J3Or8tvNgB3LOXIWmJzLoIHR3mLjdJFdXhFAtno5kov3TH9f
         7dwttIxEg3c1XqJiMGSN3Xb7yQ7/Sq0Ij7weRPc0hSQ86o8bzJyfCvHVTlrSee/ZtrCk
         EuLlFi9CzxWGWGIRDd2Rhqy9mIy2fJ2o8BKdiaZOEc6dMYU+L2qicSxk8xh+FS1oU2QQ
         JfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqX8oPcXf2MNrF0+ihQD07g8LXGTy7vr13WPLqrItt0=;
        b=rbtWAyZUve7z3TjJZnA4Nnhd+uNXpDdmnLb8h6IWvyw404PtNeW3Y/tIlq3Opnw4bI
         b27unqXRBNLi3h1kL+lgzl2zMoTDWly2Jb1lTJJCR+lcfe2gWcgpql2rRjtBoA3bUVzR
         OIxZ+TYFuKqFsI0gSt1mlOPJohTERh6C2TvBGrO5RNzSy0jgVoW0FQH2qLPb073y/OS1
         NsdU9Es9xbuP+vO7HcE+USnCvkvhyD3hzCwrJwMqrWT0Zxp5362kAigA9MFZoGuEgqgb
         TVbCZLxSLpeDlWvIL0SI8juxt8VcGJobrEURQ3oghmF7a+XXAVvbBPuggbKvHorm91Rs
         hR0Q==
X-Gm-Message-State: ANoB5pmeRfwQzFCijVdqWuXYJ2mVSMY8wMYZPqfOBMtwiGqVEEtv4lAN
        e7N/KBuNlGr17yQlJlWL5CV3Efd/aQJJBIEJgZw=
X-Google-Smtp-Source: AA0mqf4KeRVuH2G915ryW9FQKgMdJ+stg2SJK4ZIQ/Udlbb7dM0Vfycaa9O/nGgz/Btyijp4YFrr57r/AzX/r9jO+mo=
X-Received: by 2002:a2e:a806:0:b0:277:4b35:d94a with SMTP id
 l6-20020a2ea806000000b002774b35d94amr1549870ljq.21.1668720513681; Thu, 17 Nov
 2022 13:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20221114194031.12245-1-cgzones@googlemail.com> <20221114194031.12245-2-cgzones@googlemail.com>
In-Reply-To: <20221114194031.12245-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 17 Nov 2022 16:28:22 -0500
Message-ID: <CAP+JOzTXfFq_Rn+oiH8A0wkmrocLF_XkauxLL8CXez5vZMxHbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol/tests: add tests for neverallow assertions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 14, 2022 at 2:42 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add tests for neverallow assertion checks.
> This creates a foundation for the status quo, and enables to spot
> regressions in future changes to the - quite complex - assertion logic.
> One example is the support for not-self rules.
>

Thanks for doing this. It is a great start. Eventually I will look
back at the fixes I did at the beginning of the year and add some more
tests based on that. I remember that it had something to do with how
attributes and self interacted. I haven't given up on the not-self
stuff, I just have been busy with other things.
Jim

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/tests/libsepol-tests.c               |   2 +
>  .../policies/test-neverallow/policy.conf      | 298 ++++++++++++++++++
>  libsepol/tests/test-neverallow.c              | 172 ++++++++++
>  libsepol/tests/test-neverallow.h              |  10 +
>  4 files changed, 482 insertions(+)
>  create mode 100644 libsepol/tests/policies/test-neverallow/policy.conf
>  create mode 100644 libsepol/tests/test-neverallow.c
>  create mode 100644 libsepol/tests/test-neverallow.h
>
> diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-te=
sts.c
> index 5ae6bedc..968e3cc2 100644
> --- a/libsepol/tests/libsepol-tests.c
> +++ b/libsepol/tests/libsepol-tests.c
> @@ -24,6 +24,7 @@
>  #include "test-expander.h"
>  #include "test-deps.h"
>  #include "test-downgrade.h"
> +#include "test-neverallow.h"
>
>  #include <CUnit/Basic.h>
>  #include <CUnit/Console.h>
> @@ -71,6 +72,7 @@ static bool do_tests(int interactive, int verbose)
>         DECLARE_SUITE(expander);
>         DECLARE_SUITE(deps);
>         DECLARE_SUITE(downgrade);
> +       DECLARE_SUITE(neverallow);
>
>         if (verbose)
>                 CU_basic_set_mode(CU_BRM_VERBOSE);
> diff --git a/libsepol/tests/policies/test-neverallow/policy.conf b/libsep=
ol/tests/policies/test-neverallow/policy.conf
> new file mode 100644
> index 00000000..67a16372
> --- /dev/null
> +++ b/libsepol/tests/policies/test-neverallow/policy.conf
> @@ -0,0 +1,298 @@
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file
> +
> +sid kernel
> +sid security
> +sid unlabeled
> +sid file
> +sid port
> +sid netif
> +sid netmsg
> +sid node
> +sid devnull
> +
> +class process { dyntransition transition }
> +class file { getattr ioctl open read write }
> +
> +ifdef(`enable_mls',`
> +sensitivity s0;
> +dominance { s0 }
> +category c0; category c1; category c2; category c3;
> +category c4; category c5; category c6; category c7;
> +category c8; category c9; category c10; category c11;
> +category c12; category c13; category c14; category c15;
> +category c16; category c17; category c18; category c19;
> +category c20; category c21; category c22; category c23;
> +
> +level s0:c0.c23;
> +
> +mlsconstrain file { write } ( h1 dom h2 );
> +')
> +
> +
> +########################################
> +#
> +# Test start
> +#
> +########################################
> +
> +
> +## Test 1 (basic)
> +
> +type test1_t;
> +allow      test1_t test1_t : file { read write };
> +neverallow test1_t test1_t : file read;
> +
> +
> +## Test 2 (wildcard permission)
> +
> +type test2_t;
> +allow      test2_t test2_t : file { read write };
> +neverallow test2_t test2_t : file *;
> +
> +
> +## Test 3 (complement permission)
> +
> +type test3_t;
> +allow      test3_t test3_t : file { read write };
> +neverallow test3_t test3_t : file ~{ write };
> +
> +
> +## Test 4 (wildcard source)
> +
> +type test4_t;
> +allow      test4_t test4_t : file { read write };
> +neverallow *       test4_t : file read;
> +
> +
> +## Test 5 (wildcard target)
> +
> +type test5_t;
> +allow      test5_t test5_t : file { read write };
> +neverallow test5_t *       : file read;
> +
> +
> +## Test 6 (complement source)
> +
> +type test6_1_t;
> +type test6_2_t;
> +allow      { test6_1_t test6_2_t } { test6_1_t test6_2_t } : file { read=
 write };
> +neverallow ~{ test6_2_t }          test6_1_t               : file read;
> +
> +
> +## Test 7 (complement target)
> +
> +type test7_1_t;
> +type test7_2_t;
> +allow      { test7_1_t test7_2_t } { test7_1_t test7_2_t } : file { read=
 write };
> +neverallow test7_1_t               ~{ test7_2_t }          : file read;
> +
> +
> +## Test 8 (source attribute)
> +
> +attribute test8_a;
> +type test8_t, test8_a;
> +allow      test8_a test8_a : file read;
> +allow      test8_t test8_t : file write;
> +neverallow test8_a test8_t : file { read write };
> +
> +
> +## Test 9 (target attribute)
> +
> +attribute test9_a;
> +type test9_t, test9_a;
> +allow      test9_a test9_a : file read;
> +allow      test9_t test9_t : file write;
> +neverallow test9_t test9_a : file { read write };
> +
> +
> +## Test 10 (self)
> +
> +attribute test10_a;
> +type test10_1_t, test10_a;
> +type test10_2_t;
> +allow      { test10_1_t test10_2_t } { test10_1_t test10_2_t } : file re=
ad;
> +neverallow test10_a                  self                      : file *;
> +
> +
> +## Test 11 (wildcard)
> +
> +type test11_t;
> +allow      test11_t self : process *;
> +neverallow *        *    : process *;
> +
> +
> +## Test 12 (complement attributes)
> +
> +attribute test12_1_a;
> +attribute test12_2_a;
> +attribute test12_3_a;
> +type test12_1_t, test12_1_a;
> +type test12_2_t, test12_2_a;
> +type test12_3_t, test12_3_a;
> +allow     { test12_1_a test12_2_a test12_3_a } { test12_1_a test12_2_a t=
est12_3_a } : file *;
> +neverallow ~{ test12_1_a test12_2_t }          ~{ test12_3_a }          =
            : file getattr;
> +neverallow ~{ test12_1_a }                     ~{ test12_2_a test12_3_t =
}           : file open;
> +
> +
> +## Test 13 (excludes)
> +
> +attribute test13_1_a;
> +attribute test13_2_a;
> +attribute test13_3_a;
> +type test13_1_t, test13_1_a;
> +type test13_2_t, test13_2_a;
> +type test13_3_t, test13_3_a;
> +allow      { test13_1_a test13_2_a test13_3_a }                         =
{ test13_1_a test13_2_a test13_3_a }                         : file { read =
write };
> +neverallow { test13_1_a test13_2_a test13_3_a -test13_2_a -test13_3_t } =
{ test13_1_a test13_2_a test13_3_a -test13_2_t -test13_3_a } : file read;
> +
> +
> +## Test 14 (misc avrules)
> +
> +type test14_t;
> +auditallow      test14_t test14_t : file read;
> +dontaudit       test14_t test14_t : file write;
> +neverallow      test14_t test14_t : file { read write };
> +type_transition test14_t test14_t : file test14_t;
> +type_transition test14_t test14_t : file test14_t "objname";
> +neverallow      test14_t test14_t : file *;  # nofail
> +
> +
> +## Test 15 (extended permissions - standard allow)
> +
> +type test15_t;
> +allow           test15_t self : file ioctl;
> +neverallowxperm test15_t self : file ioctl 0x1111;
> +
> +
> +## Test 16 (extended permissions - allowxperm)
> +
> +type test16_t;
> +allow           test16_t self : file ioctl;
> +allowxperm      test16_t self : file ioctl 0x1111;
> +neverallowxperm test16_t self : file ioctl 0x1111;
> +
> +
> +## Test 17 (extended permissions - allowxperm mismatch)
> +
> +type test17_t;
> +allow           test17_t self : file ioctl;
> +allowxperm      test17_t self : file ioctl 0x1111;
> +neverallowxperm test17_t self : file ioctl 0x2222;  # nofail
> +
> +
> +## Test 18 (extended permissions - allowxperm range I)
> +
> +type test18_t;
> +allow           test18_t self : file ioctl;
> +allowxperm      test18_t self : file ioctl { 0x1100-0x1300 };
> +neverallowxperm test18_t self : file ioctl 0x1111;
> +
> +
> +## Test 19 (extended permissions - allowxperm range II)
> +
> +type test19_t;
> +allow           test19_t self : file ioctl;
> +allowxperm      test19_t self : file ioctl 0x1111;
> +neverallowxperm test19_t self : file ioctl { 0x1100-0x1300 };
> +
> +
> +## Test 20 (extended permissions - misc targets I)
> +
> +attribute test20_a;
> +type test20_t, test20_a;
> +
> +allow           test20_a test20_a : file ioctl;
> +allowxperm      test20_a test20_a : file ioctl 0x1111;
> +neverallowxperm test20_a self     : file ioctl 0x1111;
> +
> +
> +## Test 21 (extended permissions - misc targets II)
> +
> +attribute test21_1_a;
> +attribute test21_2_a;
> +type test21_t, test21_1_a, test21_2_a;
> +
> +allow           test21_1_a test21_1_a : file ioctl;
> +allowxperm      test21_1_a test21_2_a : file ioctl 0x1111;
> +neverallowxperm test21_1_a self       : file ioctl 0x1111;
> +
> +
> +## Test 22 (extended permissions - misc targets III)
> +
> +attribute test22_a;
> +type test22_t, test22_a;
> +
> +allow           test22_a test22_a : file ioctl;
> +allowxperm      test22_t self     : file ioctl 0x1111;
> +neverallowxperm test22_a self     : file ioctl 0x1111;
> +
> +
> +## Test 23 (extended permissions - misc targets IV)
> +
> +attribute test23_a;
> +type test23_t, test23_a;
> +
> +allow           test23_a test23_a : file ioctl;
> +allowxperm      test23_t test23_t : file ioctl 0x1111;
> +neverallowxperm test23_a self     : file ioctl 0x1111;
> +
> +
> +## Test 24 (extended permissions - misc targets V)
> +
> +attribute test24_a;
> +type test24_t, test24_a;
> +
> +allow           test24_a test24_a : file ioctl;
> +allowxperm      test24_t test24_a : file ioctl 0x1111;
> +neverallowxperm test24_a self     : file ioctl 0x1111;
> +
> +
> +## Test 25 (extended permissions - misc targets VI)
> +
> +attribute test25_a;
> +type test25_t, test25_a;
> +
> +allow           test25_a test25_a : file ioctl;
> +allowxperm      test25_a self     : file ioctl 0x1111;
> +neverallowxperm test25_a self     : file ioctl 0x1111;
> +
> +
> +## Test 26 (extended permissions - assert twice)
> +
> +attribute test26_a;
> +type test26_1_t, test26_a;
> +type test26_2_t, test26_a;
> +allow           test26_a   test26_a : file ioctl;
> +allowxperm      test26_a   test26_a : file ioctl 0x1111;
> +neverallowxperm test26_1_t test26_a : file ioctl 0x1111;
> +
> +
> +########################################
> +#
> +# Test End
> +#
> +########################################
> +
> +
> +type sys_isid;
> +role sys_role;
> +role sys_role types sys_isid;
> +gen_user(sys_user,, sys_role, s0, s0 - s0:c0.c23)
> +sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
> +sid security gen_context(sys_user:sys_role:sys_isid, s0)
> +sid unlabeled gen_context(sys_user:sys_role:sys_isid, s0)
> +sid file gen_context(sys_user:sys_role:sys_isid, s0)
> +sid port gen_context(sys_user:sys_role:sys_isid, s0)
> +sid netif gen_context(sys_user:sys_role:sys_isid, s0)
> +sid netmsg gen_context(sys_user:sys_role:sys_isid, s0)
> +sid node gen_context(sys_user:sys_role:sys_isid, s0)
> +sid devnull gen_context(sys_user:sys_role:sys_isid, s0)
> +fs_use_trans devpts gen_context(sys_user:sys_role:sys_isid, s0);
> +fs_use_trans devtmpfs gen_context(sys_user:sys_role:sys_isid, s0);
> diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-never=
allow.c
> new file mode 100644
> index 00000000..d973a0e3
> --- /dev/null
> +++ b/libsepol/tests/test-neverallow.c
> @@ -0,0 +1,172 @@
> +#define _GNU_SOURCE  /* vasprintf(3) */
> +
> +#include "test-neverallow.h"
> +
> +#include "helpers.h"
> +#include "test-common.h"
> +
> +#include <sepol/debug.h>
> +#include <sepol/policydb/link.h>
> +#include <sepol/policydb/expand.h>
> +
> +#include <stdio.h>
> +#include <stdarg.h>
> +
> +extern int mls;
> +
> +int neverallow_test_init(void)
> +{
> +       return 0;
> +}
> +
> +int neverallow_test_cleanup(void)
> +{
> +       return 0;
> +}
> +
> +static struct msg_list {
> +       char *msg;
> +       struct msg_list *next;
> +} *messages;
> +
> +static void messages_clean(void)
> +{
> +       while (messages) {
> +               struct msg_list *n =3D messages->next;
> +               free(messages->msg);
> +               free(messages);
> +               messages =3D n;
> +       }
> +}
> +
> +static void messages_check(unsigned count, const char *const expected[co=
unt])
> +{
> +       unsigned i;
> +       const struct msg_list *m =3D messages;
> +
> +       for (i =3D 0; i < count; i++, m =3D m->next) {
> +               if (!m) {
> +                       CU_FAIL("less messages than expected");
> +                       fprintf(stderr, "\n<expected %u, got %u>\n", coun=
t, i);
> +                       return;
> +               }
> +
> +               if (strcmp(expected[i], m->msg) !=3D 0) {
> +                       CU_FAIL("messages differ from expected");
> +                       fprintf(stderr, "\n<expected: '''%s''', got: '''%=
s'''>\n", expected[i], m->msg);
> +               }
> +       }
> +
> +       if (m) {
> +               CU_FAIL("more messages than expected");
> +               fprintf(stderr, "\n<expected %u; next message: '''%s'''>\=
n", count, m->msg);
> +       }
> +}
> +
> +__attribute__ ((format(printf, 3, 4)))
> +static void msg_handler(void *varg __attribute__ ((unused)),
> +                       sepol_handle_t * handle __attribute__ ((unused)),
> +                       const char *fmt, ...)
> +{
> +       char *msg;
> +       va_list ap;
> +       int r;
> +
> +       va_start(ap, fmt);
> +       r =3D vasprintf(&msg, fmt, ap);
> +       if (r < 0)
> +               CU_FAIL_FATAL("oom");
> +       va_end(ap);
> +
> +       struct msg_list *new =3D malloc(sizeof(*new));
> +       if (!new)
> +               CU_FAIL_FATAL("oom");
> +       new->msg =3D msg;
> +       new->next =3D messages;
> +       messages =3D new;
> +}
> +
> +#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*a))
> +
> +static void test_neverallow_basic(void)
> +{
> +       policydb_t basemod, base_expanded;
> +       sepol_handle_t *handle;
> +       static const char *const expected_messages[] =3D {
> +               "30 neverallow failures occurred",
> +               "neverallow on line 53 of policies/test-neverallow/policy=
.conf.std (or line 53 of policies/test-neverallow/policy.conf.std) violated=
 by allow test1_t test1_t:file { read };",
> +               "neverallow on line 60 of policies/test-neverallow/policy=
.conf.std (or line 60 of policies/test-neverallow/policy.conf.std) violated=
 by allow test2_t test2_t:file { read write };",
> +               "neverallow on line 67 of policies/test-neverallow/policy=
.conf.std (or line 67 of policies/test-neverallow/policy.conf.std) violated=
 by allow test3_t test3_t:file { read };",
> +               "neverallow on line 74 of policies/test-neverallow/policy=
.conf.std (or line 74 of policies/test-neverallow/policy.conf.std) violated=
 by allow test4_t test4_t:file { read };",
> +               "neverallow on line 81 of policies/test-neverallow/policy=
.conf.std (or line 81 of policies/test-neverallow/policy.conf.std) violated=
 by allow test5_t test5_t:file { read };",
> +               "neverallow on line 89 of policies/test-neverallow/policy=
.conf.std (or line 89 of policies/test-neverallow/policy.conf.std) violated=
 by allow test6_1_t test6_1_t:file { read };",
> +               "neverallow on line 97 of policies/test-neverallow/policy=
.conf.std (or line 97 of policies/test-neverallow/policy.conf.std) violated=
 by allow test7_1_t test7_1_t:file { read };",
> +               "neverallow on line 106 of policies/test-neverallow/polic=
y.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test8_t test8_t:file { write };",
> +               "neverallow on line 106 of policies/test-neverallow/polic=
y.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test8_t test8_t:file { read };",
> +               "neverallow on line 115 of policies/test-neverallow/polic=
y.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test9_t test9_t:file { read };",
> +               "neverallow on line 115 of policies/test-neverallow/polic=
y.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test9_t test9_t:file { write };",
> +               "neverallow on line 124 of policies/test-neverallow/polic=
y.conf.std (or line 124 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test10_1_t test10_1_t:file { read };",
> +               "neverallow on line 131 of policies/test-neverallow/polic=
y.conf.std (or line 131 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test11_t test11_t:process { dyntransition transition };",
> +               "neverallow on line 143 of policies/test-neverallow/polic=
y.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test12_3_t test12_1_t:file { getattr };",
> +               "neverallow on line 143 of policies/test-neverallow/polic=
y.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test12_3_t test12_2_t:file { getattr };",
> +               "neverallow on line 144 of policies/test-neverallow/polic=
y.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test12_3_t test12_1_t:file { open };",
> +               "neverallow on line 144 of policies/test-neverallow/polic=
y.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test12_2_t test12_1_t:file { open };",
> +               "neverallow on line 156 of policies/test-neverallow/polic=
y.conf.std (or line 156 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test13_1_t test13_1_t:file { read };",
> +               "neverallowxperm on line 174 of policies/test-neverallow/=
policy.conf.std (or line 174 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallow test15_t test15_t:file { ioctl };",
> +               "neverallowxperm on line 182 of policies/test-neverallow/=
policy.conf.std (or line 182 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test16_t test16_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 198 of policies/test-neverallow/=
policy.conf.std (or line 198 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test18_t test18_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 206 of policies/test-neverallow/=
policy.conf.std (or line 206 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test19_t test19_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 216 of policies/test-neverallow/=
policy.conf.std (or line 216 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test20_a test20_a:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 227 of policies/test-neverallow/=
policy.conf.std (or line 227 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test21_1_a test21_2_a:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 237 of policies/test-neverallow/=
policy.conf.std (or line 237 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test22_t test22_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 247 of policies/test-neverallow/=
policy.conf.std (or line 247 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test23_t test23_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 257 of policies/test-neverallow/=
policy.conf.std (or line 257 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test24_t test24_a:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 267 of policies/test-neverallow/=
policy.conf.std (or line 267 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test25_t test25_t:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 277 of policies/test-neverallow/=
policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
> +               "neverallowxperm on line 277 of policies/test-neverallow/=
policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) v=
iolated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
> +       };
> +
> +       if (policydb_init(&base_expanded))
> +               CU_FAIL_FATAL("Failed to initialize policy");
> +
> +       if (test_load_policy(&basemod, POLICY_BASE, mls, "test-neverallow=
", "policy.conf"))
> +               CU_FAIL_FATAL("Failed to load policy");
> +
> +       if (link_modules(NULL, &basemod, NULL, 0, 0))
> +               CU_FAIL_FATAL("Failed to link base module");
> +
> +       if (expand_module(NULL, &basemod, &base_expanded, 0, 0))
> +               CU_FAIL_FATAL("Failed to expand policy");
> +
> +       if ((handle =3D sepol_handle_create()) =3D=3D NULL)
> +               CU_FAIL_FATAL("Failed to initialize handle");
> +
> +       sepol_msg_set_callback(handle, msg_handler, NULL);
> +
> +       if (check_assertions(handle, &base_expanded, base_expanded.global=
->branch_list->avrules) !=3D -1)
> +               CU_FAIL("Assertions did not trigger");
> +
> +       messages_check(ARRAY_SIZE(expected_messages), expected_messages);
> +
> +       sepol_handle_destroy(handle);
> +       messages_clean();
> +       policydb_destroy(&basemod);
> +       policydb_destroy(&base_expanded);
> +}
> +
> +int neverallow_add_tests(CU_pSuite suite)
> +{
> +       /*
> +        * neverallow rules operate only on types and are unaffected by M=
LS
> +        * (avoid adjusting the messages for std and mls)
> +        */
> +       if (mls)
> +               return 0;
> +
> +       if (NULL =3D=3D CU_add_test(suite, "neverallow_basic", test_never=
allow_basic)) {
> +               CU_cleanup_registry();
> +               return CU_get_error();
> +       }
> +
> +       return 0;
> +}
> diff --git a/libsepol/tests/test-neverallow.h b/libsepol/tests/test-never=
allow.h
> new file mode 100644
> index 00000000..d3c2a74e
> --- /dev/null
> +++ b/libsepol/tests/test-neverallow.h
> @@ -0,0 +1,10 @@
> +#ifndef TEST_NEVERALLOW_H__
> +#define TEST_NEVERALLOW_H__
> +
> +#include <CUnit/Basic.h>
> +
> +int neverallow_test_init(void);
> +int neverallow_test_cleanup(void);
> +int neverallow_add_tests(CU_pSuite suite);
> +
> +#endif  /* TEST_NEVERALLOW_H__ */
> --
> 2.38.1
>
