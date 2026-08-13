Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362444838B
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615399; cv=none; b=rlNPAN2sJLcTplmE7qzgcjyAejirjVU4xUkPWJqVe2p94T0XfNGFxPI8hsRctHzPjobFOOgqBWj/VLjgN/X0T2yzhiLUHLX5M1Vgo/B3F+I8VGj7NFTc+E/UyIbQpt1/yI//W54vYVoQOQZz6z/FS4wfqh2yoQHwEddG3D2+ZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615399; c=relaxed/simple;
	bh=GlEbO6KYBvaxZe3195AccWuJzW7VCRMEe5i2OzmCZ/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfL4cr/CDFy6WHraCTMxwBQefD80DemIeGMW2gO4tHBDxpDwSU85PTJHBfwRopWsvqQgrr2T1MdWSxsQUyG1/fx7JBweqnkIUNFbFWzoUfJEBhAUeFYvdbwsAZjV3iXcc8YNZfVPd3AQOou46HSNgz8JCUL8eZRmajyvsF8q9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Obos0KOI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Obos0KOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786615393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDv7IS8tpFjCKhlmIXqf8IJ/gq/O0GEtNCCayfyG7ag=;
	b=Obos0KOIkD0yXsLeq9G6ZrrobLZQPF3OM/2Z01fghTrYGp4Qf7YzbsObB61mQD/x5Q+p+a
	kOXuSxMIYArCk3kaw7GgNx+xZAx3uMQkbp9xTS48CALzUvnZDFt+cHNu++/zyWuLiVYXq/
	of2JxXCYkivrsXo3IWXPHH1G4gqfs78=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-Z4TUnLJfNIiMl7R4iyojfQ-1; Thu,
 13 Aug 2026 06:03:04 -0400
X-MC-Unique: Z4TUnLJfNIiMl7R4iyojfQ-1
X-Mimecast-MFC-AGG-ID: Z4TUnLJfNIiMl7R4iyojfQ_1786615383
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D646D195608B;
	Thu, 13 Aug 2026 10:03:03 +0000 (UTC)
Received: from localhost (unknown [10.44.32.191])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7D1B30001A2;
	Thu, 13 Aug 2026 10:03:02 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, jason@perfinion.com, Stephen
 Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] README.md: clarify minimum supported kernel and policy
 versions
In-Reply-To: <20260812184539.134978-1-stephen.smalley.work@gmail.com>
References: <20260812184539.134978-1-stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 12:03:01 +0200
Message-ID: <87jypucp7u.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> Clarify the minimum supported kernel and policy versions.
>
> The Linux v3.0 kernel requirement is only for libselinux and anything
> that uses libselinux to access selinuxfs. The policy build toolchain
> does not link with libselinux or have any other runtime dependencies
> on a particular Linux kernel version or even on Linux at all.
>
> Note the libsepol version in which kernel policy version 24 was first
> introduced, and also note the first userspace release tag that
> included the relevant libsepol versions. At that time, the release
> tags were date-based rather than version-based and the versions were
> updated more frequently than just once per release, so userspace
> release 20090403 was the first to include both libsepol version
> updates.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  README.md | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/README.md b/README.md
> index f256912c..bfd32b89 100644
> --- a/README.md
> +++ b/README.md
> @@ -25,18 +25,28 @@ for more information.
>  
>  Minimum Supported Kernel Version
>  --------------------------------
> -Linux v3.0 (for /sys/fs/selinux mount point directory)
> +Linux v3.0 (for /sys/fs/selinux mount point directory) for libselinux
> +and anything that uses libselinux to access selinuxfs.
> +
> +Note that the policy build toolchain (e.g. libsepol, checkpolicy,
> +checkmodule, secilc, semodule_package/expand/link) does not link with
> +libselinux or have any other runtime dependencies on a particular
> +Linux kernel version. The policy build toolchain has in the past
> +successfully been built and run on non-Linux platforms as well
> +(e.g. macOS), although this is not officially supported.
>  
>  Minimum Supported Policy Version
>  --------------------------------
>  Kernel policy version 24 (boundary) for the SELinux and Xen
> -targets. Support for this policy version first shipped in Linux
> -v2.6.28 and Xen 4.0.0. libsepol dropped support for kernel policy
> -versions older than 24 starting with libsepol 3.12.
> +targets. Support for this policy version first shipped in libsepol
> +2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
> +4.0.0. libsepol dropped support for kernel policy versions older than
> +24 starting with libsepol 3.12.
>  
>  Modular policy version 10 (boundary alias). Support for this modular
> -policy version first shipped in libsepol 2.0.35. libsepol dropped
> -support for modular policies older than 10 starting with libsepol 3.12
> +policy version first shipped in libsepol 2.0.35 (userspace release
> +20090403). libsepol dropped support for modular policies older than 10
> +starting with libsepol 3.12
>  
>  Installation
>  ------------
> -- 
> 2.55.0

