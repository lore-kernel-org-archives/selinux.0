Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904006;
	b=cjzyqqwQ87e0NOpW7bcIcI99lN6x3eMJbrXkOQwtOH7OJwsrHbArEjMej+0yo3sbSU2G
	 5FFIQxDZFygau6qzrt1ZX18OC+1bLr+pM4DfEGwo3kgwhGIq6toKSWNAGHALq0mS87+NC
	 V/SYcUMryoTfgEUFcME0dhUZDITQS39B2Ydrh9dkJxOzM+tqb+pZj4wYC7yu4Af1B2fOh
	 m3TvgWjVTfEv0Qj8rIiOm9nlQlOInBAKxjXUC9kl+AhwtqTKCBNxRO1HmMzqK0q8r5sr6
	 Ah7O81WJDgKkz1T2b9VsL7i1BwX17QI3qyK6syon/oOtXexi/I/Kz4eh/GhQIVzwXbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=gigNEgg92duxPFIoW6TNYECgu6Ppac/phwX9V8LA4WmJQI9Hx5/5TXCicvL5nSQIOPUc
	 u+ZN/AKsh1oC2LOE7mHoQ03IqVn1AQXt4vgTM+AC4bbD1BgPK/HoB6AMs1Atnp9xJXPsv
	 X2tZyMXdzU5v+uYEHLMGB5sVKszu1B897KN80koTjgxojkr1OytkbK21rdgFNmYZpMWJL
	 9UTsEhK0q0qFDr8XIiTO87wp5HvfZp6TM6xcwSwLs3mAkrmGTgteRVDuL0s0NOZc+UzyB
	 BmlOBvGFHAs0fMoVX1tVnjLmQgCMYOXufl49yE6NNTD0UrQ54FuxvGss7eXvNES3xGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA1606A335
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDA1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso174956f8f.2
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=TFM7g941lxfJYiiFo6/kiZ9b0B+he/DaUG5cArktLWIPuQnxgzTXjw0eb2Nk+KzWDE
         MJpqHVeK18FBobOW5kD8mIal2ay23UDtkX9PJERwaCakIB+GyALVrc7vfA3eMdoUfRGp
         3RB1aihbChSSQtgVEcm/f024qBr2TXiRSo43pWsgUO4V5IDMCTqoJOpDNBu6o9jrnQNY
         0U8KcRiqlziJzGsRklpwGX6bMtPsdw1NpD4tWDBrtbv5yCxzhNqJAop5E8PoUDNFsP/9
         oRjcfY7kmorx9vLj07VrTOkLbYD8+53OtaR7WRrwU7yUv/r4JHHt4lhCRIzCmn+56EvH
         jQpg==
X-Forwarded-Encrypted: i=1; AL+hErG+TpTpmWArG9TnEYHNngOu6Mth5/yOLxyGIJcTQVew/O8OzX207Aqvj3m24jaOmRjJ8Nw+Ukcq@vger.kernel.org
X-Gm-Message-State: APuU4Z9POSVzIucNbrG9GmMzf+gPlNlioeDQxkS3qD0m+YJBxm02Yi5u
	gcaVjEvRDbQpL4sus87Ij7IdU1UQfqwigzhZeM+1/tqo+mPUNWkXBRiC1U0/w45tzSnN
X-Gm-Gg: AZFdTZcPpKMuH0wuFCrVo2H+NyrOa9qrgkc7DUFhQUZz/uzxLMxI8wjtcwyyNCbIS95
	bA3U0x2ZZzDMzqVt7ObBXxiqrII5wIF0qjnZfTDvxQ/K490nqtV/01Pnt8w4GpE84g2WKv0w/14
	Ay7av2EY6/r2aYcLXKovSRxqR5sXmDG2qus5fa93vn/Fq7lZV49n1wsHAMsZgs71jxSNUZisDgr
	UyviZhDNz6Ajn6x/RT73/rt9z0cGn2PkcHvLp8SimAxzh1gvjsaJsWw7d1WmkCINi21QLM6tt2V
	34cIgtK0ihR6cAXU6qo3c7iiJOOt9z+ebelEwwQWt+BLdRn/6vPCPF4bCIZP/3e4qWaoNno96V3
	7M3NaS9gPc8IiJ3K2PF1bjLEv3CWcCEzybbkNS8ybm49N4pz60TAsgYuvs8zHRgyioJ4JDcVUe1
	kdaz2y1pW6xFXpTkBxuO7x72zmyVUOHTKikJIworF2JvdajSZhIM2kT8cEWkAPnLQckZEUh2HFf
	aRMdPa3KLbziUWVdKfFck/1+E2VTnkf7Se7031g9KqvGs84IRF1zHJctKDddZRjR9CnOWiEg2Es
	TSiC7a2YnmHPVDXXuHs8thoT5UtSWwgvijYT5IntgGcycD7JFWKq93zgSyixiFnkV8wGhPBu6gC
	7DHQ/29w4Nobd+iisFEi0pUhk+VGGMwV/iSRzgmOxbUwe1+sxZ9KrGP3F
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
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
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
