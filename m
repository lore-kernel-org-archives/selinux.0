Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E7C433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8240764FB8
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBEJo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:44:59 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48386 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBEJms (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:42:48 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 78672561252
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:42:05 +0100 (CET)
Received: by mail-oo1-f48.google.com with SMTP id 123so1446786ooi.13
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 01:42:05 -0800 (PST)
X-Gm-Message-State: AOAM530qh/3RryrM0O4mqtjMa6BQXAMUxYE+whyViulcVknyxpeGQqLJ
        Dvo4iolmIi47b5rPIyHLUXkopS3/f8EEcP76t8c=
X-Google-Smtp-Source: ABdhPJxbNe4FUQ7ZnETFCEFJUDPOjxB5RI0XZq0eMmqIQ3CSj1q40qtH6R2Jgzdx/GoQ9O6+inrt6nPOJQJiTgQjLiw=
X-Received: by 2002:a4a:a22a:: with SMTP id m42mr2906326ool.22.1612518124291;
 Fri, 05 Feb 2021 01:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org> <CAP+JOzTY1cjmms-FqbgOgRRHLHvuA8DsAnK3yryi9XRmkJWaow@mail.gmail.com>
In-Reply-To: <CAP+JOzTY1cjmms-FqbgOgRRHLHvuA8DsAnK3yryi9XRmkJWaow@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 5 Feb 2021 10:41:52 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mzFOjS1nba_XU=xe4XwnJ-t5muACLMtBShuXifLzw0sQ@mail.gmail.com>
Message-ID: <CAJfZ7=mzFOjS1nba_XU=xe4XwnJ-t5muACLMtBShuXifLzw0sQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: remove unused files
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:42:06 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 8:21 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > libsepol/src/roles.c contains functions which do not match its header
> > file libsepol/include/sepol/roles.h:
> >
> >     // In roles.c
> >     int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
> >                           sepol_policydb_t * p, const char *role, int *response)
> >     // In roles.h
> >     extern int sepol_role_exists(const sepol_policydb_t * policydb,
> >                                  const char *role, int *response);
> >
> > and:
> >
> >     // In roles.c
> >     int sepol_role_list(sepol_handle_t * handle,
> >                         sepol_policydb_t * p, char ***roles, unsigned int *nroles)
> >     // In roles.h
> >     extern int sepol_role_list(const sepol_policydb_t * policydb,
> >                                char ***roles, unsigned int *nroles);
> >
> > Instead of fixing the parameter type (using sepol_handle_t or
> > sepol_policydb_t but not different ones), remove these functions, as
> > they appear not to be used. They are not exported in libsepol.so.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Nicolas

> > ---
> >  libsepol/include/sepol/roles.h | 18 ------------
> >  libsepol/src/roles.c           | 53 ----------------------------------
> >  2 files changed, 71 deletions(-)
> >  delete mode 100644 libsepol/include/sepol/roles.h
> >  delete mode 100644 libsepol/src/roles.c
> >
> > diff --git a/libsepol/include/sepol/roles.h b/libsepol/include/sepol/roles.h
> > deleted file mode 100644
> > index e750078c8dab..000000000000
> > --- a/libsepol/include/sepol/roles.h
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -#ifndef _SEPOL_ROLES_H_
> > -#define _SEPOL_ROLES_H_
> > -
> > -#ifdef __cplusplus
> > -extern "C" {
> > -#endif
> > -
> > -extern int sepol_role_exists(const sepol_policydb_t * policydb,
> > -                            const char *role, int *response);
> > -
> > -extern int sepol_role_list(const sepol_policydb_t * policydb,
> > -                          char ***roles, unsigned int *nroles);
> > -
> > -#ifdef __cplusplus
> > -}
> > -#endif
> > -
> > -#endif
> > diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
> > deleted file mode 100644
> > index 4540cee80e19..000000000000
> > --- a/libsepol/src/roles.c
> > +++ /dev/null
> > @@ -1,53 +0,0 @@
> > -#include <stdlib.h>
> > -#include <string.h>
> > -
> > -#include <sepol/policydb/hashtab.h>
> > -#include <sepol/policydb/policydb.h>
> > -
> > -#include "debug.h"
> > -#include "handle.h"
> > -
> > -/* Check if a role exists */
> > -int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
> > -                     sepol_policydb_t * p, const char *role, int *response)
> > -{
> > -
> > -       policydb_t *policydb = &p->p;
> > -       *response = (hashtab_search(policydb->p_roles.table, role) != NULL);
> > -
> > -       return STATUS_SUCCESS;
> > -}
> > -
> > -/* Fill an array with all valid roles */
> > -int sepol_role_list(sepol_handle_t * handle,
> > -                   sepol_policydb_t * p, char ***roles, unsigned int *nroles)
> > -{
> > -
> > -       policydb_t *policydb = &p->p;
> > -       unsigned int tmp_nroles = policydb->p_roles.nprim;
> > -       char **tmp_roles = (char **)malloc(tmp_nroles * sizeof(char *));
> > -       char **ptr;
> > -       unsigned int i;
> > -       if (!tmp_roles)
> > -               goto omem;
> > -
> > -       for (i = 0; i < tmp_nroles; i++) {
> > -               tmp_roles[i] = strdup(policydb->p_role_val_to_name[i]);
> > -               if (!tmp_roles[i])
> > -                       goto omem;
> > -       }
> > -
> > -       *nroles = tmp_nroles;
> > -       *roles = tmp_roles;
> > -
> > -       return STATUS_SUCCESS;
> > -
> > -      omem:
> > -       ERR(handle, "out of memory, could not list roles");
> > -
> > -       ptr = tmp_roles;
> > -       while (ptr && *ptr)
> > -               free(*ptr++);
> > -       free(tmp_roles);
> > -       return STATUS_ERR;
> > -}
> > --
> > 2.30.0
> >

