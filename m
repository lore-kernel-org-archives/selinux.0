Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0V8P5Xf013118
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 03:25:05 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0V8NlAa027527
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 08:23:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 207A761B01
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 19:25:02 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 23865-06 for <selinux@tycho.nsa.gov>;
	Tue, 31 Jan 2006 19:25:01 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AB65261AF8
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 19:25:01 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 790DDA81CE
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 19:25:00 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <selinux@tycho.nsa.gov>
Subject: LCA
Date: Tue, 31 Jan 2006 19:24:54 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601311925.00303.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.linux.conf.au/

Last week I attended Linux Conf Au.  I gave a talk on the status of SE Linux 
in Debian for the Debian mini-conf which was received in a very positive way.  
Most of the audience (which included a number of Debian Developers) indicated 
that they believe that SE Linux should be included in the default install in 
the same way as Fedora.  However no-one there is actually working on the 
installer so this may not mean much.

I gave a set of four tutorial sessions on SE Linux in the main conference 
track.  First was a tutorial covering the base technology of SE Linux and the 
Domain-Type model.  Then a tutorial covering MLS/MCS, a tutorial on writing 
policy (mostly focused on the policy that ships with RHEL4 and Fedora Core 4) 
and finally a hands-on tutorial.  The first three parts all went over time 
but fortunately the delegates had already started playing with the machines 
and covering some of the hands-on materiel during my earlier talks.  At least 
5 delegates burned CDs of Fedora Core 5 test 2 so that they could play with 
MLS or MCS at home.

http://www.coker.com.au/selinux/talks/rh-2006/mls.png
During the part on MLS some of the students believed that there was an error 
in one of my diagrams.  The URL for the diagram is above, the ellipses 
represent processes, the rectangles represent files, and the arrows indicate 
the direction of data flow.  Reviewing the diagram afterwards I couldn't see 
any error and conclude that I made a mistake in thinking that my diagram was 
buggy.  But I would appreciate some commentary from the members of this list.

http://www.coker.com.au/selinux/talks/rh-2006/

The above URL has all the slides etc from my tutorials at LCA 2006.  You may 
use them freely as long as I am given suitable credit.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
