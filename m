Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65137F8C6
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206232; cv=pass; b=V+nFkZC19+660jyPtndS3nYDk7NvQGckaEV4b05lsvq37I/QiQqYUe1PzP1I1sZAHgkDrECygvnvKH6/PG5V86iN2mzaKQex6mpadWXF4foHjEcb2qjv9g8Nfn0wLOIdGN0+XRa8IupThMb1Ey0K8pg8MoyVS2lekCygChQpkbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206232; c=relaxed/simple;
	bh=IjtnkB/EjhUZayfBlnuBGZmgmJCsSQNhjoAEaS0MLKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hre8VKqvGKzTZQ+7+vyTTGsfHZwnyCBdEiuxiQXuDWREQmThHSdnzrhH85C8VlKbpGnerY1GSwz8srU4XgctEsCic/hY0OGFdF2I8GZcOnUpFZ4kU8kcAj4NpFOy2NFRGa+uF0WxZrcBzkt42yJtlF9+ect5n9m9Vgf3oU8eLK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct7lK+9M; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct7lK+9M"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44856d185bcso87444fac.3
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788206229; cv=none;
        d=google.com; s=arc-20260327;
        b=cO3sNJKx0OHMXZuF5EvpOaw2Zecyd3Fy3qQN4NPIuUFEUortHAXbCZD+LCW7Wc+bbb
         uOurVN62UVI3EbIKHAFZBlY6qicRF7RhNm5PQ2EV64CqTXQxxLbneP1HJVlJsdYh3eJ3
         6l+S7xZ/ApgXEgpTrQS7V2T1j2KOVyuHDe+P5OF5l3Mq6+FIjPtDiALvr4FNllJaAfrc
         yX+ktq03Jj2vYMjQ/OS9urdmDIap9ZVqfG6DHK+j/xII2coWyWXpd8AXU06A7OvxX8wc
         lNv9btU+y5gP+ndKEwlNkEWTOm1u+Vn1lRG+H/WlF0HQ2Wb9O/tHYg7ah9QNzUGUEbm5
         V8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LcJkTm3NYSx1vhffD5/xYywbpnMkZEkNmKLb/Rb9D2c=;
        fh=43c1+sXWJQ/ASgEoyxdWG3Zjh+rBTlpIXPMYS4Yp/D4=;
        b=A1dONHrngR2lvhrMuT2sBSpUZJEnqdv7OYSSEnzQFARfJDqcIi9WzfIynJt8vx3HX/
         6TBSG2ebrO3D70jCcEd8DoXUz0NFbsvt5q26ZRzwOXd8OLnmE1l1wnnDht4vwkyvW+K4
         8cy45iEofLehpaKN87Cp6sQK0Z/bzL/pS6NhWcZCeSwTau7LYBdA4WV3JaSH6eDP5pDs
         y/UNMb4g8ZAPmvbhGzYiRc71YvIGvnIOpbuDR1U35eTCnWZhCmKXmjoaBI6jPx5ZKn/h
         m7yytWw6M/VF1mek7HIUVytQiY8JGbWPfMckIAcN2PCYzHRJTsivU+45g62LAvYVycw1
         8Igg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206229; x=1788811029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LcJkTm3NYSx1vhffD5/xYywbpnMkZEkNmKLb/Rb9D2c=;
        b=Ct7lK+9M0FmYSzbGIhantch9TLcmW/dxhmJ4N6POwo//R9RDgI2yygM3aRTaMGbu50
         hN8tQ8GuawwzG70BiA/rx73rMgp89ya1Rfr9xmY42bSomNxLPQ8sJpyachBpv4Xm8hOB
         7yCh2CzV4evmb7yR31xoCfkCwENHKLyS6KCSRqFE566pmB4cYMa1vvO9nLJgg9D37xnZ
         g7h0xK/bdozMXRjdOCn4jAAxEnaHouiCKBc7wG9lPZ29RnzUebgMo38G9+BzTlHlryGk
         Dd86oQme7yv4x9iRxexShS8YVxtvQhq4Oty+CW+WzC2sekV4QcbxRLi9ek5ZJhdJ8EyZ
         atKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206229; x=1788811029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcJkTm3NYSx1vhffD5/xYywbpnMkZEkNmKLb/Rb9D2c=;
        b=bXNQDnaIVisHXfqI3UvJ/py7OL+KmVrOljsyDMnl3rD6/RYjg+RTXpMBdUhfHIl1/z
         qbi9ElFUoTQ8Iwwa6zr+q963/Ol5z4Cdehb8D6NPG3lcENiDY2bjQz/lUwWpTCjBbC60
         ibbCYYWI7hQVHNzZdnp+shqhLSmlxERmtCmR6JhNneHtN2sbo/ZLGdaM5DQRx308WeT3
         Bf5z+Fk1bYQiMR0DcQlssI4NUhQUJKjEvufWWVBxEnx6iwWcDA8a77X23tn9JI0/XN8g
         hCL6jktsZIbHTxwzkgcWBQVdNoeZJzVY1asMfJOm5khHilOgJgOxCsW943EI9wyquBq4
         LWaA==
X-Gm-Message-State: AFuF++llIeBBHVT5QcsIhKC+i+4Ybp33P+kKySmq2PWXiuFOMB6mWKoc
	zqLa9zXakeWFPmWPYJdjgSSGIR4ZTT9bB/a/gYCJBnZXwtjXQ0gL8Q+DD9mO9U5RJOn2vd+Pf6G
	x7X/759Eao6j6Pq55TprNvsaZKFVvkGVkpw==
X-Gm-Gg: AR+sD12ATPPkaL09X+Bv4BBRTvD9i/2VlXifEwcg27fbVAltCIp/Mr/xpFYF2O72leS
	+tDlW29OM/cXh++DFnMHAgfoF2wA8sYWWxOQmd1y6tzMfm1D44qfZ2+NqfGUKrFUGBTezXU5YYj
	QIcnkvCIEMzQWIEbwsLKd8DxBP2dsoEnw0pTrpA6q76Zll3GAAMR/uLgIQVGVA2AlRtFd3ntALZ
	BtSdgj898p9WwIruIjPS/s2aBmoEutXKJCJGRpQkfDGdchDW3ZK2yPpn713m4GOhO5MVx80nKlq
	VcaYnTeS0jn+WgH/2Zq3UmXucbKlOMFKWPtmpGSh/2W5
X-Received: by 2002:a05:6870:6b05:b0:459:8f4e:94f2 with SMTP id
 586e51a60fabf-4683702c55fmr32731743fac.10.1788206229582; Mon, 31 Aug 2026
 12:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com> <w4OjP80sRkGXeAp6-RIM3g@coker.com.au>
In-Reply-To: <w4OjP80sRkGXeAp6-RIM3g@coker.com.au>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 15:56:58 -0400
X-Gm-Features: AcwNN1X4z__NfQmN_ebuObDsvp82vUSSujGn-2fEkIedmxK4A40YZy4W8-cyutY
Message-ID: <CAEjxPJ47k-v5DpYFSHiUZT-OH3CA7udCxyU_UJzFJzxNMJ4bNg@mail.gmail.com>
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
To: russell@coker.com.au
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com, paul@paul-moore.com, 
	Johannes Segitz <jsegitz@suse.de>, Cathy Hu <cahu@suse.de>, Laurent Bigonville <bigon@debian.org>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 3:51=E2=80=AFPM Russell Coker <russell@coker.com.au=
> wrote:
>
> On Tuesday, 1 September 2026 04:01:05 AEST Stephen Smalley wrote:
> > This would break e.g. RHEL 7, Debian 9, Ubuntu 16.04, or SUSE/SLES 12
> > if they ever updated to a version of libsepol with this change but I
> > think that's unlikely.
>
> I have no interest in Debian 9.  If someone wants to update a Debian 9 sy=
stem
> to a current version of libsepol I'm not bothered if it breaks totally.
>
> > The greater risk is if you have any lingering binary modules compiled
> > with versions < 18 inherited across multiple upgrades (e.g. RHEL-7 to
> > RHEL-8), then those modules will break and probably in a not-very-nice
> > way (libsepol suddenly won't be able to parse them and therefore any
> > semodule/semanage operations will fail and you might have to delete
> > them manually from the policy module store).
>
> Binary modules aren't something I'm interested in for Debian.  Just don't=
 use
> modules unless you have the .te file.
>
> > I'm fine with deferring this change to a future libsepol release after
> > 3.12 (e.g. 3.13 or later) if that would be safer for the distros.
>
> I don't think there's a reason to delay.
>
> Also last I checked the current git refpolicy compiled with the recent
> libsepol etc causes a kernel panic on the Debian 13 kernels.  So if we do=
n't
> get that fixed then the Debian 14 kernel will be required for any sort of=
 new
> policy.

Can you provide more details about that please?
