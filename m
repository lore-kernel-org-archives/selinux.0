Subject: Re: SELinux Policy Editor and CAP_SYS_BOOT
From: Nick <nick-lists@austin.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1105645883.24406.147.camel@moss-spartans.epoch.ncsc.mil>
References: <1105645034.32758.35.camel@hawaii.efficax.net>
	 <1105645883.24406.147.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 14:57:48 -0600
Message-Id: <1105649868.32758.58.camel@hawaii.efficax.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 14:51 -0500, Stephen Smalley wrote:
> On Thu, 2005-01-13 at 14:37, Nick wrote:
> > I have the need to enable (and make work) the shutdown and halt
> > accounts. I set a password for these accounts and tried to use them and
> > got the expected "you must be root" a collegue pointed out that I might
> > need the CAP_SYS_BOOT capability turned on. After an hour of Googling on
> > something that relates to CAP_SYS_BOOT and makes sense within the
> > context of SELinux.

> And the purpose of these accounts is what?  Console user can already
> shutdown via consolehelper.

The purpose of the built-in halt and shutdown accounts were originally
to give someone, you trust enough to be able to know when to shutdown
the system, but not enough to let him login, the ability to shut down a
server. A secondary function of these was a remote shutdown that didn't
require any thought on the users part! You gave him/her the password and
said, "If you need to shut the machine down for any reason, telnet into
the machine with "this" account and it will shut itself down. In this
manner, you didn't have to give the user physical access to the server.

Console helper is new to me, but it sounds like it might perform the
same function, Thanks

> To use the capability, you must pass both the Linux check (i.e. have uid
> 0) and the SELinux check (i.e. your domain must have an allow xxx_t
> self:capability sys_boot;).  What identity are these accounts assigned? 
> Do they even work with SELinux in permissive mode?  If not, then your
> issue isn't SELinux-related.  Otherwise, you would need to define a role
> and domain with the necessary permissions, and define the accounts in
> policy/users with the corresponding role.

No, I don't think it is SELinux related per se, I was thinking that
perhaps this had been addressed as part of SELinux since the
capabilities are a security oriented feature that allow root accesses to
ordinary users. It would be a good idea to wrap this in some sort of
protection. I am not sure how widely used this is. If you do a man on
"capabilities" you will find some info, but not really enough to get you
going. There are a couple instructions which form a sort of API, but
that is it. Apparently LinSec makes use of it.

The problem with posting things to the fedora list is most users there
are still trying to get their CD to work or solve a video card problem.
The volume of traffic is so high that that you lose any response to a
message within a day without a search. Since the level of competency is
so much higher here, I think that security related issues, particularly
the ones we would like to see addressed by SELinux would be appropriate
to the list. 

> > I came up with a reference in the old SELinux Policy Editor page that
> > indicates you could set a "boot system call" check-box
> > To check this allows the current domain to use the "reboot" system call.
> > This corresponds to the capability "CAP_SYS_BOOT" in Linux system.
> > 
> > The page also go on to say that SELinux Policy Editor is for 2.4 Kernel
> > only ...
> 
> Is that the Hitachi policy tool?  I've heard about it, but never looked
> at it.

Yes the link is http://www.selinux.hitachi-sk.co.jp/en/tool/selpe/selpe-
top.html

>   But even that wouldn't change the fact that you need to define a
> role/domain for these accounts.

Understood


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
