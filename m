Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9A2D73A0
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363435; cv=pass; b=DLfSHocmM+3aZ3LXx2W1j+pWhjs+WwB7sqZWYOvfouCUfgqzYM3HB74i4uqxIlyTLBXJINa/hBXj6/jeQbwuE68N9LTKvlaZfSiaeMgXwB/S2mJgGOomhuXARDHBnVJuOUkHaZEbkjZg3CG0SMv+9ds2NHtbeguuFLM9vcIJd0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363435; c=relaxed/simple;
	bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQUAR/BLY/mQR2c96sfKn2NToce889oNXpl4JURbNYAXjB2U2wYGtYN8zEEHCiTRfpY4xsQSs3UVWhUV4mr2i+P6xgmwsRERJPuHWEUpOQPaR+OZB7MAaNM3gMq5jRZMVZl+k/R3f0ji8yJTsDWuSIBjq801IWXBvH4nc5z5p3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPWQegah; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPWQegah"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20a33so1531645d50.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363433; cv=none;
        d=google.com; s=arc-20260327;
        b=BhvDMAtZ13FrYgl6q4l1z9QQezVybAddvFLLr7UQoElUjiPB5HbjXUUCAMH/HNGmft
         VM+JXyEFl/I2bv+J8S2k9XJyEZhlnakbBTf6MJrlYA6VnZ+kekBXPTdL2LTIEv0tiQ06
         cp21v6RuEu9lmIgM8YrdW6KN+g256fO8CIHhX8xFGy9wisaCS01dkQmA5JQCGeAMecuq
         eW7x3pC3XzyZ/oNTfsaIDVPszRKIBHY68qkES63n0+oIWSIA8+GI0fUlJ38zGPg6alzB
         BjUMQ0FZqHwM7kHaM6xlcghN9HWiB04UxjD/0t8vF3kItdljYz4w1Kx0Bo9OtIwJkuOR
         11Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=XpSw+HWl9OYkwy6vovvUO/rkUQFXXhZxud53Jd+0bLLf/SHa+473XLYIjAZo+u6uGS
         ve1SDmmTdi+jCFSrsZKYc0c6KS5BZjHE8mUGIm8N/PMF3MLLHMvdmUKQmRf+vuUCfqK4
         ONubtddNurlCw7pKUPTvsb/r6D3VmI7b+Uy/bdmAnBdwpPwvlHb3i0Wm6R/ZxJRLzdyb
         vcgGrRQnurarxu/j2/GoNHH/8/V7ci0NI8/UqXFVLcOgW1W3cVduGbGToMASKsxBg4Va
         y61RnezMu1f4BAmOTpT7vyZNCNmWF2lM/03v4siA6l3AQrtKkoTI/901TQEfsgZLws5j
         e52w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363433; x=1790968233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=bPWQegah8E4XLfBaf9RtKWQchsBZmRQJitP+Oz1Q5BriV1SFf7eSobbaWRN55iYl7I
         5+w5dF8VcCf0xSNINAPHCvXpLtnR0UEc+EGrKYs02tMJ9uMrgF4jVmf+31htf2fu9bLR
         cmcIdMXrQ+MZ9GLtzA0Sr2zEEUmJMRn4WPAVqxFFCjij+gs4LGzNbuWq7UoBTzcVDcyJ
         VzxQGKlXYcDLL5A6Sr1x9rtSKkpws8Iv0bVcrWFpL8skDaVYiDzMYaSx7HsRevsyHc6z
         p3hJGCrAbgQ98Y5q34F+jay0sArLsLvOVzFDEySzXfNzezch9e85gZniDP90HD0SniKy
         AxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363433; x=1790968233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=M8EwbrU9tPJeZdSYG4COaJWICnrhIOAgzvX/3kNKE3MTOGyQqlwRlyY2FFmdEB+qYi
         yauipVVjt5vSRjjmfteY48G2N/duaGE4vIq4FSdJDzjUN0SZMH+isNk5sKOa7xh1CBsc
         9Cb25FJB36DLNqOTI30bwtoLNq0yOB0+fEjwtTZ8w+h4z3t2k0NWaZKBG45kNTxfJf0v
         mVFSuqEFNdBGJZ+CpjYfHnmasAPEvrdn+wKpb8vjHgaQm9slVwKCIZ904LnaFt4rvsH+
         9iKOLmRCBnNxiSsVDECt2xuzNbvNasBh1Ejdw8Usk1/10D+TSL4uWKlWkBTMv5ssKWrL
         Uw/w==
X-Gm-Message-State: AFuF++n5psgqBXRxiQQG9I8ZumbhdQBPagCXRO+lpxsRRhLRzPkeSEa5
	h5lTiCq21dKAdAoD+tFIy4AwQT73nJZII3yBVok73dRnaZ8qo5c3a9b8aa5Vm8HVgi0A1vU6iSO
	Ng0md6p8UEMaVVDJYIpHQD9/oPTA6C28=
X-Gm-Gg: AYBFou1GuxBUEdaacn17PpR3TMwQzgfDLD+tpUDFPfSzfOwRRSRNyuq9Jtnw9oiyEPc
	f68Ay9z6U5Yx3Nl1hQB1QzhPqMRjADk/5GHi/kGdgY1e2GzDaW8T5c+lO5j+Q8Bf0bEsfe21MJ8
	xr68xWG2lxhwsvydBgGt75WcGYnmAlBLoQFbVZHjhfy9PJlRHWe6kaArS7FkOrLSGfJhdED+AdN
	KI2eFAyTkerW7uW4NnnWIeSa4pDvrry3mUTibgbPGKlqIT5zHoD0q+p1fo4FBnrtb4zjR7kRUsw
	hove8WoKC6GxpDPt9PiQ1ShogZ4AW16k6ZLcm4PQzHFduNWF3AEPUFQ=
X-Received: by 2002:a05:690e:484e:b0:672:bf7f:4100 with SMTP id
 956f58d0204a3-67411485440mr523259d50.154.1790363433064; Fri, 25 Sep 2026
 12:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:10:22 -0400
X-Gm-Features: AclHuK8Bb1oKrXONwgbLpN8evFAbDKFPWwsn1AAL2f8xAJA7mF0rDNmOKCSHC5s
Message-ID: <CAEjxPJ6YbXT7Xa54fOF5recbHyv=3vrWhwK8Xh4XKR-zAuxx-Q@mail.gmail.com>
Subject: Re: [PATCH 12/21] Makefile: add PHONY targets
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
