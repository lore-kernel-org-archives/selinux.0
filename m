Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA46770F6
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285734; cv=none; b=Y/4oetV+3zT+xm+WKdkM6uDeygC4tV2Q1iYaRYNPQStt7ka2sOdPdeeZziUc/R+MJgFkmGt90p9ni1okVXsoin+VSijS8EHxPZAWE1gnS4u4T2doQ0T1O0kDYKlWiJShdH5hbx92HlNgBrOgBG/dH/DEe+BgK3yuP/V+1aKQeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285734; c=relaxed/simple;
	bh=LjgoQtxv4gyUNQRcuYrHEjhkW3En6/G/CL7ZCsjyPL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erek7+4RVuBysPmmWla38DGyUUngHmnfxCfeZXrteXWkize2GTDKAa1lT1h2iFXyt7Uq/ccHUIzYCs0LNqrwsV05SqjBTfqBV2n4kuVIUbm2ggZbTLOvI47k9AytQoq8Qf32L4+BjFCql2lA3dbkf6VW6nRbve9+7PsIUK3fUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eXUW73ey; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eXUW73ey"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e05e2b2d88bso2419159276.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722285732; x=1722890532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/KBuS6gA8+ijVhpa4VFsZhXJ17iIFq5yh3hEXB0yNw=;
        b=eXUW73eyROJyR9mZIG/58AyUaZYY9AIp9wqVAUPdRrLV/tj65eSN6lJuDu1XLVmZCd
         of5q13GYBC6X5U6/5Mps3Wp4LGhkIanTpUnCFbZxgqWaXLiBuoVDjecctONb8Zl8JPBa
         KKaLjESY+2e8cd7CU0rdRdYLrUqIHdh5WYGtQ1krUgCAD2FtYBn2Jlm7CHD/6KfNYLY5
         qn8dGdtjtqIzEMqLru7JLb3f5TgdwFp3j5KvU6IQRHEVycnR2fqpfghF4HDL4zsLqelk
         9UTJMUPj6Yn9Tz4vV8KseXFbKPMdywhSn/ACx1bfVlmizJk7riwjRYeeUDsZ/6exdLV7
         HtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285732; x=1722890532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/KBuS6gA8+ijVhpa4VFsZhXJ17iIFq5yh3hEXB0yNw=;
        b=WysFkzC2FVtn7vH15XxYOyr8Cqw0z4LBfNWR4FO8prfLsQ/2Fus99BtqjKMs0i1HBm
         cxjy7xykm458KrytLeL9c8TBAj9R75mydKVGR6TQpE7/jz/9StMtsNV4Jnb7dQvaNplG
         slJdEa+9wwoyhCPpOoraKC2i9goNjbxlwlf8qi5F4Wnq99faHH/WXzlCBiQWhZXVlAUV
         G5OveUNTyBc30NIJCqWBAORxnCzIJKqm2rid4VGGbScJnLpS3T1oyrnGVlF/XCndDt+K
         a2bYbCZPajA+8SZBU35XYmDyt7O8865ThZuhXgnfAlFYsVUbXBRMSU4XkISXyi5+6J7q
         Zp8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ16QUViAz037dHa6D2gAOx35Vif4HNPq0NkSBEVc9a+lXeBZFjVfLAUYk4sKgygabgt2/cy/4F7AAvDPAmO61LaOoasu71A==
X-Gm-Message-State: AOJu0YxK3XBfoZlBIenWKU07Gtuo4UhulGYhmj/T2N0HEez0axBgA+22
	Pg+kXFkDbdty3rP/K6UtMGz1NZynMcVnNT4r800/Kk7EoIV8CXseicm6jRwQNy82VahCazfE2nn
	GEA6JQhEMBFaT/uwQt6++CgywpZcaIlJgvWmA
X-Google-Smtp-Source: AGHT+IHejU8z9VzhzHf11AFbhjZP2MQ/D23CPlqGYdcreB936eHhshh7yOLlkNZ4nfjKNdL6tv4hUXFGzL3xZp6O3lI=
X-Received: by 2002:a05:6902:1029:b0:e08:7607:bbf3 with SMTP id
 3f1490d57ef6-e0b544f4af6mr11423230276.34.1722285732178; Mon, 29 Jul 2024
 13:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712014534.1705340-1-cuigaosheng1@huawei.com>
In-Reply-To: <20240712014534.1705340-1-cuigaosheng1@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 16:42:01 -0400
Message-ID: <CAHC9VhTVXe_XUjnYPK7zkjkrcmfmH9M4PE9oshwZocD-TDbNGQ@mail.gmail.com>
Subject: Re: [PATCH -next,v2] selinux: refactor code to return ERR_PTR in selinux_netlbl_sock_genattr
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:45=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
>
> Refactor the code in selinux_netlbl_sock_genattr to return ERR_PTR
> when an error occurs.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2: Reomve modifications to netif and netport, and update the commit mess=
age.
>  security/selinux/netlabel.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Looks good to me, I've merged this into selinux/dev.  Thanks!

--=20
paul-moore.com
