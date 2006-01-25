Message-ID: <1338.128.253.53.144.1138205270.squirrel@webmail.cornell.edu>
In-Reply-To: <1138020746.20815.21.camel@moss-spartans.epoch.ncsc.mil>
References: <43D1737F.6010002@cornell.edu>
    <1138020746.20815.21.camel@moss-spartans.epoch.ncsc.mil>
Date: Wed, 25 Jan 2006 11:07:50 -0500 (EST)
Subject: Re: [SEMANAGE] Rename seuser -> seuser_local
From: "Ivan Valeriev Gyurdiev" <ivg2@cornell.edu>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Ivan Gyurdiev" <ivg2@cornell.edu>, "SELinux List" <selinux@tycho.nsa.gov>,
   "Joshua Brindle" <jbrindle@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 2006-01-20 at 16:34 -0700, Ivan Gyurdiev wrote:
>> Seuser functions and dbase have incorrect names, since originally I did
>> not think we'd have seusers.system. I must have asked about this, but
>> regardless, I now think that a systems file will likely be necessary, so
>> this patch renames all seuser-related things to _local, which leaves
>> space for a _policy set of functions. It updates dependencies and
>> manpages. This is an API change.
>>
>> I think we should add users_extra.system and seusers.system into the
>> package format.
>
> Sorry, what is the motivation for this change, i.e. what is the system
> seusers file for?

That will allow us to configure per-policy defaults for certain users like
root, __default__. We could also configure more restricted SELinux users
for certain "system" users like daemon users,or things like a guest
account. It seems wrong to hardcode those defaults into the libselinux
library rather than policy.

Sorry for the late reply, I'm in the middle of moving to Cornell, and
switching to a PCI-E x86_64 computer - might have limited mail access for
the next few days.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
