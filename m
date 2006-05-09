Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0605081947400.19850@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605071136100.8588@d.namei>
	 <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0605081947400.19850@d.namei>
Content-Type: text/plain
Date: Tue, 09 May 2006 07:28:58 -0400
Message-Id: <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 19:53 -0400, James Morris wrote:
> On Mon, 8 May 2006, Stephen Smalley wrote:
> 
> > Should we provide alternative ways of specifying the initial value for
> > selinux_compat_net as well, as we do with checkreqprot (it can be
> > initialized via kernel config option or via boot parameter as well as
> > modified via selinuxfs)?  That way a distribution can choose to build
> > with compatibility enabled by default without patching, and users can
> > boot a kernel with a particular mode of operation if desired.
> 
> It doesn't seem warranted as a boot option and/or kernel config option as 
> the desired behavior can be trivially selected during early boot.

I was thinking it would be helpful for distributions (example:  Fedora
Core 4 and 5 re-base to 2.6.18, want the compatibility mode enabled by
default, do not wish to update/add some new userspace component to
trigger the compatibility mode).   And also for users to deal with
mismatches between their kernels and userlands (example:  kernel
developer using Fedora Core 5 as his development platform builds an
upstream kernel and boots it, but FC5 userland has no knowledge of
either the new checks or the compatibility mode, so it would be nice if
he could enable the compatibility mode in his kernel config or select it
trivially via boot param).  But I have no strong opinion; if no one else
thinks it is necessary, that is fine.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
