Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29732
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 10:22:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA03010
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 15:19:49 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-159.nas-smoothtransition.com [66.95.157.159] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA03006
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 15:19:48 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'selinux'" <selinux@tycho.nsa.gov>
Subject: new and updated setools
Date: Thu, 19 Dec 2002 10:20:53 -0500
Message-ID: <001001c2a772$3b5a01e0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We just finally released a new update to our setools package at
www.tresys.com/selinux .  This release includes a new tool (sepcut),
which is a first attempt at a GUI policy source
configuration/browse/edit/test tool.  This tools is like of more value
to novices than to experts.  It's relatively basic in capabilities,
especially in regard to an editor.  However, it does provide a means to
view all parts of policy development in a single tool, and to easily
enable/disable/add/remove program modules.

Along with a bunch of fixes and changes, we've included regexp support
and the ability to open MLS-enabled policies in our analysis tool
(apol).  (The MLS changes don't allow you to analyze the MLS aspects,
but lets you analyze a policy that includes MLS...this is rather
experimental).  We also updated seuser to work with both the old and new
style of login contexts.

The source code, screen shots, and other information can be found at
www.tresys.com/selinux.  As always, feedback, bug reports, etc. are
appreciated at selinux@tresys.com.

Regards, Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
