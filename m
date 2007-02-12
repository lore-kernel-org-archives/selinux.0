Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1CHbCsx024262
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 12:37:12 -0500
Received: from smtp-out-0101.amazon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1CHcMWk016059
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 17:38:23 GMT
Received: from ex-gate-sea5-02.ant.amazon.com (sea5-dhcp-248-136-254.sea5.amazon.com [10.248.136.254])
	by smtp-in-4103.sea5.amazon.com (8.12.11/8.12.10) with ESMTP id l1CHcLMZ026097
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 09:38:21 -0800
Subject: Re: su and context
From: Ronan Waide <waider@amazon.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com>
	 <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1171301899.20328.29.camel@waider.desktop.amazon.com>
Mime-Version: 1.0
Date: Mon, 12 Feb 2007 17:38:19 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 16:53, Stephen Smalley wrote:
> The behavior has actually changed over time; you'll find discussions
> about it in the mailing list archives.  The original SELinux kept su
> separate from security context changes.  Earlier versions of Fedora (and
> RHEL 4) integrated them (via pam_selinux) in an effort to provide
> greater transparency, but this caused its own set of problems (e.g. use
> of su from init scripts, losing continuity of context across su when you
> want it for roles and levels).  More recent versions of Fedora (and RHEL
> 5) split them back out again.  One might add an option to su to support
> simultaneous newrole, but you don't want it by default.

On the subject of interaction between "old" and "new" security, I was
briefly stumped in my quest to create a bind role account by the fact
that the rndc binary (on FC6) is not actually executable by anyone other
than root, so granting rndc_exec_t doesn't help unless you also change
the binary's permissions. Is this intentional? I had hoped that SELinux
rather than the filesystem would be taken as authoritative on who gets
access, but I can see reasons why this maybe shouldn't be the case, and
perhaps the 'bug' is with the installed permissions?

Cheers,
Waider.
-- 
Ronan Waide / TechOps EU Systems Engineer / waider@amazon.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
