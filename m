Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA10161
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 12:01:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA01592
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 15:59:45 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id PAA01588 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 15:59:44 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: updated setools
Date: Mon, 5 Aug 2002 12:03:31 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIMECIKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For those of you who may use our selinux tools, we just posted an update
(0.4.2) at www.tresys.com/selinx.  The primary motivation for the update is
to make our analysis tool (apol) compatible with the policy syntax changes
in the July 2002 release of SE Linux.  We also kept it backwards compatible
with older policy syntax.  In addition, we added a policy for our seuser
policy itself, and made the install process install the new policy update.
Various other minor fixes.

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
