Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NL4GrT021376
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:04:17 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NL4Fwb012697
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:04:15 GMT
Received: from [10.1.12.42] (twoface.columbia.tresys.com [10.1.12.42])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id i7NL4GSf021670
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:04:16 -0400
Message-ID: <412A5BD0.8050606@tresys.com>
Date: Mon, 23 Aug 2004 17:04:16 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: constraints and subtraction
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was wondering if there was a specific reason that constraints don't 
support subtraction but support attributes, sets, * and ~. For example 
the following might be useful:

constrain dir_file_class_set { create relabelto relabelfrom }
         ( u1 == u2 or t1 == { privowner -sysadm_t } );

Thanks.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
