Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18166
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 07:44:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA11535
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:43:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA11531
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:43:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: patches to policy question
Date: Tue, 29 Oct 2002 13:44:41 +0100
References: <20021029131543.C24527@lemuria.org>
In-Reply-To: <20021029131543.C24527@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210291344.41948.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Oct 2002 13:15, Tom wrote:
> I've posted a few patches against Russell's default policy, but I've
> started to wonder about the general workflow.
>
> Is Russell's policy worked into the NSA CVS, so the workflow would be
> 3rd Part -> Russell -> NSA ?
> Or would it be better if I (or anyone else) would also diff changes
> against the latest NSA release and post those patches?
>
> Is posting here the right way to submit patches anyway?

I regularly post patches here that get merged into the NSA tree.

If you are working based on my tree then sending the patches to me may be 
easiest for you.  Also if you are working on something that I am working on 
or have recently worked on then it may be easiest for everyone if you send 
the patches to me.

But sending patches to the list which apply against the CVS will also work.

Posting patches here is the right way IMHO.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
