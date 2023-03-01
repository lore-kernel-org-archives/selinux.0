Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598FBC6FA9D
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 14:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAOd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAOd0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 09:33:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F599EB4E
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 06:33:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s26so54446508edw.11
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677681202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QNmTCpDmOZCnc2N2Y1G/WG7UpBdjgKpVcpE5nAImcU=;
        b=U2x3E8cD337bx5sWo5d7nOJiCsI5W2jpocK/+h6hxjRu4tREMaultMwuMdtG8VDxV3
         3oS85m1W45RXq33jFW8RJaasAP6JHpTDkkOttgFqQRBY63wLf/lV1HfX/aHe9gNy9jQr
         3w/dO6QQ3lpBRKy/7x0FgkhvKYv27SkVecMtocp8yyXAw8MjYIHTzR9++s91S52ljbmU
         qkW7YYKYNqWX2RBqOO2BUSbxI8u9DzxdIJtT9JBGwEIp570vqoqEwvTW1zlS8RkYkcmg
         yI6e1piLTBkF+BxDmgmFJFyEMuwpLNf5B4nVvGOM6PwSVT26RvWvKMUoeXucvmoGjL+W
         4n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QNmTCpDmOZCnc2N2Y1G/WG7UpBdjgKpVcpE5nAImcU=;
        b=o7jT0B9G56XtnebUlKyhYN80F8wPc3i7cz66E5kRodp4cXgQPuFUnEiTSUWLuvFQp5
         /GNLbEUECFKtnDpmsys4LaShX94Xnq54nhETc9AHSXZjAgMq9n7KjmHQi6UOrGx69/8x
         0IoP55uzf2gjl3gIG7yAeLm9gxY2tmDoeHfYCBEjJ4U6KuVtbXU3gbEvmB4wk94k+tOS
         +0ITKonAOw+IspNhIrl3SAS4k2F2F+r5AI5pfrI9g/70mh6+PuAb2uFKd8fY9gyiFrO3
         xq3ioNXhsNuevi5jvIQPOxN8yF0anLpdIRPV/8KaHrednjcfZ6Y/OZijxzh6182ZXtFM
         EW8Q==
X-Gm-Message-State: AO0yUKVQ8qW5UHYrnYlUlvEdLhtzl1LieFqM85u3MfuI62Xgw3oDzrJB
        uCibceUkiX2RXU2JjoseWE/QXPauEgAHD7LjF684dV8AvV0=
X-Google-Smtp-Source: AK7set95LtbUIeM/EzdQ4UHEXruMEbwk1gBlcQStWH9fZKs31qr+qDwO1EcA6MH48gDtIXXoPIQs11jY/iZUUwDSwsY=
X-Received: by 2002:a50:aad1:0:b0:4af:502b:4f13 with SMTP id
 r17-20020a50aad1000000b004af502b4f13mr4005262edc.4.1677681202045; Wed, 01 Mar
 2023 06:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com> <20221125154952.20910-5-cgzones@googlemail.com>
In-Reply-To: <20221125154952.20910-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Mar 2023 09:33:11 -0500
Message-ID: <CAP+JOzT_HuepSNahn=JiyYVCUbj=g6H=0m48iCY=Q8SxAeKiLw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/6] libsepol/tests: add tests for not self
 neverallow rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .../test-neverallow/policy_not_self.conf      | 370 ++++++++++++++++++
>  libsepol/tests/test-neverallow.c              |  75 ++++
>  2 files changed, 445 insertions(+)
>  create mode 100644 libsepol/tests/policies/test-neverallow/policy_not_se=
lf.conf
>
> diff --git a/libsepol/tests/policies/test-neverallow/policy_not_self.conf=
 b/libsepol/tests/policies/test-neverallow/policy_not_self.conf
> new file mode 100644
> index 00000000..da2cc69b
> --- /dev/null
> +++ b/libsepol/tests/policies/test-neverallow/policy_not_self.conf
> @@ -0,0 +1,370 @@
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file
> +
> +class class5
> +class class6
> +class class7
> +class class17
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
> +class file { ioctl read write }
> +
> +class class5 { perm }
> +class class6 { perm }
> +class class7 { perm }
> +class class17 { ioctl }
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
> +## Test 1 (single type)
> +
> +type test1_t;
> +allow      test1_t test1_t : file read;
> +neverallow test1_t ~self   : file read;  # nofail
> +
> +
> +## Test 2 (single type)
> +
> +type test2_t;
> +allow      test2_t self  : file read;
> +neverallow test2_t ~self : file read;  # nofail
> +
> +
> +## Test 3 (single type)
> +
> +type test3_1_t;
> +type test3_2_t;
> +allow      test3_1_t test3_2_t : file read;
> +neverallow test3_1_t ~self     : file read;
> +
> +
> +## Test 4 (two types I)
> +
> +type test4_1_t;
> +type test4_2_t;
> +allow      { test4_1_t test4_2_t } { test4_1_t test4_2_t } : file read;
> +neverallow test4_1_t               ~self                   : file read;
> +
> +
> +## Test 5 (two types II)
> +
> +type test5_1_t;
> +type test5_2_t;
> +allow      { test5_1_t test5_2_t } { test5_1_t test5_2_t } : class5 perm=
;
> +neverallow *                       ~self                   : class5 perm=
;
> +
> +
> +## Test 6 (two types III)
> +
> +type test6_1_t;
> +type test6_2_t;
> +allow      { test6_1_t test6_2_t } { test6_1_t test6_2_t } : class6 perm=
;
> +neverallow *                       ~{ self test6_1_t }     : class6 perm=
;
> +
> +
> +## Test 7 (two types IV)
> +
> +type test7_1_t;
> +type test7_2_t;
> +allow      { test7_1_t test7_2_t } { test7_1_t test7_2_t }       : class=
7 perm;
> +neverallow *                       ~{ self test7_1_t test7_2_t } : class=
7 perm; # nofail
> +
> +
> +## Test 8 (attribute violates type I)
> +
> +attribute test8_a;
> +type test8_1_t, test8_a;
> +type test8_2_t, test8_a;
> +allow      test8_a   test8_a : file read;
> +neverallow test8_1_t ~self   : file *;
> +
> +
> +## Test 9 (attribute violates type II)
> +
> +attribute test9_a;
> +type test9_1_t, test9_a;
> +type test9_2_t, test9_a;
> +allow      test9_1_t test9_a : file read;
> +neverallow test9_1_t ~self   : file *;
> +
> +
> +## Test 10 (attribute violates type III)
> +
> +attribute test10_1_a;
> +attribute test10_2_a;
> +type test10_1_t, test10_1_a, test10_1_a;
> +type test10_2_t, test10_1_a, test10_1_a;
> +allow      test10_1_a test10_1_a : file read;
> +neverallow test10_1_t ~self      : file *;
> +
> +
> +## Test 11 (attribute violates attribute I)
> +
> +attribute test11_1_a;
> +attribute test11_2_a;
> +type test11_1_t, test11_1_a, test11_2_a;
> +type test11_2_t, test11_1_a, test11_2_a;
> +allow      test11_1_t self       : file read;
> +allow      test11_2_t test11_2_t : file read;
> +neverallow test11_1_a ~self      : file *;  # nofail
> +
> +
> +## Test 12 (attribute violates attribute II)
> +
> +attribute test12_a;
> +type test12_1_t, test12_a;
> +type test12_2_t, test12_a;
> +allow      test12_1_t test12_2_t : file read;
> +neverallow test12_a   ~self      : file *;
> +
> +
> +## Test 13 (attribute violates attribute III)
> +
> +attribute test13_a;
> +type test13_1_t, test13_a;
> +type test13_2_t, test13_a;
> +allow      test13_1_t test13_a : file read;
> +neverallow test13_a   ~self    : file *;
> +
> +
> +## Test 14 (attribute violates attribute IV)
> +
> +attribute test14_a;
> +type test14_1_t, test14_a;
> +type test14_2_t, test14_a;
> +allow      test14_a test14_a : file read;
> +neverallow test14_a ~self    : file *;
> +
> +
> +## Test 15 (attribute violates attribute V)
> +
> +attribute test13_1_a;
> +attribute test13_2_a;
> +type test13_t, test13_1_a, test13_2_a;
> +allow      test13_1_a test13_2_a : file read;
> +neverallow test13_a   ~self      : file *;
> +
> +
> +## Test 16 (types violate attribute)
> +
> +attribute test16_a;
> +type test16_1_t, test16_a;
> +type test16_2_t, test16_a;
> +allow      { test16_1_t test16_2_t } { test16_1_t test16_2_t } : file re=
ad;
> +neverallow test16_a                  ~self                     : file ~w=
rite;
> +
> +
> +## Test 17 (extended permissions I)
> +
> +type test17_1_t;
> +type test17_2_t;
> +allow           { test17_1_t test17_2_t } { test17_1_t test17_2_t } : cl=
ass17 ioctl;
> +neverallowxperm ~test17_2_t               ~self                     : cl=
ass17 ioctl 0x1111;
> +
> +
> +## Test 18 (extended permissions II)
> +
> +type test18_1_t;
> +type test18_2_t;
> +allow           { test18_1_t test18_2_t } { test18_1_t test18_2_t } : fi=
le ioctl;
> +allowxperm      { test18_1_t test18_2_t } { test18_1_t test18_2_t } : fi=
le ioctl 0x1111;
> +neverallowxperm test18_1_t                ~self                     : fi=
le ioctl 0x2222;  # nofail
> +
> +
> +## Test 19 (extended permissions III)
> +
> +type test19_1_t;
> +type test19_2_t;
> +allow           { test19_1_t test19_2_t } { test19_1_t test19_2_t } : fi=
le ioctl;
> +allowxperm      { test19_1_t test19_2_t } { test19_1_t test19_2_t } : fi=
le ioctl { 0x0100 - 0x0102 };
> +neverallowxperm test19_2_t                ~self                     : fi=
le ioctl { 0x0101 - 0x0104 };
> +
> +
> +## Test 20 (extended permissions IV)
> +
> +type test20_1_t;
> +type test20_2_t;
> +allow           { test20_1_t test20_2_t } { test20_1_t test20_2_t } : fi=
le ioctl;
> +allowxperm      test20_1_t                test20_1_t                : fi=
le ioctl 0x0101;
> +allowxperm      test20_1_t                test20_2_t                : fi=
le ioctl 0x0102;
> +allowxperm      test20_2_t                test20_1_t                : fi=
le ioctl 0x0103;
> +allowxperm      test20_2_t                test20_2_t                : fi=
le ioctl 0x0104;
> +neverallowxperm { test20_1_t test20_2_t } ~self                     : fi=
le ioctl { 0x0000 - 0x9000 };
> +
> +
> +## Test 21 (extended permissions V)
> +
> +attribute test21_a;
> +type test21_1_t, test21_a;
> +type test21_2_t, test21_a;
> +allow           test21_a   test21_a : file ioctl;
> +allowxperm      test21_a   test21_a : file ioctl 0x9501;
> +neverallowxperm test21_1_t ~self    : file ioctl 0x9511;  # nofail
> +
> +
> +## Test 22 (extended permissions VI)
> +
> +type test22_t;
> +allow           test22_t self  : file ioctl;
> +allowxperm      test22_t self  : file ioctl 0x9501;
> +allowxperm      test22_t self  : file ioctl 0x9511;
> +neverallowxperm test22_t ~self : file ioctl 0x9511;  # nofail
> +
> +
> +## Test 23 (extended permissions VII)
> +
> +attribute test23_a;
> +type test23_1_t, test23_a;
> +type test23_2_t, test23_a;
> +allow           test23_a   test23_a   : file ioctl;
> +allowxperm      test23_a   test23_a   : file ioctl 0x9501;
> +allowxperm      test23_1_t test23_2_t : file ioctl 0x9511;
> +neverallowxperm test23_1_t ~self      : file ioctl 0x9511;
> +
> +
> +## Test 24 (extended permissions VII)
> +
> +attribute test24_a;
> +type test24_1_t, test24_a;
> +type test24_2_t, test24_a;
> +allow           test24_a   test24_a : file ioctl;
> +allowxperm      test24_a   test24_a : file ioctl 0x9501;
> +allowxperm      test24_1_t test24_a : file ioctl 0x9511;
> +neverallowxperm test24_1_t ~self    : file ioctl 0x9511;
> +
> +
> +## Test 25 (extended permissions IX)
> +
> +attribute test25_a;
> +type test25_1_t, test25_a;
> +type test25_2_t, test25_a;
> +allow           test25_a   test25_a : file ioctl;
> +allowxperm      test25_a   test25_a : file ioctl 0x9501;
> +allowxperm      test25_a   test25_a : file ioctl 0x9511;
> +neverallowxperm test25_1_t ~self    : file ioctl 0x9511;
> +
> +
> +## Test 26 (extended permissions X)
> +
> +attribute test26_1_a;
> +attribute test26_2_a;
> +type test26_1_t, test26_1_a, test26_2_a;
> +type test26_2_t, test26_1_a, test26_2_a;
> +allow           { test26_1_a test26_2_a } { test26_1_a test26_2_a } : fi=
le ioctl;
> +allowxperm      { test26_1_a test26_2_a } { test26_1_a test26_2_a } : fi=
le ioctl 0x9501;
> +allowxperm      test26_1_a                test26_2_a                : fi=
le ioctl 0x9511;
> +neverallowxperm test26_1_t                ~self                     : fi=
le ioctl 0x9511;
> +
> +
> +## Test 27 (extended permissions attribute violation I)
> +
> +attribute test27_a;
> +type test27_1_t, test27_a;
> +type test27_2_t, test27_a;
> +allow           test27_a   test27_a   : file ioctl;
> +allowxperm      test27_a   test27_a   : file ioctl 0x9501;
> +allowxperm      test27_1_t self       : file ioctl 0x9521;
> +allowxperm      test27_2_t test27_2_t : file ioctl 0x9521;
> +neverallowxperm test27_a   ~self      : file ioctl 0x9521;  # nofail
> +
> +
> +## Test 28 (extended permissions attribute violation II)
> +
> +attribute test28_a;
> +type test28_1_t, test28_a;
> +type test28_2_t, test28_a;
> +allow           test28_a   test28_a   : file ioctl;
> +allowxperm      test28_1_t test28_2_t : file ioctl 0x9521;
> +neverallowxperm test28_a   ~self      : file ioctl 0x9521;
> +
> +
> +## Test 29 (extended permissions attribute violation III)
> +
> +attribute test29_a;
> +type test29_1_t, test29_a;
> +type test29_2_t, test29_a;
> +allow           test29_a   test29_a : file ioctl;
> +allowxperm      test29_1_t test29_a : file ioctl 0x9521;
> +neverallowxperm test29_a   ~self    : file ioctl 0x9521;
> +
> +
> +## Test 30 (extended permissions attribute violation IV)
> +
> +attribute test30_a;
> +type test30_1_t, test30_a;
> +type test30_2_t, test30_a;
> +allow           test30_a test30_a : file ioctl;
> +allowxperm      test30_a test30_a : file ioctl 0x9521;
> +neverallowxperm test30_a ~self    : file ioctl 0x9521;
> +
> +
> +## Test 31 (extended permissions attribute violation V)
> +
> +attribute test31_1_a;
> +attribute test31_2_a;
> +type test31_1_t, test31_1_a, test31_2_a;
> +type test31_2_t, test31_1_a, test31_2_a;
> +allow           test31_1_a test31_1_a : file ioctl;
> +allowxperm      test31_1_a test31_2_a : file ioctl 0x9521;
> +neverallowxperm test31_1_a ~self      : file ioctl 0x9521;
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
> index d973a0e3..c6518ebb 100644
> --- a/libsepol/tests/test-neverallow.c
> +++ b/libsepol/tests/test-neverallow.c
> @@ -154,6 +154,76 @@ static void test_neverallow_basic(void)
>         policydb_destroy(&base_expanded);
>  }
>
> +static void test_neverallow_not_self(void)
> +{
> +       policydb_t basemod, base_expanded;
> +       sepol_handle_t *handle;
> +       static const char *const expected_messages[] =3D {
> +               "34 neverallow failures occurred",
> +               "neverallow on line 78 of policies/test-neverallow/policy=
_not_self.conf.std (or line 78 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test3_1_t test3_2_t:file { read };",
> +               "neverallow on line 86 of policies/test-neverallow/policy=
_not_self.conf.std (or line 86 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> +               "neverallow on line 94 of policies/test-neverallow/policy=
_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> +               "neverallow on line 94 of policies/test-neverallow/policy=
_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.=
conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> +               "neverallow on line 102 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 102 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
> +               "neverallow on line 119 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 119 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
> +               "neverallow on line 128 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 128 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
> +               "neverallow on line 138 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 138 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
> +               "neverallow on line 158 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 158 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
> +               "neverallow on line 167 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 167 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> +               "neverallow on line 176 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> +               "neverallow on line 176 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> +               "neverallow on line 185 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 185 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> +               "neverallow on line 194 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> +               "neverallow on line 194 of policies/test-neverallow/polic=
y_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> +               "neverallowxperm on line 202 of policies/test-neverallow/=
policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl }=
;",
> +               "neverallowxperm on line 220 of policies/test-neverallow/=
policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl {=
 0x101-0x102 };",
> +               "neverallowxperm on line 232 of policies/test-neverallow/=
policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl {=
 0x102 };",
> +               "neverallowxperm on line 232 of policies/test-neverallow/=
policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl {=
 0x103 };",
> +               "neverallowxperm on line 262 of policies/test-neverallow/=
policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl {=
 0x9511 };",
> +               "neverallowxperm on line 273 of policies/test-neverallow/=
policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0=
x9511 };",
> +               "neverallowxperm on line 284 of policies/test-neverallow/=
policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9=
511 };",
> +               "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
> +               "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
> +               "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
> +               "neverallowxperm on line 296 of policies/test-neverallow/=
policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl {=
 0x9511 };",
> +               "neverallowxperm on line 318 of policies/test-neverallow/=
policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl {=
 0x9521 };",
> +               "neverallowxperm on line 318 of policies/test-neverallow/=
policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
> +               "neverallowxperm on line 328 of policies/test-neverallow/=
policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0=
x9521 };",
> +               "neverallowxperm on line 328 of policies/test-neverallow/=
policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
> +               "neverallowxperm on line 338 of policies/test-neverallow/=
policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9=
521 };",
> +               "neverallowxperm on line 338 of policies/test-neverallow/=
policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9=
521 };",
> +               "neverallowxperm on line 349 of policies/test-neverallow/=
policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl {=
 0x9521 };",
> +               "neverallowxperm on line 349 of policies/test-neverallow/=
policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_no=
t_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl {=
 0x9521 };",
> +       };
> +
> +       if (policydb_init(&base_expanded))
> +               CU_FAIL_FATAL("Failed to initialize policy");
> +
> +       if (test_load_policy(&basemod, POLICY_BASE, mls, "test-neverallow=
", "policy_not_self.conf"))
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
>  int neverallow_add_tests(CU_pSuite suite)
>  {
>         /*
> @@ -168,5 +238,10 @@ int neverallow_add_tests(CU_pSuite suite)
>                 return CU_get_error();
>         }
>
> +       if (NULL =3D=3D CU_add_test(suite, "neverallow_not_self", test_ne=
verallow_not_self)) {
> +               CU_cleanup_registry();
> +               return CU_get_error();
> +       }
> +
>         return 0;
>  }
> --
> 2.38.1
>
