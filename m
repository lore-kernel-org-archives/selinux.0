Subject: Re: installing SELinux on Trustix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christof Rath <rath@sbox.tu-graz.ac.at>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <000801c303a8$4622a310$3700a8c0@wind>
References: <000801c303a8$4622a310$3700a8c0@wind>
Content-Type: text/plain
Message-Id: <1050508220.1143.21.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Apr 2003 11:50:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-15 at 19:39, Christof Rath wrote:
> avc: denied { getattr } for pid=1 exe=/sbin/init path=/dev/initctl
> dev=08:07 ino=22610 scontext=system_u:system_r:kernel_t
> tcontext=system_u:objecr_r:file_t tclass=fifo_file
>  
> avc: denied { read } for pid=8 exe=/sbin/init path=/bin/sh dev=08:07
> ino=55138 scontext=system_u:system_r:kernel_t
> tcontext=system_u:objecr_r:file_t tclass=lnk_file
> [snip]

The above messages suggest that you did not label your filesystems prior
to booting the SELinux kernel.  This makes sense if the quickinstall
aborted without completing.

> and some more of them and at the end I got a list of 
>  
> [snip]
> INIT: cannot execute "/sbin/mingetty" 
> INIT: cannot execute "/sbin/mingetty" 
> INIT: cannot execute "/sbin/mingetty"
> [snip]

Did you configure your kernel with CONFIG_SECURITY_SELINUX_DEVELOP=y
(NSA SELinux Development Support), as per the README instructions?  It
sounds like you did not enable this option and are booting an enforcing
kernel, which isn't going to work without having labeled the filesystem
(and may not work anyway, as the example policy may not cover everything
you need for your system to operate, especially if you are just using
the core policy and haven't enabled any optional policy modules).  You
should build the kernel with the development option and boot it in
permissive mode (the default) initially so that you can address any
policy configuration issues and then transition to an enforcing kernel. 
> I hope someone can tell me a solution...

Boot with your old kernel and follow the step-by-step instructions for
installing SELinux, since the quickinstall aborted for you.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
