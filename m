Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB632C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCD264E7B
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbhBDTWK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbhBDTWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 14:22:03 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854FC0613D6
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 11:21:22 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id s107so4521424otb.8
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXixQ0P5Ml7lu2p0ysl2hvIgmqbpssrl+eRdDwUhTgs=;
        b=T/iNVpXJFGMb6ZEPcNreAukmw1mCfSsNnid4leheMmIEBDQBikMLL78eJF75elqC6r
         Jkwt2ubWjOFT64Mbgt92Nk6Jln+3qF9XClZ6TpUlufMiofxH+po9T8idbBWLhYFVh8Xp
         2vrVKSLEcbs2mzmtSo9k7HKez95Gr9YiEYFAyVqWmEdD4R9n5XVX9OoHLjzsEJZb5UWq
         sOeFDUa0zikmhOBAmV7cqNtizquflSK1QkBVCjLpma9qEA9DvfU9+b8v68UmTt+yc3XI
         WaPaN8GfduS6pUol5XSQ8PMG3pzebR32cA9vhBY2tZ7H6ZAaZWWvoa+4LfmgMUep/DS2
         DMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXixQ0P5Ml7lu2p0ysl2hvIgmqbpssrl+eRdDwUhTgs=;
        b=t6nZ+yZ0occ3KcMYJsv0kOLMIFLafkRSGifU6ZHdON6vX1OSk1MUbWvda6SwPJKsQH
         np2fKsxAUcokMgAfmcUYrssmQygRAXEq0UwfBnjaIJP8lfeqvkib477nkZUKyRkC0eYH
         3w3UBa4gM8LqtbSpGmPCnpplifhMLuylgFzl6U8BZBEiEqEkziIfY+AXyYzyZzdOGcrZ
         Dd1UH0w2GPMjXvyJLLK8AzEqFMR057I3z97XH9HrD7NwEt7MHAz4NXwoUeoiqExRXRe6
         6b816v84FCdR0Z0n5HqYuqRM7FkooIYSwnkOVl16iyLpiT7NsKuLdzG4xlrU4MN9uFNY
         BiKA==
X-Gm-Message-State: AOAM531X08ABUjwgX1xuyly8DwQkGL36d5WYRqAd52O3CmMUSTkpZHcm
        wgoF0Fig0equNPGbHLl/5W8O+e3xr2Qbv92kmJs=
X-Google-Smtp-Source: ABdhPJz5xIGwOYpK24YnNarxAlBIj1Ue7XdxOmP+Zak5ev+2aUwFsHwZYHqSJnPbHE8aTTExHo9mIS97ybHEeJ0DQYU=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr699263otu.59.1612466481982;
 Thu, 04 Feb 2021 11:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210203085846.6680-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 14:26:23 -0500
Message-ID: <CAP+JOzTY1cjmms-FqbgOgRRHLHvuA8DsAnK3yryi9XRmkJWaow@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: remove unused files
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> libsepol/src/roles.c contains functions which do not match its header
> file libsepol/include/sepol/roles.h:
>
>     // In roles.c
>     int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
>                           sepol_policydb_t * p, const char *role, int *response)
>     // In roles.h
>     extern int sepol_role_exists(const sepol_policydb_t * policydb,
>                                  const char *role, int *response);
>
> and:
>
>     // In roles.c
>     int sepol_role_list(sepol_handle_t * handle,
>                         sepol_policydb_t * p, char ***roles, unsigned int *nroles)
>     // In roles.h
>     extern int sepol_role_list(const sepol_policydb_t * policydb,
>                                char ***roles, unsigned int *nroles);
>
> Instead of fixing the parameter type (using sepol_handle_t or
> sepol_policydb_t but not different ones), remove these functions, as
> they appear not to be used. They are not exported in libsepol.so.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/roles.h | 18 ------------
>  libsepol/src/roles.c           | 53 ----------------------------------
>  2 files changed, 71 deletions(-)
>  delete mode 100644 libsepol/include/sepol/roles.h
>  delete mode 100644 libsepol/src/roles.c
>
> diff --git a/libsepol/include/sepol/roles.h b/libsepol/include/sepol/roles.h
> deleted file mode 100644
> index e750078c8dab..000000000000
> --- a/libsepol/include/sepol/roles.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -#ifndef _SEPOL_ROLES_H_
> -#define _SEPOL_ROLES_H_
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -extern int sepol_role_exists(const sepol_policydb_t * policydb,
> -                            const char *role, int *response);
> -
> -extern int sepol_role_list(const sepol_policydb_t * policydb,
> -                          char ***roles, unsigned int *nroles);
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -
> -#endif
> diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
> deleted file mode 100644
> index 4540cee80e19..000000000000
> --- a/libsepol/src/roles.c
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#include <stdlib.h>
> -#include <string.h>
> -
> -#include <sepol/policydb/hashtab.h>
> -#include <sepol/policydb/policydb.h>
> -
> -#include "debug.h"
> -#include "handle.h"
> -
> -/* Check if a role exists */
> -int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
> -                     sepol_policydb_t * p, const char *role, int *response)
> -{
> -
> -       policydb_t *policydb = &p->p;
> -       *response = (hashtab_search(policydb->p_roles.table, role) != NULL);
> -
> -       return STATUS_SUCCESS;
> -}
> -
> -/* Fill an array with all valid roles */
> -int sepol_role_list(sepol_handle_t * handle,
> -                   sepol_policydb_t * p, char ***roles, unsigned int *nroles)
> -{
> -
> -       policydb_t *policydb = &p->p;
> -       unsigned int tmp_nroles = policydb->p_roles.nprim;
> -       char **tmp_roles = (char **)malloc(tmp_nroles * sizeof(char *));
> -       char **ptr;
> -       unsigned int i;
> -       if (!tmp_roles)
> -               goto omem;
> -
> -       for (i = 0; i < tmp_nroles; i++) {
> -               tmp_roles[i] = strdup(policydb->p_role_val_to_name[i]);
> -               if (!tmp_roles[i])
> -                       goto omem;
> -       }
> -
> -       *nroles = tmp_nroles;
> -       *roles = tmp_roles;
> -
> -       return STATUS_SUCCESS;
> -
> -      omem:
> -       ERR(handle, "out of memory, could not list roles");
> -
> -       ptr = tmp_roles;
> -       while (ptr && *ptr)
> -               free(*ptr++);
> -       free(tmp_roles);
> -       return STATUS_ERR;
> -}
> --
> 2.30.0
>
