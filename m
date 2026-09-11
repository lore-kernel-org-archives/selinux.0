Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94949248F72
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135801; cv=none; b=ikhdZMOMa0lBo6el9wYzsj4bbiAkvciK4oviZFXBY0lAm3gm9vbhAJWFzp2S4I4I0haIuD8NJg3T8jaam4VwAijgLbvw7Tra7RSc2yx9sR42df6DTY8UViToMhrmlaQ6lEM6uufXB273oZN1CPTWzaXwVmz5uxJaUqY+Q2PFMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135801; c=relaxed/simple;
	bh=Dad9MDDLchyzKhxFNJ3G5BHiGuIgIfpMiw1oFhsBpKM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1nN8OMqUiM3p+qzGojHHdx9JivDUDc7x9KjIV88AMW/bo7tUU7SHT+yvHjC1dnJHUJCLkzmV6/XLuYlBZdRt2ujnfqz2oZAr1DFyN/pLEVI3U6A1Tp6Jdi0FnPyU3wKa18gXRerH6UXQqnQE7lO/hc5y6yRBLPd6YtfqNGLCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/TRaW/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/TRaW/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA81F00901
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135798;
	bh=LkVp5OV3cuddE8uoE8ukH49jc1TJUhupC4bbXDL8oZY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H/TRaW/fHfxW0ZQyucDCIHLudn2q33ki5PgBXFhOlQCSw/qMtPnegsQn8r+VCQzUI
	 Yr6pgNdzZhJIM15lwk/+TZ3AHfVUdx3nZXzqiTBnY5ch8jNLYqYR/ee9i3kb7XLVWv
	 9gdcjeCMB8KwqGv6wXHRIsVLAXkusYj1L7av3CF68mwshbIrR74VIVc0G5hjzMJDoW
	 IjsHWN+4KYcXhf4YA2dVwwLBq+9gW5jDHYVMZ9Ezk5TrdaGzx+DZd4Zsk8zf2qnp8u
	 kYbvarmZHLS3QfWS47xO3gZO6cDCfW5xfewZzwiPGwGytBSVvoYvcaw8ZSfxJugM4G
	 y6+7sqvAKHKDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: reject writable opens of status file, drop
 mmap write checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260911135147.15355-1-stephen.smalley.work@gmail.com>
References: <20260911135147.15355-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:09:57 +0000
Message-Id: <20260911140958.5EEA81F00901@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fully prevent truncation of the SELinux status =
file, leaving it vulnerable to path-based `truncate()` and `open(O_RDONLY |=
 O_TRUNC)`.
--

commit 4651117ec33990214895f2560efc1a4e7aea0f83
Author: Stephen Smalley <stephen.smalley.work@gmail.com>

selinux: reject writable opens of status file, drop mmap write checks

This commit updates the .open handler for the SELinux status file to reject
writable opens, while removing mmap write checks. The stated goal is to
prevent userspace tools like systemd from segfaulting when the mmap'd status
file is truncated.

Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
Link: https://lore.kernel.org/selinux/CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-=
PiL4e7LU2nr1PA@mail.gmail.com/

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 5aaaf69410bb0..c787e2204717f 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -219,6 +219,9 @@ static int sel_open_handle_status(struct inode *inode=
, struct file *filp)
>  	if (!status)
>  		return -ENOMEM;
> =20
> +	if (filp->f_mode & FMODE_WRITE)
> +		return -EACCES;
> +

[Severity: High]
This is a pre-existing issue, but it looks like this might be an incomplete
fix for the truncation problem. Does this check fully prevent truncation of
the SELinux status file?

Because open(O_RDONLY | O_TRUNC) only sets FMODE_READ (and not FMODE_WRITE),
it bypasses this check in sel_open_handle_status() while still triggering
VFS truncation.

Additionally, a privileged process can invoke the path-based truncate()
syscall, which bypasses the .open() handler completely and falls back to
simple_setattr() to truncate the pagecache.

Since the goal of this patch is to prevent truncation to stop libselinux
users like systemd from segfaulting, it seems both of these paths still
allow the file to be truncated and trigger the crash.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135147.1535=
5-1-stephen.smalley.work@gmail.com?part=3D1
