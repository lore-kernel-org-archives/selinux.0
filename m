Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15417
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2001 14:17:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA21431
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2001 18:17:21 GMT
Received: from zuul.dsndata.com (zuul.dsndata.com [198.183.3.2])
	by jazzband.ncsc.mil  with SMTP id SAA21427
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2001 18:17:20 GMT
Received: from dsndata.com(localhost[127.0.0.1]) (2987 bytes) by zuul.dsndata.com
	via sendmail with P:esmtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <willdye@dsndata.com>)
	id <m14nPAx-00005EC@zuul.dsndata.com>
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2001 13:17:07 -0500 (CDT)
	(Smail-3.2.0.102 1998-Aug-2 #1 built 1998-Nov-18)
Message-Id: <m14nPAx-00005EC@zuul.dsndata.com>
Reply-To: willdye@dsndata.com
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: Sourceforge 
In-reply-to: Your message of "Wed, 11 Apr 2001 12:14:29 CDT."
         <72222DC86846D411ABD300A0C9EB08A1015240EA@csoc-mail-box.csoconline.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 11 Apr 2001 13:16:58 -0500
From: Will Dye <willdye@dsndata.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Mr. Westerman,

Thanks for taking this one.  I'd love to help, but I'm overextended 
already.  One suggestion: you might want to create a CVS subdirectory 
reserved for ad-hoc file submissions by people who are not registered 
developers.  Then just put instructions on the web page for making an 
anonymous CVS submission.  

Ah, I just thought of another suggestion.  You'll probably also want 
to disable most of the SourceForge services, such as the surveys, 
until you have a use for them.  Unused services tend to confuse new 
folks.  You may even want to disable the SourceForge-hosted mailing 
lists, and just point people to the NSA list instead.  The NSA list 
is low-volume enough that we probably don't want to split up the 
conversation yet.

Oh, yes; you will probably want a link on your web page to Grant 
Bayley's Australian mirror site:

     http://the.wiretapped.net/security/operating-systems/selinux/
      ftp://ftp.wiretapped.net/pub/security/operating-systems/selinux/

I can't think of any other suggestions offhand, but I hope these 
were at least worth reading.  I wish I could help more.


Thanks again,


--Will


P.S.  I just thought of another idea.  Contact the NSA guys about 
this, and see what they think.  They might want to join you as 
admins of the project, so that they can help keep it in sync with 
new releases from their main site.  You probably also want to talk 
about how to handle multiple variants, by different coders, which 
may or may not be compatable with other variants.  

I'm running into a similar situation with my Sourceforge project for 
tweaks to "Freedom", a well-funded Internet privacy system that was 
released under the Mozilla 1.1 license.  The commercial code is in 
wide use already, so I don't want to release a variant that has dumb 
security holes in it.  On the other hand, some of the coders just 
want to experiment freely, and produce demonstrations of principle.  

The compromise was to make a sort of meta-project, called Tweakdom 
("Tweaks to Freedom", http://tweakdom.sourceforge.net).  It's just 
getting underway, so for now it's just one project; but the idea is 
that it will split off variants as needed.  The main project site 
will point to the various sub-projects, and serve as a unified 
place for security alerts and such for all the different versions.
That's the idea anyway.  It's too soon to tell if it will work.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
