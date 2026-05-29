Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C183115AF
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061770; cv=none; b=Dsn+GIWFYW2B5DYcV/wXxW2zmvU3iNBdyEsUMwabUiNqJRGFIQgxxJPov6fxqhrfdNw96QbEzYCVOshfvLKM1L2lA0fy7WWb6xz3m06sycEOGyRRbFX2zRWLvbxXNglhb6XnQgwC8BLkG22GjHq/jRQLK5q6FPyJ8gTjflVAyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061770; c=relaxed/simple;
	bh=KHFInUcicta5kd+EcPksQ6IeqM0BZOnF8WSVoJHLG28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4MErmWqI9Gbs7pJYGTjsm8xIA+dcsImdpMYNW4ydsmp3Rrxr6wCWurvn7P8xUYacMm2v38oppgbmTBFJ24fCUIeCOPj51TNonLDKwjlW8J/sKZVCr5YpJcITpDPZAMfKK9CRrZ1gUlRwMDU7CdCWeTCMsYjwEKZgbGMTbbSY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+jY1cAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+jY1cAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780061768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L0mAyBpOzuAryZ6qE6pszGyMSsqqomOJiT/p64FS2I=;
	b=E+jY1cAKOH94Y5cv8TotmGBO7J0eU9O4ackDpnTpNxmatEueZDBKMjvlP0cFhwthQh5RHD
	PfHhknynjHKAq/gQqdg7ckmkdQzoeNt0xd6zuSWFE6zcRz48FWCTTBGU8qSlD/XLi9DLs5
	NH/QXhth6dgVkFrVv7YSIk4e5KHQDdU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-oR5eulQiP3Gm5Xp_i08xxQ-1; Fri,
 29 May 2026 09:36:04 -0400
X-MC-Unique: oR5eulQiP3Gm5Xp_i08xxQ-1
X-Mimecast-MFC-AGG-ID: oR5eulQiP3Gm5Xp_i08xxQ_1780061763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E96A2195410F;
	Fri, 29 May 2026 13:36:02 +0000 (UTC)
Received: from localhost (unknown [10.44.32.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AD1A19560A3;
	Fri, 29 May 2026 13:36:02 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH] libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO
 (bsc#1266385)
In-Reply-To: <20260529125126.159687-4-cahu@suse.de>
References: <20260529125126.159687-4-cahu@suse.de>
Date: Fri, 29 May 2026 15:36:01 +0200
Message-ID: <871peunxry.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Cathy Hu <cahu@suse.de> writes:

> We encountered race conditions where the built order was:
> 1. libsemanage.a
> 2. python-3.13_semanage.so
> 3. libsemanage.so.*
>
> That happened when make was called with `-j2`.
>
> In this case, python-3.13_semanage.so tries to use libsemanage.a and
> - on s390x: succeeds and builds an incorrect python-3.13_semanage.so
>   (that one was found during product testing)
> - on x86: fails (manually reproduced, never encountered IRL)
>   Reproducer:
>   ```
>   cd selinux/libsemanage/src
>   make clean
>   make pywrap
>   find . -wholename "*libsemanage.so*" -delete
>   find . -wholename "*python*.so" -delete
>   make python-3.13_semanage.so
>   -> fails
>   ```
>
> Therefor hard-require LIBSO to be present before SWIGSO and
> probably also SWIGRUBYSO.


Please add Signed-off-by: tag

https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md#contributing-code

> ---
>  libsemanage/src/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index f870dc68..782e4045 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -82,10 +82,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>  	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
>  
> -$(SWIGSO): $(SWIGLOBJ)
> +$(SWIGSO): $(SWIGLOBJ) $(LIBSO)
>  	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
>  
> -$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> +$(SWIGRUBYSO): $(SWIGRUBYLOBJ) $(LIBSO)
>  	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lsemanage $(RUBYLIBS)
>  
>  $(LIBA): $(OBJS)
> -- 
> 2.54.0

