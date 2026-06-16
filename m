Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681F29E117
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617040; cv=none; b=RsAQRcWmpbUZEz4eXAn7ta8V37LQMMndRKI3qfWX8mTx0TIQ55tCIoqEv/R4vAQWoNdqf1nvkjkMVmnRjgVAVUPM0wQY/d/u2bLiIq4zkBQy1i9TEfYcglR/5yED9ij/UOehopfDO4IpvVd1xC34BJlEgmcHQFmaT6heaySYxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617040; c=relaxed/simple;
	bh=Y23hBBEprjuM0wrOGzYk8zuku1Baho3m/lLyR05zI9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REDSECEcZrVFsH5HkCnnyA6jfeoCAfDE5ifCD05mHQzPeMfiyyo2XhvvrL+wx9yiuTAu4MhmPEBT4VZY5WivbZfuQwpuhUquQOaiqbtplDUDvEUm7X2tr4WIoOCt4pYu2FMVtgcNk2baqnMZDje75v01VPTm+HR+KejDrPpsS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeRRtz1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeRRtz1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVXevxsZEk2/WgMJUpDMN8eGLfOsgMS5lja2s82mXm8=;
	b=SeRRtz1R2g3NWMnpiWZmMq3r+wkLNV7OTsqbBhSVXONG9cg90aLDBSJZ6tE2D4G92FlLSy
	LVwMmOTVHHGHX+6b9GeBGyeoeyQPDy7jbHRhnrPmol+jBm2WqaFSekrPyY/4IZZpGJhsoF
	VeVpNXg45nSL/k5BQxcwpU+6Pf/kh7w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-4MGC7LdvMOqIzMg164cmMg-1; Tue,
 16 Jun 2026 09:37:14 -0400
X-MC-Unique: 4MGC7LdvMOqIzMg164cmMg-1
X-Mimecast-MFC-AGG-ID: 4MGC7LdvMOqIzMg164cmMg_1781617033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E58E619560A3;
	Tue, 16 Jun 2026 13:37:12 +0000 (UTC)
Received: from localhost (unknown [10.44.32.87])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36D401954B04;
	Tue, 16 Jun 2026 13:37:11 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Pepper Gray <hello@peppergray.xyz>
Subject: Re: [PATCH] libselinux: Add EXTRA_LD_SONAME_FLAGS for musl+llvm builds
In-Reply-To: <20260615172736.45712-1-stephen.smalley.work@gmail.com>
References: <20260615172736.45712-1-stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:37:10 +0200
Message-ID: <87y0geli7t.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> Introduce an optionally defined EXTRA_LD_SONAME_FLAGS variable for use
> by musl+llvm builds to pass --undefined-version. This enables such
> builds to link despite the intentionally omitted
> matchpathcon_filespec_add64 symbol.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/512
> Fixes: https://github.com/SELinuxProject/selinux/pull/513
> Link: https://lore.kernel.org/selinux/871pe7n3w3.fsf@redhat.com/
> Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> Reported-by: Pepper Gray <hello@peppergray.xyz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md               | 4 ++++
>  libselinux/src/Makefile | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 5e65a049..a458a930 100644
> --- a/README.md
> +++ b/README.md
> @@ -151,6 +151,10 @@ set when overriding are:
>  - -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
>     will support passing this flag, but ignore it. Previous clang versions fail.
>  
> +## Setting EXTRA_LD_SONAME_FLAGS
> +
> +Build with EXTRA_LD_SONAME_FLAGS=--undefined-version to fix
> +linking against musl with llvm.
>  
>  macOS
>  -----
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 9982faad..fe8d3239 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -91,7 +91,9 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>  
>  override CFLAGS += $(LFS_CFLAGS)
>  
> -LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
> +# Use make EXTRA_LD_SONAME_FLAGS=--undefined-version to fix
> +# linking against musl with llvm.
> +LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro$(EXTRA_LD_SONAME_FLAGS)

I guess there would be missing ',' before --undefined-version

something like this could fix it:

+LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro$(EXTRA_LD_SONAME_FLAGS:%=,%)


>  ifeq ($(OS), Darwin)
>  override CFLAGS += -I/opt/local/include
> -- 
> 2.54.0

