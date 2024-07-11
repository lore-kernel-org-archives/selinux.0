Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327B19FA7C
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732785; cv=none; b=leoGslZDUkIR0r+ZORX3Uk7wvKuK9qzPUtUzYVsfmXtQIbGgEINTHyqO+zE7pBVPfINFYV1OadAZD0NvrJkLBd/J4Skhzk55KNawy8PV8Xy2jV3C9RAACRKDCVx8Y+T5k7dXUqvcSSU2I1moDk/0Edt7aMCRSEeiOj+QQdOvBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732785; c=relaxed/simple;
	bh=j3gNrgu6xBBy3KKP93J3A9FXJ/8bZGTELK0SmR+gUfI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=kxFhLgJhqIn0S3txGHeqiuTHb/RE75arGRV/T57jaseci3Hw0RZWZbsmaDu041o9CfUMd1Aox/R6AN2/sGsOZ8LCzKDiyknQTySLRgI6aPdKGXd59Du15JDGgJ92HhQHxPnks3tHk7v/oAOEkuVARyFLodVPLC2twh1yIGLGbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QGiSUKlz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QGiSUKlz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447e02f3ac9so6484481cf.0
        for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720732783; x=1721337583; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vCqSWsJHJBnSwqmY/B+RX1X7j4C1yhT+DAFUrqYoUU8=;
        b=QGiSUKlziWioGDhuq3PSHJNZ0tTe6RWRcKUyginIrnlMhj1WMLNopAfx0rCCpoP90f
         snBb66+Za4Lq3CMjsV/GQSrHkoYoHGwc7GRopkvYk6ZuOEG1xdoKRRPr8we/Tfy+F+K0
         pSoviu63AgxiaECWl9WjJEpJVRZZBbIZnBpB9lV1pp6lliEkVy5iEo6u8RXGiK8Suglo
         JEt3qFn2NMcLQlVJeDd3Q+XjyGnLSFsjD6NT9mPvl0cLwB7aTNOZStA6nuVV3m+M7O3a
         f0/7byfkOJV/WbngPIdTCRMQa80to8feISt869ytms1RfdxpdwfIYfin399P5SaKrW0W
         uJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732783; x=1721337583;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCqSWsJHJBnSwqmY/B+RX1X7j4C1yhT+DAFUrqYoUU8=;
        b=uetVq/fdgaYBakxTLtdwU8aSOqysCHpbDsEdVsMbo/51XpJrkRzFW/J9cWmz5XsswG
         9MMcadahrswfDt+qlb0DTg+T3o94GC8HbZmokLy8NOUI9Hy1hfIHOgXHCEM2uG3Uv21E
         BOAg+IqaYkU+Z3Pp9IVvlrM0aOWMv4keK+dPJzCdFt9WO9sOaBXULTCRvA33hRMz/I6H
         mjckzAvVq2KH6MuBJWtivvH5LlvWHYjuvUfIodJs41K7duJvSL1p8K4mH8+22eXwnfe0
         VeTcEQyS5xNJBvikZiCWXErV7CDvpKWfPrrWQkfUY2UqFBKMF62UBTcv/mu7BMbzwfTq
         dSrQ==
X-Gm-Message-State: AOJu0Yy0WsxWkQBnmSYrQofqmoOzl/xliTEt8csKLLvvh2bp6vCfzz6k
	n5WJ8b4+voByoVy1HUCXnKJy8MsYrY8THpSZNtasHTegG3+rKZ5+HEgzjP3YvA==
X-Google-Smtp-Source: AGHT+IGhFBlQWfDIS3TyhGQMYhojs3i43wRqefTpT6SCah0k4j1jVgovjTBb8O6B7syxZ74wkQ6WNQ==
X-Received: by 2002:a05:622a:3cc:b0:446:3677:96a with SMTP id d75a77b69052e-447fa8852c7mr97594561cf.31.1720732783098;
        Thu, 11 Jul 2024 14:19:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d2d6sm34117691cf.22.2024.07.11.14.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:19:42 -0700 (PDT)
Date: Thu, 11 Jul 2024 17:19:42 -0400
Message-ID: <4307eaa682df719d7d5d4c61f4a996aa@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>, <cuigaosheng1@huawei.com>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH] selinux: refactor code to return the correct errno
References: <20240711025852.916781-1-cuigaosheng1@huawei.com>
In-Reply-To: <20240711025852.916781-1-cuigaosheng1@huawei.com>

On Jul 10, 2024 Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> 
> Refactor the code in sel_netif_sid_slow to get the correct errno
> when an error occurs.
> 
> Add some similar modifications to selinux_netlbl_sock_genattr and
> sel_netport_sid_slow.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/selinux/netif.c    | 16 ++++++++++------
>  security/selinux/netlabel.c | 16 ++++++++--------
>  security/selinux/netport.c  | 12 +++++++-----
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index 43a0d3594b72..6d8544d8c63c 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -156,14 +156,18 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>  	ret = security_netif_sid(dev->name, sid);
>  	if (ret != 0)
>  		goto out;
> +
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
> -	if (new) {
> -		new->nsec.ns = ns;
> -		new->nsec.ifindex = ifindex;
> -		new->nsec.sid = *sid;
> -		if (sel_netif_insert(new))
> -			kfree(new);
> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto out;
>  	}
> +	new->nsec.ns = ns;
> +	new->nsec.ifindex = ifindex;
> +	new->nsec.sid = *sid;
> +	ret = sel_netif_insert(new);
> +	if (ret)
> +		kfree(new);

The case where we fail add the new netif to the cache should not return
an error as we were able to successfully lookup the SELinux SID for the
netif and return it to the caller.  Yes, we were not able to add it to
the cache, but that doesn't mean we should fail the operation by
returning an error code.

>  out:
>  	spin_unlock_bh(&sel_netif_lock);
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 55885634e880..40b5dcbd97d4 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -76,11 +76,12 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>  
>  	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
>  	if (secattr == NULL)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
> +
>  	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
>  	if (rc != 0) {
>  		netlbl_secattr_free(secattr);
> -		return NULL;
> +		return ERR_PTR(rc);
>  	}
>  	sksec->nlbl_secattr = secattr;

You need to update the function's comment header to indicate that it
returns error codes encoded with ERR_PTR() on failure.

> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 2e22ad9c2bd0..a75a479515fb 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -152,12 +152,14 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  	if (ret != 0)
>  		goto out;
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
> -	if (new) {
> -		new->psec.port = pnum;
> -		new->psec.protocol = protocol;
> -		new->psec.sid = *sid;
> -		sel_netport_insert(new);
> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto out;
>  	}
> +	new->psec.port = pnum;
> +	new->psec.protocol = protocol;
> +	new->psec.sid = *sid;
> +	sel_netport_insert(new);

Same logic as sel_netif_sid_slow().

--
paul-moore.com
