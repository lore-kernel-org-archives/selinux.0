Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B8C433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbiDTTFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbiDTTFM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 15:05:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDD2BE5
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:02:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s16so3177410oie.0
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZn+R6nf/BCiPkSJkHi99vatAKwJ3Q4+6FiEeTL6iWk=;
        b=Db361tUIIlX2uwC/6xGKKCyI01bc0z8XprJVZxSWFEV2HkBujklnrItmQdG/kZ+QTY
         saa7wiNWxdyKWEd8wLm+GcPuxYpVru2/R7YOYSjuMInUrFR0IZjjjX3mdA20kofd0kzB
         kcjxlka47I8fNgFxg3T8dsgUswJXDqlvav3pYcmzLrHFOJTLuZBgKSD4/FTeTV+4EUsG
         Zo97fr8uDveDkLg/HBQRhL1aolGBXaoBEK7NH8+/eXeDX9Bsp+b7FPIrI3ZbfTrqM/h4
         D1+DBMESsOobisawLguYCnSmB9rk45PJq9/pDtNXAFczjBUWTUP4LvMQk0hhnWK45UTu
         QFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZn+R6nf/BCiPkSJkHi99vatAKwJ3Q4+6FiEeTL6iWk=;
        b=rdXM+degI8SGl4D/+RDxLYTjNvCEO1d8TDriLPua8d1bPRx1l7FvVuM62khxU4vvS8
         w6wgByv64irUgKnJZA6jPXaf3oTL5C+Gj2n54FZe4YxLcAL80aZzbWW1gryfJspNTpMt
         5rvHQM2pDoxdQ8EXZn92cTd8819WQ37K6cpg2poHFLw0cyanjpHrGHmErRHc+tfnua40
         +pB2k/1euR1gdN2LdQHd8DF5iMkKk9OK1vf932Qi7c6z63TDu8uL0iHWQZlAkW1e7jiB
         N/CApUf71iB9XceGDLfZ/chwdsVu9DZQBSXPeYa69ADIq5iQfCRgLvA6y2Ubp9HpFWz+
         ahFg==
X-Gm-Message-State: AOAM533heMxLQVD6eMLWxON4cVWcL4UePV04sklbJ4YlUTuDuSfSZ9f0
        VXJD/sYTL7AYKLXJlelmr77q+qc0yQ2a136XGzA=
X-Google-Smtp-Source: ABdhPJwv0/eqlOhvhTYIB3y+wK5Fx5Th2S8ewuNuwk9mn3dmuih1uutABsfmGUmRMdnb7dqAXBETa3W+moGaSH1/e9g=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr2510039oiv.156.1650481343228; Wed, 20
 Apr 2022 12:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220413160517.64145-1-cgzones@googlemail.com> <CAP+JOzTsbTBE9BC5+Oku_wQysYzcgcA63JBppb0zNWHaSM9knA@mail.gmail.com>
In-Reply-To: <CAP+JOzTsbTBE9BC5+Oku_wQysYzcgcA63JBppb0zNWHaSM9knA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Apr 2022 15:02:12 -0400
Message-ID: <CAP+JOzTJPtRHduLWDP4A1RT5vyXhwBB6VYLTniff0UyVyS3MQA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: adjust IPv6 netmasks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 10:25 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 9:25 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > checkpolicy(8) since 01b88ac3 ("checkpolicy: warn on bogus IP address o=
r
> > netmask in nodecon statement") warns about host bits set in IPv6
> > addresses.
> > Adjust IPv6 netmasks in the libsepol tests so that the used address ::1
> > does not set any host bits and running the tests does not print several
> > of the following warnings:
> >
> >     net_contexts:15:WARNING 'host bits in ipv6 address set' at token ''=
 on line 594:
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
> >  libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
> >  libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
> >  libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
> >  libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
> >  libsepol/tests/policies/test-expander/small-base.conf | 2 +-
> >  libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
> >  libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
> >  libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
> >  libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
> >  10 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libse=
pol/tests/policies/test-deps/base-metreq.conf
> > index 3e2f8407..b7528dde 100644
> > --- a/libsepol/tests/policies/test-deps/base-metreq.conf
> > +++ b/libsepol/tests/policies/test-deps/base-metreq.conf
> > @@ -516,7 +516,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:sys_foo_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_fo=
o_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:net_foo_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/li=
bsepol/tests/policies/test-deps/base-notmetreq.conf
> > index 8ff3d204..eee36dca 100644
> > --- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
> > +++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
> > @@ -503,7 +503,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:sys_foo_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_fo=
o_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:net_foo_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsep=
ol/tests/policies/test-deps/small-base.conf
> > index 1411e624..98f49c23 100644
> > --- a/libsepol/tests/policies/test-deps/small-base.conf
> > +++ b/libsepol/tests/policies/test-deps/small-base.conf
> > @@ -504,7 +504,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:sys_foo_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_fo=
o_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:net_foo_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/li=
bsepol/tests/policies/test-expander/alias-base.conf
> > index 57d4520e..b950039d 100644
> > --- a/libsepol/tests/policies/test-expander/alias-base.conf
> > +++ b/libsepol/tests/policies/test-expander/alias-base.conf
> > @@ -494,7 +494,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:system_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system=
_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:system_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/lib=
sepol/tests/policies/test-expander/role-base.conf
> > index a603390b..8e88b4be 100644
> > --- a/libsepol/tests/policies/test-expander/role-base.conf
> > +++ b/libsepol/tests/policies/test-expander/role-base.conf
> > @@ -476,7 +476,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:system_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system=
_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:system_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/li=
bsepol/tests/policies/test-expander/small-base.conf
> > index 20005e3f..055ea054 100644
> > --- a/libsepol/tests/policies/test-expander/small-base.conf
> > +++ b/libsepol/tests/policies/test-expander/small-base.conf
> > @@ -714,7 +714,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:sys_foo_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_fo=
o_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:net_foo_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/lib=
sepol/tests/policies/test-expander/user-base.conf
> > index 1f84fd76..b31ee8cd 100644
> > --- a/libsepol/tests/policies/test-expander/user-base.conf
> > +++ b/libsepol/tests/policies/test-expander/user-base.conf
> > @@ -480,7 +480,7 @@ genfscon proc /                             gen_con=
text(system_u:object_r:system_t, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system=
_t, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system=
_u:object_r:system_t, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libse=
pol/tests/policies/test-hooks/cmp_policy.conf
> > index 1eccf4a8..9082b333 100644
> > --- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
> > +++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
> > @@ -464,7 +464,7 @@ genfscon proc /                             gen_con=
text(g_b_user_1:object_r:g_b_type_1, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_=
type_1, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_us=
er_1:object_r:g_b_type_1, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libse=
pol/tests/policies/test-hooks/small-base.conf
> > index 1eccf4a8..9082b333 100644
> > --- a/libsepol/tests/policies/test-hooks/small-base.conf
> > +++ b/libsepol/tests/policies/test-hooks/small-base.conf
> > @@ -464,7 +464,7 @@ genfscon proc /                             gen_con=
text(g_b_user_1:object_r:g_b_type_1, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_=
type_1, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_us=
er_1:object_r:g_b_type_1, s0)
> >
> >
> >
> > diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libs=
epol/tests/policies/test-linker/small-base.conf
> > index 2bc14656..890ebbeb 100644
> > --- a/libsepol/tests/policies/test-linker/small-base.conf
> > +++ b/libsepol/tests/policies/test-linker/small-base.conf
> > @@ -593,7 +593,7 @@ genfscon proc /                             gen_con=
text(g_b_user_1:object_r:g_b_type_1, s0)
> >  #
> >  #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
> >
> > -nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_=
type_1, s0)
> > +nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_us=
er_1:object_r:g_b_type_1, s0)
> >
> >
> >
> > --
> > 2.35.2
> >
