Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DD34F497
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920460; cv=none; b=qTaOKuR6JNIU5AgcXned6eULOFpv7YSCWpw74B9YQyNFRLzjIO5CbmGKe4FjbJhIQnR33/sjxNV8rmcJtfX8WVF8VxtdSAcN27T8Hs+SGRpwtHqXJl3rIIy57OJqEBQQFfWU5HPDhEVbXxjNp/rzb7e0thPAJmOIg9bDknN+ySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920460; c=relaxed/simple;
	bh=Eb2iG6/KzrbuZ5wq2dH+u+I8G1BvQ1+m6nvoPqma+Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnEFOHQKBjvYfuSWuJDjEuGvr8qt9F30kX3Rs6jR7gegGzPeSBX5gMbmQbGVeQeHhbacsEuKM4i4taNSyD1PGKtXmOqO0c19HwhZlq3QKEM4fIZ9LJpLUihI1lmNWjeUx5Nd8ihfhCUig0LQ/AwX+TTkPqwAXGSZSXitTAX+Gxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MR6lBemi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MR6lBemi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782920458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8eXlqkkqLnHzRj+MTs3vXR3aCOyzLRl86fC7WGNGJU4=;
	b=MR6lBemiHLCNs6Es/gkqTwro5HHv6IoEIjuTNu73ppgPWG9xzZYy/HhN5OaTPUYkq8JYUz
	fPt/BucMZG0UgyNHJhOWOROaFArpM9owyf+xs9bQZj+N0rH4zJ/vNHOgr97W0vPzlpAaE9
	+usqHvl0TZXqtgGCivVlRMUh3OCUiUo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-NIUTovvjMFyXj7XF-T5tiA-1; Wed,
 01 Jul 2026 11:40:57 -0400
X-MC-Unique: NIUTovvjMFyXj7XF-T5tiA-1
X-Mimecast-MFC-AGG-ID: NIUTovvjMFyXj7XF-T5tiA_1782920456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4656F188E6C0;
	Wed,  1 Jul 2026 15:40:56 +0000 (UTC)
Received: from localhost (unknown [10.44.33.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD801195E487;
	Wed,  1 Jul 2026 15:40:55 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: selinux_restorecon(): fstat() if
 skip_multilink set
In-Reply-To: <20260628004130.28649-1-stephen.smalley.work@gmail.com>
References: <20260628004130.28649-1-stephen.smalley.work@gmail.com>
Date: Wed, 01 Jul 2026 17:40:54 +0200
Message-ID: <87tsqisoop.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> selinux_restorecon() must call fstat() on every entry if skip_multilink
> is set to fetch the st_nlink value.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libselinux/src/selinux_restorecon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 0159fb7f..b34d8e60 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1271,13 +1271,15 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
>  
>  		/*
>  		 * Skip fstat() when d_type already gives the file type and
> -		 * neither xdev (st_dev) nor add_assoc (st_ino) is needed.
> +		 * none of xdev (st_dev), add_assoc (st_ino), or
> +		 * skip_multilink (st_nlink) are needed.
>  		 * Directories always fstat for cycle detection and walk_push().
>  		 */
>  		mode_t mode_from_dtype = d_type_to_mode(de->d_type);
>  		bool need_fstat =
>  			mode_from_dtype == 0 || S_ISDIR(mode_from_dtype) ||
> -			state->flags.set_xdev || state->flags.add_assoc;
> +			state->flags.set_xdev || state->flags.add_assoc ||
> +			state->flags.skip_multilink;
>  
>  		if (need_fstat) {
>  			if (fstat(fd, ent_sb) < 0) {
> -- 
> 2.54.0

