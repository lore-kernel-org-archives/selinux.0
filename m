Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9F440A3D
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875860; cv=pass; b=kvZd0qSE77T2zPpsElklyhw1h7uoLZKXm89OzDNRXdB4b3LiA8CQ6d7zl9sqnMCaxOUor+V3abrEUE1sIBjcJCrE/0Cmf91dKBshgGglPPq4Pz/ScObSP8yjiDJ1O7GyFM9LizAhqxuVrE1A42+hQ0IWlv4PAAt7Sih9sIm6kUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875860; c=relaxed/simple;
	bh=M2uJCvu8L4bmV3c3phyIBEBqb7ElCDopfyw+k97E5lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPc5E+IJYQUr9roTASJ0PXqmvXsYr8sXAhCMPeAQRaS3ARMpWFoozaIbPiNrVSZIrGxBvpl0wtW2bOIBgbJ5MkpiWA+BxpwxrXTCeFFLEIXuX7DYOxJTuQk0bAZGKljyycgNRCrkg7RVcoBTyQEV++CtD4+vIGmfAazhR/xUzyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqZpar43; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqZpar43"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6acc2a10023so137629eaf.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 13:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875858; cv=none;
        d=google.com; s=arc-20260327;
        b=aSGds8uZXIonL5bjoJyadmSWfV/NBwAOH2VrNnBKJLD+PI3Es7uRVnRILlY4L6BrgE
         7p+7BhOxVWaTeCLR8dl/igeGy+pe3nGJxmsiy36M73MlJp2r88p0JSK0h6bAsW3rAvLp
         Do9W3o2yl43lyiCMPY7t2WinoM6nqiefl26lINHLOMrgZIrx//qanOz9KtI1PevzYvqv
         nyOfqaB8lmv7pqcb+8EN0+sgY0Jhv8OyaJjQTrIFeTGWhGgO/sIMuE+gA3tgeZk5d/0x
         fjq8mzJ3NMWX0TfZQE+HctI58pBn4AUfNNbnFK2vRN+61DLxwzHMNJQxNNrgHby4G6bK
         gBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2uJCvu8L4bmV3c3phyIBEBqb7ElCDopfyw+k97E5lc=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=NMiE7hM40tTel1RZStPSGsM/h9fiYV+TqgHvKwMEkTj4xtusU+GeOHH0zllajX9Lmt
         6FtNYBhCKqNSYJuV9K5ZrqcX98WxoXM267vfc/OSZPxbDparZ7yYhFw6I291T89R8E2W
         VD9dnc+qIIgJ1YFlQJrsvGrbVD08fPVJVmqGs6RawriKVAGnWZzv6d+a/XmTbklpB4iL
         7IspzUAz4ZM4d2RXzlMKcufcUYu/kP0fQK9n6yTM44W1Iw6Qi1ZB/593K64X0yiuscoa
         cUvZYGXyIXCTDEELXUV6WXhutSWwLa8hAYoETwJ1xV1hgLGqWnqP75WCMlZoIOYT7Y7x
         KLfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875858; x=1786480658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2uJCvu8L4bmV3c3phyIBEBqb7ElCDopfyw+k97E5lc=;
        b=NqZpar43nZIx9qh6dcBgqGZqvgZfq/l9wF47s5hwM6ielmZ+4IbwE24Ak2Sce3tOkD
         OYKesoYM4b9NfCkRz7lXdn7w4l8hJ5ED4BubBCaN8yKeB5SN+gVU7znvlCrpOl5E7ov+
         fywOyEPSBvB8CMmJyUgyhSz6DlC8XgqGIbQb7jEzhwnRS29l3qczbJnZTeftqu7/UxTH
         pR3LghAghDGBnrCMTwYkUoumY2d3CDH9XKPAlwwHY2o26vj399JBZtkbsUFXcfPxxybm
         K37/rhI2n8TvA87NC4ucnTOVlgXC+Y+6QGG62oUTGqjJT3c+xT1Q7+v1yfZVdtBfMZGG
         N6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875858; x=1786480658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2uJCvu8L4bmV3c3phyIBEBqb7ElCDopfyw+k97E5lc=;
        b=n8W3X3tVagUQU+bbXhc+jLpV2MeBXkd5WKK/j9v1+/KjgEJ/5XhSAygFhfcqcVUYJN
         NJ1eFgyRqluZr/MDlxXybHuolXF5/xu4CDe0Qv9+SaVMt0Nk3rLKvM71hQaqBuP4LjMi
         AUuAWUiW7aNgFOb933ztJNrE1SU8OC6RkuL6NOD10OzEdgela6gyQmKi6MFhOhTxwsPW
         9RIMzHArE3VsmEcnH8DoPpGVmMOKzblQLGsTmTjnkn3qJzK2of+wsgCmVLbKEUvGDfgh
         akAxilLoslZNIglv4dLXlsEWjunGSW98f5DOcF45omcfXMOgxCkf28msDM29N0xmImh6
         hUvw==
X-Gm-Message-State: AOJu0Yxj4gb1BI8th0lOjvJKnEEUqk4cXnVwuvj4Oh5jHjV6S3rNd6iC
	cK6BwuP/Iuu2QwFX/sFNXHM4b9dTmuYMge1C/TJLN1JWvCZf11cUKsE7aOMYo0adoRU/o+FzNW0
	I8Nbpi5enb58Zp3L36HXAJHsl6ExlIXc0VA==
X-Gm-Gg: AR+sD12vtJ5IC3WpotWSqxlpQBK8w0Wac5KpeJjOJUfj5OEh4H15FC5LM5rWP/UKWUw
	Cre/aYS6kWs4UjJLfPS+Zvn751jRtnxQqirByO6PI5NTzMnSp8tIRC015iaCgfEumxZ20fUN4XT
	yMJF/IpVangGQBorw5Tw/w1skLUuIZPpH3Br/w4ZSDVHVDisOhWvdvIclgl+WdG6rVmQ74NyIH8
	qrVxn/uTQIAHbdgmM/yeNk0zF5XoVCkDQr5hrhv0ASKR5UJiTahLcl60vXUgrrmA4a/eC5cH52b
	qdfqQLMv3sEWr9N15suT40gBt4zN8WLn/NV1zjykMzVC
X-Received: by 2002:a05:6820:1627:b0:6a1:7abd:2a6e with SMTP id
 006d021491bc7-6ae9702dc06mr550345eaf.30.1785875858011; Tue, 04 Aug 2026
 13:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804183420.23718-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804183420.23718-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 16:37:26 -0400
X-Gm-Features: AUfX_mxI2eFVt_1n1g5Wa9TAl6bDR0gTLdlVTS6gU-9CdKCl_3MMkwkHkuQO1SY
Message-ID: <CAEjxPJ6=CqB9nhmgJQDQXHwqNXz9Z8MivpV6vUW-cJKAb7MtMA@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/check_format.yml: run on all branches
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Enable running this workflow on all branches so that we can
> see its results on other branches besides main.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
