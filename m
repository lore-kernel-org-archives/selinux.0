Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA12858
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 23:27:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA29826
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 03:26:31 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id DAA29822
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 03:25:59 GMT
To: selinux@tycho.nsa.gov
Cc: sds@tislabs.com
Subject: automatic type transitions for pts in devfs
Date: Thu, 11 Jul 2002 11:26:26 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020711032626.549F481F9E@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

my patch works with russell's devfsd-se.so disabled. just remove any selinux* 
file in /etc/devfs/conf.d. i will see if removing only the pts entry in the selinux 
conf.d file will work. 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
