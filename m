Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4GANxI4022630
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 06:23:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4GANdl5025575
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 10:23:39 GMT
Received: from venere.mat.uniroma1.it ([151.100.50.3])
	by jazzswing.ncsc.mil  with ESMTP id h4GANcNc025566
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 10:23:38 GMT
Received: from yahoo.it (archimede.mat.uniroma1.it [151.100.50.200])
	by venere.mat.uniroma1.it (8.9.1b+Sun/8.9.1) with ESMTP id MAA04330
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 12:20:26 +0200 (MET DST)
Message-ID: <3EC4BCAA.70509@yahoo.it>
Date: Fri, 16 May 2003 12:25:46 +0200
From: Giorgio Zanin <selinux_list@yahoo.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: about type_change and type_transition
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

is it correct to argue that
type_transition program the security server to provide a cetain SID (or 
better, a labelling decision)  for labelling process and objects created 
by legacy applications
type_change does the same thing but for security aware applications
?


It looks like the difference between auto and exec specification in DTE.

thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
