Message-ID: <50536933.8030009@tresys.com>
Date: Fri, 14 Sep 2012 13:28:19 -0400
From: Pat McClory <pmcclory@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <eparis@redhat.com>, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils build failure
References: <50535A56.2010209@tresys.com> <1347641987.11029.65.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347641987.11029.65.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

yes, that works for me.  however just running 'make' (no install) 
doesn't, for the same reason.

looking at the policycoreutils/po/Makefile I see that the 'all' target 
has 'update-po' as a dependency, while 'install' does not.  When I try 
to run 'make update-po' in policycoreutils/po I see the same issue.

pat mcclory
On 09/14/2012 12:59 PM, Stephen Smalley wrote:
> On Fri, 2012-09-14 at 12:24 -0400, Pat McClory wrote:
>> Hi Eric,
>>
>> I tried to build your latest upstream push, and I'm having trouble
>> building policycoreutils:
>>
>> make[1]: Entering directory `/home/pmcclory/selinux/policycoreutils/po'
>> make[1]: *** No rule to make target `../gui/selinux.tbl', needed by
>> `policycoreutils.pot'.  Stop.
>> make[1]: Leaving directory `/home/pmcclory/selinux/policycoreutils/po'
>> make: *** [all] Error 1
>>
>> it looks like policycoreutils/gui/selinux.tbl is added in commit
>> f237aac4506e398367575319e7c0e7741ff7bce0 in the queue branch, but isn't
>> in master.
>
> Did you clean your tree first?  Try a git clean -fdx and then building.
> Works for me.
>
> cd selinux
> git clean -fdx
> make DESTDIR=~/obj install
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
