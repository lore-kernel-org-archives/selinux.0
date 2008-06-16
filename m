Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5G5O9PI012587
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 01:24:09 -0400
Received: from arlo.cse.psu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5G5O8qq013908
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 05:24:09 GMT
Subject: Re: defining a new class in a policy module
From: Mohamed Hassan <mhassan@cse.psu.edu>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4855E31E.50004@manicmethod.com>
References: <1213583952.31114.8.camel@cairo>
	 <4855E31E.50004@manicmethod.com>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 01:24:10 -0400
Message-Id: <1213593850.6655.8.camel@cairo>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for the response. When I modify the flask/ directory and run
make (flask.py) it will generate 2 directories kernel and selinux. The
kernel one will go under <kernel-src>/security/selinux/include/ and the
selinux headers will go under libselinux/include/selinux. 

There is another flask.h file under
libsepol/include/sepol/policydb/flask.h do I need to update that file
for checkpolicy and semodule to work properly?


 
On Sun, 2008-06-15 at 23:50 -0400, Joshua Brindle wrote:
> Mohamed Hassan wrote:
> > Hi,
> > I created a new policy inside the refpolicy. I am trying to define a new
> > class inside this module. When I compile, it fails with parsing error:
> > 
> > /usr/bin/checkmodule -M -m tmp/gsmd.tmp -o tmp/gsmd.mod
> > /usr/bin/checkmodule:  loading policy configuration from tmp/gsmd.tmp
> > policy/modules/services/gsmd.te:3:ERROR 'syntax error' at token 'Class'
> > on line 1185:
> > 
> > Class gsmd { send_sms_msg receive_sms_msg };
> > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> > 
> > 
> > Here is my class definition:
> > Class gsmd { send_sms_msg receive_sms_msg };
> > 
> > I would like to know how to define a new class in policy module?
> > 
> 
> It isn't supported, mainly because class and permission ordering is still very static in the policy. To be sure that policy/library/kernel updates won't disturb the number assigned to your object class it is best to submit a reference policy patch to the flask/ directory and let those header changes propagate to the library and kernel.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
