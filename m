Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3FDVA7C026255
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 09:31:10 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3FDRHaf012339
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 13:27:17 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j3FDSOTb003696
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 09:28:24 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j3FDSO1I003695
	for selinux@tycho.nsa.gov; Fri, 15 Apr 2005 09:28:24 -0400
Date: Fri, 15 Apr 2005 08:09:22 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Serge Hallyn'" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
   "'James Morris'" <jmorris@redhat.com>, selinux-dev@tresys.com,
   linux-audit@redhat.com
Subject: Re: dcache_lock deadlock due to auditing
Message-ID: <20050415130922.GA6231@sergelap.austin.ibm.com>
References: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com> <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Just an update:  the testcases ran fine for 12 hours yesterday with
Stephen's patch.  They had to be stopped due to an unrelated reason, and
have been restarted today.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
