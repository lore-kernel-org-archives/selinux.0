Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85AVBrT017033
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 06:31:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85AV8t0027798
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 10:31:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Additional rule files
Date: Sun, 5 Sep 2004 20:31:05 +1000
Cc: selinux@tycho.nsa.gov
References: <1094260356.29689.44.camel@wintermute.xmldesign.de>
In-Reply-To: <1094260356.29689.44.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409052031.05813.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Sep 2004 11:12, Erich Schubert <erich@debian.org> wrote:
> Fourth rule set if for using the "fnord" web server with "tcpsvd"
> (of the ipsvd package. very lightweight.)

Why does fnord need a different policy?  Are the actions of different web 
servers that different?  (this is a serious question not a rhetorical 
question)

My initial thought was that perhaps a little change to apache.fc is all that's 
needed.  But if there are serious enough differences in the security 
requirements of Apache and fnord then we need to come up with a good design 
for this.  Having special case rules in every .te file that has policy for a 
cgi-bin script for each web server isn't going to work!

We can create some attributes to have multiple web servers work well with the 
rest of the policy as I have already done with mail servers.  But first we 
need a reason to do so.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
