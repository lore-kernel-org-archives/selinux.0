Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAF449B29
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193567; cv=pass; b=EMmQMXhZOnJfd+DZkfXECZ/Bw1MXocPcvn4dHZ+CnOU0cd09izG19TCptSGH03KoyTUcgTiYCmx1925qt/z/rpb1Dz3jjX0cxeTe/T2IGdIifGKr4fBBERK8wOd2f7vpQg7ysvCG/rzv4+vuJibufnDomZlh6TbUGlHtogyPgCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193567; c=relaxed/simple;
	bh=bEeBX3+DTE1J8yPc7yHLNRA1VRh8U1729kSWj4muYlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uetaNZVOTU4DbIw6oqubP9ZBzLjM02OogoPcwYfcg96KFSe4Y4xb4AeFdkS+eFtz/bhfHH+NUzdo30px3WcYSeN8GNm0lDilpaNWDUqYTgCJTZSZ5pdsAyn34JGx+BlMd2eGUcRcHm1gFKA6NFMTlrkqqNfw0lrDGbbHPskbLHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDqZPR2v; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDqZPR2v"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4e6b5bd30so38578a34.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 09:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788193565; cv=none;
        d=google.com; s=arc-20260327;
        b=dDucm/xDJnLk0N9OSYtIhvh3Fv7q4zkdgb3cKnEENNfEO87UXh2MgJX7eb7jcmCgjF
         Q1d+8cGgGVHmqxPnT5X+RSiSNxic5CUTWYI+VkCQjACOJe7UePtMhS2Gy6NDPtGJtPVI
         djVQ/QvRESGbxbUYYcZuKB/Fn446gpMU+8wqdT2dL57GI2GRfZH6p3KjAuPmVTbYWmj8
         ltxsrNmOnz7MHqtc2r8hvqaD47z3kAD8h0fpfzrqF5ES/ilZug3b+XnHmrJJ2HNNfFEF
         lDJI1c8sMzIUYipLs25fHqBGuG7l9FDSSasXhQMek35+Z7jldLy0xBUMs6xPY0NFpZlF
         W7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bEeBX3+DTE1J8yPc7yHLNRA1VRh8U1729kSWj4muYlk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=BTBX37W9Km5R3ewqn3jKczftq3G0ofXGkloT0daIvmPuoJojsKkCM5XmVd0+kVFnB8
         1Ls7hIfV1mDPEaukqN5EkmP0D828gWdkjTYUneigrA56uc59dgnWKcFXlQWRm9yXiPLr
         141+QKJJ2M9yJWXR9P6C70DYMtds1PAuKOHtY34g1R/HF+b83e/Z3wyxRYnUYik80tJh
         G8vBAyJu39JDMEZwkreZMLtbXu/taUwXD+T2Yui0mDw603zRp4Vxz87HJ+LT3o2KwRwx
         rkSqvUohpV5NDr8Tzse4qJ0UJzSXQjb2J4G5GWXN0U7wSX5QPiWvS7emttAm802e9MmM
         k+0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193565; x=1788798365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bEeBX3+DTE1J8yPc7yHLNRA1VRh8U1729kSWj4muYlk=;
        b=oDqZPR2vysK6sCXAhTlUSpyL+zT2GCfRjMfnQZFrNOEcbrpWn6bRg0HZcWQlKXL12i
         jwB/fAWa5binAKlnv5EGOblw/XzXKmwtTFjB9TxuE3MghvRbiKDHfys4sD2fca6ZQecs
         xKehvUUdH87gA/5fI0Pzl76WVRYaz38xN2VxOu99k/KyyagzDAfdMDyt/Ju64RSfH6m5
         AIRxA0l9Vs4FrzdSyVGqw/xyugNz8kZdHOtYEGHPwAaI2XRpT8FW2A1ybUcRx9gEJbBy
         cKqMkjFQrwWNrk+wBXSdekb4Gigq0oCeuzzwt1FHjX+WNs/ugBc6n5ehUEeeRAhyw9bY
         xXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193565; x=1788798365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEeBX3+DTE1J8yPc7yHLNRA1VRh8U1729kSWj4muYlk=;
        b=e8q1LuptV/darGXJznJgB0tf51DxJxz4oYlyqOaRIK/kdSP9bQuN42c10lxPedXZ6b
         nua4ZWg3NO2LyLi1zjNq0JJN2BP4LTbAnO/JSlVm0pMLC4OLsmBTf5ce7sk1nh1gMU34
         t8gtzwdFAT/PugtinbWziKLTTVYovXEDrfXmjo0TkXQIe4+TaXCS/dWEiQaFxf93Bo1n
         Q5vrwzc7BX2CETbS66saci4+Olo0MrMtiI9cyn1NcR7B6SMz/aDyotKdp8k4A10NdoUZ
         k0SUoZJk3m1NI4ija2yvHprtHDud0WEso8Xnt4q98CLfPoNfw4uUF3qLP31kCOpOAmwP
         tHnA==
X-Gm-Message-State: AFuF++ns5XE8CZHLcTnSKADrnfdqgw+KxRYDC9rrkXxnd+wDpGM3/R+N
	hsmEjgWR5kptFFUEv5MC6CBaB6SMO8KJdyJMn5FXNd4EqJzPF3NQJq4NXZILSnfLaJUps7Jc01E
	AQ9z/aGGMmtbqCtLTnH31neZ9zHUSdLDTfg==
X-Gm-Gg: AR+sD12Z+eMeXXLKVEpeAw8oV5MU8gYUTz7K1LGAqkZIlZDmBvXSSXYHkU5KjHbCe3R
	UEH0D/D8li4rgHiKBKnxU2fAbgLl4LV3JaheaTxOboXkCOemoENXipwmSBrrOMumJHuYCHWN++a
	BK64r3SH9kU8ixTwp8qMqYoApYzXUmVTVJB6CeF09Do9vEgFfr6kQwub32Hda9Zlj9uIWNcbqvB
	xaMWFoNa0bjqaS67Hb7SwFJ352S++NRpcWycOLzPeR1f7y6VQKgQ1HUGRrT1CtQfEBwbxvq7iVk
	OTUJOMipmkMj00R7nwFgBDPIayy31jWfoSAxCsm3K5BJRLH9m29IqFI=
X-Received: by 2002:a05:6820:a0e:b0:6b1:3ec0:60b0 with SMTP id
 006d021491bc7-6b35e4f8d74mr6280559eaf.20.1788193563016; Mon, 31 Aug 2026
 09:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831141649.39561-1-jwcart2@gmail.com>
In-Reply-To: <20260831141649.39561-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 12:25:51 -0400
X-Gm-Features: AcwNN1XtMLmQ4SL33LT31Q2VBqI3nUj4akSea68yUgWPjJuapBw7zZOQBxn-304
Message-ID: <CAEjxPJ70a6MS+g7de_tYhiVxgME2cK6j-TC=LA3SsZkbTLixAA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Tighten validation of scope index
 class_perm_map array
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:17=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> Commit 94e9e7cf ("libsepol: Validate scope index class_perm_map array")
> verified that for each class in the array either the permission bitmap
> was empty or that it contained at least one valid permission. This was
> based on the belief that older compilers would set bits higher than
> than the highest valid permission bit when "*" or "~" was used. But
> this is only true for AV and constraint rules and does not apply to
> declarations or requires. This means that stricter validation can be
> done.
>
> Fail validation if any invalid (junk) permissions are set.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
