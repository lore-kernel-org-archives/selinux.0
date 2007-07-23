Message-ID: <46A4E385.9080009@redhat.com>
Date: Mon, 23 Jul 2007 13:21:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
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
Actually semanage login -a would need to run genhomedircon

semanage login - Needs genhomedircon

semanage user needs genhomedircon, rebuild policy

semanage port, interface needs rebuild policy

semodule needs rebuild policy and genhomedircon

semanage fcontext needs genhomedircon, or maybe nothing.

setsebool either needs nothing or rebuild policy.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
