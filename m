Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83BTtrT006382
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 07:29:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83BT5FY002333
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 11:29:05 GMT
Subject: Re: Proposed Hardware File Context file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1094167821.24091.25.camel@nexus.verbum.private>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377DD5.8010500@redhat.com>
	 <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil>
	 <41377F4B.3010608@redhat.com>
	 <1094167821.24091.25.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Sep 2004 07:28:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 19:30, Colin Walters wrote:
> I think "unit" in this context should be a regular expression which can
> match an arbitrary identification string.  udev would extract the e.g.
> the USB model number for this purpose.  This wouldn't actually be
> supplied in the sample policy, but system administrators could use it to
> customize the policy at a more granular level than "cdrom".

What granularity does udev currently support for specifying
ownership/mode on device nodes?  We want to at least be equivalent to
that.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
