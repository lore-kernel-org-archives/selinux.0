Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564336;
	b=ZH9eRAtsvBUpx81Av3RZvDu7avpNz3kEaznanBZGDWhZdoVx+3JE89kAgJfvQAeyEOiF
	 QoT0YxPDp+4iGQBBYvMyfuW6Cl5++HYS4OlS6Fw3vKYUyWLC7T4LrvjLbIrOIvKkJ6fu5
	 +ObEs+pSctYnNx+yNEtTtfMl7WKSACgkUXVthAh8hyZXCRVhe+Qg5d11NLWCZGEgr3LH3
	 8eCAFqZ68RbcO1h7cirxNaP0u21FlB21JTrRjkdOfkDPlbPLBaHCdvlEvE/TnzBph0KGN
	 43x4DJR8uRaNWdbV+uz/SgVLTSDMbz34LGlUQ01IQuiMLpCJOOwjEOOd6GTES/c9tzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=lFmCdoTYYzw2NDmw16jXmY21ZiabRd9L4Ogu2hchAWVTs71R+o2Vw1F4D4/PwQtXpMrj
	 NJLGsqBpq185r4ZepOVX2cNB6+5AJ1AchBIiV4JWOZ5wSEAjp48slvQ+2tLgXvTEiHMNq
	 Ew9gkWe/Ex197DNL0K1+0Y/CIhae4GclaQdRYK7xvTUYxqfOgKsA2c8aMLG/GpvDADFWx
	 8PZFabEd5d2/PojqX279ktSq4nvwNY6LjsmQjo0bYr5GznKPwqxXHeNU8xrKjjXFPgCw0
	 WicXUJLCBHMh/gtmjb3UxXnndeXG0PH210G/uZpeXzi49rWo7qYtU5bWkTRmgdzwV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28D606A8B0
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F28D606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so1381262a12.3
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564335; x=1795169135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=nUCLd8f0G/K2fMNIytq9u2LWpw8l5XbCSUxsIs6+S5nVG1T3fI5ErIjnpvRMTRJ1g3
         66+hupjWTQxex7ntfQ08B69tN3G7DYFzu+MIzI3GxWcQnqgZu7yay01l+4mpEhy0Ef02
         xbNHIv/PH0KitW7ZH+pZK/qyW26JriIVV4HRgFAXvls3DDajVpT9R5cy9rfpfJ9qOhH/
         quuiU6KaH+bd+1MNp1oe0tS5lHpOu5FifqraRZhGcQQrLcBdrSt8hi6RHYJpJDDneT+2
         609Jb+e8BW/fqMWXfEgOdGZ8nZZS6I2LapQ01HWyupMw/vLrZIn5Q4gffAveGLQARYQM
         rrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564335; x=1795169135;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=WOgp0k36N9oXEI5VUBLDYKtpk5JY8qcnCM3H2XATYbPpbLFYHy6/MUI/lP6aod5qsL
         sP+LXDfAtIFbtq6vxG2h3dOQhi23CV3e2vkCi1VuM1zq6sznCankqQydCNWomrez/nkd
         OYjVYrMsYacGZecboG5rUxmGgiZE6I8FszLCsLO4PtWvhj+LsiIlDd7Rna9b6bNd3ouZ
         xzbdLEdm3/VcZn8HSivgMgC5YMJSjau3rTDg1lJJLq4yEYm0VQjWccWGCht7SdFj5N3r
         wjETG3mOb6UsiRYWbC1yQGZBE3m+SqhvbmN7OFFyzQwVdzPMkC0U5KZAp1aDluo2tPuP
         IBnA==
X-Forwarded-Encrypted: i=1; AL+hErFGGVPCFoUaJ2+RS82IrD1xDKoxdFd8H+ODp416hZ3GC3lCXo6OL+dFosmYPdTZOMsHFn/ZqzkD@vger.kernel.org
X-Gm-Message-State: APuU4Z84THBYrSiTyNmomIN+QKGXUEs6ISF6AaQQmBzuQPyMIQZtPMC1
	lGspujNqG7Y7yHryqrGDD+/kF896iph2QPwpwBZH/IJ2+SIcjUKSQVN7CWMZKdWj8UM0MasD1Du
	ua9hd+HF9Oks=
X-Gm-Gg: AYBFou0Cx5Uirt/e+WiN3fDQIgfsQUP6zJ9m4NEqW5M4LeLgk4HkHFH6sRtouJ0QCKF
	XKISvKlW9sjxsb3p3hTrQIWRlOQiANOeZDJZ7/Ekes5JDTu+dRb0PlBRCHxeJ9HQs9PC6JqReZP
	Rg0Epr/aYfb8IDcy5AZZtz2RyEDG6OjG2KFzZM0gPpIOT2CkhyKrmCYWZz2PXfOjzpCxR1PvuW8
	Hkag0RAUKXzHt3CxMqQpDJpmfVSXvBHY58yrZK3cmh8av1TftxHho+BkbZXBiS8SjV+Mle0kjQt
	ygyjTSxcjlXdHdqJhzWWLFPLjkJc+SsLU92YQGShBYCiKmTBD/I/GHsAXGEJyPFcdZn4HSSP6FT
	Tc650XlYhiA+L5nX3PpA7evSKsmq9YfVcounpuD6u9ex8MLnHtZJq+moqoPUkK01TDT9Y7HmJAM
	i8h+3cJBoOBXFbBhbEiU/CEiag5mIu1NsDh0CP9aaAxjosGKI2YYM/VWeyvLSpLnnCI4KBGcmvC
	mKW1oB9IvKg2HkkdJMTsRmDUPv89yPD716+sy80MWNA4PfpShlSOU/a5i3lf3VqiFtUAvxaqMVC
	Mf8kq7I4ItNNp+4AkIRA6rH8TEKTfvqcmGNU6jOnnFrKdVtoGu8WXIGiCigQJglNxpa974WePfe
	6suvPM6Uq
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}
