Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237622;
	b=VT82zZS/ZuP9His7fVZumgtY0COJjv0cTo7TGLZUI7do9MNhWP2M3L4g82vS9yjsJUYq
	 jxeAv+4wqUF7ZpAjnx2qWhqRnmb7tKm4AP+thUnHUeSZsKvWJ8rzLp4UAoPUEJl4BLNcT
	 cPGofJhHsKHmgcTS0fCcSSSxxuDdIjmHt40WGwppc2Gp06qh3mvlDezVhkvetrxV12Zcw
	 H0f6EYIT7D0U0mRVhinexfySf+CnvDyhVJmVzR0FmBJ+Pfvi7vtB/iaDDOJlpSdgeciHN
	 wa3eh0SOadyn/A0t1uUl6tp0+vwGX/JPJbJ3+cMW+5YlduVkRLw0RGxwDSpPrU2IuWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZbRXFrDPxo9TEgcFEs8CF+aBhAr2BLLBO84rzxJ4xgw=;
	b=i4HtGwpaXqQzJxIwqPS4LhsNW9wNfOj0tuc/gRGUd8TsA7EmZoOCr6T5hWek5FToIvC8
	 nDyBiHYU9WWoXOsQ+3pD/JYD8suHp3Z4u03pa07ZbBy9af6qDfhF+fQpWocoe5dKE7Y5p
	 TZVO0NeCSMXXKst8Ey6aP7TGTqfzUUI+8bTnM+4EZSC72C1huChgNHfA+dDH0tj++epz/
	 jpeUBZ5USdOeX0iBM6NRDBZ7IH3yNhoQUHW6hBuyZkrj+gs6VVzsZwZ9GvFOO0PH36Gkd
	 Da/eWsHoa5Q3I1oRaygQjTAtR88wuOv13XDSLKFaZc5SEhc7OrrQxSWQTjrhDGDEmkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fEDC5NNa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F3606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F33F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fEDC5NNa
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677af43eed4so1062456d50.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 07:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237621; cv=none;
        d=google.com; s=arc-20260327;
        b=AzCjk6p2NvjC0/fSN5dj36V2297D/p8m3ZfkX12/injPS4q7PvI7L57sXJ5Lxx5cYg
         iTRyB37zeGvzwtM+nkrMGPB2rzB9Oo3jDoKlJqC1qDcsREtkGTwaVbv1LfdrEYQMqwh0
         1rHrwvzolXFaqxZ3/jWQvyyeXJ0ywGUh7xpBiqLPerHVMtrAtu5G1Yvpr8vOUPcii7o/
         EPHlRxtam04q8UkVb1z1E1dzmerqpajgUzgDyjPRmCApnrGX+qb+DOdDIHLYdM/77Ezk
         AFdBOL0euCScc8OHBcOwTRMpG+F3XHSffpayIEQEkhs+iWbAs5rVnLKNEAz5deXBRd0x
         UZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZbRXFrDPxo9TEgcFEs8CF+aBhAr2BLLBO84rzxJ4xgw=;
        fh=XPfnPeS4wglRmelDXjWECDrUzh1HlzFzhPotAf04/Ag=;
        b=Tr63dfta/7HuuQFZRLMfuDHS48AUZvD6C+wYvFGyHkVVv/ExTuv/trSVOEIvFDzMfM
         q1jk2NijG1DZgwvuMrAA3y+d/fg1CrF5R5wXd4ABdMiyCacA8f1wfn88sv7VA/PgoGMs
         j6ZsM0yCfPPAi6f9WnErJUnc9nrirxFw8RBmy5XT3GCx1V6CRK5VJZUMO2pbOq8abMR3
         4zCw5Rct+8+blGzLVwli+P8LXpGY1zYTS+sgq+lq/4AXELFM1D6BmpTjy+QSqx4M/s1n
         4g6VnpHM/EBcAo7YqYkH9+32C3qnuBhwz9n5R9lTsEA3kZnzZo1y9E3SZp2XliWDtuLW
         aasQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237621; x=1794842421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZbRXFrDPxo9TEgcFEs8CF+aBhAr2BLLBO84rzxJ4xgw=;
        b=fEDC5NNaNm49WxPSl1qNuGutcwMpFtYIlKd0ff6HdNe6NwxLBe8UgUO3Slj1OqPrAe
         sdnE48VLC/BApi3D2K4tLHDSjaIJYh4boNakRg6d5LmkKjIDi1LQvXqJ1q/XFh7Ws29/
         s/Wgq2Rfb2pSJ2e6/v6cGfbi6EW13JBFB8324He5qvPLbc3X7f4M2BbkbzJQ9dO1VMfi
         NeiprTbA9FVAPiJCGc+UUk+68URhd0J/L0VTEtUWdtyQfL2iux7nuFW4CAV+R2svisgL
         WVbWmB+9lk00GOajVw6zMguUIHmUceY9AGSNK6adeUC1c7MR4gRL1h2HezPCqoCvayhy
         eVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237621; x=1794842421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbRXFrDPxo9TEgcFEs8CF+aBhAr2BLLBO84rzxJ4xgw=;
        b=BtM+bi1Q7AmR2wm250l93n2WkUPHRNbLwZCPNiYsQTTZsvJDceLrtALAnlnhg/PO5O
         sU8WGJy6gvFS8gYj/OdzRqZJcF6bW9StTSsKgFpD0GLv05zkaGHAhQWQaPrUa/BYuVQ/
         DvEsDFiOBVXihtn1Y3/+YZ3PmyP0xAVHhEAZyOgLoAeo3r6Nn5JnD1dTNzRyFhcbo3la
         AVsL+lCnG13mQa3Pm/yx+HL5acxIQ0Vo4mkw8BNDKmaRVFn1wOOXBQW01WqwNDrgljhG
         HVCgSM9dhPtIrUceW7oVwYTDBeIAzICbGQiR2RNYPpi2yCa+0i8Ar5vLkdj0rSAb7RGu
         sGuw==
X-Gm-Message-State: APuU4Z+Wngkn4Ky63UvmGam5egKSUO/4tyytrr0LOeXFGTkOUECiCiTW
	EINIypriLAgVBn3Irg9QcveCn6YI11qbr1UQrDHcvyOhw5b/re12YZjYkUkqsaQZE4QUjvArY4/
	wI3SMCjlw+WGh4CGFClnIKIyNZATLGL0Omn92
X-Gm-Gg: AYBFou2tBS//cwkdhI1BjtmjdRvHI6xF5W25AjsmS0HNOj5OpBmRgTzZRh6SiqS7vpR
	KAF07L1xkLTvIMsGzK9+58SDBh8pShas1a2jCr6ZYs9uEvogVjuwfajRxuoPh5Rw74J9+F/gnG5
	3kJZPlbHdO4qngC4tVs+P0EP1FmALJYWrR6HRvEz8lNK6YiaMYG5+2RjBnhb5s5p8fKgsnXfexf
	NKMoIuXGGHaVDL70kqw46+5ROTHFOzRrf0UBc6w41h9fDCC+P9/a9uwY0Rj3wSvGTOLVknmN94S
	4fOhRd5U6+5fkdLyKbjRQT/5ISyGHpGoDfdRoM/xevs02OBsK3kMiQgRmGY5fS69+E0FrOIg14W
	eQfmfLLVkpSRzXRt/Lkm9ESSqrlDk4SBNoD1jrWgBeWmeEErUBlVa5f6K+hcKOyP7Zq7xRjOtxo
	oqDeSUGTOTjdL6c8i+qBSAZGJAFEwOGxfU9ImV3MwWDeHHIRBJtlUrLR99FQ==
X-Received: by 2002:a05:690e:441c:b0:67c:608:b375 with SMTP id
 956f58d0204a3-67c3da7825dmr2017003d50.101.1794237620950; Mon, 09 Nov 2026
 07:20:20 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131652.267648-1-cgoettsche@seltendoof.de>
 <CAEjxPJ5GXUcUD58w3NeWqqTGPJirii-HHUR67pK+SEDv14Awgw@mail.gmail.com> <CAJ2a_Dc4hUqbQQGvUaAZzbmGn2HEk_4XoaaZRb_-3h5Ze3RNvw@mail.gmail.com>
In-Reply-To: <CAJ2a_Dc4hUqbQQGvUaAZzbmGn2HEk_4XoaaZRb_-3h5Ze3RNvw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 10:20:09 -0500
X-Gm-Features: AclHuK9NUk-CtLwwk5Dh1tdMoUKH4NM2fHr_jBhMye5_uTtqN1tjGkA5W-R_oC4
Message-ID: <CAEjxPJ6KQ_fC2omz-HtLCToghYW_i0KD_6bzgsXjnyArVic70A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: keep the uncompressed filename transition
 format for Xen
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 6 Nov 2026 at 21:16, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Nov 6, 2026 at 8:18=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Commit 890bc6bf ("libsepol,checkpolicy: update remaining policyvers
> > > comparisons to correctly handle Xen policies") restricted the
> > > uncompressed filename transition format to SELinux policies older tha=
n
> > > POLICYDB_VERSION_COMP_FTRANS. Xen policy versions are numbered
> > > separately and never gained the compressed format, so Xen policies ar=
e
> > > now read and written in the compressed format instead, which is
> > > incompatible with every earlier release. For example, a Xen v30 polic=
y
> > > with a named type transition written by checkpolicy 3.11 fails to loa=
d:
> > >
> > >     ebitmap: map size 4 does not match my size 64 (high bit was 8)
> > >
> > > and policies written now cannot be read by 3.11.
> > >
> > > Use the compressed format only for SELinux policies of version
> > > POLICYDB_VERSION_COMP_FTRANS or later, via a common helper for readin=
g
> > > and writing.
> > >
> > > Add a Xen v30 binary policy written by checkpolicy 3.11 to the
> > > checkpolicy tests and check that it is read correctly and that the sa=
me
> > > source compiles to an identical binary, as a roundtrip through a sing=
le
> > > implementation does not detect such format changes.
> > >
> > > Assisted-by: Claude:claude-5.5-opus
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > This breaks make check-format:
> > libsepol/src/private.h:53:36: error: code should be clang-formatted
> > [-Wclang-format-violations]
> > #define policydb_has_comp_ftrans(p)                       \
> >
> > Otherwise,
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > For this and other format-only issues, if you want me to reformat them
> > for you, let me know and I will do so.
>
> If its okay for you, it'll be great if you could reformat them before
> applying. I'll try to check for format issues before posting in the
> future.

Ok, will do. I'm also working through some CI breakage from your
patches, fixing as I go.
