Message-Id: <200208011824.SAA28460@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New SuSE rules
Date: Thu, 1 Aug 2002 20:22:42 +0200
References: <200208010657.GAA28694@jazzband.ncsc.mil> <20020801151351.47F1E76BC@lyta.coker.com.au>
In-Reply-To: <20020801151351.47F1E76BC@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Donnerstag, 1. August 2002 17:13 schrieb Russell Coker:
> Firstly try and avoid using file_type and domain if possible.  I really
> doubt that getty needs to be able to read everything under /proc/[0-9]*
> and stat every file or device on the file system.

It's a problem with SuSE's mingetty. It reads all or the most /proc/<PID> 
directories and all files in /var/log. So I have to add this rules. I wrote 
to SuSE to change the mingetty program. On the other side, you can use Red 
Hat's mingetty, with runs fine without this additional rules. 

> I guess that it's doing some type of "lsof" operation, so some dontaudit
> would be in order.

It is not possible to deny this operations, because mingetty will not work 
correct.

> What is /dev/blog?  It's not in Documentation/devices.txt in the kernel
> source...

The blod daemon is an part of the SuSE boot concept. 

> > # Allow access to modules_object_t (lib/modules)
> > allow initrc_t modules_object_t:dir { write remove_name };
> > allow initrc_t modules_dep_t:file { unlink };
>
> Why does initrc_t need to remove files from /lib/modules?  Perhaps a
> domain transition to update_modules_t is what you need...

I can not change the domain, because the boot script (/etc/init.d/boot) 
remove /lib/modules/'uname -r'/modules.dep. I see not a possibility to do a 
domain transition for this -- it is a shell script with an rm in it.

> > # Access to file_t (/opt)
> > allow ldconfig_t file_t:dir { getattr read search };
> > allow ldconfig_t file_t:{ file lnk_file } { getattr read };
>
> You should never grant anything access to file_t.  The existance of
> file_t labelled objects indicates a deficiency in yout file_contexts.

The NSA distribution have not a type for /opt. Next days I will send a 
patch to correct this.

> > # Access to /dev/xconsole
> > allow syslogd_t device_t:fifo_file { ioctl read write };
>
> We need a better type for that pipe.

Done. I label it as devlog_t. 

> > # Access to /dev/tty10
> > allow syslogd_t tty_device_t:chr_file { append ioctl };
>
> Do you realise that anyone can kill the machine by pressing ^S on VC 10?

No this was me unknown. Could it be that this problem not selinux specific? 
I don't no any solution. Have you disabled the log messages on tty10? 

> > file_type_auto_trans(ntpd_t, etc_t, etc_ntp_t)
>
> Why does ntpd need to create files under /etc?  Must be a deficiency in
> the package.

On SuSE: Under /etc are the ntpd configuration file and ntp.dift.

Thanks for your comment

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
