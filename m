Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5E2857C7
	for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263094; cv=none; b=hVsQwM1UtlqddwXsmmNHC7WZ64EajybTpdScuhGDXQB7RtUesNzyfKvDxx8DPSIwZg8zqP+5qncrzoCyuq7ISoYJUoxexWYYTgrgIr0dixKqYvaHi3MJaM5eFcyKcCD5G0hCjYZhv0wEoQ7BAvkr80JTk5KUJM0A5Bcb12gJoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263094; c=relaxed/simple;
	bh=4S7jZ3uC4JBPtyAOlsnSX2bqFuLQK8X7sOt+PRLiduc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPlWvvz456k1KM7O0X1R4FB1FCTbNoSaXoBkoAcr4t6hXFcmcQVJpdfy+GctnNjrMVKz8Sqh2Pfg5Nldgh534FrSZ1V+cznlbj4I15QaqPcDMCt80JpXtAh+jwL9i2laty/3rvOudA70xGGEZzeMxrz7eAqxEmQFc3w8gUuR3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R50h/6CR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R50h/6CR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so7527004a91.2
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759263091; x=1759867891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGGTuNMSpK/IX2jcE2kdw78gs62apiEUig7wcWdCPrA=;
        b=R50h/6CR66QxXK4Mwqd5Ta2uMRpyDfCBwXbCi8GGIp7v6AM/BfJkKwxD15KrEI7+9Z
         iyokZXprclWko3bfEH0LeodQvO8IpKdizWehEE78K1JTJDpx693lnCcnSyC385y7Z9NP
         fufBqGzd6kBv3GjzRfFFFX6NEiDdzgymWvZPDz8evSnwq9uaKK7wDU+zi/oN6iLHA7DA
         mQM7KuogjwfCB637+JIcaAUB9ENVGKBJo0Xg85ilR0MQUeA6JeLFAKtdHDvwEudO15Xu
         CvLVSZdKiZpNVtVq8Fpxl5UPViSClNI4PtkaMsE2QcqGTlQcDy46ME0C3riKr3gedgtX
         TyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263091; x=1759867891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGGTuNMSpK/IX2jcE2kdw78gs62apiEUig7wcWdCPrA=;
        b=KP5LmYKUNLu/o2vbJpr0u5rGRdc9l/L3o/1Vlrc+aAQrJW7DDMwd/9PZFnFXTCgDYx
         MPCA3LFU4I0+Gm+uhNguKCO19N0ennGEF+C1DBloMzjeW7nBGlk54/bHCBMTKpBZgXLp
         8ESGla2Ip5RhKR7PfHJogvub2D+jruYyHWC02Wpjt782PgC5cl35WLFkl4oUfxGmLWyo
         nLd8Ny0msR7qNNde2m+BN7IGPlr4qbKT3qblo2IDvfKl2yyOL19lX/L80BvE2fLSdKog
         E3PKWOCiipFCxtWOVb2/ZwSc1TBzF3gswSqvOMED8ciDUo8GoLvBGiGGVWHWR1DFJKBH
         UtjQ==
X-Gm-Message-State: AOJu0Yy6+EC3ifhlrVw7K0munWt4tUpYpaxZGbbfCurDSiocNfjvhVvZ
	YkXqYeL+9RNIbRv59R85F1f1MYrO10tWUV8Q/3a+uz0jC0O6shixlsDvq6CjYPSO0YGchPIs3xC
	60yQawM+Jna8dIt3ZD3ZbUiW6vtr4Bh2OnbzqUmmY
X-Gm-Gg: ASbGncsZsfhekHyhAI+S9PG+queqK4Tc//qKzjTIpX9w+g5xf+bJUciE0ePQYGrN9cZ
	rViPRB1jNHAhXhtakGQKSP9neZSnby+SAFp8VN3j6QJn43uh6aJtEk71Djoojoof+ounABJbRQV
	p2WHdgLeq7IqbS0AHQtkrq+WbUS71odC+bn1GUdAJvnmH49dbIUdg3LZpDcs0W9woAh8ACAU4Fr
	i2wL3eMSvnxHD+QTvh0ED1FNKPZ9zw=
X-Google-Smtp-Source: AGHT+IH19QaUhYGV0YsoCoE1LU0CmmNRvyL6yd0SCrGLdokCAFDK+kSvCCPTwgIB0Agj0AUOYRQz9b4VVeztVQwQKPE=
X-Received: by 2002:a17:90b:4f8b:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-339a6f06e29mr760547a91.22.1759263090694; Tue, 30 Sep 2025
 13:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-67-paul@paul-moore.com>
In-Reply-To: <20250916220355.252592-67-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Sep 2025 16:11:17 -0400
X-Gm-Features: AS18NWCP-Q5jq8SXy7IkNbNEbfERyy-dg84QqfHzyCZ7GFhRE-mFkbyKDIwrsVc
Message-ID: <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>
> This patch does not touch any of the platform certificate code that
> lives under the security/integrity/platform_certs directory as the
> IMA/EVM developers would prefer to address that in a future patchset.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> [PM: adjust description as discussed over email]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/integrity/evm/evm_main.c  |  3 +--
>  security/integrity/evm/evm_secfs.c | 11 +++++++++--
>  security/integrity/iint.c          | 14 ++++++++++++--
>  security/integrity/ima/ima_fs.c    | 11 +++++++++--
>  security/integrity/ima/ima_main.c  |  4 ++--
>  security/integrity/integrity.h     |  2 ++
>  6 files changed, 35 insertions(+), 10 deletions(-)

I appreciate you reviewing most (all?) of the other patches in this
patchset, but any chance you could review the IMA/EVM from Roberto?
This is the only patch that really needs your review ...

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index db8e324ed4e6..73d500a375cb 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1179,6 +1179,5 @@ DEFINE_LSM(evm) =3D {
>         .init =3D init_evm_lsm,
>         .order =3D LSM_ORDER_LAST,
>         .blobs =3D &evm_blob_sizes,
> +       .initcall_late =3D init_evm,
>  };
> -
> -late_initcall(init_evm);
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/=
evm_secfs.c
> index b0d2aad27850..c26724690cec 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -302,10 +302,16 @@ int __init evm_init_secfs(void)
>         int error =3D 0;
>         struct dentry *dentry;
>
> -       evm_dir =3D securityfs_create_dir("evm", integrity_dir);
> -       if (IS_ERR(evm_dir))
> +       error =3D integrity_fs_init();
> +       if (error < 0)
>                 return -EFAULT;
>
> +       evm_dir =3D securityfs_create_dir("evm", integrity_dir);
> +       if (IS_ERR(evm_dir)) {
> +               error =3D -EFAULT;
> +               goto out;
> +       }
> +
>         dentry =3D securityfs_create_file("evm", 0660,
>                                       evm_dir, NULL, &evm_key_ops);
>         if (IS_ERR(dentry)) {
> @@ -329,5 +335,6 @@ int __init evm_init_secfs(void)
>  out:
>         securityfs_remove(evm_symlink);
>         securityfs_remove(evm_dir);
> +       integrity_fs_fini();
>         return error;
>  }
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 068ac6c2ae1e..8ec1a3436a71 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -42,8 +42,11 @@ void __init integrity_load_keys(void)
>                 evm_load_x509();
>  }
>
> -static int __init integrity_fs_init(void)
> +int __init integrity_fs_init(void)
>  {
> +       if (integrity_dir)
> +               return 0;
> +
>         integrity_dir =3D securityfs_create_dir("integrity", NULL);
>         if (IS_ERR(integrity_dir)) {
>                 int ret =3D PTR_ERR(integrity_dir);
> @@ -58,4 +61,11 @@ static int __init integrity_fs_init(void)
>         return 0;
>  }
>
> -late_initcall(integrity_fs_init)
> +void __init integrity_fs_fini(void)
> +{
> +       if (!integrity_dir || !simple_empty(integrity_dir))
> +               return;
> +
> +       securityfs_remove(integrity_dir);
> +       integrity_dir =3D NULL;
> +}
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 87045b09f120..012a58959ff0 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -499,9 +499,15 @@ int __init ima_fs_init(void)
>         struct dentry *dentry;
>         int ret;
>
> +       ret =3D integrity_fs_init();
> +       if (ret < 0)
> +               return ret;
> +
>         ima_dir =3D securityfs_create_dir("ima", integrity_dir);
> -       if (IS_ERR(ima_dir))
> -               return PTR_ERR(ima_dir);
> +       if (IS_ERR(ima_dir)) {
> +               ret =3D PTR_ERR(ima_dir);
> +               goto out;
> +       }
>
>         ima_symlink =3D securityfs_create_symlink("ima", NULL, "integrity=
/ima",
>                                                 NULL);
> @@ -555,6 +561,7 @@ int __init ima_fs_init(void)
>  out:
>         securityfs_remove(ima_symlink);
>         securityfs_remove(ima_dir);
> +       integrity_fs_fini();
>
>         return ret;
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index eade8e1e3cb1..b703bfc2f470 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1283,6 +1283,6 @@ DEFINE_LSM(ima) =3D {
>         .init =3D init_ima_lsm,
>         .order =3D LSM_ORDER_LAST,
>         .blobs =3D &ima_blob_sizes,
> +       /* Start IMA after the TPM is available */
> +       .initcall_late =3D init_ima,
>  };
> -
> -late_initcall(init_ima);       /* Start IMA after the TPM is available *=
/
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index c2c2da691123..7b388b66cf80 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -114,6 +114,8 @@ struct ima_file_id {
>
>  int integrity_kernel_read(struct file *file, loff_t offset,
>                           void *addr, unsigned long count);
> +int __init integrity_fs_init(void);
> +void __init integrity_fs_fini(void);
>
>  #define INTEGRITY_KEYRING_EVM          0
>  #define INTEGRITY_KEYRING_IMA          1
> --
> 2.51.0

--=20
paul-moore.com
