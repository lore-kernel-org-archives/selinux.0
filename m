Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VNTPHa006351
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 19:29:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6VNSEFB005185
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 23:28:14 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6VNSCGD005182
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 23:28:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: SELinux Workshop at CCC
Date: Fri, 1 Aug 2003 09:29:13 +1000
References: <20030731174126.A16353@lemuria.org>
In-Reply-To: <20030731174126.A16353@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308010929.13392.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Aug 2003 01:41, Tom wrote:
> Carsten and myself will be holding a 2 hour SELinux presentation and
> workshop at the Chaos Computer Camp near Berlin on August 7th. We will
> be presenting SELinux to the audience, giving them an opportunity to
> upgrade or install their own systems under guidance, and answer
> questions.

http://www.linux-kongress.org/2002/tutorials/index.html#selinux
Sounds like something similar to what I did at Linux Kongress last year.

The notes for that are on 
http://www.coker.com.au/selinux/talks/lk-2002/tutorial/ .  That tutorial 
lasted for just over 6 hours and I did not complete the material.  The 
tutorial was run on a network of identical machines which made things 
significantly easier than they might have been.  All hardware was the same 
and all machines ran Debian so only Debian package installation was required.

There was a wide range of skill levels among the people in my LK tutorial, 
some of the people could have completed it in as little as 4 hours if the 
rest of the group had the same experience.

Even if the CCC people have more experience than the people who attended my LK 
tutorial I doubt that you will talk them through upgrading their own systems 
in as little as 2 hours.  You will face issues of kernel compilation, 
conflicts of kernel patches, different file locations when using different 
distributions (and heavily customised distributions), and the stat issue with 
different versions of libc6.

If you are interested I could provide the UML image and documentation that I 
prepared for OLS (which was not used due to numerous technical problems).  
That would allow them to install SE Linux in an environment of a known state 
and with clear documentation for every step.  With such a setup almost 
everyone should be able to get a basic SE Linux install running within the 
two hours.  Once they have learned how it works through that it should be 
easier for them to get a real server working.


PS  The UML image is the 200M file I want to host on your server.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
