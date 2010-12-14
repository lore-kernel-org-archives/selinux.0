Message-ID: <4D07D368.5050104@manicmethod.com>
Date: Tue, 14 Dec 2010 15:28:24 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jeff Johnson <n3npq@mac.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Subject: Re: Unit testing userspace
References: <C92D2AAD.BBA97%csellers@tresys.com> <40341D7F-2276-4DFD-9380-AAE56F81C343@mac.com>
In-Reply-To: <40341D7F-2276-4DFD-9380-AAE56F81C343@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeff Johnson wrote:
> On Dec 14, 2010, at 2:07 PM, Chad Sellers wrote:
>> Note that we've been using CuTest in CIL, and it is very simple and easy to
>> use. There's almost no spin up to using it.
>>
>
> Try the ISPRAS api-sanity-autotest.pl (same people doing LSB testing).

If CIL is already using cutest that would be helpful. AFAIK Perl isn't installed 
by default on fedora or gentoo, and we'd want to have the tests run in the 
default make target in a clean build environment (for RPM builds and such). FWIW 
I discounted other test frameworks outright because they use ruby or other 
non-default packages.

>
> There is zero spin-up to shallow testing using ISPRAS, and some modest thought
> writing some XML templates can go a long ways towards reasonable
> unit testing with significant coverage.
>
> OTOH, if you truly need mocking with symbol replacemnet, well ... good luck! That's hard.
>

test-dept does mocking with symbol replacement and all that. Yes it is hard (not 
nearly as hard as doing it without something like test-dept) but Chad may be 
right, it could be just too hard to encourage unit tests to be written.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
