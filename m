Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBS6hERb008919
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 01:43:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBS6hD7m024031
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 06:43:14 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBS6hCLC024028 for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 06:43:13 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 8016961C18
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 17:42:58 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02159-07 for <selinux@tycho.nsa.gov>;
	Sun, 28 Dec 2003 17:42:57 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id C565261BFE
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 17:42:57 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 89A2392606
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 17:42:57 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A0B58B5991
	for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2003 17:42:54 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: procps and other updates
Date: Sun, 28 Dec 2003 17:42:53 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200312281742.53480.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have removed the procps directory from my new SE Linux repository.  Thanks 
to the good work of Craig Small <csmall@debian.org> (Debian package 
maintainer) and Albert Cahalan <albert@users.sf.net> (upstream maintainer) 
the regular Debian package now has all necessary functionality.

Also I am moving all old SE Linux support to the following URL and making a 
few other changes to my site:
http://www.coker.com.au/oldselinux/

My site is being updated now, but it may take some time for mirrors to get 
updated.  I think it would be best if mirror operators would not mirror the 
old SE Linux site.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
