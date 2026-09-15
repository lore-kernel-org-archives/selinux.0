Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BD36AB5A
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481461; cv=pass; b=UzfzrmkUcxkonMt7bUmCqc+7Sm4+CVGBcoVTKkPi1QTUYqu5UkPVw/jKDRsodQ1QHPF3kTvjQ+uTO8ujwTjm+gEIJD9nBkNm7LVHOLvc95cWbQwam3DohlU6/kg7pBVJrZPR1PYg7FbcRVQIKLEvYQFPyCWBhhhxRehqgU8kUco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481461; c=relaxed/simple;
	bh=mMu6dnebAiN735eM78jWIKb+gRkjtAni2BN0jAqwaYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbTvAnJZHpbFZD5ZBnmTlgbYKLhC9klC6Qo94jYKdMXrFWJJg8pTMgS2mjIJLX1CqTczjpcXH1+TufjviFTNXbGdOtSWAdKaCIG1vfoRRXzAsnTF7fvxKKjdVggitixmDb4Mhm+JCagpGVVz5LGr2QW0jSOH7/x23VwKjYJ8W1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX8lF3cI; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX8lF3cI"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6bc475ffcf6so1520063eaf.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 07:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481458; cv=none;
        d=google.com; s=arc-20260327;
        b=hyAhRu5DgGgwwlc/1u83HjRemv57wn0g0YJbHsqOuTtMgMVyqSUdOSflGGiWVZUs+x
         cO+hzbSW1a6IgJtQvbBNsYjyfmp8o/SOI6xkbTNQrgTfTcKdzYptJhkFU36+OSE+eI1P
         52BYw/BbaYuylGBKWcFoamKelCI/aAMZXyetYnXSvMzReexx4QdXF+k6y7wyD2Xl3g2y
         ZbaJam/S641Au+UXUJ0ZAL65Qvv1Qr5uny6nB1ms8El3z/vQgolHNdRuoGcN12Ep3oEQ
         nlK5HCzPoVWwmOQHTSKTg2NeRU52H6TY+6Q4H2BnB8iHqMakTRcEM4Kp06Gnt59eaVPZ
         WhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMu6dnebAiN735eM78jWIKb+gRkjtAni2BN0jAqwaYA=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=fa9Numeo137pvoT1lmUTx8mcWvUBCVisY0nthOtjkmowOa+3T3dDEKE70mGbGKBG24
         yId0GQTsbyPBJG+6ItD3zJLpEa6lwwZIdPS8oY1th3XFODzx8j2IISoDrvsEqBua2KZd
         /NDo5Wlk3DYDo/hVVpwSwP/KjgpztMB+ePtbPtttg6b7rEKJfzyIxaPXw3MaLgVQv0HH
         Olfvp9YCbTnre29OUNLVc8UBIs2glrkNMcWqOGHVNRMDGhUAzGMrtjQhRl5ce94sb461
         k9wfH12vEbXOaZthGT0RxWs/ESvh3+/3xtpxFDb9rjo2ZfyPoVeKZNmczpMTJLeFWiYw
         XPzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481458; x=1790086258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMu6dnebAiN735eM78jWIKb+gRkjtAni2BN0jAqwaYA=;
        b=XX8lF3cIWtlSlKQU/FGo5ReYARqAc7/lr0Hxp+Iy5229gRUkRWnVWAZVfVNpiQ2rWU
         tPJ+c9RDDc8hdHRSEKecB/5la1yLyspNXeicwAcTIKBow6ikhu4t1wcVDkc2i+LuTCfR
         Jzlkt2OfCOhrLadwq5naS+LiDBvJ1u9EKSNJCd7ltCH/PGRTEJwaloJ81EfSAQ+/xsxD
         c/FW20/gOVfUubFqVnnmgc8j2bDGdYJYYzAVcC8b5hL12JmNjkhP7CWWUWjEFhjBDOk7
         NEOvBQajAQePgYs7rHTGlHlSOPrRK27/55ege888+4jmnz2CufHLsVcYJC8Jb90t7Ssy
         kvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481458; x=1790086258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMu6dnebAiN735eM78jWIKb+gRkjtAni2BN0jAqwaYA=;
        b=MsNWoXVgirP7eFSWPhS7GwcfxN8WQXIvXBpSUqOUVkce8IkYyNWmp8K302y2YpXA0H
         4ErEY2sJrBe2+poaJgm3tG7qVr5/0wlfxb0owNcoEN2kvOipZBBeqlGhjJnvIB+jGWjT
         kxy+WrVNYRJGCcSUZ3rpojjKhLBc45VzOOQfmHGl79xQ6oTv2T5Jbs7sFtaOOI37hk5O
         7SQDXlMgeHgh2bF6W6Ve4cxrrwWvO9xddSwAio59Al2V7nS5wK/+GQOG6ZGU8EqG/86N
         JUMkcCGvOlL27ATCWAZOG6vtDn9leOW7yOiYNTji/aNT1q70zmBMbaYps/pMbL+qjwuh
         KKBw==
X-Gm-Message-State: AFuF++mqQb0mnxxLsPxCwbK0aNnDr4gHqK6TJukZRZsqgsOb2hPt5Msw
	3XpfxgayggdU1AoJsVPsfS0MZIIK+gOs3DetFounGB14U/1cs6ssRYTQ+CJNlllAHgFC/XNI9ge
	qGY8lFzlIZGgn3lEcjDSTbKuVPsKr/17BTJNP
X-Gm-Gg: AYBFou3ScoSrSDT2Ua9UCld8TWCu0+FM40jrhuV/RwDoMS9/8IW4ZtfRvCJsC0DUiFK
	T09G5/yZWa+8YazAgDx4W/3vpJOgO7Vs7ZIvIecf22EFHhuF33eVPbkSlprf1J/cd6dRf4a8uNS
	6TZ0XxpSFTZt9aVefoZxxO96R6aYXlv03UrKGWkWT/jmUAmCj+SMMXtZ+Ms6vxe7KydyvcuDOLx
	obAJkm8ukDqsB2v8ZLfUQW4nHfZFrQoSFKCdpK80k151YS5g9ess/JEQow7P+OGuABGaKiy+rkj
	mWaQnlBCTUgzpNvNAUslJ5iCEmWuLKqo6CTG865t+2wPWXd7VziiYZQ=
X-Received: by 2002:a05:6820:80a:b0:6be:4eb3:e1c6 with SMTP id
 006d021491bc7-6c541d3f3dfmr6861958eaf.19.1789481458236; Tue, 15 Sep 2026
 07:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914181511.31960-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260914181511.31960-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 10:10:46 -0400
X-Gm-Features: AcwNN1V-bE15scTYizwybNMSDDXPD3w4MI3NiUkaAgdzQkMv4e_btpNhjaEFjEM
Message-ID: <CAEjxPJ55mDuGf_jbm-Rn1VQBBOz-KSC4ckPSzCA68KnnFS_pEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux/Makefile: use $(MAKE) instead of a bare
 make for fuzz clean
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> All other make invocations are done using $(MAKE); we should do
> likewise here.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
