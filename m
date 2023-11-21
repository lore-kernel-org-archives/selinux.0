Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDCDC61D94
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjKUOM4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjKUOMz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:12:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7110D2
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:12:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50930f126b1so7317172e87.3
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575968; x=1701180768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEBb4H+1cw+2kj6oJGnb2RkcpLS29o2CB58gJTYijco=;
        b=Z1KDqWgO9dTfuB5ztbJQZSQaBaPEdYql/NGFxiDKYRqeRumD8x01PrArn1Y8Kr1ovb
         vt2lfu3tnG3rzSw2/KAEqBvh/wxKz5BsrfaDYoDAR1fe/n6rz8vXcgmeDTxXwx2hJAkJ
         VOlIEzk+oCHuO5p6CVAbJLwzE1BiXVom+Kv7bEF+hbVsBWeMmfS9yWPWNApOwAw0rs/G
         fEddAPwG8g8StbqzmBpMx+LwrR9abzskwNmMQa1Ws05B6OWkc2osb7DFDcIPlcaZV//t
         RcnfPHqyT+H7MupEEBcDRj2U56XgeUVXgv6T+enqJKcMYlifuoX9Q8dpDSOCl8N1qQ/5
         4xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575968; x=1701180768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEBb4H+1cw+2kj6oJGnb2RkcpLS29o2CB58gJTYijco=;
        b=FS6lBCwZDIWHqj42xAuFVlpoI69DIQ3Px34mdD/eLJEqREnEV50obSuQghsgSam/qr
         S0rJ5bHcTYv0Bq7V9fnlUtRosMgQRg8a1X0M9KY5KWS67q46yYGTa2Hrd1MGHyVx3YXu
         iTkszFQLj12++Q/VuIbPWVtkbYJqNepsnsAru4lItws0eECPyDwH75Avf30XopfjEU3t
         jNFdphojmrXd46ZeBWRZybz9cfW+d3GQJyTOeEHZeOjyOICv1PpJAkmq4SLrE0k4kAQr
         sxzRJwUCPOQ6PGWLwR226ExYhRGWQVrLTFMx853uqJG7W1iGKwAXbMG60wROUOIDt7Z1
         DLvA==
X-Gm-Message-State: AOJu0Yyn4suTDq7IKUhSRyajgt2ecOLal5PZd7jo7GCaJjkFC8/bCC/C
        YS07IVtTu951bfHPZuhCOwRd4rIyP3GlOPKhuVCoDm+3
X-Google-Smtp-Source: AGHT+IGNUBuH2EUeZ4/m7sxFamEnYS+29QibDhD5muTzpIbpgHcnubmbmMlPvDK8FOGnVeF8qVv6xU9Llsyd1wjYMDI=
X-Received: by 2002:ac2:532f:0:b0:502:9a2c:f766 with SMTP id
 f15-20020ac2532f000000b005029a2cf766mr7628028lfh.30.1700575967868; Tue, 21
 Nov 2023 06:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20231109132944.3338574-1-jwcart2@gmail.com> <CAP+JOzTQ=qxb=mAX17PLZizKW4JCepVrGEK1+ZUR5=J-=Q2gvw@mail.gmail.com>
In-Reply-To: <CAP+JOzTQ=qxb=mAX17PLZizKW4JCepVrGEK1+ZUR5=J-=Q2gvw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Nov 2023 09:12:36 -0500
Message-ID: <CAP+JOzSS6mMKgrC27L-8FitMRfViTvgj1FUwVeNh_28CZUD5PA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: Update the order of neverallow test results
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 17, 2023 at 10:28=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Nov 9, 2023 at 8:29=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > The patch set [1] by Christian G=C3=B6ttsche <cgzones@googlemail.com> t=
o
> > use the DJB2a hash function caused the ordering of the reported
> > neverallow failures to change in the libsepol tests.
> >
> > Change the expected test results to reflect the new ordering.
> >
> > [1] https://lore.kernel.org/all/20230816123845.80171-1-cgzones@googlema=
il.com/
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Unless there are objections, I plan on merging this patch along with
> Christian's hash function patches next week.
> Jim
>

This patch along with Christian's hash function patches have been merged.
Jim


> > ---
> >  libsepol/tests/test-neverallow.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-nev=
erallow.c
> > index c0a2bfa8..7d6ad00e 100644
> > --- a/libsepol/tests/test-neverallow.c
> > +++ b/libsepol/tests/test-neverallow.c
> > @@ -101,10 +101,10 @@ static void test_neverallow_basic(void)
> >                 "neverallow on line 81 of policies/test-neverallow/poli=
cy.conf.std (or line 81 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test5_t test5_t:file { read };",
> >                 "neverallow on line 89 of policies/test-neverallow/poli=
cy.conf.std (or line 89 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test6_1_t test6_1_t:file { read };",
> >                 "neverallow on line 97 of policies/test-neverallow/poli=
cy.conf.std (or line 97 of policies/test-neverallow/policy.conf.std) violat=
ed by allow test7_1_t test7_1_t:file { read };",
> > -               "neverallow on line 106 of policies/test-neverallow/pol=
icy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test8_t test8_t:file { write };",
> >                 "neverallow on line 106 of policies/test-neverallow/pol=
icy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test8_t test8_t:file { read };",
> > -               "neverallow on line 115 of policies/test-neverallow/pol=
icy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test9_t test9_t:file { read };",
> > +               "neverallow on line 106 of policies/test-neverallow/pol=
icy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test8_t test8_t:file { write };",
> >                 "neverallow on line 115 of policies/test-neverallow/pol=
icy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test9_t test9_t:file { write };",
> > +               "neverallow on line 115 of policies/test-neverallow/pol=
icy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test9_t test9_t:file { read };",
> >                 "neverallow on line 124 of policies/test-neverallow/pol=
icy.conf.std (or line 124 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test10_1_t test10_1_t:file { read };",
> >                 "neverallow on line 131 of policies/test-neverallow/pol=
icy.conf.std (or line 131 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test11_t test11_t:process { dyntransition transition };",
> >                 "neverallow on line 143 of policies/test-neverallow/pol=
icy.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) viol=
ated by allow test12_3_t test12_1_t:file { getattr };",
> > @@ -162,22 +162,22 @@ static void test_neverallow_minus_self(void)
> >                 "33 neverallow failures occurred",
> >                 "neverallow on line 77 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 77 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
> >                 "neverallow on line 85 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 85 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> > -               "neverallow on line 93 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> >                 "neverallow on line 93 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> > +               "neverallow on line 93 of policies/test-neverallow/poli=
cy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus=
_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> >                 "neverallow on line 101 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 101 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
> >                 "neverallow on line 118 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 118 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
> >                 "neverallow on line 127 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 127 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
> >                 "neverallow on line 137 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 137 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
> >                 "neverallow on line 157 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 157 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
> >                 "neverallow on line 166 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 166 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> > -               "neverallow on line 175 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> >                 "neverallow on line 175 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> > -               "neverallow on line 193 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> > +               "neverallow on line 175 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> >                 "neverallow on line 193 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> > +               "neverallow on line 193 of policies/test-neverallow/pol=
icy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_min=
us_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> >                 "neverallowxperm on line 201 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 201 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { i=
octl };",
> >                 "neverallowxperm on line 219 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 219 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file i=
octl { 0x101-0x102 };",
> > -               "neverallowxperm on line 231 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file i=
octl { 0x102 };",
> >                 "neverallowxperm on line 231 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file i=
octl { 0x103 };",
> > +               "neverallowxperm on line 231 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file i=
octl { 0x102 };",
> >                 "neverallowxperm on line 261 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 261 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file i=
octl { 0x9511 };",
> >                 "neverallowxperm on line 272 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 272 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioc=
tl { 0x9511 };",
> >                 "neverallowxperm on line 283 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 283 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl=
 { 0x9511 };",
> > @@ -185,10 +185,10 @@ static void test_neverallow_minus_self(void)
> >                 "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> >                 "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> >                 "neverallowxperm on line 295 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file i=
octl { 0x9511 };",
> > -               "neverallowxperm on line 317 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file i=
octl { 0x9521 };",
> >                 "neverallowxperm on line 317 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioct=
l };",
> > -               "neverallowxperm on line 327 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioc=
tl { 0x9521 };",
> > +               "neverallowxperm on line 317 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file i=
octl { 0x9521 };",
> >                 "neverallowxperm on line 327 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioct=
l };",
> > +               "neverallowxperm on line 327 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioc=
tl { 0x9521 };",
> >                 "neverallowxperm on line 337 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl=
 { 0x9521 };",
> >                 "neverallowxperm on line 337 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl=
 { 0x9521 };",
> >                 "neverallowxperm on line 348 of policies/test-neverallo=
w/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/polic=
y_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file i=
octl { 0x9521 };",
> > @@ -231,23 +231,23 @@ static void test_neverallow_not_self(void)
> >                 "34 neverallow failures occurred",
> >                 "neverallow on line 78 of policies/test-neverallow/poli=
cy_not_self.conf.std (or line 78 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
> >                 "neverallow on line 86 of policies/test-neverallow/poli=
cy_not_self.conf.std (or line 86 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
> > -               "neverallow on line 94 of policies/test-neverallow/poli=
cy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> >                 "neverallow on line 94 of policies/test-neverallow/poli=
cy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
> > +               "neverallow on line 94 of policies/test-neverallow/poli=
cy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_sel=
f.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
> >                 "neverallow on line 102 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 102 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
> >                 "neverallow on line 119 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 119 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
> >                 "neverallow on line 128 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 128 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
> >                 "neverallow on line 138 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 138 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
> >                 "neverallow on line 158 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 158 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
> >                 "neverallow on line 167 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 167 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> > -               "neverallow on line 176 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> >                 "neverallow on line 176 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
> > +               "neverallow on line 176 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
> >                 "neverallow on line 185 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 185 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
> > -               "neverallow on line 194 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> >                 "neverallow on line 194 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
> > +               "neverallow on line 194 of policies/test-neverallow/pol=
icy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_s=
elf.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
> >                 "neverallowxperm on line 202 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl=
 };",
> >                 "neverallowxperm on line 220 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl=
 { 0x101-0x102 };",
> > -               "neverallowxperm on line 232 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl=
 { 0x102 };",
> >                 "neverallowxperm on line 232 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl=
 { 0x103 };",
> > +               "neverallowxperm on line 232 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl=
 { 0x102 };",
> >                 "neverallowxperm on line 262 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl=
 { 0x9511 };",
> >                 "neverallowxperm on line 273 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl {=
 0x9511 };",
> >                 "neverallowxperm on line 284 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0=
x9511 };",
> > @@ -255,10 +255,10 @@ static void test_neverallow_not_self(void)
> >                 "neverallowxperm on line 296 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl=
 { 0x9511 };",
> >                 "neverallowxperm on line 296 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl=
 { 0x9511 };",
> >                 "neverallowxperm on line 296 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl=
 { 0x9511 };",
> > -               "neverallowxperm on line 318 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl=
 { 0x9521 };",
> >                 "neverallowxperm on line 318 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };=
",
> > -               "neverallowxperm on line 328 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl {=
 0x9521 };",
> > +               "neverallowxperm on line 318 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl=
 { 0x9521 };",
> >                 "neverallowxperm on line 328 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };=
",
> > +               "neverallowxperm on line 328 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl {=
 0x9521 };",
> >                 "neverallowxperm on line 338 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0=
x9521 };",
> >                 "neverallowxperm on line 338 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0=
x9521 };",
> >                 "neverallowxperm on line 349 of policies/test-neverallo=
w/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_=
not_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl=
 { 0x9521 };",
> > --
> > 2.41.0
> >
