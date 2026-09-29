Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A05218BA
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699305; cv=pass; b=QNKE1FgzXv+C48FiTbQTsL/KYc8OFOyoP5mNY/jBstKS1bcaWeH/rX05xVtLcn5t5JGRyXBu338bt9muxD0PeLxBzeFeMoeDtrgNJMFe9Szv70aBSkulIR6Tj5bHOH7Ptv7Cj9iorZfLjVDBkZ5ccTWt4QUoYu7vIN72U9DuJJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699305; c=relaxed/simple;
	bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4DO9/ksrwUkMC3Uf1czM/p/vLmipZerTj94q6PTTVdZmzfzMLJDHQfJpkWkIjuYFinW/lZD1FmFGKaGk2bLLzNrp6ysTZgTa59EETS7QHdbWTxAj60Vg4Qfzx18Z9PGiwdUhNrigAeOSo6D/iAvqshd0Xj1y3V8JwTmAvfZuW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca6ehWsJ; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca6ehWsJ"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so10455407b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699303; cv=none;
        d=google.com; s=arc-20260327;
        b=nbJhU4zwbqGu6Tf2XJ3NyUGOvupnp1NsG7CJY9bBUr7lglAXdIkJLyp6qhHPeA71nF
         szWysbkD/N2Jd2pw3uDo0z5WVWPe3Ezt3wnWw/wviYacBKDcui4xjJC5opfrxiy1gmX7
         WIJsWw7Svo6zANtpBgEfyRXCAPTm1tLHXxdIZNvUAnFOrNVuzZrSCeGQOCEd8XdC0nyF
         mOKQQ0A4IrbqRP/ztq5KcvYkbn3z5D+vlqH/73mGrOcMtgDnt1sprxgGZDOSvepQzn5t
         sC8wkpDz2IkTqegAwKjAKahvtlQE15F3+ZBGihq+cQXeyKKQ9hVIGae+3CA1c2btSXs9
         NxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=W1MSfuJXGgr9eAAw20RKM61xtTOytI+bIS38P9ysH8AR6EerO+P62qBxbTlw7xDVh3
         7wy/BUAe3vMu3LpJO/Vu7yg4+8n0AALTY3JcwsrMwV1hG0w/PP2C9Ct0iMqeYnucaH7P
         UcUDwuQLx3+X3yzfPd+ydW/y3M/NsOfzyO2B3LYFW5GxMc2R9vCHsWMyUoeWlOQM78z5
         0QaGC+vQXZZpA4eWfQ6L/G4P0+MW3eA2BNPNtXfecstmsV7NirIjkO1XyPQEoWwM5DMm
         qdDzPXfbHOjzOtbDRKx5KMkpGXU8rcin7v45GEFj40gRYgR34jiDL6lEL/SwBZ9Mi1oF
         1uGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699303; x=1791304103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=Ca6ehWsJYYdxRSA9d4bDFytE5UGwzJ4s0zbcDwXH/1mJ18Jm1M7aoRfo1YO1WYSic0
         ihg1kQRBFZZw15VZUkuRVMhfk8ZHjiFmC/KrTANpqyGfwqtGj/CFQUhgdR35/F+l7BiQ
         bSa5qEM4ggUmb5bbPMAbVvQBZgz3NMSffAfES74iPG+hiFHsnqmpC4AP8NAGDlZDXiev
         cHCCo6sAkrLpNNPCEbRMMU64qyfXUkBVkaisQActN17URofmlGFzRYozcGsaoNV846Wc
         9aiPslFBwyt7svXqSQXynMTw79uH2dNQW83rqAhQXwE9rPtCuOSmMLPtgZ+Euc36Eeuk
         /KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699303; x=1791304103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=EKWDnRoaBImCKEH2NCJP1FSg4avBTnAG/NGqESab5TeRFNK1aHu1zYY+I/W2TDnDxN
         9f8/wmt+vYpmFiw5LDlkO9N9+k1xQ+rKomhQ9lWH/+OL7zivFY/OKNQFD5q+ldWaeD5s
         CcF8dO8uJba+boMhTXTa0TUcei/uS+OxTd7QD/PMld4mC80VFelcTQ05pdG+lEXFO7vX
         FrhSJt9dr1AzdPsY9p9yRKIhey7VSgMnDhynwkme1uc8iP90x7W5iV2Vsej6pEVIAaCz
         eETmmQsZrEOdt6OAOTX23bQetJfHoTdthMm2OT2VgiqKO9PLiaAgihcJBUHvWoNWJbWB
         6jXg==
X-Gm-Message-State: AFq9FYJp4KzIpuFlsIRvgstdnfXZF4FH6gtwXpD2DJ3woa7AHXBoYhcr
	tVMxDwNsUavF4/iYsuFLsBIs06xghFNunKuiQP8cxEb0zLZiHCa5O8ZQ262qDtOq+JMeGqemLVw
	5Zva72P0W2R5lYkvNIij5d9Bt4NlNK/3hU2ON
X-Gm-Gg: AYBFou3xBBFJMF5iXf+vd9RWNRZviDT01j0UYsVyFBhz1HcJw8p8GH+I3wbJOxLNoo/
	ndCaS+pye2DWM2l80Hmpty2n1/Rfq1bdVo67IcanRxdT5w5Wcwu3q5QHmy74ygTuoPbrypqxhcK
	D8jURYXc6OChy/W7hBhyViUkmqXOkTERuFBscryPusujJ+ys1wWU17oPxskAhgioemRiW83UAGC
	GijemqGLYaWNzXDYUCN53EA43c+uLhaPxIWmxyfTFPAOI5JyMSstV2L34wFeWbksBhdVC8lp/7N
	RZNPy54i6KXzgg5NuHkhtJOdEzYfIa0W8/g3GouFKJkCiJP/Ch9WOig=
X-Received: by 2002:a05:690c:288:b0:8a7:4207:64f3 with SMTP id
 00721157ae682-8a742077725mr58286027b3.64.1790699302662; Tue, 29 Sep 2026
 09:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:28:11 -0400
X-Gm-Features: AclHuK9Ho1g8RxUECT-oftVrvLvtxqZhLtYudE3RLWEw1ZaDHvdmZF_eaORTE4I
Message-ID: <CAEjxPJ4vL39sjjTeP+61vcBTP+-++bC_envkLq8TYsyK4jZVLQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/21] Makefile: add PHONY targets
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
