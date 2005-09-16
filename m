Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8GKECNs000741
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 16:14:12 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8GKAgPO008351
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 20:10:43 GMT
Subject: ping broken symptoms
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 16:14:39 -0400
Message-Id: <1126901679.18007.138.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the bottom of the ping policy, there is this ifdef:

ifdef(`hide_broken_symptoms', `
allow ping_t init_t:fd use;
')

Isn't the purpose of the hide_broken_symptoms m4 tunable to dontaudit
broken code that can work without these accesses, not allow them?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
