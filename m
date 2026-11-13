Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565074;
	b=EBdCC2KLmu6nXo0d3H6Cw1failjou8ptDdP2o3gQ+lf2FWTGhs6sKyJwse77lCxhDnJR
	 I6x4SZgJM06mOaerqYR6RFKvwmHcIcgtbOhV8sZxSN4nhW0/xdTpOfBsx6VHfPMC8+1nx
	 GmocXtkTAXNK2MpOGoHFgX9TvAxYOErEubGLpIQFehP5M+tkhXtopC9Y+MqPxsjrIRDy6
	 seZD+u2wy6KCGRqRxfdlcYrPNfZpTr6qnsGWvdgP5m8HYgbvmjmjbEqxDOB/oxmtUf4WM
	 WZk02nOHYdnxhrvNuUQqkkLKxaaLWgeu1CW8QjW1TT9ZIXBjYwySMXxlUOdhCb9EPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	b=c8fACrDN1d/RQjY+VqNH4wH2oo5LjgA6kNVDdzDhcGjIuaZG5p6WL55Po1UloR2GaqdJ
	 IJNUCnx0OaGah/MuOtL6BgHodlPOGkOuG1ycnEq6QvM5wTEC4zoOA4AbHGgf+BQke1mXk
	 PLnrogLeYcYHN3Ze0QfXVkNBgcXzMXbigFaPKfKnvXctiIDdxqgla+JRkVLt+lsOOrARL
	 wkhoGEtkmQkH+gFIORhcrR0zGxd+KpvkhPwerW+B8Gz/svOmeRJODrXSY049BlaYDxfHA
	 s2d2B2pvn6IAunt9pcKRzMuijo+mFh5I8Ki8T733t4b8RLL4qhnAFpgmIVOal9Ypj6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E7606A88D
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722E7606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13807595e9.2
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=hEEG7fG6RzQkOoGSL66zkn+hWpy0b8TxpW+CxGFBwGxbhLfdgmFqwESmbjaY7MScGa
         1TTEC4ZDzMo/nTmQbATUq4OC5CVK8FiegRjrCOceUr+V68t+3IyOPEhrmauT/typpuMH
         7BtZ7bLX9twnpc3pST7EzNdPnkg3BFhqHXhYG5RTwPNXEKUOMAEYxir+CLBCGEbp4xnq
         ot2tG8XA7sYEn5cZCga4RcL6w3I4tCQX2A1rGgTmCQohN7lvb4NCOhavzOt0i7fRXz7K
         0fiOYrUI/s1Mo3f+qCL5v2ciULr5WU1WUhy3OFmgCMCM2mU4bZM+JgAT1J65gELN03wt
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=P3UmfcXoMCtp0KQYqRdCxo4dtyp4LltoI2wzcXpC4oPMzrjCb64TqEaLXjYLprJl+n
         XwlGfdBG8KOtroPB0pC5C2kG6ZWRzsxlIHyPr8+dqqRE3ejezG62oSNvyPWdgDE8mrTY
         okkCmG8aJJy+AFsvJcjD/jJU5NEh17QbMY+CWFJGGZg1oYUEJpEpqlBqVhMCCkZ98PcG
         S4ZtGIK1J0P8nbx17O607y0BF1/cKif78nz9ishJfK7HpQ4SBv8rPxOgHBIHFCybIGW9
         jbbJ7uC4opgX68/1+3rtA85MInAJ1QPi+S4mU9dOeA2uUNWEvPei/Pg0FBi6SzHZejfM
         3I6A==
X-Forwarded-Encrypted: i=1; AL+hErG+H0ZMXBQOBcX7nx5tXmPy8TvTWJU4WUPd5c0XlMgjOTRufM+gWfC7jL9LlsrTFroTT9H92oQM@vger.kernel.org
X-Gm-Message-State: APuU4Z8/BX2uVxOOU2fGUn5rLwfRx0bMi/Oc47VjbXwttGG98xvqRZtt
	ELq9WquKriOP/RDfABzjkxE1geMBiinKQUwJ9rmp+zhwwooUD/FVl1mZOIGSwFzwhMC6
X-Gm-Gg: AYBFou3be/tOBnlknkPsrnqjkOGXxDCWR6UP/RY0EujcthwynjHH92+XbItlCAOC10N
	diyr2Iw4Q8/34JiMzJvOYpgiFqQ5HRL98ZBDFV1P9xqGwmvNNpwKzF6wCI6ka3q+2fqGpR2Olu0
	B91VHgiKi6kDUxd3cb2DL2jij9zCZAu9iugXPjt5rJYcmIOEZk2D0sfksTajdSgj4Dhgr5mZ8q+
	kO7hbr/k/yuycsQzrAXH/JVLXjW5aEOQKiAbpmRTkhOR/kA7aUmqWeTYB1q7beTIbjoXChKaWnB
	nkXlrdISwCAT6rSpsJe+mQa8GCNuNAIDJMJxN7KJNroX9JlXrmOtanQYtvBevoPLJcNKMkegl60
	I402co5dfl379NteHUJRQNYmRDDeFfVdORzSLYE8OLQUep14AvKyK+o9ryH+oVrdooUFgR4s8GI
	65bTX0PA/vdFlsamEjD/ZFlZX3f97GCNLUtBScE+glT3LQzMYQp24prmCGL0AUBCsngNYey0L3d
	kCfyfmuL4MJNq/LAakfCpDcrImwnxGn98aKdayRN816EkiKjG6z94lA8KY3RWbJOTPnPOkPbplN
	c+Ig4zoTzZwbHGyF71XXrHNQNG20yTpbG+0tsPswGu4OG3zL2cPj+tdDVEXL8hY=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
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
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
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
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)
