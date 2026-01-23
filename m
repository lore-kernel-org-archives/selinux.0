Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC0318EC9
	for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181238; cv=pass; b=OxqX+bbnBJ8tQ3y8C3XGp+GTsTUkCMc4GmT5xRRKbdxBEkKCiRSBd4843RNirX9MWbVICHVmrK6fJrUuzlUEZwkeHuN99vHDLzb8Sz7/70ZGehbYv+htpFqvqua4w/Q2Eq4NZJ4FmpUoGgdL82SgNRuuwwR8bfIgKdAUfdFr+I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181238; c=relaxed/simple;
	bh=2vD9io302ZX4udB5PSh1e2XgWbC4f3DX7jHE3Ra2Uh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e29JCHp8eX486lKtIt2aHq1HtTZeAj9dRBXWbDkoV8IUc5DpkSE12C2h+txBBVqeaw7UFLLA3xCiIil+XhVbnq6iBgRdgxxnblg/KxTuWecgoxckPMX9BFNhzGfxay0cRhzX+Sl78iMKDtqSWLFcBaV87B7uYJP9ak8s9zGGxjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg8ThsNe; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg8ThsNe"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-382f9211cbfso21629621fa.0
        for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 07:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769181231; cv=none;
        d=google.com; s=arc-20240605;
        b=RmcsMIr+bN6j1hpwuWqKHN6xEhugJBfc1xGdPCqA5LyI8Gd1gzs1Jtt03RwjRtUCgs
         unFdVBWK6aEsWPS+eC/IHgS9oFo0f9V+Lr8XEwDsaTACH8NDQa3/GVL8rVrGk5H61mn8
         V/kveH7HpbKLB0CbLGKGN01tpTJkfURQ89IFs0PTvSg+F+EMgJIkdrVnTI3CToWJ/a9o
         hUxwj4DECmMO/TU6+2Vn6NGKwGfMQ0tm1DSfzHb4t+0xRywDIMkvHWUM8Lsfq0pdoAOi
         6SPzstFcTT6l9YJID8GKd+XzUNKYmiL81E4lPsbbelS+qPPSOuRMoyojVXzk9aPT56ov
         nSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0cpCF3C8EDgNTze/ZGr6TpJnsjgAF4aktTtg2gswDXc=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=byEoo2BgSaGyO4XlFA7UtUDVnI0h3DqlXF2tgHAJUswwf7GI0vNb4hJz3qUKB+xD5Y
         Z/xq2mmzAbY07WWLpmRn5kS3d4JQ/6hAhprHqcv28aSe6USrt7VtbiRconHw0kKarWbR
         WKlT+kZuwyu3BX5VYgTlzJf2rHD6/qXIohknIcIM52twNi+kaHYOvPtN9uf344ucM1TX
         GpjedumreWt+KepJCcUg4O0qjW4pwsv+UJfZMZO65yhyQlULN4nc2+RqSPI06DXhqEMV
         zAbgXOvv8PmaEy8e+BEdXcGm4gtkv+hOtc9DApG3ZFbAoipyPYn9ygCVEY4b3BXBN6Yh
         77rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769181231; x=1769786031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cpCF3C8EDgNTze/ZGr6TpJnsjgAF4aktTtg2gswDXc=;
        b=Hg8ThsNe7x92mkdrhmeWCtfg7LBuIhPCg4BZvoeliBT4uOLURYApU4ephqScWjfVR+
         I2yKU/AvDRLFvlk4DUutOlOqD16laRsNQGQgWjtXaDEimWNEZ1FXbDxPHRjlOLjwO0Qb
         v1dyMgDdKqwROm4gGRflJNNtfUOWADPJzithkkdnRa2iS3brRe5TYW3Jyx4kg3mzUEfX
         ItXXO1XV14d67dnYOVQ+NJQMDnveFTwC+tyMQpmth6Q+O5vTt/iaCXxTG1JuwL7wwkzB
         og/jdBsN8s4zA5xecyVdwbM3YBn8Siegq/S7uhKAPS9kECpd/INaPT5vr9Hv5nQCJruu
         I1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769181231; x=1769786031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cpCF3C8EDgNTze/ZGr6TpJnsjgAF4aktTtg2gswDXc=;
        b=ls4rjVIocZ7tDT4sS/M3+KnqUM3hHNZJH5owtm5JM4H5Sb1HX1YE4RnGUjq/mdBp/P
         bjpdzPuOh9OitsFMMyUxS7luJP/HbhajI9bbHXrv+Eo+JcLNAeOhm8AMdD0nMeghrcVe
         zxiBkPorlUMF/UhSA7vCNDiJ0pGWSErg8RVLGJ8xVQTviJV06oU6rc/1SFvEc2SS+i1a
         GZbECy3eapI8UNWVF9HCttbY7+phwrMMzPzjVPHVRgPvVXWXR6tJWsBSDufFhCyQC4Ba
         bDDOPA3RatfEAOnxG9u4uA93yXUlk7xwHZbM26MKYmyYi4Kh1Vn148ymxyvAooXL+DHF
         r0lQ==
X-Gm-Message-State: AOJu0YzvZRjNKZJC1yYvN5mWUatRHi3EY0IatPf6yuCR+eYxjnMJE88B
	eJIqGrv4Z+wVvCd35JTIcLDNpAsKD8fAM6MFxGcujPNaGL6N+Q2LV6D6hH7UG0LZRUJ1z9Pwvlu
	LrMC2J5DoTeq7pWCbYq4PryBesLnYagg=
X-Gm-Gg: AZuq6aI4bXvVZSBMZB77SyJy11FPeqa6IaObeicvGs+7Ct6N1zRcYRNy7SfvnxAphip
	qnjav1P35tth1Jj78mMhh9zts5IbUAPPc1KbVTASVibvcYJIISIP2zLHKGDTHcQVpfZJA6ola4L
	ZObu2y/8uKR4fj+UTFLw+/X+qX6hWgY6Ya3s0dHaAZC5D2OQq/atBuCeRWDTA9rr6kXD1WMAkHv
	Jl2OAluyy6abCoQnYBoAHzNtF7/kTAsp+PcEN9rKoqVsetvPfli3K3hCg9kj1s478Y5rIUn5bJC
	WMY=
X-Received: by 2002:a05:651c:a0a:b0:37a:3fbf:b16f with SMTP id
 38308e7fff4ca-385d9f79306mr9183441fa.19.1769181230494; Fri, 23 Jan 2026
 07:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87wm3nemxe.fsf@redhat.com> <20251118201145.984733-1-vmojzis@redhat.com>
In-Reply-To: <20251118201145.984733-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 23 Jan 2026 10:13:38 -0500
X-Gm-Features: AZwV_QjtN4O2qeEuv4LbUnTB_U4v7THi5hkgPnk18JY6_KXSY5oZ29MafNXKwb4
Message-ID: <CAP+JOzS4MHOaNSH1xMhiKGh5fcX3EEKQb42iu6k+A_AGkW4-YA@mail.gmail.com>
Subject: Re: [PATCH v3] restorecon: Add option to count relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:12=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> This is useful in case we want to check that a remediation using
> restorecon was successful (otherwise 0 is always returned, even if no
> files were relabeled).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/restorecon.h | 15 +++++++++++
>  libselinux/src/libselinux.map           |  5 ++++
>  libselinux/src/selinux_restorecon.c     | 34 ++++++++++++++++++++++---
>  policycoreutils/setfiles/restore.c      | 12 ++++++---
>  policycoreutils/setfiles/restore.h      |  3 ++-
>  policycoreutils/setfiles/restorecon.8   |  3 +++
>  policycoreutils/setfiles/setfiles.c     | 26 ++++++++++++++-----
>  7 files changed, 83 insertions(+), 15 deletions(-)
>
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index 0ccf73a6..65aaef23 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -134,6 +134,11 @@ extern int selinux_restorecon_parallel(const char *p=
athname,
>   */
>  #define SELINUX_RESTORECON_SET_USER_ROLE               0x40000
>
> +/*
> + * Count the number of relabeled files (or would be relabeled if "nochan=
ge" was not set).
> + */
> + #define SELINUX_RESTORECON_COUNT_RELABELED            0x80000
> +
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
>   * @hndl: specifies handle to set as the global fc handle.
> @@ -228,6 +233,16 @@ extern int selinux_restorecon_xattr(const char *path=
name,
>   */
>  extern long unsigned selinux_restorecon_get_skipped_errors(void);
>
> +/* selinux_restorecon_get_relabeled_files - Get the number of relabeled =
files
> + *
> + * If SELINUX_RESTORECON_COUNT_RELABELED was passed to selinux_restoreco=
n(3) or
> + * selinux_restorecon_parallel(3), this function returns the number of f=
iles
> + * that were successfully relabeled.
> + * If the SELINUX_RESTORECON_NOCHANGE flag was set, this function return=
s
> + * the number of files that would be relabeled.
> + */
> +extern long unsigned selinux_restorecon_get_relabeled_files(void);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index ab002f01..95cd53b0 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -262,3 +262,8 @@ LIBSELINUX_3.9 {
>    global:
>      context_to_str;
>  } LIBSELINUX_3.8;
> +
> +LIBSELINUX_3.10 {
> +  global:
> +    selinux_restorecon_get_relabeled_files;
> +} LIBSELINUX_3.9;
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 681c69db..8fadf4d2 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
>  /* Number of errors ignored during the file tree walk. */
>  static long unsigned skipped_errors;
>
> +/* Number of successfully relabeled files or files that would be relabel=
ed */
> +static long unsigned relabeled_files;
> +
>  /* restorecon_flags for passing to restorecon_sb() */
>  struct rest_flags {
>         bool nochange;
> @@ -88,6 +91,7 @@ struct rest_flags {
>         bool warnonnomatch;
>         bool conflicterror;
>         bool count_errors;
> +       bool count_relabeled;
>  };
>
>  static void restorecon_init(void)
> @@ -650,11 +654,12 @@ out:
>  }
>
>  static int restorecon_sb(const char *pathname, const struct stat *sb,
> -                           const struct rest_flags *flags, bool first)
> +                           const struct rest_flags *flags, bool first, b=
ool *updated_out)
>  {
>         char *newcon =3D NULL;
>         char *curcon =3D NULL;
>         int rc;
> +       bool updated =3D false;
>         const char *lookup_path =3D pathname;
>
>         if (rootpath) {
> @@ -736,7 +741,6 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>         }
>
>         if (curcon =3D=3D NULL || strcmp(curcon, newcon) !=3D 0) {
> -               bool updated =3D false;
>
>                 if (!flags->set_specctx && curcon &&
>                                     (is_context_customizable(curcon) > 0)=
) {
> @@ -796,9 +800,14 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                                 syslog(LOG_INFO, "labeling %s to %s\n",
>                                             pathname, newcon);
>                 }
> +
> +               /* Note: relabel counting handled by caller */
> +
>         }
>
>  out:
> +       if (updated_out)
> +               *updated_out =3D updated;
>         rc =3D 0;
>  out1:
>         freecon(curcon);
> @@ -887,6 +896,7 @@ struct rest_state {
>         bool abort;
>         int error;
>         long unsigned skipped_errors;
> +       long unsigned relabeled_files;
>         int saved_errno;
>         pthread_mutex_t mutex;
>  };
> @@ -1010,8 +1020,9 @@ loop_body:
>                         if (state->parallel)
>                                 pthread_mutex_unlock(&state->mutex);
>
> +                       bool updated =3D false;
>                         error =3D restorecon_sb(ent_path, &ent_st, &state=
->flags,
> -                                             first);
> +                                             first, &updated);
>
>                         if (state->parallel) {
>                                 pthread_mutex_lock(&state->mutex);
> @@ -1030,6 +1041,8 @@ loop_body:
>                                         state->skipped_errors++;
>                                 else
>                                         state->error =3D error;
> +                       } else if (updated && state->flags.count_relabele=
d) {
> +                               state->relabeled_files++;
>                         }
>                         break;
>                 }
> @@ -1087,6 +1100,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                     SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
>         state.flags.count_errors =3D (restorecon_flags &
>                     SELINUX_RESTORECON_COUNT_ERRORS) ? true : false;
> +       state.flags.count_relabeled =3D (restorecon_flags &
> +                   SELINUX_RESTORECON_COUNT_RELABELED) ? true : false;
>         state.setrestorecondigest =3D true;
>
>         state.head =3D NULL;
> @@ -1094,6 +1109,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         state.abort =3D false;
>         state.error =3D 0;
>         state.skipped_errors =3D 0;
> +       state.relabeled_files =3D 0;
>         state.saved_errno =3D 0;
>
>         struct stat sb;
> @@ -1215,7 +1231,11 @@ static int selinux_restorecon_common(const char *p=
athname_orig,
>                         goto cleanup;
>                 }
>
> -               error =3D restorecon_sb(pathname, &sb, &state.flags, true=
);
> +               bool updated =3D false;
> +               error =3D restorecon_sb(pathname, &sb, &state.flags, true=
, &updated);
> +               if (updated && state.flags.count_relabeled) {
> +                       state.relabeled_files++;
> +               }
>                 goto cleanup;
>         }
>
> @@ -1341,6 +1361,7 @@ out:
>         (void) fts_close(state.fts);
>         errno =3D state.saved_errno;
>  cleanup:
> +       relabeled_files =3D state.relabeled_files;
>         if (state.flags.add_assoc) {
>                 if (state.flags.verbose)
>                         filespec_eval();
> @@ -1618,3 +1639,8 @@ long unsigned selinux_restorecon_get_skipped_errors=
(void)
>  {
>         return skipped_errors;
>  }
> +
> +long unsigned selinux_restorecon_get_relabeled_files(void)
> +{
> +       return relabeled_files;
> +}
> diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfile=
s/restore.c
> index 2c031ccc..07582e7c 100644
> --- a/policycoreutils/setfiles/restore.c
> +++ b/policycoreutils/setfiles/restore.c
> @@ -43,7 +43,7 @@ void restore_init(struct restore_opts *opts)
>                            opts->syslog_changes | opts->log_matches |
>                            opts->ignore_noent | opts->ignore_mounts |
>                            opts->mass_relabel | opts->conflict_error |
> -                          opts->count_errors;
> +                          opts->count_errors | opts->count_relabeled;
>
>         /* Use setfiles, restorecon and restorecond own handles */
>         selinux_restorecon_set_sehandle(opts->hnd);
> @@ -75,7 +75,7 @@ void restore_finish(void)
>  }
>
>  int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
> -                long unsigned *skipped_errors)
> +                long unsigned *skipped_errors, long unsigned *relabeled_=
files)
>  {
>         glob_t globbuf;
>         size_t i, len;
> @@ -99,8 +99,12 @@ int process_glob(char *name, struct restore_opts *opts=
, size_t nthreads,
>                                                  nthreads);
>                 if (rc < 0)
>                         errors =3D rc;
> -               else if (opts->restorecon_flags & SELINUX_RESTORECON_COUN=
T_ERRORS)
> -                       *skipped_errors +=3D selinux_restorecon_get_skipp=
ed_errors();
> +               else {
> +                       if (opts->restorecon_flags & SELINUX_RESTORECON_C=
OUNT_ERRORS)
> +                               *skipped_errors +=3D selinux_restorecon_g=
et_skipped_errors();
> +                       if (opts->restorecon_flags & SELINUX_RESTORECON_C=
OUNT_RELABELED)
> +                               *relabeled_files +=3D selinux_restorecon_=
get_relabeled_files();
> +               }
>         }
>
>         globfree(&globbuf);
> diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfile=
s/restore.h
> index 95afb960..36f73059 100644
> --- a/policycoreutils/setfiles/restore.h
> +++ b/policycoreutils/setfiles/restore.h
> @@ -37,6 +37,7 @@ struct restore_opts {
>         unsigned int ignore_mounts;
>         unsigned int conflict_error;
>         unsigned int count_errors;
> +       unsigned int count_relabeled;
>         /* restorecon_flags holds | of above for restore_init() */
>         unsigned int restorecon_flags;
>         char *rootpath;
> @@ -52,7 +53,7 @@ void restore_init(struct restore_opts *opts);
>  void restore_finish(void);
>  void add_exclude(const char *directory);
>  int process_glob(char *name, struct restore_opts *opts, size_t nthreads,
> -                long unsigned *skipped_errors);
> +                long unsigned *skipped_errors, long unsigned *relabeled_=
files);
>  extern char **exclude_list;
>
>  #endif
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setf=
iles/restorecon.8
> index 1134420e..b7ff9715 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -153,6 +153,9 @@ display warnings about entries that had no matching f=
iles by outputting the
>  .BR selabel_stats (3)
>  results.
>  .TP
> +.B \-c
> +count and display the number of (would be) relabeled files. The exit cod=
e will be set to 0 only if at least one file is relabeled.
> +.TP
>  .B \-0
>  the separator for the input items is assumed to be the null character
>  (instead of the white space).  The quotes and the backslash characters a=
re
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 31034316..351940f3 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -35,8 +35,8 @@ static __attribute__((__noreturn__)) void usage(const c=
har *const name)
>  {
>         if (iamrestorecon) {
>                 fprintf(stderr,
> -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] pat=
hname...\n"
> -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -f =
filename\n",
> +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] pa=
thname...\n"
> +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] -f=
 filename\n",
>                         name, name);
>         } else {
>                 fprintf(stderr,
> @@ -146,11 +146,12 @@ int main(int argc, char **argv)
>         size_t buf_len, nthreads =3D 1;
>         const char *base;
>         int errors =3D 0;
> -       const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> +       const char *ropts =3D "ce:f:hiIDlmno:pqrsvFURW0xT:";
>         const char *sopts =3D "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
>         const char *opts;
>         union selinux_callback cb;
>         long unsigned skipped_errors;
> +       long unsigned relabeled_files;
>
>         /* Initialize variables */
>         memset(&r_opts, 0, sizeof(r_opts));
> @@ -160,6 +161,7 @@ int main(int argc, char **argv)
>         request_digest =3D 0;
>         policyfile =3D NULL;
>         skipped_errors =3D 0;
> +       relabeled_files =3D 0;
>
>         if (!argv[0]) {
>                 fprintf(stderr, "Called without required program name!\n"=
);
> @@ -223,7 +225,10 @@ int main(int argc, char **argv)
>         while ((opt =3D getopt(argc, argv, opts)) > 0) {
>                 switch (opt) {
>                 case 'c':
> -                       {
> +                       if (iamrestorecon) {
> +                               r_opts.count_relabeled =3D SELINUX_RESTOR=
ECON_COUNT_RELABELED;
> +                               break;
> +                       } else {
>                                 FILE *policystream;
>
>                                 policyfile =3D optarg;
> @@ -457,14 +462,14 @@ int main(int argc, char **argv)
>                         if (!strcmp(buf, "/"))
>                                 r_opts.mass_relabel =3D SELINUX_RESTORECO=
N_MASS_RELABEL;
>                         errors |=3D process_glob(buf, &r_opts, nthreads,
> -                                              &skipped_errors) < 0;
> +                                              &skipped_errors, &relabele=
d_files) < 0;
>                 }
>                 if (strcmp(input_filename, "-") !=3D 0)
>                         fclose(f);
>         } else {
>                 for (i =3D optind; i < argc; i++)
>                         errors |=3D process_glob(argv[i], &r_opts, nthrea=
ds,
> -                                              &skipped_errors) < 0;
> +                                              &skipped_errors, &relabele=
d_files) < 0;
>         }
>
>         if (r_opts.mass_relabel && !r_opts.nochange)
> @@ -479,5 +484,14 @@ int main(int argc, char **argv)
>         if (r_opts.progress)
>                 fprintf(stdout, "\n");
>
> +       /* Output relabeled file count if requested */
> +       if (r_opts.count_relabeled) {
> +               long unsigned relabeled_count =3D selinux_restorecon_get_=
relabeled_files();
> +               printf("Relabeled %lu files\n", relabeled_count);
> +
> +               /* Set exit code to 0 if at least one file was relabeled =
*/
> +               exit(errors ? -1 : relabeled_count ? 0 : 1);
> +       }
> +
>         exit(errors ? -1 : skipped_errors ? 1 : 0);
>  }
> --
> 2.51.1
>
>
