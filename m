Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06715
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:38:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA25877
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 19:38:07 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA25873
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 19:38:07 GMT
Date: Thu, 29 Mar 2001 14:37:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "McFarland, David M." <DMMcFa2@missi.ncsc.mil>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Context switches
In-Reply-To: <200103291918.OAA25148@stingray.missi.ncsc.mil>
Message-ID: <Pine.SOL.3.95.1010329142752.17401X-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Are you running the modified utilities or the ordinary Linux
utilities?  Does '/usr/flask/bin/ps --context' and '/usr/flask/bin/ls
--context' work for you?  If so, you just failed to update your
path.  If not, then does 'uname -r' show a -FLASK suffix?  If so,
then what error are you getting?  If not, then you aren't running the 
SELinux kernel, so you probably booted the ordinary Linux kernel instead.

Also, if you are really using the 2.2.12 kernel, you should download
the new release and use it instead.  On March 16th, a new release
was put on the web site with a 2.4.2-based kernel.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
