Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97483B584F
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550624; cv=pass; b=uOT+2Q7Ycr1uW1kg3REU8F31/VuVL7Qom+siuRnZuz2cAAI5DsL5xbnTeUgLoehvwCm4PTzsxPhQBSVmjBpbti/dpS7HAcWmA2lArJ2ta0Grbpa37nscniWhDEW9Iap6TbESQnEXn41iF5ZdZ8dYi+C1NNL2XIFI2bqhVgxRvwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550624; c=relaxed/simple;
	bh=Lk6B34bwO3pjKBrRvT9f/chK3oJA2wNgGBr96CLQ8BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhHuRI9f1qJpt4L89Dmo8Sl6dPfbTvLzJ2SH9i32zuBmpGuDELiQnq+y0hlyqbEX6C61+N4OzddSj5tLfZBXDqLkA9hzCtK8FiGXICAkI0QPoL0PKGrmdtdZXBqwhQd0UJK1t4vucuyn/MesuJn8YaM0VpvFz360R/wOLnVO24s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFQwCSJu; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFQwCSJu"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2048993a91.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 05:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550621; cv=none;
        d=google.com; s=arc-20260327;
        b=RPuF8FiRKPaUIEp+j9a7qvFSCf///oA1IQDyBLk9F9K3BgNufjFAucQC2c2LS5bEP2
         lBOLZzACT4IlMikorfi42HxyCsDQ+mEUBJvrIjePN4x+Sbpzsi+7NsNlw/3hL4FbLM9+
         aYHfrZOQOn+6rJfk8XMdi1gR92Z4g8ZCttg6G8lifJjTxY3ZbM7hDs7x7vJqbcLi9VUM
         sRJgmy/PcFfGGutjyOy0gFp1J0MizWxWusgC6X8E3CFxGaeBokPCdq5e+s9YlrOXo2uD
         MVXQKFyJPgar/101fLjMMdJjLGcZEDdFN63V3YTOrKldbHrDUWHC6i2VcmjO/jEIGpEv
         vozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lk6B34bwO3pjKBrRvT9f/chK3oJA2wNgGBr96CLQ8BQ=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=HKKSxh3HfG8WlT6cRF6HU3I0slim+XxmeYucE23SkJVRXvygld7Pd3auNqtz5FF8f3
         F9JtPp1+SMRwp/K9whlWNkoypNQAjAei2KwYnE4JfsyhooApEGwHdrQ9QDZBkMlILMrJ
         lvDnGlAF6Uie5X2bLKOlyQ3Piba4sUrKuXuAFH+MAG8C7v8iQgsUREWxwsi1HVt+C/OV
         tOSE+0u+OHqfT1NwwFusTIrN/F02hwF0ZKRcYM9sMVeRFmZ8uyltmjlCkXpTE3Se/cZN
         x1EGu+UQYM4ODg+wOW9z7VAHtRDtswnKm5YVamge31d57L5tWFeVTrvfRCMemm3xUfss
         I2Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550621; x=1785155421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lk6B34bwO3pjKBrRvT9f/chK3oJA2wNgGBr96CLQ8BQ=;
        b=qFQwCSJu3i8xLSysz5+TJuByFvkN7U7wPVSle7qMLbzaJFJgkMo1NCo6e7da3YRxnd
         NIqW3bRohtBlT43K5cS7gLHTawRVyBmmP8olbbpKBZmnEgxHZzH483Cok9P03JnWkFB3
         KhwZzmwZ1VAHHeb6sraISVg8//yaKf797Uj7TsmBVIbjFokisKHIEFa/QhX6P8ZsCYRc
         Y9zuOq3fK1kylzUhpm7Dd0d9fyRp0KIw7l76wAW4rKajPf+mw/6D+b/MhWwFINJ8kG05
         zlaA1mBnxHJ9mQYI7Ttz3yaCJKf3f2MOlbcAueVIjo57XAXsHmGM58nBHowr/02Bxrnz
         o+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550621; x=1785155421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lk6B34bwO3pjKBrRvT9f/chK3oJA2wNgGBr96CLQ8BQ=;
        b=JpZVGScDdJuuy6XLHUULkC/R7vTlcQKCSjRZ+RmSqNqJv3ZaA1XyGIWBagCtCr3h9k
         nB497QkysbmGT4lqvaGoUrpJd7Rn36J6G84xIAtMCwthgUNAkkrUOT6x4cGj4c0QbAaX
         pysJ2v04qPxP8e5WsK4xRIP/INApxk6XlS5E7nazHlNt2qhXNzCMuE+aMGs5JKXVI5yw
         WUH0Vm1o3FeAMcpXzNY54UWhVKyRSQOP7UW1j3SnGiVMipL3+s88XM9qtyS8bHrnW43p
         sL452lvWsAFQpQKnvqvr7tQaAht3Hmax+uTu8z+aPjxni8S8sC88J5xJD+hNlwsLWwNz
         H50Q==
X-Gm-Message-State: AOJu0Ywwop4z+Q8yEU5Zydc4nlAoLMl3kbYQuMi1qwfYOhQMTgmz9ibJ
	boM7h+IbRfFJulJblEskuCOO1eX1+xIkJERYOXdguTjMNC+OcYsPVDZ+jjlq9zTphR7jlOzuD7F
	DXYgFFdfv2zw8FsJVgGTd7T6UcZXe6sP9eg==
X-Gm-Gg: AR+sD12/IgA5PerasvGBWrMf5aeBUAEPpr88j5BvNTCSVeJr4PKPFxZLRgADer+WghH
	QCAlRALpDWIhZtQvul7+PiZP5RHYPK4L4aMfF2OqbzaXdy0i9+D5hSa9DDC8GhGl0nMYnwjyriS
	+N46wHI/iQzBbIjsiGVV5emDgU2xnwuM0Kgm2d1C1OY5vubVhcLn+ErRYp0x0gorV1RJk1aIcI8
	G7hpE47gVsw+y2KwsyVvvhFyWnwUwquvCMwOTjkIVn85RKSMmW+a9hEbkmwlQ==
X-Received: by 2002:a17:90b:1e44:b0:38e:7080:b4c0 with SMTP id
 98e67ed59e1d1-38e7080b7d6mr4356865a91.10.1784550620955; Mon, 20 Jul 2026
 05:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709200756.2172-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260709200756.2172-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Jul 2026 08:30:09 -0400
X-Gm-Features: AUfX_mwcAlsz7oKUq7RnYm1S5lir0g7nSipcHwPzNa8PwWYA4GohUQY7M6-sIII
Message-ID: <CAEjxPJ5YCquEY93a79JpeBXEkdunJO1syoo6QdaCwNO60Uuk9Q@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/setfiles: introduce -j for skip_multilink
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce a new -j option to setfiles and restorecon to enable the
> recently introduced SELINUX_RESTORECON_SKIP_MULTILINK flag to
> selinux_restorecon(3) to detect files with multiple hard links and
> skip them when relabeling to avoid unintended mislabeling of such
> files. This option is recommended when relabeling user-writable
> directory trees.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
