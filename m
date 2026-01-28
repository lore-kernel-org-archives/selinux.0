Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D3337688
	for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632130; cv=pass; b=o93IebF77O/lIaEaLkgUVjbrCIvwDWV02jMjPbmRdl75JrpQxFEXIPVuZrcOmSZ54zpt+2SrwmNdE5rtt0NQeIFNPFEUsBfACF/RccNgbc39NYIYgwF/twDnpFelQnzrgEz7fQOzS25/6aT/XNZAOcL7lZhLuTWWCkZnR3xAuDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632130; c=relaxed/simple;
	bh=KfADqQ1r/I011khcDJkxlYe9zzM6ptpmnXh0AnGWqBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJKu+8D+gHHJIGQgj4tmShfq1CEJPMtK6id+b5O7ZqsjRUFmGgyqkTgaMeHB/zP5Ebud4y89xQuDlfnEThChFMIktVWyM728FvQiOIka08msTVQmSklISOB7Q5Ydl9sxeWMMJwAsFkMjgmMojL5voVNAaoRuzl0l1wt2d2OWcbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apPi6gE6; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apPi6gE6"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd263bf42so254004e87.0
        for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 12:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632126; cv=none;
        d=google.com; s=arc-20240605;
        b=JaWmhFjM71WiF8YoADkYY19HZS/RgTJnAhHqKoTDN7bhMJaWv3xsVLQLz+uiGdgKFm
         /wWmF/G47y57kutXmI9uruhIjVQAv6Dh5H6mRF6lfEukS+uFjeYgnZLuwJ2FpymAnsuI
         hRvKVRTjokRffLLnzTU1O2fKMLIN8Lde8JzlZQJd9FIqAJz5tIDgas8D6uOpRJmanFVo
         HLVXTkFIT024cL//h0i/TubxhlNl1WUPpvS5oJdzZtM/+2l0qonhqfkEv/ox2e8+tMyG
         1TTL47QfhCNh3WjVQA7Hp8if668X3LNpSfuZZtcszY3c5sr7kauYV7eOACVRm0+AQSlR
         1tJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5T2NzMKbF0nMA8QXa5X3Ssjxft7TdnK/dv4WBkCUQAc=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=aEsNwoR6F1QBVw3RJa+dALWNtG1psx6nsEkyewGlSs3ex5jhUr86LWe5sv/6OrVT4W
         yTj//AAs3D39qXgxbOK4eIS7pZzQr15fR/V7DNz4FzyNG3kYAe5Lp0d+ViXTiZYHrv7o
         ims3DdAUXehFjsNEXWvfOfIe3svWcXYUWhj8o+/KBR6zGKHPWfcPewpsAcvgEqPyoutK
         hUV08AhklIhtU58DyXI5i9zr5BoHEFLunv8TkkLvvvpmy7ihMNoxbNEVPPaQXwCr8smW
         l9GvZ0wh4v3gfifVrl37zeOKKHTZ/P0B4tOtVJK1CbGFn1PbKnvipCAQRVS+kxHRqPQZ
         HAHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769632126; x=1770236926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T2NzMKbF0nMA8QXa5X3Ssjxft7TdnK/dv4WBkCUQAc=;
        b=apPi6gE61QAaQ5bZiRriaU1Xn+07mJDi6KVnSEN7tLqfuQchzLVMqOtFO60h8Yggkd
         OPfNbxYmtshT4q0o/d5b5gznKtrUUZUmuS+SokNeszBh/mvLcxfbingA4G/8/al61kVT
         QvSoAykGLCWSG+prVGgSQj/UO9RigzgDD9s3+jQ3w0EM+HSH3N7MnzRO1wUcmRc12U+x
         XPhWgvR3a77soDsc4dr0fUHjxJhonwVUuA3pLGAemJAWTv5/zeLMvSFX3kPvsdXIwS+q
         XvhLTQyvEUD2RlKbH60yU0AugoMBVnwxQJPpkv+KGQNWh9igltuJfXGtOgSqgNpY476n
         e7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632126; x=1770236926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5T2NzMKbF0nMA8QXa5X3Ssjxft7TdnK/dv4WBkCUQAc=;
        b=LbcIG+3g16CIpwW6sBLeNzmssEnD+GdvGK0AuOyNmX8qVZcaNgNUsNwORk/5u0Zos4
         G4a2W6xdwzaQRbX481pHT96skUjXsJLLIukDbc5zGpSRTOtbeibq2l2f83MfMYCwUww7
         yISCzItzezB+RpiMCthHjbPlHhTbWD0/umMW8yTkJxaAqKR51MP7lLNIY6CvvzkVUaPj
         OYyUjL/ddMlLLbuj3P5PxO4vpHQohVONE1wSmbkoa8iNlKZHEv5PzRBs7B1J4IZeohFX
         VfDjlpNMUfQkLsfZYZjb744nAL93jr5s5FceHzSk0bzuCFXLFdXtfQvN75fG2jFN8src
         EqdA==
X-Gm-Message-State: AOJu0YybmGCpbFGZqetV6DNpykMOzpz+CaAClw6NV6aTFdnCQBXJIoOG
	E94av9wMkaEWMLfieUTPnHT4Z9wrhNMzrn4vjcnuVtpPf1PI/1kbKyL8nL5F7KxBwrThik50VNz
	y9CS1W2SgChOfPODmV3uFfEBD/+9HqfHJsA==
X-Gm-Gg: AZuq6aLGz096pdXYPXorWFu1WiPUt6XV7WmxK7e627vkXvZhQ4iGes6nCM8FtU9UsQ/
	kdF+DcPRPn+6Ek//qx2zgR+XFOaDhgW88sIFLfRHWdlf9WxlwKH0B0RcV4pYAnm2trcMBx/91qb
	3MkmexT9sDmcpShEqZrdk4GYILUu9oHT0WUGgyfeqHEbMRFq0RBiBA48xn+0XuSQH78oGHCxOiR
	mfiIqLV6WdKvA2KKfEVKnD8uvQ2kuKEpXpZhLcDAEPMXHsymVQ7sg9XQ+R3vE4Fccf0
X-Received: by 2002:a05:6512:234e:b0:59d:f812:d490 with SMTP id
 2adb3069b0e04-59e0403097dmr2438957e87.40.1769632125876; Wed, 28 Jan 2026
 12:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87wm3nemxe.fsf@redhat.com> <20251118201145.984733-1-vmojzis@redhat.com>
 <CAP+JOzS4MHOaNSH1xMhiKGh5fcX3EEKQb42iu6k+A_AGkW4-YA@mail.gmail.com>
In-Reply-To: <CAP+JOzS4MHOaNSH1xMhiKGh5fcX3EEKQb42iu6k+A_AGkW4-YA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Jan 2026 15:28:34 -0500
X-Gm-Features: AZwV_QjHOQlABbovi7VeQXVBZIyEF2_G-_7upO4gIGWBJSU3r26MnD5cZoDsvIQ
Message-ID: <CAP+JOzRKwpJn-1jfFB9jmLRmqyHerbDo35r5nTrYc5O5+n9_Mg@mail.gmail.com>
Subject: Re: [PATCH v3] restorecon: Add option to count relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 10:13=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Nov 18, 2025 at 3:12=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > This is useful in case we want to check that a remediation using
> > restorecon was successful (otherwise 0 is always returned, even if no
> > files were relabeled).
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/include/selinux/restorecon.h | 15 +++++++++++
> >  libselinux/src/libselinux.map           |  5 ++++
> >  libselinux/src/selinux_restorecon.c     | 34 ++++++++++++++++++++++---
> >  policycoreutils/setfiles/restore.c      | 12 ++++++---
> >  policycoreutils/setfiles/restore.h      |  3 ++-
> >  policycoreutils/setfiles/restorecon.8   |  3 +++
> >  policycoreutils/setfiles/setfiles.c     | 26 ++++++++++++++-----
> >  7 files changed, 83 insertions(+), 15 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/inclu=
de/selinux/restorecon.h
> > index 0ccf73a6..65aaef23 100644
> > --- a/libselinux/include/selinux/restorecon.h
> > +++ b/libselinux/include/selinux/restorecon.h
> > @@ -134,6 +134,11 @@ extern int selinux_restorecon_parallel(const char =
*pathname,
> >   */
> >  #define SELINUX_RESTORECON_SET_USER_ROLE               0x40000
> >
> > +/*
> > + * Count the number of relabeled files (or would be relabeled if "noch=
ange" was not set).
> > + */
> > + #define SELINUX_RESTORECON_COUNT_RELABELED            0x80000
> > +
> >  /**
> >   * selinux_restorecon_set_sehandle - Set the global fc handle.
> >   * @hndl: specifies handle to set as the global fc handle.
> > @@ -228,6 +233,16 @@ extern int selinux_restorecon_xattr(const char *pa=
thname,
> >   */
> >  extern long unsigned selinux_restorecon_get_skipped_errors(void);
> >
> > +/* selinux_restorecon_get_relabeled_files - Get the number of relabele=
d files
> > + *
> > + * If SELINUX_RESTORECON_COUNT_RELABELED was passed to selinux_restore=
con(3) or
> > + * selinux_restorecon_parallel(3), this function returns the number of=
 files
> > + * that were successfully relabeled.
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
> > index ab002f01..95cd53b0 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -262,3 +262,8 @@ LIBSELINUX_3.9 {
> >    global:
> >      context_to_str;
> >  } LIBSELINUX_3.8;
> > +
> > +LIBSELINUX_3.10 {
> > +  global:
> > +    selinux_restorecon_get_relabeled_files;
> > +} LIBSELINUX_3.9;
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 681c69db..8fadf4d2 100644
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
> > @@ -88,6 +91,7 @@ struct rest_flags {
> >         bool warnonnomatch;
> >         bool conflicterror;
> >         bool count_errors;
> > +       bool count_relabeled;
> >  };
> >
> >  static void restorecon_init(void)
> > @@ -650,11 +654,12 @@ out:
> >  }
> >
> >  static int restorecon_sb(const char *pathname, const struct stat *sb,
> > -                           const struct rest_flags *flags, bool first)
> > +                           const struct rest_flags *flags, bool first,=
 bool *updated_out)
> >  {
> >         char *newcon =3D NULL;
> >         char *curcon =3D NULL;
> >         int rc;
> > +       bool updated =3D false;
> >         const char *lookup_path =3D pathname;
> >
> >         if (rootpath) {
> > @@ -736,7 +741,6 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >         }
> >
> >         if (curcon =3D=3D NULL || strcmp(curcon, newcon) !=3D 0) {
> > -               bool updated =3D false;
> >
> >                 if (!flags->set_specctx && curcon &&
> >                                     (is_context_customizable(curcon) > =
0)) {
> > @@ -796,9 +800,14 @@ static int restorecon_sb(const char *pathname, con=
st struct stat *sb,
> >                                 syslog(LOG_INFO, "labeling %s to %s\n",
> >                                             pathname, newcon);
> >                 }
> > +
> > +               /* Note: relabel counting handled by caller */
> > +
> >         }
> >
> >  out:
> > +       if (updated_out)
> > +               *updated_out =3D updated;
> >         rc =3D 0;
> >  out1:
> >         freecon(curcon);
> > @@ -887,6 +896,7 @@ struct rest_state {
> >         bool abort;
> >         int error;
> >         long unsigned skipped_errors;
> > +       long unsigned relabeled_files;
> >         int saved_errno;
> >         pthread_mutex_t mutex;
> >  };
> > @@ -1010,8 +1020,9 @@ loop_body:
> >                         if (state->parallel)
> >                                 pthread_mutex_unlock(&state->mutex);
> >
> > +                       bool updated =3D false;
> >                         error =3D restorecon_sb(ent_path, &ent_st, &sta=
te->flags,
> > -                                             first);
> > +                                             first, &updated);
> >
> >                         if (state->parallel) {
> >                                 pthread_mutex_lock(&state->mutex);
> > @@ -1030,6 +1041,8 @@ loop_body:
> >                                         state->skipped_errors++;
> >                                 else
> >                                         state->error =3D error;
> > +                       } else if (updated && state->flags.count_relabe=
led) {
> > +                               state->relabeled_files++;
> >                         }
> >                         break;
> >                 }
> > @@ -1087,6 +1100,8 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >                     SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
> >         state.flags.count_errors =3D (restorecon_flags &
> >                     SELINUX_RESTORECON_COUNT_ERRORS) ? true : false;
> > +       state.flags.count_relabeled =3D (restorecon_flags &
> > +                   SELINUX_RESTORECON_COUNT_RELABELED) ? true : false;
> >         state.setrestorecondigest =3D true;
> >
> >         state.head =3D NULL;
> > @@ -1094,6 +1109,7 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >         state.abort =3D false;
> >         state.error =3D 0;
> >         state.skipped_errors =3D 0;
> > +       state.relabeled_files =3D 0;
> >         state.saved_errno =3D 0;
> >
> >         struct stat sb;
> > @@ -1215,7 +1231,11 @@ static int selinux_restorecon_common(const char =
*pathname_orig,
> >                         goto cleanup;
> >                 }
> >
> > -               error =3D restorecon_sb(pathname, &sb, &state.flags, tr=
ue);
> > +               bool updated =3D false;
> > +               error =3D restorecon_sb(pathname, &sb, &state.flags, tr=
ue, &updated);
> > +               if (updated && state.flags.count_relabeled) {
> > +                       state.relabeled_files++;
> > +               }
> >                 goto cleanup;
> >         }
> >
> > @@ -1341,6 +1361,7 @@ out:
> >         (void) fts_close(state.fts);
> >         errno =3D state.saved_errno;
> >  cleanup:
> > +       relabeled_files =3D state.relabeled_files;
> >         if (state.flags.add_assoc) {
> >                 if (state.flags.verbose)
> >                         filespec_eval();
> > @@ -1618,3 +1639,8 @@ long unsigned selinux_restorecon_get_skipped_erro=
rs(void)
> >  {
> >         return skipped_errors;
> >  }
> > +
> > +long unsigned selinux_restorecon_get_relabeled_files(void)
> > +{
> > +       return relabeled_files;
> > +}
> > diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfi=
les/restore.c
> > index 2c031ccc..07582e7c 100644
> > --- a/policycoreutils/setfiles/restore.c
> > +++ b/policycoreutils/setfiles/restore.c
> > @@ -43,7 +43,7 @@ void restore_init(struct restore_opts *opts)
> >                            opts->syslog_changes | opts->log_matches |
> >                            opts->ignore_noent | opts->ignore_mounts |
> >                            opts->mass_relabel | opts->conflict_error |
> > -                          opts->count_errors;
> > +                          opts->count_errors | opts->count_relabeled;
> >
> >         /* Use setfiles, restorecon and restorecond own handles */
> >         selinux_restorecon_set_sehandle(opts->hnd);
> > @@ -75,7 +75,7 @@ void restore_finish(void)
> >  }
> >
> >  int process_glob(char *name, struct restore_opts *opts, size_t nthread=
s,
> > -                long unsigned *skipped_errors)
> > +                long unsigned *skipped_errors, long unsigned *relabele=
d_files)
> >  {
> >         glob_t globbuf;
> >         size_t i, len;
> > @@ -99,8 +99,12 @@ int process_glob(char *name, struct restore_opts *op=
ts, size_t nthreads,
> >                                                  nthreads);
> >                 if (rc < 0)
> >                         errors =3D rc;
> > -               else if (opts->restorecon_flags & SELINUX_RESTORECON_CO=
UNT_ERRORS)
> > -                       *skipped_errors +=3D selinux_restorecon_get_ski=
pped_errors();
> > +               else {
> > +                       if (opts->restorecon_flags & SELINUX_RESTORECON=
_COUNT_ERRORS)
> > +                               *skipped_errors +=3D selinux_restorecon=
_get_skipped_errors();
> > +                       if (opts->restorecon_flags & SELINUX_RESTORECON=
_COUNT_RELABELED)
> > +                               *relabeled_files +=3D selinux_restoreco=
n_get_relabeled_files();
> > +               }
> >         }
> >
> >         globfree(&globbuf);
> > diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfi=
les/restore.h
> > index 95afb960..36f73059 100644
> > --- a/policycoreutils/setfiles/restore.h
> > +++ b/policycoreutils/setfiles/restore.h
> > @@ -37,6 +37,7 @@ struct restore_opts {
> >         unsigned int ignore_mounts;
> >         unsigned int conflict_error;
> >         unsigned int count_errors;
> > +       unsigned int count_relabeled;
> >         /* restorecon_flags holds | of above for restore_init() */
> >         unsigned int restorecon_flags;
> >         char *rootpath;
> > @@ -52,7 +53,7 @@ void restore_init(struct restore_opts *opts);
> >  void restore_finish(void);
> >  void add_exclude(const char *directory);
> >  int process_glob(char *name, struct restore_opts *opts, size_t nthread=
s,
> > -                long unsigned *skipped_errors);
> > +                long unsigned *skipped_errors, long unsigned *relabele=
d_files);
> >  extern char **exclude_list;
> >
> >  #endif
> > diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/se=
tfiles/restorecon.8
> > index 1134420e..b7ff9715 100644
> > --- a/policycoreutils/setfiles/restorecon.8
> > +++ b/policycoreutils/setfiles/restorecon.8
> > @@ -153,6 +153,9 @@ display warnings about entries that had no matching=
 files by outputting the
> >  .BR selabel_stats (3)
> >  results.
> >  .TP
> > +.B \-c
> > +count and display the number of (would be) relabeled files. The exit c=
ode will be set to 0 only if at least one file is relabeled.
> > +.TP
> >  .B \-0
> >  the separator for the input items is assumed to be the null character
> >  (instead of the white space).  The quotes and the backslash characters=
 are
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setf=
iles/setfiles.c
> > index 31034316..351940f3 100644
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
> > @@ -146,11 +146,12 @@ int main(int argc, char **argv)
> >         size_t buf_len, nthreads =3D 1;
> >         const char *base;
> >         int errors =3D 0;
> > -       const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> > +       const char *ropts =3D "ce:f:hiIDlmno:pqrsvFURW0xT:";
> >         const char *sopts =3D "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
> >         const char *opts;
> >         union selinux_callback cb;
> >         long unsigned skipped_errors;
> > +       long unsigned relabeled_files;
> >
> >         /* Initialize variables */
> >         memset(&r_opts, 0, sizeof(r_opts));
> > @@ -160,6 +161,7 @@ int main(int argc, char **argv)
> >         request_digest =3D 0;
> >         policyfile =3D NULL;
> >         skipped_errors =3D 0;
> > +       relabeled_files =3D 0;
> >
> >         if (!argv[0]) {
> >                 fprintf(stderr, "Called without required program name!\=
n");
> > @@ -223,7 +225,10 @@ int main(int argc, char **argv)
> >         while ((opt =3D getopt(argc, argv, opts)) > 0) {
> >                 switch (opt) {
> >                 case 'c':
> > -                       {
> > +                       if (iamrestorecon) {
> > +                               r_opts.count_relabeled =3D SELINUX_REST=
ORECON_COUNT_RELABELED;
> > +                               break;
> > +                       } else {
> >                                 FILE *policystream;
> >
> >                                 policyfile =3D optarg;
> > @@ -457,14 +462,14 @@ int main(int argc, char **argv)
> >                         if (!strcmp(buf, "/"))
> >                                 r_opts.mass_relabel =3D SELINUX_RESTORE=
CON_MASS_RELABEL;
> >                         errors |=3D process_glob(buf, &r_opts, nthreads=
,
> > -                                              &skipped_errors) < 0;
> > +                                              &skipped_errors, &relabe=
led_files) < 0;
> >                 }
> >                 if (strcmp(input_filename, "-") !=3D 0)
> >                         fclose(f);
> >         } else {
> >                 for (i =3D optind; i < argc; i++)
> >                         errors |=3D process_glob(argv[i], &r_opts, nthr=
eads,
> > -                                              &skipped_errors) < 0;
> > +                                              &skipped_errors, &relabe=
led_files) < 0;
> >         }
> >
> >         if (r_opts.mass_relabel && !r_opts.nochange)
> > @@ -479,5 +484,14 @@ int main(int argc, char **argv)
> >         if (r_opts.progress)
> >                 fprintf(stdout, "\n");
> >
> > +       /* Output relabeled file count if requested */
> > +       if (r_opts.count_relabeled) {
> > +               long unsigned relabeled_count =3D selinux_restorecon_ge=
t_relabeled_files();
> > +               printf("Relabeled %lu files\n", relabeled_count);
> > +
> > +               /* Set exit code to 0 if at least one file was relabele=
d */
> > +               exit(errors ? -1 : relabeled_count ? 0 : 1);
> > +       }
> > +
> >         exit(errors ? -1 : skipped_errors ? 1 : 0);
> >  }
> > --
> > 2.51.1
> >
> >
