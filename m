Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8E16ABF3
	for <selinux@vger.kernel.org>; Mon,  5 Aug 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893324; cv=none; b=nFU+ynNS4q1b4Kyf+cijvrC0g809OAoMJgvP6+vZr6FY+lgnOlGlCX2gWugaKSvUEu1uCi6z3KcyxZb9K3eba+qzaiMaBaCrgyE207335cZthyW6JXNTvwoiDteNPJmWNkYSZYiSC3NKH6XsDn/n/89ObnEL1NVUThEDY919zDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893324; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnX65Hnqii4fmT82UCO9erH1tMiKRsDk6FSI3nGZJ8vQwcmX9UutA/FXAQ1avKD1GkSBxcgCnYStzR4Tplt2o8Y6tTYONXQ/q+IClaHtb8UcZEuMK9MbuDeno7wWsGfBg8YjyV610agfeWceNUuJH6qgDARhY2/fQ7UD3i4fQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dTZT/y/B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dTZT/y/B"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530d0882370so1578706e87.3
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2024 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893320; x=1723498120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=dTZT/y/BmtXDpNcwqQMY3r3ejI4e59QXjXxyGeNXYZD6tW8wNuCQ4kCQQBZn0lvYBO
         DmXZRZ/73uIhMLyk1j5H8HTMiGkEJcEXqN1L71oINzOYy4qxj7xqtXPeA+horB6a5PC8
         UALAjaTOlI0ZqPh9wNw6eezhLySxTMLWvYomk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893320; x=1723498120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=BaYGl/VT/oD7TpWYpboroDk+7sfwwT1SsM6nCrv7WZTnGv+MObx5xuGFUfcFeIRsga
         Qa8m8b6VoBPSvQ1G3AOLqFBkIsjeyhRlobzYHemdSZgr9CUMFtVirwgcmjiOSDEFadnv
         I7w2auu/RlATYzieS32aAZGNEwiYuy//zeW3MPEIUYpHrLFFj+jg0ty/hg2GMaQQYV6h
         nSzlBpe0TTbDbySLogLZx+6KJlqClwVaDOVvQZXVliUY95LeV8fGzpjj3stD2TLSv/lV
         wFmD/ZwInH+CPkfB5YGVlo40pQ6QTD53GPOguf0x5TC5cdjYRturCHC7B+V9DM3/8Dt4
         mAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXS3bvbxT2wCHZRVR9IKcFddHb8v+xqefN/3/+TqBIYFz/8DftVdguo4VofS5vCCIcgY7EUBqgXACcwkuL1kwB85aTFDSTreQ==
X-Gm-Message-State: AOJu0Yxn8w9uuTl5NUO+zBM2hd252aBZVKSRSlrY1HO2cXCX5qEOm7IW
	p7e9p4ohFQUY/y6lil3SPXvlb/HRBv2rBPQ93EH70+rXxGRRNBBxbJ+BT9NvFYrfilETmiCuuzq
	58RqFcw==
X-Google-Smtp-Source: AGHT+IHI16Z3iKft1MBiyQ6VqxcHcAiZoKrcCHDRkX/41XnbkjSBoIXEw9dAXLdAJ+GEagQZaZvLnw==
X-Received: by 2002:a05:6512:b98:b0:52f:d69e:bb38 with SMTP id 2adb3069b0e04-530bb365f79mr8749711e87.2.1722893319915;
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cb9esm487462566b.78.2024.08.05.14.28.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so13546722a12.2
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKdcn16emc+IujvL9a68dnZVbr6pjc78fw7CUcwJiICArTMArO9wQrh9q161yZNdTCpfFgzfJG5iFJlZR5XvjX/uH2ZdGtRw==
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus
