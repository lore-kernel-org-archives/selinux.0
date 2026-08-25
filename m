Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2528C840
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662324; cv=pass; b=miugm3R73LiqyYizTatDsyfYLf3eqxDmpFq/iiPE709QUG9vh5T8xALQiBpaWmNzW18+N9RKWROfFaEZnDG02ZnU7VFb3+Th+wKtpokVuIE1ugQC42QvcNEewGDkafngE84T/wW/Ibzs7x3zu7DX9wtFl80KOR19ghQPBLQHoes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662324; c=relaxed/simple;
	bh=q4eIGkuZlCwkvzqaVv4itEOGNtg13Us6yigFtaQuKPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDG+/jSuEoHm6ZfdQXiXSZ2Rf24+dfqBpBbeRs3Mavw0drNjEKHVoBVf7QcJ9/LjY8EwH8wsmo8fC1qn1mG48YcQPyVACvd5XdTKLK4VNNxZfl8oKrQWksp7UMMgBxqnE9Ie/+YSKotKGZEYwrPhgELmGEW+1GGgSaKG9pbHots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krjnHq6Z; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krjnHq6Z"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-459281bc13bso3404528fac.2
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 05:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662318; cv=none;
        d=google.com; s=arc-20260327;
        b=bPQ9Om7UwpfO+f4+MOAm9cSJyBRuNCCIV81KvsUfai96iCMUTBTplIoMFDTnc6hBk6
         Yd1KLjCly2FHFUAavUHVbxQLgdRzmCbiNDcWv/AAgXANeaMoOaDkkHCSYcLJVcCWYNYI
         1Hnw/CFVB7rqEAgJSWWa4i/eQ6Mak0UeguCrLQwDdZab7y3Znq3zTuk+Y9v2qLv0Yqsx
         np9PrfB5ScINqAJ2uoFktf0K9pXiJPS7Hlk732mW7xVtiC8MRo2rknL297Bdd5+QfGGx
         mUpG+LAh6ia7psWORzlOHK3RsLrnQgiHNURou+NIyLEOJXZ7ZTZ6edJuwfunEMYM+mc/
         H7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q4eIGkuZlCwkvzqaVv4itEOGNtg13Us6yigFtaQuKPw=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=JXNXS254XhSRtZQ03bZLYOBF51CjqC7DODjUNwmL1gizjK69zAYW+rF9m0reLJ6HiK
         fz+OkWtofgefNaTV3n10Ws5Z/xTtmCPKx6hTNYJqulQbYyz7GUmRQc4VYCe7NzKS6HDW
         3+oJQgODJ4jaPGUcZQ4DpXcf6Z5JYov+HGIv41s7z3M9vjRfEDWaO7AFN8HCGmVnH26s
         6Rx5p+pivTaD3PZSkdw3x5SYGfPdFsAxVYz6Dc7FJSsUe1Jistfrx0C/1CCHFvDshGIu
         J1ihxXZZ4aUCAbznE5yk2eoqDdttNXw5Ux1dvs/2tAFC0KSkHppmzl0GkHmgMQisGkzg
         5blw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787662318; x=1788267118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q4eIGkuZlCwkvzqaVv4itEOGNtg13Us6yigFtaQuKPw=;
        b=krjnHq6ZgNeWkC0NKLgb3kRIg2dqqAiaL8UVGEP9Eh35ypZ2yQj+VadNpGe51G17Eb
         QhsKWElYnZ6bzZGwuPe6aDBt04xWto4ykFli6B+0PGNvyIpPzDnN0QyeSxK8nd6Naqha
         6BUVmwfVKRJPcjLDU2vY2/nsq8TjvGrBJneH2Tt3ktRwLSeVM5cAEkbtAsh4ElDjBI79
         012nmVPAs3AXotruOi9ODRpJpTA8yBCVehwLd8D3Zzx/MeauDkppRFSlYpLOJtmashpB
         zwWjwtWdPr0z5n3y6/94r1wB9zK7LOBb6YUGdtT4zOcupdnmIrKhGdBijUBBWTWATJO0
         tSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662318; x=1788267118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4eIGkuZlCwkvzqaVv4itEOGNtg13Us6yigFtaQuKPw=;
        b=mtYRfLE3wCKeusQvcJhlWuhtoqVqG8xuJqVZwKx0i0QMxuBXsMeKnpnkzDIKB9djt2
         qjR1UmfBcR70UVlCd7gGjTcF6iypgB+Abb/DECLuMR/kT6yL3sWSVEUSs8D1DD1gscDT
         X2UdG4GqVfAMrWtRQHrUlWQbw0lmlMu6/9imdaBSVaTh1c17G5SgzZO9zY/ySevJTQhV
         jR3Cs4LEY/Ya0X1mrs8SBFKHQ5i8RnTdP4umymBhy7WKWDb3yoKmv5Akbiz3C+uz/ze2
         KToLbb/dJPBswX+4jyFpKFN7bOnfnBiKeDpJTPRzU5hYCdD/34pZCMVw4MS8g/uQHnhg
         QvSQ==
X-Gm-Message-State: AFuF++nzAPpboNaCXKKUe7CAiQD4kxxbfG0Qvx4d8tpye/Dc6r1Zox5P
	K6mnNHv3haeVf6kxaKZRWshFltdlqss/EKdlmaPCTtoFZeowlM7UtbWP6KX9EaWEK/cYfu9vUBb
	TKbY8jYzl6yWJRxEYyN5JwEoR+umo+kcZt4T9
X-Gm-Gg: AR+sD12eZ7/asoiDX82MrOh0a2z2Kjvbb58Rz3NEcV2BIWvWruly4kxtb/9hMbWi6tf
	z2o68vOaWKrD3R+95jcauRxhgiCZxuhN25zXbV1pgdRgfuJzX+XRr07YTGkDzXpm+jZh88I/Pda
	QgS9iumvRLk9U9jq/zM+9GZfLBBIb5Nv3AZhjl/HGobSwTzU3HfyWgflY+8vuyDaihl68yLPNUO
	jJsayuSwUi//4XHEKl72RlZJJTN0zxFW4W1mmOQnQYEH0PDdV5Y9A42c1tT/M3p/jotP8qfH7Zi
	aBmguu2Qy0EvQBYIFWMYyew7+hsgldDrpz+Usqk3jaeH
X-Received: by 2002:a05:6871:781c:b0:45f:4ee:e7c8 with SMTP id
 586e51a60fabf-4644b576d47mr5654137fac.18.1787662317829; Tue, 25 Aug 2026
 05:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824182133.75452-2-stephen.smalley.work@gmail.com> <CAEjxPJ7Lu56ZgdnoyrZPGivk6pNx7CwQtSSuySAaSMKswSP19Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Lu56ZgdnoyrZPGivk6pNx7CwQtSSuySAaSMKswSP19Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 08:51:46 -0400
X-Gm-Features: AcwNN1XwLrUanQfgCEheBF8Pi7-cCF2VHOImId4yGV7PI8v-1BvH5SnUI9pw6SU
Message-ID: <CAEjxPJ7E7NmmXEEP7VfwtPRQxnj5Q78kb3acV+KPdBzuntsy+g@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy-fuzzer: do not abort on invalid policies or
 other errors during conversion
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 24, 2026 at 2:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The purpose of the fuzzer is to detect crashes on the fuzzer inputs,
> > not to detect invalid policies or other conversion errors.
> > checkpolicy itself does not call policydb_validate() before writing
> > the binary policy, so an error at that point is not a checkpolicy
> > failure.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This was motivated by https://issues.oss-fuzz.com/issues/550672317
> > which is aborting on policydb_validate() error. I am not entirely
> > clear on exactly how that is happening but I don't think it is
> > what we want from the fuzzer.
>
> NAK'ing my own patch - we likely need to figure out why
> policydb_validate() is failing here and maybe checkpolicy,
> checkmodule, and secilc should all be calling it?

Root cause for this oss-fuzz report found and fixed via:
https://lore.kernel.org/selinux/20260825124629.84128-1-stephen.smalley.work=
@gmail.com/T/#u
