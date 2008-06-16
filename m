Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5GDwUbQ024226
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 09:58:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5GDwTnk021933
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 13:58:29 GMT
Message-ID: <48567167.9090303@manicmethod.com>
Date: Mon, 16 Jun 2008 09:57:59 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Mohamed Hassan <mhassan@cse.psu.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: defining a new class in a policy module
References: <1213583952.31114.8.camel@cairo>	 <4855E31E.50004@manicmethod.com> <1213593850.6655.8.camel@cairo>
In-Reply-To: <1213593850.6655.8.camel@cairo>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mohamed Hassan wrote:
> Thank you for the response. When I modify the flask/ directory and run
> make (flask.py) it will generate 2 directories kernel and selinux. The
> kernel one will go under <kernel-src>/security/selinux/include/ and the
> selinux headers will go under libselinux/include/selinux. 
> 
> There is another flask.h file under
> libsepol/include/sepol/policydb/flask.h do I need to update that file
> for checkpolicy and semodule to work properly?
> 
> 

After adding them to access_vectors and security_classes you want to rebuild your base.pp from that repo so that you'll have those classes included in the policy you are linking your module against. 

The module will then need to require the classes and permissions:

require {
	class gsmd { send_sms_msg receive_sms_msg };
}

in order to use those in the module.

You won't necessarily need to do anything with the headers, but like I said, if you want the numbers reserved you need to send a patch to refpolicy for the flask dir (minus the headers)

>  
> On Sun, 2008-06-15 at 23:50 -0400, Joshua Brindle wrote:
>> Mohamed Hassan wrote:
>>> Hi,
>>> I created a new policy inside the refpolicy. I am trying to define a new
>>> class inside this module. When I compile, it fails with parsing error:
>>>
>>> /usr/bin/checkmodule -M -m tmp/gsmd.tmp -o tmp/gsmd.mod
>>> /usr/bin/checkmodule:  loading policy configuration from tmp/gsmd.tmp
>>> policy/modules/services/gsmd.te:3:ERROR 'syntax error' at token 'Class'
>>> on line 1185:
>>>
>>> Class gsmd { send_sms_msg receive_sms_msg };
>>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>>>
>>>
>>> Here is my class definition:
>>> Class gsmd { send_sms_msg receive_sms_msg };
>>>
>>> I would like to know how to define a new class in policy module?
>>>
>> It isn't supported, mainly because class and permission ordering is still very static in the policy. To be sure that policy/library/kernel updates won't disturb the number assigned to your object class it is best to submit a reference policy patch to the flask/ directory and let those header changes propagate to the library and kernel.
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
