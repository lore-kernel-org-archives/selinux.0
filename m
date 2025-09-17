Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBD2E5B04
	for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145711; cv=none; b=KlXdyfWrNej2EoWFTIyMcE1zP1xUFzlVHoYJlMLornpcvEsXH3qE89VcYeSszhBv9tv+NuZIH8JBQL+QsQMD/ciZ724bl5j+27PkTZr1ud//aNtXK/rD7QadWkGZhsHHLJhE1iUB4Y4cSJeg4S47XxOWiSdUTyN2jIHc4pOFooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145711; c=relaxed/simple;
	bh=GNzw6n4ZVqYvmoEk3T/y2uuXOFZK8wZmuV6G3wlaSOA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QOiHXLS9iItzTXGpCotLDXWfGCwjC3K47e0Ioqmr4xwrp4PUeJOHCl5o87DeswlufcMTRzGif65e0UovqyIXjjAX2E8vyknlNE21tEFQCQIP0H/lA9cxJYmR41Ob8dU3PpaawCexAx8SEAQRa9qAyVvJHxWzcTY7MWhW36H3tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkVZDRKh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkVZDRKh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78ed682e9d3so2654186d6.0
        for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758145708; x=1758750508; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2+FsB0oGhnB0GpSeIJgcK0wtXgKNyr+4e1+wcxe7NY=;
        b=ZkVZDRKhjsZfnE+3dA1/15IWVXZdfJVdaO9smAP/eNIUotacx6GdSdaUueL3JCGWHf
         2cCo2r/ejs4S8OtElJ3XFpvu7ZX/hD5+gAPXszoSVQojmQC2in2YGOnAerYyfUPVVPLt
         /7KPPDuE2d13LUWbC5lx+ZDz5UQIPjNuxkO0ErFwNXjgOX64LvkOAyRSswVtdLE/xCm9
         IZOeWG1DsUwzIzzWEu5mr0Q6cYceIX/XFWVubnbuZAmOc8lWbYEaiRogl1et4f2q/1hS
         DBoP2mQhEN8FQcyiM4hYR25mEcr02MrHjcgWD7+gY2FDMJ4o+/cbwO7V8hmmXFxj3yzS
         XijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145708; x=1758750508;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2+FsB0oGhnB0GpSeIJgcK0wtXgKNyr+4e1+wcxe7NY=;
        b=dpsVNOn/worKQp6jRuqeNJ4aRxo6ThyGyOrgsjJvoPKbeW+TULG/s5l9ugFKhT6p7a
         VJuxWbxCEkm9+tEveaUIRWx+ahF5Rz8jHqM5Qgzl2jYeZAYu3ok73M2cGZtrilRziG+L
         NnfSGvQxwhFwYmZFyUCUnImmQ9QLGf/xZHo22OWTmPdTgXpQq96nM4uj3E1lNjcX0avS
         O95Q15bD92aRCH8uS2YvGTZURwPLRl11EJ/xYMfJXGblITvPE2baawW2yCgluxyvIRzC
         bgGz8z8eWx/x3J9fvndNsHXeJ6XPuI8Kpnu6arqW8lX49y+VHevAdolmXO70ztyvYPnm
         T0/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfDQcJB2FpS6iKdVRKqroz9h33Aoew4i3Ia+KYdUxQZdvVnRCpr+2eUG1MBYa2jT1tQqHbQW3V@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nx/4d+QWapSzXA8JxUB2xgxWl2KrPoiK8UiRi6vmE9pgUKf5
	UJ6cCztvfBeBQHuF9/SoQJrsMdEaeoCFF5RZGWxODtne6ZzTvi9cxAMbscjR2onNDA==
X-Gm-Gg: ASbGncv/KJ9JQYnRd4FgO113DE6/9V0rbBi7cJJwpFExfN6LkMb2fvNo6j4MnrvVb3a
	EKhsAKAwMcX06Rj9T3qL6IlPa6MjlKNKZA+cfoQD15s3iUtN5t+JtEp4b9Xp7laEEJkF6mudQB7
	F3403PumpvpuiUeO7oUbTjmjWvIvhu0mIEfSe92GoB14ovSpzI9Svgondn0PkGr2qw9Q9Izdu9Q
	3LO/GI3jzBbpK6V7C0o8acbD6eyTNCJISD0ka/Mzo+iErmUgbKReoLMPOfnAc/rVuqQO700+1I/
	vrK0VzbVWApVw7l/k/UXWD+77xHQ959FjT6Q8wtCwdjsrqSLXzInCVYWgC5gDqNZzHw8lAnuHza
	If29Vtub/tpGbln5n/+y7ennaOmKzZnDRHSyTHTEwSHhtGHaOk3JTU1NDyWhmSJwY4eTk6HnrYr
	E8pLV8zJsq1vJ+64BmLBMd4w==
X-Google-Smtp-Source: AGHT+IEj9xCk3AVx8ZB77EwFnqoJNQHrtkO0FFyl/hgo+0xVDIagSzxYT4kM/KNgBL5ymJYnRZBWnA==
X-Received: by 2002:a05:6214:240f:b0:70b:a189:a571 with SMTP id 6a1803df08f44-78eccd02716mr47654996d6.25.1758145708477;
        Wed, 17 Sep 2025 14:48:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-793473b8633sm2522506d6.29.2025.09.17.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:48:27 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:48:26 -0400
Message-ID: <1752d2d2f04b17d4da2e40990985be51@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250917_1543/pstg-lib:20250917_1545/pstg-pwork:20250917_1543
From: Paul Moore <paul@paul-moore.com>
To: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, danieldurning.work@gmail.com
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
References: <20250821182021.304-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250821182021.304-1-ericsu@linux.microsoft.com>

On Aug 21, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> 
> BPF token support was introduced to allow a privileged process to delegate
> limited BPF functionality—such as map creation and program loading—to an
> unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
> 
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
> 
> Supported operations currently include:
>   - map_create
>   - prog_load
> 
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
> 
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
> 
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
> 
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
> 
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
> 
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
> 
> Changes in v3:
> - Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
> 
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c                   | 90 +++++++++++++++++++++-
>  security/selinux/include/classmap.h        |  2 +-
>  security/selinux/include/objsec.h          |  4 +
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  6 files changed, 101 insertions(+), 3 deletions(-)

Thank you very much Eric for working on this, I've got a fit relatively
minor comments below, if you get stuck on any of these please let me
know.

Also thanks to Daniel for his work on an earlier patch as well as the
review and test work that has gone into this one.

... and of course thanks to Stephen too ;)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e474cd7398ef..d949e9c5aa31 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  		goto out;
>  	}
>  
> +	sbsec->creator_sid = current_sid();

A few things come to mind as I'm looking at the new creator_sid field.

First, we should explicitly initialize @sbsec->creator_sid to
SECINITSID_UNLABELED in selinux_sb_alloc_security() just as we do the
other fields.  Yes, the LSM framework does some basic clearing, but this
is safer long term and it isn't likely that superblock allocation is
going to be common enough to where the extra assignment is going to be
a concern.

While I don't think this is an immediate issue, I think it's a good idea
to ensure that the selinux_cmp_sb_context() function compares the
@sbsec->creator_sid fields and only returns true/"match" if they are the
same.

Similarly, we should probably copy over the creator_sid field in the
selinux_sb_clone_mnt_opts() function.  Almost surely not an issue now,
just look at the callers, but it's very possible that something might
change in the VFS and/or how people use this new functionality and we
could get caught out with a missing/bad label for the creator.

>  	if (strcmp(sb->s_type->name, "proc") == 0)
>  		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>  
> @@ -7014,9 +7016,13 @@ static int selinux_ib_alloc_security(void *ib_sec)
>  static int selinux_bpf(int cmd, union bpf_attr *attr,
>  		       unsigned int size, bool kernel)
>  {
> +	bool bpf_token_perms = selinux_policycap_bpf_token_perms();
>  	u32 sid = current_sid();
>  	int ret;
>  
> +	if (bpf_token_perms)
> +		return 0;

Since @bpf_token_perms is only used once in this function, we can skip
the local variable and just call the lookup function here.

  if (selinux_policycap_bpf_token_perms())
	  return 0;

>  	switch (cmd) {
>  	case BPF_MAP_CREATE:
>  		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,

...

> @@ -7144,10 +7180,15 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>  	kfree(bpfsec);
>  }
>  
> +#define bpf_token_cmd(T, C) \
> +	((T)->allowed_cmds & (1ULL << (C)))
> +
>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>  				    const struct path *path)
>  {
>  	struct bpf_security_struct *bpfsec;
> +	u32 sid = selinux_bpffs_creator_sid(attr->token_create.bpffs_fd);
> +	int err;
>  
>  	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>  	if (!bpfsec)

This isn't an issue with your code, and to be clear I'm not asking you
to fix this, but more as a FYI/TODO for me (or anyone else who would
care to do it), after the BPF token patch is merged, we should move the
@bpfsec allocation/lifecycle-management for tokens out to the LSM
framework so it can properly handle multiple LSMs.

> @@ -7166,6 +7230,27 @@ static void selinux_bpf_token_free(struct bpf_token *token)
>  	token->security = NULL;
>  	kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
> +{
> +	struct bpf_security_struct *bpfsec;
> +
> +	bpfsec = token->security;
> +	switch (cmd) {
> +	case BPF_MAP_CREATE:
> +		if ((bpfsec->perms & BPF__MAP_CREATE) != BPF__MAP_CREATE)
> +			return -EACCES;

The @bpfsec->perms field is just a bitmap so we can simplify this check
as shown below.  Yes, it is a bit nitpicky, but the resulting code is
much cleaner IMO.

  if (!(bpfsec->perms & BPF__MAP_CREATE))
    return -EACCES;

Same thing for the BPF_PROG_LOAD case below.

> +		break;
> +	case BPF_PROG_LOAD:
> +		if ((bpfsec->perms & BPF__PROG_LOAD) != BPF__PROG_LOAD)
> +			return -EACCES;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
>  #endif

...

> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 1d7ac59015a1..b7e55e5c6d9c 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,6 +87,8 @@ struct superblock_security_struct {
>  	u32 sid; /* SID of file system superblock */
>  	u32 def_sid; /* default SID for labeling */
>  	u32 mntpoint_sid; /* SECURITY_FS_USE_MNTPOINT context for files */
> +	u32 creator_sid;	/* SID of privileged process and is used to */
> +						/* verify bpf operations */

Drop the second comment line and only use a single space between the
field and the comment.

  u32 creator_sid; /* ... */

>  	unsigned short behavior; /* labeling behavior */
>  	unsigned short flags; /* which mount options were specified */
>  	struct mutex lock;
> @@ -164,6 +166,8 @@ struct pkey_security_struct {
>  
>  struct bpf_security_struct {
>  	u32 sid; /* SID of bpf obj creator */
> +	u32 perms;	/* allowed AV permissions, e.g. BPF__MAP_CREATE, */
> +				/* for requested bpf commands */

Similar to above.

  u32 perms; /* ... */

>  };

--
paul-moore.com
