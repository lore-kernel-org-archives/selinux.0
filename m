Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13860
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:27:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA11562
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 22:26:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA11557 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 22:26:20 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy "bloat" ?
Date: Sat, 20 Apr 2002 00:27:18 +0200
References: <20020419185507.B11916@lemuria.org> <20020419201154.4F75844F1A@lyta.coker.com.au> <20020419221455.B12025@lemuria.org>
In-Reply-To: <20020419221455.B12025@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020419222719.3FEBE44F46@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 22:14, Tom wrote:
> > > If so, would it make sense to include a 2nd, "minimal" example policy?
> >
> > It does not make sense to have another policy which is the same thing but
> > with a few files removed.
>
> Removing is some work, so I thought for people who'd rather build their
> policy from the ground up, a minimal config may be a better starting
> place. Just an idea.

Removing is much easier than adding, unless you add wildly permissive domains.

> > PS  Today I released a new version of my Debian packages.
>
> You are evil. That means I have to update again on monday. :)

I've just released a new version, and I'll probably have another before 
Monday.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
