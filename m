Message-ID: <4350177F.7010600@tresys.com>
Date: Fri, 14 Oct 2005 16:39:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu> <435018F7.6070706@cornell.edu>
In-Reply-To: <435018F7.6070706@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>>
>>> I thought we agreed to have a direct only accessible part of the 
>>> handle,  such as
>>>
>>> struct semanage_direct_handle {
>>>     semanage_handle_t *handle;
>>>     /* direct stuff goes here */
>>> }; 
> 
> To put it another way.. this "direct-only" part does exist, but it's 
> hidden away.
> (into dbase_config_t -> dbase), which is an interface type. Then the 
> method table
> (dbase_config_t->dtable) specifies how to access it, which is equivalent 
> to your
> function table for modules.

The direct-only part needs to exist. The handle is becoming very 
cluttered with stuff that should not be there.
> 
> In fact, I want to convert your modules functions into a database too, but
> I haven't gotten to it yet, and this isn't high priority.
> 
Why? This doesn't solve any problem.

> So...basically I have multiple backend-specific portions, distributed by 
> functionality,
> rather than putting it all into one big table of function pointers that 
> aren't related.

the backend-specific portions should be hidden in a backend specific 
handle. This means that semanage_handle_t does *not* contain *any* 
backend specific information, all backend specific information would be 
in semanage_direct_handle, semanage_ps_handle, and so on.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
