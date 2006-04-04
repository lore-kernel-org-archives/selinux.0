Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k34F1KCB000477
	for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2006 11:01:20 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k34F1IS5014204
	for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2006 15:01:19 GMT
Subject: Re: [patch] userhelper.te typo fix
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Leighton Athey <jathey@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1144161680.15137.3.camel@tesla.columbia.tresys.com>
References: <1144161680.15137.3.camel@tesla.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 11:02:22 -0400
Message-Id: <1144162943.9876.0.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-04-04 at 10:41 -0400, James Leighton Athey wrote:
> There's a typo in userhelper.te where it should be adding
> userhelper_exec_t to files_type but instead it adds userhelper_conf_t
> twice.  I've attached a patch to fix it.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
