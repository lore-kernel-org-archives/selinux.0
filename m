Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SLH753027534
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 16:17:07 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0SLH9ng017893
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 21:17:09 GMT
Subject: Re: [ RESEND ] Fedora Rawhide mplayer policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41FAAA5A.1020800@redhat.com>
References: <1106944688.2174.13.camel@cobra.ivg2.net>
	 <41FAAA5A.1020800@redhat.com>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 14:17:06 -0700
Message-Id: <1106947027.2936.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I will add them.

Warning, this creates a problem for xine:

audit(1106946868.187:0): avc:  denied  { search } for  pid=2976
exe=/usr/bin/xine name=win32 dev=dm-0 ino=180195
scontext=user_u:user_r:user_t tcontext=system_u:object_r:win32_lib_t
tclass=dir

I could write a policy for that too, if necessary.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
