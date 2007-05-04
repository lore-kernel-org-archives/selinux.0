Message-ID: <463B6B3B.1030906@redhat.com>
Date: Fri, 04 May 2007 13:19:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Joshua Brindle <method@manicmethod.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: Where to specific the handling of unknown kernel classes and
 perms
References: <1178141128.3897.33.camel@dhcp59-235.rdu.redhat.com>	 <463930F3.7020803@manicmethod.com>	 <1178196394.3443.135.camel@moss-spartans.epoch.ncsc.mil>	 <4639E183.4080909@manicmethod.com>	 <1178200479.3443.172.camel@moss-spartans.epoch.ncsc.mil>	 <463A005B.3010504@manicmethod.com>  <463B5356.1040804@redhat.com> <1178295358.15062.9.camel@localhost.localdomain>
In-Reply-To: <1178295358.15062.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Fri, 2007-05-04 at 11:37 -0400, Daniel J Walsh wrote:
>   
>> Joshua Brindle wrote:
>>     
>>> Stephen Smalley wrote:
>>>       
>
> <snip>
>
>   
>>> Ok, I agree, we can work out how to change it on end systems without 
>>> rebuilding the policy later. This should certainly be a managed 
>>> setting so that we can enforce access control on it and audit if 
>>> necessary.
>>>
>>>       
>
> <snip>
>
>   
>> Is this possible to be a boolean?  Tunable eventually.
>>
>>     
>
> Nope - but it could be an semanage command eventually (which would be
> nice since it would generate audit messages).
>
> Karl
>
>   
Ok my question stunk.  The real question is can we make it easy for the 
user
semanage kernel_deny_unknown=1
Which rebuilds and reloads policy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
