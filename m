Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA13824
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 13:25:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA14336
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 17:25:53 GMT
Received: from jsmith.org (pool-141-158-42-213.phil.east.verizon.net [141.158.42.213])
	by jazzswing.ncsc.mil  with ESMTP id RAA14332
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 17:25:53 GMT
Subject: Redhat 7.3: sendmail.fc
From: Justin Smith <jsmith@mcs.drexel.edu>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 23 May 2002 13:25:35 -0400
Message-Id: <1022174735.2351.1.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In Redhat 7.3, /usr/sbin/sendmail is a link to

/etc/alternatives/mta

so one must add the line

/etc/alternatives/mta		system_u:object_r:sendmail_exec_t

to the sendmail.fc file

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
