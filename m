Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E418BC23
	for <selinux@vger.kernel.org>; Wed, 16 Oct 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101216; cv=none; b=gcVU+nNG+zKwMDkiryYdNIpg7um0fY+Xrgxh/H4mDYpkWnhyamwXaT1r2AFPeUrlpaIVA0X/HKl3JnarP3SwZ3We82OdMMEfzrHzS8HhOMvAMQPE2zdN4wna8si7IoFy9hzJw7mRk3W/TxMiCqEZOCCFRFfqwvpeI+4R53NTOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101216; c=relaxed/simple;
	bh=dHrbGdTiJTMkwl3vEfItV7rPKagrR/BIr42Ctl4Lnvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCM97OBk2HKWW/6i3aMFalrAR3KeQ+I8hXd79zJsIHcWkIkg2vywEmSZr/cJLHsAwxZiT2K0WlKfsH/rJJIKseFLh+xoZaE0kK2Sy7wr5jRDwijgmMmsx0t6MwItas/jC9QmezDnbZJUhfxJ7KbsCfE3CfM0M6e2DG6csFVOUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWatFyGy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWatFyGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729101213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dbm4rjFr9MHEkO0csoo1dL7JXFiKu4SuM5wjA9MdZa0=;
	b=iWatFyGycDcVRDNzpwuq+so8oVLbk5RHHLPYFDYWd0dMhF9LNtK5fuwsHTX5plytuNmTEw
	buF9Ft/TmrPD0RHr72i8y/ZUAfMKnDhuvzDcRvN/Smz+wALBkAAItPofA/cjzrQK7WqBNT
	X9h4ydVn7SbIctQrvoZkSZTQm7OJqto=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-rIZSjJPOOZWmk5TXFQLWKQ-1; Wed,
 16 Oct 2024 13:53:29 -0400
X-MC-Unique: rIZSjJPOOZWmk5TXFQLWKQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B9871955F40;
	Wed, 16 Oct 2024 17:53:28 +0000 (UTC)
Received: from localhost (unknown [10.45.225.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 109DD19560A2;
	Wed, 16 Oct 2024 17:53:27 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH] libselinux: formally deprecate security_compute_user()
In-Reply-To: <20241004164605.7607-1-stephen.smalley.work@gmail.com>
References: <20241004164605.7607-1-stephen.smalley.work@gmail.com>
Date: Wed, 16 Oct 2024 19:53:26 +0200
Message-ID: <87v7xskk89.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> It was originally marked for deprecation back in Feb 2020,
> commit a41dfeb55d43 ("libselinux: deprecate security_compute_user(),
> update man pages"), but the attribute was not added at the time.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> ---
>  libselinux/include/selinux/selinux.h | 6 ++++++
>  libselinux/src/compute_user.c        | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 1318a66a..50419a7c 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -263,9 +263,15 @@ extern int security_compute_member_raw(const char * scon,
>   * These interfaces are deprecated.  Use get_ordered_context_list() or
>   * one of its variant interfaces instead.
>   */
> +#ifdef __GNUC__
> +__attribute__ ((deprecated))
> +#endif
>  extern int security_compute_user(const char * scon,
>  				 const char *username,
>  				 char *** con);
> +#ifdef __GNUC__
> +__attribute__ ((deprecated))
> +#endif
>  extern int security_compute_user_raw(const char * scon,
>  				     const char *username,
>  				     char *** con);
> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
> index f55f945a..d4387aed 100644
> --- a/libselinux/src/compute_user.c
> +++ b/libselinux/src/compute_user.c
> @@ -96,7 +96,9 @@ int security_compute_user(const char * scon,
>  	if (selinux_trans_to_raw_context(scon, &rscon))
>  		return -1;
>  
> +	IGNORE_DEPRECATED_DECLARATION_BEGIN
>  	ret = security_compute_user_raw(rscon, user, con);
> +	IGNORE_DEPRECATED_DECLARATION_END
>  
>  	freecon(rscon);
>  	if (!ret) {
> -- 
> 2.40.1

