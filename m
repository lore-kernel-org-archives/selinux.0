Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D349483B
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436450; cv=pass; b=Lrf8UuuZc3u/fSRLlDQvhmCVE1V+Mh9Mf2vVg6UbkjKgCIZKUidN+5KdOkUBeyvHY4M+7JjserkSbebsa/qL1Ungxh84iSBOqrMd2RKdkvn5zaIR1+5waAkYihgJG8yK+gf+S2I7ZbXxElA7v8Fwi1qrquO2S+WzfQGIFmGQx6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436450; c=relaxed/simple;
	bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlS9oaCQRkYC8SNiceZMzfDTQWYdm+kBL3LfaOaAwFU3d9PshUlTrw3JKtF/LzJon6StBOG6TR8ZqiQBQ9SQI4HcHd5FnwXvG/YUoFWL7x7M5fRgnVAl+3onYanInjXbL28xW6k480QsUV95TnJlnEAcG3fdVIAXwZKwNaO4PaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOZQS0+y; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOZQS0+y"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbee846deecso2944804a12.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 04:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788436444; cv=none;
        d=google.com; s=arc-20260327;
        b=TPw3SFVQtVR6x275CQcd5bojZAncPRawccJfU3xTVK8iBY4W1+mVy8SkTrybj+1+jJ
         S6bsGU7mVhXLy07JIXombQ5wRqfsmRxN2SprFD3lwOXAwU7KKoGqIK5bFdpihrF2Gf9M
         xnaNe6MXdPT9fd8PdV/xwQ2tZ/007ZGPat0AWho6/X5Xp4IokIgCsjH4LagB1HFmRGd9
         0fGdkykgQhWkf9sJPM1a/Lym1mFbzXLtWmjnfpra+EB2pjByikchk2aYED3h8DgY/rAN
         2VVQQtqWx6U1LTG6d2FZl0jDD8KSOvgsLOm5a5agSXoHga8mwTz/yqlmx9CbiqZ7P9BK
         v9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        fh=qmU2KrvLUG7v7gjGGFideqvKzrs8p4T3UkWFA/wrpCk=;
        b=UBWNes4g4XLcM15WRQdc9MowNik60YVwueIOQWJsOsFxWAgYT5hY5PIfSZTO/ZOHlA
         gNlOYbsFBXQtv+mn8cCLihG1ISozfKaZpuDVVx1x/oH2JsVJwZTZFJW2eIgfJH7iyb0n
         g2jiBZcOB8OvXNgrgyHCq1JPDG+zJrWPjisv2SA9Sbe243O/NkCMmCJbZvPrzpA5oF6G
         NnaZOHnOgYw9NJWlUcMdYo6pN0YZuj0ihfCqHU5aT34onN2PgF11nbTBV8CIvXoMlc39
         jdBhG2oO60TDu26avTnIztIdUC8C6quLwPp1LtV8dshR7hDpPJMTZ6cp5AzoRk3vkd9i
         GznA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436444; x=1789041244; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        b=oOZQS0+yEEfqtdVqvAymA2Od9R+g4vrT7ueq/oiO3JMQMeeGJ40Pz4OGTuAGPLyCHj
         ymIcM6kIKVrV5Uszp3m5JS0XeFTpwf4uASQqxaR3izCkjrQgpRCxr+dAQo4XeNIyjtZp
         oZlWCy8YwSzynD3HY8Vm3vSvH/u/LkavcPV90Dn9RR0u3Jv2jhQzbJVSYQjmY0fTABMX
         BFs2a8UEfAK1X9rW0E9/Buq/BVagjM6aazbhmfoSCIo/TawQ4Hn8d5c77O8FOHt+YCo9
         WzdEdlpt7P4556g7/1Txa4K68HGt3k/4n254vJYROLSdlXFaUJSy77ZH1PnVpyN1igvC
         AEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436444; x=1789041244;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        b=fkFmeTtPYUOuqhF7rE0ywyxXxA9UunDeLEAzFPfalJnHXoZoZnhBcnGRzc+FmoZ5QB
         uDJv4Rtc4Vge5WgaaAseybrz/SiAaErTVzuOizqc22AKBnCT/tGZohCB84DRQKMZsIpE
         aMtVPtZfTsksuJvaaxpqFm15hk3oktx/AplKnzHht/WsC8cMuRcyjMYMOpGyEaUGLy7q
         AGzfCq8a3ezmrqjBbHh4NsDgtXUcoHaxtpOHBFs37z0jh1vyaYZOWDR5oiQQ3ZixDnYn
         4qr9z2KB3RzDsCtW6MhctHeQrHEIXaQaGIXYpYBNa7+pjzNqd9X9PQejHyJmxTVuoV3Q
         yCUQ==
X-Gm-Message-State: AFuF++n0wY1SOLo0phBwkvGlaIupIlFoYwg90Fd0sbO86br2tqW+dC6d
	XcsygUfg0u3VzRyzRf0s4N6KxFJu5NOOltWlrq+0AChWDcKiFFyWW9mwd9f3ObLwKkxHzqyFbDJ
	x938lq1GvRsDI22MzEVGxKpz0hj19VYM=
X-Gm-Gg: AYBFou1pBXM6mSGCxfzvhZjbDYPts/LmZf7mTg6mxpjHfai72NQfZjVkhCn9bpVYvO5
	KuMIJW63RxoLFLn6jd10pDHjhwaevcs0bFI15YHO9JczzA0FgJicaG0sLfqnPeImqzp47jysOxb
	g4BVrBJaDiMMQNGiN6iOcdBAQz+4dxZN92wK+np3oeysV/HSR8w8Bi5b3CmFBMw6OFAYq55hcyw
	ciOiLsvnrK3Jvi8Kzz0a1AP/RWmeuT5WgxzxvRIPt3bmLIBU7ENKS4qGWV70O7Yg4E90mtj7sxb
	cDyhGZYTXOgwgLGyeeolVINURiEQrxQBfHc861SOwwmgQ2s+WVKqvOYj5TL6bgW5XVzCwwEH5Tj
	W
X-Received: by 2002:a17:90b:3d89:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39aedf89bc9mr18610572a91.5.1788436443559; Thu, 03 Sep 2026
 04:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
In-Reply-To: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Thu, 3 Sep 2026 13:53:51 +0200
X-Gm-Features: AcwNN1UoWZTfWh3agR_jdxc3Q2M3uh3UgHIHKTZhxeYlUtsA2KRhKMGejWfjeZo
Message-ID: <CAAUqJDu1R0KjX+-zj9in7sCN+2XPcqE9Uc34GNPZ+209VFou0g@mail.gmail.com>
Subject: Re: Heads up: Moving to a different email address for my Linux
 kernel/SELinux contributions
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Due to certain upcoming changes to my employer's work laptop usage
> policy, I'm being forced to more strictly separate my work-internal
> vs. upstream/personal environments/identities and in relation to that
> I'd like to transition to using my personal email
> (omosnacek@gmail.com) for my future kernel/SELinux (or other upstream
> community) contributions.
>
> My work email address remains tied to me for the foreseeable future
> and nothing really changes in terms of its abuse potential or
> whatever, so nothing bad will happen if someone accidentally sends
> anything upstream-related to this address (or continues an existing
> thread), I'd just prefer to use the personal one as the default from
> now on.
>
> I'll soon send patches to update .mailmap and MAINTAINERS in the
> kernel tree and SECURITY.md in the SELinux userspace repo accordingly.
> My future git commits (e.g. on SELinux GitHub repos) will also start
> to show my personal email address in the metadata + Signed-off-by.
>
> Hopefully I didn't miss any important detail and the transition will be smooth.
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.

Acknowledging this from the new address as well.
