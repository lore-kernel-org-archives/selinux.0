Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3HifXZ016625
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 12:44:42 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3HifJZ006782
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:44:41 GMT
Subject: Re: selinux-doc problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
References: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 12:40:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 12:22, Manoj Srivastava wrote:
>         Is there an effort underway to update the selinux-doc package?
>  If so, I'll hold off fixing up the SGML issues and wait for the new
>  version (I lack the knowledge to actually update the contents).

Nothing in progress, although I would like to update the reports to
reflect the current system, as much has changed since they were last
updated.  However, the report does build for me on Fedora Core 3.
rpm -q -f /usr/bin/jade reports openjade-1.3.2-14.  Seems unfortunate to
prohibit _ in identifiers; why was this done?  Quoting change would be
trivial, of course.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
