Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75HcurT006965
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 13:38:56 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75HcsZl027852
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 17:38:54 GMT
Subject: Re: How to use other LSM modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040805171955.71973.qmail@web51503.mail.yahoo.com>
References: <20040805171955.71973.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1091727491.2583.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 13:38:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-05 at 13:19, Park Lee wrote:
> Do you mean that SELinux is not implemented as a LSM module as it was
> described in <<Implementing SELinux as a Linux Security Module>>? 
> Has this situation change now? and what about the capability module?

SELinux is implementing using the LSM framework, and is a "security
module", but it has to be built-in to the kernel; you cannot build it as
a separate module and dynamically insert it into a running kernel.  The
capability module can be built-in or a loadable module, but if you make
it a loadable module, you still need to load it very early in the
initialization process to avoid problems with pre-existing processes
that lack proper capability assignment.  The technical report is out of
date, as noted on the web site and in the introduction of the report.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
