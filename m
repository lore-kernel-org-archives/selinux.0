Message-ID: <43B95D95.4080509@cornell.edu>
Date: Mon, 02 Jan 2006 12:06:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Optional rebuild
References: <43AC5726.8090102@cornell.edu> <43B975B3.4000103@tresys.com>
In-Reply-To: <43B975B3.4000103@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> This patch uses the modified flags to skip a rebuild whenever possible.
>> It also adds the active boolean header to semanage.h (which I missed 
>> because of diff excludes).
>> It will now commit changes to the active booleans, so if no policy 
>> changes are done (modified = 0), or
>> changes are done, but preservebools is enabled (which it is, by 
>> default), then changes to active
>> booleans in the transaction will work as expected, and will not be 
>> overwritten by policy booleans.
>
> I'm not sure I understand this. If preservebools is enabled the policy 
> must be rebuilt. Looking at the patch it looks like you do rebuild 
> when persistent booleans are changed though.
I'm confused. Here's what the patch does - normally if you commit, you 
will always rebuild policy, and in certain cases, depending on 
preservebools that will cause any changes to active booleans to be 
overwritten (by the booleans in policy). So, if you want to change 
active booleans in a transaction, they might get overwritten for no 
reason. After the patch, if you commit you will only rebuild if 
necessary (if something affectng policy was changed). This means that 
you can have a transaction that changes a bunch of (active) booleans, 
then does a commit, and everything works as expected.

I guess that if you decide to add a bunch of users, and preservebools = 
0, and then add some active booleans, and then commit that still 
wouldn't work, because a rebuild would be forced, and policy booleans 
would take precedence to active boolean changes.
>>
>> This is also an optimization - allows running commit without 
>> rebuilding the policy, which could be beneficial for read-only 
>> operations using a transaction - it also seems more correct, because 
>> a read-only operation should not alter the state of the system - 
>> commit should not apply any changes that weren't explicit.
>
> A commit is by definition a write operation. The user is responsible 
> for  not committing if there aren't any changes.
I disagree - I think it's the other way around. If there aren't any 
changes, then commit should have no effect. If you do writes on commit 
that the user didn't request, that seems broken to me - all changes 
should be initiated by the user. A commit flushes those changes, and 
should have as few side effects as possible. Anyway, I don't see why we 
shouldn't make things a bit faster if we can.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
