Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0LNKdRb005106
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 18:20:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0LNKcCa016360
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 23:20:38 GMT
Received: from s3cin.xetron.com (fw.xetron.com [216.68.89.2])
        by jazzband.ncsc.mil  with ESMTP id i0LNKcVC016357 for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 23:20:38 GMT
Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A87@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: transition failure
Date: Wed, 21 Jan 2004 18:20:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have SE Linux kernel 2.4 installed and I have a swatch type definition
file called "swatch.te" in my policy.
I have the following rule in my policy and I have reloaded my policy:

    allow sysadm_t swatch_t:process { setexec transition };

I log in as root in the sysadm role and run the following command at the
command line: 

    runcon system_u:system_r:swatch_t /etc/rc.d/init.d/swatchd start

The following error occurs:

    avc: denied { transition } for pid=4295 exe=/usr/bin/runcon
patch=/etc/rc.d/init.d/swatchd dev=08:02 ino=194832
    scontext=root:sysadm_r:sysadm_t tcontext=system_u:system_r:swatch_t
tclass=process

Any ideas why I'm still getting the transition denied?   Thanks for any
insight.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
