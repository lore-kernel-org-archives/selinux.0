Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958483;
	b=wVGpYgG6VPmPitQzE9ZsoLn0PXXfir//WyDHg/96atdBPz815JMZOQMkSrbsy+41cDKT
	 wQpWldXaeEk+ZU1bnx2YGxZmKDyZVk2azzaxQ+iVQ/bw/JCxGFn3ieXQ+g0Sf3YOmZK3X
	 JOhrySugXRZVi4GgoMsVaIwJt1kdLuj0niDqD/pfUClcpD3F5udWVtXTW8zeA/AUhI2A0
	 E3a/iJsklXymlvIPQnQobr7w9lXXivA3v129jAxFzdcnOtA3s+BcrS7+uW9rQeR+vNIbs
	 aLopacFEzz1It4R7CPTiZ5uvFMwmstzHrbQOPx0pUWseqn0dMCMfOXto8ECsLCVbGcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
	b=obrOiohw77+N98+peAzsy9W++zajD5m1VJ6nJKx4/5VesG9OwMK2Q2LU2RrVEy7adHPU
	 wo/JNG+huQR7T/Pm+lvXzZiFaqL6dDSucpGfb3S93irx3bRMSyZR2HK0sI8rWvgd42hmH
	 DR5NMa9sCgUqqHS4E+3mLYEjTcCCTN+5QqT2WCj6OCOP6sDikzGgKrcO2qKDb2L0MIBfL
	 plN/lyms8i5F5A1XbWo0oEfMZ7uiiZ5aF3QhPllLUWBG64183ZIlEXD06cnSs0DFxuU83
	 2U0tk25Gx+8wHf0PE8OLfDwj4IDT+0HDZOMo5j1iSqr1PX0KokqntYxpg5I6r1AY+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="C1/HoDQL";
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC0606A32A
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 23:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1EC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=C1/HoDQL
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f1e5d7450so36112685a.2
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794958482; x=1795563282; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
        b=C1/HoDQLJzzckFRnS+9k64TFool5JeA6PubBeU/laVzL/w4ah7odPpMpBEDO4oTDek
         tzvkSLyjXBT1ae6muzrpU+3lix8bwV+w5XzoROoTQVFQ75pZIhaZnTEzTzkvFRP9MXet
         cswYz9mJhJ6jqtYt4JjUilPe5tWe18DSDwlcWvq99KCO8DgF8mM2v9dS3T/+DCZLJVWq
         S4BilbEvdhkOpMHkOUTOKfcBRLK371Ffu7Ts5wblHKU+7z+VA6XukkrcJsEnIUrr5zDJ
         9evsjeK1bGn1T3KaRJrNNmPDwV+QAIp1I3m7emtneedTTpgn6usGNwt5x6nS7sEasDi8
         n6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958482; x=1795563282;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
        b=Y14ELw6Ud56huQM9bIHKCGzkf7RMNORj9A0ayoLcy8qEhLXuTc5Euqibo2mp6B3i4n
         Ni7i+9mtgcnntr7JeWDdnJ70htKPCBlPPwOpK5e07EgaR0FCjstQ6k3g2hepOIFTrk13
         uEw0V3y40GyjpxpyyKimm7GMblPft9vUrVTHaz48PgdoO32g02RJZ0o7PMhMfUGBoy/6
         1cap7RwSTLzxsu5pmM5eWQdJFOQcH7mSAICBS3+O+I/n976jGTb+GFCALDEEmMcvPxtU
         ryn+dWte2oT0FmqbdP42oTOildFOVtDiCgqbmeU9WM5hGG0m1o4eDJtuuZKadzOrp+xb
         JeFA==
X-Forwarded-Encrypted: i=1; AL+hErGFpG4PAoYSLfHsUhJQwcrsTmWmjkOO4NwpAqTG96t1ID/fmCu7MBFHtPT/2Z5o0F0kLG/8YiIj@vger.kernel.org
X-Gm-Message-State: APuU4Z/xbhM0CU2aFjQNn0PMKtONXQDLAKIrI2NCS6oSL9zdodkAGJ89
	yPDkCzFTos4mq1JTHMaOfAqz2MAlBXseJPlrx/91K7zcRehvVyYJrcnAqCRUGjq3GQ==
X-Gm-Gg: AYBFou3bipK+kCGEzDY4uADymcKLNz5lfsCXyYdmyo00KxwsjKWGW1D5s3sabWaqjgN
	0x4grhPTi8nG4nYOczDSqo9u1VSpflJN5nzvIy3l/LvWTy5oWEsUgmIKkbXZE7aZp5cr0fhMtdw
	ftS5tQsZPAQtlNGf9KrZFdwPqF0cdsgew+2K0GUqYi9WrvBXKjBizItGbdCMbOgnuBV+JayzWme
	mlZVpUHUU19Fk2DZ1MoogzweHq+FaWyCwOZdHt1yUVKWEdHVPriBZjWFucs15VILABxJLo3RO3v
	3Pqqx1gmU/jK+CKC4mHLwmA5VuRSSoLIePFb0oojmd0vWIdT/88XyKA3AxLeSG9gdmr6azFxEa1
	eTxkrDNjqY0l03PyYXHYTbaj6Wm1STGnU7Lrtd7Zni54GTt0KvquDpRQAqdc4vzJMot/hYnPDIq
	Hv4on1er+iD5kgSB6IyGyBHTseWfg2mOBEZzbNlGvaSuMWrcSTHjgE3wA/RLI0CKpsafaYCGR3C
	2iz6HVQ/bp6hdcvX77ZU8uEHYWEOKQ+zsl7IIdJBaN+l2qvwNJT2GpMLfzKGJpejvVU7P47hIaY
	GfBMPgnHzHJHtxiijbs1hT4IN4Aq506iWPUgzvNMr6X1HXLP2H7TpO9AmPdepnPJua+2ZAWMUJy
	cj3TPVqW/zKj0+qqmYDEDU5A5QK9X+W9ndp5M3CDGKZjdMlwHn3s=
X-Received: by 2002:a05:620a:2556:b0:93f:19fe:e6ca with SMTP id af79cd13be357-9499972c8e6mr213324085a.43.1794958481841;
        Tue, 17 Nov 2026 15:34:41 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm42496085a.11.2026.11.17.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:34:40 -0800 (PST)
Date: Tue, 17 Nov 2026 18:34:38 -0500
Message-ID: <7dc91c090b4f8254f8b6fbe2ec36060f@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC v3 17/44] securityfs: use fc_init_pseudo()
References: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>

On Nov 16, 2026 sashiko-bot@kernel.org wrote:
> 
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and SB_I_NOEXEC. securityfs never holds executables.
> 
> But securityfs needs device nodes. AppArmor puts a .null device node
> into securityfs. On exec it replaces file descriptors the new profile
> isn't allowed to use with that node and opens it via dentry_open() which
> doesn't care about SB_I_NODEV. Such a file descriptor can still be
> reopened through /proc/<pid>/fd/<nr> though and that's what opening
> /dev/stderr does. The node itself can also be opened by path as
> /sys/kernel/security/apparmor/.null. Both go through may_open_dev()
> which refuses device nodes with SB_I_NODEV raised. So clear SB_I_NODEV
> again in securityfs_fill_super().
> 
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/security/inode.c b/security/inode.c
> index 0804023676741..edaebf0f1972d 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
>  #include <linux/kobject.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/mount.h>
>  #include <linux/pagemap.h>
>  #include <linux/init.h>
> @@ -49,6 +50,8 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return error;
>  
>  	sb->s_op = &securityfs_super_operations;
> +	/* Userspace may open AppArmor's .null device node by path. */
> +	sb->s_iflags &= ~SB_I_NODEV;

AppArmor itself does a dentry_open() on its null device to effectively
block inheritence of open files if not permitted by policy.  SELinux
basically does the same thing, in fact AppArmor's aa_inherit_files()
is based on SELinux's flush_unauthorized_files() according to the
comments.

Anyway, I'd suggest changing your comment to something like the
following, but it's not critical.

  /* Allow for LSM specific null device nodes */

Acked-by: Paul Moore <paul@paul-moore.com>

>  	return 0;
>  }
> @@ -64,6 +67,7 @@ static const struct fs_context_operations securityfs_context_ops = {
>  
>  static int securityfs_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &securityfs_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0

--
paul-moore.com
