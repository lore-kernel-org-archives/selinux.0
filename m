Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12932
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 12:31:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA14906
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 16:30:38 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzband.ncsc.mil  with ESMTP id QAA14902
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 16:30:37 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f98GV5s17044
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 18:31:05 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f98GV4s17036
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 18:31:04 +0200 (MEST)
Message-ID: <3BC1D4C4.4070500@jrc.it>
Date: Mon, 08 Oct 2001 18:31:00 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
References: <Pine.GSO.4.33.0110080939300.9507-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your suggestion. On SuSE 7.2, the /bin/login program comes 
from the RPM "shadow.rpm". MCONFIG in the SuSE 7.2 util-linux.spm 
defines HAVE_SHADOW="yes", whereas the SELinux util-linux MCONFIG 
defines HAVE_SHADOW="no".

So when I built util-linux from the SuSE SPM, /bin/login didn't change. 
I'll poke around in the shadow.spm and see if I can find something in 
the login.c there.

At this point, I doubt that my login problems are FLASK-related.

James


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
