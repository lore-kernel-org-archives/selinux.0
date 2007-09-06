Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l866IT35027490
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 02:18:29 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l866ISqO021259
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 06:18:28 GMT
In-Reply-To: <1189012887.30065.31.camel@gorn>
References: <6E78FE11-FAA3-4C3B-A87E-FA60ABB71863@sf-net.com> <1189012887.30065.31.camel@gorn>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37E57EBC-1878-4482-9390-F43E29F24E03@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: tunable and if-else conditional
Date: Thu, 6 Sep 2007 08:18:16 +0200
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 05.09.2007, at 19:21, Christopher J. PeBenito wrote:

> On Wed, 2007-09-05 at 17:35 +0200, Stefan Schulze Frielinghaus wrote:
>> reading an older poste (http://www.nsa.gov/selinux/list-archive/0610/
>> thread_body16.cfm) I wonder about the difference between tunable and
>> an if-else conditional.
>>
>> <quote>
>> Tunable_policy are blocks that will be replaced by a similar language
>> feature when it becomes available. Tunables will be similar to
>> conditionals, except they will be selected during the policy module
>> linking instead of being selectable at runtime.
>> </quote>
>>
>> Using the latest stable refpolicy (20070629) the feature has already
>> changed? I would guess so because I can change the booleans via
>> setsebool at runtime.
>
> No, true tunables require support in the toolchain.  That won't happen
> until after the new policy representation is completed.
>
>> Looking at the file "loadable_module.spt" the tunable seems to me
>> exact the same like a if-else conditional. But I'm not a M4 guy and
>> wanted to make sure. Is this right that a tunable and a if-else
>> conditional is the same now?
>
> Tunables are implemented as conditional policy right now.

So in the end the preferred way of handling booleans is via what?  
Because as already pointed out in the post before all if-else  
statements were replaced via tunables. But the tunables aren't  
supposed to be changed at runtime which booleans should be. Or do I  
miss something?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
