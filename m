Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7300C7619A
	for <selinux@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjC3Tnn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3Tnm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Mar 2023 15:43:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C90EFAB
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:43:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so81118697eda.0
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680205418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZAbsSYr0CFd0yMVI+rRyqf3mPDWJRCdU2zqCOncKng=;
        b=XQUq+1z9Juzdwcc17UGMXylkVfMAVXksj8WQP87Vlo2XydUchfDoGK7ZxY5O9asV7i
         d5DcyemjaQDRRIIhU359NEmRKnntUAmTrQEfWfwlMX6zFVCYfIcewq1HmLRMUF6k+b4j
         IRw7Ln/Us56Ylhp8hIJl1JWGRNhpqQ172R//OTtmWK1RaMJB+v0FGMDTGT6pnAFtwgf3
         A+ADtgiY2bXaPuJ7tFp+igqEWwX4DhSLEORNxi4Q/UAjcmxrtLtx1ycx0vHH0x+DH0v0
         z9QVJeXXww7nbZ8/RrELnPKejXYi20fUztyySvfvQziD3x8x95snEatAsIh+j7PlKj4S
         7pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZAbsSYr0CFd0yMVI+rRyqf3mPDWJRCdU2zqCOncKng=;
        b=5W9p826qXc62UK0MQqyYsHFLuO4Mbsu/EVflnJrmEksS9TFDCVsSIysAml+oOXKuxS
         DyRIiJZDd+Aq5MxLSGNNfv/mLfBzZpVS8XfeCm13bnRSnfYUGXl0XX017jdwyPgZx/fj
         UI9/tkH6PORmlNDcEKmyrnbKsDxOmE97Sm88UyFn001m/lg+mnE4UO1q1UuS4aAvnY27
         8paoHxh+Rkcaqv5W6HLPfspT2F0Tf897OkLleawaK8Mhy8w7m7uAlpLHVqeTGmMjCbWP
         pTXNVxMnz46b7IZnxgVFIgzBKS3e6RrF9e91wV+PyaNUknTa6/RVUl2k/amU81m3f0bA
         mXkg==
X-Gm-Message-State: AAQBX9f4TnuooJ/TV7OFM5rrv6uI9mcVLdFJw2kLbSRbGEDfeCgaHMSD
        omopFO2kNWCe63421X0Whq/4iHHeNodfEM3ozoKuNINl
X-Google-Smtp-Source: AKy350ZcV9hQreX9/Zx5OA8KQq4ytWbkjB/1xcPk/vOZ0F5ixs0dwhNDS5+ozXFhEKcAPQJpp5Qk+IXD1JAcgO/lcrQ=
X-Received: by 2002:a17:906:6a93:b0:92d:591f:645f with SMTP id
 p19-20020a1709066a9300b0092d591f645fmr13118527ejr.5.1680205418530; Thu, 30
 Mar 2023 12:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com>
 <20221125154952.20910-6-cgzones@googlemail.com> <CAP+JOzQJt85TPLCuV2qz6S49C9E0EsRv3S-V3cpzdHEAvE4Gyw@mail.gmail.com>
In-Reply-To: <CAP+JOzQJt85TPLCuV2qz6S49C9E0EsRv3S-V3cpzdHEAvE4Gyw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Mar 2023 15:43:27 -0400
Message-ID: <CAP+JOzS8YfTShPg214v-xY=vkpST6d83LU_9BQgvxzLsGA2g2A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/6] libsepol/tests: add tests for minus self
 neverallow rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 9:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  .../test-neverallow/policy_minus_self.conf    | 369 ++++++++++++++++++
> >  libsepol/tests/test-neverallow.c              |  74 ++++
> >  2 files changed, 443 insertions(+)
> >  create mode 100644 libsepol/tests/policies/test-neverallow/policy_minu=
s_self.conf
> >
> > diff --git a/libsepol/tests/policies/test-neverallow/policy_minus_self.=
conf b/libsepol/tests/policies/test-neverallow/policy_minus_self.conf
> > new file mode 100644
> > index 00000000..58a71059
> > --- /dev/null
> > +++ b/libsepol/tests/policies/test-neverallow/policy_minus_self.conf
> > @@ -0,0 +1,369 @@
> > +class process
> > +class blk_file
> > +class chr_file
> > +class dir
> > +class fifo_file
> > +class file
> > +class lnk_file
> > +class sock_file
> > +
> > +class class5
> > +class class6
> > +class class7
> > +class class17
> > +
> > +sid kernel
> > +sid security
> > +sid unlabeled
> > +sid file
> > +sid port
> > +sid netif
> > +sid netmsg
> > +sid node
> > +sid devnull
> > +
> > +class process { dyntransition transition }
> > +class file { ioctl read write }
> > +
> > +class class5 { perm }
> > +class class6 { perm }
> > +class class7 { perm }
> > +class class17 { ioctl }
> > +
> > +ifdef(`enable_mls',`
> > +sensitivity s0;
> > +dominance { s0 }
> > +category c0; category c1; category c2; category c3;
> > +category c4; category c5; category c6; category c7;
> > +category c8; category c9; category c10; category c11;
> > +category c12; category c13; category c14; category c15;
> > +category c16; category c17; category c18; category c19;
> > +category c20; category c21; category c22; category c23;
> > +
> > +level s0:c0.c23;
> > +
> > +mlsconstrain file { write } ( h1 dom h2 );
> > +')
> > +
> > +
> > +########################################
> > +#
> > +# Test start
> > +#
> > +########################################
> > +
> > +
> > +## Test 1 (single type)
> > +
> > +type test1_t;
> > +allow      test1_t test1_t           : file read;
> > +neverallow test1_t { test1_t -self } : file read;  # nofail
> > +
> > +
> > +## Test 2 (single type)
> > +
> > +type test2_t;
> > +allow      test2_t self              : file read;
> > +neverallow test2_t { test1_t -self } : file read;  # nofail
> > +
> > +## Test 3 (single type)
> > +
> > +type test3_1_t;
> > +type test3_2_t;
> > +allow      test3_1_t test3_2_t           : file read;
> > +neverallow test3_1_t { test3_2_t -self } : file read;
> > +
> > +
> > +## Test 4 (two types I)
> > +
> > +type test4_1_t;
> > +type test4_2_t;
> > +allow      { test4_1_t test4_2_t } { test4_1_t test4_2_t }       : fil=
e read;
> > +neverallow test4_1_t               { test4_1_t test4_2_t -self } : fil=
e read;
> > +
> > +
> > +## Test 5 (two types II)
> > +
> > +type test5_1_t;
> > +type test5_2_t;
> > +allow      { test5_1_t test5_2_t } { test5_1_t test5_2_t }       : cla=
ss5 perm;
> > +neverallow *                       { test5_1_t test5_2_t -self } : cla=
ss5 perm;
> > +
> > +
> > +## Test 6 (two types III)
> > +
> > +type test6_1_t;
> > +type test6_2_t;
> > +allow      { test6_1_t test6_2_t } { test6_1_t test6_2_t } : class6 pe=
rm;
> > +neverallow *                       { test6_2_t -self }     : class6 pe=
rm;
> > +
> > +
> > +## Test 7 (two types IV)
> > +
> > +type test7_1_t;
> > +type test7_2_t;
> > +allow      { test7_1_t test7_2_t } test7_2_t : class7 perm;
> > +neverallow *         { test7_1_t -self }     : class7 perm; # nofail
> > +
> > +
> > +## Test 8 (attribute violates type I)
> > +
> > +attribute test8_a;
> > +type test8_1_t, test8_a;
> > +type test8_2_t, test8_a;
> > +allow      test8_a   test8_a           : file read;
> > +neverallow test8_1_t { test8_a -self } : file *;
> > +
> > +
> > +## Test 9 (attribute violates type II)
> > +
> > +attribute test9_a;
> > +type test9_1_t, test9_a;
> > +type test9_2_t, test9_a;
> > +allow      test9_1_t test9_a           : file read;
> > +neverallow test9_1_t { test9_a -self } : file *;
> > +
> > +
> > +## Test 10 (attribute violates type III)
> > +
> > +attribute test10_1_a;
> > +attribute test10_2_a;
> > +type test10_1_t, test10_1_a, test10_1_a;
> > +type test10_2_t, test10_1_a, test10_1_a;
> > +allow      test10_1_a test10_1_a           : file read;
> > +neverallow test10_1_t { test10_2_a -self } : file *;
> > +
> > +
> > +## Test 11 (attribute violates attribute I)
> > +
> > +attribute test11_1_a;
> > +attribute test11_2_a;
> > +type test11_1_t, test11_1_a, test11_2_a;
> > +type test11_2_t, test11_1_a, test11_2_a;
> > +allow      test11_1_t self                 : file read;
> > +allow      test11_2_t test11_2_t           : file read;
> > +neverallow test11_1_a { test11_2_a -self } : file *;  # nofail
> > +
> > +
> > +## Test 12 (attribute violates attribute II)
> > +
> > +attribute test12_a;
> > +type test12_1_t, test12_a;
> > +type test12_2_t, test12_a;
> > +allow      test12_1_t test12_2_t         : file read;
> > +neverallow test12_a   { test12_a -self } : file *;
> > +
> > +
> > +## Test 13 (attribute violates attribute III)
> > +
> > +attribute test13_a;
> > +type test13_1_t, test13_a;
> > +type test13_2_t, test13_a;
> > +allow      test13_1_t test13_a           : file read;
> > +neverallow test13_a   { test13_a -self } : file *;
> > +
> > +
> > +## Test 14 (attribute violates attribute IV)
> > +
> > +attribute test14_a;
> > +type test14_1_t, test14_a;
> > +type test14_2_t, test14_a;
> > +allow      test14_a test14_a           : file read;
> > +neverallow test14_a { test14_a -self } : file *;
> > +
> > +
> > +# ## Test 15 (attribute violates attribute V)
> > +
> > +attribute test13_1_a;
> > +attribute test13_2_a;
> > +type test13_t, test13_1_a, test13_2_a;
> > +allow      test13_1_a test13_2_a           : file read;
> > +neverallow test13_a   { test13_2_a -self } : file *;
> > +
> > +
> > +## Test 16 (types violate attribute)
> > +
> > +attribute test16_a;
> > +type test16_1_t, test16_a;
> > +type test16_2_t, test16_a;
> > +allow      { test16_1_t test16_2_t } { test16_1_t test16_2_t } : file =
read;
> > +neverallow test16_a                  { test16_a -self }        : file =
~write;
> > +
> > +
> > +## Test 17 (extended permissions I)
> > +
> > +type test17_1_t;
> > +type test17_2_t;
> > +allow           { test17_1_t test17_2_t } { test17_1_t test17_2_t }   =
    : class17 ioctl;
> > +neverallowxperm ~test17_2_t               { test17_1_t test17_2_t -sel=
f } : class17 ioctl 0x1111;
> > +
> > +
> > +## Test 18 (extended permissions II)
> > +
> > +type test18_1_t;
> > +type test18_2_t;
> > +allow           { test18_1_t test18_2_t } { test18_1_t test18_2_t }   =
    : file ioctl;
> > +allowxperm      { test18_1_t test18_2_t } { test18_1_t test18_2_t }   =
    : file ioctl 0x1111;
> > +neverallowxperm { test18_1_t test18_2_t } { test18_1_t test18_2_t -sel=
f } : file ioctl 0x2222;  # nofail
> > +
> > +
> > +## Test 19 (extended permissions III)
> > +
> > +type test19_1_t;
> > +type test19_2_t;
> > +allow           { test19_1_t test19_2_t } { test19_1_t test19_2_t }   =
    : file ioctl;
> > +allowxperm      { test19_1_t test19_2_t } { test19_1_t test19_2_t }   =
    : file ioctl { 0x0100 - 0x0102 };
> > +neverallowxperm test19_2_t                { test19_1_t test19_2_t -sel=
f } : file ioctl { 0x0101 - 0x0104 };
> > +
> > +
> > +## Test 20 (extended permissions IV)
> > +
> > +type test20_1_t;
> > +type test20_2_t;
> > +allow           { test20_1_t test20_2_t } { test20_1_t test20_2_t }   =
    : file ioctl;
> > +allowxperm      test20_1_t                test20_1_t                  =
    : file ioctl 0x0101;
> > +allowxperm      test20_1_t                test20_2_t                  =
    : file ioctl 0x0102;
> > +allowxperm      test20_2_t                test20_1_t                  =
    : file ioctl 0x0103;
> > +allowxperm      test20_2_t                test20_2_t                  =
    : file ioctl 0x0104;
> > +neverallowxperm { test20_1_t test20_2_t } { test20_1_t test20_2_t -sel=
f } : file ioctl { 0x0000 - 0x9000 };
> > +
> > +
> > +## Test 21 (extended permissions V)
> > +
> > +attribute test21_a;
> > +type test21_1_t, test21_a;
> > +type test21_2_t, test21_a;
> > +allow           test21_a   test21_a           : file ioctl;
> > +allowxperm      test21_a   test21_a           : file ioctl 0x9501;
> > +neverallowxperm test21_1_t { test21_a -self } : file ioctl 0x9511;  # =
nofail
> > +
> > +
> > +## Test 22 (extended permissions VI)
> > +
> > +type test22_t;
> > +allow           test22_t self               : file ioctl;
> > +allowxperm      test22_t self               : file ioctl 0x9501;
> > +allowxperm      test22_t self               : file ioctl 0x9511;
> > +neverallowxperm test22_t { test22_t -self } : file ioctl 0x9511;  # no=
fail
> > +
> > +
> > +## Test 23 (extended permissions VII)
> > +
> > +attribute test23_a;
> > +type test23_1_t, test23_a;
> > +type test23_2_t, test23_a;
> > +allow           test23_a   test23_a           : file ioctl;
> > +allowxperm      test23_a   test23_a           : file ioctl 0x9501;
> > +allowxperm      test23_1_t test23_2_t         : file ioctl 0x9511;
> > +neverallowxperm test23_1_t { test23_a -self } : file ioctl 0x9511;
> > +
> > +
> > +## Test 24 (extended permissions VII)
> > +
> > +attribute test24_a;
> > +type test24_1_t, test24_a;
> > +type test24_2_t, test24_a;
> > +allow           test24_a   test24_a           : file ioctl;
> > +allowxperm      test24_a   test24_a           : file ioctl 0x9501;
> > +allowxperm      test24_1_t test24_a           : file ioctl 0x9511;
> > +neverallowxperm test24_1_t { test24_a -self } : file ioctl 0x9511;
> > +
> > +
> > +## Test 25 (extended permissions IX)
> > +
> > +attribute test25_a;
> > +type test25_1_t, test25_a;
> > +type test25_2_t, test25_a;
> > +allow           test25_a   test25_a           : file ioctl;
> > +allowxperm      test25_a   test25_a           : file ioctl 0x9501;
> > +allowxperm      test25_a   test25_a           : file ioctl 0x9511;
> > +neverallowxperm test25_1_t { test25_a -self } : file ioctl 0x9511;
> > +
> > +
> > +## Test 26 (extended permissions X)
> > +
> > +attribute test26_1_a;
> > +attribute test26_2_a;
> > +type test26_1_t, test26_1_a, test26_2_a;
> > +type test26_2_t, test26_1_a, test26_2_a;
> > +allow           { test26_1_a test26_2_a } { test26_1_a test26_2_a } : =
file ioctl;
> > +allowxperm      { test26_1_a test26_2_a } { test26_1_a test26_2_a } : =
file ioctl 0x9501;
> > +allowxperm      test26_1_a                test26_2_a                : =
file ioctl 0x9511;
> > +neverallowxperm test26_1_t                { test26_2_a -self }      : =
file ioctl 0x9511;
> > +
> > +
> > +# ## Test 27 (extended permissions attribute violation I)
> > +
> > +attribute test27_a;
> > +type test27_1_t, test27_a;
> > +type test27_2_t, test27_a;
> > +allow           test27_a   test27_a           : file ioctl;
> > +allowxperm      test27_a   test27_a           : file ioctl 0x9501;
> > +allowxperm      test27_1_t self               : file ioctl 0x9521;
> > +allowxperm      test27_2_t test27_2_t         : file ioctl 0x9521;
> > +neverallowxperm test27_a   { test27_a -self } : file ioctl 0x9521;  # =
nofail
> > +
> > +
> > +# ## Test 28 (extended permissions attribute violation II)
> > +
> > +attribute test28_a;
> > +type test28_1_t, test28_a;
> > +type test28_2_t, test28_a;
> > +allow           test28_a   test28_a           : file ioctl;
> > +allowxperm      test28_1_t test28_2_t         : file ioctl 0x9521;
> > +neverallowxperm test28_a   { test28_a -self } : file ioctl 0x9521;
> > +
> > +
> > +## Test 29 (extended permissions attribute violation III)
> > +
> > +attribute test29_a;
> > +type test29_1_t, test29_a;
> > +type test29_2_t, test29_a;
> > +allow           test29_a   test29_a           : file ioctl;
> > +allowxperm      test29_1_t test29_a           : file ioctl 0x9521;
> > +neverallowxperm test29_a   { test29_a -self } : file ioctl 0x9521;
> > +
> > +
> > +## Test 30 (extended permissions attribute violation IV)
> > +
> > +attribute test30_a;
> > +type test30_1_t, test30_a;
> > +type test30_2_t, test30_a;
> > +allow           test30_a test30_a           : file ioctl;
> > +allowxperm      test30_a test30_a           : file ioctl 0x9521;
> > +neverallowxperm test30_a { test30_a -self } : file ioctl 0x9521;
> > +
> > +
> > +## Test 31 (extended permissions attribute violation V)
> > +
> > +attribute test31_1_a;
> > +attribute test31_2_a;
> > +type test31_1_t, test31_1_a, test31_2_a;
> > +type test31_2_t, test31_1_a, test31_2_a;
> > +allow           test31_1_a test31_1_a           : file ioctl;
> > +allowxperm      test31_1_a test31_2_a           : file ioctl 0x9521;
> > +neverallowxperm test31_1_a { test31_2_a -self } : file ioctl 0x9521;
> > +
> > +
> > +########################################
> > +#
> > +# Test End
> > +#
> > +########################################
> > +
> > +
> > +type sys_isid;
> > +role sys_role;
> > +role sys_role types sys_isid;
> > +gen_user(sys_user,, sys_role, s0, s0 - s0:c0.c23)
> > +sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid security gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid unlabeled gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid file gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid port gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid netif gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid netmsg gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid node gen_context(sys_user:sys_role:sys_isid, s0)
> > +sid devnull gen_context(sys_user:sys_role:sys_isid, s0)
> > +fs_use_trans devpts gen_context(sys_user:sys_role:sys_isid, s0);
> > +fs_use_trans devtmpfs gen_context(sys_user:sys_role:sys_isid, s0);
> > diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-nev=
erallow.c
> > index c6518ebb..c0a2bfa8 100644
> > --- a/libsepol/tests/test-neverallow.c
> > +++ b/libsepol/tests/test-neverallow.c
> > @@ -154,6 +154,75 @@ static void test_neverallow_basic(void)
> >         policydb_destroy(&base_expanded);
> >  }
> >
> > +static void test_neverallow_minus_self(void)
> > +{
> > +       policydb_t basemod, base_expanded;
> > +       sepol_handle_t *handle;
> > +       static const char *const expected_messages[] =3D {
> > +               "33 neverallow failures occurred",
> > +               "neverallow on line 77 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 77 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
> > +               "neverallow on line 85 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 85 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> > +               "neverallow on line 93 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> > +               "neverallow on line 93 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> > +               "neverallow on line 101 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 101 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
> > +               "neverallow on line 118 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 118 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
> > +               "neverallow on line 127 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 127 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
> > +               "neverallow on line 137 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 137 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
> > +               "neverallow on line 157 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 157 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
> > +               "neverallow on line 166 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 166 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> > +               "neverallow on line 175 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> > +               "neverallow on line 175 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> > +               "neverallow on line 193 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> > +               "neverallow on line 193 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> > +               "neverallowxperm on line 201 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 201 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { i=
octl };",
> > +               "neverallowxperm on line 219 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 219 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file i=
octl { 0x101-0x102 };",
> > +               "neverallowxperm on line 231 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file i=
octl { 0x102 };",
> > +               "neverallowxperm on line 231 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file i=
octl { 0x103 };",
> > +               "neverallowxperm on line 261 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 261 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file i=
octl { 0x9511 };",
> > +               "neverallowxperm on line 272 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 272 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioc=
tl { 0x9511 };",
> > +               "neverallowxperm on line 283 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 283 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl=
 { 0x9511 };",
> > +               "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> > +               "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> > +               "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> > +               "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> > +               "neverallowxperm on line 317 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file i=
octl { 0x9521 };",
> > +               "neverallowxperm on line 317 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioct=
l };",
> > +               "neverallowxperm on line 327 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioc=
tl { 0x9521 };",
> > +               "neverallowxperm on line 327 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioct=
l };",
> > +               "neverallowxperm on line 337 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl=
 { 0x9521 };",
> > +               "neverallowxperm on line 337 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl=
 { 0x9521 };",
> > +               "neverallowxperm on line 348 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file i=
octl { 0x9521 };",
> > +               "neverallowxperm on line 348 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file i=
octl { 0x9521 };",
> > +       };
> > +
> > +       if (policydb_init(&base_expanded))
> > +               CU_FAIL_FATAL("Failed to initialize policy");
> > +
> > +       if (test_load_policy(&basemod, POLICY_BASE, mls, "test-neverall=
ow", "policy_minus_self.conf"))
> > +               CU_FAIL_FATAL("Failed to load policy");
> > +
> > +       if (link_modules(NULL, &basemod, NULL, 0, 0))
> > +               CU_FAIL_FATAL("Failed to link base module");
> > +
> > +       if (expand_module(NULL, &basemod, &base_expanded, 0, 0))
> > +               CU_FAIL_FATAL("Failed to expand policy");
> > +
> > +       if ((handle =3D sepol_handle_create()) =3D=3D NULL)
> > +               CU_FAIL_FATAL("Failed to initialize handle");
> > +
> > +       sepol_msg_set_callback(handle, msg_handler, NULL);
> > +
> > +       if (check_assertions(handle, &base_expanded, base_expanded.glob=
al->branch_list->avrules) !=3D -1)
> > +               CU_FAIL("Assertions did not trigger");
> > +
> > +       messages_check(ARRAY_SIZE(expected_messages), expected_messages=
);
> > +
> > +       sepol_handle_destroy(handle);
> > +       messages_clean();
> > +       policydb_destroy(&basemod);
> > +       policydb_destroy(&base_expanded);
> > +}
> > +
> >  static void test_neverallow_not_self(void)
> >  {
> >         policydb_t basemod, base_expanded;
> > @@ -243,5 +312,10 @@ int neverallow_add_tests(CU_pSuite suite)
> >                 return CU_get_error();
> >         }
> >
> > +       if (NULL =3D=3D CU_add_test(suite, "neverallow_minus_self", tes=
t_neverallow_minus_self)) {
> > +               CU_cleanup_registry();
> > +               return CU_get_error();
> > +       }
> > +
> >         return 0;
> >  }
> > --
> > 2.38.1
> >
