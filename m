Subject: Re: Help: SELinux causing(?) boot failures...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: Paul Moore <paul.moore@hp.com>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <489C801E.9040306@kutulu.org>
References: <489C6A4F.3020704@kutulu.org>
	 <200808081251.45453.paul.moore@hp.com>  <489C801E.9040306@kutulu.org>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 12:58:13 -0400
Message-Id: <1218733093.29535.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-08 at 13:19 -0400, Mike Edenfield wrote:
> Paul Moore wrote:
> > On Friday 08 August 2008 11:46:23 am Mike Edenfield wrote:
> >> The reason I strongly suspect SELinux is the problem (or at least a
> >> major factor), is that adding "selinux=0" to my boot command line
> >> corrects the problem, and the system boots fine.  Everything appears
> >> to be installed and configured correctly, except obviously SELinux is
> >> now disabled.  The filesystems are all labeled correctly, and even on
> >> the failing boot the AVC messages display the correct labels, like
> >> tty_device_t and urandom_device_t.
> > 
> > Hi Mike,
> > 
> > In general, you are better off using "enforcing=0", which keeps SELinux 
> > enabled but puts it into permissive mode, on the kernel command line 
> > instead of "selinux=0", which disables SELinux entirely.  Have you 
> > tried rebooting with "enforcing=0" and capturing the AVC messages from 
> > the console/audit/syslog output and seeing if anything looks awry?  If 
> > not go ahead and do so and send them to the list, this will tell us 
> > what actions are being denied and why.
> 
> I have SELinux configured for permissive mode to begin with, but I tried 
> adding "enforcing=0" to the boot command line to no effect. Here are the 
> denials I am getting:

Hmmm...do you have CONFIG_SECURITY_SELINUX_DEVELOP=y in your
kernel .config file?  If not, your kernel won't support permissive mode
at all and will always be in enforcing mode.

> 
> (transcribed by hand since neither syslog nor auditd are starting)
> 
> avc: denied { execute_no_trans } for pid=1 comm="init" path="/sbin/init" 
> dev=sda3 ino=920038 scontext=system_u:system_r:kernel_t 
> tcontext=system_u:object_r:file_t tclass=file

So your filesystem is not labeled at all.

Are you sure you followed the steps in the Hardened Gentoo SELinux
guide?  And have you sent any email to the gentoo-hardened list about
this, as you'll get Gentoo-specific help there?

> avc: denied { read } for pid=1 comm="init" name="ld-linux.so.2" dev=sda3 
> ino=1785880 scontext=system_u:system_r:kernel_t 
> tcontext=system_u:object_r:file_t tclass=lnk_file
> avc: denied { getattr } for pid=1 comm="init" path="/etc/ld.so.cache" 
> dev=sda3 ino=1090186 scontext=system_u:system_r:kernel_t 
> tcontext=system_t:object_r:file_t tclass=file
> avc: denied { read } for pid=1 comm="init" name="udanrom" dev=sda3 
> ino=126002 scontext=system_u:system_r:kernel_t 
> tcontext=system_u:object_r:urandom_device_t tclass=chr_file
> avc: denied { getattr } for pid=1 comm="init" name="/" dev=selinuxfs 
> ino=1 scontext=system_u:system_r:kernel_t 
> tcontext=system_t:object_r:security_t tclass=filesystem
> avc: denied { read write } for pid=1 comm="init" name="tty0" dev=sda3 
> ino=126327 scontext=system_u:system_r:kernel_t 
> tcontext=system_u:object_r:tty_device_t tclass=chr_file
> 
> 
> There are apparently a lot of the latter since I usually get a message 
> that printk is supressing several dozen messages at this point, then I 
> get no more AVC's on the console.
> 
> 
> Thanks,
> 
> --Mike
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
