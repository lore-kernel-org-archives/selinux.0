Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA335943
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485894; cv=none; b=pu2w+uvUIR/ZXPi+9BMmOUFqmLqmzKaTqJiScHuo3NeUM6fc1Da6bkSNurXrxLOJ/8+/ggXSOfEekuVlJCMK8GxguRgAsLlZXhv+EIkKvGaEYZDKOPZgS0RCVqlWi8gm2ITYPWCOZebyvInGsJQBrxYI5C5ZiKJ9gyCQ0CjMjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485894; c=relaxed/simple;
	bh=sJFoOt5LoEDUWtZDnE0BEE1g0wIpUvqp6koKPjXmN6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHaKWLujPnqsfA1aVq0Wcb9HJyU2ZDrHhWrXicqEdQHkithFANIpwagY805Ovl9qLNOrDNKc7SuixkleOn7eps4S9XOxpQTVnqvaXkrBesZihLdh2CtMQfV6J8FV4U9/M4KPMFBuK5C/Y0r7jVVsLzX8dqBBn72G7mEX09bLIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UdZmelAV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdZmelAV"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30039432861so65591591fa.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 17:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734485891; x=1735090691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tTw+5TyexKkWCi3v4oEfU8ZXn9M7LHfztZgCa3P7G6Y=;
        b=UdZmelAV2qDsYn1B7QO6CXjwxCAl6M48lBHntk9Q/YArPIGcjmy7O86YIA/r4iZMP1
         MPDdIUSiOr70glw4+muKTtXXG9IThkWqr6BVQ54h+RjOYXvJiWLwQPzThiWvPhc5xYWh
         J/vavw+aXhUP3a2DJ0ZcOvHM+W/Ex0J4PFE6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485891; x=1735090691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTw+5TyexKkWCi3v4oEfU8ZXn9M7LHfztZgCa3P7G6Y=;
        b=e/3RBoWBdzFGXMMGnN+/27fpca2SaBDC7LOlv7ZamXZ1krRSwSZKHKYBzDyE1mTthc
         KjNRX/oRxP1uM1MktnWr8Nw7PfsFF9XMWrZz4j5abKFvIA8GsUSHNJ28eVAgUHZk19fH
         00mZVT8xIMsS+jnUy1unNh5+db+3Ki4D8yxMefSZ/IStU/nI8lXOvOdZd/9aeejULK/4
         4hz5jQat6tesJIVeOI8AIoNXqiDVMDrHcegOi/Q9VDgyq8hqDBm64dbVeOQWvQInUiUy
         M1iFsEbJcbF8+p/gNVlzkHyDr55+NB370PHkKJKVtiN+uU7pq0PR19RVPbsa+CHe+X7H
         6s8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ibkvt+fYyh4AItsF9o+NvKALvvHn3qAgaMe1ZRNdu3JOzs/HnOsLCcuuKAOKY2bTlqDG1te2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeogm+7XiXvUPJ2pOQbzamE5J/E+5m11g84hCxi6k698+VU8r
	KsYpzmm4bPGV/qcN/3TziU1kaYmBknjYZb2XpBBlUGSJ2fD1WfA/b64ha95rarrZoE9RJoG6P8F
	RBUIA61WvyMJvG2uDOYaGpG0GRApqbhbqUTc=
X-Gm-Gg: ASbGncvW9DtV0iUwmOYdzOskMQ3k3kCg86Q/mykR8SnZCyYiFCW8zvbXEJyNxHhsmcq
	bqwq+UcgeQWa3gCzuyDxNAbkxbXgFf4lrUQTWtm9NZsbrxDFuF9GZUOtnC4qmAJFs3oHq
X-Google-Smtp-Source: AGHT+IHExv5ASdFpxoJIEspSXfEkPyYaTz2dyjkQsgzS+ZTCz1kLSRrgNevgxlASLIB2ncFIHGW4fKxkikPa+UECXy8=
X-Received: by 2002:a05:6512:3193:b0:540:1be6:f15f with SMTP id
 2adb3069b0e04-541dc988a55mr413995e87.0.1734485890238; Tue, 17 Dec 2024
 17:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
 <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
 <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com>
 <CAH9xa6d+zJRoZMO+ip_DR88vhxBf6PoneQBkrGuR7F6PqD1r-g@mail.gmail.com> <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
In-Reply-To: <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 18 Dec 2024 10:37:58 +0900
Message-ID: <CAH9xa6c7AAvMUE+DK2tDD65Nsg3S663iH2fZLeeNc+mSPjfT2g@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The speed at which a new nice-to-have feature can be adopted is
> generally not something I worry about, it's a new *feature*, not a bug
> fix so if it takes some time to be fully adopted that is okay.  What I
> do concern myself about is the quality and long term maintainability
> of the kernel code, especially when user visible changes are
> concerned.  Adding kernel complexity for changes like this, especially
> when they can be handled in userspace is almost always going to be a
> no-go as far as I'm concerned.

The perspective of long term maintainability being more important is completely
understandable. Also, your comments on the other alternatives are well-taken.
Thank you very much for your input. Then, I will update my patch based on the
full match, also reflecting your review comments.

In the meantime, I'd like to confirm one remaining option that we haven't yet
discussed, just to consider all possibilities. If the concern is primarily
about the implementation rather than the behavior itself, would it be feasible
to implement prefix matching using a dedicated helper function instead of using
a trailing wildcard character like '*'?"
