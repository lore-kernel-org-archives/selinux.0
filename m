Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CIo8XD025104
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 14:50:09 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CIo89Z027717
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 18:50:08 GMT
Message-ID: <4E95E15E.6080207@redhat.com>
Date: Wed, 12 Oct 2011 14:50:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am working to further shrink the size of policy in Fedora 17.
References: <4E8F43CE.7010605@redhat.com> <4E9598C0.9080700@tresys.com> <4E95A0E6.9070301@redhat.com> <4E95D057.2040700@tresys.com> <4E95D805.3050507@redhat.com> <4E95E05F.9050108@tresys.com>
In-Reply-To: <4E95E05F.9050108@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/12/2011 02:45 PM, Christopher J. PeBenito wrote:
> On 10/12/11 14:10, Daniel J Walsh wrote:
>> On 10/12/2011 01:37 PM, Christopher J. PeBenito wrote:
>>> On 10/12/11 10:15, Daniel J Walsh wrote:
>>>> On 10/12/2011 09:40 AM, Christopher J. PeBenito wrote:
>>>>> On 10/07/11 14:24, Daniel J Walsh wrote:
>>>>>> Right now, every domain that transitions to another
>>>>>> domain gets the following rule written.
>>>>>> 
>>>>>> dontaudit SOURCE TARGET : process { noatsecure siginh 
>>>>>> rlimitinh } ;
>>>>>> 
>>>>>> In Fedora 17 policy right now we have 2152 rules, out of
>>>>>>  Dontaudit: 9415
>>>>>> 
>>>>>> 
>>>>>> sesearch --dontaudit -p noatsecure | wc -l 2152
>>>>>> 
>>>>>> We could rewrite this with one rule.
>>>>>> 
>>>>>> dontaudit domain domain:process { noatsecure siginh
>>>>>> rlimitinh } ;
>>>>>> 
>>>>>> Of course this is more lenient then what we have now, 
>>>>>> although since it is dontaudit rules, not sure it
>>>>>> matters.
>>>>>> 
>>>>>> Comments?
>>>> 
>>>>> I'm on the fence.  On one hand, I hate to overspecify the 
>>>>> policy, but on the other hand, these perms can only be hit
>>>>> on a domain transition.  How much does this save?
>>>> 
>>>> 
>>>> 2000/90000
>>>> 
>>>> 2% of the size of policy.
>> 
>>> Based on my test of all Refpolicy modules compiled in, the
>>> size went from 4687381 to 4667101, a 20kB difference.  If
>>> someone was trying to squeeze everything out for an embedded
>>> system policy, I could see this change, but otherwise, it
>>> doesn't seem very compelling.
>> 
>> That is because you have not already shrunk your policy to the
>> degree that Fedora has.  F17 is down to this.
> [...]
>> Allow:           83205    Neverallow:          0 Auditallow:
>> 10    Dontaudit:        6079
> 
> I don't understand.  The change in Refpolicy was 1690 dontaudit
> rules.  If thats a 20kB change in Refpolicy, the 2151 rule change
> in the Fedora policy would probably be ~25kB.  What is the current
> size of the Fedora policy (policy.26 on disk)?
> 

I just updated people.redhat.com and the libra.te policy

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6V4V4ACgkQrlYvE4MpobPMtACfRwh0qPmXDPc2+HXFO0bW3Hdx
aRIAoOnt5iqmrEZ0gAr/s+Vqlh2I0PbG
=ZkPq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
