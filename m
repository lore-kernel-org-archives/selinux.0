Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq3aAeAb"
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC11985
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 08:06:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28652d59505so1998924a91.2
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702051563; x=1702656363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYzeWAVpCpm1+hUcLiUQOOiASYll0SPqIMbMja86sQM=;
        b=Zq3aAeAbTWcqvu42ea653R9IjJpJXsp8Cz3vmJ/VKJn0Fz3fzxpuD4hl1erxD4pML/
         99AJhE2PsCmAQBBl66kAtNI9cxgOT7hGMgnZwhN2KrNeu7ay0tibDTulv9ylraGqpIV3
         hjyV3xXq4uapqNXEieVJbYN/2MoqKWyD+D/8F1YIdl2bx4heE8zBtcjjwWIuCs1YN8CE
         YohVfrhY8H9oobq8ToqBDKwLv7TvtrS+lrHi6uxNEeFMupSC/Rq2Ksf9vnoqDRGMRm7H
         5WCGFcENdCP0WrV1webVme8R4UQ6sHPvg7DInik4dxAGO2LLfAdgXNABG4DABPBnui1s
         Cl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702051563; x=1702656363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYzeWAVpCpm1+hUcLiUQOOiASYll0SPqIMbMja86sQM=;
        b=DHNVBg6eLLhy68/l/xaRktuCEjoqHr1hvQwtCuygcOd4aZ3SfzLiuVwploj2Ups2Wd
         l+4f+W5uXOS1FT5SyFfgjXUO6ir2XTqksQhcy9oTSRMXjd2G5GbWkCavzamA/SXS+eSV
         BQcVEH0YJeSaPb6GuCacgDvi6XE0EGiYgSCfLgUr/m0HOXzWShRlLNX5KKcreEvVq10f
         A5dLQTw2xlf6k5VCKIicwR8sIc/oOI2LQCvnP89beK7WTJRhdm8m4PCOmwWcMhFuUcB4
         +lMXxItLjPPgTnbf0+4NJRazw7RelV/PRsB4JAnZW4VI1p4ncDJvFqudYtXs7cw151oO
         Upfw==
X-Gm-Message-State: AOJu0Yw7mBdZcWuSmALfgHmgLwsM5bvxS5jDhk70WVUr+D3EIsCLvQMP
	Zsn4uRVswFI/TlI0OGL96m0GVOAk0YRQnNzIrDQ=
X-Google-Smtp-Source: AGHT+IFX1TzupDLIOt7R4cPyX4JTBXd3udMw2D6UaNoQ/n7DX+KXZEbYFmt0wB8REwzwHEdrD4WnBP66aGy+b0FCO7I=
X-Received: by 2002:a17:90a:db08:b0:286:9231:c5c1 with SMTP id
 g8-20020a17090adb0800b002869231c5c1mr266824pjv.7.1702051563128; Fri, 08 Dec
 2023 08:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207165319.63889-1-cgzones@googlemail.com>
In-Reply-To: <20231207165319.63889-1-cgzones@googlemail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Dec 2023 11:05:51 -0500
Message-ID: <CAEjxPJ4htnqzDyHFNR_aNJH-hrz_wbM=Z=NN7BjUQDrKBa8e9A@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: validate permission identifier length
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 11:53=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Limit the maximum length of permission identifiers.  Otherwise
> formatting an access vector might fail in the common used helper
> sepol_av_to_string().
>
> The current longest permission within the Reference Policy is
> x_application_data { paste_after_confirm } with a length of 19.

Android has longer permission names. I'd rather just fix
sepol_av_to_string() than impose some arbitrary limit here.

>
> Reported-by: oss-fuzz (issue 64832)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> The oss-fuzz issue got closed by the latest fuzzer updates (due to
> unrelated changes that invalid the current reproducer), but the issue is
> still valid.
> ---
>  libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index bd8e9f8f..72681120 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -366,12 +366,30 @@ bad:
>         return -1;
>  }
>
> +static int validate_permission_wrapper(hashtab_key_t k, __attribute__((u=
nused)) hashtab_datum_t d, void *args)
> +{
> +       sepol_handle_t *handle =3D args;
> +       const char *name =3D k;
> +       size_t len =3D strlen(name);
> +
> +       if (len =3D=3D 0 || len >=3D 32)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid permission");
> +       return -1;
> +}
> +
>  static int validate_common_datum(sepol_handle_t *handle, const common_da=
tum_t *common, validate_t flavors[])
>  {
>         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
>                 goto bad;
>         if (common->permissions.table->nel =3D=3D 0 || common->permission=
s.nprim > PERM_SYMTAB_SIZE)
>                 goto bad;
> +       if (hashtab_map(common->permissions.table, validate_permission_wr=
apper, handle))
> +               goto bad;
>
>         return 0;
>
> @@ -395,6 +413,8 @@ static int validate_class_datum(sepol_handle_t *handl=
e, const class_datum_t *cla
>                 goto bad;
>         if (class->permissions.nprim > PERM_SYMTAB_SIZE)
>                 goto bad;
> +       if (hashtab_map(class->permissions.table, validate_permission_wra=
pper, handle))
> +               goto bad;
>         if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->constraints, flavors))
>                 goto bad;
>         if (validate_constraint_nodes(handle, 0, class->validatetrans, fl=
avors))
> --
> 2.43.0
>
>
