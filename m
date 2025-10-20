Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728C3314DF
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989514; cv=none; b=IKJP2Lzd3ZxycaQRXkh0LqBcg83T/+OA0N/pYNn+w0/uQRG27PGw0RxbKUktfOvTZObMip//F+5afvZ6sE7o97jbimE1KR7xQnH/PSpX7JADDV0+2EGOt1l5Kycxk+GTE1+/Y9ozM/W7mIR7Jtz25jCD+eTt9Ts1Nekg1zHvVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989514; c=relaxed/simple;
	bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZJ49/iInii9YKkwWqak1v6ygZ08Yh0/K07tTGyUvLe7Y5Yox9jkMQqaFMfOkarbI6KUizsY1B7K9X1tBcBU2822FSgMLDUO/WzxgHEu6ShGA9FCfD8WxcX2EIS1t/AD8/DiH4DbiYqx2SMOS0hLZ51Y/LHwmcgXDynEVpMBsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ib9X9TZk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ib9X9TZk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so6490886a91.3
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760989511; x=1761594311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
        b=Ib9X9TZkHKj2D0thJvwbpRFLaZFa72cofLe0ytzoAyEV8mCmKn9EUk8kF8p4HRlOz5
         uRXYw07qztw5FPac/MVOA/9Ik/KmGaz0F9Q0q9atZBuiYYWgETfcnMm1XhMLBdNE2Fak
         o7VrXVp/fS1blf6gqyxarxC2xwezy8il+oj5qx/g0IwuDo9DlTod9riSf8iheof9C4S9
         BGf9q1kKM9BIykMeUPL3B6SnZdOIWr4vf68SHptB9sbo90epShdrOOLJXQJyrF+cxQPr
         eaBPx7Th8a3jvZZWnU6EvP+2ZMvavHhvnPtUXKT3qr4wKqLuHjR7taLPWSGnXNOekbKE
         Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989511; x=1761594311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
        b=Th2+UwfGssE1y8DaE7RuzzYqHAzq/Is9cenOxDj3rBp90pjfAs+wc5TM4ZKWagIj8o
         sXXH4TtDt0qtlzTefMsasHupu9TQPkPxHjwx1mpl8l2ODLQ7f+JWfLhzB3AnKTTuuhjv
         nKyUc1vlLUwqOwqBvBX5yyCPe7AZWf4/I3rxk70PfUXETKLlWl2KSax5dyUbZVv+b2+7
         SG9EZ8ri1S8Zsp7Yziq2Xs7wVz3i47JC2n3Svv9vi5lcFoHxHJvYW3sTXTEQqTOmNy8Z
         iG+YqvMtdyqQ24Wpx8pATgetNkIxGpaQF07KIJ5H8R/7pFWXZrVy4hDW8qUb5Eq7s5k4
         yTkw==
X-Forwarded-Encrypted: i=1; AJvYcCWHaDUSXm4Rcrk2OQYq98rFHNzXU1BHibB+Hn+LqxJqWS7YvqqSoeZMgabjcas5OIDOmMlzWWvD@vger.kernel.org
X-Gm-Message-State: AOJu0YzdaZ6uRZY6quQjRibWznLdXNyY/DqOjLgHYRX+4T8/VX3bFWFZ
	8tbVZZrt4pegy4L3klw/UHLvAmIoePBXTGqgBAfbzQt89ObX/bLGyxOQjF6q8zJtZwl0P28pYoB
	GiRDyA4XNmO2rhqE7qQA/U5f7D+MIZeOLNZoaM0iT
X-Gm-Gg: ASbGncuad+qbHlpRgWa2gnWgnq2vIORAC6i13x6CT1afnpF28NfLgcnCB8Hou66yw8q
	PXq15Y/nuEM/yQpQ81bF1UV0f/0obMPpmYcry708nnz2uIMqg0jOXOnGkKop3oGEc/C8ia5J8Jg
	Smkc45mYTTDKmQNl3/r58irJTbopbAi/s+dmrzXxLImWbb8bhtJYtIraj1bo6PRtacXzeZdX83N
	SVqOzAYu+DwwzdnRs0KvohohOl/DOVwQpt+OGsIX5BVTx2bxjLTq8isyJ+UFCHDmUBh9qw=
X-Google-Smtp-Source: AGHT+IEenXOkNohiqJLVgj5aurgvEoGkiULfuK8scdYRERow3ijKAZkm4ZUS/+GJ7fckXlSK4CGIhPCjIiaxr+Y8pxE=
X-Received: by 2002:a17:90b:5105:b0:32e:e3af:45f6 with SMTP id
 98e67ed59e1d1-33bcf87b6a4mr18241210a91.10.1760989511270; Mon, 20 Oct 2025
 12:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c77eac51a26a0248980027e9f3b3b564@paul-moore.com> <20251017095342.1180797-1-zhanghongru@xiaomi.com>
In-Reply-To: <20251017095342.1180797-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Oct 2025 15:44:59 -0400
X-Gm-Features: AS18NWD3BYsicXVXZu5qzq5h8AK3tIvy-eKY9eQXxou9Vzg-_zWsJHfh8MkXdLY
Message-ID: <CAHC9VhStjnvsgunsrKZ55zMfAAGOySLtp-TNGUKZcECJO2LkOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:53=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
> > On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:

...

> > If you want to change the AVC hash to something else with better
> > performance, I suggest sticking with a well known hash algorithm,
> > ideally one already present in the kernel; that is going to be the
> > quickest path towards acceptance.
>
> Stephen initially suggested I refer to the jhash or MurmurHash3 algorithm=
s
> in the kernel. In my previous testing, MurmurHash3 also achieved
> performance improvements compared to the original algorithm, so it's good=
.

I don't know if it would be any better, but we also use djb2a for the
symbol table hash, see commit 32db469edfcc ("selinux: improve symtab
string hashing"); that would be another option for you to consider.

> I plan to move the MurmurHash3 implementation from avtab_hash() to a newl=
y
> created file security/selinux/include/hash.h as a public function, which
> will be called by both avtab_hash() and avc_hash(). Is this ok?

Sure, that sounds reasonable.

--=20
paul-moore.com
