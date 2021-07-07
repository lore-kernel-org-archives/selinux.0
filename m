Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A877C07E95
	for <selinux@archiver.kernel.org>; Wed,  7 Jul 2021 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DBC61CC1
	for <selinux@archiver.kernel.org>; Wed,  7 Jul 2021 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhGGQiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGGQiC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jul 2021 12:38:02 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2DDC061574
        for <selinux@vger.kernel.org>; Wed,  7 Jul 2021 09:35:22 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so2868109otl.0
        for <selinux@vger.kernel.org>; Wed, 07 Jul 2021 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROOO/St9ifP2Ntyfeoo6tyyU3eqiJk2UgELdSPNdrRw=;
        b=RgoMzC86ztPFrbL7ekcF7nOjfWSZ11dbbzrtSbusqTp4VIPzghZV8znliXfmz9b4aU
         ghnEAF1XDJ11li7IcNT37azcQVGcmpRQHVeH/IjBsLiR2rzOWCdIZ0nEOpEWq+bV/D8s
         95eS4SmQsEu7wDP4MkkKF882q3DSxYlJSxg+GgiUdgwr4IBDfqE+IJfrJ3I/p/Ge1Ax+
         si2XZaAqkn95i4AwATiPlK6HQNn8MPtv6/6gTC36GOEn4Ttba+gnAsBC+J//yy5ZQPax
         ijZeoZdzPar54nmVZ5cBqnzq90lLCPKzHWAT3LE7zNAO/hDuFOdI2mAj2DinxhOCMKOf
         4z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROOO/St9ifP2Ntyfeoo6tyyU3eqiJk2UgELdSPNdrRw=;
        b=U/gaS+Ik+GDH6Qyli/+jvwYQ1bZeHOrza2NQkJ2jiO1nXwCy1MebuGCwOaDWlYy7Zq
         3KLDaeN4X1XQpa9vGXX8+SGlJ+6KLIAIwbQaUBTYOlQfQjGXx5PI61j/QQ3uPE+qgy7o
         wt4VdXIETCVzO2dHGeLszO59ImHT+9DFEKCGX+zaB8qsR7KvTSwyP9fURQc4Ma/wvCIT
         llOQwxa6V2fKYpifE+eZKchFP3/tbfhnUSsI95+B+B25pkIs+4u9i5JJFKwg1Gb+yA8h
         tqwFPONSmHdfpG/Tdgj2WPYri3EwFoOvv9JCvmEHAqupMznkCPqFIhNzaou9ZicU40Jq
         VMIg==
X-Gm-Message-State: AOAM530q0sugorr5GcJiND6Jzz5zZbGzvRi+VGG5+wRGxemxEFkI3Fw3
        rAQEyS7nObRfeyBvwscw3j4tneaEInD1eB5w/t+oNWIP0d4=
X-Google-Smtp-Source: ABdhPJxIQRKoaPXvh+CAh5ZWDL8CG4AOXnIycbOMK7AvqpT62use6uqP5nLtLfM6sgSScAfkfbwSX6M0MFPLRKmOS6o=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr5610447otr.196.1625675721686;
 Wed, 07 Jul 2021 09:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210702110705.435223-1-nicolas.iooss@m4x.org> <CAP+JOzQM=p9Kg2grQWeKzgwWe+N+HTTJNdaiQ++HhW+mPYb9+w@mail.gmail.com>
In-Reply-To: <CAP+JOzQM=p9Kg2grQWeKzgwWe+N+HTTJNdaiQ++HhW+mPYb9+w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 7 Jul 2021 12:35:10 -0400
Message-ID: <CAP+JOzS-d9QpCmJMbKiK0j6tEhgwtJQhUdzzCWFNcr-oS3T-Ug@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: do not override previous results of __cil_verify_classperms
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 6, 2021 at 10:58 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jul 2, 2021 at 7:15 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > When __cil_verify_map_class() verifies a classpermission, it calls
> > __verify_map_perm_classperms() on each item. If the first item reports a
> > failure and the next one succeeds, the failure is overwritten in
> > map_args->rc. This is a bug which causes a NULL pointer dereference in
> > the CIL compiler when compiling the following policy:
> >
> >     (sid SID)
> >     (sidorder (SID))
> >
> >     (class CLASS (PERM1))
> >     (classorder (CLASS))
> >
> >     (classpermission CLSPERM)
> >     (classpermissionset CLSPERM (CLASS (PERM1)))
> >     (classmap files (CLAMAPxx x))
> >     (classmapping files CLAMAPxx CLSPERM)
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=30286
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_verify.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index 59397f70f2ea..8ad3dc9e114a 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -1786,8 +1786,12 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
> >  {
> >         struct cil_verify_map_args *map_args = args;
> >         struct cil_perm *cmp = (struct cil_perm *)d;
> > +       int rc;
> >
> > -       map_args->rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> > +       rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> > +       if (rc != SEPOL_OK) {
> > +               map_args->rc = rc;
> > +       }
> >
> >         return SEPOL_OK;
> >  }
> > --
> > 2.32.0
> >
