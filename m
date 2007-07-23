Message-ID: <46A4EF07.3050106@manicmethod.com>
Date: Mon, 23 Jul 2007 14:10:15 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Proposed patch to lisemanage/policycoreutils patches to	not	run
 genhomedircon/setfiles when setting booleans.
References: <469E6FFF.3040009@redhat.com>	 <1184954124.17338.868.camel@moss-spartans.epoch.ncsc.mil>	 <46A11BC4.10106@redhat.com> <1185210391.5266.12.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1185210391.5266.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-07-20 at 16:32 -0400, Daniel J Walsh wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Wed, 2007-07-18 at 15:54 -0400, Daniel J Walsh wrote:
>>>   
>>>       
>>>> Takes about 2 seconds off the time to rebuild policy and lots more if 
>>>> you are backending your passwd database with ldap.  Or have many 
>>>> different locations for homedirs.
>>>>     
>>>>         
>>> The way this should work is libsemanage should internally know what
>>> needs to be rebuilt and only rebuild those things.  Not require the
>>> caller to enable/disable parts.
>>>  
>>>   
>>>       
>> I tend to agree, but this at least meets my short term goals.
>>     
>
> Understood, but I don't think we want this approach upstream.  Joshua?
> Karl?  
>
> I'd rather work through the internal issues of libsemanage, as we want
> that anyway so that e.g. semanage login -a doesn't rebuild policy either
> (that was the whole point of moving Linux users out of policy, but
> libsemanage today still rebuilds everything!).
>
>   
I agree, I'll see what I can do about getting someone to work on this, 
perhaps after the genhomedircon in libsemanage work is done we can look 
at this (won't be long now, we've been getting the necessary stuff 
merged into ustr so we can use that for string manipulations)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
