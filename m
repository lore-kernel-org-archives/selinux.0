Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D7282F1D
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762706; cv=none; b=iamLCmxCLhkWKKPTONt2iTVojozxp2mlrUr6xiUKPsZmurniEsuW3e9vGY7eNvrHBoMy4FG4g6l37M+J/DN3ZSLtwNxy/b1G/Pc9CiMshKhx/ozAtQny7ndhfFgnfsySH/ZKZuxN81pYe3bLPS9mEs0fvXPFNHTRXAjoa0uFxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762706; c=relaxed/simple;
	bh=uGT6RqSxq5kfenA+pUvt1cXMIFqohodJru4D756LcsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXQPvOpONe6oRb0a2iM5Heej3Y89hU79bChe3qTraxMh/Fd6vNY3HllMkqqaRyLrTta98sDNZRGJ45VDfPbnqtAZNjFULidY0+R+Pc6kGU9TJFTdtlTlPWIyYU1BcDJGCk3HCeAMhqB7kf+8sttS5/NjoEqpcXevHrZMuEPTDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdIRt+zq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdIRt+zq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778762703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MfxGeY8pth/GpSrfhicCJgdlu97Qwnx8A8ekek8DiQ=;
	b=hdIRt+zqrl4Kl+neG3RgGePtOFCM9ni6i/g6s/jn+2bSVFJakFeab48PcfpDpc+enxBGdr
	8XZQlSH5niWHUR/1ORK8j1/tDvGh4XBi1RjYd8ZYfp539q7etnbYJwta6HrNzCZgN09QTK
	2ZiGJftYMLQi7fapMu7sDD6FV42fil4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-lLgtQmU-NCC8xuFo87eVcg-1; Thu,
 14 May 2026 08:45:00 -0400
X-MC-Unique: lLgtQmU-NCC8xuFo87eVcg-1
X-Mimecast-MFC-AGG-ID: lLgtQmU-NCC8xuFo87eVcg_1778762698
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE85E195605A;
	Thu, 14 May 2026 12:44:57 +0000 (UTC)
Received: from localhost (unknown [10.44.33.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 008501800264;
	Thu, 14 May 2026 12:44:56 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com,
 perfinion@gentoo.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fix error checking for setfsuid()
In-Reply-To: <20260512193553.752163-1-stephen.smalley.work@gmail.com>
References: <20260512193553.752163-1-stephen.smalley.work@gmail.com>
Date: Thu, 14 May 2026 14:44:55 +0200
Message-ID: <87y0hm6tyw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> setfsuid() doesn't reliably set errno or return anything indicating
> an error.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/seunshare.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 17a727e7..b9c85bf2 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -858,8 +858,8 @@ int main(int argc, char **argv) {
>  	/* Changing fsuid is usually required when user-specified directory is
>  	 * on an NFS mount.  It's also desired to avoid leaking info about
>  	 * existence of the files not accessible to the user. */
> -	if (((uid_t)setfsuid(uid) != 0)   && (errno != 0)) {
> -		fprintf(stderr, _("Error: unable to setfsuid %m\n"));
> +	if ((uid_t)setfsuid(uid) != 0) {
> +		fprintf(stderr, _("Error: unable to setfsuid\n"));
>  
>  		return -1;
>  	}
> -- 
> 2.54.0

