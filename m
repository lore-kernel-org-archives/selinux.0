Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UK84bb018849
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 16:08:04 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7UK833V026925
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 20:08:03 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 9ABA83A1F3
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 16:07:58 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 3C3C81B4BB6
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 20:07:47 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 23D6A39C19D
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 14:07:47 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKMoeDWU-QxP for <selinux@tycho.nsa.gov>;
	Thu, 30 Aug 2007 14:07:44 -0600 (MDT)
Received: from [16.116.100.36] (unknown [16.116.100.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id 5CFCE39C1A1
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 14:07:43 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Time to remove compat_net?
Date: Thu, 30 Aug 2007 16:07:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708301607.42110.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does anyone have any objections to placing the compat_net code on the 
kernel's "feature removal schedule" (I'd go for removal in 2/2008, six months 
from now)?  SECMARK can do everything that the older compat_net controls can 
do, and it does it with less overhead and a cleaner implementation.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
