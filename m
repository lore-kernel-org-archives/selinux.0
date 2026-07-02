Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980F33F5B3
	for <selinux@vger.kernel.org>; Thu,  2 Jul 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026561; cv=none; b=oYs5G0V0RLGteVytFoeuC4zBlUIL6Ch5K2FKDWhYqw0+ONsgyZuyu5gadPHYvbBRtLOX0w+OeaHaND5rSsIpTqzxIn6aOYZcRwRuOBZ9LfwT6JmQuSs2D9nQFSuwdk9wR88Hew0Ce3a+o2JHPAAPoxU/GaLRBKQcrPQPKsqA+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026561; c=relaxed/simple;
	bh=ouR8TrKTdaUgj5VUYgwEuvViJWqxd5FXy5BOp8C8MMw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HgC3jVmLmoavw/5iQZowGcIO3gp2lwZrF48+HyatUUU+V1c9PKxkn2fUlRByTY+rOj4XsmVrnBkwH3nP7VyDupqADeKiNqzRzqJw4p7TPF8iBKi6tUpT8HWZ5ZsiGOtY8D1jbjZeH+Dyvdr6yMgacJqmBIVN0zU7CTHOpTOIZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dc8O+x3D; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dc8O+x3D"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5b048375so104615785a.1
        for <selinux@vger.kernel.org>; Thu, 02 Jul 2026 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783026559; x=1783631359; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJB+SnKXg/Iaj9dh+1/QXu3RKn8G8jVD2oOZ/Lpv5FQ=;
        b=Dc8O+x3DIkzMHgcQesFvCraBnNy7hZBLEewz7iHWwQNU2YmOfW6Zvh4R0VWZIE052S
         rkNqVU0vMts3wTOCSSQIOPXfmFERG18FszSRkRkEMNzfqxdIkmtOm4bQv4+ZL1j2GwYI
         prioKCniYJq+5HdTx3rlrCminF20yYfznQwG9174HDzIPQePqYexd94zrNusqoHSUaS8
         Woti7MXxXAfcys3QUprcTSl2NjBcq84U9CIBRtKybgN9emcUmhJVIUVORNzQRVZdcCLz
         fHvFsE0EvcumwVO9ZX1d7WW1vFyB7fD1nBBnz5aRmRDr/bSVr+dlpAAdjAWLotn8sO35
         cNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026559; x=1783631359;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJB+SnKXg/Iaj9dh+1/QXu3RKn8G8jVD2oOZ/Lpv5FQ=;
        b=OZAtUltMqlIyxBiLrzIu0LAtcTszUlPHJv9KcfLx34b5FghoqOk9qovBGjF9xuuqIm
         L+wKtuROnpKhTa05G+0kWVCWXBh1LWdtLVyJSt1AwPMASppi5US9A5KvqRCCB/Qs89mM
         rO2E3F2NekmQ0P0ZlcvtA34Or3oRTPcb47q0BTsxg8zHfkLFT8w5p/2nHIZ4W+heFA7e
         KLCmA0+v48ZBNoO5LkTUcarLox3de0ckXBavQNkFpZrgQlgAOEMhMNKD6NrI4THfph4D
         dFbYhzXpPazjMHk1BNjsxjzP1BzKG3LMDgKCMTgraRLKk0yPQpwsEAixqn7qp6oCyeqU
         UrTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LEEF6CUphU8C37GCVFvMoPJ4oqYURIXQqOn9nkar9B2yI2teo0MrUI/e6gCAjLz6ip4eW5a/o@vger.kernel.org
X-Gm-Message-State: AOJu0YxRawgAst7LPw8j/CDu70zJ+yUpduehYg2zCv9CoaBFGFYCLRn7
	0UG2/iSx2LDgT2BopvRP4H6MQQ4V1G4AkcB71DznB79uWvoc6lUSAtAi4DCr+VQYCw==
X-Gm-Gg: AfdE7cmE/4Z9Tb6OU6fZN5ot0BgVIKo3bbuE8Si/Va3gaCyT4V9pI7T2Hq87iSypTEj
	wg2LyX35mu5KI+rX7XcnUAOJSbs3NVbQWC5ud7/bJ5CcF7XEy2Le760X5+iar5heOSA6hndGE6p
	c6bC2TzXN5467DGa7I8vq36AXSq98wi36XM5wbtoTJdul4GhI1DkXQnDnq/MyOyrkHxDfMqUSRs
	Zc99CwIQ4S50PXI18qTf81VSJ1Q5km2qWyOT4VkWAbqgRrmoYz6nokf9TFnCB3xKaleQgLGAfOy
	A3TyoFrvtn1B9k+b0x/efwxgsgNge7ksXmhdOy1ahfTlxFmfFcRvjBgzutfPzHz6UQ3sDyGUN/K
	CwXPV9N4XJCe9KBBuq9Ig1wGCXoJzgbDoc48iT2YuzSNFVwz4/bzxDhlQ7JkHytdfAVL0B4XSjh
	r/WeWGhju6PytmrJ0cdPhq1M8OAh2eDfAc1yJ67rwmKUMeQq4i8CYP9AQJGw==
X-Received: by 2002:a05:620a:170c:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92e781d6ab1mr1061745885a.13.1783026558741;
        Thu, 02 Jul 2026 14:09:18 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80162034sm315351285a.27.2026.07.02.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:09:17 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:09:16 -0400
Message-ID: <d6f8f888e50c38903c19123673056924@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260702_1708/pstg-lib:20260702_1621/pstg-pwork:20260702_1708
From: Paul Moore <paul@paul-moore.com>
To: Cai Xinchen <caixinchen1@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>, <amir73il@gmail.com>, <brauner@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>, <caixinchen1@huawei.com>, <lujialin4@huawei.com>
Subject: Re: [PATCH 1/2] security: Some cleanup code
References: <20260626011720.1144213-2-caixinchen1@huawei.com>
In-Reply-To: <20260626011720.1144213-2-caixinchen1@huawei.com>

On Jun 25, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> 
> Delete an unnecessary blank line and a blobs variable with
> duplicate assignment.
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/lsm_init.c      | 1 -
>  security/selinux/hooks.c | 1 -
>  2 files changed, 2 deletions(-)

Please split this into two patches: one for the LSM (lsm_init.c) and
one for SELinux (hooks.c).  They are two different subsystems, mailing
lists, etc.

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..d7384866e3a5 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -290,7 +290,6 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  		return;
>  
>  	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
>  	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
>  	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
>  	lsm_blob_size_update(&blobs->lbs_backing_file,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..e5930ebc9e37 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1748,7 +1748,6 @@ static int bpf_fd_pass(const struct file *file, u32 sid);
>  
>  static int __file_has_perm(const struct cred *cred, const struct file *file,
>  			   u32 av, bool bf_user_file)
> -
>  {
>  	struct common_audit_data ad;
>  	struct inode *inode;
> -- 
> 2.34.1

--
paul-moore.com
