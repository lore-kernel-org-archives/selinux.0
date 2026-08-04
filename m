Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648A4734ED
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869506; cv=pass; b=KXvQBf5QY9SzREFMyr41P+SklbgByLWbu1C/Rnzfvzm14lJn8EAad0lJf1lqgqVZJwscbLWCtFB0KXgSkD5zVKsb1tKWjBlRek0GcqiWG4vFjckYI8yOsASK7KIIlCpq9eidMp0FNJwuZvIIo6KGWBUfSuAT94GZH3gsfXcDRq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869506; c=relaxed/simple;
	bh=BT1he3iFK4yj+cBU6LCEV7RC8hU7Ju46daYXhaSzeg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7ReKr6AKFMxxRtfu+t0AL5iBrTULWmCcu24pbbJ+U+XO7ty/U02cAGFE9QPlhfe1UGQDiKZdfrgVR9bOcnihOE+1RTHcDxLqawzs1LtdFpOtuwerJUbSGU9sk5w6yN8hbQnhLOGbqrt4vBE6jSzCxlUyj7veHP9Jcqx0Wa+shY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgmQKUZo; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgmQKUZo"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4563ac048f4so56181fac.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 11:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785869504; cv=none;
        d=google.com; s=arc-20260327;
        b=h27Spojp/t97aUuyicN2cSTo4Y5+ECe3hekF/8nSgSSyQM5EPtnGOgYt4oZ/tIZDSV
         Tchc7euatHbF81lL5T+gD4564jv1WWio4yHO8wZd5DjJ0KJnO9HaZjy8Dk6bS/36tzZk
         1Ti/8nMI3af2DEVcLCkf/5tzqSqjnBtSo9Wjy7a+N1cyulzOpvxF7Bxi88/8IMi0Pv5q
         4E3lcuQIBOK0/i2tTuyFm8JwtaDdGcuWhY2BueSiSp3rNQnogKKXFO1lPYu7IYl1He3B
         5X8KJEtQjBuECT31oKIL2dewIS1d9lpVPpYgIWPXUocn7fiEeICVWvVEEp09nrzClhyK
         o0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XJ5NKw+96lAia8ppHis2DDzFr3ywsPwdOaiLM3ARStU=;
        fh=hwEe77+mxkCCP0gM62Ux8utARB1lEEppqerh7jEPTo4=;
        b=lIt0+Z3nnMYTDaZg5TmVbOhXFYfQMNe+IoKVjrWmjnq5tyh8AitJ3NnMXqPynqMOMQ
         6dN2gymtTEm3l1szmWGPiPrKNfX7s4KnqAhKMymWXmi6RWDwgmtgbpsq4DEtszXhXZN9
         xDNT2Nzj6uQplR6jJIoDiUexsIpGtT1dR7KpxvSeB//rQFDU8M+B7bdJ3bzMTIfwAF2r
         QwOAEuumkpWW55VZq+emqtEXwdE9vpYB8jMuZGVgOANvCo8jyW0mvRGDRu/mPEG0gwsT
         mL4hGlLdNLODbpnxy5tBSlKYQv7U8WR4OtO80QOY+AnqwRmO6pdY2bu4nZLPo2BYZFET
         KcsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785869504; x=1786474304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XJ5NKw+96lAia8ppHis2DDzFr3ywsPwdOaiLM3ARStU=;
        b=QgmQKUZo89K2y6Sp7G/McW0ZOZs8gNbFmTQSWmo0EIGJ8yt5dPSJR/LVm0clm61odA
         A5KR3uDBLJsiGUmhTvkDTrIe7Y34cshzOJQWJy/9JAz2hE/N2/ZZ9IcoX0ISjJ6tK76j
         WqCE7cNNZg8FZUFXbJUvtKko8jFwGruLFBIhF47BSlEYGvCAUrRtP1r2ngosI+u6jw4N
         DjxtoyPZcxh1ukLSLe9e5LFyNJU9NicAE8e7UHf6MwFECAt/rzZnihTGB6lLY/E7he6I
         fngN6/fhTamdupF/3bUf3+Udn3fZJZmOSVVu36n5S5Xm9K41LQ3Chve1La4JJGl9pnsX
         B0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869504; x=1786474304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJ5NKw+96lAia8ppHis2DDzFr3ywsPwdOaiLM3ARStU=;
        b=rLy8eYgfhVGKBaFWeYXWmIHFzo88MfvuB8nFKWuTz1haGzbPpWgSMX1RpL5v+qAxpi
         fgUnCduVC0605cJOnwVXrVnxx9KKWY/f6tkkAo9XVZCpXqq+k/LsN27wlXWMPc2JhCW1
         6rlCUJc+P957NwZe5KtY+CUWDTKXbeqjoWDgQpTOw4wuE3nh37tFux+XmC+VnxMbJpHO
         qQRAPQf2IPFLfwhPj9WdpLopH7KnW9rGXbvszBSB3zltH2MZyhw6BHyyvYAzhRVfkdo1
         xqpXy8GJPII6rXgfhN+mdxgf73Rz0DKoli5IxYNGaW9swoJzcQ7ErqXuo6+OorZ5i45L
         1OWg==
X-Gm-Message-State: AOJu0YwzB/R4nTioXnYakLTgO+6Ee5H+KnBLcOGhcf0NCIEV5vXbH/iW
	E/Xy+HrD6RnrPVUbMtKjpayMCd0N3rDWsstEC7w/Q05d/jXRDEL3M/CitXcbhuOdqPw6J4Di9N+
	BkmArlCALhvomhIs4tq0rxVoNlf/pGwqHNx8+
X-Gm-Gg: AR+sD10LZ589RA1JbOgIQUfPlT/HNVygEYf5jbjV9H35qfZSllmoUXmy1oH97wZoJhe
	nT9zot7fp9ReHVLHFaecShtx/21u9Mew9+PasyXw4zQdBw7zdcwTOIYjpd1+onKWxNwONC11NFh
	vemr370++jFw+l0n1Zwg6Vn8t3olUMoyxLffuKCtmvFCcoCVk7g9CSSYxB+cTzyjZxF0PlJ2VTS
	s6FCuLFN7aeMGtwHveGYxUJsrLZ+knJvm7iy7QNX8Wx/C+eLxPG4w+26yysS5RC+szXKZjsnlkX
	Hc9Vf0X0Y/NacVQFz/MiLBKguHN1TZI5z6py2dgrlyC0
X-Received: by 2002:a05:6820:1907:b0:6aa:d6bd:f6e5 with SMTP id
 006d021491bc7-6ae97033850mr616710eaf.35.1785869504031; Tue, 04 Aug 2026
 11:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804182510.27921-1-jwcart2@gmail.com>
In-Reply-To: <20260804182510.27921-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 14:51:31 -0400
X-Gm-Features: AUfX_mxj3iIR5p5rg3w25oe7146UPop55r6ropyYT-r02l0kkiKqotc3Y8HgMQo
Message-ID: <CAEjxPJ4Se+Mx1tCRu_PzC9J=ONgyG5_7Bo=4FSiHzHqdmUCX6A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Non-mls polcies should not have any levels
To: James Carter <jwcart2@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:25=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> A maliciously crafted non-mls policy could still have levels in it.
> There is no validation of levels for a non-mls policy which could
> cause a problem if those levels are processed somewhere in libsepol.
>
> A non-mls policy should have no entries in the level symbol table,
> so check that the symbol table is empty when validating and return
> an error if it is not.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Triggers a test failure in libsepol:
Suite: downgrade
  Test: downgrade ...error reading policy binary, version 34
(downgraded from 35)

Error during downgrade testing of Non-MLS policy
FAILED
    1. test-downgrade.c:183  - CU_FAIL("Unable to read downgraded
binary policy")

Also typo in the subject line (polcies).
