Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New SuSE rules
Date: Thu, 1 Aug 2002 17:13:51 +0200
References: <200208010657.GAA28694@jazzband.ncsc.mil>
In-Reply-To: <200208010657.GAA28694@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020801151351.47F1E76BC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Aug 2002 08:59, Carsten Grohmann wrote:
> My new rule set for SuSE can be found under
> http://www.carstengrohmann.de/download/selinux/.
> This include additional rules for the getty_t, so that runs now fine with
> the suse mingetty.
> I am sorry, but this time the file README.suserules are only in german.
>
> Please mail me any comments, if it works fine, if there problems ....

Firstly try and avoid using file_type and domain if possible.  I really doubt 
that getty needs to be able to read everything under /proc/[0-9]* and stat 
every file or device on the file system.

I guess that it's doing some type of "lsof" operation, so some dontaudit 
would be in order.

What is /dev/blog?  It's not in Documentation/devices.txt in the kernel 
source...

> # Allow access to modules_object_t (lib/modules)
> allow initrc_t modules_object_t:dir { write remove_name };
> allow initrc_t modules_dep_t:file { unlink };

Why does initrc_t need to remove files from /lib/modules?  Perhaps a domain 
transition to update_modules_t is what you need...

> # Access to file_t (/opt)
> allow ldconfig_t file_t:dir { getattr read search };
> allow ldconfig_t file_t:{ file lnk_file } { getattr read };

You should never grant anything access to file_t.  The existance of file_t 
labelled objects indicates a deficiency in yout file_contexts.

> # Access to /dev/xconsole
> allow syslogd_t device_t:fifo_file { ioctl read write };

We need a better type for that pipe.

> # Access to /dev/tty10
> allow syslogd_t tty_device_t:chr_file { append ioctl };

Do you realise that anyone can kill the machine by pressing ^S on VC 10?

> file_type_auto_trans(ntpd_t, etc_t, etc_ntp_t)

Why does ntpd need to create files under /etc?  Must be a deficiency in the 
package.

> allow ntpd_t console_device_t:chr_file { read write };

My Debian package has the following patch to macros/global_macros.te to 
address that:
-allow $1_t console_device_t:chr_file rw_file_perms;
+allow $1_t { sysadm_tty_device_t console_device_t }:chr_file rw_file_perms;

> # Access to /proc/sys/kernel
> allow ntpd_t sysctl_kernel_t:dir { search };
> allow ntpd_t sysctl_kernel_t:file { read };

That's in my Debian package.

> # Access to /var
> allow ntpd_t var_t:dir { search };

That's in the daemon_domain macro, it should have worked without that.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
