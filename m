Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904114;
	b=oXHgWfpBvWW2UAZZqyP+1FyCWYryt1f8LRv85bGqKUakGN7QGEgBJCATid01BVd18iNO
	 QH9XcgnAux3CcMpi6Kd3O32DaQr6fBr3A4jLW/qITt2bMWwo7inyYf4GBf/YZMPC/Yqy/
	 WBPifeh/bwmt0CZFhLvGM0o4S8idsMPCsRcfiVtt8p4pfWYsqOY5i+yn2Ws91veUjymMV
	 jb+v9IOBYF4donlG/ka1h/aVSnD5tO56KzRB4DgZM1ZUsMcPr0LbwYjmO9MqJodI51ys/
	 f/F/v+9zQ7Jxkhcod4cAYztWVyWn3BnZn/M0vB1f4lIbO41ssEMFtX2ORZNjEPCsGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
	b=FQ3Byr84p7io0M70gP7Z4I84/AcrpDgcI2oTVxp7S6eYfuc3rQvbpIxsn8QdeUWDclHI
	 GjMEMwEvwQ6pACkfetnos8K8lVLIXy5yTG9eJ6/wYXv17O8Uphh7szjPdEviED0nGEGCS
	 B5KlpFr4xll/POc69BYTKq+7YVToUwsUPNmInVy2JeiJaXspvae1XtN+ZK/BGMLcOxQvt
	 Y5DT6hB69ZtRJQseEFXE95ItJCwuL5i1w0AhzmJuXmkKVziU0xdIczarNyBODJ7z+OEV9
	 5XYlcKu/2MqOJdl46/LZKOH8QxLilkPicqrGWpuG3U+jqWgFcdVRN0bdCGuru+hxv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="lDHE/E60";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCF60A260F
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DCF60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDHE/E60
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so27360695e9.3
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904108; x=1795508908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=lDHE/E60fAF7y/GcfWe7zssqpibfABjaDWc4DbPAbANFwY7mipSCQzk/tGna/Yk9Yp
         5M31Ja6Q4S90Eg4jWdoE2GH6TurYV9Y9Yxd6SoBGFySZlSGgcD3Nf8Ac20Morq/IEeLi
         HZNDCkpilOoqmPVEk/N5paMQG+RjNO9OhPzIDtVn6k+5pNMY8rSlnV+zGCrptyxwBw8i
         uHdMwH/Pby0zhrQLCKl2b6izfUmExSZrUoQCnWP4NFP78u9vhGGyVwUcvE3no1VAV9ln
         DDlxdlg3j7mlBLcF1wQFzdXfstbmRKgVspXMjOajtHMeg5NsSNAba7k+RMZ1HFntU+s+
         8A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904108; x=1795508908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=q61aFynggIVGhUxCFozEYak+afJVOfD45z3GJELaFj3np2oaCwQN9FW/ApukzimD6T
         /aBOuD5M902bFYLbo51Nwm8UyvUMEjHRWwFOF15HBLOT8JpIhou6byClzDa73gb0+BaD
         Df6h2bt1qvm4sxqhI8nOpF5hUZ6UbRsIb6Jbe/2RoK5NnLMXfODxcSPYeeHYCJOB20ha
         UsxsEUtM6QarLX6Fg6gF+sEFG3gXwli3IZs7BzO/pSWNeJh1EkS4eBIWNTboG2cztOmH
         e8RQYMv3igylApmppjNnFzOwFd8iLrb6GLmUBEsb7LpAKO3wPxgHt7t7WU+1RhZTQXtv
         lHDA==
X-Forwarded-Encrypted: i=1; AL+hErHh9kkDT6K9K4yN/nNkyiFbZs1z8UgUV7ed4Qz6RhTLFLqlRmrZPialvVQNLSYAeCGOs/WvMuyh@vger.kernel.org
X-Gm-Message-State: APuU4Z+BNATxJb4EEV0iFeR8hB8cTQXjHjcEzmVns62bsTL5v3gb4vWZ
	Jv5d6cJJp52LtWtb4o2y1XgPNLtsvXEfhlM03ba4ZUaholwbMYPwt4yWa/n5W54gXGJp
X-Gm-Gg: AYBFou3j67uM9+w2eEFm50Wb4byHPUzXPCsS06i7fqR3VrXJuFzn66lB0j12kW6TuLU
	ojakxJMUMyBYfXJObSF7EKaCQ7xZXuUYozhWqfPctY0fXMZl5tlUck0fLlOuEJn7OgqadtgQ0gq
	DGW8jpPVcz/2JyZVuykuLMNG57b3Hn5eGct7GVWzKvdyFptgo6VEvpJFxIoxHshmZA1PkR4TX2k
	RO4l9o55Q/R2nXZwkG4TfRazUjN9VZ1byZ92Yd3+Kfasq9yOTdYo94r1Tv4/TTs8rqJXVE+M8L7
	9281DqSAxj7GsrCqmsVwWBR0QXHawOePgK5ijap3qUc4S8tUxs9TN9zNrQxojNhBwuAeTC/HDlA
	og0caw81Ja5lLnoudBMg0chGeMYniiBeUbcj/M2rqgcg50MFmjYTpDLk+WnnxPvPVWXa5h6CNJX
	7xh7uZGLOV4zNeXHCUbmXhgl68PxxZli2dBq/WtI4Z6B3kNkDk8Z7u4ALQfR+ugESSszr02x+Sa
	xJAUWXT4oaR5IznfqNAQGukoOmGD12+yUOuFW23NyP7MN/LPZK0ivv/CjyPng5wYINZJhs9/Mhr
	nm8mRHo9KFkmBE3gtfdCk3vrBy+vAs4jQyl6RsDwYJlNzMImS8x4yJgkS6DLbIGriNe8nhV9IVv
	OeTB93nZD+FDRmse14EohLNZrK+lmR1R/CZJXK7JYotWdq4qn0U/H1pVL
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr255399085e9.5.1794904108278;
        Tue, 17 Nov 2026 00:28:28 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm75197335e9.10.2026.11.17.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:27 -0800 (PST)
Message-ID: <afc070a816e3ae5eb3c9e2d62d4f25c59ee61df2.camel@amutable.com>
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:28:26 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
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
> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/xen/xenfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 37ea7c5c03469..aba7d038ed735 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0
> =C2=A0#include <xen/xen.h>
> @@ -80,6 +81,7 @@ static const struct fs_context_operations
> xenfs_context_ops =3D {
> =C2=A0
> =C2=A0static int xenfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &xenfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
