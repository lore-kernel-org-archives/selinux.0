Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RJDXRb000174
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 15:13:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3RIe0oI008702
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 19:13:31 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
        by jazzband.ncsc.mil  with ESMTP id i3RHVkJP005691 for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 17:31:46 GMT
Received: from hawaii.efficax.net (localhost.localdomain [127.0.0.1])
	by hawaii.efficax.net (8.12.10/8.12.10) with ESMTP id i3RHVc84007250
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 12:31:38 -0500
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.10/8.12.10/Submit) id i3RHVc0J007248
	for selinux@tycho.nsa.gov; Tue, 27 Apr 2004 12:31:38 -0500
Subject: Adding user accounts
From: Nick Gray <nagray@austin.rr.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1083087096.29534.185.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 12:31:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the procedure I have for adding user accounts.

#1.  useradd -m developer 
#2.  passwd developer
#3. sed -i -e /user\ root/a\ user\ developer\ roles\ \{\ staff_r\ \
sysadm_r\ \}\; /etc/security/selinux/src/policy/users 

#4. cd /etc/security/selinux/src/policy
#5. make policy
#6. make load

Is this still necessary?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
