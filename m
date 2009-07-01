Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61GaHC7019124
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 12:36:17 -0400
Received: from mail-pz0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n61GZxlM003532
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 16:35:59 GMT
Received: by pzk7 with SMTP id 7so613324pzk.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 09:36:15 -0700 (PDT)
Message-ID: <4A4B90BE.5070205@gmail.com>
Date: Wed, 01 Jul 2009 09:37:18 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Andy <hewanxiang@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Problem about PAM-selinux
References: <2cd8d8530906302109g57ece921i8a9fcd72261c6f88@mail.gmail.com> <4A4AEE64.3040105@gmail.com> <4A4B55C9.4040402@redhat.com>
In-Reply-To: <4A4B55C9.4040402@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 07/01/2009 01:04 AM, Justin P. Mattock wrote:
>> Andy wrote:
>>> Hi, all,
>>> I have a pam-selinux problem. I know I should post it to pam list, but
>>> no response from them.
>>>
>>> Things happened like this:
>>> I want to upgrade my pam in Fedora Core 6, when I make my
>>> Linux-PAM-1.1.0, I encountered a error.
>>>
>>> pam_selinux.c: In function `mls_range_allowed':
>>> pam_selinux.c:239: error: `CONTEXT__CONTAINS' undeclared (first use in
>>> this function)
>>> pam_selinux.c:239: error: (Each undeclared identifier is reported only
>>> once
>>> pam_selinux.c:239: error: for each function it appears in.)
>>> pam_selinux.c:246: error: `SECCLASS_CONTEXT' undeclared (first use in
>>> this function)
>>>
>>> And I grep "CONTEXT__CONTAINS" in the whole Linux-PAM-1.1.0 source
>>> code packet, nowhere defines it.
>>> It seems to be some issues about selinux.
>>> Anybody can give me a help ? Thanks.
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing 
>>> list.
>>> If you no longer wish to subscribe, send mail to
>>> majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>> looks like an old *.h file somewhere
>> try updating all the SELinux packages,
>> (and kernel if need be)
>>
>> Justin P. Mattock
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
> CONTEXT__CONTAINS is defined in libselinux.  I think you need to 
> update to a later version of libselinux.
>
Here is the address to the SELinux userpsace project:
http://userspace.selinuxproject.org/trac/wiki/Releases
you can either compile the .tar.balls
or in the search bar type "git" to
use the git interface(preferred approach).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
