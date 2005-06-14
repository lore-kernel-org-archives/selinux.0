Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5EHTQgA016332
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 13:29:27 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5EHKdvj023562
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 17:20:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 7DEDDAEF83
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 17:41:09 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29030-02 for <selinux@tycho.nsa.gov>;
 Tue, 14 Jun 2005 17:41:06 +0100 (BST)
Received: from [192.168.0.1] (81-1-74-34.homechoice.co.uk [81.1.74.34])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 398D6AEF82
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 17:41:06 +0100 (BST)
Subject: Java & SELinux? JNI?
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 18:38:27 +0100
Message-Id: <1118770707.10262.58.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone written a default policy for Java 1.5?
I've just made one for Java + Tomcat 5.5 and discovered a few things
along the way: Java1.5 needs write access to /dev/random! (even when
just running or compiling things - there is a bug id for this @sun), it
also tests to see if it can execute files in /tmp/!, etc

Also, has anyone looked at providing a JNI interface to libselinux?
I could find a few uses for this where the same java instance may be
used by different contexts and would need to rely on lower level code to
enforce file access (and provide another layer of protection for file
paths trickery). It would need some fairly tight integration between the
domains and the Java code but it could be quite useful. An example of
this would be webapps in tomcat, but this could also be applied to
application contexts within the same webapp too.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
