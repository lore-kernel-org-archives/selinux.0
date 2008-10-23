Message-ID: <4900B461.7090509@redhat.com>
Date: Thu, 23 Oct 2008 13:29:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: LC Bruzenak <lenny@MagitekLtd.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: semanage help
References: <1224727612.14755.244.camel@homeserver>	 <1224766402.28867.4.camel@moss-spartans.epoch.ncsc.mil>	 <4900A0C8.9050200@redhat.com>	 <1224779343.28867.60.camel@moss-spartans.epoch.ncsc.mil>	 <4900B01C.4070206@redhat.com> <1224782298.14755.267.camel@homeserver>
In-Reply-To: <1224782298.14755.267.camel@homeserver>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

LC Bruzenak wrote:
> On Thu, 2008-10-23 at 13:10 -0400, Daniel J Walsh wrote:
> ...
>> On Rawhide it seems to work
>>
>> # /usr/sbin/semanage fcontext -a -t prelude_spool_t -r s0:c0.c1023
>> '/var/spool/prelude(/.*)?'
>> # restorecon -R -v /var/spool/prelude/
>> restorecon reset /var/spool/prelude context
>> system_u:object_r:prelude_spool_t:s0->system_u:object_r:prelude_spool_t:s0:c0.c1023
>>
>>
>> So I will patch policycoreutils.
>>
> 
> Thanks Dan!
> 
> LCB.
> 
Of course this is totally not intuitive to the user.

He really wants to modify and existing fcontext so he needs to add a new
conflicting one.

This command should really be fixed to check if an exising global or
local exist,

if a local exists it should modify if a global exists it should add.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
