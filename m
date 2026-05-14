Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA13C0A15
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762673; cv=none; b=CDoV19eGnuH8+IczeHV1oZGSUHYRTIweMIsNe1/1Mr8V5jgFI0iJT2De+vJZ35BKAWmrqRT7gDnQLs0t1XrSJiPJ0hAS6yYADc8794ugELXWXK7dy0CogI8o2PQod2fVAb9uuL7fm83yOrz9E9QaFn28TlMdMrCtgaSH1sb5Zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762673; c=relaxed/simple;
	bh=CatE1RLjHrSqsFGzxoI9sDcenX7g/w18gptb4pveDvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hQNRVSey5FswwIIV+a74nIw53alT58KosMaLYg7rYO9RBJ4iXgjtBvPHFpdAnUdDcuq2y+SASbrNjQlPf+Pvso1NnO9Zel/F84PeRC2Ia5Pi+HQDsLzH7QHa/BqxChPOp8g21q9kbJKy1ZaJosMsE323xRFERnlsmVfONaTEW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3N1O35O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3N1O35O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778762671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACJ+hNTqzLLlaUJtNA+UCGKzd8GCXbrdQYAqSGBqyzY=;
	b=Q3N1O35OU1kXDUZSTSkY8D14T5yG5kpda5LAoWBEa5v79cGSvx339tcpyBCbPx223t+tPr
	mnC+6YYZUcPs8T4pXBay7RPf9+c8wWsAwIznpN/di+VRV7zbQ2fLOVLm6FLgm3joYJVGfW
	sSLI6URb8uNVw96Yd8be+K4QzI2E7pc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-Pe2CsdeXO4O4tT5NE8ebyw-1; Thu,
 14 May 2026 08:44:28 -0400
X-MC-Unique: Pe2CsdeXO4O4tT5NE8ebyw-1
X-Mimecast-MFC-AGG-ID: Pe2CsdeXO4O4tT5NE8ebyw_1778762667
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0110518002DC;
	Thu, 14 May 2026 12:44:27 +0000 (UTC)
Received: from localhost (unknown [10.44.33.168])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 339C130001A2;
	Thu, 14 May 2026 12:44:25 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com,
 perfinion@gentoo.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: switch seunshare_mount_file() to use
 open()
In-Reply-To: <20260512192631.751908-1-stephen.smalley.work@gmail.com>
References: <20260512192631.751908-1-stephen.smalley.work@gmail.com>
Date: Thu, 14 May 2026 14:44:25 +0200
Message-ID: <871pfe88k6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> seunshare_mount_file() currently uses fopen() to create the dst
> if it doesn't already exist. Switch to using open() with
> explicitly specified flags including O_NOFOLLOW and an explicitly
> specified mode for the new file.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/seunshare.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index a1900eaa..17a727e7 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -304,18 +304,20 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
>   */
>  static int seunshare_mount_file(const char *src, const char *dst)
>  {
> -	int flags = 0;
> -
>  	if (verbose)
>  		printf(_("Mounting %s on %s\n"), src, dst);
>  
>  	if (access(dst, F_OK) == -1) {
> -		 FILE *fptr;
> -         fptr = fopen(dst, "w");
> -		 fclose(fptr);
> +		int fd = open(dst, O_WRONLY | O_CREAT | O_NOFOLLOW | O_CLOEXEC, 0600);
> +		if (fd < 0) {
> +			fprintf(stderr, _("Failed to create mount point %s: %m\n"), dst);
> +			return -1;
> +		}
> +		close(fd);
>  	}
> +
>  	/* mount file */
> -	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
> +	if (mount(src, dst, NULL, MS_BIND, NULL) < 0) {
>  		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
>  		return -1;
>  	}
> -- 
> 2.54.0

