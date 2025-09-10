Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABA322DAB
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513683; cv=none; b=J21wPetEtmOKhhqYuSaU8SFSTPB9TCMuq1EqK14asQTUoRh1al4kZbVEF5QMlMJN+4MzeDUe51CT3eTQ8o2YXZq/xiNcu31p3STUn8BKCqDWLJLLheEkeWFarhMKbbnMmOOjV01Y2PFNon2rkSpreFeo2rcx9gnZt+8TZ6+lBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513683; c=relaxed/simple;
	bh=hXzOqtySqaRCqPIsBJsmWCzIGRal5L0pSYyYsjeChxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgVTrEXmsIAF5BYf8C7qmlyVwEtzZQw6odCw6vNVcgNqoC4/HDx9vSfLvmJd5XVDxUMVWE7IUr7RbYMBOgEMRXrE+gIMsxxcj7g7ojdGzeCmEhfI4EU5ne0gw+jzwS4Y7NcWzU517uhzg83DMs7Rh0Kf4RKpopM05MGeE6HiwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsafEsiJ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsafEsiJ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccea8f43cso589641fac.1
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513681; x=1758118481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtFd/EREJDAyoOQ4j4U4pIx20JcwlzEPJvEqbmq0f14=;
        b=PsafEsiJcy0Jks3Ll3Vynk8rlxuqhDDuHrw0wiELeAY0DKEYMEl/OEYUPZmCsE7gig
         ntZu+MdsTxy+CavJhRtqdzv/eeIKwP/jgY2xy5vpq3+evnX66u+MlUXlwJol4F7YKuoM
         iX6a+311U+O40vRIFeSqCF7oBgbRo7VzL+liI8SMrGvYBneBd2gAwo7uuXTnKcltOm/p
         Nkei9l8ppo9+rVW7cRJpW7VWAi8lotfiPLUFjzbn6/9InltTvO0MtC+yq2HC7yHS3yZW
         UaqxDddY7k6DvlolKZXdqRb8kL/hc2tZ6/IrFaW3V8OxKp5BZ3L24qccsMiH8SFDV/0r
         3pPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513681; x=1758118481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtFd/EREJDAyoOQ4j4U4pIx20JcwlzEPJvEqbmq0f14=;
        b=Aq7ISZN4OeMDqYAsQpsCBHV1T/ae9tt/4BHhWLXJJM64ZkbnykK9ggWKxwPRIFPf4H
         HWqy/e6G7Lyock5q7GpDyT6skswlU79ynsEV8jCMO/lqzMPnZykP6ws+XIhYIJYh3p/c
         x3E+ROcxWw4OtdR1wZpocbZ+vRIMWkVAkapteCkbQpZgZeu9GrgWlIZg09WwwCMgrcbX
         frR/EzA0g9QHS3UTyIFh0+UXWlLOox7PHDPYlG6YMNixC6GsitDKlQAvf51bdCvUvYHL
         S2YMTr2r1a4XG5SZ6epobcp/UVBUW+MX/2QpD0DpKOGHxZqFDJceCDVRVyUn7XvANI+b
         rfhA==
X-Gm-Message-State: AOJu0YxwBIROkyeBlHVVj9FT6XpfQevGsxmEaWuH7aKmYSLD1Z1Gb0/b
	WND8oC8I5U6RNsUSaGB0mO+xhC2Y58HeOe0ZY4K/+CgBjllajBfv4nMIH/Rw5r7LCpHu70bhPzB
	BjpiRlWcD5sUzafGrz4prl8XZ67T1EdQ=
X-Gm-Gg: ASbGnctOW1Q7AUZVKpHQBwdyDsfuOWM2Tw9mV5V3HxxipSulz9j4++kW5JFs+WnzluA
	McXBzK5XctfrFDi6cfqinHsPJnnzPu7tEcPSeNV9DxRSBp/s+bBu5TUnzZ9pUmGDja92AetJctY
	+sa7YjmGYueDYvwQLphbn6K3+IueHoieaQG1UuR51KXY6yBKcCepqq3FaQBRLW8Q8sxGs3Z2Ccv
	vyBw1A6PmTBzs5oeRgYFtqp/2e9
X-Google-Smtp-Source: AGHT+IHCedw0kwNDk/JjAyS7npiVJzfn+aXLw8moqkP1jPvytTN8tvg82vBwBwbQdKXc5N19TsBNqoCSCBoUzVRoY8g=
X-Received: by 2002:a05:6870:4e98:b0:32b:d4f0:46fd with SMTP id
 586e51a60fabf-32bd4f0f6c0mr1053876fac.7.1757513681134; Wed, 10 Sep 2025
 07:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910104322.328299-1-rjones@redhat.com> <20250910104322.328299-2-rjones@redhat.com>
In-Reply-To: <20250910104322.328299-2-rjones@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:14:29 -0400
X-Gm-Features: Ac12FXzuJhIURPMjngaeyPK55Pr9sCXrLlEA1WA-Oz-i2yc9IQIs3qmPHUL2bII
Message-ID: <CAEjxPJ5wEHLwbn7Rf=whqzFBgh=AVsy2YTY1L4wOr6JcB5yE5Q@mail.gmail.com>
Subject: Re: [PATCH v3] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:43=E2=80=AFAM Richard W.M. Jones <rjones@redhat.c=
om> wrote:
>
> SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes with
> multiple hard links or bind mounts that have differing contexts.
> However doing this involves building a large internal hashtable that
> stores the full path of every file examined by setfiles.  For
> filesystems that have very large numbers of files or long pathnames,
> this uses a lot of memory, which makes SELinux relabelling in
> constrained memory environments infeasible.
>
> This adds a new setfiles -A option that disables this tracking.
>
> For example, using setfiles to relabel a filesystem with 15 million
> files took 3.7GB of RAM.  Using this option, the same filesystem can
> be relabelled in 121MB (albeit with no warnings or errors possible for
> conflicting labels, but for our use case we don't care about that.)
>
> Fixes: https://issues.redhat.com/browse/RHEL-111505
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.8 |  5 +++++
>  policycoreutils/setfiles/setfiles.c | 11 +++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfil=
es/setfiles.8
> index eabf0a1c..d43e4ad2 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -23,6 +23,7 @@ setfiles \- set SELinux file security contexts.
>  .RB [ \-I | \-D ]
>  .RB [ \-T
>  .IR nthreads ]
> +.RB [ \-A ]
>  .I spec_file
>  .IR pathname \ ...
>
> @@ -187,6 +188,10 @@ use up to
>  threads.  Specify 0 to create as many threads as there are available
>  CPU cores; 1 to use only a single thread (default); or any positive
>  number to use the given number of threads (if possible).
> +.TP
> +.B \-A
> +do not track inodes with multiple hard links or bind mounts that would
> +match different contexts (saves memory)
>
>  .SH "ARGUMENTS"
>  .TP
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index ad09f840..31034316 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -40,9 +40,9 @@ static __attribute__((__noreturn__)) void usage(const c=
har *const name)
>                         name, name);
>         } else {
>                 fprintf(stderr,
> -                       "usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [=
-r alt_root_path] [-c policyfile] spec_file pathname...\n"
> -                       "usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [=
-r alt_root_path] [-c policyfile] spec_file -f filename\n"
> -                       "usage:  %s -s [-diIDlmnpqvFUWT] spec_file\n",
> +                       "usage:  %s [-diIDlmnpqvACEFUWT] [-e excludedir] =
[-r alt_root_path] [-c policyfile] spec_file pathname...\n"
> +                       "usage:  %s [-diIDlmnpqvACEFUWT] [-e excludedir] =
[-r alt_root_path] [-c policyfile] spec_file -f filename\n"
> +                       "usage:  %s -s [-diIDlmnpqvAFUWT] spec_file\n",
>                         name, name, name);
>         }
>         exit(-1);
> @@ -147,7 +147,7 @@ int main(int argc, char **argv)
>         const char *base;
>         int errors =3D 0;
>         const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> -       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
> +       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
>         const char *opts;
>         union selinux_callback cb;
>         long unsigned skipped_errors;
> @@ -375,6 +375,9 @@ int main(int argc, char **argv)
>                         if (*optarg =3D=3D '\0' || *endptr !=3D '\0')
>                                 usage(argv[0]);
>                         break;
> +               case 'A':
> +                       r_opts.add_assoc =3D 0;
> +                       break;
>                 case 'h':
>                 case '?':
>                         usage(argv[0]);
> --
> 2.50.1
>
