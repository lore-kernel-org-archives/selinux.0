Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B424C433F5
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbiELRjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357125AbiELRjG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 13:39:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423035DBE7
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e656032735so7587669fac.0
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aoFLVgOdhmB2kSs5sZL7f6b/dmHrndOj+Y5nNt6vJxs=;
        b=A4iEP4ZXFjf6nG4A7I6nywdmlJR5Da1OuvkzyyVwtj6OzL6JeKdTObEQlSHtAiDudR
         BlENL+n88/ECrtwgF8xuE/5ZK09SeSNQfb46YvayYvVQnHxmuFJIZglOEUMSZz7WK5lr
         /ISLcNSC59kkPnzNOIL0D9/62vYqcZD6qeFs10Jihap1cTKpN4VUuXaLGUcQ82rWCGP9
         anXFVR+keJcfN33CfK8fvhKLXUV4zvbM9Eho0nKHvKJhinBdIHiJ8DchGcNvbMO9IxOW
         mMrFdjOkKfiUaD9ibgkahDfyP6CK3ydJnKIKgOwDi83aMtyB28/tSZ6ZMkzsj83iiwpP
         5RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aoFLVgOdhmB2kSs5sZL7f6b/dmHrndOj+Y5nNt6vJxs=;
        b=pHy5tqae2wqxzOkuVLSnSZ+1nkxITWacufja2U3YLsMENSg0zpNansQHiOonn+YH+N
         MI1sZ79doTmLjRGVqVkKL0jmHY18YV8Ie/INYK4/kS+NeckBSa4QXosU4FpAFTggPU4S
         CXFeeQs6kpK6W4RULGylfKXRXEFK2e9ZOfmaa0g7VDcafOUv6qhTy0CrLJk7SbvVCIXx
         VMNBep9s2KI0+GkFxWfTOWuM9Az/uv2e0jHCkh/LCqNmANO8nXLPLBuloXfOMe5iE4tL
         O9//Kc9VE8ZFi4BYORsMjDliMWEm73xtkYjqBbj5N3X3fM52C0y+UEm58mWBhUC2Hyf8
         J8kw==
X-Gm-Message-State: AOAM5327krzAJ1oY6kYjZk4Z7KYQoKJgn5YJIbOMUywX4KOzh3iwn4/D
        nIFMqGny6BlnVGLk0R/ju8l/gTW4x1GRgXKpXoo=
X-Google-Smtp-Source: ABdhPJxZJlv28beF4CpzuHZwccu9+eZQxxPpL2kuBuHWIoa4AAUfvfySyfBZepm6jZSWs6NC02ky9TVbLKJBgJSFhAU=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr541202oab.182.1652377144552; Thu, 12
 May 2022 10:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com> <20220511184225.218062-1-cgzones@googlemail.com>
In-Reply-To: <20220511184225.218062-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 13:38:53 -0400
Message-ID: <CAP+JOzRJtgXVvAFjuB1sV6C3HifnMQQNW+b0rDD=Zc0pbpt7+g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] libselinux: restorecon: misc tweaks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 11, 2022 at 7:58 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * mark read-only parameters const
> * check for overflow when adding exclude directory
> * use 64 bit integer for file counting
> * avoid implicit conversions
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index e6192912..c158ead8 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -44,7 +44,7 @@
>  static struct selabel_handle *fc_sehandle =3D NULL;
>  static bool selabel_no_digest;
>  static char *rootpath =3D NULL;
> -static int rootpathlen;
> +static size_t rootpathlen;
>
>  /* Information on excluded fs and directories. */
>  struct edir {
> @@ -55,7 +55,7 @@ struct edir {
>  };
>  #define CALLER_EXCLUDED true
>  static bool ignore_mounts;
> -static int exclude_non_seclabel_mounts(void);
> +static uint64_t exclude_non_seclabel_mounts(void);
>  static int exclude_count =3D 0;
>  static struct edir *exclude_lst =3D NULL;
>  static uint64_t fc_count =3D 0;  /* Number of files processed so far */
> @@ -169,6 +169,12 @@ static int add_exclude(const char *directory, bool w=
ho)
>                 return -1;
>         }
>
> +       if (exclude_count >=3D INT_MAX - 1) {
> +               selinux_log(SELINUX_ERROR, "Too many directory excludes: =
%d.\n", exclude_count);
> +               errno =3D EOVERFLOW;
> +               return -1;
> +       }
> +
>         tmp_list =3D realloc(exclude_lst,
>                            sizeof(struct edir) * (exclude_count + 1));
>         if (!tmp_list)
> @@ -211,10 +217,10 @@ static int check_excluded(const char *file)
>         return 0;
>  }
>
> -static int file_system_count(char *name)
> +static uint64_t file_system_count(const char *name)
>  {
>         struct statvfs statvfs_buf;
> -       int nfile =3D 0;
> +       uint64_t nfile =3D 0;
>
>         memset(&statvfs_buf, 0, sizeof(statvfs_buf));
>         if (!statvfs(name, &statvfs_buf))
> @@ -230,12 +236,13 @@ static int file_system_count(char *name)
>   * that support security labels have the seclabel option, return
>   * approximate total file count.
>   */
> -static int exclude_non_seclabel_mounts(void)
> +static uint64_t exclude_non_seclabel_mounts(void)
>  {
>         struct utsname uts;
>         FILE *fp;
>         size_t len;
> -       int index =3D 0, found =3D 0, nfile =3D 0;
> +       int index =3D 0, found =3D 0;
> +       uint64_t nfile =3D 0;
>         char *mount_info[4];
>         char *buf =3D NULL, *item;
>
> @@ -300,7 +307,8 @@ static int add_xattr_entry(const char *directory, boo=
l delete_nonmatch,
>  {
>         char *sha1_buf =3D NULL;
>         size_t i, digest_len =3D 0;
> -       int rc, digest_result;
> +       int rc;
> +       enum digest_result digest_result;
>         bool match;
>         struct dir_xattr *new_entry;
>         uint8_t *xattr_digest =3D NULL;
> @@ -573,7 +581,7 @@ static void filespec_destroy(void)
>   * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
>   * the type components differ, updating newtypecon if so.
>   */
> -static int compare_types(char *curcon, char *newcon, char **newtypecon)
> +static int compare_types(const char *curcon, const char *newcon, char **=
newtypecon)
>  {
>         int types_differ =3D 0;
>         context_t cona;
> @@ -1398,7 +1406,7 @@ void selinux_restorecon_set_exclude_list(const char=
 **exclude_list)
>  /* selinux_restorecon_set_alt_rootpath(3) sets an alternate rootpath. */
>  int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
>  {
> -       int len;
> +       size_t len;
>
>         /* This should be NULL on first use */
>         if (rootpath)
> --
> 2.36.1
>
