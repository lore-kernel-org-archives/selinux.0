Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E21126C10
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696025; cv=none; b=chdQAiOlE63knmFemFTL6Fc6aErwnYRaHaDyeXv4LlYnpv8rkE/cV6ZA3luoN9v12C03sNEUQ61o4UDbbr1dAlY8dhucecXOWyDazVQuDDEEeEP0puzbE/MaswRBbrpQd0ElCmFvGoTD6FaQZ7WeN4f2AvlBLJp2MQBT8OcABuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696025; c=relaxed/simple;
	bh=5qPmmCQFw1GLJWZnGu+8zc4z5EDDMOvl7s13qP3L6HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8HTsVL6z2bUJMoUCXAo5xiEA0eF9Wv+HGx26AkTi2+DrxhghHmQ1FD3m0Bna46LhH1lRL3De9dNIRkIOs7ZTnDlaoWZbssE+C19LYPDI+B+IiQpMite7oQrgLTN+Ii9kEjugrxJ1t8Ssr8RZqPr+FB7vykcgkyYxueSMOPnyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EofFHI+W; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EofFHI+W"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e380fe87b09so2039277276.1
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731696023; x=1732300823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qPmmCQFw1GLJWZnGu+8zc4z5EDDMOvl7s13qP3L6HA=;
        b=EofFHI+WOuLQl5LF/OVhwQ2HTKgO4bpuJkgpQA/jC0pthvRU4NLqF6HEIxEtFv512s
         3d9V/w/1cb7DNZsivHMbnA+KIhbnVSwqfo1BuGEgooF/2aO5VmBOktPKO+D1m4Rfc5RR
         io0X4TuNJ3awOpsv/eol/H/jLIbVgJuzLk6qvvmSwJzd2hILPKo7hVNNNR/X/sL7bmog
         eiHkwqo3H1RZoKAkjmpK/RrHFBB2kIME9koQVGrPj7eT3HmzDwLogwUwTMW9vane1sBS
         uJIYbspEUxityPiOyqruB9sC3dgHpl+FypSxaV7Ay0ioSens2ylnWpzVgtuL42j8ULjX
         8ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696023; x=1732300823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qPmmCQFw1GLJWZnGu+8zc4z5EDDMOvl7s13qP3L6HA=;
        b=Tuf6FSMQv+7RKecaorJ75xp8cSz2SxxY4VgvMdiFcGeyOfmJMqYHyhkzBqHI4Qj5vN
         WvSJuy1r0CJH0a5k2KubNh+RpRC4FysTKL7ETKHMj9xPcyihsZE6m57MvaU0tzxMI0HX
         luTWK+ZUtfZO/+CmNu/4fBKY8jSjB5oK/QlNdf+2SqtD0BRsazBfS2NATHgco/hdfE61
         EaShL6o8+tyaXa9Ny3wRuHp3MXsWvu5oRuz4k8DbcxCOmKg/gLmCevR2+3m1+pdATbsF
         VmJOAEI5ldN9UFlwohTlQ/GFqqV70soI4+oJA4LEqGQb4C7mmXYR1Q96rpvJCHi7gJ3N
         6fXA==
X-Gm-Message-State: AOJu0YxXJuLF1mh79PElrzfSsHIla97McqEtzJsk7vBzBCl4u+iP3zWL
	R0cA2CTUS6Hl+nPqhZbTjH4Bi0nQXAotq7KdVaEBADgbUlSYz/GGgGSSq0HkiRF0C7aiAXMOrGS
	7lu7G4H1ZqVk8ce2htmEcCxbqQ8tn4ey4vNg=
X-Google-Smtp-Source: AGHT+IGXRhVRb6n5IG7URZCoaQe1oS2/3nEWp01HDwPbot+47tJ5oVUXwhjn/GR991RyGhxFvnNE6MxQl1NSeUypxkM=
X-Received: by 2002:a05:6902:2989:b0:e30:d9b2:d8d1 with SMTP id
 3f1490d57ef6-e38263ed077mr2763594276.52.1731696023149; Fri, 15 Nov 2024
 10:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ed3flbjd.fsf@redhat.com>
In-Reply-To: <87ed3flbjd.fsf@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 15 Nov 2024 19:40:12 +0100
Message-ID: <CAJ2a_DdumsYPSWKz5F=QhB+Jq04OTbNXGAMgrtKh3CXDYXZeOw@mail.gmail.com>
Subject: Re: Intent to release 3.7
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 10:37, Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Hello,
>
> It's been about 6 months since the last release so we're going to start
> the release process.
>
> Original plan was to ship final release before end of the year, but
> given the number of changes delivered to the mailing list in last day, I
> think it'll better to postpone 3.8 to January 2025
>
> I'll tag and announce 3.8-rc1 on next Wednesday, November 27, 2024 and
> continue with next rcX every two weeks. As written above the target for
> the final release would be at the beginning of the next year.

Sounds good to me.
Some patches that might deserve a look:

I. Changing the lstat64(2) call to plain lstat(2), to improve compatibility.
Suggested on GitHub[1] and reported on the Debian Bug Tracker[2].

[1]: https://github.com/SELinuxProject/selinux/pull/401
[2]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1087016

II. Always build for LFS mode on 32-bit archs
Originally reported in February[3] and updated in March[4].
Patch looks good to me.

[3]: https://lore.kernel.org/selinux/Zc6tzKPsYZRICHya@homer.dodds.net/
[4]: https://lore.kernel.org/selinux/ZeQuOBwQ2eSbkUAS@homer.dodds.net/

The following two series from patchwork have been superseded:
- https://patchwork.kernel.org/project/selinux/list/?series=902774
- https://patchwork.kernel.org/project/selinux/list/?series=903201

>
>
> Petr
>
>
