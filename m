Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD251B4234
	for <selinux@vger.kernel.org>; Tue, 25 Mar 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943754; cv=none; b=BlH5vcV/9ltLLafCUn0gjUeUothyqvxkXi8MPDjD46lVgKizsQBHC0GrzB65ku5dBdP7rk8R1a2nx8T0I71RH0FLYBBF16o49OgIUzn4ovEEKX/toocLOIHcLSbopyUEB3vghoV3ODhFIXbOypWKJqKd6lexwGii6tyGkg14A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943754; c=relaxed/simple;
	bh=rvtaKCacTd+dMFEwCfsS4KnID/jFXOuQd2z1cHSbJkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbprBiwrUtKcQu6xrPII2JxVt6S8c/B5VRxnldfksKIvEVsxk9pJIxXFvXiUiI5aO8IO9Vy9b21qyAhTp8VKo1BBvgJkF9VTBbLk6F6/xAc588TV7Y3EtrWBSC51RW5bOKN7NDeJuFtXuLsLjyDlS3/Bi3ZqAMfEzI5ZROYoj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yn6rStf5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yn6rStf5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso604133a12.0
        for <selinux@vger.kernel.org>; Tue, 25 Mar 2025 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742943751; x=1743548551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=Yn6rStf5pO+s7P+LMfXqHHu80sudrltuUvXpI2yHeTAbVmA6H+4cI274H67ddvaw+r
         Ravjrco0JPax3g9JmXzaj2rcmhY4hb5F2vPW2OsF8TNypFozRxE8vtKbfx9dVKdSXHQL
         WMo+6aU4qAe7hLZYESC8+N0ajp8Ik9Ewu9D8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943751; x=1743548551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=qgKCASri+rlhhYDGs0gTW/L/UjxqnQ0khMhZYG2scziXWiFASmi22tAjZzeI91u407
         tTZenAUAN3ZaeDdi/PCeYPw8ETwOqrlQNCu0hzydMsbAmooT2LGKdsfCoKJ2CWknVcu5
         5XOGK/2H9t8Rq/D4zkGPIWl8eIoiJqQSEe2Mj4ZwbZ84kVN2gbySflZcZLQwDqQLBFpM
         aO9LA3Q/IEBYb7qqgtodXOhvcRKSkdYtSGbTc0jAMd5LwsbruO2rQuCCN+jKmphtdgYq
         bmEbVPwQWOLedIccUV32nhpQpxNrykOVZ7L6i0iIthum13yd52YLMGBEXu8xb2gv5Gk/
         RCkQ==
X-Gm-Message-State: AOJu0YxdsX8AOXMo/28bHqt92nK/yXFuaWN20QLMMqFehAq7ggutJhnY
	lUSa2TMM1vOk26EUrt1tCcADdUS7HK43ZEOlXni6iNKgAUxAjiv7cJGXCsfyJd+8wG0sM4k/s2G
	iboOq4Q==
X-Gm-Gg: ASbGnctr5piUdcCcrj//sVHMOz5GbZJb6RsmtRmyDT1XCtnxexwDjEriwN+vJl6a3nG
	ndqHnWYKbihPg/u0Zo71Dggtb5vB37a6uPcpsnvwyynHJ7ch061p1/cN3GOgOAtCbcV2l/QtjS6
	eMbAxa95saNco2bQGHc5zZkmE5KzxRpmAhDExEMEQg4GqIVAPcmKLXvFfFgEIVLv0W1+em+540q
	JhAjDycaH8Xc5vlqGQY+bCYvpf3E4uqKl5Es+KKh2uIoCPyPtmL0Gl62bvbe8SAUY/N15+6IL7S
	FIe+PKcIx7Cm35vrO3RqtfnsrLHSwiv4elq8yNOPyoh9A3WiXV9TAnhItSKdSAcQiYZVF8wxNwL
	d3ga1lpS8L4nbfnIZKugFvfmnzyYOpQ==
X-Google-Smtp-Source: AGHT+IEx5omITJbkLIxxDe98bTpbX7bej74kCHzHEjg1XewvJRndXCWaMFdvQ1mYbNjBFZ7hG+6eHA==
X-Received: by 2002:a17:906:c106:b0:ac2:b813:ac25 with SMTP id a640c23a62f3a-ac6e0a48dc3mr127404366b.14.1742943750932;
        Tue, 25 Mar 2025 16:02:30 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf668d9sm8326457a12.10.2025.03.25.16.02.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:02:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2aeada833so63526566b.0
        for <selinux@vger.kernel.org>; Tue, 25 Mar 2025 16:02:29 -0700 (PDT)
X-Received: by 2002:a17:906:81d6:b0:ac6:e42a:fb4c with SMTP id
 a640c23a62f3a-ac6e42afbbbmr77412666b.9.1742943749513; Tue, 25 Mar 2025
 16:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
In-Reply-To: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq6H2w1UwofX9xTNQfWxTgnnyE_4keu9omt7uh5If6fR9mM7-LXzR1V2TI
Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 12:39, Paul Moore <paul@paul-moore.com> wrote:
>
> - Add additional SELinux access controls for kernel file reads/loads
>
>   The SELinux kernel file read/load access controls were never updated
>   beyond the initial kernel module support, this pull request adds
>   support for firmware, kexec, policies, and x.509 certificates.

Honestly, is there a *reason* for this, or is this just some misguided
"for completeness" issue?

Because dammit, adding more complexity to the security rules isn't a
feature, and isn't security. It's just theater.

And it adds completely pointless extra cases making the different
cases use artificially different code.

The commit message doesn't actually make any mention of *why* any of
this would be a good idea.

I've pulled this, but honestly, I think all those new cases should be
removed, and if people object to us having "LOADING_MODULE" for other
kinds of reads, then I think the fix should be to just rename it to
"KERNEL_LOAD" or whatever.

Because dammit, this "make security interfaces more complicated just
because" needs to STOP.

We are literally wasting enormous amounts of time in the security
layers - I regularly see the lsm and selinux layers spending *more*
time on security than the actual operation takes because the security
people have written random code without taking performance into
account - and I need to see *reasons* for adding more crap in this
area, not "let's expand" with no actual reason given.

So I really think that commit needs to be either reverted or explained
very clearly why user policy _needs_ to care for the difference
between a module load and a firmware image load.

Because I think any such explanation is likely complete BS. The
difference between loading modules and loading firmware usually would
boil down to "different hardware does things differently". There's no
obvious reason why one should be considered different from another
from a security standpoint.

               Linus
