Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9L92Ii025722
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 16:09:02 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9L94M7024510
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 21:09:04 GMT
Subject: Re: [RFC][PATCH] Control ability to have a writable executable
	mapping
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1100034309.408.278.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Nov 2004 16:05:10 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-09 at 13:40, Stephen Smalley wrote:
> Please note that this patch does NOT provide the functionality of PAX,
> exec-shield, NX support, etc.  It merely provides SELinux policy control
> over the ability to create an executable mapping that can contain data
> not covered by file permission checks.

Sorry, the last statement isn't accurate; this patch only provides
SELinux policy control over the ability to have a mapping that is
simultaneously writable and executable.  One could still create a rw
mapping and then later change its protection to rx.  For anonymous
mappings, the patch could be trivially modified to apply the check for
any PROT_EXEC mapping and thus prevent executable anonymous mappings
entirely except when explicitly allowed; that seems reasonable.  Private
file mappings are more problematic.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
