Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA95jbSf029909
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 00:45:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA95jD1W000621
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 05:45:14 GMT
Received: from ns3.biznetindia.com ([203.200.89.83])
	by jazzswing.ncsc.mil  with ESMTP id hA95jC5e000618
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 05:45:13 GMT
Received: from ns3.biznetindia.com (localhost [127.0.0.1])
	by ns3.biznetindia.com (8.12.8/8.12.8) with ESMTP id hA95jS6H029970
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 11:15:28 +0530
Date: Sun, 9 Nov 2003 11:15:01 +0530
Message-Id: <200311090545.hA95j16H029965@ns3.biznetindia.com>
To: selinux@tycho.nsa.gov
Subject: Invalid Security Context error
From: "Dhruv Gami" <dgami@uncc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello Everyone,

finally i managed to compile everything, though some of the patches
needed manual changes (will post a list of patches that didnt work
properly).

Now, when i rebooted the machine for the first time after compiling
everything, and following the README doc step by step, i was asked

-------------
login: root
password: *****

would you like to enter a security context? [y]
       Enter role sysadm_r
       Enter type sysadm_t
Not a valid security context
-------------

have i missed some context setting somewhere ?

regards,
Gami


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
