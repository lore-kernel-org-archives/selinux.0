Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ICCtrT019710
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 08:12:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ICCqRq016558
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 12:12:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ian Campbell <icampbell@arcom.com>
Subject: Re: [patch] setting default role from ssh
Date: Wed, 18 Aug 2004 22:12:46 +1000
Cc: Timothy Wood <timothy@diyab.net>, Colin Walters <walters@verbum.org>,
   Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   Nalin The Nalinator Dahyabhai <nalin@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <1092513257.4515.28.camel@nexus.verbum.private> <200408181750.19891.russell@coker.com.au> <1092821707.8246.30.camel@icampbell-debian>
In-Reply-To: <1092821707.8246.30.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408182212.46564.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Aug 2004 19:35, Ian Campbell <icampbell@arcom.com> wrote:
> On Wed, 2004-08-18 at 08:50, Russell Coker wrote:
> > This style option seems like a useful feature, I don't think that we want
> > to have SE Linux conflict with it.
>
> I assume you are talking about the ssh command line rather than anything
> to do with the protocol itself. In which case what about just adding a
> --role=XXX (or whatever name) option rather than trying to cram more
> information into the limited number of meta-characters available for the
> user/host on the command line?

We could have a --role option on the command line, but that data needs to be 
transmitted to the server somehow.  Munging an existing field (EG by adding 
":role" to the end of the user name) allows preserving compatability with the 
existing ssh implementation.

Is there any way of adding such data to the ssh connection without breaking 
the protocol?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
