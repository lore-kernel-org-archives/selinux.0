Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k17KS2Xf028946
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 15:28:03 -0500 (EST)
Received: from repulse.cnchost.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k17KS0kS010793
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 20:28:00 GMT
Message-ID: <43E9024D.9030304@hypertechsystems.com>
Date: Tue, 07 Feb 2006 12:25:49 -0800
From: David Slater <ds@hypertechsystems.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: auditctl examples?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am interested in using auditctl, but am having trouble understanding 
how to do so using the man page.  I apologize if this is not the 
appropriate forum for this question, but it appears to be the logical 
path thus far.  Specifically, I would like to understand the concept of 
adding a watch to a filesystem
object.  I would like to generate an audit entry in 
/var/log/audit/audit.log each time a restricted directory is accessed.  
It would be greatly appreciated if anyone could forward examples of 
doing so.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
