Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01058
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 13:38:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA14831
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:37:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA14827 for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:37:05 GMT
Date: Mon, 29 Jul 2002 13:37:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Menon, Sunanda R" <sunanda.r.menon@intel.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: building the kernel
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0F2F05CF@orsmsx108.jf.intel.com>
Message-ID: <Pine.GSO.4.33.0207291334150.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Jul 2002, Menon, Sunanda R wrote:

> I downloaded 2.4 LSM based SE linux( Option 1 everything in one part),
> unzipped into SELinux directory in Redhat 6.2 Linux.
>  I went thru the "Building kernel" part of the documentation. When I do the
> "make menuconfig", I am getting th efollowing error:
> /bin/sh scripts/menuconfig arch/i386/config.in
> :commnad not found
> :command not found
> :command not found
> scripts/menuconfig:syntax error on line 104:  'unexpected token {
>
> Does anyone know what is the cause of this problem?

No, I can't reproduce this error - 'make menuconfig' works fine on a clean
copy of the 2002070313 release from www.nsa.gov/selinux.  Did the 'make
insert' in selinux/module succeed without any errors?

Do you see the same error on a 'make menuconfig' of a clean Linux kernel
from www.kernel.org?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
