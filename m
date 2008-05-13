Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4DKjVLI010208
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2008 16:45:31 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4DKjUpR022193
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2008 20:45:30 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2317641fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 13 May 2008 13:45:29 -0700 (PDT)
Message-ID: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com>
Date: Tue, 13 May 2008 22:45:28 +0200
From: "Jan-Frode Myklebust" <janfrode@tanso.net>
To: selinux@tycho.nsa.gov
Subject: RHEL5 initrc_t vs. unconfined_t
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running IBM's GPFS filesystem on RHEL5, and am having some
problems with selinux blocking some ifconfig's the GPFS daemons wants
to launch. GPFS works fine if launched manually, but not when started
from the initscripts. So, is there any way to say that this initscript
should run unconfined, instead of as initrc_t where things might
transition to other domains ?


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
