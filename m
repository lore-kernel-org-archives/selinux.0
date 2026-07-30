Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA843E4BA
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428655; cv=pass; b=sU2522eL1hwZhfgDmTUD2pOHXon854+Vc9GYGIvePE3oc9mGxRgRofrf5otXlU05UzheVzyScnGH/Rra/K8+PybG5MD13DNkTgNKvzC/yZgETOsnkT79JLlwBCOEp6rS0ZAZxPeXMhgvtangfD5vNxQrSDoWXnLPezItmxXdhwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428655; c=relaxed/simple;
	bh=lzPp6MWsSkLzXPTxVF8/ZwAAPc6IvXRK8A8fsZ7sbao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw+kQtIASzw+YkrDUqE4LRQz95agHAUlp6ntiZcJyLhx6OkcYXht61frR7CELabrdI8Yia7DAenaw5PrT1lY8efSDebXdhZJ41NkUiFq06YtWGzQkQDWoegnADeev9yWwkwoqZSzc7mx793qmO3l9ztZ3lWVApjTEkeRnCGB2RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNUIpV2S; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNUIpV2S"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-451a49abd8aso32426fac.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 09:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428653; cv=none;
        d=google.com; s=arc-20260327;
        b=nQ88FeKuavVqGdNNpUGQeY429i22uwO1xW0DMF6t7/z9aWT/8Iop+O8o1pi0q5+PVo
         UlLtf3MQbha7+Moagmhtc8yv9pb55/jYSG/fx7vZMkAktDdzgxHYW7psLfh+KC77HPkT
         k95pOhJth8O3UW9kqi/YXIjBhH7nuIvvuKqk1RXgIV7mtjd4WHCWrtcGiY51VRvlbnRu
         rOuBNWzBfY45BIYbDMIzXaylCdlWWjITQFp1oxZUw33xUXQYIBnDbDxRRzGbYSuiTBKP
         yH4eRwA6IQHq/VyUnmdWyPf2j5Kba5YbmsQBC7hl+tzgNRlc8WhnasuRhHEiKK4/slZI
         sFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3pI2D1dCmbt7Gdob83hj3i2q5GYuN0hXpP3QxPKCx0=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=Evcz1tBN+9xgC+EPIXOfIfWBy2X1jNKmF1rOrlVVVG7UdO5VWk14RGtxdxu8KkSMzV
         eYhpj1wQAXvSPVyFkH4ytimZeHOItZ3x2DUdIQ1gKba3t5IpZUT/3TJM2tJOYqryas3y
         FgAdYcB/tO91z4JSqvV5kn/kJ6zWvHivdyqQ8n3EEFw9eYD8LBfNVx16HPdbjZLq1Rjy
         M8fqrhAl3B9wguYhd035dzlzK5XXAeRsF/3D26vkHBSMvmzmIPqeMAgLG0PZSmSQ/0Ov
         GrZ0e2NEosUwepD92m0kg+ARPXGFWQeZMaYakgBbcSaxCHKEMIXHxMVVnZRvhxNjI9eA
         fJSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428653; x=1786033453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3pI2D1dCmbt7Gdob83hj3i2q5GYuN0hXpP3QxPKCx0=;
        b=qNUIpV2SIRc8C4FJCdACNZkEZr9u6AJr+IjZ5Bz/CGCeP29XucSISIWW/0gI28vHV5
         CaHquy84P4OPyTR2cQD4lTBjwP5E1l/O6tEIjYjKpxWLUf5Ev7BkCw1jKkumj/7S85hj
         2NE3xJCldiEFM+mKPAsMqgfmj34kVB5uJO82VxpYCOUblet2Lw0q0tk+X17D+DfUsdFe
         z7c/ULRyu4egzAvE9PwylWDvm9LniicsiifDJEn0VbnaCmFRg3es2OyNn8CdF+vg+ci3
         I6EEewuQTqQZ7rdbl2WKD9oEGQFWEZ5o9V0SYcur0YSdcq8wOp4+Rif6ttAif5s0wCZ5
         LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428653; x=1786033453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3pI2D1dCmbt7Gdob83hj3i2q5GYuN0hXpP3QxPKCx0=;
        b=Kcisg8nur+uCy6g+7Lu/rjpBcoaY4IEJhXUZZfT33we1c0dSma1mmsVkqjGJ0KPYAw
         br6/IT34tv+OLokX37v2H7gNqW04kLSWNEqpGYiXzpWdDZqoNxlNMr5E0iPSdDaAd6h0
         amS/5i2PUZWzKGb8288u/cPkvA5wjM0Yk+hw2eeJMHAmVit8SyH90GVb4lbZh7lh1iOP
         3BcU7G/TYUl/IaBcA6o07yWf9xte/A91h+xu4ewGfIp9NR+fFtD8NtaqI0vghRv9sSaN
         2AE1HcOmxnoW003T97FBKX9C180rH8/pRzyMKIp+mEFD8hlho1Pm8XCdx4fpVqsIxk0i
         SQTg==
X-Gm-Message-State: AOJu0Yx6fXJdDxCByqk+hzNW1wi3oI2bQ5iS3IqZLGLrk6WVAa2uCnAn
	ESpOOPDZFAL5gBeKQJgTq9U3f4lwOlrud66PsTwmggBw5jA/sj2fnk2qWBh0/fw7K/hCyVGmxaZ
	gVq0xaupGG95bpX4qSzwrk99+4SgQBWg=
X-Gm-Gg: AR+sD13uIN9jCf4q0s+36+v+KE+XDe//3bZGiC+in2KKplMtS4aijxGDOrJDGgR/5nu
	wB3hu+vmcug5nZcycl16xVhHE0vtiKf2uK9+5SYXYMbBD2Jr3fDBnirhfuge+LzneKPVWXlOpFl
	4Vfi+LgoUBFit+D35glh91PFXl3R87aePTc/bNYq0akMyc9IG+gyW+W57dJn++VW29U7rsboZ/Z
	XRc+UL+IljTJ+co+m31LWJbE7IcJ779skDipwjHZHmvgxHIKPiDEmEfYN55MtQH/JexqvyZ2oqu
	FrGLqxzZAYWYqrH71E0xOJ/2wxZAw608SXEncsYePbt0
X-Received: by 2002:a05:6870:35d2:b0:43f:ecf9:2d3b with SMTP id
 586e51a60fabf-458c0f752cdmr2119634fac.19.1785428652554; Thu, 30 Jul 2026
 09:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730101840.3224405-1-akkohli@redhat.com>
In-Reply-To: <20260730101840.3224405-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 12:24:01 -0400
X-Gm-Features: AUfX_myliOVNo8_Zrvm4vJM3AHT88MnFztr7pfdEuELM7sy4ikAh3AG3o--dtPM
Message-ID: <CAEjxPJ5kxyuZhLixm4v2ecfaphpmeW4U210-+4d=++X1fdfQaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] checkpolicy: extend bad-data and robustness tests
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:32=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> This is a follow-up to the checkmodule bad-data harness already merged:
>   checkpolicy: add bad data protection tests
>   https://lore.kernel.org/selinux/20260710102906.3059833-1-akkohli@redhat=
.com/
>
> Patch 1 adds negative .te fixtures for duplicate type/attribute
> declarations, type/attribute name conflicts, invalid type names, and
> malformed role/user stanzas. It also runs the negative suite as
> non-root in CI so the unreadable .te case is exercised.
>
> Patch 2 adds expect_robust coverage for oversized generated .te/.conf
> inputs and a large attribute membership set, with tunable sizes.
> Together these bring the harness from 16 to 25 tests
> (1 positive + 21 negative + 3 robust).
>
> Changes since v3:
> - Drop trailing whitespace in run_tests.yml after the semodule-utils
>   non-root block (patch 1).
>
> Tested with:
>   cd checkpolicy
>   make checkmodule checkpolicy LIBSEPOLA=3D../libsepol/src/libsepol.a \
>     CPPFLAGS=3D'-I../libsepol/include'
>   make test LIBSEPOLA=3D../libsepol/src/libsepol.a \
>     CPPFLAGS=3D'-I../libsepol/include'
> Result: roundtrip tests pass; checkmodule negative tests:
> 25 passed, 0 failed.
>
> Akhil Kohli (2):
>   checkpolicy: extend bad-data tests for type, role, and user errors
>   checkpolicy: add robustness tests for large policy inputs
>
>  .github/workflows/run_tests.yml               |  11 +
>  checkpolicy/tests/negative/bad_role.te        |  13 ++
>  checkpolicy/tests/negative/bad_user.te        |  15 ++
>  checkpolicy/tests/negative/dup_attribute.te   |  13 ++
>  checkpolicy/tests/negative/dup_type.te        |  11 +
>  .../tests/negative/invalid_type_name.te       |   9 +
>  .../tests/negative/type_attr_conflict.te      |  10 +
>  .../tests/test_checkmodule_negative.sh        | 205 +++++++++++++++++-
>  8 files changed, 276 insertions(+), 11 deletions(-)
>  create mode 100644 checkpolicy/tests/negative/bad_role.te
>  create mode 100644 checkpolicy/tests/negative/bad_user.te
>  create mode 100644 checkpolicy/tests/negative/dup_attribute.te
>  create mode 100644 checkpolicy/tests/negative/dup_type.te
>  create mode 100644 checkpolicy/tests/negative/invalid_type_name.te
>  create mode 100644 checkpolicy/tests/negative/type_attr_conflict.te

This series has been merged.
