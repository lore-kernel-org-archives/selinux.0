Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1632386C0A
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035418; cv=pass; b=XN7ORmxT201j6hhsVt5QnDtrohG3h9yGm+iVuJeeIgQt8zgEYLA75ee0jV3V24dvJVYD/aqctxkBHQgJ5oeDIM/73zdxJdVx23CLb/1muB3dHiAUSlSqd5OaSz75HfnvQ7J2zmJzemRNMr1Oww10daWHbPy6EiM8UnBK3dpsAfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035418; c=relaxed/simple;
	bh=9tOwQqIAdyjghJMjTm6oUIxKO9dFwJzcIPT3HUguBcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3FnLjxx5EwuhrtLiEsQOY4RF8mtPX/qEEPwe9fylK4tSBbaWlJ3g7/dYf1dYyiWqB9bKMwICxk9W9y0oCcZF71YEt7Otw8mTExM/pDk8KtADM1wcizANyCLQVJa/aTt4mhEyYlwTY/C2w8Eu/vU+nTQtPc5x0m5wIAwP5vsiVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYaHFPEh; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYaHFPEh"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4560d6f82edso1605591fac.3
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 09:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786035413; cv=none;
        d=google.com; s=arc-20260327;
        b=eWFGGBxS37XTmhQXVNIm75QKun5L5GwJB6ckqHkf1SWzob57LiUDZ9PsU4rWa5hR6k
         wR4wMBRzyFdh2SoyY+0NoeyWRC7z0520gjTVV+O0iFR8Io4uEbjaYJsP7BcUCN6pU9w0
         nIJMv0HxX5KkS/OCp1aGyEH8C09uBZU4rqBxS4swU9e7d1ki6fZ0Rw//UfW9fUL1G/2g
         /gtCcO6+TryIm8JTRKNzDBvhrpkIQoexz2wY/gCGjhExDel1vZYKDeYcxxnKOzYIYyH0
         OAFXq+aPvuifth6nxqnX0YUKbIvEOvM5gB4BXtmrykslRkNJeqwTeozTog4LXZ6SOGW3
         aPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9tOwQqIAdyjghJMjTm6oUIxKO9dFwJzcIPT3HUguBcg=;
        fh=hHxFmmuaOLzT2FSSyyQP8hIOa5fDwpRUH/2LlLaXh+E=;
        b=qYQXZOkOY3f+tNfmOA4aAj3mk6sp52wSwFi4SiphF5vyWkP10Can9i8MZr8T3ur2yV
         i8K9omuKRg1xiaH6bbBKm9UqeJpSI5B9hmHr3FqQZSyQtSPiCVGO5l/4WW9qZ9JHcS1o
         n3jox+V43Do+5w6bzY5fB/BWTPpkrBAVKuoSHD2qPh13nraS9LXDUFymg9aDmJhAMYV6
         BnRPA39zaECtVirfDHETOOtMOB7eP2oAWw1H6gzlzZGQIJ9EbC3abvl5eLS8Cz4XiW2j
         zg32LV+OfBkWHdlNMWgLkeXBbh5CFPUQyI18jljC4hvB9NPdQnuFLyYe9bLGa5h3aEjF
         MTrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035413; x=1786640213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9tOwQqIAdyjghJMjTm6oUIxKO9dFwJzcIPT3HUguBcg=;
        b=kYaHFPEhFuLRslM6vaEXNLgh5VGjW+EsTr5Ixaj9XJgHanuxQdHgRBNt0xJXXNSfR/
         pr14Nazu4oKXQN+z1zkBWRtqnrOu2/oS42EGM8k4OgN99rKFEEKvIZMooMXciBS233Ct
         P7L2l9MmSpPAOFejkVsKYBRYdrkxI6bL+l4whahPkswVZlPDIJppFuxzJeyBpqfp1k7O
         A6H6BXh3L71ZNPE8ZSylaTLNqU99kiRPR3+Xtwpw75E2hL1E/YfZXist0/fVnhGxEMio
         fuLIbethlQijX6YN3uVgysYoFxH7f/ZQID5P47MePympSMv17++dHOexDraWBrZ4ExJU
         KPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035413; x=1786640213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tOwQqIAdyjghJMjTm6oUIxKO9dFwJzcIPT3HUguBcg=;
        b=fpXLZWC/pb1biPNJfqfUKm9DwynAazGWrUa80UdDZbrMpxoNaCLafdyh8k1K749N1r
         JAK2okvrXK9EkS2QcqA3Updi1d8Ksk07IehrIsACJb56XrsArHdGE65zkCn7UZvpOgAI
         Bezvy8HUo8i0AQwN2sKVpLt9CPUQTB+HjZxuFUvMoi162ziHshPFax5rxaeqDb9QGC7/
         UEwRl8H2dxpjKmOqVYsXX9DAlVuVyBfcZs0Q+NArwCRv+mW/LgYnmZwCXdk6dVHpBtOz
         puKfnYbG9vHdiGJFjd2T+F7Jsd9Svs6Q6qrMipaT2N0PCyUpMDctZEobOFoLG4ceihTu
         YY5g==
X-Gm-Message-State: AOJu0Yw8lgMWp4gLaxYJGPXSn+IfKXZivjzXJ9ra4QByBMWutyk47ILx
	g9OOakGOeDcVFUvpzF9ch1z15KMFv3AoPKw76wWdpfvlcjnEQOZrnVV2LZZKJa7qztBuayyTWdr
	WjR9GiKnTSlwQ/OeORHWBFrjZjbNHw9Q=
X-Gm-Gg: AR+sD11CXQoNbAOvwTZg6k7CLuUNZYIAYw0hEuKxH1YyPu21PQ4aolvc3A75P902eVu
	I2tEY0/0TKiwQPlRObppJT6ypPT4hqtq2zBr8nOXRipqo8rfLkk2Q9e6b/c0kdAMztof3dyP7vI
	g5nE3durF106KlPH5cb0EVEc4wlbCVcdq1m0IXreVwKotK0Rjwnhyn/jU7FXmMpEQvIQmAn9exq
	4HMWaRqXqWUdRLOxClVTF0JC7tAS7I26wHZGWo9AA0FngqaPVMVheP+oQWKZMVO3uf+ZCrZ9EC5
	FbBEhoAZWuhkFrmsHEhg2a4j3+8/yOb3nDBQJfDSUyUu
X-Received: by 2002:a05:6871:60f:b0:448:9052:f436 with SMTP id
 586e51a60fabf-4599eb81df6mr8367067fac.8.1786035413206; Thu, 06 Aug 2026
 09:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805191438.77935-2-stephen.smalley.work@gmail.com> <CAP+JOzTTwarKFCiaOmKfcT+M6V_uShJuD3EMfNCWNgfxcsDLag@mail.gmail.com>
In-Reply-To: <CAP+JOzTTwarKFCiaOmKfcT+M6V_uShJuD3EMfNCWNgfxcsDLag@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 6 Aug 2026 12:56:41 -0400
X-Gm-Features: AUfX_mx_l2R_w_u4JcvgLNVLtmJbDTDvmBgRs3VZf9frTm2pKzXQ_zH-SvZqOhI
Message-ID: <CAEjxPJ6oRxoS7Gm3uFN-gGerPpmV1MPxb6jCcHfgTKGkq0YASw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol,checkpolicy: drop support for kernel policy
 versions < 24
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Chen Gong <reister@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:29=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 5, 2026 at 3:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Given the recently reported bugs in libsepol's support for policy
> > versions 20 through 23, let's drop support for kernel policy versions
> > < 24. This also aligns the minimum SELinux kernel policy version with
> > the minimum Xen policy version. This makes libsepol's minimum
> > supported kernel version v2.6.28 which is older than the v3.0 minimum
> > we already set for libselinux.
> >
> > Reported-by: Chen Gong <reister@ruc.edu.cn>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
