Date: Fri, 18 May 2001 09:12:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Sean Rolinson <snowdog@bigfoot.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: Problems compiling: SELinux 200104121417 on Alpha (config/flash.h: No such file or directory)
In-Reply-To: <010501c0df17$ee102050$24b8dcd1@hemisphere>
Message-ID: <Pine.SOL.3.95.1010518090235.12195C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 17 May 2001, Sean Rolinson wrote:

> I am having a problem compiling SELinux with a 2.4 kernel on an
> alpha.  I am using the complete downloaded package,
> slinux-200104121417-release.tgz (i.e. NOT the patches).

SELinux is not currently supported on the Alpha, although it should
not be difficult to port it to the Alpha.  If you grep for CONFIG_FLASK
under arch/i386, you'll see that some of changes are in the
architecture-specific files.  Also, there is some Alpha-specific
code in the execve system call that might require some Flask
changes, but that isn't clear.

> I then edited the file "include/linux/sched.h" and changed line 35
> FROM "#include <config/flask.h>" TO "#include <linux/flask/flask.h>".

These are two very different header files.  config/flask.h is
generated during the kernel configuration and defines the
various CONFIG_FLASK* options.  You don't have one because
arch/alpha/config.in doesn't include any Flask options, since
we don't currently support the Alpha (see arch/i386/config.in
for the Flask security mechanisms menu).  This option menu
should actually be moved into a separate config.in file
in a non-architecture-specific directory (e.g. flask/config.in)
since the options themselves are not architecture-specific
so that it can be sourced by any of the architecture-specific 
config.in files.

> Finally, I changed to the kernel root directory and typed "make" and
> it proceeded to compile the kernel with no additional errors. 

Since you didn't have a config/flask.h, none of the Flask options
were defined, so your "make" simply built an ordinary Linux kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
