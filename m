Message-ID: <43D04896.4090404@tresys.com>
Date: Thu, 19 Jan 2006 21:19:02 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com> <43D016A1.6010004@cornell.edu> <43D03F2F.6060204@tresys.com> <43D046C0.1050400@cornell.edu>
In-Reply-To: <43D046C0.1050400@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>> How does the lack of access mean that the store isn't managed?
>>
>>
>> for all intents and purposes yes, since you can't query or write to it.
> 
> I still think that you shouldn't draw conclusions about what the user 
> will be doing with the store in a function that answers the question "Is 
> the store managed?" Maybe I'll switch to a more privileged user when I 
> decide to query or write to the store.
> 
I guess I can use access R_OK | X_OK to see if it's managed but 
ultimately the user won't be able to do anything if they can't write.

>>> I see in seobject, both is_managed, and can_write are called now, 
>>> meaning two access checks
>>> (and shouldn't they be in the opposite order).
>>>
>>
>> I'd like to bail as soon as possible if you aren't going to be able to 
>> write. Since they both do essentially the same checks but can_write is 
>> silent it should be first so that the user doesn't see the debug errors.
> 
> This doesn't make sense to me, is_managed() should also be silent in the 
> success path (meaning, if it can successfully check if the store is 
> managed or not).
> 
the reason Dan put in the UID == 0 check that I was trying to get rid of 
was because failure to read/write to the store spammed the user with 
error messages that don't make any sense to a user. Checking if they can 
  write before attempting to do so is all that makes sense, which is 
what I did. is_managed was always silent in the success path, it was not 
in the failure path which is why i switched it to use can_write instead 
of create_store, which has ERR() in all failure paths.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
