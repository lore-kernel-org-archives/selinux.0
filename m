Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81883AA1A6
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150496; cv=pass; b=FlWZdm7Ke6olQ0I2wc1rVA7ZmFmlft4J4P3enXHqYLRk/0zpC+I226sKBNhiZSVU/TC+2hUEqU9RvGUG0dLG/geu9b3aNnTvDgq87xcErQgqGwRHWQZDHtLqeR5p+ewTpdvcmIzJRkimkCkTGi9Llr2u/jaDvhFajg6Vv10Vtyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150496; c=relaxed/simple;
	bh=2A6IlZRPaZgCCt/5ye3lWUSYW6f521UA9SJRAn6Ypkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK69xGM0La5nlbdxGEwsmezHhnwOImXzj5eQwcCWYL+MclytKv3iuOU2Q/Aqv3wSbbH6mj4UxrWSi9wNfCCh8xHDIFPIUL8gwxZeI1YydrDydmyL86WiLAjTn0RjoKIfw+p6YJ42qBnWh/KGRCVJ7cvASHly3jH9O2g7XrOcIZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnEY2OlE; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnEY2OlE"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-451a49abd8aso842052fac.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 07:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150493; cv=none;
        d=google.com; s=arc-20260327;
        b=PCBytBnlT0g6b53ScJQEl3nsCj1B3mDMF0gGQY2OSCqRvgSvF5q9c52EV/hjAfPmR/
         qcVVsPGROoyIyxtSKYj489vvoUUKm+i7vbCXykCkkbR1EotTUlZ+xAgor4Bxhn5esIYA
         HMbjkO/D8uGkfltZfms3BGam/rhwVS46dTqzDOMRuPFuBFndP1MGAALkbjxD1MMXDGiF
         KIKsV3472F2xaN/1Z+5Gpna/QoNileibqrpmD3fT/dp/yW2IuomTDjU5c9nCy2Q6qnZv
         Crk60m4iDNLS9UewxA4fFF6So58amTJ/6JmH2CcT2lBsca9hm8fcq90vS/U0RvmIBQ3Q
         4xxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0SGLbrGV/BWnpBu1QpBnwRUfeOxbEq3r/fkIt4hva4=;
        fh=Vdc608U6fmQnkK4Pj/GsEOPoO5XtlZs1Z9K2hPCnM4c=;
        b=BCNzIcQemCDliduBue7mcVRHHe3YvdAUvthhSiphYLUy9MG+4XhwivdEaTKTHVl3ZR
         kTjhzJfjuiHZqNIIJGN85bPUQ2QhJsLf0oNeACQJFJIQUpycb6YNUkh1OlhXbYqhmkO+
         d1Os5l95NN8l8q47g4V00BME+HiP4bhTS+cfSb04iNKsPGLyYeU4fneqDFHWMu3IC5Zq
         eekJAwgs60/+gRftm501In0+e++NCEVv/Oy+MUlnPLbnBSDHnI9SjrGAOAjHwlmu6Ol7
         YR/RPy7ByeyxpeG0CQtabZqyyKiMKOweQwaUJsCQlPEKLD5xWSGOAqB0HS+hk6kaFOXe
         4ggA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150493; x=1787755293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0SGLbrGV/BWnpBu1QpBnwRUfeOxbEq3r/fkIt4hva4=;
        b=gnEY2OlEF6XIAtJbwZIDw//2P/8i/MIXS9nY4boohraL/PyaoLKCdTZiMz7YZ6JxAW
         VGKbafDZPny6CsmPHS5BIUe+qrgCVvQsUS1YBf4U6lZSxmTSjxosc+t3iRpGxQ3URvc+
         Gp1Tby0Id2J4u7Xe0d2QfsX//TM8puw98S85QSw/qPZ/nKEVaT3soBBCkBDDEmC7/MUM
         O/PcM5eeHbkNMEMkQKETZY9pYD4ylSdoZOmjsWku2svZvh8Ivo24//+GUWFD2fJke5+9
         70NoQi+fY1b/4TFHNA7YsDLPP1incZuGb7cAXVErfRl4vO53/eJPTSA/JOUGakmvODK6
         74Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150493; x=1787755293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0SGLbrGV/BWnpBu1QpBnwRUfeOxbEq3r/fkIt4hva4=;
        b=ErjQFhH52Q1hTY123XlVG4gLJmNRJltjNMPzVpTiC8+IFbx88oOS270JEYomf5BpLD
         IZwdqwIKUuUF5BvCuSa92Y4fGi0nWAJXEVhtN9IKiauEtZop195KfiQejuLVXXURWXPU
         S9Pemyrt6zhWCwraf/Wlcq3ZOIFquCjD4ZTewxNat+C3OfU8Hi9Gk5nwPqr9smKu+9SO
         2kHBCWOqZKOyTu4LtQiuvB0Zmld6n9PDJpgV2j8EL7j1XoQ3lWDbf2K1joiMXXU65Gsn
         uaKY2FB7xbcONbxTGcFWymzSRFU+41hMGTkv4dCRymOXAR+d79KSAUt/SAQjNGoLk0pf
         HWOg==
X-Gm-Message-State: AOJu0YxrWdw19tUqeroOBzPaxnDWWFrWi89faIF4PO1w2QfecrZEoLsW
	3j220oK7E4UpiX6/WR/MfA53ohf7zVr26gqen3AF0Yq+S5ecrfVvBBTNiZcUl8nrV7CeUlVQ4h/
	YnloouNXzLjd8ysrYI59PR74HJWDyVOU=
X-Gm-Gg: AR+sD10dRIJ1ow3jeloSYRQa1zO31J6bsG44t82fi1k72TjIuNVJ/KlCGsEtvx1EYMb
	yPd4oz0/XvM7nVD4xu49uq75vXryCnIMod8gpxSdDboVsxYhL9dz15XCpN7zjt58cbT09selnMV
	2Al3kjOSHjfUSGrl32H87HShykd+1AaLcDZINMAPxkPtBuSaOvNZ9Kp8Md5nfgaHGK4zJUgQVfs
	0edxqv7xmSpRtZ+0HANhiS/PWfuijlQ2KzlgVec2fewe1VDKimJ8EN2r+80TQGQrlNCAnjw5Xit
	kuxId1B41hOj7ja+zu083O5BQaG9MsENdNTR8hIihWlPrXDMoumk/Nk=
X-Received: by 2002:a05:6871:2e9a:b0:456:8f0d:4fb3 with SMTP id
 586e51a60fabf-462f682c2b9mr4911421fac.12.1787150493297; Wed, 19 Aug 2026
 07:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143027.574025-1-boeroboy@gmail.com>
In-Reply-To: <20260819143027.574025-1-boeroboy@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 10:41:22 -0400
X-Gm-Features: AcwNN1Uw9PkD5ZpSrtWCR9XMKeFUedY2rfBB87mwIdB3Zy3DQhyvLtEeD-mMwUA
Message-ID: <CAEjxPJ4vzaopfLB87QHvPBsFB6BrinGhX6-Xn5MnatLhkaxf+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] policycoreutils/setfiles: honor RESTORECON_THREADS
To: jboero <boeroboy@gmail.com>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:30=E2=80=AFAM jboero <boeroboy@gmail.com> wrote:
>
> From: Johnny Boero <boeroboy@gmail.com>
>
> Relabeling is invoked from places that cannot reasonably be given a -T
> option.  On a Fedora 44 system, 10 installed packages run restorecon
> from their scriptlets -- filesystem, kernel-core, container-selinux and
> selinux-policy-targeted among them -- and not one of them passes -T:
>
>   restorecon -R /usr/bin /usr/sbin
>   restorecon -e /run/media -R /root /var/log /var/run /etc/passwd* ...
>   restorecon -R /var/lib/containers
>
> Influencing those means patching every spec file in the distribution,
> one merge request at a time, and only covers the packages one happens to
> have installed.  The environment is the only knob that reaches them all
> at once.
>
> Add RESTORECON_THREADS, with the same meaning as -T, which takes
> precedence when both are given:
>
>   RESTORECON_THREADS=3D1 dnf update  # keep relabeling on a single core
>   RESTORECON_THREADS=3D8 dnf update  # cap parallelism during application=
 load
>
> An invalid value is reported and ignored rather than being fatal, since
> the variable is inherited by every child process and should not be able
> to break an unrelated caller.  parse_nthreads() does not touch nthreads
> on error, so whichever default is compiled in stays in effect.
>
> Link: https://github.com/SELinuxProject/selinux/issues/489
> Signed-off-by: Johnny Boero <boeroboy@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>
> This replaces 3/3 of the v1 series; 1/3 and 2/3 are unchanged and still
> apply as sent.
>
> v2: drop the "nthreads =3D 0" reset on an invalid value, as Stephen
>     Smalley pointed out.  parse_nthreads() does not write nthreads on err=
or, so the
>     reset was a no-op with 2/3 applied and turned an invalid value into
>     all-cores without it.  Verified by building 1/3 + 3/3 without 2/3:
>     before the fix an invalid value ran at ~1000% CPU, after it stays
>     single threaded at 99%.  Commit message reworded accordingly.
>
>  policycoreutils/setfiles/restorecon.8 | 17 ++++++++++++++++-
>  policycoreutils/setfiles/setfiles.8   | 18 +++++++++++++++++-
>  policycoreutils/setfiles/setfiles.c   | 18 ++++++++++++++++--
>  3 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setf=
iles/restorecon.8
> index 8d7b46f0..001039b7 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -187,8 +187,23 @@ use up to
>  .I nthreads
>  threads.  Specify 0 to create as many threads as there are available
>  CPU cores (default); 1 to use only a single thread; or any positive
> -number to use the given number of threads (if possible).
> +number to use the given number of threads (if possible).  This option
> +overrides the
> +.B RESTORECON_THREADS
> +environment variable.
> +.SH "ENVIRONMENT"
>  .TP
> +.B RESTORECON_THREADS
> +Sets the default number of threads to use, with the same meaning as the
> +.B \-T
> +option.  This allows the amount of parallelism to be controlled for
> +callers that do not pass
> +.B \-T
> +themselves, such as package installation scripts.  Setting it to 1
> +restores the historic single threaded behaviour.  An invalid value is
> +ignored with a warning.  The
> +.B \-T
> +option takes precedence.
>  .SH "ARGUMENTS"
>  .IR pathname \ ...
>  The pathname for the file(s) to be relabeled.
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfil=
es/setfiles.8
> index 53cb97cc..101556a9 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -192,12 +192,28 @@ use up to
>  .I nthreads
>  threads.  Specify 0 to create as many threads as there are available
>  CPU cores (default); 1 to use only a single thread; or any positive
> -number to use the given number of threads (if possible).
> +number to use the given number of threads (if possible).  This option
> +overrides the
> +.B RESTORECON_THREADS
> +environment variable.
>  .TP
>  .B \-A
>  do not track inodes with multiple hard links or bind mounts that would
>  match different contexts (saves memory)
>
> +.SH "ENVIRONMENT"
> +.TP
> +.B RESTORECON_THREADS
> +Sets the default number of threads to use, with the same meaning as the
> +.B \-T
> +option.  This allows the amount of parallelism to be controlled for
> +callers that do not pass
> +.B \-T
> +themselves, such as package installation scripts.  Setting it to 1
> +restores the historic single threaded behaviour.  An invalid value is
> +ignored with a warning.  The
> +.B \-T
> +option takes precedence.
>  .SH "ARGUMENTS"
>  .TP
>  .I spec_file
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 4c860755..7f1c0a31 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -65,8 +65,8 @@ static void set_rootpath(const char *arg)
>  }
>
>  /*
> - * Parse a thread count, as given by the -T option.  Returns -1 on inval=
id
> - * input.
> + * Parse a thread count, as given by the -T option or the
> + * RESTORECON_THREADS environment variable.  Returns -1 on invalid input=
.
>   */
>  static int parse_nthreads(const char *str, size_t *nthreads)
>  {
> @@ -166,6 +166,7 @@ int main(int argc, char **argv)
>         struct stat sb;
>         int opt, i =3D 0;
>         const char *input_filename =3D NULL;
> +       const char *env_nthreads;
>         int use_input_file =3D 0;
>         char *buf =3D NULL;
>         size_t buf_len =3D 0, nthreads =3D 0;
> @@ -246,6 +247,19 @@ int main(int argc, char **argv)
>                         exit(0);
>         }
>
> +       /*
> +        * An explicit -T option takes precedence over the environment.  =
An
> +        * invalid value is not fatal, so that a bogus setting inherited =
by
> +        * every child process does not break unrelated callers;
> +        * parse_nthreads() leaves nthreads alone in that case.
> +        */
> +       env_nthreads =3D getenv("RESTORECON_THREADS");
> +       if (env_nthreads && env_nthreads[0] !=3D '\0' &&
> +           parse_nthreads(env_nthreads, &nthreads) < 0)
> +               fprintf(stderr,
> +                       "%s:  invalid RESTORECON_THREADS value \"%s\", ig=
noring\n",
> +                       r_opts.progname, env_nthreads);
> +
>         /* Process any options. */
>         while ((opt =3D getopt(argc, argv, opts)) > 0) {
>                 switch (opt) {
> --
> 2.55.0
>
