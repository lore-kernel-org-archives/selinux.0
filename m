Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6CC433F5
	for <selinux@archiver.kernel.org>; Wed, 23 Mar 2022 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiCWSNH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiCWSNE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Mar 2022 14:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFEB088B33
        for <selinux@vger.kernel.org>; Wed, 23 Mar 2022 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648059093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hg+OxtVtA31Pd+fQPy+nB2EKaYVXBS9SIPL8EbO3QIM=;
        b=Jrcu9M2uOl7ACl7XlXim2Ub5TKHCbmFJykdZwkq13d5a8u7XHI1MM5LXG0Ju82BmXewxSs
        b08HFU5fnpIKwsnYcwdH8CiiR3EK7XQJwxUix0w+V+e7RmUlpwM3oNdt4M3LRk82ciMRAt
        /k5KwrDDT2XobHaXspwTk1K+phDh3Fk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-yj368UkxOHK-4xFc3kGq9A-1; Wed, 23 Mar 2022 14:11:31 -0400
X-MC-Unique: yj368UkxOHK-4xFc3kGq9A-1
Received: by mail-yb1-f200.google.com with SMTP id h16-20020a056902009000b00628a70584b2so1785175ybs.6
        for <selinux@vger.kernel.org>; Wed, 23 Mar 2022 11:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg+OxtVtA31Pd+fQPy+nB2EKaYVXBS9SIPL8EbO3QIM=;
        b=Yk1aWmaOyITlqZChZgiYcmEF4/XVPXD6UN78oQvRfJt2NwHqMcJioie1z2lqqyJj8e
         RjMf/3acnRVGbsVHnrzKsO6wEW8UYUwH11uwpj7ic7VfYsQiTqBdMd6ctaabi0ZrT1LA
         5HFuMeXIULWhm4qf2h7OWbN5lSqMrwogAGwn7mhKfjvcVV/HISBwwwxwDUs1ux4paKa8
         8/XwN274QEFLuPYXOd/1+BDZSmAiJiMBu8V7GH+4/8wEDa3dZwYWfAEYosG+5vbi0L3+
         BiLR+YlUrs6QqvWVStSkthDUUFs+dv1PyUCjlQIPsK7zlarZmVyxzYgppx3jm3RP0w3l
         6KzA==
X-Gm-Message-State: AOAM530Ab7C752V5YYm3tHY+Cz42Oc1MSgIlepZK5IJEeGagrOZIJNiJ
        p8vMoXeuPBSmfKs/jBgrfwqkGafvP0gpEr4cmlLPNpxw9ysolDb9oXWmi4NLjU+wuvxvBLXX/ck
        vgAWzYBNzxusBFZChtg7rYfoH+Tvzdx4SBw==
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id g7-20020a5b0247000000b006244d2494eemr1224737ybp.197.1648059091422;
        Wed, 23 Mar 2022 11:11:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Rw+Ey/xCo6BQHfO9qvcUFIUey8WqKtuDgMCjQNi7In6e8BO9JNMN5XpR071r+p4xUiLDXaeg92efqpSqFt8=
X-Received: by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP id
 g7-20020a5b0247000000b006244d2494eemr1224719ybp.197.1648059091196; Wed, 23
 Mar 2022 11:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220323173412.1538778-1-plautrba@redhat.com>
In-Reply-To: <20220323173412.1538778-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 23 Mar 2022 19:11:20 +0100
Message-ID: <CAFqZXNs11g0x6wTvu_kkHVkUE==SV-ameWRnnW5ipd_gY3aAwg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Fallback to semanage_copy_dir when rename() failed
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Joseph Marrero Corchado <jmarrero@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 23, 2022 at 6:34 PM Petr Lautrbach <plautrba@redhat.com> wrote:

In subject: s/Fallback/Fall back/ and s/failed/fails/

Other than a couple nits above and below the patch looks good to me.

I think we could make the fallback rename atomic by creating a file
before the rename, removing it afterwards, and checking if it exists
at the beginning of each transaction (in case it does, we would retry
the rename from scratch before proceeding). But maybe it's not worth
the hassle for such a corner case...

> In some circumstances, like semanage-store being on overlayfs, rename()
> could fail with EXDEV - Invalid cross-device link. This is due to fact

due to the

> that overlays doesn't support rename() is source and target are not on

s/is/if/

> the same layer, e.g. in rpm-ostree based containers. Even though it's
> not atomic operation, it's better to try to to copy files from src to

s/to to/to/

> dst on our own in this case. Next rebuild will probably not fail as the
> new directories will be on the same layer.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/343
> Before:
>     # semodule -B
>     libsemanage.semanage_commit_sandbox: Error while renaming /etc/selinux/targeted/active to /etc/selinux/targeted/previous. (Invalid cross-device link).
> semodule:  Failed!
>
> After:
>     # semodule -B
>     Warning: rename(/etc/selinux/targeted/active, /etc/selinux/targeted/previous) failed: Invalid cross-device link, fallback to non-atomic semanage_copy_dir_flags()
>
> Reported-by: Joseph Marrero Corchado <jmarrero@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/src/semanage_store.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 767f05cb2853..aa44ebb7e481 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -697,6 +697,10 @@ int semanage_store_access_check(void)
>
>  /********************* other I/O functions *********************/
>
> +static int semanage_rename(const char *tmp, const char *dst);
> +int semanage_remove_directory(const char *path);rename
> +static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
> +
>  /* Callback used by scandir() to select files. */
>  static int semanage_filename_select(const struct dirent *d)
>  {
> @@ -760,7 +764,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
>                 retval = -1;
>         }
>
> -       if (!retval && rename(tmp, dst) == -1)
> +       if (!retval && semanage_rename(tmp, dst) == -1)
>                 return -1;
>
>  out:
> @@ -768,7 +772,20 @@ out:
>         return retval;
>  }
>
> -static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
> +static int semanage_rename(const char *src, const char *dst) {
> +       int retval = -1;

The value is immediately overwritten, so there is no need to
initialize retval to -1 here.

> +
> +       retval = rename(src, dst);
> +       if (retval == 0 || errno != EXDEV)
> +               return retval;
> +
> +       /* we can't use rename() due to filesystem limitation, lets try to copy files manually */
> +       fprintf(stderr, "Warning: rename(%s, %s) failed: %s, fallback to non-atomic semanage_copy_dir_flags()\n", src, dst, strerror(errno));

I believe this should use the WARN() macro from debug.h instead. Also
s/fallback/fall back/.

> +       if (semanage_copy_dir_flags(src, dst, 1) == -1) {
> +               return -1;
> +       }
> +       return semanage_remove_directory(src);
> +}
>
>  /* Copies all of the files from src to dst, recursing into
>   * subdirectories.  Returns 0 on success, -1 on error. */
> @@ -1770,7 +1787,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>                 goto cleanup;
>         }
>
> -       if (rename(active, backup) == -1) {
> +       if (semanage_rename(active, backup) == -1) {
>                 ERR(sh, "Error while renaming %s to %s.", active, backup);
>                 retval = -1;
>                 goto cleanup;
> @@ -1779,12 +1796,12 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>         /* clean up some files from the sandbox before install */
>         /* remove homedir_template from sandbox */
>
> -       if (rename(sandbox, active) == -1) {
> +       if (semanage_rename(sandbox, active) == -1) {
>                 ERR(sh, "Error while renaming %s to %s.", sandbox, active);
>                 /* note that if an error occurs during the next
>                  * function then the store will be left in an
>                  * inconsistent state */
> -               if (rename(backup, active) < 0)
> +               if (semanage_rename(backup, active) < 0)
>                         ERR(sh, "Error while renaming %s back to %s.", backup,
>                             active);
>                 retval = -1;
> @@ -1795,10 +1812,10 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>                  * function then the store will be left in an
>                  * inconsistent state */
>                 int errsv = errno;
> -               if (rename(active, sandbox) < 0)
> +               if (semanage_rename(active, sandbox) < 0)
>                         ERR(sh, "Error while renaming %s back to %s.", active,
>                             sandbox);
> -               else if (rename(backup, active) < 0)
> +               else if (semanage_rename(backup, active) < 0)
>                         ERR(sh, "Error while renaming %s back to %s.", backup,
>                             active);
>                 else
> --
> 2.35.1
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

