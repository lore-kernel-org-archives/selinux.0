Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23187
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 12:13:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA17211
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 16:13:38 GMT
Received: from jsmith.org (pool-141-158-43-149.phil.east.verizon.net [141.158.43.149])
	by jazzswing.ncsc.mil  with ESMTP id QAA17205
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 16:13:38 GMT
Subject: sendmail.fc and RH 7.3
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 05 Jun 2002 12:13:42 -0400
Message-Id: <1023293622.1368.5.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For some reason, in RH 7.3, sendmail is accessed by double-indirection:

/usr/sbin/sendmail is a symbolic link to /etc/alternatives/mta, which,
in turn is a symbolic link to 

 /usr/sbin/sendmail.sendmail

(?!), so that you have to augment sendmail.fc to assign the correct type
to /usr/sbin/sendmail.sendmail.
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
