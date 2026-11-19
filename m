Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095752;
	b=ea3qSvyAFYwepomgb6SgX04EKsGgGDflT6xYcy6umJzRtfIHS1aFeQBVFekRSME5q7Ea
	 fYzytYQDHeHzDhcE6vAFcmhTQdInZbHmXPrW6YL4LL2+m+0ty377Q74Z0/+93C9j4HcqD
	 pY7aXZiMYp6xpkGv0fpxzG6T95b01U93Xw4VKvONEnr/UElot3o7q2H01gIhrY53rL2K+
	 lqC+8LijkDOf5GNz7S6bk7lPzIGe6X4efPUxHmmQtt3SAa8UBMZ/WAg9wK06/lVugHOFR
	 V1ruiM79L1iKxmiw5I/fmRWoXAquPFDFtehQac97b08+LicFYPymjX+8hmtOcGVQ80Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095752;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=ZODH7Vg2TOJZ+U7pETCwIgdTbcMundJk34kCW2v0vdU=;
	b=MV0OAVn7+L0fyh0Ob56tW7M2dMfnVOzwiuDeiDZVJMMO4KTDrAdBAssskifNv1Ms+7Rz
	 ligVPyzWWV0m8oOHSZc02XFfrElc05Ir8jQEhVdm4g+u6fLMijWndyvC9LjeXkMOPabM1
	 sr2r7UoYb946fxtta4E7tUzdrouEe5USGNXnW9Qjidk2H1cjLPVCMX2hA+WgAITAyC/cV
	 bsD5yvUmYTlwtP7+6CNzsxAx46AJx7AQwww08GKBQLaOkRW2Ixut5dEtm4keg+yNAUjT0
	 2ZSWUEt6mOhEFLXcg/HPvcTZ0W7cwOA9vK77YdQvONGIEZreIcIZ64atlRVis8rI6ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCUEYItq;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13460A261E
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C13460A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCUEYItq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZODH7Vg2TOJZ+U7pETCwIgdTbcMundJk34kCW2v0vdU=;
	b=HCUEYItqIkx8kJxrE/ZODuiqtU5yp/0XqJt6uWVXAlDwmSR/O7TKbi1mpWraG80b8AqYoH
	DFWiAjiGrDJag+g5Kum9L4ysW6zuHGgJ7WIBHN4CqNAKxUIyxT6WqYfH3AhdpC5U6BkeWe
	YmvnPlPKR9KjT/TbccEPuP/MLddoIvc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-bYaVwIieNtiLcwVUoygWdw-1; Thu,
 19 Nov 2026 08:42:29 -0500
X-MC-Unique: bYaVwIieNtiLcwVUoygWdw-1
X-Mimecast-MFC-AGG-ID: bYaVwIieNtiLcwVUoygWdw_1795095747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40A4B180054E;
	Thu, 19 Nov 2026 13:42:27 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BE6B1956041;
	Thu, 19 Nov 2026 13:42:24 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: prevent path traversal via crafted username
 in getseuser()
In-Reply-To: <20261119130718.783-1-stephen.smalley.work@gmail.com>
References: <20261119130718.783-1-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:42:21 +0100
Message-ID: <pjda4n5vsxu.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> getseuser() builds "<policy_root>/logins/<username>" and reads the
> per-user seuser mapping from that file. The username is whatever NSS
> resolved for the login and is passed straight through by pam_selinux;
> Linux imposes no character-set restriction on NSS names, and directory
> backends (LDAP/AD) can serve names containing "/".
>
> A crafted username can make a root-running PAM stack read a file the
> user controls and take that user's SELinux user and MLS range from it,
> i.e. the confinement decision is delegated to whoever named the account.
> Fall through to the ordinary seusers lookup for such names instead.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libselinux/src/seusers.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index ea542392..df9385eb 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -293,6 +293,14 @@ int getseuser(const char *username, const char *service, char **r_seuser,
>  	char *rec = NULL;
>  	char *path = NULL;
>  	FILE *fp = NULL;
> +
> +	/*
> +	 * Prevent path traversal via crafted username; no valid username
> +	 * should be NULL, start with ".", or contain a '/'.
> +	 */
> +	if (!username || username[0] == '.' || strchr(username, '/'))
> +		goto err;
> +
>  	if (asprintf(&path, "%s/logins/%s", selinux_policy_root(), username) <
>  	    0)
>  		goto err;
> -- 
> 2.47.3

