Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158018E377
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743048596; cv=none; b=kCYkJuIiJe2pr7JJ6ToEJfW2Klb1b5s97jqmVTqgbc9j2amEizz7WJPbr2+xzxX+WvPH+cj7Q7dOZyMKeImRhjmQIxvlkrUfc01y/nOaKLEzmbHtequrqfOZ+5WPIvSuIAEx19OrB13PaTcFe7Q0PpzFgyzUS7BsTCEIBTpPVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743048596; c=relaxed/simple;
	bh=Lz1FQLkO9pjDr4w82/Pd95GcHEkMkqv3nNZh8P0KAio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUTylKPhN3SK0W7jy2s/7hqgA7j7Mij3gCt3lO1XoLQLpyNOSFSPGIqnn71GOEIX2vTHAK28U2IJnYQaZbaevMTRt7yjb6gnb/NzIEPMdHP2VulUnNYINEi3OX4M2a4pcDv/vNsusyQECPQXbZCW5x2QZqmDjKwFA+lTArwLfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UFYMplWH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UFYMplWH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so725889a12.2
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743048593; x=1743653393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOWeEw9Pu7F8nbiAXPD7wEj/kT9XBFmAh+hzKHsE59g=;
        b=UFYMplWHcT/n51H474rCtmkH+GU+5sQmsVm+h20tHQ4tuHqlPC7aqumCG8uQbkwGXG
         soC3iVjNatW+NTuW+Oyv2Lg7BPbx/2M19rnEwwAL1alZSJG1jqtmUHHt+DPK/YQlCXq/
         ISOV8cFIf4hj5cWY975vBn+RFV+gtX1+hlu+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743048593; x=1743653393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOWeEw9Pu7F8nbiAXPD7wEj/kT9XBFmAh+hzKHsE59g=;
        b=XBFnhih7+u9JjE+74feOprGLGfIa9/UPsCYdxyX8pZLWgBDhE+lA8pZmCeUb9hk1Xq
         Qa+kkh6esgjW0JshvtY67OpWaDcVqXVa4Y9kE2AJoz8NIgfix/RHVS9BnqM08Gc+IlIU
         l7CWpzAy9YbX2YbBv1wAv3Pt9HfctlFDHJybEhx14NenMqEApMkOdkeCNoLuhoVDSLUI
         lbYq2OtS1umWtoanMrGyIq8OJHKvtl/oLWw1BPDZwIhw/PCfEZyRf0N1dIyGhUoO3Aa+
         tO+veWexZ26bk30NlEYJ+HHiQ7toLYpHWTbqkjdpNXzHQmrpe59lioMF1gmwZPuRvgzb
         McjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQeXk427fG4We0gjA4Z97BSgzkTPVgvR2Jy7X09R17gCSEUsvbV6FcQw7N+/FAw+JgvztBtiFy@vger.kernel.org
X-Gm-Message-State: AOJu0YysdtaEWk9LTNwjoKBNH0xzympK7HEJvSrDIzISzbS1SiD20y3I
	liuClSx4YzPVFoyfYG+HWcWTG3pRgmCAd+YB+flTgwSkmcDh1jSgU93ussHgngRSw/Lr+YEX/hB
	QV9U=
X-Gm-Gg: ASbGncuC2ZrJqG4czpFreWhrlxpwSMsVgPJ0yleji2r8AXcFfdkDpXDd8X8zoBX6WpY
	N62ZZmFxrYO84f4s64N/FNhCqqomi934icpOoJAQ/xgzUIcz8Nw5EpEcU9W3GcI04hzU9nAoCLQ
	vSBbFnVgJOTkB8b56fHhclwgvOFAdVnKjAEv6ul/2RVfqpf25o+dLH73NQXCtqFK/c3erbXOdCI
	+P9itaBtXeZDVG506zpgmIQZOzBiUE52xVunepuyxWSJNPN6YH108brElqi0yhHDY4RLHjeeySI
	+vMQbJYQqDCpnEHPy8iAaf2oK4LFbM1B7tPYaRlGmavtqLpoAADX8YUbojwL47hQZSb+dcBw6Ae
	tFloHZAN1i6CK4Z2/WMtrVqlgqisXgA==
X-Google-Smtp-Source: AGHT+IGk2ssTHuHGwJ/V6Uz4ufAILo1scvSdpLj860L7f1IiecyAG2nWxRWH2LZyAbRjRGAm6H2lzg==
X-Received: by 2002:a05:6402:1d4a:b0:5ec:c976:268a with SMTP id 4fb4d7f45d1cf-5ed8e4a9544mr1892711a12.15.1743048592798;
        Wed, 26 Mar 2025 21:09:52 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c7f53sm10231419a12.64.2025.03.26.21.09.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 21:09:51 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25d2b2354so92014266b.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 21:09:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLqyw9OKuHcKRSX7GKd2Cm6gT078dDJZYdBJTNm0Wledb5AP9XLhAcnCf2e2r5QCuaImY0i2lJ@vger.kernel.org
X-Received: by 2002:a17:906:c10d:b0:abf:69e6:438b with SMTP id
 a640c23a62f3a-ac6fae622dfmr169188166b.9.1743048590150; Wed, 26 Mar 2025
 21:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com> <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
In-Reply-To: <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 21:09:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
X-Gm-Features: AQ5f1Jphh6bvpH_hyDGYydwiPutImRu0h5mKD_G1WlOxtBvFwB1PFPSAJ7TmHxU
Message-ID: <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 at 20:28, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> That is not quite right. If you look at commit 581dd6983034 [1], when
> a firmware is about to be loaded, the kernel credentials are used.

Ahh, that's good, at least there's no "random state" to check.

But it does still mean that the security check is pointless - there
aren't any other credentials that would validly be used for firmware
loading, so what was the point of checking them again?

In fact, the commit you point to was made exactly *because* the kind
of pointless and wrong security checks that I'm complaining about were
done, wasn't it?

                    Linus
