Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OCOYrT025711
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:24:34 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OCNmMZ000428
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:23:49 GMT
Subject: Re: policy patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200408241818.40064.russell@coker.com.au>
References: <200408241818.40064.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093350182.1800.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 08:23:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 04:18, Russell Coker wrote:
> diff1 removes some unnecessary dontaudit lines from syslogd.te, if there is to 
> be one single domain accessing devpts_t:chr_file then syslogd_t is not it, 
> and if a log file gets type unlabeled_t then it's something we want audited.

Both rules were added by Dan, so please coordinate such changes with
him.  The dontaudit rules for devpts_t:chr_file are for the targeted
policy, which has no derived types for ptys or ttys; daemon restart will
trigger such denials.  I think that the dontaudit rule for unlabeled_t
is for the kernel bug that is leaking descriptors to the rootfs to init
and its descendants.  However, SELinux should be closing those
descriptors and re-opening them to the null device anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
