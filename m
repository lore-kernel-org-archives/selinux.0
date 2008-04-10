Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3AEn9Xe002163
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 10:49:09 -0400
Received: from QMTA03.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3AEn85K005428
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 14:49:09 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v3 0/2] Series short description
To: selinux@tycho.nsa.gov
Date: Thu, 10 Apr 2008 10:48:03 -0400
Message-ID: <20080410144452.8521.39381.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This revision includes the list_del_rcu() fix mentioned earlier this
morning.  This boots on a quasi-recent Rawhide machine (three/four days
old?) with the targeted policy in enforcing mode with no noticeable
regressions to networking: I can do a wget to google, SSH into the
machine, ping, etc..

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
