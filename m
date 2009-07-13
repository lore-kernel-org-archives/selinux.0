Date: Mon, 13 Jul 2009 12:15:09 -0400
Subject: Re: [RFC] Install SELinux policies from rpm package header
From: Chad Sellers <csellers@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>, <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Paul Howarth <paul@city-fan.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-ID: <C680D5CD.A8AD7%csellers@tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E012CD8FB@exchange2.columbia.tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/10/09 4:26 PM, "Joshua Brindle" <jbrindle@tresys.com> wrote:

>> From: James Carter [mailto:jwcart2@tycho.nsa.gov]
>> 
>>> Its alot worse than that. What about files on backup
>> drives? Offline drives?
>>> transient files that will get relabeled to something inappropriate?
>>> I'm not confortable relabeling databases with potentially sensitive
>>> data to var_lib_t because mysql was uninstalled.
>>> 
>> 
>> The argument seems to be for removing the ability to remove modules.
>> It would be the roach motel style of policy management.
>> 
> 
> I like it, policies check in but don't check out. I haven't heard an
> argument about 1) how I'm crazy and wrong or 2) how to keep systems
> running as expected otherwise though.

There's certainly a case for leaving all policy installed. Policy is
configuration data, which RPM also leaves installed when removing packages.
We could easily treat policy the same.

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
