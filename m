Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB914884C
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314321; cv=pass; b=eW7GAookqQhxbTSlMgYXSIAh9E83DVSHXM5N+1uDUvBQ5kdyfqOWKI8GcG+CmL9wxa8G2eUPifrBuiG2Txg+l7yQbMYO0YMB1hSZHDbcll9+Y70OOnUBsWOJFIjKnm/NMsnNd9h/pNZuYDu71E5jIl5n+odKKIUWm5i+G8rZHWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314321; c=relaxed/simple;
	bh=jeU39LXhyUJTRy/sUBGYZMPlGdwDQ482SEjwsqUB9vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyyNcJdcXfmvZwitYQSv6MQ6UMTrU+qeiq/pIvJTtslgIPRy/VccdbW4vc9CKjQMaLG3SHWu6Uyqj/4NQyfPyqyJcnS/r6B/LJI0ziNXR27K2r9LqrKKAt8COZUAfVLarkLX7J6NaoYjb1OoDXGSI6OmP1uhFhLk6ngz8d6d/hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUDC2unE; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUDC2unE"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509069a7a7fso269651cf.0
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 18:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774314319; cv=none;
        d=google.com; s=arc-20240605;
        b=OU4bp8aaFfQA5T8OBuq/vqeb+/QKjfdqaKjCSPqty5WRlvIBdq+biZOjB2cP2GZn8B
         5EWTdSIZA6193sYdj/9Vqcqqyc9wrj9t8DoXFfsNxGR2IO3S2tkn7C368LRp0gROgj3n
         AFog5yHastcfq30xAnnWXtJVLM0k9+yJW6JLTH0K2lUob7M6HSIR51pkaEPOqOX0qswx
         ObxG/bDcZhv+408HB+uObLsfLZZ4p0Do2pWw3sra9eXiB16lWNZWhZbJo7lzLCqAsrsz
         sOZXuDA7RiSoAOz1dGoQ6kDlJiLalAHxtuyf6hG8yCIppD77pJRkrk6QnFsmgSwSBjHA
         Ckxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jeU39LXhyUJTRy/sUBGYZMPlGdwDQ482SEjwsqUB9vk=;
        fh=XPfnPeS4wglRmelDXjWECDrUzh1HlzFzhPotAf04/Ag=;
        b=XzjjhJjN9w321RhDiGrSQ+wn88mev8jtQji8u+RNhQ3Dx8x5+hrIy5k6ggBoAAtYrc
         BsMOIgm6yEJioNnKaLzp09/KueRQQ1m8ayBLhVwrQ5ArNdWyVnEehX7NFPSBiI1uMMSr
         vBzX5QtGoXNZm50t6NChbC3GJ2HhreCB4YDgsgoClSzH5fhnL6/AyG6/oAURLhLGrFju
         MCWZxD/TOOSupsN6Y1jtGMc38UST/dk5Ipdd6fQvpRUfXGDQWVRDSWWCSPRukpnjJgV6
         EiAluBm6diBmhG/xRakEjSfP0k6jX8kd/gU3v81933kE/wq8Kkse7OxovcOo/1tEZErT
         Yasw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774314319; x=1774919119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeU39LXhyUJTRy/sUBGYZMPlGdwDQ482SEjwsqUB9vk=;
        b=kUDC2unEIEfJJtcEEqCIIbrCHrqVgydUSXrB2bwlspRGlJFb3gdZueOLkPtr85QR14
         6Ektoa5OKTxWVLTx8SzNX4aIDUNZLEfqfQ9WcV0+zcLfoUruJaoPUQEpd5Omk3EQaTCV
         ASh3pb/iouQS5E+Nj0j6ry4Oz5TOCzLdluz4kNOZWpblZmUy8PRLvtrBX1D8qReTu85O
         HlPZEcHL00GPTxsG3+lS4nmPKHIbP9Zijgp6c5WnTVhKTepsrgmRr3NZxnG9i4cAHFFj
         W/rC3B1XImXLy/57D2Zi1qO95F2Pk71RFSttr8FO8Zb5BFO76/6knG+sWoKB1bwtNpVu
         V/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774314319; x=1774919119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jeU39LXhyUJTRy/sUBGYZMPlGdwDQ482SEjwsqUB9vk=;
        b=AKwb1d5RjH7S2Nz63x2KPGTNv0PKU8eT2HJao9LKOCkh09MWkOcbRs4zW3GrmVMFzT
         F1m6ryyna/JeI8QCQpxEa2BbLUh3VofLdSOKaiCWWNDltmDVqM7OarTM7s9/wIpPSzLm
         KdcQIURsWS6JmKMejNkAltPAB/aTJfk91zSyDB4UaIHPv7OwbwRku2GftFGIvOZHupQQ
         nBwPxU3CNFvay2Mpn4Fj8uPwclq91pFg8IHIXYz2AEm+bjXFHbYwr+duOQbVAIAhm5fx
         yk+hBlepfdwsbIwBot8WkvuB2d1iToUhgVtKwgL/YlY9u7Q1eUnYdST+H1hNTlt8iRZp
         Xs+A==
X-Gm-Message-State: AOJu0Yxv/pQ3UXzw4s1tAUqplL572c045N+00qPVcHG03hpsvnOXiwes
	MDELLhEq5Dggdd8+ZABnmVE+VxmS5sAB87bKnYnm+v8+ZA+MgYjjbb4F+eRImYQ87gANjITxyO2
	o2YUV/Xo/2Zby36uoAsds+z3CxZ1kYuljUK9iK+KIqlyks7R9yafnVaS+
X-Gm-Gg: ATEYQzxZnXIZhuMSIa8kHcx8SKcbbNGikdhlw+Jk9SCR3CWr1PR5DT7MV2H/EcrB8cY
	RzgVqcVni8O3nr1NHxCQ33mVmCHZ2NivpULptK0GccV7RIee+RYUPSsWMOqaXx/AXKINUIkx2PG
	ddF+WM6QIPi1Tj/ScP4JRL5BV2D8Rm7JwsCjOnoTyP8nKTZyFNto28sG72yWHcBEBiMz/1aqHCU
	1dLPteY6Tp6ZIgCtB9atIL1lr8ggt6T+Ow+IgZKx3SZko+oOWEhi2iZ1ZhZjZ8a+Jf1dFpjhlkv
	KfSNKORR3tb/2CmN2q5wj3L8mlIvBbzelyE=
X-Received: by 2002:a05:622a:9009:b0:506:1f23:e22c with SMTP id
 d75a77b69052e-50b6fb9bd95mr7220931cf.6.1774314318173; Mon, 23 Mar 2026
 18:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131941.106248-1-cgoettsche@seltendoof.de>
 <CA+zpnLd0awdRwt=MERAN-xuZBsYYbY1+YDHxN4TrWw_PrEMx7w@mail.gmail.com> <CAJ2a_DcOYVcREmxXaReiWX1d5Zt-2aeU=m=goyvjisKNsY4KCA@mail.gmail.com>
In-Reply-To: <CAJ2a_DcOYVcREmxXaReiWX1d5Zt-2aeU=m=goyvjisKNsY4KCA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 24 Mar 2026 12:05:00 +1100
X-Gm-Features: AaiRm52ukOB-bvGpvq9cNWGwAZpDA7Aa0rfVTdnjmLFs9DWFg6tDAjz1Ga0lLqc
Message-ID: <CA+zpnLeRq-jkip_se50dR8DP9S-cFHAFAyf9yA6=+A4RLcTnsQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: correctly find partial matches
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 4:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Does android have a context definition of `/.+` or `/.*`?

No, we don't. This forces us to declare an entry for all files and
directories at the root.

Thanks

> Then that definition would be returned from lookup_check_node() with a
> provided static buffer for the result and since find_all is false,
> all_node_specs() will never be called.
