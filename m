Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904594;
	b=w8ERw6K6LuJi7+iljx6dxiQ0VUdfjOkr5r2abN8jpiuI1Kn9A4hraNk6B5u8c7SQtjAs
	 6Z8DIF7YbeEjvCmg9wR3v00J8r7aPyURKeYMN5RsI63qb9aGoJToSSCsseO3jMHEgWR3l
	 9q/0Z6L9MjfHsFxYRsQOJMLEsQ34meeVf+i8g/Wy7FPJ+sj8wVK/eKBQTKpo9gbbRqmic
	 jRPEMYYJrqgEM5p/WcZSl6kW4v6xJ4lqg+YCL9oaJQkqQeGM4nyPc0g1cW/26HmkIEjk8
	 ZZLXZFtaSJEUW/Lxt92uYQXMZ8pmAQivryISF6eX5C70MEbyVbdxY6055AELCDKeVKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=AzY7w5AiOPWko0UVnVBvW5J/9lZJmJkKi3C4vZOWgsW6EnpgnvtcVyf0bAkSmnc9KF/c
	 +Mq/VuvmROr0o9FWTyOW48I09OdnZF9CaYDNhdgH3jsRu5v/DXHNrXDkeEFearsPbytWm
	 +mOOF2kmMYGP6nx3IliDn2dQXzPx0JCd2MFssb7M/+7FAEhcd09+I/XlpHyu8te1w01pc
	 wLAKAG1dvPPoNMu+C8zgTq4YztXaoZkHJ7aJXC4VTbO+TDAn3nuwo54vY+cra3oXTRITB
	 ECjbRJ6C4PD2EgXf87MvJBz5lUEntVh4h1DVsVubaD2d6sYTU7d7Qx8ToTAi2uaUFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80A606A896
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF80A606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a210470b49so35813455e9.2
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=Ezml0ZoV4E8yFbWb2q75YyNXvTQq9C0O1WneMKWd0WiBcEHUljKaMYJQA5EjnekMOw
         zfsC4nXK+/w4o+5aCh74C1d0MVdz5fd65ov7nCej9zQu9PITZUbG99rRFO/zVyuqweA9
         sqE4HcWYEQ7O8Jzc639ucwvBBfm3PJWq81Q+FNzIY07fxh2Sio8Z1OM3XDvuYHRhGOwR
         tpJz0kUyd3LfGicrzHrrfDMkfqGWqeRAGSQxgTlmAd5rif/5crHZiOcu1+0fZTvN2xQM
         VjXD/tD1rOq08QF2Qj0Udh3jb3a/O0OAfLMWj6pIYVu9AI/xsUZoE1wTF0Yio/LlD5Wt
         nmCA==
X-Forwarded-Encrypted: i=1; AL+hErGncWkwViUhuwnN67hHNpOD7bjefjY8Igi3XxL70NDx6RMuvV/LcBpNDmUwRT6KYXBT2G2Zh3uW@vger.kernel.org
X-Gm-Message-State: APuU4Z//06IQkq7U8wdfTfphYWHcV+agLnkIO81klLMhFLMFRqGoWbkB
	OxyDbVTAyD+fF4UxNIBq5CMBw93bNTuZ78cgQaTdJSMj1B1MwuLCyBWom5gDNBFpUh22
X-Gm-Gg: AYBFou2wg6dzvGt5HCcDsdAD0PUKQDFK8m6enh60Kcu9qFpBDBUGw9n4P6QT/Q3iKOw
	nWvuOxTmKBAPOjzZjfHrOObS8ks35w2X92Cpal9ZoLyCPt3BpzDZ+I1Hgf3jfrTxMLVndvbUVAB
	jfeDjwzx2aR29MufLTMaZSK1wnFh9s0nubjdqZwgdF/ek2ktHu5BryX6Tv0Njg/yr60H6jWbiHV
	CsrfU3Gc21HCBciB9fAZBvb6wTEomX4XRFefR5BAculqnWBYblIHqfN0SxBSR7EMTD/IKEhTYhJ
	SeNsPsaYCxzTYnv+QyEttqyyD79v5HigJwsJSoAFSL/YAAUGUNqkjrSbMYk79+8M1DFOEut6RQe
	XwzDV/rPljE/XF9kkIkwca4NYFOWZmCFjP1QVqMbld4kufitJBVSpQvFLwTd3TNd7TNiddrKhOS
	gJpYJUj59lKaNMgu9kCVE/3Dj9Ujd6jpAqtZH3+zCOuL22vtq7DE/S2l0b2fNtSs7buVdxSfPyR
	rnbMAAg49HxN67uo5D5g8jflQV5Uj6pVl/f4YUK98cAmbqICC35BysnyYZa/QQcgFeq375JvzLT
	pLuoW8UOpw6DRb/aTrxjXIWtg/z79A0qwBmJBylrpF0HR7HFRg/Xye8O70ZIH5SgbmOELWvmiLl
	wSH78G2zzLIIVWvKsaQHUgjMyMKs7YXrxCqXPdolZvuPdjBPkFgTVkaBa
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
