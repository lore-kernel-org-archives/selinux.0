Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i51HgIrT027261
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 13:42:18 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i52Hg3XL024285
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 13:42:03 -0400 (EDT)
Subject: Re: latest cvs: policy appears to have different specs for apt-get
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040529132024.GA12259@lkcl.net>
References: <20040529132024.GA12259@lkcl.net>
Content-Type: text/plain
Message-Id: <1086111685.13325.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 13:41:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-05-29 at 09:20, Luke Kenneth Casson Leighton wrote:
> i'm getting this error on make relabel:
> 
> 	ERROR: Multiple different specifications for /usr/bin/apt-get
> 	(system_u:object_r:rpm_exec_t and system_u:object_r:apt_exec_t).
> 	/usr/sbin/setfiles:  labeling files under /
> 
> i won't pretend to know how it occurs...

You shouldn't enable both rpm.te and dpkg.te in the same policy; they
conflict.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
