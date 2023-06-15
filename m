Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD96EB64D9
	for <selinux@archiver.kernel.org>; Thu, 15 Jun 2023 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFOUb2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Jun 2023 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFOUb2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Jun 2023 16:31:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DF26A1
        for <selinux@vger.kernel.org>; Thu, 15 Jun 2023 13:31:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f849a0e371so695347e87.1
        for <selinux@vger.kernel.org>; Thu, 15 Jun 2023 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686861084; x=1689453084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqKQzP39kqJ6KntcOyovhMzwgHScJMBr5zTCrTiiS9w=;
        b=ZiXRv4u/mWXZy5hCTe7HQ888N9jojl+g7NY+ruDoLdWkJqIik1AvLLNpWxhXyw56/A
         01qsLe4Inya/20wY7YmrpQEmr6Bnz61Pb11h0Flxl1Es2dxXl9A1uxhg4fGmeis2hBUq
         0xqy0YUhqw14LPzIUW5p0yri/wFrqP/AozN/sBcD6VJ9Wux+TOSPhcYA0m8BYIfQyZRM
         hot2oj56OwTvjPPhIyD72auJLDzYQrl3zZqqxTMlY0nugSwzFwpAbZUXGuPEiUj19HCg
         wJvAiCzLYVR3OQ1FxKW8MRoahes0xxnIPGyoazGKE69ATgDYmPhd2dkNz5Z9mo2T59aI
         rGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686861084; x=1689453084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqKQzP39kqJ6KntcOyovhMzwgHScJMBr5zTCrTiiS9w=;
        b=fr1MQuOZuKg0V1r8XGCQ4Jg9LUuqg/VgvViBEW/z3pKIFDIBliVW7HxZLELX5zPsIs
         vXgiHMu4+L+Mt/JUAk2ChQBqdSYewH8q7DKzwpFLzbMzdEfnKtvdVwU2DKiUBY4HAeun
         4Kubxmmy5ft1iw+TYymBazFvOlPdtTTJDJZidma0M5AHyq137/7/9A1LhLwAH+i7DXIc
         qqT6WYPyp4LWqK+s+z/q/RfYD2PhLHlIT50Rg4dsQyCv5Fn+Xp+msMdeXhOrPQnvvFyI
         vZmbhinD+s3bQj6YMRY/m+9L+D9G1jxqgYG6R1hgYQJ2+1eREyCpoLNHBXDSNcGdHDUK
         jdNA==
X-Gm-Message-State: AC+VfDxziUHAp6tGCUDEy5cisQrtC51bIG5gYjPHGG68T2dv1gtNS4Ra
        Qd6Y7WD8LNcRcmrgqlLVnD4glLsAvYXLUMO2GEW5VJj34Vs=
X-Google-Smtp-Source: ACHHUZ7mpxqofNHVp1mM8+zUb0wZUP/0KEu0K5IuKQJiyCiSBOb4LNRGTAN4/dKQoxgmsvIxv8aNt/uBGS4JEmaK6Kk=
X-Received: by 2002:a2e:9542:0:b0:2b1:a89a:5f2b with SMTP id
 t2-20020a2e9542000000b002b1a89a5f2bmr361413ljh.2.1686861084153; Thu, 15 Jun
 2023 13:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230512102322.72235-1-cgzones@googlemail.com> <20230512102322.72235-2-cgzones@googlemail.com>
In-Reply-To: <20230512102322.72235-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Jun 2023 16:31:12 -0400
Message-ID: <CAP+JOzTRFByfdYUVqCmV+yTSZ1id5vjWyhSZE+3h04J3fibnrg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] libselinux: deprecate matchpathcon and
 compute_user interfaces
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 6:25=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Annotate interfaces of the matchpathcon family and
> security_compute_user(3) and security_compute_user_raw(3) as deprecated.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/include/selinux/selinux.h | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index 7f8deb65..4799dd1c 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -261,10 +261,12 @@ extern int security_compute_member_raw(const char *=
 scon,
>   */
>  extern int security_compute_user(const char * scon,
>                                  const char *username,
> -                                char *** con) selinux_nonnull((1,2,3)) s=
elinux_nodiscard;
> +                                char *** con) selinux_nonnull((1,2,3)) s=
elinux_nodiscard
> +                                              selinux_deprecated("Use ge=
t_ordered_context_list(3) family");
>  extern int security_compute_user_raw(const char * scon,
>                                      const char *username,
> -                                    char *** con) selinux_nonnull((1,2,3=
)) selinux_nodiscard;
> +                                    char *** con) selinux_nonnull((1,2,3=
)) selinux_nodiscard
> +                                                  selinux_deprecated("Us=
e get_ordered_context_list(3) family");
>
>  /* Validate a transition. This determines whether a transition from scon=
 to newcon
>     using tcon as the target for object class tclass is valid in the load=
ed policy.
> @@ -435,7 +437,7 @@ extern void selinux_flush_class_cache(void);
>  /* Set the function used by matchpathcon_init when displaying
>     errors about the file_contexts configuration.  If not set,
>     then this defaults to fprintf(stderr, fmt, ...). */
> -extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...));
> +extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...)) se=
linux_deprecated("matchpathcon family is deprecated");
>
>  /* Set the function used by matchpathcon_init when checking the
>     validity of a context in the file contexts configuration.  If not set=
,
> @@ -444,7 +446,7 @@ extern void set_matchpathcon_printf(void (*f) (const =
char *fmt, ...));
>     may include the 'path' and 'lineno' in such error messages. */
>  extern void set_matchpathcon_invalidcon(int (*f) (const char *path,
>                                                   unsigned lineno,
> -                                                 char *context));
> +                                                 char *context)) selinux=
_deprecated("matchpathcon family is deprecated");
>
>  /* Same as above, but also allows canonicalization of the context,
>     by changing *context to refer to the canonical form.  If not set,
> @@ -452,13 +454,13 @@ extern void set_matchpathcon_invalidcon(int (*f) (c=
onst char *path,
>     security_canonicalize_context(). */
>  extern void set_matchpathcon_canoncon(int (*f) (const char *path,
>                                                 unsigned lineno,
> -                                               char **context));
> +                                               char **context)) selinux_=
deprecated("matchpathcon family is deprecated");
>
>  /* Set flags controlling operation of matchpathcon_init or matchpathcon.=
 */
>  #define MATCHPATHCON_BASEONLY 1        /* Only process the base file_con=
texts file. */
>  #define MATCHPATHCON_NOTRANS  2        /* Do not perform any context tra=
nslation. */
>  #define MATCHPATHCON_VALIDATE 4        /* Validate/canonicalize contexts=
 at init time. */
> -extern void set_matchpathcon_flags(unsigned int flags);
> +extern void set_matchpathcon_flags(unsigned int flags) selinux_deprecate=
d("matchpathcon family is deprecated");
>

It seems that set_matchpathcon_printf(),
set_matchpathcon_invalidcon(), and set_matchpathcon_flags() should be
deprecated, but I can't find anything that says that they are.
Jim


>  /* Load the file contexts configuration specified by 'path'
>     into memory for use by subsequent matchpathcon calls.
> @@ -472,7 +474,7 @@ extern int matchpathcon_init(const char *path) selinu=
x_nodiscard selinux_depreca
>
>  /* Same as matchpathcon_init, but only load entries with
>     regexes that have stems that are prefixes of 'prefix'. */
> -extern int matchpathcon_init_prefix(const char *path, const char *prefix=
) selinux_nodiscard;
> +extern int matchpathcon_init_prefix(const char *path, const char *prefix=
) selinux_nodiscard selinux_deprecated("Use selabel_open(3) with backend SE=
LABEL_CTX_FILE");
>
>  /* Free the memory allocated by matchpathcon_init. */
>  extern void matchpathcon_fini(void) selinux_deprecated("Use selabel_clos=
e(3)");
> @@ -480,7 +482,7 @@ extern void matchpathcon_fini(void) selinux_deprecate=
d("Use selabel_close(3)");
>  /* Resolve all of the symlinks and relative portions of a pathname, but =
NOT
>   * the final component (same a realpath() unless the final component is =
a
>   * symlink.  Resolved path must be a path of size PATH_MAX + 1 */
> -extern int realpath_not_final(const char *name, char *resolved_path) sel=
inux_nonnull((1,2)) selinux_nodiscard;
> +extern int realpath_not_final(const char *name, char *resolved_path) sel=
inux_nonnull((1,2)) selinux_nodiscard selinux_deprecated("Not meant for ext=
ernal use");
>
>  /* Match the specified pathname and mode against the file contexts
>     configuration and set *con to refer to the resulting context.
> @@ -494,25 +496,25 @@ extern int matchpathcon(const char *path,
>  /* Same as above, but return a specification index for
>     later use in a matchpathcon_filespec_add() call - see below. */
>  extern int matchpathcon_index(const char *path,
> -                             mode_t mode, char ** con) selinux_nonnull((=
1,3)) selinux_nodiscard;
> +                             mode_t mode, char ** con) selinux_nonnull((=
1,3)) selinux_nodiscard selinux_deprecated("Use selabel_lookup(3)");
>
>  /* Maintain an association between an inode and a specification index,
>     and check whether a conflicting specification is already associated
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> -extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file) selinux_nonnull((3)) selinux_nodiscard;
> +extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file) selinux_nonnull((3)) selinux_nodiscard selinux_deprecated("matchpath=
con family is deprecated");
>
>  /* Destroy any inode associations that have been added, e.g. to restart
>     for a new filesystem. */
> -extern void matchpathcon_filespec_destroy(void);
> +extern void matchpathcon_filespec_destroy(void) selinux_deprecated("matc=
hpathcon family is deprecated");
>
>  /* Display statistics on the hash table usage for the associations. */
> -extern void matchpathcon_filespec_eval(void);
> +extern void matchpathcon_filespec_eval(void) selinux_deprecated("matchpa=
thcon family is deprecated");
>
>  /* Check to see whether any specifications had no matches and report the=
m.
>     The 'str' is used as a prefix for any warning messages. */
> -extern void matchpathcon_checkmatches(char *str);
> +extern void matchpathcon_checkmatches(char *str) selinux_deprecated("mat=
chpathcon family is deprecated");
>
>  /* Match the specified media and against the media contexts
>     configuration and set *con to refer to the resulting context.
> --
> 2.40.1
>
