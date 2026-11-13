Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564825;
	b=zloUL1Yerfjc5QbH/OOOdZ5mDn7o0EfOLoGDt9D/8vcc77oBM1qNJQquaMoSj1G70fs0
	 lLWOCdX3x9oFm2DPKR3VLiqZHgSnYWwrxT2Q2ufqVPBlqD78+zLB3yJt2VMBtTCLZhu/i
	 23hedY/iLR8s77hVErVjHwA/+RJ/Va5mBUSe137gh7CdlHmCcdL21vJjFIAzkgcei8xx7
	 Hr0ePC7IOE9k96prJYsVu3G2iexaookzB3bisKuc0nsZpwZvehUsCNTkoR5gwXtjuWTnm
	 OM1ppqkkgIgGj8IoMzgjEN6/aIp2ACUM9nzfyAw5zkW3697M6fC5DkeRZfhs7xAV+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=o6bxdQDqZ775aW0Aev5wPO3OrRWpSKrOhEysGbPVlgIA+Q6ips+P4hiC5S/yrM8R1fRS
	 YI309lhQIIKt/JeQf/2NvNS1n9NSq5NvR1rTeQLejCibBF0ZL1W8km104lSagutVbQCQt
	 UwnRt4vd1FuL27ab1U7KnFxe24ExlPGv4/GaSv33urotqM1xIii8H+akvCtXZqqNk1u04
	 KWhg7Iw3dWTJmOE4KDZ6svug9qxBY0+m16RIpkSu4NvUy4e6CF4qcS1b3mL1zczdSNcq+
	 0HqmcoCadZdydUqT3EQOQAN/XcPaeMQ905iaKep/6Iknq4Zzqw0D5KJfRsv8D+mjtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AB60A2612
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039AB60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso1490866a12.3
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=PXcGn44B76fhJ5ArhC5zZT0lQKXc44dmEQJQtcRSoYIlx4ps5ZWes885qtiPGcDpqd
         kR2/oAHAHbWxfJhjhHOW7n9Y3Dzirt4oaqisV4Ph/AxwLK39o46ey4OzyoRw93Y8WURP
         oVuSOa/wkSE8o1TvSpLsYieQNwS+X74fRN2NOuTxRQedZaZUgRdUjtE0q7fvf9he1UgI
         2WBuWFYYDfoHQccw+51jl7BSg7joz89fkiIrtb80EK5n3LyC57e3/MWs1lKpzHfD2CDc
         FKZpJn3UEzXwzXAy89qaumLww8kdPDMpSBa9Lsne90SOxHQameF/bJlv3OnaTXtxbl7H
         H19w==
X-Forwarded-Encrypted: i=1; AL+hErGw0OVCECdHGCYsJXq3mreaa9OI94PQzNYtlg3Qw1KF1Ah1q1HjzE0pe3qE5JHu8rBH/OuPN9ek@vger.kernel.org
X-Gm-Message-State: APuU4Z/QUAdL5SnC8ykoaT5V7y3Jb7Y5uEoOM2q/j70viviWoTGTceqM
	B9yMoUJc4k8uv4qVWQr8hCuC85a8nw8jGH0JfE5GxcOuiJcU46CfoUqv4XmCzl7AVk0v
X-Gm-Gg: AYBFou08BDGq4xekSZP+PQjK5TAM6E2pwbn/Alj9OBpRJGlTL32iqGgevJ60j4Qzffm
	1ypM2N8410daE3YLhC0r+m7rs7P8q8h8ZntnvDggaaBMplfNLqPiKXaIcNw/rMqi3NFKaqXSqCD
	GnXBbvut8BU598reEErD8L/09Pqut8tbEwxlQPlUWCIfilodaSMSHpliQv2sW7VcEusOj7Jzogh
	kkVeFbOUeXuYpQAvG9vyB16CivYwJK207h3Ezx1nrr9SCmRpV6q2gFxZh7tfpzAy6AHqVG+2cbH
	q3PvHwmFtJr06rXZrTKbKFn7I9xINd8tZeUd6iiFpKvpqV4it75DYZHMSfQz504Ux9xuT1RRRix
	8ts0Hz0R7+pLrFIeyyZiJ2eThaaMJPDvVbJ+du4FWAqk0mG/+WVuno9IQSt1gnUwPYOSuHdFr/E
	XouatJ7s0//6ULN2L1AkRRMel3QDWMyY8eFXyZrSQCcEwSVYwXtMgMad92O2reru+9wPBTaxMzr
	aHXkzXpWf3zuCP7nMWne/21/uoS2yZ3P2vEssSdpro2Orfh57opXd1WKTwOa5D9kLOGikkh5+TP
	G8KFcQntEJ27fpj+QG+dIMAPV9YqkqpBNX6V+j3cZM8qBlx/+heZMhFdBKLBdMiV3NimIv6hDNv
	PldPT+LHt
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
