Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5JJ8ghU017246
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 15:08:42 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5JJ8fxZ009567
	for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2006 19:08:41 GMT
Subject: Some sort of explicit labeling for ipc?
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: kmacmillan@tresys.com
Content-Type: text/plain
Date: Mon, 19 Jun 2006 15:09:22 -0400
Message-Id: <1150744162.27852.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I was ask to do the socket create labeling patch it was mentioned
that an ipccreate labeling patch might also be useful for some use.  I'm
not sure who wanted it or for what.  But if someone can explain to me
what they want in the way of ipccreate labeling and what the use case
would be it might be something I can look into getting the kernel hooks
for.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
