Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C281311AC
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975386; cv=none; b=c+NmWv/JiwUH19Fr1OjwhyylmAFXNrkb+jOj0JpxccCWepmUBsZaY+n/MBHwg8zu5ts+e1d04zMqRccEB4XsVh+XmYLq5OgMUn/kIRy7jdC7QgGdYNG7+mGhdFTpZFoD4xVXa+SS94cmAS9Lo2YgD+npu0xwX44KIAaquTdj5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975386; c=relaxed/simple;
	bh=wGImJduUykEez5iL8jBCdHtYwyus7XW/YxfURAe6ZRs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LQajrXhORnLwwOJmenKHxDhm6IVcGDOOpayBWgQBRBE3XmiP3V7atZF7RkK5/zE0ho2ceAeifEFDPT0X7eyygg+ps0Y1QKxbos/vuFkkTBAq9FnQwsAadalsV5ZSJPLRgwJCIncdBizq+nVI/zWReK7a/PdXmGWOw9DfOpJhiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eiJNGbLU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eiJNGbLU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7640e484so1620137b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 19:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733975384; x=1734580184; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dA9+/PQxCKX7KIJbmEmqgdH+PYPJKykZdxvUx4wSDw=;
        b=eiJNGbLU20+2fufaYhiCJXMA7fK3ae3Np5fM/BaEXHZXckR3kvVEB5bKok05cHBs6d
         kTu0JWyNH559LgIbdNlIqKXGcZY3Z6UECw2uKeUetGzntCp3sPccFRBTP6qcXGS0vkAM
         bg3gAroJj38fxxD0V/z/6WkLeAcI823JxRiYixOxzc7KIkGl0Mb6rMsdz8QAsu3v+ePM
         pHgJdHRm6RMeWDGjVcJWab9rKP2LyULmhDppaAeYXUQu6aQHlH+jCu/I7t7a+ZfPt4T2
         MTk7bt00wfS2QF2/mHi/CEDbWErjtDKcm0Jo1B8Gqesicv+4uCoWdK/D/Hf9L5YXXn17
         iowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733975384; x=1734580184;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dA9+/PQxCKX7KIJbmEmqgdH+PYPJKykZdxvUx4wSDw=;
        b=YtL5NMgOZ3o0c8gm88QXatcXT6lja+OX7h0kqfz4/FpycdMHACKTvpbiRVaQ1Kgc+B
         +wwENKuaIZqqaKX+ua1EZZlWcSsRA5YinA+lUi9bOaa1/bRVgYGzWcUfJ04+oVohlmAv
         BsSuNDC48nSsKh7wuwGORYzLhWGQnR78jRa267nugA6DocoqX5rtu7wstCaHfMxcclHO
         /XJeKCnc3R4MXWNfcnh35pEs+9UB83TRNSsLrlt3aSHFJC+jYYkMnoNatxjKqhuYl5rg
         WA1tJ3lWkWOqjSldexkksjr4anU3biI3oZVlWQMAqKm78iD1zcExcxojaXufOkmOBixO
         vHyw==
X-Gm-Message-State: AOJu0Yys8qfO0AzNuGc/YzXIR1Gk7M3xaMSjvcLel14Pc8HbXqh2ufU0
	UjOAOGeA0P4vXfa8DfDsg0dEgW9jeQQRHxicwCUXjj4qXY8vCDE+Ytry7V1u1zukpBls/xCUpvL
	SsoTWtMxN2OO+l3tcFXbO0iC4LIQNrSS1tGgHNWo78vNgtXnMJg==
X-Gm-Gg: ASbGnctSyC+c3teL0ERbgfnghdRq7QFa0QLaxxW0IyU1FEhQmh1PWRbhMVxyouowG3I
	joz/KJJ3Re79uz+AYMSb607rHvypjy1GbMwdB
X-Google-Smtp-Source: AGHT+IHwhYbSc6PvQWsX5S1h+1gkxjIlflviJW5uVlxXbKyW21p5QEHf7uaUy7qQGxYSmYzRXT3g1ZUd5kq/DNs2Pz4=
X-Received: by 2002:a05:690c:3589:b0:6ee:694f:fea3 with SMTP id
 00721157ae682-6f19e4f0f56mr20865887b3.14.1733975383716; Wed, 11 Dec 2024
 19:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Dec 2024 22:49:33 -0500
Message-ID: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
Subject: The curious case of pidfs and pidfds
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Late last year Chris sent an email[0] about the increasing use of
pidfds on modern systems and the difficulty in distinguishing between
pidfds and other file descriptors when passing or inheriting fds
across a process boundary.  A few months later there was a similar and
very brief discussion on a related GitHub PR[1] to add some basic
enablement in refpol.  Unfortunately both discussions faded without
much in the way of resolution and I'm concerned that we don't have a
(good) plan for handling pidfds.

As we are starting to see pidfds become more common (which I view as
an overall positive), the lack of a good way to handle pidfds is
becoming more of an issue.  Having just started to look at some of the
kernel code a couple of hours ago (see fs/pidfs.c) I'm worried that
many of the access controls we have for /proc/PID may be missing or
bypassed with pidfds and their associated inodes.  I haven't spent a
lot of time on this just yet, and with the upcoming holidays it isn't
clear how far I'll get before the end of the year, but I wanted to
send out another email on this topic to see if anyone else has spent
any time looking at pidfds and pidfs.

Anyone?

[0] https://lore.kernel.org/selinux/da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com
[1] https://github.com/SELinuxProject/refpolicy/pull/762

-- 
paul-moore.com
