Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7TGLHLa027209
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 12:21:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7TGLGet023380
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 16:21:16 GMT
Received: from out005.verizon.net (out005pub.verizon.net [206.46.170.143])
        by jazzband.ncsc.mil  with ESMTP id h7TGLGlq023371 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 16:21:16 GMT
Received: from scanner.gici.com ([4.3.7.85]) by out005.verizon.net
          (InterMail vM.5.01.05.33 201-253-122-126-133-20030313) with ESMTP
          id <20030829162111.CWBR15786.out005.verizon.net@scanner.gici.com>
          for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 11:21:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bill Laut <wlsel@verizon.net>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Q on Internals & Data Structures
Date: Fri, 29 Aug 2003 12:22:23 -0400
MIME-Version: 1.0
Message-Id: <200308291222.23424.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I'm beginning work on my first experimental implementation of a security-aware 
X, using the paper "Securing the X Window System with SELinux" 
[KilSalVanNAI2003] as a guide.  To facilitate this, I would like to prepare 
an informal reference document that schematically charts all of the kernel 
data structures used within SELinux, along with a chart tracing the execution 
thread of the security services from start to finish.  Of particular interest 
is the format of the compiled policy as it sits in the kernel, and how it is 
interrogated to arrive at a yes/no decision.

Has any documentation of this sort been created, and if so where can I find 
it?  I already have "Configuring the SELinux Policy" and "Implementing 
SELinux as a Linux Security Module," but while good they are not what I'm 
looking for.

Bill




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
