Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E477C7EE43
	for <selinux@archiver.kernel.org>; Wed,  7 Jun 2023 08:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbjFGIcr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbjFGIcq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 04:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F406BE62
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686126719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyJs9dzjDgeTA92Kxzb85zb9KPL+kjo0ptjLOS7sCCc=;
        b=FUMZ4XbfSDq08ljTvSQ/Iq8LeUwOLlcZSh5Y6ZXe+ZgmLU6shOXbTUVAm21Wt4bqp4G2/M
        G8bVvldKDl2Eysis6XOll+dGt2V7MqDS9ncZ62uUWMJv+TC+g0PCr62DoSeeZxxExI9JKM
        CQaVfiGklKmrRz1jZtJQaWdzAlcZioE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-rzqo72sVMcu0SeW2IJnVTQ-1; Wed, 07 Jun 2023 04:31:56 -0400
X-MC-Unique: rzqo72sVMcu0SeW2IJnVTQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2566e9b14a4so6490145a91.2
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 01:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126715; x=1688718715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyJs9dzjDgeTA92Kxzb85zb9KPL+kjo0ptjLOS7sCCc=;
        b=bTWMW/CsOVqhik37iI4F8xBsAbzci58WwvBBYp04NNKAZAUjfwz3I5dQDp8Nhm6eb7
         IbukihJ0Cu/05vt+Z1E49yjnrfqo6I3f3yPPA4kObTFtE8p3RyuERX+nG+Gf8iS2e6T9
         /ly2piUrAhM17q6I6wXYrEWVY6CBFfPT5yY6pKCvYguyg6rw943fXHPfscf2Ii4FiMmx
         tQ9jhbLFa5nuiR7pWIiAONV49zU65W2WUe4/VcZpSxdOOEB4CLe5yZ1FFsbP8RQTpPzb
         H0hTQtcSyBNdPMchfE3gpUELT9zIPBNDg7MJrLQ6ipps0UWGSlY7SsKfmei4bPXHRgee
         zOEw==
X-Gm-Message-State: AC+VfDzU+5kToONPjOXkr2cbTLTF8EEKTPdVsXknlX3AKymVqqDUkOkj
        tZjjLWIHZIK+9+wXAD6z3qAqjhnDWMeXlh0oEW8UheoFtcP699nlq7K/68Q31rxHTtpwD9NTOyi
        yvzXl1wJYDV8vhm6l4RM8FNhR84VvqNVaVg==
X-Received: by 2002:a17:90a:aa85:b0:259:4199:29d8 with SMTP id l5-20020a17090aaa8500b00259419929d8mr4440505pjq.15.1686126714870;
        Wed, 07 Jun 2023 01:31:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ478YDIVMKaSu/a7mN9Nq2KDgvV5QAkI+VUV7iq2+NTS7uco39w8StGndBZgCF5MFlsUca3waHL0DA+Po9/GpM=
X-Received: by 2002:a17:90a:aa85:b0:259:4199:29d8 with SMTP id
 l5-20020a17090aaa8500b00259419929d8mr4440485pjq.15.1686126714544; Wed, 07 Jun
 2023 01:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
 <20230531114914.2237609-8-juraj@jurajmarcin.com> <CAP+JOzTm5dgTMKJmhtDbbu72B-knQoBFbphuB3whaNfOidR3SA@mail.gmail.com>
In-Reply-To: <CAP+JOzTm5dgTMKJmhtDbbu72B-knQoBFbphuB3whaNfOidR3SA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 7 Jun 2023 10:31:43 +0200
Message-ID: <CAFqZXNsUd3earrrK1J_udvFsa7hNxXTFVLshytTz5HE25fN9Jw@mail.gmail.com>
Subject: Re: [PATCH 7/8] checkpolicy, libsepol: add prefix/suffix support to
 module policy
To:     James Carter <jwcart2@gmail.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 10:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, May 31, 2023 at 7:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.c=
om> wrote:
> >
> > This patch extends the structures for module and base policy (avrule_t)
> > to support prefix/suffix transitions. In addition to this, it implement=
s
> > the necessary changes to functions for reading and writing the binary
> > policy as well as parsing the policy conf.
> >
>
> I would like to see an example of the new syntax.
> Something like:
> type_transition ta tb : CLASS03 tc "file03" match_exact;
> type_transition ta tb : CLASS04 tc "file04" match_prefix;
> type_transition ta tb : CLASS05 tc "file05" match_suffix;
>
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > ---
> >  checkpolicy/policy_define.c                | 13 ++++---
> >  checkpolicy/policy_define.h                |  2 +-
> >  checkpolicy/policy_parse.y                 | 15 +++++---
> >  checkpolicy/policy_scan.l                  |  6 ++++
> >  checkpolicy/test/dismod.c                  | 14 ++++++++
> >  checkpolicy/test/dispol.c                  |  2 +-
> >  libsepol/cil/src/cil_binary.c              |  4 ++-
> >  libsepol/include/sepol/policydb/avtab.h    |  1 +
> >  libsepol/include/sepol/policydb/policydb.h | 13 ++++---
> >  libsepol/src/avtab.c                       | 30 ++++++++++++----
> >  libsepol/src/expand.c                      |  6 +++-
> >  libsepol/src/kernel_to_common.h            |  2 +-
> >  libsepol/src/link.c                        |  1 +
> >  libsepol/src/module_to_cil.c               | 25 +++++++++++---
> >  libsepol/src/policydb.c                    | 23 ++++++++++++-
> >  libsepol/src/write.c                       | 40 ++++++++++++++++------
> >  16 files changed, 154 insertions(+), 43 deletions(-)

<snip>

> > @@ -452,13 +453,19 @@ cond_dontaudit_def        : DONTAUDIT names names=
 ':' names names ';'
> >                         ;
> >                         ;
> >  transition_def         : TYPE_TRANSITION  names names ':' names identi=
fier filename ';'
> > -                       {if (define_compute_type(AVRULE_TRANSITION, 1))=
 return -1; }
> > +                       {if (define_compute_type(AVRULE_TRANSITION, 1, =
NAME_TRANS_MATCH_EXACT)) return -1;}
> > +            | TYPE_TRANSITION names names ':' names identifier filenam=
e MATCH_EXACT ';'
> > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_=
MATCH_EXACT)) return -1;}
> > +            | TYPE_TRANSITION names names ':' names identifier filenam=
e MATCH_PREFIX ';'
> > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_=
MATCH_PREFIX)) return -1;}
> > +            | TYPE_TRANSITION names names ':' names identifier filenam=
e MATCH_SUFFIX ';'
> > +            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_=
MATCH_SUFFIX)) return -1;}
> >                         | TYPE_TRANSITION names names ':' names identif=
ier ';'
> > -                        {if (define_compute_type(AVRULE_TRANSITION, 0)=
) return -1;}
> > +                        {if (define_compute_type(AVRULE_TRANSITION, 0,=
 NAME_TRANS_MATCH_EXACT)) return -1;}
> >                          | TYPE_MEMBER names names ':' names identifier=
 ';'
> > -                        {if (define_compute_type(AVRULE_MEMBER, 0)) re=
turn -1;}
> > +                        {if (define_compute_type(AVRULE_MEMBER, 0, NAM=
E_TRANS_MATCH_EXACT)) return -1;}
> >                          | TYPE_CHANGE names names ':' names identifier=
 ';'
> > -                        {if (define_compute_type(AVRULE_CHANGE, 0)) re=
turn -1;}
> > +                        {if (define_compute_type(AVRULE_CHANGE, 0, NAM=
E_TRANS_MATCH_EXACT)) return -1;}
> >                         ;
> >  range_trans_def                : RANGE_TRANSITION names names mls_rang=
e_def ';'
> >                         { if (define_range_trans(0)) return -1; }
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 9fefea7b..3f568701 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -125,6 +125,12 @@ EXPANDATTRIBUTE |
> >  expandattribute                 { return(EXPANDATTRIBUTE); }
> >  TYPE_TRANSITION |
> >  type_transition                        { return(TYPE_TRANSITION); }
> > +MATCH_EXACT |
> > +match_exact                    { return(MATCH_EXACT); }
> > +MATCH_PREFIX |
> > +match_prefix                   { return(MATCH_PREFIX); }
> > +MATCH_SUFFIX |
> > +match_suffix                   { return(MATCH_SUFFIX); }
>
> I would prefer just "exact", "prefix", and "suffix" without the
> "match_" prefix, but I can live with it if others think that the
> shorter keywords will cause problems.

I slightly prefer the "match_" in the keyword, since it makes the
semantic more clear when reading the policy (especially for people
that are only learning SELinux). But I guess in the case of "prefix"
and "suffix" it doesn't make as much difference as in the case of
"exact". Which leads me to the question whether we want to even add
the redundant "exact"/"match_exact" keyword as opposed to just leaving
the current syntax (which we need to keep either way for
compatibility). IIRC, when we discussed this with Juraj, we were not
sure which way to go, so we are open to dropping it if that's
preferred by others.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

