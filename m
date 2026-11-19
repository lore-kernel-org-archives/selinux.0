Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795096211;
	b=s0gDAQR+V560IZPQfsbEOtxap8JIjORMICzTKql/ucdv7Ci+OFC+8kQvV/zL/wdF5rfv
	 TZ+WG6oz9DK7TH+EawWmSJuh0wWIPwdhcI9fycmSDQzsQV1JvjHcOIUAQoqwlTDjezDk4
	 Y68qiwTgW4APF7yzuPjSQnv/Bh+frezF7dt6yHwkzjO+a9cw6YUg9LkcRbMwjS2hC+n0S
	 jt9nHYCbKTJuqpGWHZhdHsc94ol+2IR69fk20VAddQ6lBrEqWFbze30Tv6CCSA0BanC+q
	 uUJtx2HCejPXSwBJEL5JhTw6ZbhFfsfpsxOz+AkDwaVJiRqCBaV1sp49OPimiJZXk0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C/86kkjPGVJfQz5ZtXWqLOtmVcv+u+W33XqGrvfRxyg=;
	b=vC8Cx+f76WBhuc4F3dKlZ+zxaho9HqPdPjZIM6bBrK9wevgf0i6fWAxyq5XP7+e86MuK
	 RHt98oivc+pKW8Z8QLU0eRslWPc4bk0v9EAZCxUdP1uok7FAYLVhJBOTa5S9OYXyTJGff
	 E6XeF7TlrltuQx5VPVNwOOFYBjsQ2nkviP70sLvi1pqY9pqPosfFxsXwH7M8LU7QkVVGs
	 2lB3W6mQGtrMPmSf12L9xQG/SobOg7zE7WMt91UkGBeEHqEt1FPrAO/KTQMWGFfJpvWKi
	 lNBzjlKmAnOh9ciyhh/YdHEPk8jjA7rsae0XHcTY8vuDPHScw7L+fGRPnjIbXkvlFEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1lZJSDR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474C606E870
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B474C606E870
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1lZJSDR
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b4d07494b0so10695647b3.0
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795096210; cv=none;
        d=google.com; s=arc-20260327;
        b=c1+cHjMxEaQv2ny+qVwOdBhqZ7n5Z53Q5k0yhXXxoEopwFPtXCL9DFGcodhnnnlbQv
         CSVrCFg9qaHhg4pqavFfvxtZgS52DhOKeL+/f/ZlqJ+mPhCGC70y4iT+Vmo/nOpb7Zch
         SZePrydeJza+DqFlUpgkfoXCaqEGiu99kRb6PVQpYRsJKWyt0hVus78IPgRMt2qOseRd
         USij2DBi3obqHojhF1hlv6H1grNnbYm+uftb1N4Zh26CaTVexq6IpiNZtvHscTj3zn1l
         s9r/hMwk1h491ZO85gw9ptn2EJnJiu9F066BL8XWs3ejM6I/t01tJnuT323aIjeAMo1q
         J/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/86kkjPGVJfQz5ZtXWqLOtmVcv+u+W33XqGrvfRxyg=;
        fh=fKbHs9HwQ6CWiIN4PUmiAGo4elN4Nn/634DkV4jaSF0=;
        b=bRyrFxkH6h/pt/svK+VA/9Ed36Xu4mGHmAPSBkgvccyLEA6spcvwr/Gt7wztNcR3bI
         eKywyUR76+/vgheDp5b5peVC0n4klt/bxPo/oaxfQte7hRMGxT50Z5Kj2TntBw0NQoAh
         mXyoVqZ/AWOZLtNcnukpVVRWcK+9+lJAGDfm5+Gr5FpLk/3m5q4+O4ViwTN5iCl2g1Ym
         ZRymOPhhj/OBpp2y/J0M5BV27QweNHw9oHvIXgnch9MM/iaYsAZTN6abGxoo4gR9rdPa
         KJgvSQvZ6e12jPv4efEejH2GSbbQ8ss2ED3Tda4OxfAl9K5IM23q5EUdwZbMqRUKyoRM
         wC2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795096210; x=1795701010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/86kkjPGVJfQz5ZtXWqLOtmVcv+u+W33XqGrvfRxyg=;
        b=O1lZJSDRdrv0zGWtDiNkZeSKOblwDF0zl1M/jRpNZitp/6bSQlzOuDfuZuXI4uFur6
         8kyG/S2L9XXmD2t36PIywsm9TV4A3uGFJWB1bA9q9IIJRTEHQ+TmbBwWSsDe9kQDxhaC
         aVpHjivbhipGgsAOy43CGgdDeAsAZBpciuTBl9LTu5GugGzpbhdSwh+tCmRIL50JSdie
         fSsH2cLkK/+iALov/8Lp0QFlUBDCf+2fNrnnAF4kwQuR44K5DGkpw5ro+VKiaUHKBXxJ
         r7zUnS0NdO+PtCkdiAXJeLpeKe4C7A/DvlPVa29xaQ71/a0RPs1+cpuysb00Bszo8f2o
         YQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096210; x=1795701010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/86kkjPGVJfQz5ZtXWqLOtmVcv+u+W33XqGrvfRxyg=;
        b=OdrRcT6BjhRyZqxuo9pMmtwcVuzm3MPUvwpUCNEyh34ra6toKXnpLBQXeC+zBhDr+W
         qJ7TVh30bskNhPKu/prHBcbQSVKZhG3+fOAjda687ewkWbDOx9MGsU5qRGLYSTg5Vo+X
         8PtXbuqlzy+OkygWXhhiqE3Z6JpWMB8Gaed5zo9GyiMxLynE8IF7tMIX/EpwidMbEjFE
         t8Vxz8u7UA5s0YiFtVRhVic/gwQl/a5zeacF2Spfj6815xgtT04mX26hE365EaoaWknV
         IAHvj5DOu4aFUODwHQGiAn+gKJPCyq+e5yxFSQlTRr2HCdhlYSQ5wkR8HOG9lB7sOWwz
         CUpg==
X-Gm-Message-State: APuU4Z9O+MBinXm3Q5irYe+3A8r7gjFZTIrf26JsTjfYi8W4JRCZy2QK
	3k7bC66HYGltfGhvpy4DPS3IVTUCATSo5/zOOcaqnWITojD9x6jGTPCXg/PxVZW61fOdViMjf+P
	eLnFQDc/XOBckh5fKompwP87CZpZ6Lf8/8g==
X-Gm-Gg: AZFdTZd8b6+OwPLNBTTAErOIeNS1HRNDKn45GWtDR+BHkUFLpd5MP9UkKOxLxkMK+mp
	s/SSq+pMmg4Zyjafgl7mEbtLkKDDKZS6pdRsxYANreeLf4JP2+n/SefA7Q+06akEluuAsDa48n/
	pLgyAqCD0R9/CcRFm6ISFLFlSB3tgwNqYHNbS09yH5tfGwdZ4LMptHmU6CejXjyiI90gbaviRq3
	6AZBCIS9LuTok5/yk/0no4Yrt+z55OYp+yJQAf6tFdkmIBywLV+0VM6/UwbBtIbRPCdwwZ47rZ3
	aAKKn++zu2CV52JMtHdpm+oNVmQaDIYhHbW+9eXG3eTa3ST3JuGbzM8AVsRu5XUi0Ra3RcgAoX8
	mS+3GDPV3fqI+eOxxIbuu0E3Yupl08JPXzMi1XQcSVd293kIkp6Pg6NFJ/z/sQ3yuYwygjOm78R
	ZE25EzYybjB3ed34TquMA0SVFzES0RmggZsT1GesPF90vaGm2iTLBnMW7TlFM=
X-Received: by 2002:a05:690e:1699:b0:679:97d1:439e with SMTP id
 956f58d0204a3-67dec2cc946mr389588d50.2.1795096209588; Thu, 19 Nov 2026
 05:50:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119133201.2185-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261119133201.2185-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 08:49:58 -0500
X-Gm-Features: AclHuK_dzbHplcGUxNoaD1gut7ZgfLi529Qfzw6sreMEqc2TyAWgj00QUmaTcw8
Message-ID: <CAEjxPJ4zn0BJvGWFxMg+_=b1UFFxrmYa65aufes55QBsRReE6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Reapply "tools/nfs.sh: comment out the fscontext=
 tests for now"
To: selinux@vger.kernel.org
Cc: omosnacek@gmail.com, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 8:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This reverts commit 459fc1c7f460a712d7aa4ee19ff31d4d3ae193c9.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been applied to fix the CI testing until we resolve
the residual kernel issue.
