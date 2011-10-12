Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CHbVWm020669
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 13:37:31 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CHbUSW021611
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 17:37:30 GMT
Message-ID: <4E95D057.2040700@tresys.com>
Date: Wed, 12 Oct 2011 13:37:27 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am working to further shrink the size of policy in Fedora 17.
References: <4E8F43CE.7010605@redhat.com> <4E9598C0.9080700@tresys.com> <4E95A0E6.9070301@redhat.com>
In-Reply-To: <4E95A0E6.9070301@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/12/11 10:15, Daniel J Walsh wrote:
> On 10/12/2011 09:40 AM, Christopher J. PeBenito wrote:
>> On 10/07/11 14:24, Daniel J Walsh wrote:
>>> Right now, every domain that transitions to another domain gets
>>> the following rule written.
>>>
>>> dontaudit SOURCE TARGET : process { noatsecure siginh rlimitinh }
>>> ;
>>>
>>> In Fedora 17 policy right now we have 2152 rules, out of
>>> Dontaudit: 9415
>>>
>>>
>>> sesearch --dontaudit -p noatsecure | wc -l 2152
>>>
>>> We could rewrite this with one rule.
>>>
>>> dontaudit domain domain:process { noatsecure siginh rlimitinh }
>>> ;
>>>
>>> Of course this is more lenient then what we have now, although
>>> since it is dontaudit rules, not sure it matters.
>>>
>>> Comments?
> 
>> I'm on the fence.  On one hand, I hate to overspecify the policy,
>> but on the other hand, these perms can only be hit on a domain
>> transition.  How much does this save?
> 
> 
> 2000/90000
> 
> 2% of the size of policy.

Based on my test of all Refpolicy modules compiled in, the size went from 4687381 to 4667101, a 20kB difference.  If someone was trying to squeeze everything out for an embedded system policy, I could see this change, but otherwise, it doesn't seem very compelling.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
