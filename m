Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11392
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2001 18:31:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA23459
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2001 22:30:40 GMT
Received: from jazz.cs.utsa.edu (jazz.cs.utsa.edu [129.115.11.19])
	by jazzband.ncsc.mil  with ESMTP id WAA23455
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2001 22:30:40 GMT
Received: from ten46.cs.utsa.edu (ten46 [129.115.11.76])
	by jazz.cs.utsa.edu (8.9.3+Sun/8.9.3) with ESMTP id RAA08795
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2001 17:25:07 -0500 (CDT)
Received: from localhost (ccardena@localhost)
	by ten46.cs.utsa.edu (8.9.3+Sun/8.8.8) with SMTP id RAA01760
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2001 17:26:04 -0500 (CDT)
Date: Tue, 18 Sep 2001 17:26:04 -0500 (CDT)
From: Carlos Cardenas <ccardena@cs.utsa.edu>
To: selinux@tycho.nsa.gov
Subject: UltraSparc
Message-ID: <Pine.GSO.3.95.1010918171342.1734B-100000@ten46>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has there been any successfull attempt for SELinux on an UltraSparc?
After doing a make menuconfig on an Ultra 5, I saw that there was not
a Security option, then realized that SELinux wasn't really made for it,
but rather for i386(I saw this by looking in the
lsm/security/selinux_plug/arch that there is a sym. link machine pointing
to sparc64....there is no sparc64 in that directory).



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
