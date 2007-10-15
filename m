Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FEhYNw017279
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 10:43:35 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FEhUbS004922
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 14:43:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: checkmodule and MLS/MCS support
Date: Tue, 16 Oct 2007 00:42:40 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200710142206.29369.russell@coker.com.au> <4712657A.5010105@manicmethod.com>
In-Reply-To: <4712657A.5010105@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710160042.42915.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 15 October 2007 04:52, Joshua Brindle <method@manicmethod.com> 
wrote:
> Russell Coker wrote:
> > http://ramblingfoo.blogspot.com/2007/10/selinux-mlsmcs-support.html
> >
> > Given that everyone who is working on SE Linux seems to be working on MCS
> > and MLS systems, would it make sense to have the default checkmodule
> > operation be to generate modules for MLS/MCS policy?
>
> Changing defaults is a bad idea. Gentoo, for example, builds policy on
> end systems. Things would all of a sudden blow up on every policy
> installation if the default changed.

No, it would only blow up systems that don't use the default if they don't 
explicitly use the correct option.

One possibility would be to have explicit options for MLS and non-MLS and the 
default be to detect what is in use on the current systems (most times you 
either produce policy for the current system or for an identical system).

Another possibility would be to have checkmodule produce a warning message if 
it was building a module that would not load on the current system.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
