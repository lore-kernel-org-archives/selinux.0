Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA10655
	for <selinux@tycho.nsa.gov>; Fri, 12 Apr 2002 12:33:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA27923
	for <selinux@tycho.nsa.gov>; Fri, 12 Apr 2002 16:32:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA27913 for <selinux@tycho.nsa.gov>; Fri, 12 Apr 2002 16:32:42 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 18:33:35 +0200
References: <Pine.GSO.4.33.0204120840060.21729-100000@raven> <20020412161729.B29624@lemuria.org> <20020412170130.A30042@lemuria.org>
In-Reply-To: <20020412170130.A30042@lemuria.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020412163336.32FB044BF0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 17:01, Tom wrote:
> On Fri, Apr 12, 2002 at 04:17:29PM +0200, Tom wrote:
> > It looks like I solved the problem, at least it now boots and appears
> > to run fine, except that I can't log in remotely, but ssh localhost
> > works. I'll inspect that later.
>
> Funny thing, I guess I found the revers of "NoRootLogin" :)

Do you have an entry in /etc/security/default_context?

I think this may be a bug, but haven't looked into it deeply enough.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
