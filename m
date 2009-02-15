Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1F4DKfd023115
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2009 23:13:20 -0500
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1F4DIu1012281
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2009 04:13:19 GMT
Received: by wf-out-1314.google.com with SMTP id 25so10565604wfa.30
        for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2009 20:13:17 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 14 Feb 2009 20:13:17 -0800
Message-ID: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
Subject: sysvinit doesnt see libselinux/libsepol (LFS system);
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm in the process of creating a linux from scratch system.
(able to startx so far);
when looking at:
ldd /sbin/init
I dont see any info on
libselinux or libsepol.
I did apply a patch that I found by a simple
google(but results in an unable to sync error when there is no
policy present, as well as a simple copy of a policy from another machine
resulted the same error);
Is there a clean patch for sysvinit_2.86.ds1.orig.tar.gz
(I just grabbed any sysvinit from either deb/or ubuntu);
or even better, a sysvinit(version) that has a built-in command like
xserver does(--enable-selinux);
appreciate the time.

regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
