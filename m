Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F517BB0F
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997867; cv=none; b=jEJ4OHCgFWdNzomsjVqeq/AIKrpcoUNMO8DsQ8BJoUk0MYRQqJLFhVlhasxckNZBtNipIwVUSYo7ST50q5U0Hd+W7NsnUvP2c1rdoP1MDyOHXHE+TSQlg6IOo8ik2kjta/I2zod319TkT4t+rY7rjtRVE11uy8LoRIe6Wde7TW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997867; c=relaxed/simple;
	bh=ivSz3Dyal+GkU5kxkc0GC24zn+dmyvB5f7XdPLqkhqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l459eBvMIiHYAxMMEGmUjoq8KRbXLb5TYK06BBThxwi6o1rVnYlNgFSVyPxmwPVp2zByzzEC0XWgerMz0g3qLpAZ+KUpZTRttScV1OBYLrYQZ9TFIeqYD3DIcVusAQzcCrkBYN848sEJvVqE2CoOS+IMykS1vab3+RMse9Ab45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO95iTDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO95iTDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721997863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzrxUvNCTcI6hUzK4kLRhdqlCUXjbl3RzRk2Ub6q4+c=;
	b=EO95iTDIHw14ox8HUjcS2lN+1jfCaxScomFqCSwlcJcf1uRiqHMyX8TLfiIes6krlbcrUN
	S6XUZXBwd0SaDd0jkdZys1zTzIPrWcZeJLvkjxJt0nMTJQGBqc5sCo39lpOLUwQ5FxjeZv
	iLMjnijWObb4vU1fs025iQSqx0JsPq0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-mF-ZYYukMdGQezRnCwZ7ig-1; Fri, 26 Jul 2024 08:44:22 -0400
X-MC-Unique: mF-ZYYukMdGQezRnCwZ7ig-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb5d93c529so1058443a91.0
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 05:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997861; x=1722602661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzrxUvNCTcI6hUzK4kLRhdqlCUXjbl3RzRk2Ub6q4+c=;
        b=KH7TF21SYB+xsCwvFUoOKrxFFyQ2kVL7MNPW9aiw0qgeLxIpolhSIROZvfbrgGP6En
         lXZn4hLKiS4xv8Wqjo42ae/3iaFRNDqOeFTVcvuMHNshrTLUYBR3vlZxzmBWERRr18sg
         DoSegtDDwYs+tsnRWIXeXpsliBCb7DEuqpITqhXRxI4k56q150m3xHIDbm2ezMjW6Vkf
         G2c6L8lPEPSwo+Fv+zFuhtBcVYLYBt+nT/FN4U3yFxnfp/brI057Axn2HPaoi6+poHcP
         h5BSoBUrHqgtH1Ju2ZQtmWShhK3/APtpo1cIifW8ZxEyAHWphK1BKW/HibRhq9l3TCpx
         cmFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNxOmVLXuY8JO56Wi0EJWiHpDmawpbP8eMZcdopFMChVys8GqQw7p+Riz7nJS3xeReXt793oh7M6zMTJ+bO/TffFxbMFaPFA==
X-Gm-Message-State: AOJu0Yy4Lex0sjFbM+8dZaeTls3PWJ60vOSh9rQRch2p0s8efX0tFNSn
	Jh0UWBfV7t0Ch25nLHVA/0OI/F6g6HrRF9qzNutoPLyMhbaRJiztW581UNYDjTcWv9KSOZOT6Wb
	ZtnL0H4AZWLaX8HmDbNbZ5Km82Di3fLRUL3TeuBfSk7QhvwhqAvFAVinsBaMKnOsMJIJw+EzAXn
	ypfh6WrtVIiW97eBG+54GuUlr7yYUksunhVJk79g==
X-Received: by 2002:a17:90a:ee8f:b0:2cb:6419:5b53 with SMTP id 98e67ed59e1d1-2cf237dc568mr7207739a91.24.1721997861004;
        Fri, 26 Jul 2024 05:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETmA5FGd6JwdaTqVMDJGKDRghvF/hzgOQ6sMgXzz9gHgcjQAvU+30uXKW4YJ04AKNcVPJT2SmUvzPkuIs7g28=
X-Received: by 2002:a17:90a:ee8f:b0:2cb:6419:5b53 with SMTP id
 98e67ed59e1d1-2cf237dc568mr7207714a91.24.1721997860587; Fri, 26 Jul 2024
 05:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
 <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com> <CAHC9VhTwFyMhYK448gBpwO7M4bEBCOq-f=-ztn1vro9nQU9v0A@mail.gmail.com>
In-Reply-To: <CAHC9VhTwFyMhYK448gBpwO7M4bEBCOq-f=-ztn1vro9nQU9v0A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jul 2024 14:44:09 +0200
Message-ID: <CAFqZXNuwruVUeLV8PKBbxBqa9ubbvE+NGVnOumzH+BCXcRNZBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 20, 2024 at 6:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Wed, Jun 19, 2024 at 4:46=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@ke=
rnel.org> wrote:
> > > >>
> > > >> Hello:
> > > >>
> > > >> This series was applied to netdev/net.git (main)
> > > >> by David S. Miller <davem@davemloft.net>:
> > > >
> > > > Welp, that was premature based on the testing requests in the other
> > > > thread, but what's done is done.
> > > >
> > > > Ondrej, please accelerate the testing if possible as this patchset =
now
> > > > in the netdev tree and it would be good to know if it need a fix or
> > > > reverting before the next merge window.
> > >
> > > Ondrej, can you confirm that you are currently working on testing thi=
s
> > > patchset as requested?
>
> [NOTE: adding SELinux list as a FYI for potential breakage in upcoming ke=
rnels]
>
> > Not really... I tried some more to get cloud-init to work on FreeBSD,
> > but still no luck...
>
> As mentioned previously, if you aren't able to fit the testing into
> your automated framework, you'll need to do some manual testing to
> verify the patches.

Sigh... okay, I now did test the scenario with a FreeBSD system as B
and it passed.

> > Anyway, I still don't see why I should waste my
> > time on testing this scenario, since you didn't provide any credible
> > hypothesis on why/what should break there.
>
> I did share my concern about changes in packet length across the
> network path and an uncertainty about how different clients might
> react.  While you tested with Linux based systems, I requested that
> you test with at least one non-Linux client to help verify that things
> are handled properly.
>
> Perhaps you don't view that concern as credible, but it is something
> I'm worried about as a common use case is for non-Linux clients to
> connect over an unlabeled, single label/level network to a Linux
> gateway which then routes traffic over different networks, some with
> explicit labeling.
>
> If you don't believe that testing this is important Ondrej, trust
> those who have worked with a number of users who have deployed these
> types of systems that this is important.

I'm not saying the concern is not credible or that (in general)
testing this use case is not important. What I'm missing is some
explanation/reasoning that would make me think "Oh yeah, these patches
really could break this scenario". You said something about consistent
IP header overhead and bidirectional stream-based connections, but I
don't understand how the former could cause an issue with the latter.
Does it violate some specification? And I'm not arguing that there
isn't a possible bug because I don't see it; I'm just arguing that if
there is a mechanism through which the change could cause a bug in
this scenario, you should be able to explain it (at least roughly) to
someone who doesn't see it there.

>
> > Convince me that there is a
> > valid concern and I will be much more willing to put more effort into
> > it.
>
> I've shared my concerns with you, both in previous threads and now in
> this thread.  This really shouldn't be about convincing you to do The
> Right Thing and verify that your patch doesn't break existing users,
> it should be about you wanting to do The Right Thing so your work
> doesn't break the kernel.
>
> > You see something there that I don't, and I'd like to see and
> > understand it, too. Let's turn it from *your* concern to *our* concern
> > (or lack of it) and then the cooperation will work better.
>
> It's not about you or I, it's about all of the users who rely on this
> functionality and not wanting to break things for them.
>
> Test your patches Ondrej, if you don't you'll find me increasingly
> reluctant to accept anything from you in any of the trees I look
> after.

Paul, I don't want to break the kernel, but that doesn't mean I will
do an excessive amount of work for someone else when there doesn't
seem to be a logical reason to do so. IMHO, just because someone
somewhere has a special hard-to-test use case that is very important
to them doesn't mean that it is your job as a community project
maintainer to force other contributors to do work to defend these
peoples' use cases. The fact that we don't see any effort from them to
have their use case tested upstream (they could either auto-run their
tests on patches themselves and mail back the results or provide the
test code and/or infrastructure and ask maintainers + contributors to
run the tests on patches before they are merged) means that one of the
following is true:
1. They do care about upstream not breaking their use case, but expect
that upstream will automatically ensure that "for free".
2. They accept the fact that upstream may break their use case and
they rely on testing at a later stage to find issues and
reporting/fixing the bugs once they are found. Usually this is because
they have calculated / assume that at the given time, the cost of
implementing/facilitating testing on upstream level is higher than the
cost of finding the bugs later and waiting for the upstream kernel to
become usable again.
In both cases it doesn't make sense for the community to self-impose
the need to substitute the lack of effort from the consumer side, and
much less so to push that effort to others (which will just drive
contributors away, which is a far worse consequence than possibly
breaking some complex scenario once in a while). However, as soon as
someone comes and says "Hey, we have this test, this is how you can
run it. Can you make sure patches touching X are tested with it? If
it's too much of a hassle, let us help to make it work.", it's an
entirely different situation and we (both contributors and
maintainers) should very much do our best to fulfill the request.

This is my idea of how the fine balance in the
user-maintainer-contributor relationship could work best. I'm writing
it here so that you can understand where I'm coming from and perhaps
ponder about it a bit. But the main point here is that you requested a
complicated scenario to be tested without adequately explaining what
you assume to be possibly broken. And I also pointed out that the
behavior you seem to think can cause breakage is already present in
the current code - you didn't answer that. So I feel like you
arbitrarily push some high-effort requirement on me and that's not
nice.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

