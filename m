Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OL87sj029748
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 16:08:07 -0500 (EST)
Subject: Re: libselinux rpm_execon should not fail in permissive mode.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41F561B3.5090907@redhat.com>
References: <41F03552.90806@redhat.com>
	 <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
	 <41F55E02.6090302@redhat.com>
	 <1106599610.19246.255.camel@moss-spartans.epoch.ncsc.mil>
	 <41F561B3.5090907@redhat.com>
Content-Type: text/plain
Message-Id: <1106600513.19246.273.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 16:01:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 15:59, Daniel J Walsh wrote:
> Basically running rpm --root
> 
> Bugzilla %145770

Is the problem that /proc and /selinux aren't mounted in the chroot'd
environment, so we can't access the SELinux API?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
