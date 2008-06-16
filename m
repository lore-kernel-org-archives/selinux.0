Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5G2dBaW028928
	for <selinux@tycho.nsa.gov>; Sun, 15 Jun 2008 22:39:11 -0400
Received: from arlo.cse.psu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5G2dA1e013822
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 02:39:10 GMT
Received: from 64.178.104.51.dynamic.dejazzd.com ([64.178.104.51] helo=[192.168.1.100])
	by arlo.cse.psu.edu with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <mhassan@cse.psu.edu>)
	id 1K84cg-0006Vs-Pf
	for selinux@tycho.nsa.gov; Sun, 15 Jun 2008 22:39:10 -0400
Subject: defining a new class in a policy module
From: Mohamed Hassan <mhassan@cse.psu.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 15 Jun 2008 22:39:12 -0400
Message-Id: <1213583952.31114.8.camel@cairo>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I created a new policy inside the refpolicy. I am trying to define a new
class inside this module. When I compile, it fails with parsing error:

/usr/bin/checkmodule -M -m tmp/gsmd.tmp -o tmp/gsmd.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/gsmd.tmp
policy/modules/services/gsmd.te:3:ERROR 'syntax error' at token 'Class'
on line 1185:

Class gsmd { send_sms_msg receive_sms_msg };
/usr/bin/checkmodule:  error(s) encountered while parsing configuration


Here is my class definition:
Class gsmd { send_sms_msg receive_sms_msg };

I would like to know how to define a new class in policy module?

Thanks,
-M Hassan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
