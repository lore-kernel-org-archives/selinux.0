Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5A1A6813
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762727; cv=none; b=d4p3gXbzwsONPp3Mg1YdCTp9Fhd6NM3uTpBp6F7kQ8BPLYGStf8s4gX08haGL9HDGv9eu1DwhG2E2tWwTKHXP0DTiwQBvQxhfb1tnHmzAbAoge3U0dgfca59wvZvDyf+j1YjCiE+lRS8UvKJ2jbu1aWVhIOeBDoRE92fglKAV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762727; c=relaxed/simple;
	bh=i/pWpIpjLu9y7FmZn1edI7Pqu5AmjSt4WMeLell+FOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aj2R1vBskjCUEgvk8E5wRLUmRIwyhcAe4ab7VudQyZRHW7gEfdMwWqggrVqzBGyUbEaL58wg/hl3tUKEZHtGvcXqu3/cpZdjQQVQEur8Ezxi8pi6WbV+y3B24pZxa/R0NuK/QircpEfR92/U6I7CkdG0MQ926iWm+QQpOskXaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOgc721i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOgc721i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778762724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8lgeWDVzZ+0sWqGX2aS5bz7U+x6s4qDUngPYFghfJc=;
	b=HOgc721iq2ENId0B9Rom/L4vO70/9+wZyE+IHcA+cmnTOzad6s/4z5lIDrHKGCkXYlTHtF
	pp51XSf+ub8Xm3qRuTNi1HO4hdSh8A7cwk4jElnh4dkP8MgtDJUr8qnibcQWcOvwyEKJbr
	26yJcHALuZ6ToexCOWDcuQfMZboMGmw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-mJv8vijXM9GpSL2cgMdG2g-1; Thu,
 14 May 2026 08:45:21 -0400
X-MC-Unique: mJv8vijXM9GpSL2cgMdG2g-1
X-Mimecast-MFC-AGG-ID: mJv8vijXM9GpSL2cgMdG2g_1778762720
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C4411956065;
	Thu, 14 May 2026 12:45:20 +0000 (UTC)
Received: from localhost (unknown [10.44.33.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD5941800576;
	Thu, 14 May 2026 12:45:19 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com,
 perfinion@gentoo.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: remount /tmp and /var/tmp with the
 proper flags
In-Reply-To: <20260512200605.753172-1-stephen.smalley.work@gmail.com>
References: <20260512200605.753172-1-stephen.smalley.work@gmail.com>
Date: Thu, 14 May 2026 14:45:18 +0200
Message-ID: <87v7cq6ty9.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> mount(2) with MS_BIND ignores any nosuid/nodev/noexec flags, so
> seunshare_mount() was never setting those on the /tmp and
> /var/tmp mounts. Fix seunshare_mount() to remount them
> with those flags after the bind mount, which does
> set them properly.
>
> Test:
> mkdir tmp
> seunshare -t tmp /bin/bash
> cp /bin/bash /tmp
> /tmp/bash
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/seunshare.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index b9c85bf2..985e0cfb 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -260,26 +260,32 @@ static int verify_shell(const char *shell_name)
>   */
>  static int seunshare_mount(const char *src, const char *dst, struct stat *src_st)
>  {
> -	int flags = 0;
> +	int bind_flags = MS_BIND;
> +	int sec_flags = 0;
>  	int is_tmp = 0;
>  
>  	if (verbose)
>  		printf(_("Mounting %s on %s\n"), src, dst);
>  
>  	if (strcmp("/tmp", dst) == 0) {
> -		flags = flags | MS_NODEV | MS_NOSUID | MS_NOEXEC;
> +		sec_flags = MS_NODEV | MS_NOSUID | MS_NOEXEC;
>  		is_tmp = 1;
>  	}
>  
>  	if (strncmp("/run/user", dst, 9) == 0) {
> -		flags = flags | MS_REC;
> +		bind_flags |= MS_REC;
>  	}
>  
>  	/* mount directory */
> -	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
> +	if (mount(src, dst, NULL, bind_flags, NULL) < 0) {
>  		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
>  		return -1;
>  	}
> +	/* remount with security flags, ignored on original bind mount */
> +	if (sec_flags && mount(NULL, dst, NULL, MS_BIND | MS_REMOUNT | sec_flags, NULL) < 0) {
> +		fprintf(stderr, _("Failed to remount %s: %m\n"), dst);
> +		return -1;
> +	}
>  
>  	/* verify whether we mounted what we expected to mount */
>  	if (verify_directory(dst, src_st, NULL) < 0) return -1;
> @@ -289,10 +295,15 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
>  		if (verbose)
>  			printf(_("Mounting /tmp on /var/tmp\n"));
>  
> -		if (mount("/tmp", "/var/tmp",  NULL, MS_BIND | flags, NULL) < 0) {
> +		if (mount("/tmp", "/var/tmp",  NULL, MS_BIND, NULL) < 0) {
>  			fprintf(stderr, _("Failed to mount /tmp on /var/tmp: %s\n"), strerror(errno));
>  			return -1;
>  		}
> +		/* remount with security flags, ignored on original bind mount */
> +		if (mount(NULL, "/var/tmp", NULL, MS_BIND | MS_REMOUNT | sec_flags, NULL) < 0) {
> +			fprintf(stderr, _("Failed to remount /var/tmp: %m\n"));
> +			return -1;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.54.0

