Message-ID: <42EE4073.1010501@tresys.com>
Date: Mon, 01 Aug 2005 11:32:03 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>	<Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>	<1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>	<42EE3879.2050409@tresys.com> <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-08-01 at 10:58 -0400, Joshua Brindle wrote:
>  
>
>>Stephen Smalley wrote:
>>
>>    
>>
>>><snip>
>>>
>>>- We need to be sure that we are comfortable with collapsing the type
>>>value space and class value space to 16 bits.  That was done by the
>>>first patchset as part of reducing the avtab node size.  The avtab_read
>>>code checks for value truncation when reading older binary policies; we
>>>should also add checks to checkpolicy to ensure that we don't overflow
>>>
>>>during policy compilation.
>>>
>>>      
>>>
>>I know it won't affect the size but why not make all symbol value
>>spaces 16 bits, just for consistency?
>>    
>>
>
>Also, my real question here is whether we are sure that 16 bit value
>space is going to be enough forever for types.
>  
>
Right, which I didn't answer although I do think the answer is yes.

To reach the 16 bit limit the policy would have to grow ~50 times and by 
then the avtab size would be very large, even after the attribute patch 
would result in a ~250 meg avtab (assuming the type to rule growth is 
the same)

Trying to contrive an example where the 16 bit space would not be 
sufficient... A shell or webserver with 10's of thousands of customers 
where the security goal is to keep customers seperate via domains, but I 
don't really think this is a realistic example, at least not real enough 
to penalize all SELinux users in order to facilitate it.

But just incase.. how hard do you think it'd be to toggle the size via 
kernel config and checkpolicy flag? I know the compatibility is already 
ugly and this wouldn't help at all but if there is a genuine need for a 
larger value space in very specialized systems, it would be nice to 
allow that without optimizing the system for corner cases.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
