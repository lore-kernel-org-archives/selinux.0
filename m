Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318D1AD9EE
	for <selinux@vger.kernel.org>; Thu, 20 Jun 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894365; cv=none; b=qI+1b2S2/hSptzS1xmNb4NGjF5XQVoRdsopJbqHkWH/aYYA1RQqcNkEp7rsmumOL8kyJ0jCN147omdiOnMcMiSwKsfqzhlK4o6mSs9n5QDCDav5ejkPKnwEcXFmvI5SsMfGyQh/uRuLe76RjgUJbN54U72pU7p1YRnNxd9tJiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894365; c=relaxed/simple;
	bh=I8JAbpL3PqkA/EkE72QMuFZnLHqtF83qkStDr0N4H38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2qci7gf8OHN7AUplPvxOBdebgz+ib6xNkUkTJ1XqagBT79OQq4FpqWmpJ47wczO4zY3YnsMl4kyG3TcCUJJtnqNVM1p15uthkl1BWyZoxwofb55St+HRNXEnLcy12BxVaP/OqXPvzF0gLM/3qRevQDQv26+tk+CIRM3awsfLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HA4/QOVJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HA4/QOVJ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfab5f7e749so874330276.0
        for <selinux@vger.kernel.org>; Thu, 20 Jun 2024 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718894363; x=1719499163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBK8rutGei3y8cl5HYXKe7qhfX+aGQujhf+KTCzTbro=;
        b=HA4/QOVJhCSuIjxhHGMenVwGHuMWqYunItGJc8sb63ixofqq8A9s1+G2RvYweY9zje
         7V1MYceEPpJ3qdMy2p6IsAz9nATk2XHbroU+Y+hrf8ZOdnwET6FcBBhDLGQcfSjJThGk
         8wlVSHF054gBpEv5byI9DUHSBb8tfFWNcK4MuC7yM7ivNGH2vpsOjH2iupaIXcMmapj5
         TBwES1/weqpv52t4ruz21mXu5LM0ljeRyWQMkFiK3ySm/bYRPbr6wu/jLXXWoo68DLUu
         XDPta4XG+/PkWtXho7uqiSSZqonjUgyykEhUUooPiXBMmXio1DmqdsQq0rXh1kR6ctOJ
         WlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894363; x=1719499163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBK8rutGei3y8cl5HYXKe7qhfX+aGQujhf+KTCzTbro=;
        b=qdQEKsVgmIbqKXVr5//np7+Cv8aKUxcyvHkQziPqSPHVfbU5QHSBqi7B/s9WT6GrGe
         0ZOM365hWzw+CR9f2TuVAGwJQvzhj85+I4H5pGXf+qjQfEOzRRIpkakyDLlcvj147RHp
         5kqm27JCMG4UUrLOzrIV/MOTN39uKDTZZe6IsnaD/vayevkoGiOmvNips35OpUyAFneV
         0qyZCRJ3tAo2GHfa7HDIPHUhyyMK24mL8qa3Jthw3ZKcmSMou450akG2Ko96Dhd17T/c
         4GLx5KQkFlt+jeq+wujmXl2k4yNTd2fLQ0z2tzO+COgWmw1DBuodRExybGwTYXc9USEe
         o0QA==
X-Forwarded-Encrypted: i=1; AJvYcCWe0YEsgYM2Z5WN9qpADo6REQME6OH2nyNV7mkuh4khiA5C/Cg+8vAy6pHwPFYulx4d4Q8TSqQmv5BaVdExu7ds62KuupJziA==
X-Gm-Message-State: AOJu0Yy5Wt9k6G4EepsOr1PpCmLB9ZOlp/7BIVs3OHYMa8QUksuuN+wY
	sPhecH5qhKSi5+kLJBHopDiIqKQE1L5Pj0m9C07Q5RunuoenRhDltw0lVdz3gu6qF3gABdTiGAs
	AAw/yVsPjZ5VT9DgUdh0gUcvAQ89MXQJm9KUD
X-Google-Smtp-Source: AGHT+IFWgVeHFD7xuaYmPthmiJaG3UnzIljalYgp8EGE74ka/RrztYjjeEXPQRf0wFwWOPTmWpmdEgPzHxWlrrcllWI=
X-Received: by 2002:a25:ab46:0:b0:e02:b888:79ae with SMTP id
 3f1490d57ef6-e02be22851bmr5225111276.62.1718894362774; Thu, 20 Jun 2024
 07:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
 <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com>
In-Reply-To: <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 10:39:11 -0400
Message-ID: <CAHC9VhTwFyMhYK448gBpwO7M4bEBCOq-f=-ztn1vro9nQU9v0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Wed, Jun 19, 2024 at 4:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@kern=
el.org> wrote:
> > >>
> > >> Hello:
> > >>
> > >> This series was applied to netdev/net.git (main)
> > >> by David S. Miller <davem@davemloft.net>:
> > >
> > > Welp, that was premature based on the testing requests in the other
> > > thread, but what's done is done.
> > >
> > > Ondrej, please accelerate the testing if possible as this patchset no=
w
> > > in the netdev tree and it would be good to know if it need a fix or
> > > reverting before the next merge window.
> >
> > Ondrej, can you confirm that you are currently working on testing this
> > patchset as requested?

[NOTE: adding SELinux list as a FYI for potential breakage in upcoming kern=
els]

> Not really... I tried some more to get cloud-init to work on FreeBSD,
> but still no luck...

As mentioned previously, if you aren't able to fit the testing into
your automated framework, you'll need to do some manual testing to
verify the patches.

> Anyway, I still don't see why I should waste my
> time on testing this scenario, since you didn't provide any credible
> hypothesis on why/what should break there.

I did share my concern about changes in packet length across the
network path and an uncertainty about how different clients might
react.  While you tested with Linux based systems, I requested that
you test with at least one non-Linux client to help verify that things
are handled properly.

Perhaps you don't view that concern as credible, but it is something
I'm worried about as a common use case is for non-Linux clients to
connect over an unlabeled, single label/level network to a Linux
gateway which then routes traffic over different networks, some with
explicit labeling.

If you don't believe that testing this is important Ondrej, trust
those who have worked with a number of users who have deployed these
types of systems that this is important.

> Convince me that there is a
> valid concern and I will be much more willing to put more effort into
> it.

I've shared my concerns with you, both in previous threads and now in
this thread.  This really shouldn't be about convincing you to do The
Right Thing and verify that your patch doesn't break existing users,
it should be about you wanting to do The Right Thing so your work
doesn't break the kernel.

> You see something there that I don't, and I'd like to see and
> understand it, too. Let's turn it from *your* concern to *our* concern
> (or lack of it) and then the cooperation will work better.

It's not about you or I, it's about all of the users who rely on this
functionality and not wanting to break things for them.

Test your patches Ondrej, if you don't you'll find me increasingly
reluctant to accept anything from you in any of the trees I look
after.

> BTW, I was also surprised that David merged the patches quietly like
> this. I don't know if he didn't see your comments or if he knowingly
> dismissed them...

I've seen DaveM do this before, but as Jakub has been the one pulling
the labeled networking patches after my ACK I thought DaveM was no
longer doing that type of work.  My guess based on previous experience
is that DaveM didn't see any comments on your latest patchset - as we
were still discussing things in the previous thread - but only DaveM
can comment on that, and it really isn't very important at this point.

--=20
paul-moore.com
