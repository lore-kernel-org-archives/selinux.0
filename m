Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K4xtrT001581
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 00:59:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K4xrQ4017126
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 04:59:54 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3CAC761AF7
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:59:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20643-05 for <selinux@tycho.nsa.gov>;
	Fri, 20 Aug 2004 14:59:52 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D262E61AF6
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:59:51 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E88B7B57DB
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:59:47 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: distro.tun
Date: Fri, 20 Aug 2004 14:59:47 +1000
References: <200408192333.25072.russell@coker.com.au>
In-Reply-To: <200408192333.25072.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DVYJBlADMYWP0av"
Message-Id: <200408201459.47366.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_DVYJBlADMYWP0av
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 19 Aug 2004 23:33, Russell Coker <russell@coker.com.au> wrote:
> The attached patch makes the distro tunable macros define to their same
> values.  This is useful because distributions have many files named after
> the distribution and sometimes the file needs a different label to other
> files in the same directory.
>
> Of course we could have names like (r)edhat in file names, but I think that
> this is the most convenient solution which will cause the least confusion.

My previous patch was bogus, I should know better than to send a patch 
untested late at night even if it's trivial.

It put m4 into an infinite loop.

Now we can do a macro definition such as the following:
define(redhat, `redhat')

But this means that if you pass "redhat" without the `' M4 quotes to a macro 
it can still go into an infinite loop.  To get this to work with 
full_user_role(redhat) we need to change most instances of "$1" to "`$1'" in 
the macros files.

By using "redhat", "debian", "gentoo", and "suse" as flag macros we are 
essentially making them reserved words.  I think that the most practical 
solution to this problem is to use "USING_REDHAT" etc as the flag macros.  
The chance of someone wanting a user role named USING_REDHAT_r is quite low, 
while the incidence of people wanting a redhat_r role is much higher.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_DVYJBlADMYWP0av
Content-Type: text/plain;
  charset="iso-8859-1";
  name="distro.tun"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="distro.tun"

# Distro-specific customizations.

# Comment out all but the one that matches your distro.
# The policy .te files can then wrap distro-specific customizations with
# appropriate ifdefs.


dnl define(redhat, `redhat')

dnl define(suse, `suse')

dnl define(gentoo, `gentoo')

dnl define(debian, `debian')

--Boundary-00=_DVYJBlADMYWP0av--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
