Message-ID: <43D0EDD6.9070501@tresys.com>
Date: Fri, 20 Jan 2006 09:04:06 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com> <1137766150.3648.125.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137766150.3648.125.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-01-19 at 16:45 -0500, Joshua Brindle wrote:
> 
>>- add semanage_can_write to libsemanage which does a silent check for
>>access on the active store, modules directory and binary policy
>>directory
>>- chance semanage_is_managed to use can_write instead of create_store
>>for access check
>>- add access check to seobject.py, in semanageRecord init
> 
> 
> Also, how do you envision implementing this interface for the policy
> server backend?  Same question exists for semanage_is_managed I suppose,
> but that interface seems a little more general in concept.
>   

I wasn't at first but one could always ask the server if my context has 
write permission to the policy, which is a slightly different concept 
but from a user perspective probably means the same thing.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
