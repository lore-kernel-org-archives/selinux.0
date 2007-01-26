Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QK8Iij020386
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 15:08:18 -0500
Received: from macii.ads-oh.atg.titan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0QK9IaF005711
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 20:09:18 GMT
Received: from [192.168.50.32] (macii.ads-oh.atg.titan.com [66.218.141.147])
	by macii.ads-oh.atg.titan.com (Postfix) with ESMTP id A5C74146DFF
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 19:59:02 +0000 (GMT)
Mime-Version: 1.0
Message-Id: <p06002029c1e0096aebf1@[192.168.50.32]>
Date: Fri, 26 Jan 2007 14:54:12 -0500
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: semodule problem
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was able to successfully modify, load, and test policy rules (using 
audit2allow to add rules) until I ran into a problem with one 
particular rule I tried to add.   After adding this rule

    allow testserver_t self:process { setcurrent };

then semodule gave me the following error:

   libsepol.check_assertion_helper: assertion on line 0 violated by
             allow testserver_t testserver_t:process{ setcurrent };
   libsepol.check_assertions: 1 assertion violations occurred
   libsermanage.semanage_expand_ssandbox:Expand module failed

Any clues what caused this?

Thanks

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
