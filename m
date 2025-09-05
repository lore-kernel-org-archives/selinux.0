Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F830B51B
	for <selinux@vger.kernel.org>; Fri,  5 Sep 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090750; cv=none; b=R6BcE4z6oinQA9sEJDZNqXNAqaApLoqnrrY1IejxSsm6TiwKbaoPpySSkT2c1WqgvbxX+pkC5jWiJhqnBq/TCFHPX1zu+HZ9986suLOB//Vzfd07cMf/EZvQ5LXLdQtob4ohczr7H6cCndKptodnGjpUi1kcvcDZ4Jid5XlestU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090750; c=relaxed/simple;
	bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG5EHs/4ThgOXFT/U+CNp/JcfwwktDqvighzcdlXNL0y7yZVlv3LIQuW8kj+gLJQ8DP0MFVA8HgecLlO/fRxRA8O+mXFmTJdt0Lnt8DZSe84T3MZfA/Nen/jBRotDyk/0nlHIuTYd+OxmBzXuuzDe8uyT232DTtbjLY+HQtqMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fLpfcSqw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fLpfcSqw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso2066357a91.1
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757090748; x=1757695548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
        b=fLpfcSqweYhlvGsJBaBERif/W2unQOUi/CBPBVtzv48hzCxJ2bgNiZFWBuPY7z6uIw
         asrjE06QoUl7R1FxJwRkO9IqHFi5HUHx8n97topdIZ+Pn8eF2nvuDq0yhZXPXxVzoBp6
         eibzv5ih27/1TXfAO5A77vR2rIScpz9q/TAMb0advI6vDAyZezIjzda9J0z0FJCTPCQd
         jIzy9YJn71PrWaf4hoghehXo4+FAGqHyEOs7nXgpUauZBLMZTlnbbMUtubv/LuUqVWaW
         bd05+8C2hBynkmnAHAywzUsbwT1V79pTYQs7GiS0oSkY0Dl5mn6FCRDeNBLdBJu5Syzj
         raxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090748; x=1757695548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
        b=TMNDeZGq4683kpFNPl0iRQgITLs+RuRsLUKf8yKI1y6cQYNY0KP95k9VVrsJ2R/YZ+
         11dtzXuevRypnMIZa0XtgG4CnpWISbuWEMshTxUA2+rLTvGGXmmdxhnOUYSHmhmTHdZu
         0FkMPy6ME31SjxbRSgt/VAGjLuDkXxhx56XDJljP3pzZ1HH7qgxmDcRlVa3mk3zp3g9q
         uEVwlXSLm2YbR7wEenGEvAumi7ObpWmQLfscXhSbM0nLU+5mh05KD2ALTUdvP6kaZ5Gz
         DnxLmWRPB6ylVGY1U1jBWsXuGq/lPs8b6fGgRgIWIUphkZaZgGgJfeojaye4TVWwXg+K
         E/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW1l6BJu27nQYyBjTJ8kihb9VcYH3uO8zblQLJPw0BXftX7LvCSV7iOi+CvMYQ/GsYgdEPU8qrW@vger.kernel.org
X-Gm-Message-State: AOJu0YxldE7YBesKcas7qBZ695sQoN7UGjUWg2wh7QC1SUTUQnCBPfq8
	iELe+1W6lKbkURbtr30h5qyCF2jsgQrj9n25O+lQL2cSKVKuWzCr3gDV2V+KyWrF2929RcPIzhE
	jyW9fsns6gwK9Jk/HcsQEBfYx6DM3d7aZHgOW404q
X-Gm-Gg: ASbGnctUeQUeqYmU4qb/m192fzaD/cpCpYrkqNSwgBYYewZrnx5mtNVYLBrTW8nvNHT
	IjywZfRuJkq0HSCDOjsXkPMIqF42ir/zm7HHw2uHZn12Kr+nTdjvHakrMLwKz1+ZyhHRO7TVKDN
	N49HYrEWLDfvCA7OmC9MlQdNmJ6b0OMZsufwS9GNP12yfaVbA4vvHP0JIHGxE1+8trqzIzp5Us7
	mVBU0ijdRG5J7Xi2A==
X-Google-Smtp-Source: AGHT+IGWJh7u5PAd44ZJLulFMJ+7r7YGlUtbhoA5hYCPYuJqnmlWBAoXkvcO4V5svJI/aCAPBlexkQfLw/LGFbCdMuY=
X-Received: by 2002:a17:90b:57ce:b0:329:87b8:9fc6 with SMTP id
 98e67ed59e1d1-32987b8a698mr28292575a91.16.1757090747582; Fri, 05 Sep 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905100454.685866-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250905100454.685866-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Sep 2025 12:45:35 -0400
X-Gm-Features: Ac12FXzPdJ_HTnyZNod5pdaRfBqEI-sY3U7IFCG5_usISf4LjaTZUtqU1Skuq_M
Message-ID: <CAHC9VhSW69hmvduJK1cKt_XffiDwEeHUKAtJ3YLbohKWff0+bQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:05=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.co=
m> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> On mobile device high-load situations ...

What are you using for a SELinux policy?

--=20
paul-moore.com
