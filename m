Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793991558;
	b=A7C1eL0HwLyyy3F6EfUvgqz5AqCdfDigxQduC8OalOjyDVQF7vu6fbeLvVgjmJcCbDBC
	 r4uGa4LY/ypkCBpVe1r57267te7iqgTFVceYz8+0ZwoDLHM+0y0RWqKp0oapSp8hOfxrB
	 xbfQix84JL+rBiK58ScAT/y25axbMbsCanGCS9N0AVC5E0vgCeCASInbzEtUod1KT/y3I
	 7waUqQCGQiSv9D0ci8HHBElHtqG+otEEuO6SJL7oWWhzBRzqsdttpL+VloI36CNOmiR82
	 7cHTglBBiahmysSlEy5vJmHiWMdPCfPCGfDuBUGgMe0KW0SfQjGKPMSZIoAkTU/ieVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VT7U086FAyyxJagU81xSbe18PzpTKwvgipIZuJgNvjw=;
	b=WWvIKzxxxa58WrpaDAgZpuWwclDt7NPdlMlJ+tCW/uyuU3t7V/R6CQUB8KHoyU03TNUs
	 VDQALcsEqQBXXusN1iz+FCILxxT6WFF+MYnfu2h4S+iSaF8mIjiIaT4ETNyVyFbLRgyFA
	 Vipb36PR0hwLSYM+TzBYNrlDZTFAKslTO07zXk6tI3YrzuqGmVlyH9tFLWujwblYNPVHk
	 W1EEEpUx4wJiimNhUkBaYiXy7uvudg6P1kaGQ8HGcEBnFcnl8scjDsmpDFQgcwv5ZwTSv
	 PxVnQG9nafjo73cQOh5yR7LrVnJt5snA4R/SYWvqLOqhGn1ZkUwB4mD0Jo/LAYZw9iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfWqrn1D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A5606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8A5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfWqrn1D
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b306bbff8eso7617607b3.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991557; cv=none;
        d=google.com; s=arc-20260327;
        b=ePWd9iOCm3eDSYLuHPNjT68H/0n/yqHFz/humczF9zdx3rm2ohWVmvvkYxIdgepa4O
         7Icj6HyWUzCV7KIeTBvNpDtvboKZ69bQi4SfTQ04iRfE5sG/PJhv0kKA9JfYnI7FtF1c
         olcarHcehtv1AyfnW2PCQYbJ+Ciy+1DBXSYkxgFLl77QwPBd9jvqPIXYMmbN8LvxVuxP
         M/gtauXBGw3pNEDRKHzhnLmHt6yP3LT2MlSw1TBabqnh6xVOxPPZbERSrK7EaKuUgjC+
         G0M/lr3NK0q0D2ENShwLLYpVO56dcJkRk42N9byYBQynaeN3evOGQOJjhU6yaGlemNZE
         Q8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VT7U086FAyyxJagU81xSbe18PzpTKwvgipIZuJgNvjw=;
        fh=QAvOFrmPUxZXEuEsq/ts+MLRTgn2+9f8G/gjiCUTzH0=;
        b=Gb8oUHXvxPALllNC4nDa+EroJ9t8OdloFqi+9V9DCFSxDlzoCqHGZ18dufjaav7UJo
         IpnVPpi0mPfuWaSf5FySVVUmpQ0o3fY9RtCFuFXnZJJTPlDA81i1Tfmv9b9MbTbyCri2
         h1C1/7CBpNq6eU/LBK0PdffiRWWYqNjl4GxTBUYweN72nOdT8S7giYcVPwGIN6Z/8OHa
         mgo9i6/CZAA/Q7/8DNk2mOpmjSZZEO3RIUz1zI3+JQY/61APSZSmQPbVJ0/VT8GZqNC7
         33sjgmXMhj1H+QAtwkOtaCtsF15/qNqKAlOcbcDmHcO20ABHXzCw4gt8mnrnWRWSgtr6
         pLOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991557; x=1794596357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VT7U086FAyyxJagU81xSbe18PzpTKwvgipIZuJgNvjw=;
        b=hfWqrn1DTKFjA+P4pYjKiaSl1gCXosSK2ZraVc8DB8eiWLi6pzM0DBgwsn3s8txkh+
         g2L4kW2iH9BupMKEXmHZ4nKBbgx14gdo7kWBqeagbjxx/21/k2uz095aaJgFXY/b6qw8
         +NIySU/J74jc5OXr3awdHrgcQf7PuIGbVf3da7rlqYSwaehA8ix3laT1HDxg1JVuoRJn
         3hstbqX/xOxYPbHIpVwPrue/LIgRL2MXTyMEmKyORPCWTz/Dhteg3Zw1cu7bLp4mkW0f
         zOou53BkoqsY9fKP31ramfFhniJ1RTFrOSKsm8PFQtROpYV1khpCNLmWdNHrkUOGOfl7
         JyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991557; x=1794596357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VT7U086FAyyxJagU81xSbe18PzpTKwvgipIZuJgNvjw=;
        b=AXaScDp4joF05kqhE19dkj6MWc8EQy+OHbXjfsaDmDRPMxjGI3GvmXAZotfF4AGFsO
         h1i1TG15JsTUdK5gmtZ6qgnipsHjq+3/ifmBKI9fMv2wR6+WYe0D5XhHXqcwLLEtf6/g
         eFBPioYn0/iGLvEVjPsj7YGMmuFmV/HHLAOyvJDpxVPLo+qwhYm5C13IX60jOhUdV5j6
         MQhIgFu5Ot/AMVbccAj1dOmiHJTwB55295NV1oP5BWhTJOLdz9/TqwZoXO4eCp31nPY0
         denogMOjD717DYzHBOxoSk2WWI8UxQb+nlNNFffRjhSgFiUqpaARRgUUIWzXBvDSu9cF
         uMwA==
X-Gm-Message-State: APuU4Z/xRLdKf4u92iteSyPJzUBIzozvD1sUjnMzbmwWQIPCMSIHrKr7
	+J6YHPV298UKDkKIzjfZeDs10FrGh4HiiEqOHPSXit7A/dBzp4yGPLVx6gaRfifIHAcVlvBdM9a
	di3TPtHf0fi8r7Z4qPO4pSwbeXckSzXh6zsa9
X-Gm-Gg: AYBFou2X9HICk21J/9PvFjSHRL0N0InSNOKzzr2glCvZXZbcXCRQEusIpC0qNDj6+vw
	WaXG5P1ioz5GLixrDwV9h2+nT6Kesftpjfsa/3DoorlEan4mUlKFLSHMaGYMhrzqnHdbSYLvsZd
	6kMTwDFwXSq8BumuLNZHMxaszE3S2D93gPKIqk8OL5ER3uBQGGs4j0h+dpjx3U+I+azg/vvvVd+
	wd6k+hZIYNly5exzVUj7UiJ7+4/1n/QAxOWf18Z4FNBNGh879bSi5kxOypMQ5gthFmb/Pf5jE1m
	gYLC2bdj81aZ1lTD5QZ4FfuVHuR9jbwaPl9ucpYEMehaf+ZV/+p0Fhhq8C0MeNIiMaprFdXbKLl
	tzWYVciznVHvfca84m1Ma994c4NsQ/HqQ0QhZLzDSEL4V5CWqCLqH98Ll0W6IylkC/MlXeehLUH
	eQKF6+Kscb3YuwhCMG5degVoBdZYt8GKhu2v971ILUAlmn3CfTJhPVfNDUIw==
X-Received: by 2002:a05:690e:12cd:b0:677:d759:3949 with SMTP id
 956f58d0204a3-67c1440e34dmr1682562d50.65.1793991556531; Fri, 06 Nov 2026
 10:59:16 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106155955.199062-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261106155955.199062-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 13:59:05 -0500
X-Gm-Features: AclHuK8_L-wlSaY2uL7WOmyXTm4jtJwtSW1vx8htxIcSba0xxgsr3zt1wjYPCgU
Message-ID: <CAEjxPJ6J8tc2P9b0iG9HVyu0bPE7e3g7XGKWG5ULRPuVFR=vUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: fix permission value collision when linking
 an undeclared class
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Asif Nadaf <postasif@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Asif Nadaf <postasif@protonmail.com>
>
> permission_copy_callback() assigns a newly-added permission's
> access-vector bit from dest_class->permissions.nprim + 1, but never
> increments nprim afterward (unlike the class-level case a few lines
> above in class_copy_callback, which correctly does
> ++(state->base->p_classes.nprim)). If a single module requires two or
> more different permissions of an object class that is declared nowhere
> (only ever required), every one of those permissions is assigned the
> same access-vector bit.
>
> Confirmed with a real checkmodule-compiled module linked via
> link_modules(): before this fix, two distinct required permissions on
> an undeclared class both get s.value =3D=3D 1. With the fix they get
> distinct values (1 and 2).
>
> This defect is currently inert: a class that is only ever required and
> never declared can never satisfy is_id_enabled()'s SCOPE_DECL check, so
> any decl needing this path either fails link_modules() outright (if the
> require is mandatory) or has its block disabled by enable_avrules() and
> is then rejected by expand_module()'s "class vanished" check (if the
> require is optional). No currently-reachable code path lets the
> collision reach a policy that successfully builds. Fixing it anyway
> since it is a real latent defect that other, unrelated validation
> currently happens to mask.
>
> Signed-off-by: Asif Nadaf <postasif@protonmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
