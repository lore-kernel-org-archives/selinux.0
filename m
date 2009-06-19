Message-ID: <4A3BCB2F.908@manicmethod.com>
Date: Fri, 19 Jun 2009 13:30:23 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: chcat fixes
References: <C639DAB6.A73D6%csellers@tresys.com> <4A154566.3090006@redhat.com>
In-Reply-To: <4A154566.3090006@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 05/20/2009 04:05 PM, Chad Sellers wrote:
>> On 5/20/09 3:00 PM, "Daniel J Walsh"<dwalsh@redhat.com> wrote:
>>
>>> Expansion of categores is still broken. Here is a patch to fix.
>>>

Its a shame that we are still hard coding the format for categories into tools, 
we might as well have hardcoded the format into the security server.

Stephen - any chance we could get selinuxfs interfaces that export 
level/category data so that tools can use that instead of hardcoding this stuff?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
