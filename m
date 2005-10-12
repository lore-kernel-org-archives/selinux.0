Message-ID: <434D35B1.7060409@cornell.edu>
Date: Wed, 12 Oct 2005 12:11:29 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ RESEND ] [ SEMANAGE ] Debugging system
References: <434CC592.70001@cornell.edu> <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-12 at 04:13 -0400, Ivan Gyurdiev wrote:
>   
>> Okay, here's version 2. I'm not sure if I like this very much, but I've 
>> done all the changes you requested:
>>     
>
> What don't you like?  Or what did you like better about the prior
> version?
>   
It looks more complicated now.... and more disorganized.
I guess it's fine, as long as it's easy to use.
>> - variadic list passed to callback **
>> - message structure dropped
>> - message structure fields embedded in the handle
>>         (ugh.. I had to do this, because of circular dependencies)
>> - handle passed to callback
>> - msg_write is a macro
>> - also fixed extra newline
>> - also added newlines to every single Tresys error message
>>     
>
> Why require the newline in the individual error messages?
>   
The newline is part of the message - it's not a good idea to push it 
into the messaging system. Eventually we will run into a case where we 
don't want a newline printed, and the messaging system wouldn't be able 
to handle that....happens every time I try to do this.

>> - libsemanage.map is modified this time
>>
>> Because of (**) I now can't submit the sepol patch, because my compat 
>> handler is broken .... Do we need compatibility with 
>> sepol_enable/disable_debug ? Have we released an official libsepol with 
>> those functions? I know Dan's been building that library, but I'm pretty 
>> sure no one is using those functions yet, and that's rawhide. It would 
>> be nice if those could be removed, so I don't have to support two 
>> callback systems simultaneously.
>>     
>
> If there are no users, it can still change, and I don't see any.
>   
Okay, in that case I will remove those functions...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
