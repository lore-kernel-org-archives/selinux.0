Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA24925
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 08:04:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA28329
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:03:36 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id MAA28325
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:03:36 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Debian User'" <rogelio@evoworks.evoserve.com>, <selinux@tycho.nsa.gov>
Subject: RE: modifying utilities to use libselinux
Date: Thu, 27 Jun 2002 08:03:56 -0400
Message-ID: <004601c21dd2$b6cc86b0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3D1AB057.1040206@evoworks.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am going to assume you are using potato :)  Perhaps the best thing to
do, if this assumption is true, is go update to woody and use mr coker's
woody deb's located at http://www.coker.com.au/selinux/  you'll need to
do a kernel reconfiguration as well with the kernel-lsm patch

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Debian User
Sent: Thursday, June 27, 2002 2:28 AM
To: selinux@tycho.nsa.gov
Subject: modifying utilities to use libselinux

is it wise to modify utiliies to use libsecure? what kind of utilities 
besides login and ssh should use libsecure? how about screen? I had a 
big problem making it work in selinux. 


--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
