Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h640JfHa004882
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 20:19:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h640ImnJ006349
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 00:18:48 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h640Ikhr006342
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 00:18:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: busybox
Date: Fri, 4 Jul 2003 10:19:26 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200307041019.26588.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My SE Linux patch (written for use in the Familiar distribution on the iPaQ 
but which also works well for recovery disks) has been accepted into the 
Busybox CVS.

I have inspected the merged code and it all looks OK, but I have not had time 
to compile it and boot a machine running it.  I don't expect any problems 
however.

Now the only thing that needs to get merged upstream for my SE Linux iPaQ port 
is some of the policy and the X login program (gpe-login) patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
