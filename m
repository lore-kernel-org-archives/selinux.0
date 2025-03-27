Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC72FB2
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102237; cv=none; b=L2Ep4tdkQdI51vdwD0s/aPwOmO68/ve6Y/SonVmIhe/3hCVJV7TvMZ6ObQOdIxnPRU8Aw0381olmXRKIq7MvfIYaD9Ev8OLW+RzglLsAPaTOFqy8Fj3soTPj5JPWkhVLN8URv4wkMttfxiwRLbwxvXMWTG88Rnd/eRWGULzNbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102237; c=relaxed/simple;
	bh=ZV+lHTqy2y18sHJQYhQiUkM92LLosntDULZ7IsN9AuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6jYFvXxhB4WYfCsiHqP9XuseBTtL3pWXrAKmN96IcVlGTzmH1gHb3dTM4oGoXiSpsR7xzL1KscC1Tx82ecfhhsKyttOdgX+jNok4sKSCY6ObCZB30nqv8BjSxMssUh18KrHwyOjVMD5zQVTQXrU9sbBQGiL9ijLCbdhCzTipRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QZxT5thJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QZxT5thJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so2170331a12.2
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743102233; x=1743707033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eckh3c+xZEpUAPcGpuJWSWBJz7nrFu2WDtg6sHEX70w=;
        b=QZxT5thJ6UJr6xbe5k3gkC3nbBHDn6OYIaJOu172bF5U97AeMWILLVjVv1jG4nRcqr
         LkEnDfDFmJ17ou308bkqTd4sS2RAh9wPPlSQfJ8++3qQL9Yz8zTPr0jaDScbf4GG+G04
         zPZaiII5nVYw/PD7o9mrO/Q2U5WgHxY9nwNWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743102233; x=1743707033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eckh3c+xZEpUAPcGpuJWSWBJz7nrFu2WDtg6sHEX70w=;
        b=pSzciM3WN3OSYNdkheOANPS373fuqyvzR3HGNCYx/REdj9LabYpAryTtffN16dF/MW
         dhQ4aKSUt+9Y9mTfN4FjRGQmvAl2/bPPREAwXLQsvYo+bu24bNXnffFZGAAhuv/tGiQj
         kl6EykIxufs2oEBZlvg5s+kZtKmb6fE+5jzaT1VufLjQ347upKiV8CS//WzvEiTGFQMe
         4Do6i2MnPnSorkmd/ERL9ha9iDv3fGaJpOWkDIXFo++N2X77J3W6g2Qm6Hk0a1c7N7YH
         qqy5z+DQ2UAK06oAXzuyrd4FvAMwBjOwcccUFNA5gOi37vzxJVeD7YgbMy4bvuPJkuLx
         yWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW86LXwPlvBdHBZn3hzvZwk9jtpdhrw2mWN8+UYJG/shdPW16zNMBlHtYSVPbubQlhF+VtMKQ5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVOt0A7RT/KeYZtG4OHZsvBWi5lHYlTNiWHF8Fg0/WSDNhJPs
	Rt3bFlOUuMlZqAdBVth1aLw1u12hSxUox4pbr10cfHOQDt+Ly/oqIswaSzZ2tITSoOYzIP0oajj
	kHho=
X-Gm-Gg: ASbGncslwBCizQEI6V1j32lrYXMbbwqviiY3Hb/4+YuBhUEIZGIPeKWzSkJ6OjeaJDW
	8Cns3OByFAKdwaWfw32voqzkGpemJ/Wt5TeIDqfmgo1SY4xLb4tRvdC+YTUGGF9mIKnbNdifGHJ
	h/V2hl4tmahhRIUIYgSTiKSuPxShOTrvXaZcqdbJ34xFEo+C1H3JCCNLDOShqWQ4m5DzRoU8Njh
	iQXcARGsQoIwgjVwzXdJ+wGLot6e9pfF5agyAEGwTcvjk2c/znFbTAoXrAaSDrWF8ZJ2ZrPI1TD
	CVEF7XvsBkFpfmkSg8h7D7XeqrTM7VTcODnTtvENEVKs5rPL29aHL7Eth2eVYH8tZgHQX6JUv/N
	eBuSq0w/cLSknTaiK94DgXTWEXC1xIw==
X-Google-Smtp-Source: AGHT+IFxJz3ry9z1DF9r08ca9TQ2HGdHn59UxQvjLE34WVwgBbDnyRvQHEgXjRp2tMnOLrizdljjbA==
X-Received: by 2002:a17:906:2c0a:b0:ac7:1c1a:d0f6 with SMTP id a640c23a62f3a-ac71c1ae015mr35002466b.37.1743102233017;
        Thu, 27 Mar 2025 12:03:53 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f8c2sm36355466b.105.2025.03.27.12.03.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 12:03:52 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac29af3382dso212916466b.2
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 12:03:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmpIPc26QB2XKMPpSFiSr/FODUfJ/45i9wIwiJEI0C4QYxb43LbCzhgFPyiFJkt3thJmNPe8/3@vger.kernel.org
X-Received: by 2002:a17:907:724a:b0:ac6:ecd8:a235 with SMTP id
 a640c23a62f3a-ac6faef94bbmr415071366b.28.1743102230511; Thu, 27 Mar 2025
 12:03:50 -0700 (PDT)
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
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com> <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 12:03:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
X-Gm-Features: AQ5f1JqA5bKkmZKwxCnmbWV1-xhL46E4nM7-YF5EKDpJAQBP2OdnLsbOul3uyVQ
Message-ID: <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 11:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The best fix would be to be able to cache the "this doesn't have any
> extra security rules outside of the regular POSIX ones" and avoid
> calling the hook entirely. That's what we've done for the ACL path,
> and that has turned ACL costs into almost a non-issue.

.. just to follow up on that, because I tried to look into it, but
didn't know the lsm and selinux code well enough to actually make much
progress, so if somebody who does is really willing to take a deeper
look, please pester me for details.

But the big high-level case for pathname lookup tends to be the calls
we have to do not just for the final inode, but the "every single
component" cases.

Which is a much *simpler* and more targeted security check than the
"any random permissions". It's the "can I use this directory for
lookups", and if we had an inode flag that said "this inode has no
security policies that change the lookup rules", just that single big
would likely be a *huge* improvement.

Because then you don't need to try to optimize the security check
itself, because instead the VFS layer can optimize it all by not
calling into the security layer at all.

And from a "this is called too much" standpoint, the "every path
component" cases tend to outnumber the "final file open" case by
something like 5-to-1 (handwavy, but not entirely made up).

I think the main case is

   link_path_walk -> may_lookup -> security_inode_permission

where the special case is that may_lookup() only sets MAY_EXEC and
MAY_NOT_BLOCK (for the RCU lookup case, which is what matters).

So if inode_permission() (in fs/namei.c) could avoid calling
security_inode_permission() because the inode has some flag that says
"none of the security models disallow MAY_EXEC for this directory
walk", I really think that would help.

I think trying to optimize the AVC hash table lookup further or
something like that is a dead end. The cost is "many many many calls",
and each individual call is fairly cheap on its own, but they all walk
different hash chains, and it all adds up to "lots of cost".

Hmm?

                      Linus
