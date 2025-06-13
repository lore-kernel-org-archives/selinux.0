Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE42E11A5;
	Fri, 13 Jun 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824091; cv=none; b=EX9688C3jMop1q9od45ls1amiMLc4Psvi5mbvXnbFqZ+y/KYtOvx/Huag/zSnsMwlHlXp8cexT6F7m5ecOyNpuMVYtp9Yv0a8Rz9ZU4c9loVPfCsdMuYgkg+ZUbnXPzhRtpmd/nNBU84esuqprIyzpTI6m+pof1Cz/pUx67m4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824091; c=relaxed/simple;
	bh=SQC6l8juYuyTcXEXMU0Sulm1SxoD5s3wGXltdA/8dPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7Ip9bOzJLWjqbl+dAAcRHIgC7ASVPyKWTKaxICft+Ynj8ythk3NZk1ZjXPpMCgidppeeo3c6g33grileYXYXmYtaQ8kPwTN1yalivTXAY2RZL/vJkZ1aWYfjO9RfmmEhkYRtoiSNBL85Fk/ekhGBseFmh4o0qeYxJqlem/i+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCYxfM+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCYxfM+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D31C4CEE3;
	Fri, 13 Jun 2025 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749824090;
	bh=SQC6l8juYuyTcXEXMU0Sulm1SxoD5s3wGXltdA/8dPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCYxfM+C6xPeCd+2maLKWqgqtqHJnpC1A9T0XdCGcue5xUNLO13gpd8HCDjTmpz81
	 ULfvyr97J612RwPRjtqq5kCfmOcZ/yWq7igKbcNVttNPCOD4/WkVSEAFWpCoqXuNGd
	 R9p1FnCtvFkd9Gszqs0izW9CxSn0Ps4EY08ZWaGJuTgzxPhAZ5OidNwFIsos3ncCqt
	 k5yGq6I3/HHOzh5onqhfS/JxzDRQicrOpsNKZwNmVJmfcdRC6rp7upkMxMrW8LgxDm
	 QR3PHJ6xw6GzVpAtVOyqgYKHW3gRo2Tw6ZPV8uU3Kr274czIv0OyQuJYiLBhOQa5zg
	 G5hVPhLrAHSDA==
Date: Fri, 13 Jun 2025 15:14:47 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 04/42] selinux: dynamically allocate selinux namespace
Message-ID: <20250613141447.GF414686@horms.kernel.org>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-5-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610172226.1470741-5-stephen.smalley.work@gmail.com>

On Tue, Jun 10, 2025 at 01:21:35PM -0400, Stephen Smalley wrote:
> Move from static allocation of a single selinux namespace to
> dynamic allocation.  Include necessary support for lifecycle management
> of the selinux namespace, modeled after the user namespace support.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 112edf9b2106..c67965cbfcba 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2202,7 +2202,7 @@ static void security_load_policycaps(struct selinux_state *state,
>  static int security_preserve_bools(struct selinux_policy *oldpolicy,
>  				struct selinux_policy *newpolicy);
>  
> -static void selinux_policy_free(struct selinux_policy *policy)
> +void selinux_policy_free(struct selinux_policy __rcu *policy)

Hi Stephen,

It looks like this __rcu annotation is insufficient, and further updates
are needed. I didn't look further, but Sparse says:

  .../services.c:2212:27: warning: incorrect type in argument 1 (different address spaces)
  .../services.c:2212:27:    expected struct policydb *p
  .../services.c:2212:27:    got struct policydb [noderef] __rcu *
  .../services.c:2214:15: warning: incorrect type in argument 1 (different address spaces)
  .../services.c:2214:15:    expected void const *objp
  .../services.c:2214:15:    got struct selinux_policy [noderef] __rcu *policy
  .../services.c:2232:39: warning: incorrect type in argument 1 (different address spaces)
  .../services.c:2232:39:    expected struct selinux_policy [noderef] __rcu *policy
  .../services.c:2232:39:    got struct selinux_policy *policy
  .../services.c:2297:29: warning: incorrect type in argument 1 (different address spaces)
  .../services.c:2297:29:    expected struct selinux_policy [noderef] __rcu *policy
  .../services.c:2297:29:    got struct selinux_policy *[assigned] oldpolicy
  .../services.c:2210:24: warning: dereference of noderef expression
  .../services.c:2211:15: warning: dereference of noderef expression
  .../services.c:2213:15: warning: dereference of noderef expression



>  {
>  	if (!policy)
>  		return;

...
