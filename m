Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10B3E8684
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073096; cv=pass; b=Z+zY+d48lNotCdAsEApJY3xx2KaiMoAjoT/dE1ctgKsqUyjXiqD9QOm8CrGaWH9acKEmlL2tIQuKYUdvqSGPVwI81hsomz39uwaj7ywUg3MIik/rxb3+BQOABrioRQBJes03PygXmyxQCkv1JVeWH6bd5t50FnDLMxbyZ3JBGho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073096; c=relaxed/simple;
	bh=jB2hlfp5POBIHKtEq9V5A09do6WD3mIE7rm/g74+h8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0gq0TS/QK82/aZ8PvM3uQiFNZ8tk4mXU6oifJVRocomOFcmw8O1ywWLbmIQkA+Gg/lZWIPcdq2oX1DKYK1+PX3HyMkXsaS4iIe5n4mPnsyaeXPcXMKAx+ezqhGW8Rvoyg8T1DMrCNkktkr7t/7n94r528nTygUpDv/5uRPyvs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5J+50CN; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5J+50CN"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67990a45e02so1820142d50.3
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073094; cv=none;
        d=google.com; s=arc-20260327;
        b=C8besc2syyqCW3G22+sIw1OngXiaFxREPd/DxRZYXCUbyEv7yWyENQbPxscKWCzbVt
         WdFYY776JhGdaqbHw4NgPwlOPr+RkwyRFQPpaOtZffQ5HPkwUbPNVIoFBTgggRnSzkt7
         4rO6u91U5SWj2fCn4PKjfNuLpJg5k26UNLbBr1AeYqbtln1nHIwqrM1hfljdiNUBAeAc
         rtgD3PVRte1pCgtWPq8S6wrx59zF0xKEtH34Hic9w1c8yngAsoE5ZaI90mpPzmiBtxvx
         tEUbhykY5tuTGsfEgvJKF1V6uw0gwslq6kvTwWXE5X5iFZtVIHxzTEsd9lvBZLQZB4Zg
         6SsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jB2hlfp5POBIHKtEq9V5A09do6WD3mIE7rm/g74+h8Q=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=a+sbd6fcwKolEi5/x33eqgUyhQs6o4B2CIAVo7QRzt2nMQgw6TpBYS3DACUcvgEzII
         hwcmNlsc8haUGjN5dwBa8NEAu1py+/xZrRPiCnTm1EZQoHniSHw0Be2dq230XzFxmh+2
         VhiMBH1W8a+PFttQMYbxcMu5c8LWBwP1iVZyEWQmQfdkDXQoFuKPulR4hXtx3dK8SHK4
         mILEq1pga+5EBDAv0EbqVvvmSiMXxLhevAettIW+hESMy2QJuzHop7okHhdbu4gO6BWh
         xwmtfIYje3mZa7SWFFdfLrzgY4x9HPy0YuebLTDFJvu37SrA1gfAg8WJgZIHftbdTnNQ
         3gFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073094; x=1792677894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jB2hlfp5POBIHKtEq9V5A09do6WD3mIE7rm/g74+h8Q=;
        b=A5J+50CNUbDxUY341EsYOd70n0LcVwaFfucyfyNoev4LdzVSYc5mSSsqlZFzsdzZq4
         PK6PZiebxHJ2a1IW7/iv38pNJRInf+/+2kXY0uNa/2l8nDsB1IU+WYMhMQhWedp4N2ED
         G5E2hnV6yyMcFjLo+A1UpU5fzrrpW22H33qH7P9xccy+VuFeTcI98++1nj+jWqPFmnmy
         VudJmpwD305r1YgOkT31KZW4BTz08bh8OqnZktskH1nS6F4PqGRVj/EHJVWEdDHib+e9
         6lS/Yh6EavY4raTuxfHXMYkxsHHh1CMCtxFskubCVLpTtNOCQr0ywIqivIeTxSQDJQva
         3w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073094; x=1792677894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jB2hlfp5POBIHKtEq9V5A09do6WD3mIE7rm/g74+h8Q=;
        b=s1am5kTS/G8pzPvq3Jk8QlcQiK17SzKaZmzanvg5alzIQ1zz82cDkmwYwcRZW3AdAs
         j5VYCKvHv5QE71DprVzLWtDcvtxpb8PyTWm61yj489I9M9nlwAz6fZUqr/SrlPR+ba8t
         xRxK6H9vu9BFgVRW2MwLNpYxMxBa2gKy8GMiBVKd34fqTniI3QLCGJfG40Oo4YAnIdsj
         l0LHpyX18WY+JFWcg/1GEyb3iEUTrd1CByb4RzAcTWpMLXwTLSSqMr7rWtiQiLnZ14mh
         VWNgROk1CQzX7hDc+ftnsqpJRcGXWuBfcgbo0XYpEUKQc5c50VlItwt8W/RP61z3XbJ+
         LS9w==
X-Gm-Message-State: AFq9FYJ8RkzZD2Rd/v7RPRcerYRy91fm5nMxTfwOougyAxqLGwbm6LAO
	3PTCAEHUdnLGmuVjOdATwCVPMdlJSlOBj8GOMZQ0bXERC1i90JTwE3rOtB9R05LDQJd18dvX5fn
	7l9QFXL93e/v/Rr/V7/CUegiPbFJRiOQ=
X-Gm-Gg: AYBFou13fdk08UHT93n4kmY4S7zpdWs/gCqGUrvYVYlp7u+mjx6OtPR+uVVBl4wcGtc
	vd+BI1TCEhlCcp8bCJHhy1aSiewIqZCtAGd9g2uFYB78DHKSzqy+8n67wcOidquXfVBc27uVj8h
	1yzrBJ5IaRX0H5IOGiJky6JyUcFaueGU3Od0VYEp6cJjTEM4xJRfXeNru4w7d1M55MKFN818PBk
	yAePcYW+ZfrbVPu8ajQObCNelVggMkNR65qlWNkEDh8r7XYiCOFd9zVlhXVF32wPxW/TOsD3wWi
	IbrObJEOt2XdlfibqELDUmdNjMjuePsCOLBkTLQ7k1xk9MpGp5VSnIQAS0Tq9kkcPQ==
X-Received: by 2002:a05:690e:408e:b0:672:db9b:2d1d with SMTP id
 956f58d0204a3-67936984139mr8749653d50.36.1792073094259; Thu, 15 Oct 2026
 07:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015014457.877322-2-tmz@pobox.com>
In-Reply-To: <20261015014457.877322-2-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:04:43 -0400
X-Gm-Features: AclHuK9okb-rf-8sRG7BbpRQSMK_FSQoy47vCcZl-bRFo6nopogaN5qPw7ccGaE
Message-ID: <CAEjxPJ5wNpL28BVaW8AAXXgv8SfOpWSGtUMzd7=xXvoYEoxfQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: add -r option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:46=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> The -r option was added in 50f0910c (libselinux: add support for pcre2,
> 2016-09-15), initially to "Include precompiled regular expressions in
> the output" and updated in 36df3755 (libselinux: sefcontext_compile
> invert semantics of "-r" flag, 2016-09-28) to exclude precompiled
> regular expressions.
>
> The man page was not updated for either commit, leaving this option
> documented only the usage string.

only _in_ the usage string. (missing word)

>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Your patch is correct but it would be better if it also corrected the
SYNOPSIS section to show -i -r -V.
The usage() synopsis line in sefcontext_compile.c similarly only shows [-iV=
].
