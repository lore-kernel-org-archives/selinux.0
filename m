Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B534AC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A0120657
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 18:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgENSo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 14:44:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44354 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgENSo6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 14:44:58 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 66D03566852
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 20:44:55 +0200 (CEST)
Received: by mail-oo1-f49.google.com with SMTP id s139so948989oos.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 11:44:55 -0700 (PDT)
X-Gm-Message-State: AOAM530PrvyesZChKB+4JOMej7oRW/EUVwhQ6Jx0WYapmZ9hisRGlu44
        0RVA7cTZyWPS5oEW0Q1WSnJGFkNva8fekp+SvgA=
X-Google-Smtp-Source: ABdhPJyJTJVk/p3XswExx9St0qopHUedGyHCtV5sMSn/CWX4cgtGpEfDBn1Suu4HpC0b8jAgyq3z49wfo7rsb1Ddjb0=
X-Received: by 2002:a4a:ad0d:: with SMTP id r13mr4771319oon.22.1589481894046;
 Thu, 14 May 2020 11:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <5ebc4bc6.1c69fb81.a8850.464e@mx.google.com>
In-Reply-To: <5ebc4bc6.1c69fb81.a8850.464e@mx.google.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 14 May 2020 20:44:42 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==4oSmvECxX-Roarvc5w=EsAtF=M-yjGv2bQD9rN7GUeg@mail.gmail.com>
Message-ID: <CAJfZ7==4oSmvECxX-Roarvc5w=EsAtF=M-yjGv2bQD9rN7GUeg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: fsync final files before rename
To:     Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu May 14 20:44:55 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 9:34 PM Smalley <stephen.smalley.work@gmail.com> wrote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Prior to rename(2)'ing the final selinux policy files into place,
> fsync(2) them to ensure the contents will be fully written prior to
> rename.  While we are here, also fix checking of write(2) to detect
> short writes and treat them as an error.  This code could be more
> generally improved but keeping to the minimal changes required to fix
> this bug.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/237
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 falls back to EIO if errno is not set by a short write, and
> only fsync's the final selinux policy files being created in
> /etc/selinux, avoiding the overhead of fsync on every file copied
> under /var/lib/selinux.
>
>  libsemanage/src/direct_api.c     | 10 +++++-----
>  libsemanage/src/semanage_store.c | 20 +++++++++++++++-----
>  libsemanage/src/semanage_store.h |  4 +++-
>  3 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 1088a0ac..d2b91fb2 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1188,7 +1188,7 @@ cleanup:
>   * overwrite it. If source doesn't exist then return success.
>   * Returns 0 on success, -1 on error. */
>  static int copy_file_if_exists(const char *src, const char *dst, mode_t mode){
> -       int rc = semanage_copy_file(src, dst, mode);
> +       int rc = semanage_copy_file(src, dst, mode, false);
>         return (rc < 0 && errno != ENOENT) ? rc : 0;
>  }
>
> @@ -1488,7 +1488,7 @@ rebuild:
>                         retval = semanage_copy_file(path,
>                                                     semanage_path(SEMANAGE_TMP,
>                                                                   SEMANAGE_STORE_SEUSERS),
> -                                                   0);
> +                                                   0, false);
>                         if (retval < 0)
>                                 goto cleanup;
>                         pseusers->dtable->drop_cache(pseusers->dbase);
> @@ -1506,7 +1506,7 @@ rebuild:
>                         retval = semanage_copy_file(path,
>                                                     semanage_path(SEMANAGE_TMP,
>                                                                   SEMANAGE_USERS_EXTRA),
> -                                                   0);
> +                                                   0, false);
>                         if (retval < 0)
>                                 goto cleanup;
>                         pusers_extra->dtable->drop_cache(pusers_extra->dbase);
> @@ -1595,7 +1595,7 @@ rebuild:
>
>         retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
>                         semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL),
> -                       sh->conf->file_mode);
> +                       sh->conf->file_mode, false);
>         if (retval < 0) {
>                 goto cleanup;
>         }
> @@ -1634,7 +1634,7 @@ rebuild:
>                         retval = semanage_copy_file(
>                                                 semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS),
>                                                 semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS),
> -                                               sh->conf->file_mode);
> +                                               sh->conf->file_mode, false);
>                         if (retval < 0) {
>                                 goto cleanup;
>                         }
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 859c0a22..cd5e46bb 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -707,7 +707,8 @@ static int semanage_filename_select(const struct dirent *d)
>
>  /* Copies a file from src to dst.  If dst already exists then
>   * overwrite it.  Returns 0 on success, -1 on error. */
> -int semanage_copy_file(const char *src, const char *dst, mode_t mode)
> +int semanage_copy_file(const char *src, const char *dst, mode_t mode,
> +               bool syncrequired)
>  {
>         int in, out, retval = 0, amount_read, n, errsv = errno;
>         char tmp[PATH_MAX];
> @@ -735,8 +736,11 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
>         }
>         umask(mask);
>         while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
> -               if (write(out, buf, amount_read) < 0) {
> -                       errsv = errno;
> +               if (write(out, buf, amount_read) != amount_read) {
> +                       if (errno)
> +                               errsv = errno;
> +                       else
> +                               errsv = EIO;
>                         retval = -1;
>                 }
>         }
> @@ -745,6 +749,10 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
>                 retval = -1;
>         }
>         close(in);
> +       if (syncrequired && fsync(out) < 0) {
> +               errsv = errno;
> +               retval = -1;
> +       }

The patch looks good to me, even though I am wondering whether it
makes sense to call fsync() if an error happens (by changing the
condition to "if (!retval && syncrequired && fsync(out) < 0)").
Anyway, this is a minor comment and I am fine with the other changes.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

>         if (close(out) < 0) {
>                 errsv = errno;
>                 retval = -1;
> @@ -811,7 +819,8 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>                         umask(mask);
>                 } else if (S_ISREG(sb.st_mode) && flag == 1) {
>                         mask = umask(0077);
> -                       if (semanage_copy_file(path, path2, sb.st_mode) < 0) {
> +                       if (semanage_copy_file(path, path2, sb.st_mode,
> +                                               false) < 0) {
>                                 umask(mask);
>                                 goto cleanup;
>                         }
> @@ -1639,7 +1648,8 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
>                         goto cleanup;
>                 }
>
> -               ret = semanage_copy_file(src, dst, sh->conf->file_mode);
> +               ret = semanage_copy_file(src, dst, sh->conf->file_mode,
> +                                       true);
>                 if (ret < 0) {
>                         ERR(sh, "Could not copy %s to %s.", src, dst);
>                         goto cleanup;
> diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
> index 34bf8523..b9ec5664 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -24,6 +24,7 @@
>  #ifndef SEMANAGE_MODULE_STORE_H
>  #define SEMANAGE_MODULE_STORE_H
>
> +#include <stdbool.h>
>  #include <sys/time.h>
>  #include <sepol/module.h>
>  #include <sepol/cil/cil.h>
> @@ -162,6 +163,7 @@ int semanage_nc_sort(semanage_handle_t * sh,
>                      size_t buf_len,
>                      char **sorted_buf, size_t * sorted_buf_len);
>
> -int semanage_copy_file(const char *src, const char *dst, mode_t mode);
> +int semanage_copy_file(const char *src, const char *dst, mode_t mode,
> +               bool syncrequired);
>
>  #endif
> --
> 2.23.3
>

