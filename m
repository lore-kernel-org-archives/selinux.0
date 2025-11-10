Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D128000B
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806217; cv=none; b=AsqWGRavUfCIfE4i6a6FECJaNxhrti2ueixtHkuQdK8PYLY4jYeTIEymUG1/0Ea2d00zPl3wfEZbemD3XPmoI8ARRXcEaQSiAp9cN1aQUrC2/rqP+qld77VAK7zp7Qc14Hj1MS5498ZqPaB8SQ14Ltn0lEXw9FmYVh8mJ52rY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806217; c=relaxed/simple;
	bh=41QXAjlMjaQbQUhzbNkb4QEAImkKbnMZH8PFBFzuUWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH3QiroA4SanG8/7OVLKDMp47fXaq6K1ChGMOU+2/TPGWvYT2zxiC+O0a4Ja3WFQozBeNNqgJ3ZllocXFjFwRhy7DRigSk+mhwVEa/mOdioWqxP/1Kq8nRWE0BtF2orPaz8OwyZD9bYs0ufjQf3zNpB4phce4nedACIX7EjTdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKAML3wC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKAML3wC"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso3334480e87.2
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806213; x=1763411013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TDsXvOwoXnAifXBvsjEk9Q8GTS5WqXGgb2tOu6E1PE=;
        b=aKAML3wCtseiIBNzvdvcwN/Mj2qUnlUjUEPjcPUQ5shkOXeTFPA3zNSOfNpxlwu9Bv
         vBcZ5PGYjqA3Lokj/gDPc/tWNVoX3FrzDdZrvI0kX4/AtYEv0m8jksxqIqwqLZP2f59x
         O5Ah8ywknIn9DoA+ugAG9P91C6jYthM1p/wizYyaIwDTBuq10cwspxMs9ODoqXn504Pw
         ATMCo1byVveZoA83MWqmtVLWIKy2FXRHdKiYGaTatj3g24WgvOuGd43fn+TfY4yFSi7/
         sYI6U1zhOXddFGjZXOBT48EXY7xiFvUR05Bl6RDKX/tUzr+BGPXfsnYu0KJaaWpU/5r8
         rnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806213; x=1763411013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TDsXvOwoXnAifXBvsjEk9Q8GTS5WqXGgb2tOu6E1PE=;
        b=SmPjo9bT2+l07N+KhjeSauh36GZbm3OEhFRiF3mQFFCOPBrLK6vO4epM5j0TqJtfId
         aBSxcEg+jURXRDIE+gQSEZq7yUCrSYoyyAEmNZMQpkbVqtWWZdAE4ZVYQtUg7OpJHI0S
         axkssnWdn1cEVHE9XcG48DHxgdKYn6Y+a4BKV5u1ECLX2QW30s9Ajw2IK7TgMdDHzTRp
         rNeM8OdfLxhz31lodkdShWAZD9s1G32IZffT59LLumn9DoybE7ATuZE8OrU7zpRVbUIz
         cXISAa7cuJFPSTTcb0V840NXwoU1e/je/N5etZpPRg2qppBLxWuRBWGbs0db+1Uy2AQ4
         U0pA==
X-Gm-Message-State: AOJu0Yxc6a3k7EbO4PE9Ym+cb6uWu7w5a9P4zf9XDIN5UlilvN+L+jpj
	6CT23Yk/jmm1G+SMI+BeAnfeAn0X0gJIjlw0Z2wWox2watWo9oMSwZQZmFWof2x0JnpTcXpVpDG
	oORztRpLgESg/qfTDNUpheaiMIga/p5mRUg==
X-Gm-Gg: ASbGncsSl+TMToYj6sUmXqx9KxnEQuFVRyJ/o64iLPoetg3ntiKxLhFkM5pY/NzKDze
	vuPUxtqVvs6JAZKqs0mg5MudPrvq6XCh/EiH5KI+rTIWvFkZV7MfnSHVsx6BqiMLAiqdkZVaO4C
	fuouxnZ77sbpNICjTmIXkbgcEivITnVLm9b2wwPsoV6Y4Q1M6wuEytzmUSqpOMF6vi/eBavR3h/
	161JRi9svoeg9tuBUBbQx/AipXksQNNF1B7usFqf5HJ/HSA9KT4JjrgNLbwV+PFXgGQ8zWU
X-Google-Smtp-Source: AGHT+IFG2VxMCdFoptSdf3VaytiaBpLigJRbTpPsnoqooraIIYWimN991EZ/q9af70Y8a/X4Vdf9Oc2BtT9SKKm8o+A=
X-Received: by 2002:a05:6512:31cf:b0:587:68fc:c4f with SMTP id
 2adb3069b0e04-5945f1fcc1emr2386578e87.53.1762806212779; Mon, 10 Nov 2025
 12:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com>
In-Reply-To: <20251110180935.202229-1-vmojzis@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 10 Nov 2025 14:23:20 -0600
X-Gm-Features: AWmQ_blWf8GS14-R80Erhgt7KtP4DujwXFgqh4cbcncD3KDZThpbGIWc8lUV_Ww
Message-ID: <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> This is useful in case we want to check that a remediation using
> restorecon was successful (otherwise 0 is always returned, even if no
> files where relabeled).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libselinux/include/selinux/restorecon.h |  9 +++++++++
>  libselinux/src/libselinux.map           |  1 +
>  libselinux/src/selinux_restorecon.c     | 14 ++++++++++++++
>  policycoreutils/setfiles/restore.h      |  1 +
>  policycoreutils/setfiles/restorecon.8   |  3 +++
>  policycoreutils/setfiles/setfiles.c     | 24 ++++++++++++++++++++----
>  6 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index 0ccf73a6..736481bb 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -228,6 +228,15 @@ extern int selinux_restorecon_xattr(const char *path=
name,
>   */
>  extern long unsigned selinux_restorecon_get_skipped_errors(void);
>
> +/* selinux_restorecon_get_relabeled_files - Get the number of relabeled =
files
> + *
> + * If selinux_restorecon(3) or selinux_restorecon_parallel(3) was called=
,
> + * this function returns the number of files that were successfully rela=
beled.
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
> index ab002f01..f21e089e 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -244,6 +244,7 @@ LIBSELINUX_1.0 {
>  LIBSELINUX_3.4 {
>    global:
>      selinux_restorecon_get_skipped_errors;
> +    selinux_restorecon_get_relabeled_files;
>      selinux_restorecon_parallel;
>  } LIBSELINUX_1.0;
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 681c69db..6e9a159e 100644
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
> @@ -796,6 +799,10 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                                 syslog(LOG_INFO, "labeling %s to %s\n",
>                                             pathname, newcon);
>                 }
> +
> +               /* Count relabeled files (or would be relabeled if "nocha=
nge" was not set) */
> +               relabeled_files++;
> +
>         }
>
>  out:
> @@ -1096,6 +1103,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         state.skipped_errors =3D 0;
>         state.saved_errno =3D 0;
>
> +       relabeled_files =3D 0;
> +
>         struct stat sb;
>         char *pathname =3D NULL, *pathdnamer =3D NULL, *pathdname, *pathb=
name;
>         char *paths[2] =3D { NULL, NULL };
> @@ -1618,3 +1627,8 @@ long unsigned selinux_restorecon_get_skipped_errors=
(void)
>  {
>         return skipped_errors;
>  }
> +
> +long unsigned selinux_restorecon_get_relabeled_files(void)
> +{
> +       return relabeled_files;
> +}
> diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfile=
s/restore.h
> index 95afb960..7c949c1c 100644
> --- a/policycoreutils/setfiles/restore.h
> +++ b/policycoreutils/setfiles/restore.h
> @@ -37,6 +37,7 @@ struct restore_opts {
>         unsigned int ignore_mounts;
>         unsigned int conflict_error;
>         unsigned int count_errors;
> +       unsigned int count_relabeled;

It's using unsigned int, but other places use unsigned long. Wouldn't we wa=
nt to
keep this consistent to prevent truncating long to int? Do we care
about rollovers?
It's unlikely to happen, but some file systems don't have bounds on
the number of files,
also can't restorecon go across fs boundaries, so the count could be
high, albeit unlikely.

>         /* restorecon_flags holds | of above for restore_init() */
>         unsigned int restorecon_flags;
>         char *rootpath;
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setf=
iles/restorecon.8
> index 1134420e..e9bd16b6 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -153,6 +153,9 @@ display warnings about entries that had no matching f=
iles by outputting the
>  .BR selabel_stats (3)
>  results.
>  .TP
> +.B \-c
> +count and display the number of (would be) relabeled files. The exit cod=
e will be set to the number of relabeled files (capped at 254).
> +.TP
>  .B \-0
>  the separator for the input items is assumed to be the null character
>  (instead of the white space).  The quotes and the backslash characters a=
re
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 31034316..6323f56c 100644
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
> @@ -146,7 +146,7 @@ int main(int argc, char **argv)
>         size_t buf_len, nthreads =3D 1;
>         const char *base;
>         int errors =3D 0;
> -       const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> +       const char *ropts =3D "ce:f:hiIDlmno:pqrsvFURW0xT:";
>         const char *sopts =3D "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
>         const char *opts;
>         union selinux_callback cb;
> @@ -223,7 +223,10 @@ int main(int argc, char **argv)
>         while ((opt =3D getopt(argc, argv, opts)) > 0) {
>                 switch (opt) {
>                 case 'c':
> -                       {
> +                       if (iamrestorecon) {
> +                               r_opts.count_relabeled =3D 1;
> +                               break;
> +                       } else {
>                                 FILE *policystream;
>
>                                 policyfile =3D optarg;
> @@ -479,5 +482,18 @@ int main(int argc, char **argv)
>         if (r_opts.progress)
>                 fprintf(stdout, "\n");
>
> +       /* Output relabeled file count if requested */
> +       if (r_opts.count_relabeled) {
> +               long unsigned relabeled_count =3D selinux_restorecon_get_=
relabeled_files();
> +               printf("Relabeled %lu files\n", relabeled_count);
> +
> +               /* Set exit code to number of relabeled files (capped at =
254) */
> +               if (errors) {
> +                       exit(-1);
> +               } else {
> +                       exit(relabeled_count > 254 ? 254 : (int)relabeled=
_count);
> +               }

This I don't like. By convention, certain exit codes mean things. If
someone is debugging a restorecon with this option set,
and sees exit code 127, they're going to think, "command not found".
There are other codes to, like 126 not executable,
128 + signum, ie 137 is I was killed by SIGKILL Additionally, the
truncation makes it less useful.

I'd rather see this just exit 0 or 1, if folks need the count they can
parse it from stdout.

I'm no longer an SELinux maintainer, so don't let my nack stop anyone.

> +       }
> +
>         exit(errors ? -1 : skipped_errors ? 1 : 0);
>  }
> --
> 2.51.0
>
>
