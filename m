Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA16075
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 11:40:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26623
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 15:39:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA26607 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 15:39:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: success story
Date: Wed, 28 Aug 2002 17:40:34 +0200
References: <20020828145606.A4758@lemuria.org> <20020828133557.831BC8FDA@lyta.coker.com.au> <20020828165429.B7518@lemuria.org>
In-Reply-To: <20020828165429.B7518@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020828154035.5218C8FDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 16:54, Tom wrote:
> On Wed, Aug 28, 2002 at 03:35:57PM +0200, Russell Coker wrote:
> > Please try my latest policy on http://www.coker.com.au/selinux/policy.tgz
>
> oops, I didn't know you release them daily. :)

I don't "release" them daily.  That URL is for non-release versions, 
development snapshots.  "Release" versions are in Debian packages and can be 
downloaded through apt-get.

> mine was from last week or so. I installed your latest one and indeed,

OK, I was under the impression that you had an older one than that.

> proftpd works great. there are still some postfix errors. I'll have a
> better look tomorrow.

I look forward to it.  Although please make sure that you have the correct 
labels on files, the postfix.fc has changed a bit recently...

Postfix is very complex and it's difficult to get right.  :(

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
