Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA27593
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 18:54:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA29114
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 22:53:51 GMT
Received: from inst.augie.edu (inst.augie.edu [192.103.41.1])
	by jazzband.ncsc.mil  with ESMTP id WAA29110
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 22:53:51 GMT
Received: from Tak (cd505925-a.sxflls1.sd.home.com [24.17.104.25])
	by inst.augie.edu (AIX4.3/8.9.3/8.9.3) with SMTP id RAA58998
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 17:54:15 -0500
Date: Thu, 25 Oct 2001 17:43:33 -0500
From: Levi Bard <labard@inst.augie.edu>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Missing getscheduler hook
Message-Id: <20011025174333.0d638cc1.labard@inst.augie.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In addition to mozilla problems, this patch fixes problems with sun's
java sdks, (and probably other sdks as well) which also conflicted with
the nonpatched scheduler.  Good catch!

Levi Bard

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
