Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656EC19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbiHIPSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHIPSy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 11:18:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E811803
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 08:18:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q184so14203549oif.1
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=4FM2LzEmS7P4EJ1E8Noc+DhjROsp/XsR9WLLlYSbeAc=;
        b=ImhUTB4AhOyd7Am4Fs3xvB4Mxd0yfOrw3r0BitD6cjYyaym0IqYtXKAxjScqlwRO+i
         DhJ7GU6A4J3ZaL/iNfHcOUEd4LRcflLB2MqVR8RQIjJmca12PNGv1dydqZ1eEF9R03r8
         2P1DoaVM3Mxt96sXBc2hL1CSSAPSdofC7ZDcfYmJg3CAR7fvVhk9zCETMyG0gtQ/t9gN
         SGNSrD/uoYnGUUJA94HU5yWtr4CaYs0iian7HhjSoYtVaPhhWCP6as4NMuRZe9MwxQms
         NzoQ7fTd6vpl5fh70kJC5jsziYS90CqQvGHUR+J0fb4TYc9JJBeyPzaf1wHDuZUBMrtx
         saPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=4FM2LzEmS7P4EJ1E8Noc+DhjROsp/XsR9WLLlYSbeAc=;
        b=jUUNCsD6MVvo2TmtyYPHy6UjhacbJQGiMcSq9A92AovpXsnUPpssattUWXHwg6FWcC
         SNyxXmGNE2crYYVre5OU1sYJOQbM/MS2BofgFT6Lx/27ZPGpVkPVP4xUFquJB3KSaIdi
         jvfnwFdYwJcIbZ+VXszI3NU+8ryIEsBubJcPuERpaYzqxcdMFRw7MCFvFNtL+Lrae8i3
         VwJ7tF50J+4uhXGzu6HDzIrG/S1d2FqlXtCYMhKhotvksUYoLoynLvzb/ltGrKJSLwKs
         fH264cZ1V9KKwtIaWn8OXYa/fIfg1R9xFKE4v9Do8O32OlGuQCJgcAcqaz6rqr+e2cHo
         qQCA==
X-Gm-Message-State: ACgBeo1/jAH3ro1ogverHaWP7uyn0ahlC9AZG8NWYkXK0hYni9pN9zDt
        svHni1WtsCTZjpEkIEVtofzx/NOFh+pPP6lRQ+w=
X-Google-Smtp-Source: AA6agR6bv6vwvs0WH89UJ5gQ5ovgMBBgsKFBt0nVuiGUNMCfdCUgxzrpJHZ72nfBMWL0a8GSdmgpGvh87k8YulyQjsw=
X-Received: by 2002:a05:6808:9b9:b0:343:b4d:592f with SMTP id
 e25-20020a05680809b900b003430b4d592fmr2421374oig.156.1660058332678; Tue, 09
 Aug 2022 08:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220713134343.19811-1-cgzones@googlemail.com> <CAP+JOzSFzXmTTXBevMra4d6isCCW8uRP_Q0V8neHEA+Yeq=QFQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSFzXmTTXBevMra4d6isCCW8uRP_Q0V8neHEA+Yeq=QFQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Aug 2022 11:18:41 -0400
Message-ID: <CAP+JOzT_=Z87hWiQ_+j_PcfF-F9eeWZgfdMPXYyHKf6XrJ3cWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: break circular include
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 19, 2022 at 12:29 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 9:50 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Since `struct type_set` is forward declared including
> > policydb/policydb.h is not necessary and creates a circular include.
> >
> > Also drop the unnecessary forward declaration of `struct policydb`.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/include/sepol/policydb/constraint.h | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/in=
clude/sepol/policydb/constraint.h
> > index b91fc4e9..82335e21 100644
> > --- a/libsepol/include/sepol/policydb/constraint.h
> > +++ b/libsepol/include/sepol/policydb/constraint.h
> > @@ -18,7 +18,6 @@
> >  #ifndef _SEPOL_POLICYDB_CONSTRAINT_H_
> >  #define _SEPOL_POLICYDB_CONSTRAINT_H_
> >
> > -#include <sepol/policydb/policydb.h>
> >  #include <sepol/policydb/ebitmap.h>
> >  #include <sepol/policydb/flask_types.h>
> >
> > @@ -70,8 +69,6 @@ typedef struct constraint_node {
> >         struct constraint_node *next;   /* next constraint */
> >  } constraint_node_t;
> >
> > -struct policydb;
> > -
> >  extern int constraint_expr_init(constraint_expr_t * expr);
> >  extern void constraint_expr_destroy(constraint_expr_t * expr);
> >
> > --
> > 2.36.1
> >
