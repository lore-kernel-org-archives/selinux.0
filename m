Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5G3pKFK003209
	for <selinux@tycho.nsa.gov>; Sun, 15 Jun 2008 23:51:20 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5G3pK1e025415
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 03:51:20 GMT
Message-ID: <4855E31E.50004@manicmethod.com>
Date: Sun, 15 Jun 2008 23:50:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Mohamed Hassan <mhassan@cse.psu.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: defining a new class in a policy module
References: <1213583952.31114.8.camel@cairo>
In-Reply-To: <1213583952.31114.8.camel@cairo>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mohamed Hassan wrote:
> Hi,
> I created a new policy inside the refpolicy. I am trying to define a new
> class inside this module. When I compile, it fails with parsing error:
> 
> /usr/bin/checkmodule -M -m tmp/gsmd.tmp -o tmp/gsmd.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/gsmd.tmp
> policy/modules/services/gsmd.te:3:ERROR 'syntax error' at token 'Class'
> on line 1185:
> 
> Class gsmd { send_sms_msg receive_sms_msg };
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> 
> 
> Here is my class definition:
> Class gsmd { send_sms_msg receive_sms_msg };
> 
> I would like to know how to define a new class in policy module?
> 

It isn't supported, mainly because class and permission ordering is still very static in the policy. To be sure that policy/library/kernel updates won't disturb the number assigned to your object class it is best to submit a reference policy patch to the flask/ directory and let those header changes propagate to the library and kernel.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
