Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=lsP5R1AXTjAv132GsizwkafLjzrKLvCSg3JLukqizIV/jB8F1LkVL6riQA+as87zjYmz
	 mgcTyq2r82azw7XaCT70S6Xg7KvRdwkL6PwQwtFLq6ywiG0Q5hg/u1i6OWUJPX2XvUMQK
	 sVXrVKAIBOGdr7F3yLBUlZNcIF08oyfl9Y2uRZGwEaFYEOUeyHWz3ZM5R8QC7ZkMKBS7J
	 XLWb0yEVcvMpwXlowV9VG4G16oVJtDZrp+XNbC0x1csaP4G0G1Q8hoV2bREi7MaHWns7H
	 A56/1nHZ/TO4mnfKCDX56akFxjBcwRnec/BUcTwx9Sd7lHhctk0XXjbJSyQnOjtkJBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=d97SG4h4HgkAat2vsk1chczGHcP4KLo1PhDEhgbUSpq3pY7+NC8uWnaUnY6KcaZxPSPn
	 L714MxuEnTdJMOBL3Buuth48os0pdMD4h1qXkNvReae7jImjrGfY99ZDsXqt6m/7q0HaO
	 OkxkZfhhFmFjNSRef0jvsdX0vtDa17EM2V+wkDg+hrCaz0P9n1oS1NxtIGhXIGhLv/iGX
	 N2jDJlaM3Q7cCjQKmgAt70X1qBPSiWJjaaVZgxbxk51GIISZojYLWHv+BcxQs3RWzT5F0
	 rJbCKEQT6I0RxafSHo5vBLLhBrlyna2oD124yzqEh7Rh1wX+l2SHRJle3BldjD7CK/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D64606A330
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D64606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so3649025e9.0
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=SCmdFXCn4U/dJT/l8x5WP9sBCUDCERqNPz8A2BZK+v6IeyPM25Rux73nGyzV3/FqV/
         rVaXJDA7pFoCTGaZyrq9+pFGiHhTClMC++QP+Oxj2BuvSqpOy5vgTMF99gKcKGceglS8
         6QfUlh+lLM19zGydVfbr2vH5DQ5/kRaQND6/a3tZ+0Klps7GUfE7LsLnUQyJ8kbC7ovH
         mKEtcBjG77P24eenbrdBpv5c7XzWexmxulCTcjrid8PTapgYSKvswwiHiE0uSDL3ZPKl
         xJ+ID/PO6kC8drgfuQesVO2Giha8FftGxAK8D0+H7oilr+5BwervNdHLuZK6h/u6dFiR
         1q1w==
X-Forwarded-Encrypted: i=1; AL+hErH3Ek0ZRwMG0ul7J78n2AUfPk0dtr/QsIIhevnE0R2ZLOf5t/hNKW/yczeWhu/YoX/yBlK1vVBE@vger.kernel.org
X-Gm-Message-State: APuU4Z8bIwq9rmbpDyxP30fRHlDqbFSioiBJD59UZPrcCzTs92nNVDqt
	j+EfGHMJU3Hg3MPYzOsXApl8yrnIVARy3vexamNC59jpi1DNoyVnXIDZxoFeZL7f5FiY
X-Gm-Gg: AYBFou3GNDo4od6INdl86ahE3dRuJSVTRfsU9/omEV0eOLVV2OcjRkcIhJDEsnKGYWy
	A/ZK8E0wJSat3W+PkbJw0cdp3pWN1ocLzyfcrIAXfsEdjUiVGRrJqXOxi1ykBgtmkMBpYKuIs7F
	Dgvci74cJd5a3D5GXyE/lCK1WQ/4z5AMOmiV9gQX/js0kTJCz9wvsU22yYnYuSCy4yXiid0Y4w3
	845BhjZi0Qly9lG2J/PbA9Gz7wQisGGwPgbx3gxtMw9VoFchtl8deA2BcW8YLqCcbZBWlZ65229
	KIgH9b3pzDVDL1ELPbTNHPHDsgLGIuynb9bYstpa69/gMXK6Ij90iaCAn/L6MX0pieYmSwd0F+1
	2wppYsH/UUuhuEXtMmWNo9zKqFTQta7ufLwKd5gMkShJTAGb9g0PGn5D+k5ZhXvvhTZoU22O7Ac
	aFXnU5ZSMSzFv2rher56NjGzlVAvrnOwFYY2KoTw2trWCrWSnEpT9saNOb7A1ZySwFtVZRdAt3D
	dVgU/s/QHfdozTfsYeJBxzWbfN8jejD7XwIqxsx0szeqmvS948eooi/sauWhWHmwy2EoQsJxY1h
	gUZbEIcJkTpCJrTGa3bL8bk5MKIehma++HSR6S3puYxDueBZJmEdYxYZ00jBu+E=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
