Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BL7uVe012014
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 17:07:56 -0400
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BL4Ci2016100
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 21:04:13 GMT
Cc: SELinux List <selinux@tycho.nsa.gov>
Message-Id: <A2626FB3-B180-4C23-8B58-E7975D9AF1B8@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <49B823CD.3090409@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Help with python seobject.loginRecords
Date: Wed, 11 Mar 2009 16:07:53 -0500
References: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com> <49B8126B.9060501@redhat.com> <F1007BB4-8898-4A05-B09A-4FB1EF8519A2@nall.com> <49B823CD.3090409@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 11, 2009, at 3:49 PM, Daniel J Walsh wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Joe Nall wrote:
>>
>> On Mar 11, 2009, at 2:35 PM, Daniel J Walsh wrote:
>>
>>> On 03/11/2009 12:15 PM, Joe Nall wrote:
>>>> I need to add login mappings in python firstboot modules during  
>>>> system
>>>> configuration. In my first module a simple:
>>>>
>>>> seobject.loginRecords().add(username, "siterep_u",
>>>> "SystemLow-SystemHigh")
>>>>
>>>> works. In subsequent modules, I get an exception:
>>>>
>>>> libsemanage.enter_rw: this operation requires a transaction
>>>> libsemanage.enter_rw: could not enter read-write section
>>>> Traceback (most recent call last):
>>>> File "./t", line 6, in <module>
>>>> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow- 
>>>> SystemHigh")
>>>> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442,  
>>>> in add
>>>> raise error
>>>> ValueError: Could not add login mapping for test3
>>>>
>>>> What is the right way to do this?
>>>>
>>>> joe
>>>>
>>>>
>>>> -- 
>>>> This message was distributed to subscribers of the selinux  
>>>> mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>> Probably an MLS issue.  firtstboot is running in a context that is  
>>> not
>>> allowed to lock/manage selinux.
>>
>> I'm installing in permissive and switching to enforcing after  
>> firstboot.
>> You are correct that firstboot_t doesn't have the policy for all the
>> stuff I'm trying to do yet.
>>
>>> You probably should exec semanage rather then calling seobject so  
>>> you
>>> could do a transition and not have to give a huge app like first  
>>> boot
>>> the ability to manage security policy.
>>
>> That is what is installing right now. I would still like an
>> explanation/code snippet of correct usage for future use
>>
>> joe
>>
>>
> This works on F10 Targeted policy
>
> # python -c "import seobject; seobject.loginRecords().add("pwalsh",
> "staff_u", "s0")
> # python -c 'import seobject;  
> seobject.loginRecords().delete("pwalsh")'
>
> Could it be a translation problem?

I don't think so, mcstrans is installed and running at this point in  
the install. Try this, sometimes it works, sometimes it fails with:

[joe@fast firstboot]$ sudo ./t
libsemanage.enter_rw: this operation requires a transaction
libsemanage.enter_rw: could not enter read-write section
Traceback (most recent call last):
   File "./t", line 7, in <module>
     seobject.loginRecords().delete("pwalsh")
   File "/usr/lib64/python2.5/site-packages/seobject.py", line 526, in  
delete
     raise error
ValueError: Could not delete login mapping for pwalsh

------------

#!/usr/bin/python

import seobject

seobject.loginRecords().add("pwalsh", "staff_u", "s0")

seobject.loginRecords().delete("pwalsh")

seobject.loginRecords().add("pwalsh", "staff_u", "s0")

seobject.loginRecords().delete("pwalsh")

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
