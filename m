Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New SuSE rules
Date: Thu, 1 Aug 2002 21:56:18 +0200
References: <200208010657.GAA28694@jazzband.ncsc.mil> <20020801151351.47F1E76BC@lyta.coker.com.au> <20020801182445.4897EFA93@ivanova.coker.com.au>
In-Reply-To: <20020801182445.4897EFA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020801195618.D8D9D76C7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Aug 2002 20:22, Carsten Grohmann wrote:
> Am Donnerstag, 1. August 2002 17:13 schrieb Russell Coker:
> > Firstly try and avoid using file_type and domain if possible.  I really
> > doubt that getty needs to be able to read everything under /proc/[0-9]*
> > and stat every file or device on the file system.
>
> It's a problem with SuSE's mingetty. It reads all or the most /proc/<PID>
> directories and all files in /var/log. So I have to add this rules. I wrote

Just because a program tries something does not mean that it needs to do it.  
For example I have added many dontaudit rules for sysadm_home_dir_t 
(sysadm_home_t for the NSA policy) because of daemons that try to access 
files or directories under /root and have no need to do so.

Any domain that runs "ps" will request access to all of /proc/[0-9]*.  The 
only domain that needs such access is sysadm_t to allow the administrator to 
see what's running.

There is no way that mingetty could require access to ps data on all domains, 
it may require access to all userdomain, but definately not domain!

Why should a getty know anything about a dhcp server, BIND, or a mail server?

> to SuSE to change the mingetty program. On the other side, you can use Red
> Hat's mingetty, with runs fine without this additional rules.

Can you email me the source and binary of this SuSe mingetty, I'll look into 
it and determine what it really needs (or how to fix it).

> > I guess that it's doing some type of "lsof" operation, so some dontaudit
> > would be in order.
>
> It is not possible to deny this operations, because mingetty will not work
> correct.

How does it fail?

> > What is /dev/blog?  It's not in Documentation/devices.txt in the kernel
> > source...
>
> The blod daemon is an part of the SuSE boot concept.

How does it work?  What does it do?

> > > # Allow access to modules_object_t (lib/modules)
> > > allow initrc_t modules_object_t:dir { write remove_name };
> > > allow initrc_t modules_dep_t:file { unlink };
> >
> > Why does initrc_t need to remove files from /lib/modules?  Perhaps a
> > domain transition to update_modules_t is what you need...
>
> I can not change the domain, because the boot script (/etc/init.d/boot)
> remove /lib/modules/'uname -r'/modules.dep. I see not a possibility to do a
> domain transition for this -- it is a shell script with an rm in it.

Why not just have your rpm package of SE Linux replace that shell script with 
another one that does it differently?  Surely RPM has some equivalent to the 
diversion mechanism I use in some of my Debian packages...

> > > # Access to file_t (/opt)
> > > allow ldconfig_t file_t:dir { getattr read search };
> > > allow ldconfig_t file_t:{ file lnk_file } { getattr read };
> >
> > You should never grant anything access to file_t.  The existance of
> > file_t labelled objects indicates a deficiency in yout file_contexts.
>
> The NSA distribution have not a type for /opt. Next days I will send a
> patch to correct this.

I suggest making opt root_t as it's likely to be the root of a different file 
system (and it's not something you'll restrict access to unless you're 
restricting access to the root directory).  Then have rules labelling 
/opt/.*/bin(|/.*) bin_t, etc.

> > > # Access to /dev/xconsole
> > > allow syslogd_t device_t:fifo_file { ioctl read write };
> >
> > We need a better type for that pipe.
>
> Done. I label it as devlog_t.

I'm not sure if that's a good idea.  The sock_file vs fifo_file distinction 
will allow you to suitably lock it down, but there may be confusion among 
administrators as to what to do.

> > > # Access to /dev/tty10
> > > allow syslogd_t tty_device_t:chr_file { append ioctl };
> >
> > Do you realise that anyone can kill the machine by pressing ^S on VC 10?
>
> No this was me unknown. Could it be that this problem not selinux specific?
> I don't no any solution. Have you disabled the log messages on tty10?

It's not a SE Linux issue.  I noticed the problem years ago on Debian and 
AFAIK all distributions have always had it.  I just don't enable logging to a 
VC unless you have a moderate amount of trust that the local users aren't 
malicious or careless enough to do it.  If you press ^S the write buffers 
eventually fill up, syslogd stops accepting logs, and then everything that 
tries to log will not work.  Logging in does an log write and therefore you 
can't login to a machine in such a state.

> > > file_type_auto_trans(ntpd_t, etc_t, etc_ntp_t)
> >
> > Why does ntpd need to create files under /etc?  Must be a deficiency in
> > the package.
>
> On SuSE: Under /etc are the ntpd configuration file and ntp.dift.

They should change it to be under /var/lib.  /etc is for configuration files 
not for data files that are always changing.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
