Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514715098B
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749992; cv=none; b=nCzT2Wr1cdOOxEmdD3BJ2k7MpGS/zmlnEMHLsJHeFF1Fs57ngoYzJIx7NuqNZmmfgqg6mF+gPfYTAim9Lff0IOoVax37k88qxq6urLgwgU/N6GTn0rKnj7LnqVwPjmLhDQhi5t7DMKsm8pdCG881Pi0WM1YRsvcTLNL8igBvvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749992; c=relaxed/simple;
	bh=4emBIOYEGYuESx2KwkWDKy6rB4hyEHtP9Rn3icpO2Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBHhB7F4Jn3ZaeWy1J3c9RBoNLRuj5EZVdfjCUskeDo2H8jw0i4Cv1VIr/XbrtJL6XeHjHjkOPxafl9Ks7vKn5yBK4Uk/+ftBMfg7G2JIGjdTNMvGeldaNYtbRHtlrhbaTvf0y7slSk676aY8Yu3YlwNsaOU/McQII6is0p1PTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uIm6QIrO; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uIm6QIrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714749982; bh=63pVr66jOd0mgWjT0mqxY3F1MVFZupIuADlXpS28ngo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uIm6QIrOePiHUG1SNN3eBLogsoNL66eBrNWyvjJF3UVsKXm2tRzC8o4lf2eNAG3fVnMFKlJ3gzLDOa2c6IEelnzKOvZMiWBJcomyhDT94Ol9yYROgkTKD2lZyraJJCseLRdtLXs6CncrmovCJwPXCdcHoiAw+v5f14vMyLAiVtWF6ijwX7UovvcRrBFAtqCVWZCvq+WFKVlBkqwCc4pV7reXCqcVrP8SVbexDGLQ2nDCeOPVneTe+r1ZUIwUpBU9hep/KheAQxVQOXznANR2um384SvQTja2pJPflMpUxeO8dsiwEMav4BjZ6+UIqbe6W/+wCFNOpOJGkWQmz6B3YA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714749982; bh=ElgKvFPCPaMW/I2VC9pHBJX6cq1Cj30ygHpbjKYMh0M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IIHTuaYejiGYMf8BJyW+ZgpqbQR0R9RrbfV2erR5Ai2ZFt77BGvPhdugvKMqf/KgdjQoSTfWkIUBs6weMzcteK5s7k+W/QMT1eeEHe2GYylYawr72flkpQTzeXTv7fboX1euvZOAbdnTTHG6eFawOYCTJ1K2JxBryo1iGseU/2hBvfd41N8hgV7Un1cRldQg7cPuSTk5x6eCamGKQsgawZo6joa9+HwVuITNo8sPfAiJTUT9MCcmC9zp3t2rAcxJy2RfWoD2pRQdcRJReqP2Lr5wQ/DqIGnlFxV4OkF4S3GLPdqKh6lhYesP+sE6iqF/Wzb+8Mj216j+sG0SQKcd4Q==
X-YMail-OSG: CKk_wW0VM1mYb5uAdu91IaG063G3OKvZeWI1wAylB7QFHOYgzN7RpcZptkMexqo
 lOY1KH.YTnsYBVFDZdcbmKKIlAQi10b1cQQXjSyYCETaFpZVxr7a0N.NB8qTP9dk87eElNf2HIxe
 QAI8E0W5ALCtsy8.N4SnTo1Q7fX3UdxlqD3qeLQ3qcxl_xtkgaGweH9e6GpTo_KHsxFqr32fNfB9
 FXTvNOgURUupG6k8fTWxjxidjOVD17U5d2VKob3DYMqEiyrAHWGdWTlrgDVc4JO.YeeNhiIz59fl
 V3oeUg6O3mV0GjhbotfI7aUrzA7gF2OEg_K6xqyqrnf7jAgEO8k5kDg4Th8Z93proGPD_Sb5fsi0
 LT1mkGn7SfmqlqrFUekr6M6TKsXs7zUXA4HiFaCXeudhKrpvKI22u_CziHHtuV5sqymZclOCgSGL
 X4ZSrDpTYdeBnWLGNMlZAx46fdqCXxVFEF.mdZFRHQeYuYCOyeVxa5lKvIvGWAi5mVbGgMTUv_tI
 LQLoZ_xVlZC8EVqqiteJbZhoCaQ74l0geaObWQICnK.isDqMQkClRdymbbpRSs2YBBKty9vnndP4
 BRPfTP5eTVwtRZmDGS1FysJZB6DbwUrebVHVvBxnB14FSmkRUDo0xzgCNDUK.bloMIo2AamuxqEy
 kpMRk7wiA6TFTYaU5qWvyw9CdTDyI_a73F2Pq_L5qP_6pBI7xwTW4U5S8Kl6ptyNjrZ9PCH6baVe
 WkzuCdEmFiduZYsAdpEWGoYRBGCtfUQF9rcI3d41rsDnHxod8CoFfq8Rr_ZwJ5TD_raF1dC1k7Qv
 _LvY181.riXF34jahU_bpypLjBJIoO4uQuYleizzi5siNxR4IimmVxXVynfs64AYBnifq00W5qiT
 oeG5zAebEXN5TEMz8dtUmavMaFF.wAJdu7U.Z.tw.J3UdEX1db9gdwXdM.v7NOqXT5BM4XYOw_nu
 y2opkLnUi9Fr5b6JkBjs0DJNJYksXAF1m2yN3mzLg6E8VXluJq_YUdHQo3bvv7FADf5lJgrUhr1X
 EsD5_MfjxBKH4NTIGf4XAx1xGyaeEtm_vSKMQuIfWR4hVKo2xpUYVyy7WQu86Y.TzsTyu086nvd4
 tQVZRfEmo5H7vZQQ.e1px.Er6my0Ad0.cjBsrdf5PPngYYstriu.iQZMTLKs94_aRLUOTOUYYh0X
 LJnwe9bB3Jq.FkRRQBymuw70wEYgzf46XqI3C.A1iw7L03yhm7dfOZF7JBnd8mEMeU85kDIdSJvD
 Dx5.HRpQwUtnc0ne5hyxrgK8yk44QufKJ7uedpKwJlzLSqn3JJtik3df..8CNzJV4TkWeUhkMK53
 ulTUraxTnjP.vx4Y3DQYJ0NgznzvoMRK7VYVpJw0EwAYdIpb_7U7Ds2tO6IbQPWIdvqUFpOyAHhp
 hojl_AZwMc0twY1JKKMjDmP5eyzhJ11l3ZXpd8piPynfgURPRnFs0y1UGI93bwT.ttDVBZs9LccV
 M338ESNw7VvnsA4MzEhT3rTRzAzWGr3TtUFzZmpv133kOszOCYX3f69hUiGrCAMlFQ.Kmef4kbL8
 OB8ZUXRGAoMbff26fotQgcFJ7syORcP1lyWKqw6F1aPRRLzZBoYnUCUxPqKiiJ6_g4GC1zZOwi0W
 04DevVhlDmXk_KktpGi3mhScRUb90QBDro6v9if_8Fu4UI7MVhvG12U765lo1WC6TFTyq1fydEvo
 cFEDAMAaKRpFjm1IRLm1MMyuMQHQ04h4W2ttEhCxXMHBWXPtf8BH1DjdDgzYsoj09DvC5w2Yj2Ty
 UftMEicQiCEdOzHt9yeN9Kx7gqUl9uP3QplG0XIqCYX88PzOM6TU9Zw7k9ATdmE1IkmR8nlRCU8D
 YOXdpkfyvFOnhpPHxxOYetos6NZ6VU.lH0LaIx.bZyOq7BGOcIIuxtxk1hzWHbloXcyLEXZuRQk6
 3HR4OhILxX9Gwr3hVPUK.VL_ooAPnOHhP5KAVV1vH0v4rI80uRZlCxGUdA_o_psu6nhgqyHOi0.p
 _cNUaA9nd1PzTqO5Dc00EbE6M6Zl9wu_ZFfwl2x0h_NuZnieD0kz6b9O0ehzhUvyjrWjGXURIgTk
 81JTlvpJXq6idAxaj1DZc1igPV.TRzX_JCHinJX1KCD8htpC5mIsbsuMfTSJoe5ClvRlctfGSffo
 pn1tuWS8Y2zd7IOrJKiWCqRoaeR9D..uP6K8TfsQbBkph.d2wL5YKGyZNUOCVsWf3cjKIeMweJh9
 TF2iWlZBJ9zlmSCY4_Iqt3K_rmJLLRAF7igWp7fVIpcQQqo85AGx0erXPE4BY.QME.FGbVn62eXA
 wx5Yuvh3O.iB6bggcnA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 40a0d651-b252-48aa-a64f-3101aba34a14
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 15:26:22 +0000
Received: by hermes--production-gq1-59c575df44-zhcxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5e5afd597545c701d1c8d02cf14168ef;
          Fri, 03 May 2024 15:26:17 +0000 (UTC)
Message-ID: <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
Date: Fri, 3 May 2024 08:26:16 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240503005850.466144-2-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240503005850.466144-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/2/2024 5:58 PM, Paul Moore wrote:
> The current security_inode_setxattr() and security_inode_removexattr()
> hooks rely on individual LSMs to either call into the associated
> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
> return a magic value of 1 to indicate that the LSM layer itself should
> perform the capability checks.  Unfortunately, with the default return
> value for these LSM hooks being 0, an individual LSM hook returning a
> 1 will cause the LSM hook processing to exit early, potentially
> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
> of the LSMs which currently register inode xattr hooks should end up
> returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
> executing last there should be no real harm in stopping processing of
> the LSM hooks.  However, the reliance on the individual LSMs to either
> call the capability hooks themselves, or signal the LSM with a return
> value of 1, is fragile and relies on a specific set of LSMs being
> enabled.  This patch is an effort to resolve, or minimize, these
> issues.
>
> Before we discuss the solution,

https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-ca.com/T/#mac61625dc1983d13ee5e8015fd22e1165381f079

... or am I missing something?

>  there are a few observations and
> considerations that we need to take into account:
> * BPF LSM registers an implementation for every LSM hook, and that
>   implementation simply returns the hook's default return value, a
>   0 in this case.  We want to ensure that the default BPF LSM behavior
>   results in the capability checks being called.
> * SELinux and Smack do not expect the traditional capability checks
>   to be applied to the xattrs that they "own".
> * SELinux and Smack are currently written in such a way that the
>   xattr capability checks happen before any additional LSM specific
>   access control checks.  SELinux does apply SELinux specific access
>   controls to all xattrs, even those not "owned" by SELinux.
> * IMA and EVM also register xattr hooks but assume that the LSM layer
>   and specific LSMs have already authorized the basic xattr operation.
>
> In order to ensure we perform the capability based access controls
> before the individual LSM access controls, perform only one capability
> access control check for each operation, and clarify the logic around
> applying the capability controls, we need a mechanism to determine if
> any of the enabled LSMs "own" a particular xattr and want to take
> responsibility for controlling access to that xattr.  The solution in
> this patch is to create a new LSM hook, 'inode_xattr_skipcap', that is
> not exported to the rest of the kernel via a security_XXX() function,
> but is used by the LSM layer to determine if a LSM wants to control
> access to a given xattr and avoid the traditional capability controls.
> Registering an inode_xattr_skipcap hook is optional, if a LSM declines
> to register an implementation, or uses an implementation that simply
> returns the default value (0), there is no effect as the LSM continues
> to enforce the capability based controls (unless another LSM takes
> ownership of the xattr).  If none of the LSMs signal that the
> capability checks should be skipped, the capability check is performed
> and if access is granted the individual LSM xattr access control hooks
> are executed, keeping with the DAC-before-LSM convention.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  security/security.c           | 70 ++++++++++++++++++++++++-----------
>  security/selinux/hooks.c      | 28 ++++++++++----
>  security/smack/smack_lsm.c    | 31 +++++++++++++++-
>  4 files changed, 98 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 334e00efbde4..6e54dae3256b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -144,6 +144,7 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> +LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
>  	 size_t size, int flags)
> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..1f5c68e2a62a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2278,7 +2278,20 @@ int security_inode_getattr(const struct path *path)
>   * @size: size of xattr value
>   * @flags: flags
>   *
> - * Check permission before setting the extended attributes.
> + * This hook performs the desired permission checks before setting the extended
> + * attributes (xattrs) on @dentry.  It is important to note that we have some
> + * additional logic before the main LSM implementation calls to detect if we
> + * need to perform an additional capability check at the LSM layer.
> + *
> + * Normally we enforce a capability check prior to executing the various LSM
> + * hook implementations, but if a LSM wants to avoid this capability check,
> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
> + * xattrs that it wants to avoid the capability check, leaving the LSM fully
> + * responsible for enforcing the access control for the specific xattr.  If all
> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
> + * or return a 0 (the default return value), the capability check is still
> + * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
> + * check is performed.
>   *
>   * Return: Returns 0 if permission is granted.
>   */
> @@ -2286,20 +2299,20 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, const char *name,
>  			    const void *value, size_t size, int flags)
>  {
> -	int ret;
> +	int rc;
>  
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	/*
> -	 * SELinux and Smack integrate the cap call,
> -	 * so assume that all LSMs supplying this call do so.
> -	 */
> -	ret = call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
> -			    flags);
>  
> -	if (ret == 1)
> -		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	return ret;
> +	/* enforce the capability checks at the lsm layer, if needed */
> +	if (!call_int_hook(inode_xattr_skipcap, name)) {
> +		rc = cap_inode_setxattr(dentry, name, value, size, flags);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
> +			     flags);
>  }
>  
>  /**
> @@ -2452,26 +2465,39 @@ int security_inode_listxattr(struct dentry *dentry)
>   * @dentry: file
>   * @name: xattr name
>   *
> - * Check permission before removing the extended attribute identified by @name
> - * for @dentry.
> + * This hook performs the desired permission checks before setting the extended
> + * attributes (xattrs) on @dentry.  It is important to note that we have some
> + * additional logic before the main LSM implementation calls to detect if we
> + * need to perform an additional capability check at the LSM layer.
> + *
> + * Normally we enforce a capability check prior to executing the various LSM
> + * hook implementations, but if a LSM wants to avoid this capability check,
> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
> + * xattrs that it wants to avoid the capability check, leaving the LSM fully
> + * responsible for enforcing the access control for the specific xattr.  If all
> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
> + * or return a 0 (the default return value), the capability check is still
> + * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
> + * check is performed.
>   *
>   * Return: Returns 0 if permission is granted.
>   */
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name)
>  {
> -	int ret;
> +	int rc;
>  
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	/*
> -	 * SELinux and Smack integrate the cap call,
> -	 * so assume that all LSMs supplying this call do so.
> -	 */
> -	ret = call_int_hook(inode_removexattr, idmap, dentry, name);
> -	if (ret == 1)
> -		ret = cap_inode_removexattr(idmap, dentry, name);
> -	return ret;
> +
> +	/* enforce the capability checks at the lsm layer, if needed */
> +	if (!call_int_hook(inode_xattr_skipcap, name)) {
> +		rc = cap_inode_removexattr(idmap, dentry, name);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return call_int_hook(inode_removexattr, idmap, dentry, name);
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3448454c82d0..7be385ebf09b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3181,6 +3181,23 @@ static bool has_cap_mac_admin(bool audit)
>  	return true;
>  }
>  
> +/**
> + * selinux_inode_xattr_skipcap - Skip the xattr capability checks?
> + * @name: name of the xattr
> + *
> + * Returns 1 to indicate that SELinux "owns" the access control rights to xattrs
> + * named @name; the LSM layer should avoid enforcing any traditional
> + * capability based access controls on this xattr.  Returns 0 to indicate that
> + * SELinux does not "own" the access control rights to xattrs named @name and is
> + * deferring to the LSM layer for further access controls, including capability
> + * based controls.
> + */
> +static int selinux_inode_xattr_skipcap(const char *name)
> +{
> +	/* require capability check if not a selinux xattr */
> +	return !strcmp(name, XATTR_NAME_SELINUX);
> +}
> +
>  static int selinux_inode_setxattr(struct mnt_idmap *idmap,
>  				  struct dentry *dentry, const char *name,
>  				  const void *value, size_t size, int flags)
> @@ -3192,15 +3209,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
>  	u32 newsid, sid = current_sid();
>  	int rc = 0;
>  
> -	if (strcmp(name, XATTR_NAME_SELINUX)) {
> -		rc = cap_inode_setxattr(dentry, name, value, size, flags);
> -		if (rc)
> -			return rc;
> -
> -		/* Not an attribute we recognize, so just check the
> -		   ordinary setattr permission. */
> +	/* if not a selinux xattr, only check the ordinary setattr perm */
> +	if (strcmp(name, XATTR_NAME_SELINUX))
>  		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> -	}
>  
>  	if (!selinux_initialized())
>  		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
> @@ -7185,6 +7196,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_permission, selinux_inode_permission),
>  	LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
>  	LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
> +	LSM_HOOK_INIT(inode_xattr_skipcap, selinux_inode_xattr_skipcap),
>  	LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
>  	LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
>  	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..6e37df0465a4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1282,6 +1282,33 @@ static int smack_inode_getattr(const struct path *path)
>  	return rc;
>  }
>  
> +/**
> + * smack_inode_xattr_skipcap - Skip the xattr capability checks?
> + * @name: name of the xattr
> + *
> + * Returns 1 to indicate that Smack "owns" the access control rights to xattrs
> + * named @name; the LSM layer should avoid enforcing any traditional
> + * capability based access controls on this xattr.  Returns 0 to indicate that
> + * Smack does not "own" the access control rights to xattrs named @name and is
> + * deferring to the LSM layer for further access controls, including capability
> + * based controls.
> + */
> +static int smack_inode_xattr_skipcap(const char *name)
> +{
> +	if (strncmp(name, XATTR_SMACK_SUFFIX, strlen(XATTR_SMACK_SUFFIX)))
> +		return 0;
> +
> +	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
> +	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
> +	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0 ||
> +	    strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
> +	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0 ||
> +	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /**
>   * smack_inode_setxattr - Smack check for setting xattrs
>   * @idmap: idmap of the mount
> @@ -1325,8 +1352,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
>  		    size != TRANS_TRUE_SIZE ||
>  		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
>  			rc = -EINVAL;
> -	} else
> -		rc = cap_inode_setxattr(dentry, name, value, size, flags);
> +	}
>  
>  	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
>  		rc = -EPERM;
> @@ -5050,6 +5076,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_permission, smack_inode_permission),
>  	LSM_HOOK_INIT(inode_setattr, smack_inode_setattr),
>  	LSM_HOOK_INIT(inode_getattr, smack_inode_getattr),
> +	LSM_HOOK_INIT(inode_xattr_skipcap, smack_inode_xattr_skipcap),
>  	LSM_HOOK_INIT(inode_setxattr, smack_inode_setxattr),
>  	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
>  	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
