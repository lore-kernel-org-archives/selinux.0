Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B591A3A8A
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305212; cv=none; b=pbY4IfbKXDTbEDzppW5k2+y1Q93uWMRKDm/bmkxqKgUpNLXGvLxEff+bwfV2ZM4mT9Kwt+EYh5RdwRG7OI3WSxeC+gL+TO6fPIdcWmZgRQ6PZrU6PKtpWfSDzNT17vjFcTrDYBlXpvi+HNIgEkZH14X4MOdz5URDf8kMf341b+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305212; c=relaxed/simple;
	bh=IBgdwAJe5H17wbrZDVA2x27/kX07CfX/jTa/yjL7fA8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pvEhuoqwZ82J3ujseh9OuB/MefjnqEX4vm87IEIa0X11EMuD8UcLzk5iZSWtgbSMZuvB2fUkdhqo7XAxJVCZdLY5hcVPyYwiXNxR+X+kPffWqXF+CTb9kYaOtpO/A5X4DN6kK4HXQCKr1YDKSDHCclQsh3CP9CZQ8UaHl0hEQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fj4/4Ubr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fj4/4Ubr"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6df83fd01cbso14114956d6.2
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305207; x=1736910007; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9p3PIyde0IryzmGRbQB6cL/YMYO2iIIebuEb1QLjCU=;
        b=fj4/4Ubr0glqj+NgL1fXq2k7rDON1YQSKCXGTblhi1WqGR+9HSjm7ryiK3K5KVNzkc
         smx7Q9WrZZFTXPxzEOSGK6t7VenF7J2HSHpFaf9Hk0X/umFbHczJaaywTnb/tQHCf40/
         u9y/R3v2xQWPvktiqPNcQ9TseRbE457emq8FTBVteCfIrHaL9yibUZZhPXhM4iwCMHsL
         y67WHNwPHjasqWuGY+CKyMEAJsL/TsmvC4b+UYAiMWyjWiCNxh6n7N7eFIXsAV1yfyZ1
         SSK4L7iKVRlYNx1mnqm/wb5rSRyKupqHV1nj7B26a8FIpMa/Zmp7SSHcUY6joIwRYi49
         gGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305207; x=1736910007;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9p3PIyde0IryzmGRbQB6cL/YMYO2iIIebuEb1QLjCU=;
        b=s7v7tvwHHyizMrsmPQIzotq1fwAu0vAY8lhgAz2WyfKe+9xWV3WNpbHS3l1cLn4y+u
         Kxs2kO7KoeV3/Ffu1JJkkvKCePMhZpAKVwfMPTKaOY889mQrOQjOL4KTkHj4ScxE2CmD
         PCve5ODUx+ExO1+n0gLtWO3Vk79RdVQTDwvlknQZOYzXPs042aeyjrmBoqPIHGrXax06
         dTwSH348hJoMamUTCfG5qgFkjEClWrSY4qQbNXh6voAzRVF5V37J/x7c2w8nXoErXhNl
         sWBXreMLqBBYsjmO7v9PmqJBLPkI08a9HTw9YeufftfacTP5U0DRCPyXS4nmOfxc1jRN
         2YQA==
X-Forwarded-Encrypted: i=1; AJvYcCXNeYLvjUDiTcoizLJlwUkx2kxwfrJ8A2gJe32wBsZskBIuCNXv9FqRLWtmhslf/EWrYJ3j1hg6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrl5bsfUnsk+Aws9KBpiwc+KhgPd905/wZPpJhsXh9o3jsWvYX
	53//9WEgcAuhhFb6OsWu2V4aeR3bYFUoSns4lkOMGigVHDreiHA7cuGQTUejIA==
X-Gm-Gg: ASbGncsewE3ztt2lwA/Urw80uEenFwaruaiqGTM+BHJGgM0i5Mc2XuHifSPiXskbASW
	k/7nSzsDpI21kvCInh5DIpMfaRTmgKzBA8jHPNvLUF/Nt8/qnxsh7xtZZxOSyCtXQQcpgNGYolc
	sJAjFB1ndunilZZ9y8oAZlXR5vw48OCebhGjpHdk5kNI18BbY9xWxvRDeozXZ/evQwyDpaes55R
	Ug7FGHOMrUF6BQkL20WCwKV6XhH+T2aaH64PsZChMLAjcX6ykY=
X-Google-Smtp-Source: AGHT+IFRMJcPrngiHqUMozYobBJyTgbsJI3kbTOpFCUuC+SScE55JPq+uPAFNcMMnkTChRvnis6FtQ==
X-Received: by 2002:a05:6214:252f:b0:6d8:7ed4:335b with SMTP id 6a1803df08f44-6df9b25f37dmr23741846d6.26.1736305207047;
        Tue, 07 Jan 2025 19:00:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6df99ff40easm4836756d6.3.2025.01.07.19.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:06 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:06 -0500
Message-ID: <ef5f7c20f5a3a485cdf2603ea4a4cde9@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH RFC v2 11/22] selinux: more strict policy parsing
References: <20241216164055.96267-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-11-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Be more strict during parsing of policies and reject invalid values.
> 
> Add some error messages in the case of policy parse failures, to
> enhance debugging, either on a malformed policy or a too strict check.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   accept unknown xperm specifiers to support backwards compatibility for
>   future ones, suggested by Thiébaud
> ---
>  security/selinux/ss/avtab.c       |  37 +++++--
>  security/selinux/ss/conditional.c |  18 ++--
>  security/selinux/ss/constraint.h  |   2 +-
>  security/selinux/ss/policydb.c    | 157 ++++++++++++++++++++++++------
>  security/selinux/ss/policydb.h    |  19 +++-
>  security/selinux/ss/services.c    |   2 -
>  6 files changed, 182 insertions(+), 53 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index c2c31521cace..3bd949a200ef 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -349,7 +349,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
>  	struct avtab_extended_perms xperms;
>  	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
>  	int rc;
> -	unsigned int set, vers = pol->policyvers;
> +	unsigned int vers = pol->policyvers;
>  
>  	memset(&key, 0, sizeof(struct avtab_key));
>  	memset(&datum, 0, sizeof(struct avtab_datum));
> @@ -361,8 +361,8 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
>  			return rc;
>  		}
>  		items2 = le32_to_cpu(buf32[0]);
> -		if (items2 > ARRAY_SIZE(buf32)) {
> -			pr_err("SELinux: avtab: entry overflow\n");
> +		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
> +			pr_err("SELinux: avtab: invalid item count\n");
>  			return -EINVAL;
>  		}

A reminder that magic numbers are a bad thing, if we can't make it clear
what the '5' in the conditional above represents by using a computed
value, let's either use a #define with a helpful name or a comment to
make this a bit more understandable.

> @@ -444,9 +456,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
>  		return -EINVAL;
>  	}
>  
> -	set = hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AVTAB_AV));
> -	if (!set || set > 1) {
> -		pr_err("SELinux:  avtab:  more than one specifier\n");
> +	if (hweight16(key.specified & ~AVTAB_ENABLED) != 1) {
> +		pr_err("SELinux:  avtab:  not exactly one specifier\n");
> +		return -EINVAL;
> +	}
> +
> +	if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)) {
> +		pr_err("SELinux:  avtab:  invalid specifier\n");
>  		return -EINVAL;
>  	}

Let's define a macro in avtab.h with all of the allowed avtab key
values, otherwise I think people are going to forget about this check
when adding a new flag and they are going to get frustrated :)

> @@ -471,6 +487,15 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
>  			pr_err("SELinux: avtab: truncated entry\n");
>  			return rc;
>  		}
> +		switch (xperms.specified) {
> +		case AVTAB_XPERMS_IOCTLFUNCTION:
> +		case AVTAB_XPERMS_IOCTLDRIVER:
> +		case AVTAB_XPERMS_NLMSG:
> +			break;
> +		default:
> +			pr_warn_once_policyload(pol, "SELinux: avtab: unsupported xperm specifier %#x\n",
> +						xperms.specified);
> +		}

Similar to the avtab flags discussion above, can we create a small
inline function in avtab.h that checks to see if an xperm is valid?

  /* feel free to come up with a better name */
  static inline bool avtab_xpermspec_valid(u8 specified)
  {
    if (specified == AVTAB_XPERMS_IOCTLFUNCTION)
      return true;
    elif (...)
      return true;

    return false;
  }

> diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
> index 203033cfad67..26ffdb8c1c29 100644
> --- a/security/selinux/ss/constraint.h
> +++ b/security/selinux/ss/constraint.h
> @@ -50,7 +50,7 @@ struct constraint_expr {
>  	u32 op; /* operator */
>  
>  	struct ebitmap names; /* names */
> -	struct type_set *type_names;
> +	struct type_set *type_names; /* (unused) */

If we're not using this field, let's remove it.  If for some odd reason
we need to keep it here for size reasons, or something similar, let's
turn it into a 'void *unused;' field.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index eeca470cc90c..1275fd7d9148 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -634,13 +634,11 @@ static int sens_index(void *key, void *datum, void *datap)
>  	levdatum = datum;
>  	p = datap;
>  
> -	if (!levdatum->isalias) {
> -		if (!levdatum->level.sens ||
> -		    levdatum->level.sens > p->p_levels.nprim)
> -			return -EINVAL;
> +	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
> +		return -EINVAL;
>  
> +	if (!levdatum->isalias)
>  		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
> -	}
>  
>  	return 0;
>  }

Hmm, I don't think the code above does the error checking in the same
way, how about something like this:

  int sens_index(...)
  {
    if (isalias)
      return 0;
    if (!level->sens || level->send > levels.nprim)
      return -EINVAL;
    p = ...;
    return 0;
  }

> @@ -653,12 +651,11 @@ static int cat_index(void *key, void *datum, void *datap)
>  	catdatum = datum;
>  	p = datap;
>  
> -	if (!catdatum->isalias) {
> -		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
> -			return -EINVAL;
> +	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
> +		return -EINVAL;
>  
> +	if (!catdatum->isalias)
>  		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
> -	}
>  
>  	return 0;
>  }

Similar to the sensitivity level comment above.

> @@ -1136,6 +1133,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
>  
>  	len = le32_to_cpu(buf[0]);
>  	perdatum->value = le32_to_cpu(buf[1]);
> +	rc = -EINVAL;
> +	if (perdatum->value < 1 || perdatum->value > 32)
> +		goto bad;

More magic number problems.

>  	rc = str_read(&key, GFP_KERNEL, fp, len);
>  	if (rc)
> @@ -1170,6 +1170,9 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
>  	len = le32_to_cpu(buf[0]);
>  	comdatum->value = le32_to_cpu(buf[1]);
>  	nel = le32_to_cpu(buf[3]);
> +	rc = -EINVAL;
> +	if (nel > 32)
> +		goto bad;

Magic number.

>  	rc = symtab_init(&comdatum->permissions, nel);
>  	if (rc)
> @@ -1335,6 +1338,9 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
>  	len = le32_to_cpu(buf[0]);
>  	len2 = le32_to_cpu(buf[1]);
>  	nel = le32_to_cpu(buf[4]);
> +	rc = -EINVAL;
> +	if (nel > 32)
> +		goto bad;

Again.

> @@ -1527,7 +1578,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
>   * Read a MLS level structure from a policydb binary
>   * representation file.
>   */
> -static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
> +static int mls_read_level(const struct policydb *p, struct mls_level *lp, struct policy_file *fp)
>  {
>  	__le32 buf[1];
>  	int rc;

Why is this here?  You don't use the @p parameter anywhere in this
patch and it add some code churn in all of the callers.

> @@ -1606,7 +1657,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
>  	struct level_datum *levdatum;
>  	int rc;
>  	__le32 buf[2];
> -	u32 len;
> +	u32 len, val;
>  
>  	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
>  	if (!levdatum)
> @@ -1617,13 +1668,17 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
>  		goto bad;
>  
>  	len = le32_to_cpu(buf[0]);
> -	levdatum->isalias = le32_to_cpu(buf[1]);
> +	val = le32_to_cpu(buf[1]);
> +	rc = -EINVAL;
> +	if (val != 0 && val != 1)
> +		goto bad;
> +	levdatum->isalias = val;

Should we have a simple inline function to do the integer boolean check?

Considering all the places we check for 0 and 1, it seems like it might
be a bit cleaner, and would help with self-documenting.

> @@ -2221,7 +2303,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
>  
>  			rc = -EINVAL;
>  			val = le32_to_cpu(buf[0]);
> -			if (val >= U16_MAX)
> +			if (val >= U16_MAX || (val != 0 && !policydb_class_isvalid(p, val)))
>  				goto out;
>  			newc->v.sclass = val;
>  			rc = context_read_and_validate(&newc->context[0], p,

This should probably be in patch 10/22, yes?

> @@ -110,15 +110,15 @@ struct role_allow {
>  /* Type attributes */
>  struct type_datum {
>  	u32 value; /* internal type value */
> -	u32 bounds; /* boundary of type */
> -	unsigned char primary; /* primary name? */
> +	u32 bounds; /* boundary of type, 0 for none */
> +	unsigned char primary; /* primary name? (unused) */

See my previous comment about unused fields.

>  #endif /* _SS_POLICYDB_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 28c0bdf9fc9d..d5725c768d59 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -445,8 +445,6 @@ static int dump_masked_av_helper(void *k, void *d, void *args)
>  	struct perm_datum *pdatum = d;
>  	char **permission_names = args;
>  
> -	BUG_ON(pdatum->value < 1 || pdatum->value > 32);

Do we need to convert this to a if-then check that does the proper error
handling, or is it already handled in the other changes in this patch?

--
paul-moore.com
