Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564378;
	b=WQUcfwo+u4Y6fBQ0cOuaRLb2h84Uhj71eY3Ab/3H3GaNQSgpeL7VaakF1S07mW03m1Xn
	 QEDiSmPE6Mc2SGAXixwkbbPS38lS+5SyS9duh7A4PA02yd9xOr6tpSOiSssQxBqsXkno7
	 cLUmUZ2CQR8nyQKul71c8ycRlUQA61UrAZoZJbBFqtl/TUR0fLnMBjvqLis5eDiqq3LbS
	 VF+a3j66RFOf3ab9K0SWu5wXpiIFhF1tBd9FjDCyKaCAaK5/l6RvxZ0GiyjY5S2SnhG/9
	 gfTVP513vUVcmHp3z+XgpUVE4F2Ts7lfkQpIzK3XDjWieQwSP+DbqkLkr5jmOzb4P3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
	b=49ZGRE6iEjBknLfHYIpmu+aAWxoJMz1/NXfj6o4cmBhHRaZMG4/NDBvygLDAwlLTHiYD
	 J1g5sUKw7yJr9lsFxTWU05ho6y4WItacXNWSAOrTtM6aUcFvW/1JVAbR+VAMqq2AtdKtp
	 IADMx8pcWErRi2U+SaQhCcBIQFrhV+v3NnHQWxO1WvsqlDbl1IMsSwXFJfKfhl5tF6RSh
	 mYsn+AyEWZZ9RDMrzG5aXqmf/EsHIgooCvUFpDdV1jyxMczBCEYNcN99rcxLjcbj0lyoO
	 XVG+EghJnz6KTMkyJrf2m/fo+T+oNfrpwxiZZ4zit26ZAF0l9/pNQppDnyY6HHBWqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E40606A898
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E40606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso1499722a12.2
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=WDdVkHgloKbBDmiudlEZ3ZWe+zg0BVZ0Jxwgdy+X6nc8ZJ9FIVi7F/SYJVqBRxNf3G
         3Gnq29xgDZdSKYiYaDVmU8W0xCuGm4Eu82rb/A8U6D5iLEOgHTmlDog4vSfdCU82B9rm
         qMGycG7Kl4j8h61zt+kqUkohzwqy0DPARMdjq2hKw51hdb6jylA1cwqwSD8nreSBsEB9
         DkDXk5ueYK99P4pH+jY8EwMoZnNW6BehoecLG+1JSq6wWJXsZMYgAdKGybKKFJkxuO0p
         O8Ri4u2My3QdIqEe8fwKAquZP0382+IuLTCd4KpBNa7znuGAHwPb5rxafjOggGTtG7Td
         r9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=bYpExUPfhWnjFz0pt36UIudUYWII0epDip9nl/QqBR0IOWPmTHxhELMc2ykJ1BPnwQ
         tD/iouw4iCHEaeQN3VJzF0QojLPzJ1WOWZBlk1SF+7fkFNIBtpEvn4ByuGBaIirZAhC+
         kIiHeqZiXR7ysM7qCNzv0C6RVrx443KQquLWu2G+S03MxkwP/vRm7DW83xlrn1sPMbI+
         QsvLbWpIXfpA0EdsZaQ31LdNqQc3VwSkoE4EMrTLtZ/lB514zlL+XB7Q4U/tHQX5xkn5
         MvKP0eH3i6DLf8M+TRm0BNftPfXwAc1FJ0X1tw6+XioGGw+5tu7kWAGQUm3MN1C4xkqy
         PIiA==
X-Forwarded-Encrypted: i=1; AL+hErF0LRkDqiHbtj+DI3EPkICEl944W5M4qY6quMW2nJVXh6SvW2OdcLUDIJ4A/dDaHH09BItWmLkB@vger.kernel.org
X-Gm-Message-State: APuU4Z+49/yYUIgt1YFtnnxt+HIvfMaY3ZnB+zYvWdCEUUfHCk5hor+M
	tWs1TAcbFBr2cvgjhdPvJgYoaqabnOGge0RC7OjbfjE48vTQH9uytSF6rwJgXpK3OLUt
X-Gm-Gg: AYBFou0ZIppeuOzGazI59blIpcdPHvSF/C6YYsBGUK7G1NmcgDnvhsxbHYVpLKqbnI/
	GLFPSXqPi7KyNmELUD0+fNCIFmTmUVTM9QGUMlg9/pV6GgGuj0tr+6KvoX/iFXODt30AVDfARn9
	4lhY/MrN/EY1AIAUoN9SxbcxV8IXWVImNzRK7twvbUnDcNQhJkjTREJ0DpiS6fSH60IOyZ2n5T7
	n5VxdC24tZ0OGIHBi0rr9C8VmP2A+PIIHcSorUt4qF/An7BQ80x9frQ0tWAI7sLhTGJa8ncmPsJ
	946w0o3Kd95WvaFYsYxPoGSU7bZd02mEjCZJ+ZJxl/LQuVrc8ZBVJYgpsB5QKEfEc9/0Onu8oys
	gbMQ22B6sF6yh8LoJIseXm18zDn4GF5eJsCyP4bI+/9LhJ/xWqvgMl+45FH4guignGgpRgCQYCQ
	q23iP8g5aeRH/OomN4Z558HBVIeicmo44vwgybsagwdAThZiRzEscu1ud2AgUHlXkmLauMdF7px
	9I0IKHPNbu0j/wAPaHl5qJ0g5yqatGc1dTnCc8DjQ4M+QaIskALCPC5us4pvdR2qvfJoqmtT36G
	D8oBy2Wlo7aBoCReOncL/ARM23uLZG4JTUJx27ZZ4E35NDKoU0eeKr9Wg2Z55CQ=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
