Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3MDJXZ019124
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:13:19 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3MDIJZ000760
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 22:13:18 GMT
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, jwcart2@epoch.ncsc.mil,
   SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1099507502.3861.11.camel@nexus.verbum.private>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
	 <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com>
	 <200411031641.59816.russell@coker.com.au>  <4189060A.1010003@redhat.com>
	 <1099507502.3861.11.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 17:13:14 -0500
Message-Id: <1099519994.3861.18.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 13:45 -0500, Colin Walters wrote:

> Once we have Russell's change to add the "daemon" attribute, I think
> that can_ypbind should be keyed off that too, rather than being
> something we add to essentially every daemon domain's .te file.  If you
> want to use YP, you're going to want it everywhere.

I take this back - there are daemons that don't need to get user
attributes, and there are other programs besides daemons that need to
use YP.

But I do hope we can push PAM-related permissions into the auth or
auth_chkpwd attributes; when I was trying to set up my FC2 server to use
Kerberos I had to modify individual daemon domains.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
