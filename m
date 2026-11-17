Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904032;
	b=rkUCDKthYhlLxJ/n80CdJXj2qRXVUX2de4eOAWP7L6L11rNG/j8+mZbJGmthsT1tvilV
	 YBhOONQK3zl65KaHeGESTautyLh5/cFss4KvaJZGFkgdO0KzHQympPP3Bdz8WmC+aiB8f
	 BwX9oIT0NeRzCGUNS1K8JtE8Kbm2JENC4kcc8ksGCYMdx7JMIAZup7F3zKK/BMPWHETLV
	 PwCEB68Wf5ebOP7JXFtCbHh/dYEFSYTS0Tl3IwyWKAUJFrfXGOpofnthle8wMpK7qsTeK
	 +y8PMvnNwvrXHYk0QJ1lJBQ8XZCowCmW0kt8O/thik8G6/3/XbcPZcYbIrIK0oFKwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
	b=24lP+Eqe9WrdTicIFI9stlxtCUvWPmaGOiLQAHm9mhc9TU0U4NZ8diQOd5QA1f8SJLWg
	 kT5Sc8ZNmoX+lW+xjR9Rfra9udVXGwvTDXpI2yVZTgywZ8DufBOdITYostojjK2eUbUbm
	 6T4p4kL8ojcaMprhFEBWhuC23M1Tb2+yV+7KxHqD/D14o4Swe/dojdoKr12T2tuQriqIy
	 C5ibxdmVH0eh9q/5j8h6O6I46TOvUIqFjjQki3o1LGHSYfGYkCCO42D9NPI1vi9xku5Zc
	 S75JnZfDAYHu9UIFBqAOVLU2cGzOm2NNux9AkRR++cfnpSKX1rOCbsLUGfqGSXZUtyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576C606A329
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E576C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so17182705e9.3
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=m3Y+iV2pelmutPYORVxza4CHQMpjq7iS5lmecWgDjvax6Coso4uWa+KMaCm+CB3bWY
         yM9xDjlaUDqClL2wfFs+3EgMKFX4Q8fuLgup7VSVEO3iDYFOyh4nyeN0Shri07+KD82b
         UFGbuWvBELdRnXkiKa1GIWjPRb4Wz8WRQUErt4eMboeCaxWHABbQwTZk6BuPw2NopAXW
         5935wwOL0Ggt8LD7VeJmtmL6iC6DgtiD4S4DRbEtkaj1swNFS1XEbe90cWaNyokAE8Lz
         Ulc1c4G0eNVUIpLzTdbViN3HgCOMoyHpu6hnCIZ+utcpbQY02w1kBKtCyN8iaUfGq6tI
         6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=bTmpJPKxxhokPpa8mTl/kVB18kTbSCQchT+QltUAeqIjeZvRRhUU0MPRduk4FyuMZm
         z05Nk9/p9PiZoHoSJL9W73C1VpfuNKH4KXaK6vhvhwp55/vVBQ9fPPJTdFqnH2AeTXsn
         qAz7nmxQ3Ec6zeE0loPTVdVFcIsp0aKcU3+u0I/aw0ZHsaKUNf0oWCokbyo5lT4hy7zC
         TpeW2j4B/7Y7reB0l4Ch8PKPcoBANIl2IhV595cV72xDm5QDemjcvmYW1FenxEiKXPfG
         9s3N+U8VMVuGZHqJKA/R0v/YZKQzUJf+feqm0EISk8rf7dOFIsd+rq1fLAUYsRJHv6D1
         RyYA==
X-Forwarded-Encrypted: i=1; AL+hErG0DNxmty2rYUsf5k6sqCvSe9lI6OHzc4g0r+QwflEoCQDLcaugLZ1aFXidDRGV0dEbShmSOLSW@vger.kernel.org
X-Gm-Message-State: APuU4Z9swfw+dUja7vGeLvORI8Zst32dduksgUpwU4uLckmGnEYT98Iy
	Y9uBqrLpKuj6nk9xc2F5O3Am+cDmhraPsxhP8As6sdisWhkA3XJf69S34xA9dgfpfeyv
X-Gm-Gg: AYBFou0DfiSCtbU1/0nGZ82hvRDlB4DcRT+69GQkucbyYdnT6ifqsAgn0FviUZN2W+w
	DmUwHu8RZv24DSx5OTCDpAPLd3B+8hv4n86oOeYLqArmHK/+NOFiUBUTl+W4TH/SKkyQUeG5cxd
	u2LPx+qgKhaeWBKNlExdh81YY0OVQSmmMxFGhofmHNiJya6sMSOqrf0ZkMcR6jVsIxTrMop18xS
	D+E1r6a45BfnhRtuPO/fDVxOx85yMPNIQTfjZSGiVQCrLAF0NxuqF1yB8Iq8ePplgFHmt+rfXh/
	zmEPoCIp5Q2iM1WRIb1os2w4qW2USgOrsxxMrEgtbWybFjtszCYeuqjALIZxVZbHxQsRw9stU1W
	JkpZSZ7wX0lM0K2B/aLQNVPd2TKoNhfcWYUyzB1SL7K1ZlNoQi4f8PmKoubjnB4D0P5RlSIUojy
	484QSS3xSO5EgHKSDFFclrWCz0B2jNLxbu9amfFZeuslJT+Ag58EOZsdagF5bJHVrNKVHQTpTh0
	EzLSQ3YAFeZ0O6/ZsajRzegOCq4dkHkw3nBqI5F6po8X3NukY7BB6hZ+9+IMwCPjxKhchKiKJt3
	Lt/bn1ybbijAq7eHavfqYIrE96f/13VO6dVynWGeNH7NH34PDY0lbvodx2MnyveCZlWy9mKqAIq
	41deSpVJJdUtdsXnMvOmuqzBzvIhVuIUVabU5ZFbA5RzrI4WxCED4/bNS
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;
