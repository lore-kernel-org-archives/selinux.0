Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BB0YpT026225
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 07:00:34 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BB0KHC006188
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 11:00:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id ED21C18431
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 21:00:27 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-yMO+goB0W6 for <selinux@tycho.nsa.gov>;
	Mon, 11 Aug 2008 21:00:27 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 9BCE71842C
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 21:00:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id D662B214F7
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 21:00:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: long contexts
Date: Mon, 11 Aug 2008 21:00:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808112100.25447.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

runcon -l s0:`/tmp/test.pl 630`-s0:`/tmp/test.pl 1023` id

The above command fails with error "File too large".  It seems that for full 
support of ranges with the pessimal combination of categories we could have 
no more than about 700 categories.

open("/selinux/context", O_RDWR)        = 3
write(3, "unconfined_u:unconfined_r:unconfi"..., 4088) = -1 EFBIG (File too 
large)

Above are the relevant lines from strace output.  I'm running Debian kernel 
2.6.18.  I expect that a single page is used by the kernel to store the data 
written to /selinux/context.

Below is the contents of /tmp/test.pl.

#!/usr/bin/perl

for($i=1; $i < $ARGV[0]; $i +=2)
{
  print "c$i,";
}
print "c1023\n";


NB  I don't have any good reason for wanting to do this.  I just wondered if I 
could break anything.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
