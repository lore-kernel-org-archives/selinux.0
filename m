Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4PB9cI4003263
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 07:09:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4PB9ctV026833
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 11:09:38 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4PB9Zal026830 for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 11:09:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id A7540BF3D
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 21:09:34 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 32708-07
 for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 21:09:33 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 73A21BF11
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 21:09:33 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CBAD292705
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 21:09:31 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 4FE8A37E
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 21:09:26 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: web_client_domain
Date: Sun, 25 May 2003 21:09:25 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305252109.25426.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the moment I am experimenting with a new attribute web_client_domain for 
every domain that is allowed to connect to web server type processes.

Web servers include apache, squid (proxy server), cups (http administration 
interface), and probably lots of other things we haven't written policy for 
yet.

Web clients include netscape (running in user_netscape_t and other domains), 
lynx (running in user_t etc - maybe it should be changed to run in the 
netscape domain), squid, and it will only increase.

Having every web server (or application with a web-based configuration 
interface) require separate ifdef rules for each of netscape, and squid, and 
having a regular rule for userdomain gets to be a bit complex.

I've put a new policy.tgz on my web site for anyone who wants to try this out.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
