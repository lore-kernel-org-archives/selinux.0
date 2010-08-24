Subject: Re: Enable selinux in SLES 11
From: Stephen Smalley <sds@tycho.nsa.gov>
To: imsand@puzzle.ch
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
	 <4C72A7CB.1020105@gmail.com>
	 <34832.193.5.216.100.1282634053.squirrel@mail.puzzle.ch>
	 <4C73C991.8020100@gmail.com>
	 <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 10:48:50 -0400
Message-ID: <1282661330.23429.50.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-24 at 16:09 +0200, imsand@puzzle.ch wrote:
> Unfortunately it doesn't work. I've done all steps described in here:
> http://thetoms-random-thoughts.blogspot.com/2008/12/selinux-on-opensuse-111.html
> but this doesn't seems to work for sles 11.
> Anybody out there, who was able to run selinux on sles 11?
> I've got some other questions?
>   * what happens if the policy is not found? what would sestatus report?
>   * are there some good debug options for selinux? logs? any other hints?
> (dmesg shows nothing related to selinux)

I've only seen successful reports of getting SELinux to run with
OpenSUSE 11.2 and later, and even that hasn't been trivial.  I haven't
seen any reports of getting it to work with SLES 11.  But you should ask
Novell about it.

If policy is not found, then sestatus will report disabled.  No policy
loaded is treated the same as SELinux disabled as far as userspace is
concerned.

Was SELinux built into your kernel?
$ grep selinux_init /proc/kallsyms
<some address>	t	selinux_init
<some address>	t	__initcall_selinux_init

Was SELinux enabled at boot?
$ dmesg | grep SELinux
SELinux:  Initializing.
SELinux:  Starting in permissive mode
...

Is SELinux enabled in the kernel?
$ grep selinuxfs /proc/filesystems

Do you have a policy installed under /etc/selinux/targeted?
$ ls -l /etc/selinux/targeted/policy

Was your policy loaded?
$ dmesg | grep SELinux
...
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
