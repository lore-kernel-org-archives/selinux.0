Subject: Re: SELinux Policy Editor and CAP_SYS_BOOT
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick <nick-lists@austin.rr.com>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1105645034.32758.35.camel@hawaii.efficax.net>
References: <1105645034.32758.35.camel@hawaii.efficax.net>
Content-Type: text/plain
Message-Id: <1105645883.24406.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 14:51:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 14:37, Nick wrote:
> I have the need to enable (and make work) the shutdown and halt
> accounts. I set a password for these accounts and tried to use them and
> got the expected "you must be root" a collegue pointed out that I might
> need the CAP_SYS_BOOT capability turned on. After an hour of Googling on
> something that relates to CAP_SYS_BOOT and makes sense within the
> context of SELinux.

And the purpose of these accounts is what?  Console user can already
shutdown via consolehelper.

To use the capability, you must pass both the Linux check (i.e. have uid
0) and the SELinux check (i.e. your domain must have an allow xxx_t
self:capability sys_boot;).  What identity are these accounts assigned? 
Do they even work with SELinux in permissive mode?  If not, then your
issue isn't SELinux-related.  Otherwise, you would need to define a role
and domain with the necessary permissions, and define the accounts in
policy/users with the corresponding role.
 
> I came up with a reference in the old SELinux Policy Editor page that
> indicates you could set a "boot system call" check-box
> To check this allows the current domain to use the "reboot" system call.
> This corresponds to the capability "CAP_SYS_BOOT" in Linux system.
> 
> The page also go on to say that SELinux Policy Editor is for 2.4 Kernel
> only ...

Is that the Hitachi policy tool?  I've heard about it, but never looked
at it.  But even that wouldn't change the fact that you need to define a
role/domain for these accounts.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
