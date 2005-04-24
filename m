Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3O1dvgA024335
	for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2005 21:39:58 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3O1VjGJ010767
	for <selinux@tycho.nsa.gov>; Sun, 24 Apr 2005 01:31:45 GMT
Subject: Strange audit messages - whitespace
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 23 Apr 2005 21:34:34 -0400
Message-Id: <1114306474.11286.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I get audit messages that look like this (with lots of extra whitespace)
for my new GConf domain. Any idea what can cause this? 

audit(1114306264.184:0): avc:  denied  { connectto } for  pid=21975
exe=/usr/libexec/gconfd-2

audit(1114306274.010:0): avc:  denied  { write } for  pid=21975
exe=/usr/libexec/gconfd-2


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
