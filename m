Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8012321420;
	Thu, 30 Jul 2026 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455603; cv=none; b=BbbYxLU1OE0P2N6LqGVwBFm5m1vvYGiWq3fPhydUULy4lzty04pXU1sXLEuQ8l91hsf8huqpBDAb3rah9fLmU5owdd+HE/ya0WuZHT/wMXyQ9jh8ZaDuaB2e1+aE6oktKa+PU99cu7FuurDxl8DwXmJU40h+/xxdtjWMMUYQkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455603; c=relaxed/simple;
	bh=kfin2RpEaWAy4zoc56m0vF/nq7nhO80LfYOA1gcel2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfY4b4me8dXtyHdYPZHlthMagoS5mcSZt7d5W7ij4SvLXKQezbZOSK2YrEwae+j+n7lOAp67ED+AhCggdxxS7hG8jEQNLY8eUFZJPwWf4zeRuub/SdCexvWyI+WeSLKx4GWw/bzEEWi5O6h+ZkvcdXvnOScCzTPWuW6v4xY22Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnxaROo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnxaROo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA951F000E9;
	Thu, 30 Jul 2026 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455601;
	bh=ZoJzN0FsQ8LMTR13JTZv0Gkd1yHLllK22hfGuN3JtR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERnxaROoZvYWGZmZVDZeYZ+hFU+JZUUbXNVK0UKXH6kBzzBMQEjQMBl85PvJO33oU
	 Z7J0wZAnEvnPS/ww9MR3Y6zBNvRf/4GaqbQDIjKXs5jvJbsU1UTZnlpMlyIFeTBHh/
	 Tk4MuLwwWiJ7l4tii9yEjeZQJ5uuStx+WYT9j1U/gEevaz+JVCNZGmHCln5rnIkWFG
	 wF1QzX/YK8mPqcaRTemFDwjkxo8In3ZSi5/Hul88R9LzucdUE/1Eludxez+cSF8uyn
	 3VD6OeR52P+0vj0FEGwjJ1B7v1pvSoYQUOaaCS9wWcE5nsNFWbFxCY3d0q1jh6gHKH
	 iQ+4H/Wzkpn6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf-next 1/4] security: introduce struct lsm_xattrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260730234533.1912709-2-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-2-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 23:53:20 +0000
Message-Id: <20260730235320.EEA951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Latent buffer overflow: `struct lsm_xattrs` lacks a capacity fie=
ld, and `lsm_get_xattr_slot()` increments `xattr_count` without bounds chec=
king.
--

--- Patch [1]: [PATCH v6 bpf-next 1/4] security: introduce struct lsm_xattr=
s ---
commit 4d965e040bf3aa7aac8ca18905c2c3f09a037f96
Author: David Windsor <dwindsor@gmail.com>

security: introduce struct lsm_xattrs

This patch introduces struct lsm_xattrs to consolidate the LSM xattr array
and its count into a single context object. This preparation allows better
compatibility with the BPF verifier for a planned kfunc that lets BPF LSM
programs atomically label new inodes.

> diff --git a/include/linux/security.h b/include/linux/security.h
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
[ ... ]
> @@ -68,6 +68,11 @@ struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> =20
> +struct lsm_xattrs {
> +	struct xattr *xattrs;
> +	unsigned int xattr_count;
> +};
> +

[Severity: Medium]
Should this struct also track the maximum capacity of the array?

Since this object is being introduced to allow dynamically loaded BPF LSM
programs to label new inodes, a BPF program calling the planned kfunc
multiple times could potentially exceed the allocated capacity. Tracking
the max capacity would allow for bounds checking.

>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
[ ... ]
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
[ ... ]
> -static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> -					       int *xattr_count)
> +static inline struct xattr *lsm_get_xattr_slot(struct lsm_xattrs *ctx)
>  {
> -	if (unlikely(!xattrs))
> +	if (unlikely(!ctx || !ctx->xattrs))
>  		return NULL;
> -	return &xattrs[(*xattr_count)++];
> +	return &ctx->xattrs[ctx->xattr_count++];
>  }

[Severity: Medium]
Does this increment need a bounds check against the array capacity?

If a dynamic BPF LSM program requests more slots than were allocated in
security_inode_init_security() (via blob_sizes.lbs_xattr_count + 1), this
would result in an out-of-bounds write to the array.

This could subsequently lead to memory corruption during the cleanup loop
that calls kfree() on the array elements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730234533.1912=
709-1-dwindsor@gmail.com?part=3D1
