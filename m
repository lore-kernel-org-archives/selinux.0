Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SG9URb005753
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 11:09:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0SG9T1I022483
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:09:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0SG9Sbs022479 for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:09:28 GMT
Subject: Re: Must SELinux have a initrd image and RAM disk when it boots
	up? and...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_2004@yahoo.com.cn>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040128155450.12205.qmail@web15207.mail.bjs.yahoo.com>
References: <20040128155450.12205.qmail@web15207.mail.bjs.yahoo.com>
Content-Type: text/plain
Message-Id: <1075306166.19427.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 11:09:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 10:54, Park Lee wrote:
>  and download 2.6.0-test11 kernel with SELinux patch applied and
> SELinux Full Userland Archive from NSA's SELinux web site.

I'd use 2.6.2-rc2 from kernel.org.  Or the Fedora Core development
kernel.

> When I configured the kernel,I have chosen the following options in
> the Block Devices :
>  <*> RAM disk support
>  (4096) Default RAM disk size
>  [*] Initial RAM disk (initrd) support

Try increasing the default ram disk size, e.g. to 8192.
CONFIG_BLK_DEV_RAM_SIZE=8192.
>  
>  and Must SELinux have a two boot-up 
> phase using a initrd RAM disk?

Not anymore.  The modified init program will load the policy from the
disk and then re-exec itself.
>  
> Thus, prelink-0.3.0-16.sel.src.rpm can't be done.
> Why? Is there some errors in it or in the Fedora core 1 system?

Odd; this worked for me.  If you can't build a patched prelink, then you
should disable prelink on your system.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
