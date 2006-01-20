Message-ID: <43D03F2F.6060204@tresys.com>
Date: Thu, 19 Jan 2006 20:38:55 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com> <43D016A1.6010004@cornell.edu>
In-Reply-To: <43D016A1.6010004@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>> - chance semanage_is_managed to use can_write instead of create_store
>> for access check
>>   
> 
> Why should semanage_is_managed do an access check?
the only way to check for a managed policy is to look for the 
directories. We also require write access to read from the store (read 
lock) so you can't do anything if you can't write to it. Also, it was 
already doing access checks (semanage_create_store with argument 0 
checks access but doesn't create directories) and that was what was 
spamming the user with errors when they couldn't write.

> How does the lack of access mean that the store isn't managed?

for all intents and purposes yes, since you can't query or write to it.

> I see in seobject, both is_managed, and can_write are called now, 
> meaning two access checks
> (and shouldn't they be in the opposite order).
> 

I'd like to bail as soon as possible if you aren't going to be able to 
write. Since they both do essentially the same checks but can_write is 
silent it should be first so that the user doesn't see the debug errors.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
