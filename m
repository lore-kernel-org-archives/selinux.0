Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF3164BB
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821549; cv=pass; b=VgQBh+kDOZKtLWfJVt9nE9URD6ESsqjaeVsVicqVRY6CTpeUdf8GOCzGHB+Bs5ltnIrbGKKu190nML/UvimEpqIv20KUsjDB0lqJcUURRZd3IWD5+8az1CLd2pceQl8fQFxK8Vy3htcZD/JkV0kXSP9DoLfrWgMfYGVA89ljgsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821549; c=relaxed/simple;
	bh=xauAVDrNEqxXuQQDfkuXjcLzA9iR5d/8KDCLj8SlAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDltHPvMioGoQDdjwGqQvGWchvZkN/V8ydBjc7aNjWscTi97C5s3IpgsADXDD7Wns9A3KGgsOGGilDyaiDM22JepMNZ7jDkN4QyzjyO2R2qF7cZF8SyP5gvwWE5UfJ6PoxegRDIU6It4DKZ9Ne3Q14bfyRKsz+9tbe2o7I8Vzuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HllqAs+/; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HllqAs+/"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b884ad1026cso429821566b.2
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 17:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769821546; cv=none;
        d=google.com; s=arc-20240605;
        b=bfkHyuPh/GWxCnXSVj1rgks3Ze6KkHCExq+dKi1azzfViaDfN2B1wDYY6AVlecsB7G
         pqCpOw22ZzRBPo0dTd8FnJZM5J3NGVSEQT0J9vg3/bEPmUTQlqQWFyYYLB+kG+gAqDMW
         uUB+NDb+0rpVPNpoM/rufQuY213HQwnZQb0mx1F77TBSk86ESaZgC6FBwgibBkFLr4UO
         ycilTvZYQ+7TflfIKWMpy7ICinB7b5pMubUPt6pMTEBhwUPF1zluz1AH0FPTPYrZFDuy
         HoMEJRlyUQF0B1nwKcHtKBo1jCPbMvInRawkNSnjzRFj6dQVWnBEoFPyNHUZdWaKhaR0
         11+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        fh=a8unZEgRDGSc/RdYooNPefoHlckOFPC/+N1yQgRa2SQ=;
        b=BZWF7egbmAXMRCr5rQLCF5WOt4lwz2XvmKwi1U72FIkAdqp7hukoQ5Z4QFZAILtAUw
         nLBDkZ3sOJIzSiDgX9WlJoa1KNi14K39nYniJEZFuEVHEpJSFqaBPiA0pHwv3lki4pD0
         bcW/ESa4YUXwoIfKhpbMWME+EEJRs+Hza3QJUyPBewrilyflAYBsAfTCNEvwW8AUFX5d
         Aq4kw0RWbIAJ7Pa2BzQEZY/StiBACt2g0sryck8GDsbI+iSBgX/gSIpofHEJD2uatdH3
         dVFhUY30YttE1lK1+ZPXIk8jPgZQk4hqYFIc5Csi9Ud6dwdsxbLQEzyK1zGqpwhf+Ad1
         1igQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769821546; x=1770426346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=HllqAs+/IWHE2+kQ9ii8b5Gtko1h7Ik70Pwl45FY+prbj2XSVoNyELK+flYSa2NQo8
         EXfzD6mw0oX/ZlcIu3rfD3gSpUvxACQGYIH/Tl36lScTzSqGPf7KX8gtg3w/jdI+zaqh
         b70RFAKtyAAsDtS1eh60MRioJEW4g53yrxfS3kn8JvPA1T8gyDJ3TbalXssoUOVJkQbB
         jvGjJObfMMQbMdMBdGn+zwg4BMNPdymUx9VX9d4oC/MnBUwn5iYrXwM6DX/OcGYm3wZH
         /zCPYr3iPl0vH84xBlQRUFtR3PnsqszdSt7W3HzHNo81Di8s17L3tMFO2MgvOo+9Qs0Y
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821546; x=1770426346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=iACwIA2GBwdTlNBDiXkBPutLHvdf6SDiR1r/hvSYsoOdI849OTjU9TzxOn+17vHZA7
         mx9FzYpcGe6nyvoTsPu8HLhVq8NMFhKC9a3/cedtDanyuS/RacRDUkMhADP0jBzTyNFb
         4OFHV3RINjX/XubWsxfKvVgfnltT3ywBa5FInfq74LL0FwCLxdEa/xDgyGBgCjM/DXMT
         a9DRDer4CrOlaw4L3sZxwax5l7rUj4UWXj3YddDhyRHyc+UdtswnvDsF6Z7VYxFz8WJ4
         rQi/SwpSetgwk8ycJy+Aug7nqBGdg6je2hfjh7MYmW0QFlR0ojqC8sM0F5aYytceSY3B
         jloA==
X-Forwarded-Encrypted: i=1; AJvYcCWVjsnexlD54vgp5Mccz6Q0DI50mQnGbRGktE9Qw+hQipCqj7gFGSXG5nDDRoa6XBN+ZHI05n6k@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNYOil/b2eu9KvIF2eABBKDsq/UvQ/VZS0rZOeS+eViI3zdbU
	X/wNN+1zgely18qVcN1T73XBIZ4hVbEu4Q1UG+2dQwirAPMA3xyXL2XWowl3wqOdo7WbfiJXdNr
	dMBN+R985rE4lA8hfR1w8JpvHdzGh49dGWk26JO9Z
X-Gm-Gg: AZuq6aLZmaLgL6tZ0IkTJMxw/rj2YlRmgISC2ansIeLIfvZTJD9/Xcdqv8JzPoSpqKI
	D7cu94XQu80eqv63iShKDgS7T0qomMTRnvTw7EF/Y+q44/XMFCZThA2yqHcq4RRlPKo/uCcqbTd
	xvp24YVN0DrG7vW/t8i+mOWxLp9RM8JOXlwRplQgM3zPVIE6kl4yBNLTR1FsnQW/374JeweLD6F
	x20Zra8kUQHIMqb0cB8guHaLelAHz27zpQWL095COmvRrfOu9DsfIUToB6F2rKmsm8OON9iZ157
	/3U=
X-Received: by 2002:a17:907:3e0d:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b8dff696c0fmr254282166b.31.1769821545900; Fri, 30 Jan 2026
 17:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 17:05:34 -0800
X-Gm-Features: AZwV_Qi-TVApb-UR_yhUuzDZcqy8acCYfKVdTsorIhJOL99wmGwpM0Som40uK5A
Message-ID: <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> So we have something that does O_NDELAY opens of ep0 *and* does not retry=
 on
> EAGAIN?
>
> How lovely...  Could you slap
>         WARN_ON(ret =3D=3D -EAGAIN);
> right before that
>         if (ret < 0)
>                 return ret;

Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs with
this addition.

> in there and see which process is doing that?  Regression is a regression=
,
> odd userland or not, but I would like to see what is that userland actual=
ly
> trying to do there.
>
> *grumble*
>
> IMO at that point we have two problems - one is how to avoid a revert of =
the
> tail of tree-in-dcache series, another is how to deal with quite real
> preexisting bugs in functionfs.
>
> Another thing to try (not as a suggestion of a fix, just an attempt to fi=
gure
> out how badly would the things break): in current mainline replace that
>         ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
> in ffs_ep0_open() with
>         ffs_mutex_lock(&ffs->mutex, false)
> and see how badly do the things regress for userland.  Again, I'm not say=
ing
> that this is a fix - just trying to get some sense of what's the userland
> is doing.

Ergo this didn't make a difference either.
