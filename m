Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8U6bRsJ016561
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 02:37:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8U6bQCG006796
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 06:37:26 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8U6bNqJ006785 for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 06:37:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nick Davis <nicholas-davis@utulsa.edu>, selinux@tycho.nsa.gov
Subject: Re: SELinux & UML FAQ
Date: Tue, 30 Sep 2003 16:36:28 +1000
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <200309261242.07521.russell@coker.com.au> <3F7895A0.2030207@utulsa.edu>
In-Reply-To: <3F7895A0.2030207@utulsa.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309301636.28378.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 30 Sep 2003 06:27, Nick Davis wrote:
> Is there anything special required for getting UML working with 2.6
> SELinux?  I've downloaded the patch and
> applied it to 2.6.0-test3, which seemed to work fine.  But I get errors
> when doing a 'make linux ARCH=um' as
> suggested on the UML website documentation.  I was wondering if anything
> has changed since the 2.4.x days; the docs are at least a couple years old.

It's difficult to even guess at the problem you have when you don't include 
any of the error messages.

At this time I recommend 2.6.0-test5 as it's the latest kernel that I have got 
to compile with UML.  Hopefully a UML patch for test6 will be released soon.

For 2.6.0-test6 the nearest I got to compiling it was after applying the UML 
patch for 2.6.0-test5.  The compile didn't even get far enough to determine 
if the problems I've encountered before are still there.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
