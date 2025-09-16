Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B932F260B
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048941; cv=none; b=aqUOojEm8nnNk7dD7hcl+B7xBGAP0gb8mi3a/1pg84q6sFCgoRHjd8Sc0pyTYznUR7/a7z2HZx0VIgD3+qYt4UvWqo1kRn/SBHiNFNMwoXbmid0sPnotXwasI3swb5huXdElKSbev2rJxTip6ADdYcPM7kXLYR/gGJR8UKDUe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048941; c=relaxed/simple;
	bh=yQZLEO97N1ggWumkq/IJfJbIaY6AhB3DfK64R7Uw5UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSsYuoO5U7qabhpSsNMrOlZ1J171h1JW5GV7BwadYxsg+dXvjtcpIZgIclP0zvz1VBUm2y7WdmNG5lHCGCpVEV+LjLDCG3/RQ253I42BrqWLtdRRtb4v5x9OAlUao+dDfBAKYm/QcnWcay+0g/08fN/POpLgGFYKYpgJT83E1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No76TUtv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No76TUtv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32df682cba2so180460a91.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758048939; x=1758653739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+QBfx32epdAdNPyHe1/ONEZYv20CZLtxukROY1EY7c=;
        b=No76TUtvyZcXgXb3wlezprFYgT5lf6btsKIpm78ZomrtJViQFD89lWjOvDeUBtKYHW
         JB0hUWHYMgn4/UXVMMGK0fbgKRTSYVtCiK5nwzBWaDKTblhE6hVfO8ZD+UcJ81JSbIZE
         L8sKhu/o0Bklqo0mvtKfJ1dn4dFXMXZLlQ2+UmlvPKyxWkISEREC8KmEWBZh1wTr2y/x
         rPRe4QkKJTpo/FoQPdDcX+HPUjqLMhzGJIWg6im7EbqNNwxJVA045qHDn7zJXKyvrErc
         OYyGbOk/i22za9thnW7za70Gm1pjyyyaaERCKJk6e0V+0+qe7jR1ft6Yopu7sbHVzuxN
         DYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758048939; x=1758653739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+QBfx32epdAdNPyHe1/ONEZYv20CZLtxukROY1EY7c=;
        b=tEgNGV6WHln56gVbFT8vjCP3UwDdXhzk9iDtPHHlfFmjqklB178rB/mPvJqoRnYbEh
         u49qaYbsnIEUrthKHiRp6CvXkKlSAkdbEZR2kLt0nvNzfrZCfAYrTABLsWBIjSkpsQms
         /RqwkLq6aWK3zBMyVB7+s3NnQSfBpvmdvRtX4fEmssaHOd2lFrOln3JH1+n72TJ29e7X
         RL5OuI1EHYWv6qYAHutUrf7vK/eYEPViD2zAG4+aMZyEAMSs2xgc+EToWRg1kV0ySyG4
         3z6mYCnONgGeujCEIl4l9Vv4CoxioIFTT/G/hfsxqgo2hS86stKPu2eUXg0hXLVJz0zD
         4K+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAuyNeS9EiAXf+GBhIBYDFj/uGuQFoI8Hp/ALkhzwnJB/OgTGNGULaOpzvzdyTOc8Ez5AIRciF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QCKi0TSCAutOTEkQvomoT8qWHcbVntLNt6kCOUViZMa7fadm
	Hrrt+jOHvYKNyQmrLV1eNQWKT/R/6MFTrQQU1vMW5yYckzOLe0JqaEVR9oyAWgSfTGdPESemset
	KCCyHo/cQGvzV0QfmRn1zegldLPlaO88=
X-Gm-Gg: ASbGncuyloVtDZWrmzWhR+mfZ/Kwhctz8PGA1R1ocJ0m2Z0zJBid4Lrzo8vPSHJPDYP
	63KlZcxzCJAc5WhNzd0APllYifKqBnUsfL1D7I4MjZbUEgzTJ0bKgvm9GODZsOCSWbaZfgXwPXL
	ew/elhiJ1W0iy/tkBAyxLl1NVd681HqJ7o8pPU5ZmiESTBfLLgoljfGHpZdu9EaCFPIFnca8Gs7
	d9XT0nTT0C99W05NQ==
X-Google-Smtp-Source: AGHT+IGH1tDr6RygMSLfZlgkaIzbrhRU10FifKBMbQSNm6D1Il+4mP0pVCESOWN6g3QuPiL/62h1TINxSCV0sXU0hjk=
X-Received: by 2002:a17:90b:4ac2:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-32ea60da81bmr3630464a91.8.1758048937607; Tue, 16 Sep 2025
 11:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
 <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
 <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org> <CAEjxPJ692h1RbJfHLGfVye7diVW1r5WJz=P0iZeNet0gf8Qusg@mail.gmail.com>
 <d3a2e381-1814-4d14-978a-8a2ad02063a3@ieee.org>
In-Reply-To: <d3a2e381-1814-4d14-978a-8a2ad02063a3@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Sep 2025 14:55:25 -0400
X-Gm-Features: AS18NWD7F9mtsC9-e2OJn1qzyaC3Qn3u9v0PpKe2rGcFB6m15E-cDoO6Vv07_pw
Message-ID: <CAEjxPJ7mc1AtE1m1_fypn-q=Y=+WiGPpgkmHPZCdbWMqSdQQ+w@mail.gmail.com>
Subject: Re: Lack of official hosted macro documentation
To: Chris PeBenito <pebenito@ieee.org>
Cc: Paul Moore <paul@paul-moore.com>, Ian Pilcher <ian@penurio.us>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:16=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> =
wrote:
>
> On 9/15/2025 3:38 PM, Stephen Smalley wrote:
> > On Mon, Sep 15, 2025 at 3:26=E2=80=AFPM Chris PeBenito <pebenito@ieee.o=
rg> wrote:
> >> On 9/15/2025 2:01 PM, Stephen Smalley wrote:
> >>> On Mon, Sep 15, 2025 at 1:56=E2=80=AFPM Ian Pilcher <ian@penurio.us> =
wrote:
> >>>>
> >>>> TL;DR - Writing policy modules is harder than it needs to be, becaus=
e
> >>>> the documentation for the macros/interfaces in the reference policy =
is
> >>>> not easily discoverable.  This could be helped by hosting the genera=
ted
> >>>> HTML documentation in a location that would be indexed/processed by
> >>>> search engines and AI chatbots.
> >>>
> >>> Great idea. I thought we actually used to have something like this bu=
t
> >>> am not finding it now.
> >>> Chris, any clues?
> >>
> >> We did have some generated pages, but when the project moved to GitHub=
,
> >> there wasn't a place to put them.  There hadn't been any requests for =
it
> >> to return, so I never looked into it.
> >>
> >> `make html` in the repo checkout will generate them in the doc/html/
> >> directory (from the repo root).
> >
> > Maybe we could put these in GitHub pages for SELinuxProject?
>
> I have no objection.

If someone else were to create a GitHub pages repo for SELinuxProject,
I can help maintain it.
