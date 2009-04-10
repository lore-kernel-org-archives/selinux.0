Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux <selinux@tycho.nsa.gov>
Message-Id: <E1878383-7226-40C5-B235-9C6D66674092@nall.com>
From: Joe Nall <joe@nall.com>
To: jwcart2@tycho.nsa.gov
In-Reply-To: <1239381231.27413.48.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Policy infrastructure problems and improvement
Date: Fri, 10 Apr 2009 12:44:20 -0500
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil> <49DEC8D0.2060105@schaufler-ca.com> <1239366882.27413.24.camel@moss-lions.epoch.ncsc.mil> <E92B8263-9FF8-4AD8-83C9-97113864D8E2@nall.com> <1239381231.27413.48.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 10, 2009, at 11:33 AM, James Carter wrote:

> On Fri, 2009-04-10 at 09:51 -0500, Joe Nall wrote:

...

>> If Chris and Dan maintained and distributed policy as modules and not
>> as monolithic entities, the impetus and understanding to improve the
>> tool chain would be much stronger.
>>
> I am not sure I understand what you mean here.  Do you mean that if
> Chris and Dan only maintained a part of the policy, while others
> maintained the rest,

no

> the difficulty in putting all the parts together
> would provide strong motivation to improve the toolchain?

yes

>  That may be
> true, but it would make for a miserable existence for Chris and Dan.

Perhaps. They are smart guys, I suspect we would all benefit from  
their cleverness in avoiding the misery.

We have 118 (out of 402) different application rpms with policy in  
them. I'm experiencing the pain already :)

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
