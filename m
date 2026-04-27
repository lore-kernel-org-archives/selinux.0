Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9D382F0B
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332778; cv=none; b=LhHHkPOsdTt7rjvh8gDuTCmPr4kVSAtX7U5tp635YVEyGlFmWBvqQrQMu21HeLo1+Rq80OG/9+QicraeikH06qf2ma8ygiYrl74b/dnmdvHjWutbHctsatLNZ3NAhm9wdlIfiVl4OVFhd2f2StnkWTofFrVjpbp2YGxkBFb8Ic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332778; c=relaxed/simple;
	bh=26JcQONhsnOoI3eYTKhqy18PwJWdR4v9SHzJaJb9hhI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bzBoSjGJxuJntnjhVjMqFvruIcEyIqroaamFhpS7JMwwKzXioZR6kNBlurPnwStw7RKmXVWkBr9B6o2xgxhKgI8CBBGWgTBrtYH7H3S234i2VKrMJlBZ/Vlomzgl3kwgIvCbgEUG/0Im5uo/a96DDl79ayMLe+lLo487gD5Myco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PGECWZjM; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PGECWZjM"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8eb5ad01402so960691385a.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777332776; x=1777937576; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AacrbQWeONsXwYeqMAMp8ZNpTduvDnpFQOhYm8v5DdI=;
        b=PGECWZjMVMuvoHZEqtbcT9v16+X5abPB6pFB+QMndGI/JN3GIG0J2s6/R/1ir23f9z
         Rnx1dk84bc/GRU4Q6LDApegzMdvstZEW/bjUcUEtIRR9xKaWO5Oj6wGaLauocTTGuoRh
         DWvvYx6P31mcZborlxcUm13iRU2S8aO5AIsYhVSzwuPRPH6UgJdZHCyhYtete7ZojZu1
         cRQf9nnX8HqOJHrnmOt3WNOKO04bAJMQqB0hSJpLTdnhhozP/Z6OSc/nYQhJrHR9c0DS
         eiE3+RXp1ef2jFxL77nf5iM3BdB7F/I+jjbCYV0L3e2quvuVKqnBCU9MsqtnkuqCCd96
         ShjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777332776; x=1777937576;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AacrbQWeONsXwYeqMAMp8ZNpTduvDnpFQOhYm8v5DdI=;
        b=L6AHCwjrT/ZYvNE8TwUpqdEgGOuIthvSoHlg2O/hjFZ30pmDlrPQe+OkjHJqPN0qmy
         4gBGFnvoEa8dkzsMFd5TmOtJrbE9NHODQNV6eqHMGtfi2HcP1lWIqKefN3P8HKhr7QAT
         nFWOWqDb3X7lgvpOd4DUMe71gLYZfS2x4kYBTiq/WN9Uje2H6kNYGje/L175k2EaL2X6
         H670J+gJ1tinev/0BlzHNT0f8bCHoybC8+Z71VEGelzGQQxGqJfXb3wgqbM2WZRMrl5/
         hRLuDZc7kszw9TpbWZEHGW26gQKqu6++/Jk8DPGNA6FdlvhPjTx6mbET1Z7vkQWpUiM7
         47+g==
X-Forwarded-Encrypted: i=1; AFNElJ/h7rGNmx4pfOZZy0ZfGROkBZbYu3t68ArRojqiHnGaXD8XXOHnqRxP7/7Lud/u6nsfCCmF4m6p@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpOS1cW4A7Asu8/DiozUSpJNiJYmFhcKDm0WGWCMqfQtF/uA6
	p7FI45Ecwfc3M3zww7Tv6wNgspPYBjO5HcSE8yzW0Qk1VVEHgygRfYkDRhNAioGMhg==
X-Gm-Gg: AeBDieu/NDnkSOmnK9/P2JCqPs5D74FFzcr7Dn4bGx+UZXC6KyaXA8Dx/KfYgzXfoo+
	Dc+Q9jhugWMd5my9eMYvpvcpSF6piH8HonUi2TIqk70Lk2nrp5zOBqb9xORWi/1apd8tWT+0YGu
	BTgUM1+kpZq+2DIP4CnBhGa7Ba9fCCo8RHv3QnXyJApVZrVdpUfh1Pj4Ook7uGeszCEC5IjJUm0
	u58h9ykcgUxEr5OLpmXUL1Cq8Ze6vC2SlEZw2xKjuDWLnAmlBP4bp+/HzhU2KJm4WOvUt2A7sSR
	ulkNeuyyxJtoBe9VyvAhFhI4G3wTLvPqGR/dIGbO4SX7y3eHc2MKV8vOUt8pS9Qw/tYt9CILrav
	dFVepONzg7hQtnBpnhBRDe6ltXqJJVuo3cHuRfKlynOtQOC8NeFGo5GxrUI4ExTStKPgPxyh1o2
	gnqTfxk7AGolUuUr+RxgnlCtbCcdTiO30ACM5dYjwKQOufi5/Ia+DYdk9qSnomY7mYoecAaWQ1y
	ulAosI=
X-Received: by 2002:a05:620a:7111:b0:8ce:5a30:9523 with SMTP id af79cd13be357-8f7d6f3dd9bmr106905485a.4.1777332776436;
        Mon, 27 Apr 2026 16:32:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c49c4953sm52474885a.3.2026.04.27.16.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:32:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:32:55 -0400
Message-ID: <0a65e27845468d7b0b57810086a563d3@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260427_1759/pstg-lib:20260427_ 820/pstg-pwork:20260427_1759
From: Paul Moore <paul@paul-moore.com>
To: David Windsor <dwindsor@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: don't reserve xattr slot when we won't fill it
References: <20260426232349.844289-1-dwindsor@gmail.com>
In-Reply-To: <20260426232349.844289-1-dwindsor@gmail.com>

On Apr 26, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> Move lsm_get_xattr_slot() below the SBLABEL_MNT check so we don't leave
> a NULL-named slot in the array when returning -EOPNOTSUPP; filesystem
> initxattrs() callbacks stop iterating at the first NULL ->name, silently
> dropping xattrs installed by later LSMs.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Good catch, thanks.  These seems like a stable candidate so I've merged
it into selinux/stable-7.1 and we likely send it up to Linus later this
week.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..4ff118a9395f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2966,7 +2966,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  {
>  	const struct cred_security_struct *crsec = selinux_cred(current_cred());
>  	struct superblock_security_struct *sbsec;
> -	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> +	struct xattr *xattr;
>  	u32 newsid, clen;
>  	u16 newsclass;
>  	int rc;
> @@ -2992,6 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	    !(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> +	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>  	if (xattr) {
>  		rc = security_sid_to_context_force(newsid,
>  						   &context, &clen);
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0

--
paul-moore.com
