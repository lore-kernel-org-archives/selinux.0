Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC623839A3
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432256; cv=pass; b=MB+CPzDmTW/fqWFAS79o06EXr/InKpZQw+D+QVO7FVJYeXk785dzW8gWAHrdSZz6Pns1RzbeZPrKq10PjWExbxSA4vzM+7FFAhDqXkKKVVoef9OvjZn4l6FF6ju+ncBtoa4PXE2+gwjcbhfQW0HxdmTfiFEZa/VYRLXOzhAlhjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432256; c=relaxed/simple;
	bh=Kr9YDqv1LpU4dAoe2cmtdNPyLsiJwt4x+ue0UZBPI30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYyIlvxQwCl2NNAOdoQ/xao0HuqcKAiFIgSj2Yd9uQcWzKXV9zUFR93m6PlMHCt+DZrukBhcLVMxrU/KOkIFAIQQNjezj3cSqxm6HDvzZxI7rcG0WuffNDV3gG8iyyuaNCxLw989dQTttRidSitXx3C60EPP+VBsdx6uIx0bLHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG0JJirS; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG0JJirS"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4563ac048f4so98048fac.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785432254; cv=none;
        d=google.com; s=arc-20260327;
        b=EBTOavUy3mXcGB+Z23Fyr35ETEEIcKa7d7UW7N4JoQob5xGHLPCjmze5zmJctiBDu9
         APs2d29jIqDt9ZBcHxyb+y94lZWYXUNnscnE8XTG4qJfFnPjkK9aNzKB3WaB/eh1QJbp
         EAyIYQBVYCoP629SYL5E/BBe4wdMXUq4qfGJZLvlfvvQCdfx83foBoadiqM9pvNCPjv4
         XOLsX4eUQbnmIda8XHp8wPxfsB/w0h2bQ6umSys3K7MxeIZXy8q1nahfp4Dwe90vhZtS
         AnIxGXsj6vN69sleDH2Kb1rLdQgNfSweVRZmraYMMik/hd2faxagtNnJp7pWqkiQ+Q2m
         JhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kr9YDqv1LpU4dAoe2cmtdNPyLsiJwt4x+ue0UZBPI30=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=l6wj0s80Hf/hGkQFGpUQ9sjmg4HWoO2j/j0aOL7nCLrbHLznU3col37M4GMYN8632e
         cUZUpaSYFmjvtqljNJ6sdDoU0LAeztvrW4UzkYxctUaX9J2k3Q3plseavU4uHUgoHbCi
         H1oTWmCEvKo3YXsmceDx4mcixrQvWWJxlJOHUKl+Pnct4QHLWUOJRtmt0TV8dA/n5Sd0
         PiZ+WhbetwK99JuivRhpoPIT1loaFDBYB9UuMw1Mpuk2E213jbPVB1uIeVer/tgUgFRg
         YrwVpBCtjnFiZWcvAtA/BMDm5g/nBVV3nTE/er347AhAAuFn10PH+SXX/eb26vZen/LO
         7VPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432254; x=1786037054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kr9YDqv1LpU4dAoe2cmtdNPyLsiJwt4x+ue0UZBPI30=;
        b=sG0JJirS+wKoorDj12s1n4yjPxnFNIk2TRzc2+muC8hswpJOHWE7zzrVq5zpvpGxJu
         AX9hIXqCHrYWbSdM1eSPubwk4K6rj2wN8kAYrebACZTaKUtr7QWBce7rkXdDFOfUWt/z
         7EDlFslaVe4kIz50mh4OYNV36TvpO6uwCwwJ6TTb/ibiCCAz2xbeA1mLiCprOUbFbMAX
         T5nqxrDevCb0VIQZy0Xz13fs4oKFWNvXlqmDVs5CtmtW12VS3oqWOPgeZW9F17BCKpYZ
         iW1XdUxiaBgTz6pUNhp5pB0QuhyE2yCnkz4KCjl458nmsAEaP1KBtddbqXCnvIzC14dn
         EatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432254; x=1786037054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kr9YDqv1LpU4dAoe2cmtdNPyLsiJwt4x+ue0UZBPI30=;
        b=Gi0NkgdsnOBReINBecjVVzVgROt4NTEmJC1uerEZko6ChVsvL0QIEav0dz6DYtG8qh
         hC6a9hLVijjU6CyvbR8t5UME1B9GHeE6sI2V0j9s9ViyPx3Gu8S6WkJVbT14ki89Xjmc
         N3vJowDAFWrG5RkcP8bKSxjguwhadgKhQoQaZafyciBBavlOHAw5WL74tb0EedwAzc13
         qs6LytUW18sytUcKBnSKndmdzbZFMSX2wuGyQHmijxVft8vz5GeCTjywCRU3KbCcY0IR
         jyqwqJoOdEp+OVG+HhmmeVcG+1TTKcfXEDtqe5ztcE0SWchlo8FkcEoUm4/bKCrn7j5i
         Xodg==
X-Gm-Message-State: AOJu0YxOUHmUhm6utDVy0F2pcbirXHKOmw4zRbKpDBXSnteKt5Bukpmo
	+duL5xs3sWYnvzdwC3L8v7a2MRGV9E/A1fxZ90mIU8Y5NVJ7kGOA0r2F5XPdwaYSUiR25VbJVSj
	pS+Mu53X7n5dQMQuiaTJKJR6abl0Hzn4=
X-Gm-Gg: AR+sD12uva/PETkoIRr060U7hn5BmnhlA0r0yweXqANgIry6pDcmYt1X5X1Gj4RY+8m
	ZAF6KAZtYFsVL1/0GW47tNQPaA1kz3U7TL3+mVhDpqDTNQESDg8eY8NS5vDzZRzlREwi387+LYJ
	oR7EW+9Ucw15uoou5G/fHtfoA03Gj86QT5FEON6GOc5za/1QwTuxst2uoD/KLRVzthYb6XPUWY2
	nBITUfb6aEv7LnvzBQY9VfnQ9o3g4awcDsph7gGgT1SZHtscG0TgcEwKl+mZPDs+Gd67LTJJc2G
	vqQcXPUprgNiwqWwx2AJAkZ72GjsifjVPEXza20KVPSs
X-Received: by 2002:a05:6870:a48a:b0:448:a0ba:1252 with SMTP id
 586e51a60fabf-458c1993f70mr2473599fac.26.1785432254266; Thu, 30 Jul 2026
 10:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730125712.29409-1-jwcart2@gmail.com>
In-Reply-To: <20260730125712.29409-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:24:03 -0400
X-Gm-Features: AUfX_mwylTKruKmlM31EKcRl7BFkzvGPSJ9Elo-gY7g-bfUst0UYIO-K0YzdeNM
Message-ID: <CAEjxPJ60TK=pWv2m-qP4kh1gjhLEyQzA6PEuoWhhY1rqtpLxMg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Turn assert into error in type_set_expand()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:57=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The assertion in function type_set_expand() can only be violated by
> a malformed policy. Since it is called before the policy has been
> validated just return an error.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
