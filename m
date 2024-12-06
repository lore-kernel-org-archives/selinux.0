Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8F26AD4
	for <selinux@vger.kernel.org>; Fri,  6 Dec 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490754; cv=none; b=kQPqXyx4gNqoMEONVGf0lO6bee66buNm/IV3Mv5RfieoiH0+jGeU7ls390eFInoybojR0d83TyM6HEhFMASz+hLvi4opFcdnBkaTXk+di0oD/RNv6OpVi5hWdDtTVTNVI9tjjPTeL4LW4HwujYhtAU3bsaLFeA5pbWOYVZGfP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490754; c=relaxed/simple;
	bh=/DQJtWc8rFhhG0y6x/OP6gIGjkGBJBGirO6slvbRipM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/9XeSrqbbsHGIhROEeyCTOvrSubDd3VfW6HW30zqMLVSEHOHa3a4b9nOS3NmjsGEvLY2zNfeqQLOJ2pYnudlCBeOHqAISVeBd0kLcdNup/1v8in9JyB7dxbRj0sOgNgrqnM7GAvWYOLQjwbGBXVAye+pbu41ePomAdw4W5CWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UHNfXHc3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UHNfXHc3"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de880c77eso2155811e87.1
        for <selinux@vger.kernel.org>; Fri, 06 Dec 2024 05:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733490749; x=1734095549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DQJtWc8rFhhG0y6x/OP6gIGjkGBJBGirO6slvbRipM=;
        b=UHNfXHc3xxWIFLp2/DO56RK5IJ8FyRiaP5xczyoEkjffla5U0+h2CcoeZoO+r2gJOH
         RJM8TP5WUaH45hZUV9aiYnUxQwNWX+Dqy92uP2sVCThMhK/4G2a5ZarfThlhjVxnCNY7
         PTz9lM5uiCSw1JySt3q0LMucHEWviKV1qE+Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490749; x=1734095549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DQJtWc8rFhhG0y6x/OP6gIGjkGBJBGirO6slvbRipM=;
        b=o7Sv6jsXgLlPMAgWW2h3PiH1peFu4gxbpxxBIkZbzKALPrHv9wkTl19LwolEJkGWXD
         /NsQNqVQsv5E72yXFUtM+zQ74/+rD7i9ZnKdI/OOPU2kT/hZ3Q/n9oeGKCg395LFBeiD
         cwM3ZdvB8YVnxteXJtK/01mbbklpc8HrDo4Ph7DfQNGxCTcP3QnXkJUX7YZmioX+wBef
         Mh5ERTroi/8p5uhbuiuydCzXC1NykcnD4t/tnz8TAR7vuhPrvwdJaJfCKMdgfOPjaRbU
         yx3mgIfpKdBX8Tno0NLjR5J4apS9z5RzmOBTJwG2Af4eKG9uT9rJPnPje0hRFBNcjIPg
         46nw==
X-Gm-Message-State: AOJu0Yxzf2OLAVML+O+Ryp5XYvFW7v8rGcFR3FWI3s5BwT+kJLGWG2K4
	Oioj9h1SFizGPqLhB3hldOasWnTul6Of+p0wzCMbide1Nh++s6tE1akzVqeZ7Kd7/Fh0l986bkJ
	9aLl3TFnUUzBQcwas/StanCnSfu8nJ2Zt+fs=
X-Gm-Gg: ASbGncuFPn/3GUzo8UuO/fc/+p28ejGp5tL+xu3QNGXhKwrspnPLBfdzcA8aKGGxblz
	+q3Pxpx1rYGijy/fy3Pp1trAUGcX7oTjZXeXMXj5SzdOsA/hPeZzhDrhcjGLStA==
X-Google-Smtp-Source: AGHT+IGpYdMwU4zSe8oVtOWTqRA9TXz8wv/88fcTUXkcfn31GditG+DPFxvMGtTndhWnN+iEYjEzTckuFcr/K4GYKqw=
X-Received: by 2002:a05:6512:234a:b0:53e:12c3:b4e with SMTP id
 2adb3069b0e04-53e2c30da6cmr852274e87.52.1733490749301; Fri, 06 Dec 2024
 05:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6dmxzcooYYya5kH=KwfhhKUJSq9LYVKiwxj1sxsDB3h-w@mail.gmail.com>
 <206b1563-c3c3-4e6c-b7b8-da1d44640772@googlemail.com>
In-Reply-To: <206b1563-c3c3-4e6c-b7b8-da1d44640772@googlemail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 6 Dec 2024 22:12:17 +0900
Message-ID: <CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com>
Subject: Re: [RFC] genfscon wildcard support for faster sysfs labeling
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com, 
	jeffv@google.com, Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> Out of curiosity: can you give libselinux 3.8-rc1 a try, which might/should
> improve the runtime?

Yes, we are excited to see the latest rework on the file_label structure.
However, we have a few hundreds of non-trivial regular expression rules instead
of literal rules. So, the latest rework is still not enough for us. By the way,
I found a bug in the latest libselinux which breaks our existing rules. I'll
share it in another thread.

In addition, it's not enough even if restorecon is improved from 2.7 seconds to
a few hundred milliseconds, which is the time of `restorecon -R /sys` in a
clean Debian with the latest libselinux. On Android, restorecon runs for `/sys`
when a device wakes up. Spending a few hundred milliseconds CPU time every time
hurts the battery life a lot. Thus, we want to eliminate this overhead entirely
by genfscon. Actually, we have another PoC to further improve the restorecon
performance, but for the reason above we want to improve genfscon instead.
