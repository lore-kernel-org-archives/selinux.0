MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: Unit testing userspace
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <C92D2AAD.BBA97%csellers@tresys.com>
Date: Tue, 14 Dec 2010 14:21:48 -0500
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Message-id: <40341D7F-2276-4DFD-9380-AAE56F81C343@mac.com>
References: <C92D2AAD.BBA97%csellers@tresys.com>
To: Chad Sellers <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Dec 14, 2010, at 2:07 PM, Chad Sellers wrote:
> 
> Note that we've been using CuTest in CIL, and it is very simple and easy to
> use. There's almost no spin up to using it.
> 

Try the ISPRAS api-sanity-autotest.pl (same people doing LSB testing).

There is zero spin-up to shallow testing using ISPRAS, and some modest thought
writing some XML templates can go a long ways towards reasonable
unit testing with significant coverage.

OTOH, if you truly need mocking with symbol replacemnet, well ... good luck! That's hard.

hth

733


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
