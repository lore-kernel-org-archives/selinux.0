Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99IaiCK008373
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 14:36:44 -0400
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99IZWcD020164
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 18:35:32 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1Ko0NN-000EkF-E3
	for selinux@tycho.nsa.gov; Thu, 09 Oct 2008 18:36:41 +0000
Message-Id: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: per role template confusion
Date: Thu, 9 Oct 2008 13:36:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can someone explain the per role template implementation? I am confused.

During policy compilation, a .mod.role file is created that just  
references the roles in /usr/share/selinux/devel/include/rolemap  
regardless of the roles defined via semanage. Should semanage add  
roles to rolemap? Is there additional magic in semodule?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
