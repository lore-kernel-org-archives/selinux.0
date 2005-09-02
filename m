Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j82Id5Ob023431
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 14:39:05 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j82IbhoJ013081
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 18:37:48 GMT
Subject: squid policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 14:39:44 -0400
Message-Id: <1125686384.16388.66.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While converting over the squid policy to a reference policy module, I
noticed this:

#squid requires the following when run in diskd mode, the recommended setting
allow squid_t tmpfs_t:file { read write };

I'm confused on how this can happen.  As far as I know, there shouldn't
be no tmpfs_t files; everything should fall into a derived tmpfs domain,
usually provided by tmpfs_domain().  Can someone clarify this?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
