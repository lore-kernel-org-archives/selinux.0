Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA21123
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 21:14:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA16272
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2001 01:13:40 GMT
Received: from zuul.dsndata.com (zuul.dsndata.com [198.183.3.2])
	by jazzswing.ncsc.mil  with SMTP id BAA16268
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2001 01:13:40 GMT
Received: from dsndata.com(localhost[127.0.0.1]) (4786 bytes) by zuul.dsndata.com
	via sendmail with P:esmtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <willdye@dsndata.com>)
	id <m14q31H-00009ZC@zuul.dsndata.com>
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 20:14:03 -0500 (CDT)
	(Smail-3.2.0.102 1998-Aug-2 #1 built 1998-Nov-18)
Message-Id: <m14q31H-00009ZC@zuul.dsndata.com>
Reply-To: willdye@dsndata.com
To: selinux@tycho.nsa.gov
Subject: Re: security enhancements outside of flask model 
In-reply-to: Your message of "Wed, 18 Apr 2001 16:45:05 EDT."
         <Pine.SOL.3.95.1010418164308.21294W-100000@clipper.gw.tislabs.com>
Date: Wed, 18 Apr 2001 20:13:58 -0500
From: Will Dye <willdye@dsndata.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley writes:

> Third, arguing that the difficulty in managing fine-grained access
> controls means that we should not have fine-grained access controls
> is illogical.  When you have a feature or some piece of functionality
> that is needed for some purpose, and that feature/functionality is
> difficult to manage, do you throw it out or do you develop higher-
> level tools to help you manage the complexity?  


I'm not qualified to offer specific opinions about security matters, 
but I'll throw in this quick comment about generic ease-of-use...

We often encounter situations where some users want the ability to run 
a system 'out of the box', without having to learn very much about it; 
yet other users want the ability to make modifications.  Very broadly 
speaking, the usual approach is to offer a system with the equivalent 
of dials and buttons, which are set at the factory to some reasonable 
defaults.  Users then have the choice of accepting the stock model, or 
twisting dials and pushing buttons to create a variant.

As generic approaches go, this one works fairly well.  One tradeoff 
you have to live with is that it becomes more complex to support and 
extend systems that have certain changes to them.  I can offer a 
program that runs "under Linux", for example, but in fact it only 
runs under certain configurations of Linux.  

This is a fundamental tradeoff, but we can often reduce the pain of 
that tradeoff considerably with just a few changes to nomenclature.  
Give one name to the stock model (or the stock model with only some 
carefully-considered minor variants), and give another name to any 
model that has been tweaked beyond some tightly-specified limits.  

If I can say that my program runs under "DummieLinux (TM)", and the 
definition of DummieLinux is well-done and easily tested, then the 
users who like no-brainer stock boxes are probably going to be much 
happier.  If we have a script that can detect if you've modified your 
system past the allowed parameters of DummieLinux, well, so much the 
better.  If the definition fits a formally-defined virtual machine 
model that lets me all but prove that my program will run under any 
DummieLinux system, I want to double-check that you haven't turn off 
critical functionality, and then gratefully shake your hand!  :-)

In the case here, I suppose the approach would be to still allow for 
fine-grained controls, but set up separate naming conventions for 
one or more well-defined 'stock' options.  If possible, set up some 
scripts that can programmatically determine if a system fits a given 
stock definition.  The hardest part is probably going to be deciding 
which 'stock' models offer the proper balance of simplicity, ease of 
testing, functionality, and so forth; but so it goes.

This doesn't really change anything at the technical level, so it 
is tempting to dismiss this discussion as no more than roses by any 
other name.  Yet it is with names that we desribe things, so the 
issue of nomenclature can be a critical one, especially when a large 
audience is involved.  Naming conventions might help a lot when a 
government manager wants to know how long it will take to "fully" 
train her new hire to be the department's system security guru.  It 
would probably help a lot when people search to see what alerts and 
products apply to their own site.  It might even reduce potential 
confusion between the complexity of running a stock version, and 
the complexity of making fine-grained adjustments to a variant that 
has to address a very subtle and specific situation.

So, the basic idea is that "plain vanilla" setups should get one 
name, and any non-trivial variations should get a different name.  
If possible, provide a easy & reliable ways to tell the difference.

Again, this is just a generic thought that came to mind, not advice 
based on any specific knowledge of security or SELinux.  I hope it 
was at least worth reading.


--Will


 _____________________________________________________________________
 William Dye, Interim Chief Executive Cat-Herder, the Tweakdom Project
 Open-source tweaks to "Freedom", an Internet privacy software system.
 http://tweakdom.sourceforge.net   No relation Zero-Knowledge Systems.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
