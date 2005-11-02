Message-ID: <436876D1.2060805@cornell.edu>
Date: Wed, 02 Nov 2005 03:20:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] Some seusers mapping validation
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu>	 <4367044C.1000501@cornell.edu> <1130874624.22731.280.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130874624.22731.280.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> users.local allows you to define additional SELinux users and authorize
> them for role sets and ranges.  seusers allows you to map Linux users to
> SELinux users defined in either the policy modules or users.local, and
> to assign the Linux user a subset of the range authorized for the
> SELinux user.  Hence, validation of the MLS range in seusers would
> consist of:
> - validating the range by itself as usual,
> - validating that the range is a subset of the range authorized for the
> SELinux user.
>   

This requires additional interfaces in context.c that do not currently 
exist...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
