Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D01480DDE
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735222; cv=none; b=ixLwY6+dt/36b2blDWao8sx9R5HyO3kCKbkC7h8eOupN9UpFkuZhf/3aRQlNYMjoJpT6eAs9lDBieEXi5Ys3RaDxhUqfqMbywKmesoDFRS+L5U1MMnWyKzAgv0Ya53/W2u2N3HUbzPcG0d5WkR5vmdhZY752DA6UIYzWBjKASPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735222; c=relaxed/simple;
	bh=F4KYwrqCJjEgfezxQxUfIi6qPOrrq6egxEfkQFj+L5o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lal+7lvS5QdNiVWhr5CXr4r8/A1oW1T18/ZO+BcPV5NaZ32WwtsO/dVn6kICOmUjl4gPPM7OkU6nX5mQZ9W/WzxGR8Bi3C3G0bJtK4D3fdIRlYrTTJETGYL0q1LtIao/A7H9/7mwVm076vQoqzkgvfj07HhhZmXSuiI7/TJZskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyJRg6gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyJRg6gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784735219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cao64DJfWHR4u1oRL8u9+Cw2ZOFgByL+YciYs+TsU8k=;
	b=YyJRg6gg8vbX+C0qc6mT/vdL1sjo59si4aMC6NZ0eLihD7ja7bu7Rtjd82xF6cbcdZAtWs
	op39FwH1aVbrTtl+vPKG7/1hWOH+8gFie7GhNyP4HooA2LqfEy8/fqwyylDh/StL2kk+tM
	CJADy3daRqPjFyS7r6u6/LYrhVZ8p+Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-3mHfo44FNACt8DbcKRWT-g-1; Wed,
 22 Jul 2026 11:46:55 -0400
X-MC-Unique: 3mHfo44FNACt8DbcKRWT-g-1
X-Mimecast-MFC-AGG-ID: 3mHfo44FNACt8DbcKRWT-g_1784735213
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13CE41800756;
	Wed, 22 Jul 2026 15:46:53 +0000 (UTC)
Received: from localhost (unknown [10.44.48.255])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B1E2D70;
	Wed, 22 Jul 2026 15:46:52 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Johannes Segitz <jsegitz@suse.de>, selinux@vger.kernel.org
Subject: Re: [PATCH] selinux(8): note on conflicting configurations
In-Reply-To: <al8eYnGraP-hoCCm@suse.com>
References: <al8eYnGraP-hoCCm@suse.com>
Date: Wed, 22 Jul 2026 17:46:51 +0200
Message-ID: <87mrvj9gd0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Johannes Segitz <jsegitz@suse.de> writes:

> setting SELINUX=disabled while having selinux=1
> results in a non-booting system. Document this
> here in a note
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>
> ---
>  libselinux/man/man8/selinux.8 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> index 5842150b..17df2a99 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -50,6 +50,15 @@ regardless of what is set in the
>  .I /etc/selinux/config
>  file.
>
> +.B NOTE:
> +When setting a conflicting configuration like
> +.B SELINUX=disabled
> +in
> +.I /etc/selinux/config
> +while having
> +.B selinux=1
> +on the kernel boot options will result in a non-bootable system.
> +
>  The
>  .I /etc/selinux/config
>  configuration file also controls what policy
> --
> 2.55.0

It seems to work for me on CentOS Stream 10:

[root@default-0]# sestatus 
SELinux status:                 disabled

[root@default-0]# cat /proc/cmdline 
BOOT_IMAGE=(hd0,gpt2)/boot/vmlinuz-6.12.0-250.el10.x86_64 root=UUID=45db8c52-819d-4199-bca1-3f50a95d7fc5 ro console=ttyS0,115200n8 no_timer_check crashkernel=2G-64G:256M,64G-:512M selinux=1

[root@default-0]# cat /etc/selinux/config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
# See also:
# https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-selinux/#getting-started-with-selinux-selinux-states-and-modes
#
# NOTE: In earlier Fedora kernel builds, SELINUX=disabled would also
# fully disable SELinux during boot. If you need a system with SELinux
# fully disabled instead of SELinux running with no policy loaded, you
# need to pass selinux=0 to the kernel command line. You can use grubby
# to persistently set the bootloader to boot with selinux=0:
#
#    grubby --update-kernel ALL --args selinux=0
#
# To revert back to SELinux enabled:
#
#    grubby --update-kernel ALL --remove-args selinux
#
SELINUX=disabled
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted


[root@default-0]# rpm -q libselinux
libselinux-3.11-1.el10.x86_64

