Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5E5KtgA011888
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 01:20:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5E5CfBf026357
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 05:12:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [RFC] Module language syntax
Date: Tue, 14 Jun 2005 15:12:16 +1000
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
References: <1117217853.9785.22.camel@localhost> <20050527185331.GA1544@lkcl.net> <1117220066.9783.27.camel@localhost>
In-Reply-To: <1117220066.9783.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506141512.21436.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 28 May 2005 04:54, Joshua Brindle <jbrindle@tresys.com> wrote:
> booleans and conditionals are runtime and are not at all affected by the

So loading a module can define new booleans?

> loadable modules. The optional dependencies added for modules are
> totally separate from conditionals and are much closer to m4 ifdefs in
> practice and could hopefully be used to replace many of them.

The optional parts of modules will still take up disk space.  I presume that 
they will take up RAM as well - the program that loads the policy won't know 
which modules might be loaded.

Currently the strict policy is 10M in size and growing.  This is a problem 
that will become worse if we remove ifdefs.

Some ifdefs will need to be changed to optional dependencies for correct 
functionality, maybe many.  I don't see this as a benefit but rather as an 
unavoidable problem that is outweighed by the benefits of modules.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
