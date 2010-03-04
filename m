Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o24H8E0L010537
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 12:08:14 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o24H8csO008625
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 17:08:38 GMT
Message-ID: <4B8FE8FB.6050607@manicmethod.com>
Date: Thu, 04 Mar 2010 12:08:11 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Karl MacMillan <karlwmacmillan@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow generating dontaudit rules.
References: <4B858A2A.8080302@redhat.com> <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com> <4B8C277E.6020608@redhat.com> <4B8C35E7.2020300@redhat.com>
In-Reply-To: <4B8C35E7.2020300@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 03/01/2010 03:45 PM, Daniel J Walsh wrote:
>> On 03/01/2010 02:29 PM, Karl MacMillan wrote:
>>> I'd rather pass in the rule type to the AVRule init rather than a
>>> boolean about this being a dontaudit rule.
>>>
>>> Karl
>>>
>>> On Wed, Feb 24, 2010 at 3:20 PM, Daniel J Walsh<dwalsh@redhat.com>
>>> wrote:
>>>>
>> How about this patch. Moves the dontaudit up the chain a little bit.
>> Is this what you want.
> One minor problem. Updated patch.
>

Karl?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
