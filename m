Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835F2EB5CE
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807089; cv=none; b=giUtNijXKTS/CMWuMZKU5sqNixe38jq190bvNWObBy+Z0RixjUono/9qv73j/vDt+xbXc5+R73z1BMWa+6csisgy1YESanV9oBM2zG44429rvmTw6jhv8MV5mO9v/0Ek9CRPTS+hSPJ/JcPxekCpkBoVOI8+10fZIUVJD6KHyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807089; c=relaxed/simple;
	bh=9azrhI6JODILGw5J/+pQZgna9H0HMugWT1GTHJd1Dww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aALtt0P+RhMjp9GwQ2M1Ts1/emqWJPuvLY5KCtnfGaMS6MN3htE2L+C5u2TNKGO6xvRrJ8fSU9pZszGk+u2R2WSNiGuEvTXsUc49+p6UuOKwsly/NvwKddMndOQ6xmLSNjlDnyMOhhTj3DJ9cikHegDZPNv8DIkbMRPhEAH2QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcx5VUCv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcx5VUCv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5943b62c47dso3081998e87.1
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762807085; x=1763411885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGe6GpqLXxq3fGLMxODKgs/2aIukZrXKWfiD9YZ/YeY=;
        b=Tcx5VUCvKPjVF8CQrdyDPpnw1F6nDA+WXMNwQBhzaporj6zF8hdxTCtCu4DMywCN+3
         v0Ae7zeHYc7WfQsYn4YFhavBy+k03G5Q9Wq02Xb1iROOdq98U+f9YY1YAFfprBPsBDeB
         IiXPWXLPdhzRs4c9DGFfiw/GenUu8ysX2V0+5L4dClRjS6DjmBa0sXv28p8fCeJA06C9
         t36h9blOUJO0ooZl1AqMglySZ/Z878uP/NI7T1bq0qeoENsvPrThTzGR7qYvDx/M63Jy
         Xn5cudGOZVKniByRYveMSJf33oe7gaAfbxFOr2uDt9y2MAxS8fCOyFfvdS5ZWsjbt3WZ
         pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807085; x=1763411885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGe6GpqLXxq3fGLMxODKgs/2aIukZrXKWfiD9YZ/YeY=;
        b=rqEwBd/MmmF98UxGCnLwg5uQe0Ap3c+GWqJidJTPzAnYKnp94OwnWbTBuWC1JJGIZl
         ogccb6jy8N3p7X0K0ruHxu/P0/MHSikj6cCsCwlXVXYfQPD3DG0wI0LTPbhhWWXtUawF
         ChWDaHdIwLHFqERsQiBu2Ffg5Onr+PjRTxW+EobnCGUkO7pZT6WxlfGcR9HVtSrYos7S
         mDswQZC7Yk2BlYN1xzTerPXVdW94hwQdOizE4hjm1CB80qV4T2B57Omv+KEFak1zMMLF
         y2JPSAzooMNoRPRBjLmrU0zY2kKU6NOks7NyFgTegnybvPAzUDKRXTOsSVw5nfCG1NQJ
         BJNw==
X-Gm-Message-State: AOJu0YxpOz/IzE7HtddBUo3Sh2h+ZV/7xXEmNoDTSr6CIx81n1eYnWck
	GTHzQYliu52cy0Z5t8PdEwi3EqLTIyQsJx2UI9LTGJL91kMFB6OYwTkN/8OmA3EtUMZEW2d0bLb
	Y2IcwLuxoydEk3C0bvcpJlI+ee7cXAmHd4Q==
X-Gm-Gg: ASbGncuBKUi0bwROm9vugoJMkFuxW0syZd2ePIrasIJYiYQ0/c6vhLyYoeDUe+Rl/I/
	l7uZSnVTwx56IXppixD60sZmc4boSHk0N6I+qIhaRoQI2gJVh/msVWJ2WDE1dFEGRxcCA5GQ2KX
	Js4smYP9yxmJ3belCqkPPWdlVCSvnWrqna5W0wHe901GoNmfrnG2+sjckr+jJjmV5spkBwqPtkS
	l/6Jv9FC3289sqVYdyao9ZoZ2sTsSlyJpD0NX2YLLhAYp6IuvjEF9EGYUHj+VmWFfEFXkvY
X-Google-Smtp-Source: AGHT+IH94cHuYuOWBTA8FVAPfQewiGKyeVFLnFxM0ySFRxk2pquwmWbZD8TvKdDuZinsb7lxDVE072FRA4HQrCJgLgw=
X-Received: by 2002:a05:6512:224f:b0:594:2d64:bcee with SMTP id
 2adb3069b0e04-5945f19bf29mr2641791e87.15.1762807084901; Mon, 10 Nov 2025
 12:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com> <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
In-Reply-To: <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 10 Nov 2025 14:37:53 -0600
X-Gm-Features: AWmQ_bk_WkUsCVPxGKtfMof3uBJ-gQjgKwmt8hKQdk0JiLgeCwtpmAHPD3MOU94
Message-ID: <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:23=E2=80=AFPM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Mon, Nov 10, 2025 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > This is useful in case we want to check that a remediation using
> > restorecon was successful (otherwise 0 is always returned, even if no
> > files where relabeled).
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  libselinux/include/selinux/restorecon.h |  9 +++++++++
> >  libselinux/src/libselinux.map           |  1 +
> >  libselinux/src/selinux_restorecon.c     | 14 ++++++++++++++
> >  policycoreutils/setfiles/restore.h      |  1 +
> >  policycoreutils/setfiles/restorecon.8   |  3 +++
> >  policycoreutils/setfiles/setfiles.c     | 24 ++++++++++++++++++++----
> >  6 files changed, 48 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/inclu=
de/selinux/restorecon.h
> > index 0ccf73a6..736481bb 100644
> > --- a/libselinux/include/selinux/restorecon.h
> > +++ b/libselinux/include/selinux/restorecon.h
> > @@ -228,6 +228,15 @@ extern int selinux_restorecon_xattr(const char *pa=
thname,
> >   */
> >  extern long unsigned selinux_restorecon_get_skipped_errors(void);
> >
> > +/* selinux_restorecon_get_relabeled_files - Get the number of relabele=
d files
> > + *
> > + * If selinux_restorecon(3) or selinux_restorecon_parallel(3) was call=
ed,
> > + * this function returns the number of files that were successfully re=
labeled.
> > + * If the SELINUX_RESTORECON_NOCHANGE flag was set, this function retu=
rns
> > + * the number of files that would be relabeled.
> > + */
> > +extern long unsigned selinux_restorecon_get_relabeled_files(void);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.=
map
> > index ab002f01..f21e089e 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -244,6 +244,7 @@ LIBSELINUX_1.0 {
> >  LIBSELINUX_3.4 {
> >    global:
> >      selinux_restorecon_get_skipped_errors;
> > +    selinux_restorecon_get_relabeled_files;
> >      selinux_restorecon_parallel;
> >  } LIBSELINUX_1.0;
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 681c69db..6e9a159e 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
> >  /* Number of errors ignored during the file tree walk. */
> >  static long unsigned skipped_errors;
> >
> > +/* Number of successfully relabeled files or files that would be relab=
eled */
> > +static long unsigned relabeled_files;
> > +
> >  /* restorecon_flags for passing to restorecon_sb() */
> >  struct rest_flags {
> >         bool nochange;
> > @@ -796,6 +799,10 @@ static int restorecon_sb(const char *pathname, con=
st struct stat *sb,
> >                                 syslog(LOG_INFO, "labeling %s to %s\n",
> >                                             pathname, newcon);
> >                 }
> > +
> > +               /* Count relabeled files (or would be relabeled if "noc=
hange" was not set) */
> > +               relabeled_files++;
> > +
> >         }
> >
> >  out:
> > @@ -1096,6 +1103,8 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >         state.skipped_errors =3D 0;
> >         state.saved_errno =3D 0;
> >
> > +       relabeled_files =3D 0;
> > +
> >         struct stat sb;
> >         char *pathname =3D NULL, *pathdnamer =3D NULL, *pathdname, *pat=
hbname;
> >         char *paths[2] =3D { NULL, NULL };
> > @@ -1618,3 +1627,8 @@ long unsigned selinux_restorecon_get_skipped_erro=
rs(void)
> >  {
> >         return skipped_errors;
> >  }
> > +
> > +long unsigned selinux_restorecon_get_relabeled_files(void)
> > +{
> > +       return relabeled_files;
> > +}
> > diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfi=
les/restore.h
> > index 95afb960..7c949c1c 100644
> > --- a/policycoreutils/setfiles/restore.h
> > +++ b/policycoreutils/setfiles/restore.h
> > @@ -37,6 +37,7 @@ struct restore_opts {
> >         unsigned int ignore_mounts;
> >         unsigned int conflict_error;
> >         unsigned int count_errors;
> > +       unsigned int count_relabeled;
>
> It's using unsigned int, but other places use unsigned long. Wouldn't we =
want to
> keep this consistent to prevent truncating long to int? Do we care
> about rollovers?
> It's unlikely to happen, but some file systems don't have bounds on
> the number of files,
> also can't restorecon go across fs boundaries, so the count could be
> high, albeit unlikely.
>
> >         /* restorecon_flags holds | of above for restore_init() */
> >         unsigned int restorecon_flags;
> >         char *rootpath;
> > diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/se=
tfiles/restorecon.8
> > index 1134420e..e9bd16b6 100644
> > --- a/policycoreutils/setfiles/restorecon.8
> > +++ b/policycoreutils/setfiles/restorecon.8
> > @@ -153,6 +153,9 @@ display warnings about entries that had no matching=
 files by outputting the
> >  .BR selabel_stats (3)
> >  results.
> >  .TP
> > +.B \-c
> > +count and display the number of (would be) relabeled files. The exit c=
ode will be set to the number of relabeled files (capped at 254).
> > +.TP
> >  .B \-0
> >  the separator for the input items is assumed to be the null character
> >  (instead of the white space).  The quotes and the backslash characters=
 are
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setf=
iles/setfiles.c
> > index 31034316..6323f56c 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -35,8 +35,8 @@ static __attribute__((__noreturn__)) void usage(const=
 char *const name)
> >  {
> >         if (iamrestorecon) {
> >                 fprintf(stderr,
> > -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] p=
athname...\n"
> > -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -=
f filename\n",
> > +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] =
pathname...\n"
> > +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] =
-f filename\n",
> >                         name, name);
> >         } else {
> >                 fprintf(stderr,
> > @@ -146,7 +146,7 @@ int main(int argc, char **argv)
> >         size_t buf_len, nthreads =3D 1;
> >         const char *base;
> >         int errors =3D 0;
> > -       const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> > +       const char *ropts =3D "ce:f:hiIDlmno:pqrsvFURW0xT:";
> >         const char *sopts =3D "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
> >         const char *opts;
> >         union selinux_callback cb;
> > @@ -223,7 +223,10 @@ int main(int argc, char **argv)
> >         while ((opt =3D getopt(argc, argv, opts)) > 0) {
> >                 switch (opt) {
> >                 case 'c':
> > -                       {
> > +                       if (iamrestorecon) {
> > +                               r_opts.count_relabeled =3D 1;
> > +                               break;
> > +                       } else {
> >                                 FILE *policystream;
> >
> >                                 policyfile =3D optarg;
> > @@ -479,5 +482,18 @@ int main(int argc, char **argv)
> >         if (r_opts.progress)
> >                 fprintf(stdout, "\n");
> >
> > +       /* Output relabeled file count if requested */
> > +       if (r_opts.count_relabeled) {
> > +               long unsigned relabeled_count =3D selinux_restorecon_ge=
t_relabeled_files();
> > +               printf("Relabeled %lu files\n", relabeled_count);
> > +
> > +               /* Set exit code to number of relabeled files (capped a=
t 254) */
> > +               if (errors) {
> > +                       exit(-1);
> > +               } else {
> > +                       exit(relabeled_count > 254 ? 254 : (int)relabel=
ed_count);
> > +               }
>
> This I don't like. By convention, certain exit codes mean things. If
> someone is debugging a restorecon with this option set,
> and sees exit code 127, they're going to think, "command not found".
> There are other codes to, like 126 not executable,
> 128 + signum, ie 137 is I was killed by SIGKILL Additionally, the
> truncation makes it less useful.

I forgot to mention as well, If a user enables this option in a script
set to exit
on error, they have to code around this command under specific options.

>
> I'd rather see this just exit 0 or 1, if folks need the count they can
> parse it from stdout.
>
> I'm no longer an SELinux maintainer, so don't let my nack stop anyone.
>
> > +       }
> > +
> >         exit(errors ? -1 : skipped_errors ? 1 : 0);
> >  }
> > --
> > 2.51.0
> >
> >
