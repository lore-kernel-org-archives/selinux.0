Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QKHbgA019645
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 16:17:37 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QKHCFZ016206
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 20:17:13 GMT
Subject: Re: Alternative user management approach
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506270238.24851.russell@coker.com.au>
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
	 <42BD7A43.909@tresys.com> <1119728228.13078.34.camel@localhost.localdomain>
	 <200506270238.24851.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 26 Jun 2005 16:17:46 -0400
Message-Id: <1119817066.2454.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-27 at 02:38 +1000, Russell Coker wrote:
> On Sunday 26 June 2005 05:37, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > > The biggest challenge after this is labeling, how to label home
> > > directories
> >
> > How to label the home directories?
> > Will directories keep their role-dependent contexts?
> 
> Yes.  Only the identity of the home directories will have to change. This 
> means of course that genhomedircon needs to be updated to know how to map 
> Unix account names to SE Linux identities, that shouldn't be difficult.

We're moving to a libsepol solution written in C, automatically
invoked from useradd - so nothing's as easy as it seems. Once finished,
however, the C solution should be smarter, and more capable than
the python tool.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
