Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA20400
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2002 19:39:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA24093
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 00:38:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA24081 for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 00:38:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 84CDD9265F
	for <selinux@tycho.nsa.gov>; Thu,  7 Feb 2002 11:38:59 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 1CB3F388D16
	for <selinux@tycho.nsa.gov>; Thu,  7 Feb 2002 10:39:37 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: USB device files
Date: Thu, 7 Feb 2002 10:20:05 +1000
MIME-Version: 1.0
Message-Id: <20020207003937.1CB3F388D16@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any way of automatically labelling the device nodes on the usbdevfs 
which is mounted on /proc/bus/usb for USB systems?

Something like the method used for devfs would be good for the next release...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
