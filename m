Message-ID: <435018F7.6070706@cornell.edu>
Date: Fri, 14 Oct 2005 16:45:43 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu>
In-Reply-To: <435017B2.7040107@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>> I thought we agreed to have a direct only accessible part of the 
>> handle,  such as
>>
>> struct semanage_direct_handle {
>>     semanage_handle_t *handle;
>>     /* direct stuff goes here */
>> }; 
To put it another way.. this "direct-only" part does exist, but it's 
hidden away.
(into dbase_config_t -> dbase), which is an interface type. Then the 
method table
(dbase_config_t->dtable) specifies how to access it, which is equivalent 
to your
function table for modules.

In fact, I want to convert your modules functions into a database too, but
I haven't gotten to it yet, and this isn't high priority.

So...basically I have multiple backend-specific portions, distributed by 
functionality,
rather than putting it all into one big table of function pointers that 
aren't related.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
