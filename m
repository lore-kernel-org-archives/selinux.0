Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D042222CB
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294646; cv=none; b=ZlIMIToeXdohwnJ3avD3/0tngAw1qjCMcVO0H93fsqH5C4GTPi+m+chAutDwUxP/uRx0DY9gGtHdAPjbRDk6JK31+dR+Rf24wO/uK0jZG/PemfWQKnUMfJPuXbJz59iqA48RRt0FZncTvR6Nw8Cgx0yFb1LYRqanqXo7flRexvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294646; c=relaxed/simple;
	bh=G+htcuKsD01KS14VhohHQnIuNG9lqT/LRNo7nGbHF48=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gG7ge1Zc+Xp4/B/NgzK8jm61BieTOBCXi+YKUhL2Evlhf+B8Wu906Gz+iK1i/LnIQ7/ax61FLZOfZ9EAbt+sZ+EN+iNesie/AH4zSfyDIbJh6UP+ShBcb2i3RQFC61gXHGuieKOuG+BhIniM/1BAOHniLRiEOHonIH1xFfft+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp/Zxs6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp/Zxs6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747294643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtTJWuHA7US4IBcxg5edyOTNeNG7VcNs4mlbDrTuufs=;
	b=Xp/Zxs6foQqr2Rxa40YMp3U1gEBoYCbG0hZWKOvrydoTQVYPtl3RgIQx6Q55aFc7iF5qVy
	JTcX8D70zIN+NYoPK24epTqN3EodajMS0sLIShb8PmfqokVZD5bbWj6Yz+IbqkAdlAmRbm
	HaHcENvgTd99RwRqMINJPV2Ez5JI11c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-l9uN6-YgOPO9X_h4nxpc0w-1; Thu,
 15 May 2025 03:37:21 -0400
X-MC-Unique: l9uN6-YgOPO9X_h4nxpc0w-1
X-Mimecast-MFC-AGG-ID: l9uN6-YgOPO9X_h4nxpc0w_1747294640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 522051800366;
	Thu, 15 May 2025 07:37:20 +0000 (UTC)
Received: from localhost (unknown [10.45.224.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB567180045B;
	Thu, 15 May 2025 07:37:19 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux-list
 <selinux@vger.kernel.org>
Subject: Re: [PATCH] userspace: Make git ignore ctags output file called 'tags'
In-Reply-To: <aCUNtrN_-RGv7PNq@14-5A-FC-31-E8-67>
References: <aCUNtrN_-RGv7PNq@14-5A-FC-31-E8-67>
Date: Thu, 15 May 2025 09:37:17 +0200
Message-ID: <871psq5npu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Kalevi Kolttonen <kalevi@kolttonen.fi> writes:

> From a442c879df2db6aa8ec026af236029c66f8c97bc Mon Sep 17 00:00:00 2001
> From: Kalevi Kolttonen <kalevi@kolttonen.fi>
> Date: Thu, 15 May 2025 00:34:34 +0300
> Subject: [PATCH] Make git ignore ctags output file called 'tags'
>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 6ff61265..30290c41 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,6 +20,7 @@
>  *.pyc
>  *.pyo
>  cscope.*
> +tags
>  .#*
>  \#*
>  .*.swp
> -- 
> 2.49.0


Hello,

please take a look at CONTRIBUTING.md file -
https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md

* Patch descriptions must end with your "Signed-off-by" line. This means your code meets the Developer's certificate of origin, see below.

Also please consider using `git send-email` as prefered way to send
patches.

Petr

