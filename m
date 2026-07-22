Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CB1448E0
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730560; cv=pass; b=UJ3AC2q25g/CRFr4+uw3gozypklzAaZPlhbvVlTqqZ9trc8PVq3FwlSgKwXEGMP5a8TFtK0yhLJYCVyFhsaCLu8WP7EPiwLwqBVMfZxQVeB82f3gd3IAijhToGakTxcfync8j053pmYftrGpFfXQVxmg74BYra0+e7zWlHDlCo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730560; c=relaxed/simple;
	bh=1wNMElBo+AliEYpZFgBJN4pFdLNVkIwBbEXel7MQLb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx98j41wX3CQXWtoIXfOLFXvmEFP0ciyoSLRzmtEEmCAI8tmmhG58kfzSC8FuNpGLUzeZxbHgGsI8gqPuQW6lPN+OclsfsqSGpXgnsfI/khcdS/7y83JgHVCH/fTQxlVjcs/WaYZofihuf+3IzjNRPVPYTTYuXmPWH9DYW9lEQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W10GSPcz; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W10GSPcz"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso3980789a12.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 07:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784730558; cv=none;
        d=google.com; s=arc-20260327;
        b=RSAD3KWZG5NCMDWTBdmjrWEFSqHHLUj5ZkAs55OpvhOgPIbLTjvTQH+BebovZhEzA+
         TKJcEo7eZ4GcPWpnb23VC4eXMoxU6EsrgA/wT0o95H717lrMdH05Oq4CCqe8PO/Xste3
         r2mmqWrrKiWDe2POgpLcqjchH4dMSPj7wADXwDRKYwxAbajidIxFLfvm4vHWWn3SvoME
         z8fJg0asG+56eMJf0AZPJafIQZYIPurNrr4XsV3Tjv+TKGxef+uYtmxVCgdpspCrwpbo
         ai4Om9Zn0iQanxcEmPIIkFObZcqJUP/iIrCw0mGgk07GJioJgMJCMdwfCf7Ot02VseGR
         Pz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5lc8RCxKLaF2IzHjUyNtx29wO+xOlWK+b6lz8l7LenM=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=iJuheyrnA17mhtRCAUTjsn7y81xnFaAePBWldrlw2v3MLi1rOlf0DLArcKMl8XZeEx
         8dirELJE/PwI4x3SU6Y8B5C5LeWfsB6iWBNJBZ7O0ol9n4HedueYscwDqUTj5uUfRHJH
         vdYibVgtmeU3A4zvbPwHzXu3HtFSNBve4YHX7TmSxq8e07OCgqtJ/fURVV98JvsV6f4i
         HCWzs3IaLBI8Ep5kXDHv2/mu/oGx46yuuUDgERzZkdVAPF8zXg9uf8uReL1+x1DgNPZS
         V1gZI7bVvsvSEOHH09ILbSsXqfFjYsmxm3jYpRAR1VoBEdYU7Q7xtU0D4PPF0p+pkk2e
         5JIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784730558; x=1785335358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5lc8RCxKLaF2IzHjUyNtx29wO+xOlWK+b6lz8l7LenM=;
        b=W10GSPcz7K7rH/Em+IQd1yZEkHMUcj8SM5gR4RhUb3X+u+DmWuyBebeLe9KiyHsys1
         4hlEcPeoxkc16F9yu49PK3aLgdmOqGnqA21wa5RNfCPajAtItSM5fSxJlMgQaXCxNXWL
         bOICXyoYfYblAok06jeNbIDueNkPu6XvjBQbADKKa7P+J761yYUJTi4wBhpEPLsy9DDH
         2AJ8PN2zubtsJ/fECqvZtq0Hr+NrrhpFGX8AzuZmBO84q4D/dKcIQ/fRyE6UXQ69UwFA
         F8on8HX4QXRibE8p/OlDitSK6o6E4nKTBmV5bdSHiftPtf9DHaekgp2tFv8F0cFbdMMz
         pm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730558; x=1785335358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lc8RCxKLaF2IzHjUyNtx29wO+xOlWK+b6lz8l7LenM=;
        b=M2h/OpJhJXDt2vlF1+u39odZzHcrXqDmRpjdRU2KmKMNcMPrNGBUSCle48IGXvtGwX
         Hw+jhD2R0aYksssawz46BOURFF0c++hcm8qMujOSqCDe3mxOkkyHUZNx1XMcFJSCsDj0
         zoiWOlgyxRlHdlj4IiW3UdgnxeAAc5zGIPYWQMe8+nxnxgsA94L/CTny3cQf1JRv6WFH
         w7PLH//l2xWXq6arWCajMCHLNoSCx0zyFfEqeJPqVPlB/eRtxZclPeuwpyE9KVWDfPoW
         qjSX2UaQHmW75VOVySnBFqsz7JRhaHiI+M6wsWzFpL8lckIKVbXEecixBI2W1haKfeS8
         tQpA==
X-Gm-Message-State: AOJu0YwonxbYLe/rgNmeUyyeJSmQMDuQO3IoYGjFIDdcdD9x3ctWEnr4
	SCZw8BG3JCUt9zye1mW1J8ZfTr7ujsDDW7Rz1cTApSa1zfaTEF4BjKgaSnUyidrh0Lb7VWAoY13
	RY7on1d45xjP3PDyfmR3GdVsJyWWN2UjYTw==
X-Gm-Gg: AR+sD13j8Nf10RdY5GUEJvEQuCUEiuoOBhx2bs5h8Z5+cC+i2hMk5MjMk7N+tQwohYa
	IO1Jrf+PYjr1Cw2FQ3f2WoAbvpkj/C6XYKkYd98xQut26Aj++Clt+nBvMgyFG93ETMTRhdHzNvt
	wC2UgaxdFmzrUI+IevlypVxpEwfvQ8xxpIH3EqgrXdkt1VyrJ5Sh9goH/5iBG0dR7izjoUMdDuS
	G2XDD5PWHISeUO9C5ob38ax6jrVpvAVBARoQ6CCrkeCc8Wu7e74kgKOPLzGig==
X-Received: by 2002:a05:6a21:d83:b0:3c4:3750:2c03 with SMTP id
 adf61e73a8af0-3c437502cd4mr2577071637.9.1784730558032; Wed, 22 Jul 2026
 07:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <al8eYnGraP-hoCCm@suse.com>
In-Reply-To: <al8eYnGraP-hoCCm@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Jul 2026 10:29:06 -0400
X-Gm-Features: AUfX_mz7_cB8sjw-VasSuQ4_J5UM3rMERqJlZEHOTRnMURDztDAbW2byKDW9d0s
Message-ID: <CAEjxPJ5-WxJou91SZZf0L-B0LmsToqgdq9OupgY4w1UX4QvgxA@mail.gmail.com>
Subject: Re: [PATCH] selinux(8): note on conflicting configurations
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:23=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> setting SELINUX=3Ddisabled while having selinux=3D1
> results in a non-booting system. Document this
> here in a note
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>

The patch is fine but wondering if we want to change the libselinux
behavior in this situation.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/man/man8/selinux.8 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.=
8
> index 5842150b..17df2a99 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -50,6 +50,15 @@ regardless of what is set in the
>  .I /etc/selinux/config
>  file.
>
> +.B NOTE:
> +When setting a conflicting configuration like
> +.B SELINUX=3Ddisabled
> +in
> +.I /etc/selinux/config
> +while having
> +.B selinux=3D1
> +on the kernel boot options will result in a non-bootable system.
> +
>  The
>  .I /etc/selinux/config
>  configuration file also controls what policy
> --
> 2.55.0
