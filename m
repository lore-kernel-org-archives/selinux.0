Message-ID: <44EB02B3.5040100@tresys.com>
Date: Tue, 22 Aug 2006 09:12:19 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
References: <87mzabgyrk.fsf@rho.meyering.net>	<1155308294.8018.59.camel@localhost.localdomain>	<87irkzfcgr.fsf@rho.meyering.net>	<1155567404.23601.10.camel@localhost.localdomain>	<87ac67iaao.fsf@rho.meyering.net>	<1155571378.23601.32.camel@localhost.localdomain>	<873bbzi6c1.fsf@rho.meyering.net>	<1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>	<87wt929j25.fsf@rho.meyering.net> <1156182056.14126.91.camel@sgc> <87pset93nk.fsf@rho.meyering.net>
In-Reply-To: <87pset93nk.fsf@rho.meyering.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering wrote:
> "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
<snip>
>> Fscon has security implications.  For example, if the program fscon
>> exec's transitions to a different domain, either it would have to be
>> disallowed across a transition, or we would have to add a permission to
> 
> I understood that making fscon disallow a transition would be fine.
> Any cross-transition use could be achieved via runcon.
> 
>> allow it to work across transitions.  If a misbehaving program doesn't
>> clear its fscreate, then all its child programs will be broken by trying
>> to create programs in the wrong context, which would be common for the
>> non-transitioning exec() case.
>>
>> Fscon doesn't work for any program that isn't simple like coreutils
>> programs.
> 
> But there are many others that *would* benefit.
> 

You didn't respond to this and its probably the most important point. 
Being able to set your childrens fscreatecon is _dangerous_ and 
potentially affects robustness if a parent forgets to unset it before 
spawning children. Granted doing this across domain transitions can (and 
must) be protected by policy but within the same domain there is little 
that can be done. You'll risk making the filesystem inconsistent with this.

I honestly don't understand the problem here, these applications are 
simple and adding -Z (to be standard with every other selinux aware 
util) doesn't hurt anything. fscon is _not_ a better way to do this, its 
a hack that can only be used by coreutils because of the point above 
that any app of sufficient complexity will be writing files with 
different contexts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
