Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115711F3D4E
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956839; cv=none; b=JfcvxCyX/ZoWhtpmIHfFphtvyzTFW8s/8JYi5aK6ePBmBOwrakNCidWp0cT3pGjSIYquu0JJ3txbhoqP9ANnnMohvY9ipBzLseIMmPSXMa+DYSEuTamdDvqyY5n9jYeIM00gEJI0aEhkxSQRS05B9pQF5wO0O54cgolkhpqhZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956839; c=relaxed/simple;
	bh=XjWohJ1rHjS0M0dsdBs+S4FpDa5FRpu6VFQRl6eEPx0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=khe11Xr1WY5+QdluPc71J50tVINMyeN8S+ZMu3a1vmhd1wPYlw/18hDB6U+lnnmZC56SNS7gyeGoJtYad7tCCgR6c9AG7ZoIkR+1WJpEQ4drruKiu4QusHksmae8o2KlrFvegzTJqusy2gMWFbyQptsCB8MjP11JwsjEGJeNQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FpJ00CBF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FpJ00CBF"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46792996074so7803571cf.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733956836; x=1734561636; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbEMBIQICNqdjN4q54mUQTl/ER72J1lRvwAJgJZbqTc=;
        b=FpJ00CBF7NvCqkeemqd0ZUCD4orVkAw/ZiQSLOdbglQth5kkQgLVNIDbIDUW9LmExk
         xzf4x0L9EE+DSzqcFjdPDOKEnc/AdlYwyrYiQCp19VIZg4OvMttRo6FtXyf+qpFd/E6R
         HfLLtJBdQgzg8q4Sbn77YlYsQNzeBMtna2h3eDoJpxEdJnlO8st/A/bK0853hBPOQLzw
         xZNBDqFhQllfuyWCT8I6+4OwPYKfm+UJab11Z5bkordxXUmTpd51hkZR34uy1bhB4Uxp
         Sf24bguFsID+izwHDZ+x2DcQMnDuiSNqCi1INvGlAmXDqJkmJDRrg3glrHv2X3MAkPdU
         FgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956836; x=1734561636;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jbEMBIQICNqdjN4q54mUQTl/ER72J1lRvwAJgJZbqTc=;
        b=fyfgty2GablCPK1xSezxDg3lNZucWlG3nUfZXDdqlkidLw9vbYH3c95bROzUGhxBTu
         +KHAHj45Opvl5TMtZf6gxPjF0MLXvZInVoJ744ZiC6F4O1VKl/7RRHvV89Lmty+ppiyq
         s8UA3bKrhvIxm7WtwvufVBkpxku82t+yZ4bbzO+bJt8ev+OkvBnVMdqdKcLKAgX1pBmD
         FrESYEBzHeQ65xu5G9x6/fHpsW9AXRTXceB2vEVrXuWVh8Xi4DUpjUjwT1/8tdz/ecjS
         vdYoCg7tAm9WsE4aFTBHQ+GzHXkKR9FC6u/u3XwQFzoQnj1XBMB19893Io7of1AMPm9X
         QKgw==
X-Forwarded-Encrypted: i=1; AJvYcCVjinaeN53UyuMzQieEJFNWenwzsfM6sogzxjLl1fpAM75IctVjF90EmyaHSLjnQ0kdnyeSQajd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9UN4yEdXloq+z5nNsOc1O1aKLWnkzoL9mh4MUhvdHmN/ginU
	lV+FXHOcudu0kVSliwjUltJilareFVL19nzUZllLqJoV4MeAiWxLANc8qS8Q6w==
X-Gm-Gg: ASbGncsmdTywsYt6i6LlL6tPHoYf1/l7zrg0F6Vw+ZnFe6bM/WRX8lW0v3MJHTR5R27
	JEj20sMcs7H5bj7UDOiAwFTifg8DxAFdshUHggUAG11mqPWSHvHsO8kPyh88iiIBaETkGzuj7J7
	sx+AdN1VUgyxGh62Ab0ImMG6GxNLprWunH+6K3Wf1dq5UTi9uVP6/4QPyYzOk2rUWRB27VvBNBt
	C5Nue+m+rcYcKwC/K8fe/Rup2A6xfk14Dd7sh6pusicBq4U
X-Google-Smtp-Source: AGHT+IHFqcjc46tt5p5Lhlf9uzRY1tuMQNyb6bNyGxbn4gvS7/DZ+jqlLUT2HYg74lVgH5XKeJyIhA==
X-Received: by 2002:a05:622a:6f81:b0:467:54b3:2704 with SMTP id d75a77b69052e-46796186096mr12720881cf.16.1733956835614;
        Wed, 11 Dec 2024 14:40:35 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46759b837aasm44386921cf.83.2024.12.11.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:40:35 -0800 (PST)
Date: Wed, 11 Dec 2024 17:40:34 -0500
Message-ID: <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241211_1304/pstg-lib:20241211_1304/pstg-pwork:20241211_1304
From: Paul Moore <paul@paul-moore.com>
To: Takaya Saeki <takayas@chromium.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, selinux@vger.kernel.org, Takaya Saeki <takayas@chromium.org>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
References: <20241210115551.1225204-1-takayas@chromium.org>
In-Reply-To: <20241210115551.1225204-1-takayas@chromium.org>

On Dec 10, 2024 Takaya Saeki <takayas@chromium.org> wrote:
> 
> Currently, genfscon only supports string prefix match to label files.
> Thus, labeling numerous dynamic sysfs entries requires many specific
> path rules. For example, labeling device paths such as
> `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> requires listing all specific PCI paths, which is challenging to
> maintain. While user-space restorecon can handle these paths with
> regular expression rules, but relabeling thousands of paths under sysfs
> after it is mounted is inefficient compared to using genfscon.
> 
> This commit adds wildcard match to support rules efficient but
> expressive enough. This allows users to create fine-grained sysfs rules
> without burden of listing specific paths. When multiple wildcard rules
> match against a path, then the longest rule (determined by the length of
> the rule string) will be applied. If multiple rules of the same length
> match, the first matching rule encountered in the genfscon policy will
> be applied. However, users are encouraged to write longer, more explicit
> path rules to avoid relying on this behavior.
> 
> This change resulted in nice real-world performance improvements. For
> example, boot times on test Android devices were reduced by 15%. This
> improvement is due to the elimination of the "restorecon -R /sys" step
> during boot, which takes more than two seconds in the worst case.
> 
> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> This patch is based on the RFC:
> https://lore.kernel.org/selinux/CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com/T/#t
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 +++
>  security/selinux/ss/policydb.c             | 56 ++++++++++++++++++----
>  security/selinux/ss/services.c             | 13 +++--
>  5 files changed, 66 insertions(+), 11 deletions(-)

I would like to hear from the policy and toolchain folks on this idea
before we go too much further with this, but I did take a quick look
at the patch and left my comments below.

> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
> index 079679fe7254..2b4014a826f0 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -15,6 +15,7 @@ enum {
>  	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>  	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
>  	POLICYDB_CAP_NETLINK_XPERM,
> +	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>  	__POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
> index e080827408c4..17e5c51f3cf4 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
>  	"ioctl_skip_cloexec",
>  	"userspace_initial_context",
>  	"netlink_xperm",
> +	"genfs_wildcard",
>  };
>  /* clang-format on */
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index c7f2731abd03..ccd80fb037d5 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -201,6 +201,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
>  		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
>  }
>  
> +static inline bool selinux_policycap_genfs_seclabel_wildcard(void)
> +{
> +	return READ_ONCE(
> +		selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]);
> +}
> +
>  struct selinux_policy_convert_data;
>  
>  struct selinux_load_state {
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 383f3ae82a73..959e98fae3d5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1090,29 +1090,59 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
>   * binary representation file.
>   */
>  
> -static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> +static int entry_read(char **bufp, gfp_t flags, void *fp, u32 entry_len,
> +		      u32 buf_len)
>  {
>  	int rc;
> -	char *str;
> +	char *buf;
>  
> -	if ((len == 0) || (len == (u32)-1))
> +	if ((buf_len == 0) || (buf_len == (u32)-1) || (buf_len < entry_len))
>  		return -EINVAL;
>  
> -	str = kmalloc(len + 1, flags | __GFP_NOWARN);
> -	if (!str)
> +	buf = kmalloc(buf_len, flags | __GFP_NOWARN);
> +	if (!buf)
>  		return -ENOMEM;
>  
> -	rc = next_entry(str, fp, len);
> +	rc = next_entry(buf, fp, entry_len);
>  	if (rc) {
> -		kfree(str);
> +		kfree(buf);
>  		return rc;
>  	}
>  
> +	*bufp = buf;
> +	return 0;
> +}
> +
> +static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> +{
> +	int rc;
> +	char *str;
> +
> +	rc = entry_read(&str, flags, fp, len, len + 1);
> +	if (rc)
> +		return rc;
> +
>  	str[len] = '\0';
>  	*strp = str;
>  	return 0;
>  }
>  
> +static int str_read_with_padding(char **strp, gfp_t flags, void *fp, u32 len,
> +				 char padding)
> +{
> +	int rc;
> +	char *str;
> +
> +	rc = entry_read(&str, flags, fp, len, len + 2);
> +	if (rc)
> +		return rc;
> +
> +	str[len] = padding;
> +	str[len + 1] = '\0';
> +	*strp = str;
> +	return 0;
> +}
> +
>  static int perm_read(struct policydb *p, struct symtab *s, void *fp)
>  {
>  	char *key = NULL;
> @@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void *fp)
>  			if (!newc)
>  				goto out;
>  
> -			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
> +			if (ebitmap_get_bit(
> +				    &p->policycaps,
> +				    POLICYDB_CAP_GENFS_SECLABEL_WILDCARD))
> +				/* Append a wildcard '*' to make it a wildcard pattern */
> +				rc = str_read_with_padding(&newc->u.name,
> +							   GFP_KERNEL, fp, len,
> +							   '*');
> +			else
> +				/* Prefix pattern */
> +				rc = str_read(&newc->u.name, GFP_KERNEL, fp,
> +					      len);

More on this below, but it isn't immediately clear to me why we need to
have the special handling above, can you help me understand why these
changes are necessary?  I understand you are "marking" the wildcard
entries with a trailing '*', but since we are calling match_wildcard()
in __security_genfs_sid(), why not fully embrace the match_wildcard()
capabilities and allow arbitrary '?' and '*' wildcard matching if
present in the policy's genfscon path entries?  If we do that, we can
drop most (all?) of the str_read() changes and simply check for the new
policy capability when reading the policy, yes?

>  			if (rc)
>  				goto out;
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 971c45d576ba..da4d22220fe8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -48,6 +48,7 @@
>  #include <linux/audit.h>
>  #include <linux/vmalloc.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/parser.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -2861,9 +2862,15 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>  
>  	for (c = genfs->head; c; c = c->next) {
>  		size_t len = strlen(c->u.name);

We don't need to do the strlen() computation in the wildcard case.

> -		if ((!c->v.sclass || sclass == c->v.sclass) &&
> -		    (strncmp(c->u.name, path, len) == 0))
> -			break;
> +		if (selinux_policycap_genfs_seclabel_wildcard()) {

We should pull the policy capability check out of the loop.

> +			if ((!c->v.sclass || sclass == c->v.sclass) &&
> +			    (match_wildcard(c->u.name, path)))
> +				break;
> +		} else {
> +			if ((!c->v.sclass || sclass == c->v.sclass) &&
> +			    (strncmp(c->u.name, path, len)))

Shouldn't this be 'strcmp() == 0'?

Did you test this change both with and without the policy capability
enabled?

> +				break;
> +		}
>  	}

Completely untested, but here is what I'm thinking for the
__security_genfs_sid() changes:

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 971c45d576ba..f9b045b4aa11 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2843,6 +2843,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
        struct genfs *genfs;
        struct ocontext *c;
        int cmp = 0;
+       bool wildcard;
 
        while (path[0] == '/' && path[1] == '/')
                path++;
@@ -2859,11 +2860,18 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
        if (!genfs || cmp)
                return -ENOENT;
 
+       wildcard = selinux_policycap_genfs_seclabel_wildcard();
        for (c = genfs->head; c; c = c->next) {
-               size_t len = strlen(c->u.name);
-               if ((!c->v.sclass || sclass == c->v.sclass) &&
-                   (strncmp(c->u.name, path, len) == 0))
-                       break;
+               if (!c->v.sclass || sclass == c->v.sclass) {
+                       if (wildcard) {
+                               if (match_wildcard(c->u.name, path))
+                                       break;
+                       } else {
+                               if (strncmp(c->u.name, path,
+                                           strlen(c->u.name)) == 0)
+                                       break;
+                       }
+               }
        }
 
        if (!c)

--
paul-moore.com
