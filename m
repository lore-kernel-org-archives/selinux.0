Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7284C77B7A
	for <selinux@archiver.kernel.org>; Wed,  7 Jun 2023 13:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjFGNcS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbjFGNcR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 09:32:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0731993
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 06:32:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so2485506e87.0
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144733; x=1688736733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EidVIiDjfJ+Cc5XcNImAlcxbdFLRmxpysygTOeiVJBM=;
        b=SDTK3Ea2Jr2un17seqGEaMYvsZZNK81RDl9u5c7LUt1QSFyHbfJwjDQUzyWMyYqSD3
         7quHV2o377Ekzpkr5gqu+zVnJWQPNLYIeTuVd/vtyd4cMQC2Tn+53pXyUjAoE1EwLbtU
         AZNi8PvDGsRM9YYqUtaCxQpeBo2qCB1vb/lPk8NPzhI4dSyppSPZTcB6TPK6+tbYORmx
         HbHWX9SEXcnuaeVSL+MdkOT5FaGNlUy9Wx6GwD6poiXR+D6gS6qW4OnJDs/T1z0LN55g
         LW8sG0/MgI7kOiQbtS6ils7Ppx8DM8K1wbBsdENSHWjGW5RujM9+ZflEjIECJnsyGGY2
         9FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144733; x=1688736733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EidVIiDjfJ+Cc5XcNImAlcxbdFLRmxpysygTOeiVJBM=;
        b=MuF6rsSjzE6wwlwzampflAXnptF2X6tglZkFr2ebnAtfhyQ//R0RrDTMwDLHF+mBim
         zEC5OBmYqQ58hYzu6d4Df6LEbW9xg23N6V1/xJ52u2b2/y+9vn6qKlJ27Gn3FOIqJvCY
         /yi+if/PSlmwgboxC+avs135hUbwzZRVeCDIdvq3mHk8T7VyAAUL5WRSnue9xrE7wHDD
         BjazccXyDWRimAj//mKpcGsmjKyOE5w1Y/IZ2XIHT6a0Iw5gb5jB4Zj4GGPTEgRKhfu8
         4befx9bsEWGvPfNvs44FQlVj2gHusieSiSPqu5G7EqdIQfkU8iMBAyGWSks4qPZUmORT
         k3Qg==
X-Gm-Message-State: AC+VfDyrSF/Fd1qsT85VtT0OdXcRcU3KZZlLEfiV3Juy5swRC7AYa1W+
        8s1xsViSIVeDPgauCJwu6nq3GrFwvuG+ZdJjhVM=
X-Google-Smtp-Source: ACHHUZ59R4yQIbsLqhHJE5Coyqvd8hX0b0l7W3H4TxjKujnio0qly6RVlfs6EAqR80jMDISeEMrabTWEh/sdwxSear0=
X-Received: by 2002:a2e:8e8c:0:b0:2ac:5905:eff9 with SMTP id
 z12-20020a2e8e8c000000b002ac5905eff9mr2113934ljk.6.1686144733365; Wed, 07 Jun
 2023 06:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
 <20230531114914.2237609-8-juraj@jurajmarcin.com> <CAP+JOzTm5dgTMKJmhtDbbu72B-knQoBFbphuB3whaNfOidR3SA@mail.gmail.com>
 <CAFqZXNsUd3earrrK1J_udvFsa7hNxXTFVLshytTz5HE25fN9Jw@mail.gmail.com>
In-Reply-To: <CAFqZXNsUd3earrrK1J_udvFsa7hNxXTFVLshytTz5HE25fN9Jw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 7 Jun 2023 09:32:02 -0400
Message-ID: <CAP+JOzR6CO9FWW+pyxOQ2fqXSPeByA-uRps5nODJh_2Rzn3uuQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] checkpolicy, libsepol: add prefix/suffix support to
 module policy
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 7, 2023 at 4:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Thu, Jun 1, 2023 at 10:59=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > On Wed, May 31, 2023 at 7:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> > >
> > > This patch extends the structures for module and base policy (avrule_=
t)
> > > to support prefix/suffix transitions. In addition to this, it impleme=
nts
> > > the necessary changes to functions for reading and writing the binary
> > > policy as well as parsing the policy conf.
> > >
> >
> > I would like to see an example of the new syntax.
> > Something like:
> > type_transition ta tb : CLASS03 tc "file03" match_exact;
> > type_transition ta tb : CLASS04 tc "file04" match_prefix;
> > type_transition ta tb : CLASS05 tc "file05" match_suffix;
> >
> > > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > > ---
> > >  checkpolicy/policy_define.c                | 13 ++++---
> > >  checkpolicy/policy_define.h                |  2 +-
> > >  checkpolicy/policy_parse.y                 | 15 +++++---
> > >  checkpolicy/policy_scan.l                  |  6 ++++
> > >  checkpolicy/test/dismod.c                  | 14 ++++++++
> > >  checkpolicy/test/dispol.c                  |  2 +-
> > >  libsepol/cil/src/cil_binary.c              |  4 ++-
> > >  libsepol/include/sepol/policydb/avtab.h    |  1 +
> > >  libsepol/include/sepol/policydb/policydb.h | 13 ++++---
> > >  libsepol/src/avtab.c                       | 30 ++++++++++++----
> > >  libsepol/src/expand.c                      |  6 +++-
> > >  libsepol/src/kernel_to_common.h            |  2 +-
> > >  libsepol/src/link.c                        |  1 +
> > >  libsepol/src/module_to_cil.c               | 25 +++++++++++---
> > >  libsepol/src/policydb.c                    | 23 ++++++++++++-
> > >  libsepol/src/write.c                       | 40 ++++++++++++++++----=
--
> > >  16 files changed, 154 insertions(+), 43 deletions(-)
>
> <snip>
>
> > > @@ -452,13 +453,19 @@ cond_dontaudit_def        : DONTAUDIT names nam=
es ':' names names ';'
> > >                         ;
> > >                         ;
> > >  transition_def         : TYPE_TRANSITION  names names ':' names iden=
tifier filename ';'
> > > -                       {if (define_compute_type(AVRULE_TRANSITION, 1=
)) return -1; }
> > > +                       {if (define_compute_type(AVRULE_TRANSITION, 1=
, NAME_TRANS_MATCH_EXACT)) return -1;}
> > > +            | TYPE_TRANSITION names names ':' names identifier filen=
ame MATCH_EXACT ';'
> > > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRAN=
S_MATCH_EXACT)) return -1;}
> > > +            | TYPE_TRANSITION names names ':' names identifier filen=
ame MATCH_PREFIX ';'
> > > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRAN=
S_MATCH_PREFIX)) return -1;}
> > > +            | TYPE_TRANSITION names names ':' names identifier filen=
ame MATCH_SUFFIX ';'
> > > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRAN=
S_MATCH_SUFFIX)) return -1;}
> > >                         | TYPE_TRANSITION names names ':' names ident=
ifier ';'
> > > -                        {if (define_compute_type(AVRULE_TRANSITION, =
0)) return -1;}
> > > +                        {if (define_compute_type(AVRULE_TRANSITION, =
0, NAME_TRANS_MATCH_EXACT)) return -1;}
> > >                          | TYPE_MEMBER names names ':' names identifi=
er ';'
> > > -                        {if (define_compute_type(AVRULE_MEMBER, 0)) =
return -1;}
> > > +                        {if (define_compute_type(AVRULE_MEMBER, 0, N=
AME_TRANS_MATCH_EXACT)) return -1;}
> > >                          | TYPE_CHANGE names names ':' names identifi=
er ';'
> > > -                        {if (define_compute_type(AVRULE_CHANGE, 0)) =
return -1;}
> > > +                        {if (define_compute_type(AVRULE_CHANGE, 0, N=
AME_TRANS_MATCH_EXACT)) return -1;}
> > >                         ;
> > >  range_trans_def                : RANGE_TRANSITION names names mls_ra=
nge_def ';'
> > >                         { if (define_range_trans(0)) return -1; }
> > > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > > index 9fefea7b..3f568701 100644
> > > --- a/checkpolicy/policy_scan.l
> > > +++ b/checkpolicy/policy_scan.l
> > > @@ -125,6 +125,12 @@ EXPANDATTRIBUTE |
> > >  expandattribute                 { return(EXPANDATTRIBUTE); }
> > >  TYPE_TRANSITION |
> > >  type_transition                        { return(TYPE_TRANSITION); }
> > > +MATCH_EXACT |
> > > +match_exact                    { return(MATCH_EXACT); }
> > > +MATCH_PREFIX |
> > > +match_prefix                   { return(MATCH_PREFIX); }
> > > +MATCH_SUFFIX |
> > > +match_suffix                   { return(MATCH_SUFFIX); }
> >
> > I would prefer just "exact", "prefix", and "suffix" without the
> > "match_" prefix, but I can live with it if others think that the
> > shorter keywords will cause problems.
>
> I slightly prefer the "match_" in the keyword, since it makes the
> semantic more clear when reading the policy (especially for people
> that are only learning SELinux). But I guess in the case of "prefix"
> and "suffix" it doesn't make as much difference as in the case of
> "exact". Which leads me to the question whether we want to even add
> the redundant "exact"/"match_exact" keyword as opposed to just leaving
> the current syntax (which we need to keep either way for
> compatibility). IIRC, when we discussed this with Juraj, we were not
> sure which way to go, so we are open to dropping it if that's
> preferred by others.
>

I think that I would prefer just "prefix" and "suffix" and using the
current syntax for the exact match. That seems like it would make it
very clear when something other than an exact match is being used. But
if others want to keep "match_" and use "exact", I can live with it.

Jim

> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
