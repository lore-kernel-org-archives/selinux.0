Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0832kRb019475
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 22:02:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0831gxr029213
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:01:42 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0831eYc029178
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:01:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Kerberos
Date: Thu, 8 Jan 2004 14:01:18 +1100
Cc: bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401081401.18967.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For Kerberos we have a /etc/krb5.conf file that has the configuration.  How 
sensitive is the contents of this file?

What is the best way of managing Kerberos access?  I get the impression that 
anything which requires getpwnam(3) access will need to read /etc/krb5.conf 
and access the network.  This means that when kerberos is enabled we need to 
allow almost all programs to have network access and read access to 
krb5.conf .

Would it be possible to change the kerberos libraries to spawn a child process 
similar in nature to unix_chkpwd to perform the kerberos functions?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
