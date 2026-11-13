Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=S2hOOpxufW3erGzyXi+qGaw+WM0LcsZnI0Y7fl8ho30x0kCbhpQoreo5hD+rar1irPxb
	 9sofOqGl5DblyLjppxkhmPcb+lsOjA61Ta2mk7fjfZpswpZd7ogjTtBWbzlHrLWqPZgPX
	 I9IWWLAd0DIxt/KcXPCU0zjE3qOnY9tYl5Z2puaEFSSV9JcCM17Io8MnU9wNHLmM+DVGh
	 SCUEgP3w4tG2lbx3tU6Hyq3ihV3iaU1dbXVmELU/X+9qQdUL4YC7ZVHB0s2B/INP0e2bT
	 cugy5X1PgFpEnyx65jjQM4sq95hc4kaUmsttjdM4G2f/VgDBwvt4DjQP6iQxjuquEAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=pL3NqSB70LZv3khagCAmvPrZlb25nDpuVk8JJRYDaJSSU4yi975I8YKxDpMVoSNlr1e+
	 sD3sIGzqScSIj52iwWrdH4K/5LyNitlLE7ketwgMIVIpUnyBp0BDqgfktswTjwBlHNjW6
	 kdWKmXCIQaERFMY9uIQaWenOzMdQEDYxXb22fbrV/uPbtmNxaRWY4LzoGLkoX7+ZITwIV
	 kdGmlKHkyakiO9Gs5IEIQN6/pimarMwom7T4Ovn5q+EwpW2JFzaCuQ0kG96S3ghkHb4BX
	 hfi0vSvLQboryGT89akJi3cvsI4UbwbYfDWDR6TKwMFnjNyO4q5Soy5SZAPTIRgyjZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970860A262C
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C970860A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so3385674a12.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=pU64isGMQcuanH/+SrHmOAAsmM1ZtTddWrDiflNwe3G5EIMVywx6Qk0yAd8Vymj7bB
         RFXxfQUIsvSItBzBf8DDud5lpgfUD8H7dEORUtal4EJLM/+u5Zh7qoz6smENJCW8SLmi
         zybT7ogKwe6wGLHkLD2zo0hEg6RnW338jDssMi5GZfnWLqYYzbSKzVMwLDJIqaNPVKIN
         ULKGkqYZHku9bWwqbwhqFIBZTru0lT5+1U7gBopvTIwFhvELBh8NXMFYkQFMvdLOv72u
         prL4BivcU0cKEn3JRMOC44fBG5TPFDJew/VvO1Cx621kJ56LePtOKkHZwnZP3fD8qTgQ
         LnGQ==
X-Forwarded-Encrypted: i=1; AL+hErGPAm8xtM78FADMmtDA6sw+vk2a0gtyqaDmV3eL2kAKyXNciiurNUkAu4d+RMry+MYuyjsd0EO8@vger.kernel.org
X-Gm-Message-State: APuU4Z96g3d7P/UAUlZ9GiO28ecVcz4qRW4LxStJiutyUkU/6mCR69iG
	CSc0qrqNV2+zlwHSXf4QansLKT+X4mgCjDQ9t+xennzjfrHFBcgu+e2//EDXMtvn/uAn
X-Gm-Gg: AYBFou33yvxlYhP5gQj9fLbuaFZHVLMNZ9vfcX9pAuQQD10vFZd2a9FiWmKHPrQyJSD
	ABBB1PoXOaAVq8mON9Iq947MjhxyYFp7WP35DQHEl0HMfgGSVVXX+54h1C/cbE5ZJ+/NnU78d1Z
	zHPTMIOOXyl4TFxwGiTPS/RyZLosq5FGxBS2FUXnf3xl8RZ1NN5qtbF1+0rRh/uHh35j+g5zHc+
	chnDOagWbpCBiv+qGuZbXX7/osBEh6hykGbR1228qzHklRLAWwgO30W+ARAQvd+ilg5r0dkxEuO
	9PTeUnGxBJSkdnJN+xtQQzOwJ4qaKx7DA9GWSw9n7U5wJ1a/3NMLHMExoO4Uiozg0U25pKwEYoD
	Pi1WDQitxPt9aIzVeXt55ygIURj8t5PYjPoJ46bbQOOT8ABJ+l55xKJ4pELF+I/VDPbn5z0LfTn
	Ljm1xaAXHLiOXIqXZ9sBw+l2+YnYoCA6OIqLEDXFS+V97nL7oI6aCOAmHIH+qndWTM3Uyld4tzo
	uofubsNeThcfi48vvhjGI0RCOzd1iMHxO+DZCHEsT8aDF96Mv80FDWdI2ed3wVN79LiBP3VeF0A
	TIsN5zf6kX9TD5ZeHjL/dZg8vKezd65DMUvEnI0ggrEvnBW7lJXQOSJLUM5sSRM=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}
