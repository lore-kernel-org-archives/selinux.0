Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE822D794
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748247; cv=none; b=Z1+az2quEtFB6qzSPVGF7HJfo2xaqE4HxIV56ilgd29Vi3mCxbGcTfDyV/yd4ZhaGeEJy3wqIl8fUI9mRdIa2DnvBSP9Q1L1a57tAkt4D+KwxCYZ4TruGmPrkBUle5dQeKqTByjG0u1iXC2tHHIqfv/cDGian04R/hkNArZNbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748247; c=relaxed/simple;
	bh=teTHsod4910ezafI2RGYQkyyjTyfP076sfHXdAI2Psg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/w0JC8xsw+eiiqmh4lOJC4r8wgXJgL6g470/JWpG/ksBs3HG267kocQAV5eI/R9eFZG+OeA3hhOHgbB+AI88jodDBT9BgGEvOMR97AK5adJvUgUtsO7DMY2kFd5nrYKMrlHLZLnTxG8TF4cMni9DpvcdbaBMfcMi/Gk1bFww+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHSxHYHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHSxHYHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uHLLErO0Dhbhff0DpoF+/T64So28jWV5FofRxchgSQ=;
	b=KHSxHYHIMUVQzVl0/XHczs2aeW8e7NE3aN6OUXYQsCdAOUSNb6ZONHsajS7j0GG1sEnezy
	IEfPKgaaNr1/GrRnqufVdeZx0axWHrO3/0b49UlDfzogv5xotNRbCK9WAkFMlT//Lgpw20
	/h8Uo3AUpdeAWs/Ib0xfj19II3aEOYM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-nOHDwAnZMuODPrEBTmDc4w-1; Tue,
 20 May 2025 09:37:23 -0400
X-MC-Unique: nOHDwAnZMuODPrEBTmDc4w-1
X-Mimecast-MFC-AGG-ID: nOHDwAnZMuODPrEBTmDc4w_1747748242
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39BD419560A1;
	Tue, 20 May 2025 13:37:22 +0000 (UTC)
Received: from localhost (unknown [10.44.32.76])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EFF41955F35;
	Tue, 20 May 2025 13:37:20 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH] userspace: Make git ignore files '.vimrc' and 'tags'
In-Reply-To: <20250515091833.14378-1-kalevi@kolttonen.fi>
References: <20250515091833.14378-1-kalevi@kolttonen.fi>
Date: Tue, 20 May 2025 15:37:19 +0200
Message-ID: <878qmrcsj4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Kalevi Kolttonen <kalevi@kolttonen.fi> writes:

> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 6ff61265..34aa2b48 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,6 +20,8 @@
>  *.pyc
>  *.pyo
>  cscope.*
> +tags

makes sense

> +.vimrc

according to https://vimhelp.org/starting.txt.html#vimrc the current
directory is searched only if the 'exrc' option is on and based on
https://vimhelp.org/options.txt.html#%27exrc%27 this is not something
one should do

so I'd rather not to hide it for all. you can use your own
~/.config/git/ignore, see gitignore(5) man page





>  .#*
>  \#*
>  .*.swp
> -- 
> 2.49.0

