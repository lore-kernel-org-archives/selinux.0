Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CDXHJ1022551
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 08:33:17 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CDWuWi019163
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 13:32:56 GMT
Message-ID: <4B9A429B.9050206@manicmethod.com>
Date: Fri, 12 Mar 2010 08:33:15 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Karl MacMillan <karlwmacmillan@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow generating dontaudit rules.
References: <4B858A2A.8080302@redhat.com>	 <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>	 <4B8C277E.6020608@redhat.com> <4B8C35E7.2020300@redhat.com>	 <4B8FE8FB.6050607@manicmethod.com>	 <10143821003041346o6903d2bbw49863b44d05a2a8c@mail.gmail.com> <10143821003080811l32b1243frcb71d7289b74cd37@mail.gmail.com> <4B9550EF.5020208@redhat.com>
In-Reply-To: <4B9550EF.5020208@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> On 03/08/2010 11:11 AM, Karl MacMillan wrote:
>> Accidentally sent this straight to Josh.
>>
>> Karl
>>
>> On Thu, Mar 4, 2010 at 4:46 PM, Karl
>> MacMillan<karlwmacmillan@gmail.com> wrote:
>>> I meant this - I don't want to pass around a boolean flag when we have
>>> a flag for rule type. This allows cleanly adding support for, say,
>>> generating both allow rules and auditallow rules at the same time.
>>>
> <snip>
>
> Ok this one only adds a flag to the policygenerator to tell it to
> generate dontaudit rules.
>
> No passing of args.

Merged in policycoreutils 2.0.81 and sepolgen 1.0.20

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
