Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998720E6F3
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805488; cv=none; b=JE0YEHbdX0JMdTjXK/ksuEmLT2ibVFITelfQMSzGYFPj6Gjt+DjU3kkixL94FNO4INwxF5pBKRs/0jfw1grT/d9TU1SyIHZjeO/qSf0lLKqgJWh3oU8KcvVn4ROX2nr5lkFFsobMaXQc56EMXnfEhYySwe6J+DOrkJ/pwAa3cMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805488; c=relaxed/simple;
	bh=Vbq2fnjWsIa5LU7G3dOkVwugiOVhkVuS7e3sOOZ172A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8tt9rWMQjnT4SXBS3pfTbMo24RQgtr8uqcEfhJXFHSfw3LBjLFIZmPkidcrcMazqCqJ0M4jDZQDZfH+mvAUgASNXa2qG+ZdmObpAucYay/F/BcOoHfkMVMSJsdMUAcf5x/dtiJRPaMsaN+D+YFs8ofD4pj4RDXLAGoVPS3Qvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3XSQa5X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3XSQa5X"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26c209802c0so10190935ad.0
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758805487; x=1759410287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbq2fnjWsIa5LU7G3dOkVwugiOVhkVuS7e3sOOZ172A=;
        b=l3XSQa5Xtm3zyBIjT4TXtmxZxb1RkO+43P5kPiUGItVbez8JEZO6vT7xuC4X7fHmtC
         hTQk6h1xmhVkQfhu+GQUSWskd6aRxotNUFjuxgadiO/lrPN7Rqwf58pWIXkj0ppWCt+h
         iWBqLypcGqDXySXG4bP5GTQ1hAvGYdgJaY+h1Crq++cm5YGqCm2WvewBdiZQcLFiUKeg
         xBeQqH4fTJ9i1xMq5wBeCu+dX8MR8IxJ9y8setrgSiwzms5yXLEDTJWREVXJ35Hb+whu
         h63cGLxcqUnS2WoyxaveMMdunSank+nZC2zoExhxTRs/RfoH9yu4xpb6ghd2RRJq0Kvh
         ESxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805487; x=1759410287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vbq2fnjWsIa5LU7G3dOkVwugiOVhkVuS7e3sOOZ172A=;
        b=a9Q5WxR9hsfmEww13AAwxlW+ZOUt5JSm2KoQLHmSZjjjX/A4pU3Bs2eQT+6zW6Sdn2
         6MSXOd2qzyN/nceYVK8sM2pqDT9rnmMqqzWzMBjum703r4OVtkU4NPFyHV7fg4MDX+eh
         IlF+Vxu6pnA2etgrU6x7UJ2xyC1lREaSOpwZmTYVpXSjTdNDx9YaoQG1pDnsx0hQ2mWt
         xf76w79qVN9sZniN9I7/xzhXJvYUa49X0Dj+lxdbPWnDAjpGhmhVqIcDWV00nJpWbIqh
         C2qAl3b6+YnUyYLoCDxQhQBHahFg6IcCFC0Huhr6UEXAsMvfTXD+tIMsMUl1MuQ4UheC
         f78w==
X-Forwarded-Encrypted: i=1; AJvYcCVBZ8wQFHqseb+9X320CgCQX3t3WCnozeyDrlSPpLpdJJhkq4Hp/PGg1bALX7CWzfyS01jlNfg3@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUUJv0axzMANeX3pouBSG6rXi3Rc9AEoh060iGEuMQRwTNlL3
	gH2uPaFUdeLEs1+PBvxYh5Xgau+SNd3AL4AZ9Yd/6YEA59+cvPY6P54rTrjevEWe3/cVU07NOBL
	3EGTxfw91tpxGUerCZGEdv6eEMwnx6VM=
X-Gm-Gg: ASbGncueqXeE+6ww2BQlm/cdxT1AVCQ99kVHzNTqlZ0EY8SJD+z6H4Hp2RnAN1H3dC6
	mFZrbbObCEdoaG5RWX/F5AxtBTwCAuBfe7kQcWi7Rj2sVkacF2EqbOCyGUlYuuH5Vq6Gio+q1tX
	iclmO0Vq23hJyTnno7qe+fO93s1w/gqkQ7YbF0k/obxwgyLxnF1bhoK6UtlDWF3w2Cn7SQRXd6k
	wzfjxYxgYkniCLngg==
X-Google-Smtp-Source: AGHT+IGFL0wXW3+s7m7m0LOiGIi3VtOpNcP64AT/Zj9oOIS23Yp92ruQdWHlcOT2D//NM97oP1jBAL5qR5Ztn5frCfM=
X-Received: by 2002:a17:902:d48c:b0:248:a642:eec6 with SMTP id
 d9443c01a7336-27ed4ad2dabmr31068965ad.50.1758805486775; Thu, 25 Sep 2025
 06:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01> <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
In-Reply-To: <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Sep 2025 09:04:34 -0400
X-Gm-Features: AS18NWAXJ9TN6E2IEFi8B_1U02UUmhLtJMXpiXjBiSX8NI949JSpWkj-q1mAqPw
Message-ID: <CAEjxPJ57pcmch_Up7NB2oLVs4254rDBrgkZgmJqkWi5URNDPmQ@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type transitions
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: juraj@jurajmarcin.com, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:30=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Hi Juraj,
>
> Are you still working on this patch? If not, would anyone have any
> reservations if I pick up work on it?

I would be glad to see this work brought to completion.
