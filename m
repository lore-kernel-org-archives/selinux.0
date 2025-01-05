Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897E29A0
	for <selinux@vger.kernel.org>; Sun,  5 Jan 2025 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736043160; cv=none; b=BpU8qlhisfAp1bI9QiXeNgJcwIf5aaP0KoM9Q7yN+6I0+LpOFT6WQLW5/oAcOmegfaXG/x6YDK1vRqEqx77YoNCoXVC6N30YA1qPzhDe/0vgneyjm/KP/0AUjsyv9+6GmMkzqQLRP7cUArcXtuUCE6tpky8iKCqOnMVA7Z/wiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736043160; c=relaxed/simple;
	bh=Jzfp8M24ZGYO8CfByHmvPRILhEgp3SAXkuYYuv0i5/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPNaQISJ5VapAMUPoTTd8T3o8tB9AIHE1MRLgLjPgS3q4hnO0FFqA+FojQ+Gym/NoS6EVgBZTDe4a5Xj5GpYMiKuwMJ5yYPPvKFPQQUs00PeX94cjY2xHbhQii01Xkt0mSRf2EizOLmvRoh9urR8cGUm4KBFeb86L0RlrVGcZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CySZ8vf9; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CySZ8vf9"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e53c9035003so15686936276.2
        for <selinux@vger.kernel.org>; Sat, 04 Jan 2025 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736043157; x=1736647957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVhkp6+4+SyxA1C7vrnL8lux54uiVvQyU708Zob6d9M=;
        b=CySZ8vf9OLOhU24WKEejG0p3XnXqR//c4ziWRDp7La6dRSXO59Y1Oy0jjA8GTgbpEP
         hJsdXrQFqfzjFUFgb/6VMYSH24vTFN1R7fTN2bMVl0aJEpuQA3Zm2YRCG7Kr7f4//zNh
         tEoYIoSaQssNv7AQv+QINIvjodklba+Qmb3ZTl9kojYvBQet4/bhhUVCUxFySH2RgVnn
         8G/t8bUOZWrIrvhSF4Ho1LuyUuhgLQwPeqpTapRUNOvmVhqSYo3XBQEUR2ikHXhfNLan
         Sbfzgh5mlGL8F3Lvc5duhXxCe64VKPZxGd75bi2R93t5XcFQHpL52a5cRGzMGKKDqEEw
         rs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736043157; x=1736647957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVhkp6+4+SyxA1C7vrnL8lux54uiVvQyU708Zob6d9M=;
        b=dvjCVXd695CjV3LUkyv2NQa6Vya5RdidFA7vknqNhw/mqedrGpzchdHOOVf7Va93Tq
         a5B2m+xMgctNt9k4yNoVXALnI2xEiTZhJogQrqX48npuzYEJVbxFBJsRjzZ71V+/nAjc
         gUWU8LIF4tQCX1JBzJpeVeBket/HIvTz3HZxK4VJuQSkaIhtMMQdPlW5YsXK8rbI9lca
         2Mxs9aP/QAPA1E41hQxJALCM9ppb7eeMJUmefpHXgJLmznKpUx/hY6j7u0XhzMWnIQCj
         rjny+enUaEQnht3ptUdzgOHTVsXpdjLD1ZvOday2A9GRHGek5evr5XphIV1XVtTZCZOH
         MFsg==
X-Forwarded-Encrypted: i=1; AJvYcCUYd8as93TumyzNgP6eEgk+oVmF/r3b0DIjj8vkeFj7p8hAU1gLWnrmsxHdnP5qeMrcs4gI+pE+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6lUNDqlSeviEkuylPG9gSHBWQki72cFpF7efMhequ3Ff+etT
	YWnKhe+sIC7npQLZ2cgDIUfSgU19gGfKOv0eYLQ2k8mBMsvDj+ZV2puM4iHPsXNbMw9EOHBQwr6
	Lyu0lDL59S44tDO6pxZFtnWOBcnjAirVoB0Pj
X-Gm-Gg: ASbGncsIrtvDbStGwPDGDq4oA8iI6wJfcGGAFlnSAsqeABsxlIQMe6B06xOJB9j+hdm
	b7iZo/ZYUzF6f+vV+M6Yu+IOZbON2luP6Mm4l
X-Google-Smtp-Source: AGHT+IECujpE4SlfMSgDTibr3ecgQxCdF8XBs81RAecEaO9HiXL8b8vWykU+LPwyt7KcvSbGf6hiT7jTg2ydSuKCgd8=
X-Received: by 2002:a05:690c:6009:b0:6f2:8781:32dc with SMTP id
 00721157ae682-6f3f820ae78mr369384597b3.30.1736043157303; Sat, 04 Jan 2025
 18:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com> <4ad606c2-c7d1-4463-a2f1-4fd0c63c6e9b@schaufler-ca.com>
In-Reply-To: <4ad606c2-c7d1-4463-a2f1-4fd0c63c6e9b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 21:12:26 -0500
Message-ID: <CAHC9VhSWUNfFUZPtEQdHN4ON6VzWoRN38NeoHJHmGZj68NprYw@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:34=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 12/19/2024 12:41 PM, Hamza Mahfooz wrote:
> > It is desirable to allow LSM to configure accessibility to io_uring.
>
> Why is it desirable to allow LSM to configure accessibility to io_uring?

Look at some of the existing access controls that some LSMs, including
Smack, have implemented to control access to certain parts of io_uring
such as credential sharing.  While having a control point at the top
of io_uring_setup() is a fairly coarse way to restrict io_uring, the
advantage is that it is very simple.

--
paul-moore.com
