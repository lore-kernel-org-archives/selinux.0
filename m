Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0VIWAXf018789
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 13:32:12 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0VIUsAa018375
	for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2006 18:30:54 GMT
Message-Id: <200601311831.k0VIVcNq002297@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <fedora-selinux-list@redhat.com>, <selinux@tycho.nsa.gov>
Cc: "Selinux-Dev" <selinux-dev@tresys.com>
Subject: ANN: Setools-2.3 release
Date: Tue, 31 Jan 2006 13:31:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Setools-2.3 is now available on the Tresys Technology website.

http://tresys.com/selinux/selinux_policy_tools.shtml

This version adds MLS and OCONS to apol and seinfo as well as some other
smaller changes throughout the tools.  

Here is the detailed changelog.

apol:
	added new MLS components tab for sensitivities, 
	levels, and categories.
	Changed users tab to support ranges and default 
	levels.
	added range transition tab for searching range
	Transition rules.
	added new tab for network context components.
	added new tab for file system context components.
libapol:
	added binpol support for MLS, network contexts, 
	and file system contexts.
seinfo:
	added command line options for MLS components.
	added command line options for network contexts
	and file system contexts.
sesearch:
	added command line option for searching for rules
	by conditional boolean name.
seaudit:
	added new column in the log view for the 'comm' 
	field found in auditd log files.
	added filters for the 'comm' field and 'message'
	field.
manpages:
	added manpages for all tools.	


Kevin Carr
Tresys Technology
410.290.1411 x137




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
