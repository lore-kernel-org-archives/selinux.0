Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA10396
	for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 17:14:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA21558
	for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 21:13:03 GMT
Received: from web40001.mail.yahoo.com (web40001.mail.yahoo.com [66.218.78.19])
	by jazzswing.ncsc.mil  with SMTP id VAA21554
	for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 21:13:02 GMT
Message-ID: <20021004211432.73107.qmail@web40001.mail.yahoo.com>
Date: Fri, 4 Oct 2002 14:14:32 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: RH8 policy support
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200210042307.35349.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:
> On Fri, 4 Oct 2002 22:50, Brad Chapman wrote:
> > Does your policy work well (or mostly well) on RH8? I'm installing it soon
> 
> My policy is little different from that which is in the Sourceforge CVS tree.

ACK

> 
> > and would like to make your policy work with a minimum of fuss (i.e. it
> > takes less than three hours to edit the policy to make it work ;). Do you
> > know of any problems so far between your policy and RH8?
> 
> I don't know.  I have not had any need to install it on Red Hat.

I have. Besides, RH8 is a major new platform and a lot of people besides me
may try to use SELinux on it.

> 
> To get SE Linux running on Red Hat as well as it does on Debian the following
> 
> needs to be done:
> 
> Wrappers for rpm and related commands to run them in system_u:system_r .

I can certainly try this, but it will be ugly and evil and will need some
major cleanups before going into the CVS.

> 
> Support for relabelling files after installing a new RPM package.

How would you do that?

> 
> Policy to make the install scripts start daemons in the correct domain.

What install scripts do you mean?

> 
> Testing all this on standard operation of Red Hat machines to find
> differences 
> from Debian and write policy and patches to programs to match.
> 
> 
> Probably about 3 months work should do it.
> 
> As for getting basic functionality working, I don't know of anything in 
> particular that'll stop it working, but RH 8 has enough new things that 
> there's certain to be some relevant changes, probably more than 3 hours work 
> will be required.  But don't be deterred!  This is fun!

I'm not deterred yet. After I eliminate most of the errors I'll post logs and
patches; maybe after a while I'll be able to activate enforcing mode ;)

> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>

Brad 


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
