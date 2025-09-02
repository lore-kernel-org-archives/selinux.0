Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04162DC353
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827992; cv=none; b=Qt1Resmaqpv+QZuvkRvTaDdQWK8Bt7s+Qc8hZnCfV8VQcJumraTzUO1wFQU4ve91fvMpccWAsDmyOKHJp/mpCZZxwLr3tqYcRbafPFx18/7sBeNIHiA6UiDJ5JjE9Bw66jnd6xH2Da6Fd66tC5T6v4eJCYBWI8p91XoCnCDCKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827992; c=relaxed/simple;
	bh=84EkvKSFQytHOr5wPfHh+SqP3xnPhY2sv+aKhZqhXx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciHV4Ypc91dnH+DVymWkokth62PV11e1epPS4PFP8g3sEgeuv42MWu5T9OGabQu8ZtkJ8zzMhRHC8Qg8AKMEoy8xSN++cA+Dlkmh99+fwaULEpwK0gSDdeRHZJDkCmilNAlUCTaBXooZq2/A1aYA+nz11BPrBYgGYBH3sN6nmRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyqNtuv1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyqNtuv1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248c7f955a2so49047955ad.2
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756827990; x=1757432790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLjUl/69VEgieZGeBzVCPjFRVERoMj5AiKNGPP/3SpI=;
        b=NyqNtuv1Ehsje0wb6K9xcLuSeyDRpQo5ylMB0/a6mwZPcepDsKiyNwaJW/0PEYPkis
         Z7d0ONUnzDKm8g9vR+1xK98eWp9tOaKYuV5/g2dWYuJBdOTVITsI2HEj9aAyw8nL8OBD
         SNKYQ1tZAcjH2qnlhUgTfCNWq8N8Sdicx5pqGQ96NIt5XZ1KfWcSbSx5jVsBnAXKnXmz
         4rC4kcOH3nEmN9YydmAr03O0RGLtkm7j9RHTl9+AvfQU8nxKWj3cVJ2ZK2S/5ZBnZQNe
         Fr4pZFDqbFk+TIUg9rJXTZS60U7ip6i9pnaZwovu34JQER9exDlZmCPpM/ExHlVmtkBo
         2msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827990; x=1757432790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLjUl/69VEgieZGeBzVCPjFRVERoMj5AiKNGPP/3SpI=;
        b=gS6ZOQX5HDriiiOzIqBE6E7UfHVb+CrzvhkMqO5MlLNxLCgHghdeQYtzdz1VIu6yqn
         pc8SoDiT93+pDu2a8j7ZBd0l8uEss1pNQsl5O3m+01bXoEQ1aTH6H6g75kOEL5cbI5JQ
         0iu7Jw7ohlmJmZK/zcwhQhPZFwRcdNtILNseGsfOAGFDPCqy2hooA1x6U1JMuKvqs8HP
         SNITq4zJmsOohAftSw20Ce9qFplX5NNLtCx6TmtXsJKvACwu20R6GsfVLWQnCLuPjbpv
         rW7Cn0JgroXPSRAruzz9WH6bGvnY5+7eliEK69cigXwKi7U/7zzlDy5AmfXtlcMuon/T
         X9ng==
X-Gm-Message-State: AOJu0YyBd0hEWwuQX2jZVeTbV6tK15qwiK7ESVw0J1HNbpv66zNft/b/
	qjw79lqn2pocggPImZ2uxKuCxEuyUhL/Lkf2UfRp7J/W/pyoIMTlG7v1obFZ5XS7crROMK/cpsV
	bqPKW3XO0xqZ1xdylWizcH11dASt9HcB8XA==
X-Gm-Gg: ASbGncvxvx0spDUfIMyDX+eDeLm2HwXbc8yvefYrwFBeZWXRGqmqMds0s7Mvrkyl38y
	AKZ5I404ce0z0BePj1mBL2AkFD8sEMS7m7L6XUJ5cjhJtgQ6tlFrgwiREvPKT7a5fIdl4wtqQCh
	hlSeLzmqHf7Eujit8GuyXcDvt0hiifeuBKuVF7wmxGgw63g2niQV6PYa5pvvQ6WPn2leEI6xnaI
	edPGlE=
X-Google-Smtp-Source: AGHT+IEJTStx9v5WBlPqj/i1IJFR9zMnnzDCBF5xUm+DS4khNtsyUkDSMRxizbvOje9bbndPB9LjKh73XSDLrib8UPk=
X-Received: by 2002:a17:903:41cd:b0:248:9348:965e with SMTP id
 d9443c01a7336-249448f8a41mr154179385ad.9.1756827990042; Tue, 02 Sep 2025
 08:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901143412.2904562-1-rjones@redhat.com> <20250901143412.2904562-2-rjones@redhat.com>
In-Reply-To: <20250901143412.2904562-2-rjones@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 11:46:19 -0400
X-Gm-Features: Ac12FXzSmbPDGkeDiUqaQ3SYuyPsJdjeLW3nFpGwWGX_lnmqKRTRf5li0sBJlQA
Message-ID: <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com>
Subject: Re: [PATCH] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:34=E2=80=AFAM Richard W.M. Jones <rjones@redhat.c=
om> wrote:
>
> SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have
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

I don't think we usually include downstream issue tracker links in our
upstream commit messages, but no need to re-submit just for that.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.8 | 4 ++++
>  policycoreutils/setfiles/setfiles.c | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
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
>
>  .SH "ARGUMENTS"
>  .TP
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index ad09f840..40f2e7fe 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -147,7 +147,7 @@ int main(int argc, char **argv)
>         const char *base;
>         int errors =3D 0;
>         const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
> -       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
> +       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:A";
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
>
