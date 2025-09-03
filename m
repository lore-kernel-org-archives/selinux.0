Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690591DE3CA
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907744; cv=none; b=Xy6K8GX/9oHxUngw5T2y2PLKgyU+xPXX2/6HxSfU9oF+Vq6reIm5CIhBVYoAZvOeGf/hNcd+1SCkPUkT1Z65TCZ/oHikRwSqs40z5jzCKAeOTWJ4xmOcrkK2En0750mMINNyeU5LnZxaE3i9WlTmcvArtTuuOOLRRboOwPLGAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907744; c=relaxed/simple;
	bh=DHY4HJZtxrnVI7CqAluBD9MY778qX5IW9gmJHLGX/uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6KOz+avHZGYpBPXQDub05A9t5DRkF3i/UX8PfOmn/AnlYLMlHiWsUtL7bdT/8wPTSGmAUp3QReFo5mWOlNMIrmlOuofMdzWIZTyr76lTFV6jeIsRN/k/o8StpTsC1bL8Xq5WxCHjK1jh5c9RJQ++UOdIhqsPzn/4lkFaiGKJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+X0lxjB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+X0lxjB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-328015abe0bso975752a91.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756907743; x=1757512543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i66W5Lqfa0wvHJLI+azzd2gd4bJjZA3WnKNK0/0fwQ=;
        b=U+X0lxjB2ecHr52Kyik/IacsOnAM/r4w61Wziq2Oea2vh0xw4wYFvPW8sv6sZavjZc
         0AHIwSLmcCpqWgwGiIKdV7RFd1UM495ReNuks5EkZHiHOFQnNTN0ATHjS4BmBepH8fDR
         EziBV1rNx2czw+XCjDx0BdnFpSn3+FZcix1lZ+fkXRQJpdIOUO8igx9myggOX6lYg59t
         RonoYqyTP4cbr5eMS1Kihl2IP0gHVCUREJd8sYWquO8HMOC0aMseI37ccJenrw8I1R/3
         IDydDYP9ljdtFXNS1Tpt7vSsSJXbS8aYxBtFHU9gSEuVRlgGbKPjm9bpGYBJcMBNbF21
         QNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907743; x=1757512543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i66W5Lqfa0wvHJLI+azzd2gd4bJjZA3WnKNK0/0fwQ=;
        b=CFilOfdxhBKTgAuKPEQFiBM5kHjRaJx4YMcu3BYWs+EeeZcCLTGhD7B1QLasQUEimo
         8Ij+7i05YmTPc/VoylAKWM/WSpiiytKzEnFBq9fhzPfZ9hLF2tHUDP5aEz57G4Sa+FhC
         dDkTyjNgxxva6GMsiIkF40xl1p12Sm1WVNyzAhuRyX07rgdjFZBd5rLFf/2qc5qVD1mm
         tp9IeOeWGwpzAiTKIi0IQIQ40mk7tZcupwZ9NVMdRRVZscVa8pnHcUmNdfWWlIQ1hnJz
         96SG/WkPXfVd4BRTKHWkn/rp5pXImB7JAQz/FsIEXfuKlWTcLhousjtakFzdlxe0pfKn
         gR8A==
X-Gm-Message-State: AOJu0YyFBY2UnUgJjsT1+S4IX82UuYxThZPmyKlqwvccqr2vLVWHLxLA
	EGodvp6v6RS2aF7Helx2HvPBuTq438wkmuxRJEO3cJb930rVZPeW3fUlhvfNL0C8Wg+MjbDhkzf
	hfuARb4OENiAB4aoq72nfXSWUAJWtOfLRgQ==
X-Gm-Gg: ASbGncsGlhzkQPnlA7wjRVq+bOX7JzlCq2PNR/Vplnb0/VQ/rcCWge4FN8m/g6tm68w
	0NHDJ4VfcfQed5eVdj7OQU7+xxVb+zUf0qDs8DgTR6/My2B8YW0dcx6sJIu9lbwiiYm9hY9J2Wb
	o8PBRu4gE53t7Cp56cyT5FgL3tV/kwcY/HpTR7krBjNRn2kHcj6UHHSf4ut7Z7BxGnmUMJZyln6
	uprFKs=
X-Google-Smtp-Source: AGHT+IG7WxZRJXNMIoRhNxDfBYcNw8cMwLtyaCsu6OJjUbv264zu+7yT7rNhhHnXfQ1/xd6w5i7nKifPTNrd64Z1m+c=
X-Received: by 2002:a17:90b:1fcf:b0:327:e2ad:2ff3 with SMTP id
 98e67ed59e1d1-3280d387063mr20686108a91.18.1756907742514; Wed, 03 Sep 2025
 06:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902175000.3214164-1-rjones@redhat.com> <20250902175000.3214164-2-rjones@redhat.com>
In-Reply-To: <20250902175000.3214164-2-rjones@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Sep 2025 09:55:31 -0400
X-Gm-Features: Ac12FXxuld-rJwhoQENJ5Yy0mEMiaIB1xMo1MuwQ2WDjcRIeAdyU-pcPaPgbQR4
Message-ID: <CAEjxPJ7nJ7j9HPR8yEeM8ErscZfmUr0imTwUvvwZikAqsP1EDA@mail.gmail.com>
Subject: Re: [PATCH v2] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:50=E2=80=AFPM Richard W.M. Jones <rjones@redhat.co=
m> wrote:
>
> SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have

Technically, for inodes with multiple hard links or bind mounts that
would match differing contexts. But no need to re-spin just for that.

> differing contexts.  However doing this involves building a large
> internal hashtable that stores the full path of every file examined by
> setfiles.  For filesystems that have very large numbers of files or
> long pathnames, this uses a lot of memory, which makes SELinux
> relabelling in constrained memory environments infeasible.
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
> ---
>  policycoreutils/setfiles/setfiles.8 |  4 ++++
>  policycoreutils/setfiles/setfiles.c | 11 +++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfil=
es/setfiles.8
> index eabf0a1c..7c9c5d39 100644
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
> @@ -187,6 +188,9 @@ use up to
>  threads.  Specify 0 to create as many threads as there are available
>  CPU cores; 1 to use only a single thread (default); or any positive
>  number to use the given number of threads (if possible).
> +.TP
> +.B \-A
> +do not track conflicting inodes (saves memory)

Likewise here, I would say inodes with multiple hard links or bind
mounts that would match differing contexts but no need to re-spin just
for that IMHO.

>
>  .SH "ARGUMENTS"
>  .TP
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index ad09f840..4db3e894 100644
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
> +       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:A";

Should this be sorted? I'm ok either way and we don't seem to be
consistent, just asking.

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
