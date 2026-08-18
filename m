Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197AF369208
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083497; cv=pass; b=ZaoSI0J6xU9JecX3+eqgX7iDor6M1HNLjwk5pB5UUVd9PXMAs09rIE0O93C9XGEmw9A5Kb5luXDCfI4H9Ib/sB61sVSNzRu/4jZPCbM1UenEKiuSJXAmMxf0NaVFC7fuM+1N4vAAFtcS0lX1DVULAgI9zf/Djs/yXOT86LVJOsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083497; c=relaxed/simple;
	bh=wBQtV4BEPLvS2MSbFIRFRNlFck7t5oD5o5aTy01koBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbYCfFG9eSi7pyzIFJxIoiRTwFcZpojX4QoXbAY6k+OcJsUs4MIJy5OFgKXXBo+8tNeTsmtujuBVe1IkHNXQ06RMOuJc3vHbOnVsNd09EHNTwUYZ5q+TEQ6LJqkohkXcSbKwy0zX/R2qffg312qDrQ/SlPplsat3EprI3Gg0GQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFGDWCyn; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFGDWCyn"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a168dc590cso259875eaf.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 13:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083495; cv=none;
        d=google.com; s=arc-20260327;
        b=gldX8CPLz0a6TzIW1Bfr+D1ivGlRgbd422TQOqPulhROGy3ZWzfYUGoVUgQOCt6sEb
         AGocXT/701gNC2u6wUt3Q02TykCbZwqF9zpgXR35Gm79IS+0WRIVUWbpItbOAfIgJhE6
         PZnrUDFrDcHBW5x5dfa5xe0YOyGSADy9RZGbd8nsKltapLa/8J+D9G2Kw1nH+D9O9Yej
         upKK7jX9EDQ1lQhOICFaI92d5si+EA5hXy8dLAAjswaxYVN7na6Uk2XjP9Z+fu3pW2rz
         tW6b1nsa2wWxHLKeG9C7k5rWCB9YdC9VNJzYSVwdgwhxVBf8vT4RP3pbyHSER16rtuOv
         znmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBQtV4BEPLvS2MSbFIRFRNlFck7t5oD5o5aTy01koBc=;
        fh=Vdc608U6fmQnkK4Pj/GsEOPoO5XtlZs1Z9K2hPCnM4c=;
        b=NOfkJT8MbRgXyr6eEGv3Hi1QdiQTqQTNT0uolLSjZAe1x9RPigzvsLCwJwX0uuOuC5
         rr0UwK99L578whZiJuRwHSIH5yCO6/PC7KSdkYEVuRNxJWu3WZ+Y942HOSzoLivGl6lj
         vQcoax1I4ow44lLBy1pGJY2OtujxzGw0G3mIZlG/0NjHf+Q19n68JkLabgjkY7OQLf6j
         UdTX65hTlGwfonPRYhpkIFExuPkGP3VRFt0jjb9FevGdx0WLajBPuv5o/13qWPhi9gsX
         QanPUCWF51v5nDIJ97z8PLns0VPvdInQtO0M9n5pMBSx1zRQoggG17rF3ebo61iA74ZC
         0m0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787083495; x=1787688295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBQtV4BEPLvS2MSbFIRFRNlFck7t5oD5o5aTy01koBc=;
        b=CFGDWCynaLLwkjMVJeyYBrd7V70SZ5+iyAJsZn97wP5Nc7QIqd9nAb85e6zet3hxb4
         MG7xVGYLWj90JmnTgQfSs7qcqViAAf+BNUSlONVS9SWKf9yl2Ngx8YXmvl5MQfViWBYi
         eSRLI/TCCrXnWHe0HINP/dUsQVPr8AheX3xDTv/Oyu33903xAbY4NxX1WPeKwpMu8P/S
         fB+dauVFVpMEtuTrz56deVfLcNmbYphlv9Z6tGasfp2H1P126zH3hZVUWav6FY+sVjtS
         Ev8N/OM1L8w+CQdIqUzPfIiDAWrFxioCCp0Jr2wDuYk/gqqbLQZxEqVO1nXxHowCUF9O
         uV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787083495; x=1787688295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBQtV4BEPLvS2MSbFIRFRNlFck7t5oD5o5aTy01koBc=;
        b=BPCmB+qeNa8nsD2m7hziwi3dk4duPL29LerMMxbtD/nQKJTTpCniN+BRojZt9s6GoP
         2+8tEmuFBxnzAIXCd4GPl2cGWuWqSkwvg2l+JCYBJ/exB7xoenf2UmGAHw0gPy4rh7XE
         3mxiweUX8tmY5oxqjLErrQ2hL6oAtylBcSxR0Em7rgbesP2yogHRMwn+83heCpVE/Vbu
         tsef36K66TgGo+gtSfMZmo15raiQ+BDRBslU3SVfoPx7LHxGS9CSrxptpWLNkiEmcdRS
         SaEl47pVCPAc+fLxPKXf/Nt318TYZ9F8+2Uz5Cb7+dEV0271/pHa/dxNKFVZf94gDmxY
         MTjw==
X-Gm-Message-State: AOJu0YyAN0qVYVfUsPurCRxWiIGaoR+05kttzqXjGH9hrpzYkJUX/PuW
	qIjYX0kdkj7e7/YMU4ToWS105x4JgV0Pg/n2QVCTBr02khnoZRs2J2VgQCpcF9jKLuaQxZIYR5F
	1Wh3wvg7FsZzGFyiJ7NUrV6ULZ2A0/pg=
X-Gm-Gg: AR+sD11iRKeJ40mqZDJAk7zIvgQjFOS1REFXy5mHcL+w8SpCMqpL1OhUNJ+SsC+AQh6
	8AQczkNueNMgjCzbEis57bgMcu2KfhbbSiW7QlwC7SAx2dPqdVcjP4qE6LTnB1aARORXC098OC3
	bkP9HJPibxE/hwvpu6YXx5WuHKz96+rUO2IxnekGplH3a/oq3omjjNS1C6/vSY9KqWVF0XpDSFB
	7dbn8+Ly8+dfquqSWnha4HxQKHXw1vyVInxx15v3emSKdO2dJ88Wab2zScGdxky+5Zi2ZSS2/wt
	O8uWGyE27aWw/2KyAW61tQymUcdeZmVZAAqsOwhhZJBe
X-Received: by 2002:a05:6820:f021:b0:6aa:e854:1fa0 with SMTP id
 006d021491bc7-6b13ac51f9dmr63186eaf.14.1787083494837; Tue, 18 Aug 2026
 13:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com> <20260818192340.119297-2-boeroboy@gmail.com>
In-Reply-To: <20260818192340.119297-2-boeroboy@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Aug 2026 16:04:42 -0400
X-Gm-Features: AcwNN1VhcEV9Fwy_v7ZTlPS8BBZF-Ose1o4jS-AF-1fazB2uj0E3Qxt-2y2boO4
Message-ID: <CAEjxPJ59MhYLc1ivJWVKX9H_EOvwyGKyaEHvULRWkFq=Xc-Q5Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] policycoreutils/setfiles: reject invalid -T arguments
To: jboero <boeroboy@gmail.com>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:24=E2=80=AFPM jboero <boeroboy@gmail.com> wrote:
>
> From: Johnny Boero <boeroboy@gmail.com>
>
> The -T option is parsed with strtoull(3), which happily accepts leading
> whitespace, a sign and, in particular, negative values: "-T -1" wraps
> around to SIZE_MAX threads, which then fails a calloc(3) of SIZE_MAX
> pthread_t entries rather than reporting a usage error.
>
> Factor the parsing out into a helper and reject anything that is not a
> plain decimal thread count.
>
> Signed-off-by: Johnny Boero <boeroboy@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
