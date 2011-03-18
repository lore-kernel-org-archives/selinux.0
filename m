Subject: Re: about ss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
References: <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Mar 2011 10:02:58 -0400
Message-ID: <1300456978.25429.29.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-18 at 08:43 +0800, Yao wrote:
> Hi, all
> I looked at linux-2.6.36/security/selinux/ss/*.c and found most source
> files include <linux/***.h>
> I know security server need to use some of kernel data structures.
> But does ss use kernel fuctions?
> Is it possible to modify security server and make it self-contained if
> ss used kernel function?

The original security server code was developed for another OS
(Fluke/Flask) and then ported to Linux.  There are a small number of
fundamental dependencies on the runtime environment, like memory
allocation, logging/auditing, locking, etc.  Over time, the security
server code in Linux has become increasingly "nativized" for Linux so
you may find further dependencies in the current code.

You'll find other forms of the security server code that may be more
portable in:
1) The SELinux userspace (http://userspace.selinuxproject.org)
In particular, a copy of the security server code lives in libsepol.
Originally there was a single code base shared between
checkpolicy/libsepol and the kernel, but this was forked when SELinux
went into mainline.

2) The OSKit (http://www.cs.utah.edu/flux/oskit/)
This was used in Fluke/Flask.  Security server is under security/, AVC
is in com/avc.c.

3) Various ports of SELinux to other systems
(http://www.nsa.gov/research/selinux/related.shtml)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
