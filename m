Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047515198B
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521675; cv=none; b=HNtt5h0t9FFOnn3hrNtenHUm1xR4qLYxhPB3B8V7JP8ItEKcnDFW1qKNmiI4PmE5YOM8Q4GY5AT1sOIGKJ+jKEUIyyHfcjjlsBcxMQSxK7CbQrIyYSqF/4GQOaigRJz2hlvHjAj5dp5WUv7iZlbO8RMjApH0KYv2DVR4P3NP5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521675; c=relaxed/simple;
	bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QswyQZPaTvb7QX6HH3IshlrjTBsM54qlXhKf/L9ljLVVkNKtIjwglyKEMKWNFmGfKtV2UDcdPqTgRIeHH3+cPE4ApuO0hqdJq3vgQiI/uwvY+8BKCIzOH/7sTLoP2tCl37bvRAu8qFkaC6TRGqkNUEZDaQQKBc0Ee7g8WR3WsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HKHrvHIP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HKHrvHIP"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f754678c29so54666797b3.0
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 14:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740521672; x=1741126472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=HKHrvHIPGOs1LAPhaKGNVYAN4p1hSmui5H2x05WfT8rpf/+sxE5cNaJe4j4UPShABd
         QdglBIJRHJlmFTsh0oXtBBF8oK31iko2mj5XAMfkURIXlnHuNViYHY6r4rtcvAFOoCtI
         iKp00SFOYRRF4IrIH5cz9W1tHw+QlEtTRXMqgiMh24y1D7JKw+EngatYg/Lh+9uAIW+r
         B1jSUsbiiMY20xcsisZek9Fjju86noKydwlAvseGVqLwOeC4Pci7nwp+jLZt0Uf28mO8
         we5gSJFCqE0NJTVwC1+55Q/k4JgavG3yBljPZJ2worsbEqjsdGQPxVIwT4TwA5Y2IM+5
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521672; x=1741126472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDGLRB1elogkq5ZS7O3/EtHbyE61wRXahwAtSkqJ0aw=;
        b=A170jJ3kI74hw27NfyhRNc9i4PYqvfd6AgcF4G+9A2p1jq7GiczfhULdgvGsEvlafT
         6lHPcHmarRziWsYfBkOqOBm5L/auAexnetelmZbKyG1xNjUUIJgPq9XPwwUX5j8WK5BK
         GYNkip8gYzI7hRFLpdBGDBVFuGhcsA8gHM7Flq9JAxBUtHvwJmT1+/DMo0ag4onzJx6K
         HVcFVXl314+P7tw1jteT4w5bBerCFjwFcyDuXcz4jwjaxzD1JLT+zs3nyu00JaF/EaA9
         RjHMksIBf14cpBvHGnlyOMFuF2WcMSqjBPZuog/XSgY21I9c8GwqhAfDpWsMesp627Zw
         qseQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTP8lepWw52uVeruDQ6wJ93H0QI/+T+qqEl9MZghCKLK0F0RPJz6brcgQROuAepIkQCe57C28q@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYoNF3EnjzbtZs6Y+A3GOwx05ZNANcj5JHJH4UMn11+4TIZGU
	5jlUBBGUc1awYsn3SKnGbxxSN2BUo3BXz13fq1G6FYAHt/u+QkHdrB8Oo1JhpvAHACMm4T7eucl
	lj9XZeCdQwSKQKWyxIa6pqgtuNY9kn4a58hkK
X-Gm-Gg: ASbGnct6NCDCbsD75FPTsj8heC18iMn1MyNttnIZcdOMj56ub7+b/HN3PEB6dA+L0W1
	NCZFnKyDOSGgiQL7YPmX1iyjusmYk/mk1FGkl+L5RhVTy/Wf+ekDZKOkdSbG1ypKPN4GSBbYXsB
	l6NMaTPbs=
X-Google-Smtp-Source: AGHT+IEq+q/3SNBzxXflir8s+6QdmuMLr7mPJKzm7/BUu7IXjxCgJ1uEovP+G+hSJ9QqgINvHv7u8FQo9Dm4e0gAv10=
X-Received: by 2002:a05:690c:312:b0:6fb:9fb2:5840 with SMTP id
 00721157ae682-6fd10ad8d15mr47580827b3.28.1740521672571; Tue, 25 Feb 2025
 14:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhxQfFfrpmRS6tOv5ANVug6d8dGx6Hsc7MYYe63sUOpcg@mail.gmail.com>
 <20250225192644.1410948-1-paullawrence@google.com>
In-Reply-To: <20250225192644.1410948-1-paullawrence@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Feb 2025 17:14:18 -0500
X-Gm-Features: AQ5f1JqI7MeM_scLLuLOFY1u27DXLEkWvnLakhLURvGM4cGQ0eQrhjUWTYnMN4E
Message-ID: <CAHC9VhSu-034tguAKj+rptYB0w8D9mtgmjbDgLwVc-bJQcSrBg@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To: amir73il@gmail.com
Cc: corbet@lwn.net, dvander@google.com, ebiederm@xmission.com, 
	john.stultz@linaro.org, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	luca.boccassi@microsoft.com, miklos@szeredi.hu, paulmoore@microsoft.com, 
	rdunlap@infradead.org, salyzyn@android.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:26=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
> Would a patch to set credentials during remount be
> of interest?

Amir mentioned (in a html email so I'm not sure it will go through the
lists, I haven't seen it yet) that Christian recently proposed an
override_creds option using the new mount API, does anyone have a lore
link they could share?

--=20
paul-moore.com
