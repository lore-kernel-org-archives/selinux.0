Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98928D845;
	Wed, 14 May 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249932; cv=none; b=ijFTn1p+4kGlP7gbbbzOeZKd5eT92yC2NKcCVED77mUjIZiMOh9ALDWJAPNXgkhtRPaizrDn9/052jJao+Gbx5IYWm1vUvDq5YhtrCKGkWZadqqW8gfixKm9hhdPyhfBpW6GoFbxvpYv3CGO/DIq+/vy9u5bfpjQXiLk7A/8Q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249932; c=relaxed/simple;
	bh=x6hp/nwbDhMCy76zMJE6YsIV48Iou3QqK2ehxXyhniQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkgddegrN4aNCJQ6oMpZVHQQ/K0q+7wxn95d6QvE356U2u6WTqlifcnUl9PGGHlcl5nxSgsITibvh2JoQ9GZeCn2bwD3PWmdOfZpbxkGbHxZFpuXxF25ASr0FmB0gb1vcD/8ZOqYas3w7/BVCTOdapkwnKMxDFIos2nw2TtQis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwcDmqvL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwcDmqvL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30820167b47so218143a91.0;
        Wed, 14 May 2025 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249929; x=1747854729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JTblm+Vm6knlIU7Mus2muRFYHdRIST7xjUu2xbNQuM=;
        b=gwcDmqvLz6WIMla0HWv6xFnnRs5ZtR5i++qO8uTvazf1Mx8dYryMhNOaaVY4xfqWbL
         OeyoM0ifuVTkhnr/BLF58jfLOHxV4Zj+V8EqkZbDaodAudvJyyH/v/nj2i/dMWQz/EOf
         rwLksLopBhkfhaWu7e+r74moVgsEE3xxQYHNh6/7wZFEkF9Lw9tv8K0OMO1CoHipBcW4
         XockmdU47ztHUGhZsMcHlQNqV/nWvXeYQSgn4gaOBCaqaYu792VpIzAEDGDPMA0K9f9u
         DsGYb4aKhkJ6PdsVUNo8npKPNaxXayi7zNIxVAQFrr4cILpVhPKiPMOs7HPyJE8HySkD
         pJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249929; x=1747854729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JTblm+Vm6knlIU7Mus2muRFYHdRIST7xjUu2xbNQuM=;
        b=IYAkugngtbdTd/RKBIMqwANroxSEaatpj7RlM/s+tXr57s6rioxMES8Rv2IVPr+fyu
         9Ct9/RwSrlB48JXFWrwE59JC2SKzG4LsXBxdFBUR+T5+XLiQdULZN/oXVgARot2kcIsz
         fDYz4o/ShnKmGc3QlreqKJ2caon7AyEAMBLRzcgWPW4EuiEXCRYSL4rOk8xF5PI1f74Z
         IMOlbg+vSRUem3TMcLJ96GF3vPQcPBstqZq98zE5pzMcitR79Rkb2Ep5BoLUW1WcClo1
         eF7kmMZzpX+RQARW9VXQ39MMi0qVsT/Gfkmqq3VVDYjcdEH1o9iqTkvT9dk/++C7cgnR
         MccA==
X-Forwarded-Encrypted: i=1; AJvYcCUg1a2jKn8kxxn2hej/rA62GbcsVb8XACJROq7tQBgm0h0mzMDOB+Q9G9WINld5BVsutbKq5MW+IfmkDr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodUy9rCHJFHrBaHK9nK1l6IA9P7TlX70emrp1cIzUzcJGY5hW
	CIMlMq2j32z53mXMQvdiNcku4WSgjlTyf5QmXE7H/nd8nt91EYbMkrM2VGUP5a0NCSbM/bLiF/Z
	5+AS3W83yboebQgnStB8I0ZzDGccySdZAJw==
X-Gm-Gg: ASbGncsMIg7Q+4qfOPk7duDO6yW8GkkQuGv6fQsifGoWGmRRL0oFacb/4xS6LT+sDbO
	0TVh9LiBn3ou1U7aTYuOI62tZTlnPmc4GLFMAZFFOZDLAX04R6C5ISDzPryBf9Ykg4f/VLoameu
	/kW5twlssEbwXT5UrKpcZDsoBTdItW/F5Q
X-Google-Smtp-Source: AGHT+IGSyZX7yN7Iw4juAVnQ6B08qG4jVmuBycJu7xv3LHeVMj9ijUR/Pydudamc0dCiCZZT1Ajv47p4ngL5wd+yWOE=
X-Received: by 2002:a17:90b:5628:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-30e4dac971cmr1180049a91.2.1747249929295; Wed, 14 May 2025
 12:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-11-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 15:11:57 -0400
X-Gm-Features: AX0GCFufs5BrK4qnKn-gzCevR1bWug2XlTeYEFvpMzw1RUPTW0hLCGpRbon-vhc
Message-ID: <CAEjxPJ6p_JPqUyvcQJL1=Vfa+5C_zt-oB7yvpkBYLCBLfxi55w@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] selinux: more strict bounds check
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate the types used in bounds checks.
> Replace the usage of BUG(), to avoid halting the system on malformed
> polices.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/policydb.c | 29 +++++++++++++++++++++++++++--
>  security/selinux/ss/policydb.h |  1 +
>  security/selinux/ss/services.c |  3 +++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 4559c8918134..7774f6da2ebe 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1020,6 +1020,15 @@ bool policydb_class_isvalid(const struct policydb =
*p, u16 class)
>         return true;
>  }
>
> +bool policydb_user_isvalid(const struct policydb *p, u32 user)
> +{
> +       if (!user || user > p->p_roles.nprim)
> +               return false;
> +       if (!p->sym_val_to_name[SYM_USERS][user - 1])
> +               return false;
> +       return true;
> +}
> +
>  bool policydb_role_isvalid(const struct policydb *p, u32 role)
>  {
>         if (!role || role > p->p_roles.nprim)
> @@ -1942,6 +1951,12 @@ static int user_bounds_sanity_check(void *key, voi=
d *datum, void *datap)
>                         return -EINVAL;
>                 }
>
> +               if (!policydb_user_isvalid(p, upper->bounds)) {
> +                       pr_err("SELinux: user %s: invalid boundary id %d\=
n",
> +                              (char *) key, upper->bounds);
> +                       return -EINVAL;
> +               }
> +
>                 upper =3D p->user_val_to_struct[upper->bounds - 1];
>                 ebitmap_for_each_positive_bit(&user->roles, node, bit)
>                 {
> @@ -1979,6 +1994,12 @@ static int role_bounds_sanity_check(void *key, voi=
d *datum, void *datap)
>                         return -EINVAL;
>                 }
>
> +               if (!policydb_role_isvalid(p, upper->bounds)) {
> +                       pr_err("SELinux: role %s: invalid boundary id %d\=
n",
> +                              (char *) key, upper->bounds);
> +                       return -EINVAL;
> +               }
> +
>                 upper =3D p->role_val_to_struct[upper->bounds - 1];
>                 ebitmap_for_each_positive_bit(&role->types, node, bit)
>                 {
> @@ -2013,9 +2034,13 @@ static int type_bounds_sanity_check(void *key, voi=
d *datum, void *datap)
>                         return -EINVAL;
>                 }
>
> -               upper =3D p->type_val_to_struct[upper->bounds - 1];
> -               BUG_ON(!upper);
> +               if (!policydb_type_isvalid(p, upper->bounds)) {
> +                       pr_err("SELinux: type %s: invalid boundary id %d\=
n",
> +                              (char *) key, upper->bounds);
> +                       return -EINVAL;
> +               }
>
> +               upper =3D p->type_val_to_struct[upper->bounds - 1];
>                 if (upper->attribute) {
>                         pr_err("SELinux: type %s: "
>                                "bounded by attribute %s\n",
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index 1367387beaa7..04acf414fffa 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -324,6 +324,7 @@ extern bool policydb_context_isvalid(const struct pol=
icydb *p, const struct cont
>  extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
>  extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
>  extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
> +extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
>  extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boole=
an);
>  extern int policydb_read(struct policydb *p, struct policy_file *fp);
>  extern int policydb_write(struct policydb *p, struct policy_file *fp);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 5b1d0e80d975..464a4663c993 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -718,6 +718,9 @@ static void context_struct_compute_av(struct policydb=
 *policydb,
>          * If the given source and target types have boundary
>          * constraint, lazy checks have to mask any violated
>          * permission and notice it to userspace via audit.
> +        *
> +        * Infinite recursion is avoided via a depth pre-check in
> +        * type_bounds_sanity_check().
>          */
>         type_attribute_bounds_av(policydb, scontext, tcontext,
>                                  tclass, avd);
> --
> 2.49.0
>
