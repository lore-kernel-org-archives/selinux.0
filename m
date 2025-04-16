Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5851547C0
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832830; cv=none; b=Q7y9P3dHLrwcN67G/FOpXKGyUBSpABahgdT5Lm2u+RwozObj8m6p8hGmr3fXZvEQMp6NSsUJcjfXO4h0S2ZblRmIqNagJiTp6Fg4Rb2Sh0a0LD60HiGflLQcWcM7EdLPFJRSRPKeKPdKyDVvAedkNuUjOrABNFFBR5ZZzGjNEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832830; c=relaxed/simple;
	bh=JPICmnEMGzUMMVLL1gquVHa9NPzKFUbs6F9eqhNHfvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJ7Qu54kDZFzFyyi9YeDLWUtaAPnAuh/8PsUvV3W5Ulfl/5iny8DBOIBaPuEvOZOXbrvhkkQreZlLUgGUBNidzAGkiQRnpAnl1ISNGzGkbqnHAKKNQl/v+pEOAH3NDZHAvODJIK7vHZT1Hq+swJR6Mt/ccyBuXYJ5HNLtQdmZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiwrxKnz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiwrxKnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744832826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WL8yVLY2aK3Ls/v59X93XNO5vx7Q5xweOik5atxFI=;
	b=SiwrxKnzAChi8ho1Y+2WduxTEHkHGqN9ZEThZI+IT5fuqxN7IsEPnAuISHX+rf0Tzix5pD
	jY3AvhsbQX83hLDadS2ObIeTKTy0NwtVjhhCS0kYJPnp40It2aWnUZeODvl/8FCZ9OsSEj
	ai9BA0JwKN61dFAbeQbq30YF7USc660=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-Z72IWLakN1Gq_JmhvmiVrw-1; Wed,
 16 Apr 2025 15:47:03 -0400
X-MC-Unique: Z72IWLakN1Gq_JmhvmiVrw-1
X-Mimecast-MFC-AGG-ID: Z72IWLakN1Gq_JmhvmiVrw_1744832822
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75F29180048E;
	Wed, 16 Apr 2025 19:47:01 +0000 (UTC)
Received: from localhost (unknown [10.45.225.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB6DF180094C;
	Wed, 16 Apr 2025 19:47:00 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Tristan Ross <tristan.ross@midstall.com>, selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: Re: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
In-Reply-To: <20250416045011.29923-2-tristan.ross@midstall.com>
References: <CAJ2a_Df2p03otFfJ7wpGJ_izTw8SGAKr5vztFf0XxnnVypKFnw@mail.gmail.com>
 <20250416045011.29923-2-tristan.ross@midstall.com>
Date: Wed, 16 Apr 2025 21:46:59 +0200
Message-ID: <87bjsvzy6k.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tristan Ross <tristan.ross@midstall.com> writes:

> ---
>  libsemanage/include/semanage/handle.h |  6 +++++-
>  libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
>  libsemanage/src/libsemanage.map       |  4 ++++
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> index a5ea31de..601cd9ee 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -30,7 +30,11 @@
>  struct semanage_handle;
>  typedef struct semanage_handle semanage_handle_t;
>  
> -/* Create and return a semanage handle.
> +/* Create and return a semanage handle with a specific config path.
> +   The handle is initially in the disconnected state. */
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_name);
> +
> +/* Create and return a semanage handle with the default config path.
>     The handle is initially in the disconnected state. */
>  extern semanage_handle_t *semanage_handle_create(void);
>  
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index faea0606..ca57702a 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -59,19 +59,14 @@ const char * semanage_root(void)
>  	return private_semanage_root;
>  }
>  
> -
> -semanage_handle_t *semanage_handle_create(void)
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_name)
>  {
>  	semanage_handle_t *sh = NULL;
> -	char *conf_name = NULL;
>  
>  	/* Allocate handle */
>  	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
>  		goto err;
>  
> -	if ((conf_name = semanage_conf_path()) == NULL)
> -		goto err;
> -
>  	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
>  		goto err;
>  
> @@ -106,13 +101,30 @@ semanage_handle_t *semanage_handle_create(void)
>  	sh->msg_callback = semanage_msg_default_handler;
>  	sh->msg_callback_arg = NULL;
>  
> +	return sh;
> +
> +      err:
> +	semanage_handle_destroy(sh);
> +	return NULL;
> +}
> +
> +semanage_handle_t *semanage_handle_create(void)
> +{
> +	semanage_handle_t *sh = NULL;
> +	char *conf_name = NULL;
> +
> +	if ((conf_name = semanage_conf_path()) == NULL)
> +		goto err;
> +
> +	if ((sh = semanage_handle_create_with_path(conf_name)) == NULL)
> +		goto err;
> +
>  	free(conf_name);
>  
>  	return sh;
>  
>        err:
>  	free(conf_name);
> -	semanage_handle_destroy(sh);
>  	return NULL;
>  }
>  
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index c8214b26..5dab7bf7 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
>      semanage_module_compute_checksum;
>      semanage_set_check_ext_changes;
>  } LIBSEMANAGE_1.1;
> +
> +LIBSEMANAGE_3.5 {
> +    semanage_handle_create_with_path;
> +} LIBSEMANAGE_3.4;
>

It will be part of the next 3.9 release therefore this should be

+LIBSEMANAGE_3.9 {
+    semanage_handle_create_with_path;
+} LIBSEMANAGE_3.4;



 -- 
> 2.47.2

