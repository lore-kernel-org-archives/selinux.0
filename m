Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D219B59C
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090605; cv=none; b=ma3j8FLTzE186EHZznEnNz3McmtGYnIBNJrYrVkpSJ+IbbgX2zFdtXy4EgSYUfxciclQOrfd9ERDbizmI3jBBQ5zsXYC0UK+2hQbqvGsBhoN3Nk9KxieT3211Y1r+Xd2vN7RGURB8W0r3LFxG/3rmhFQd49D+40c2sAKwAvvOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090605; c=relaxed/simple;
	bh=qeSfzsuQ+OnvzOB9ynW6I4+8VDYguG/d7VHfeNiTSM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfI9MFpfp+3YwBO4usHNNwniZ32kVEgU2hOOIhslaAklT5ggdyyv83hcOc1IyjISiOEfBjr4dYJyX6yqF4ynryx8uDDVq8/ciCB6X/SlZ+owY6O5Z4i7aL/7tUhY21qSxY3RMIJczq5/pKmrJyvR9Df0fZj7UHw3varn4uTusYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oq+xEplI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oq+xEplI"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so2192487a12.0
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743090601; x=1743695401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giFLnP1jrB3bJbmUGr3lK+uOvsNT5VzaCpu7lPsk4hs=;
        b=Oq+xEplIxNaC/jjoSOBE9weI6KgcgDj/cxp2XfEfDNSMHOHFJKs7ikjxwqCJ11MjWA
         B8F/ireESXVCfC93P6lHubTdu7DWI+fTRbuZ1KyH9VdIV8Qp+br4FSrvT+AS+vKXL66L
         VOhxhwC2UWnarwcIKdDnOyJiV/ZLgCcZ5kztI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743090601; x=1743695401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giFLnP1jrB3bJbmUGr3lK+uOvsNT5VzaCpu7lPsk4hs=;
        b=HzjYPLzHTAdabXcIvMR9B1sVxXBn2yL68CQ83oT2Fo1ZMbITkdPnxPcrTr8D4182yf
         WErv/3uNmKx7Vexm7OnFc0JF9JtIaVQR83GgNgpmWAiz4XnoY0gHYYixOBmN1zwUWDeU
         vytermBbF6vJaJGFDALeq6GSHolwM9zcIeUi3jNGZ2hC2m/pXEwG+oqW1xjcriGgzWpJ
         CRyAucZBbPhOZWTY1PU861uEYcI3bJ/3IF0GMz6s7YuZhff7BfDntYqrpgNILtLRrnz+
         Ix1DWOdD7xvNYgcbqAh9EIMDoTE6VNuKagDnv2TRtNgOb+vQfCqOH4vkbRBT5Zmn9mGz
         Fofg==
X-Forwarded-Encrypted: i=1; AJvYcCU6i9sMasj+LFkeEAT81FTjAjqgkCaeytt++GKlHnUylShL1+RmHt6TCbNg7jZaggLZVIRF5muA@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/E908BkVJQE1iuLZP8sWQrCQ05Ufz2B5sbO4iIry3oA5GV2a
	irhXXSaxXbrmTIp0i8cFZUmMhYQ0/12eMTSkSd0rccUiGBWVI8gjYtxEcTXnwzq91JvqKnHbI9O
	Xp6g=
X-Gm-Gg: ASbGnct17sGoUKiR7Ie5okayZpzyFzOc1ctC4of7bL+RPz64kDiW4oO+bNjSiumIiie
	XDCl8l7euYQeVtRIpHKG8wv2anyEuk24HGCXATftqhbZ3G9S1Al62UQwXe90bgXyTwLBs69WDrP
	ppaRPXi/hhpmxkSIbwcfPwS47oc2Q9wiPfWD/6NHf7RnMx9dcQb1h76mZkUo7GrcJ5WH5sutuYJ
	OL2ueyQk6pTAVnDcgOKpGDDxDsQ1hjXdwRTFFV/sJLaZ7E+1kxKstjQhtALVPy/159/lspGqyV+
	ny76K3VOFVE1ed0sCfot6p0rQOYHJGsE38ciLxkg49mebsw+/QhX4O0Nq6Fd2cmu5kWzWumgUV4
	K2/oPzrq462y7VS8SDYU=
X-Google-Smtp-Source: AGHT+IHPm1OHTBKfHpiAfdCxcyZ9SlUiGc2xA7arTMRyZe+At+0ErW03suS7/NbA8aVHo2lK7bFZvg==
X-Received: by 2002:a05:6402:2102:b0:5e5:dbcd:185e with SMTP id 4fb4d7f45d1cf-5ed8e4a51c9mr4713554a12.13.1743090601234;
        Thu, 27 Mar 2025 08:50:01 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0df880sm11211987a12.76.2025.03.27.08.50.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 08:50:00 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so2150276a12.1
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 08:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe3QnGNML5hcWfT54onpLJGF39haeTKlIOSzMsAngAc9827FlldLnTTU7LONBJKvgru03SFcrY@vger.kernel.org
X-Received: by 2002:a17:907:969e:b0:ac3:3f13:4b98 with SMTP id
 a640c23a62f3a-ac6fb14a9eemr321047366b.39.1743090599993; Thu, 27 Mar 2025
 08:49:59 -0700 (PDT)
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
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com> <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
In-Reply-To: <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 08:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
X-Gm-Features: AQ5f1JpfPxIDPXqHseSeuENAM4paunItAZJKgsQVaCtDcDayjV2pwNNW6TWk5bQ
Message-ID: <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 01:59, Jeffrey Vander Stoep <jeffv@google.com> wrote:
>
> The value here isn't so much about checking the source context
> "kernel", but rather about checking the target context and enforcing
> that firmware can only come from trusted filesystems. So even a
> compromised privileged process that sets firmware_class.path cannot
> cause the kernel to load firmware from an arbitrary source.

Yes, and that's literally why I earlier in the thread pointed out the
new code in selinux_kernel_load_data()

  "I'm looking at selinux_kernel_load_data() in particular, where you
   don't even pass it a file at all, so it's not like it could check for
   "is this file integrity-protected" or anything like that"

because I understand that you might want to verify the *file* the
firmware comes from, but I think verifying the context in which the
firmware is loaded is absolutely insane and incorrect.

And that is literally *all* that the new case in
selinux_kernel_load_data() does. There is no excuse for that craziness
that I can come up with.

And yes, I'm harping on this, because I really *hate* how the security
layer comes up in my performance profiles so much. It's truly
disgusting. So when I see new hooks that don't make sense to me, I
react *very* strongly.

Do I believe this insanity matters for performance? No.

But do I believe that the security code needs to *think* about the
random hooks it adds more? Yes. YES!

Which is why I really hate seeing new random hooks where I then go
"that is complete and utter nonsense".

[ This whole patch triggered me for another reason too - firmware
loading in particular has a history of user space actively and
maliciously screwing the kernel up.

  The reason we load firmware directly from the kernel is because user
space "policy" decisions actively broke our original "let user space
do it" model.

  So if somebody thinks I'm overreacting, they are probably right, but
dammit, this triggers two of my big red flags for "this is horribly
wrong" ]

                Linus
