Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA01348
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 14:02:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA16244
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 18:01:15 GMT
Received: from mail2.hd.intel.com (hdfdns02.hd.intel.com [192.52.58.11])
        by jazzband.ncsc.mil  with ESMTP id SAA16240 for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 18:01:14 GMT
Received: from fmsmsxvs041.fm.intel.com (fmsmsxvs041.fm.intel.com [132.233.42.126])
	by mail2.hd.intel.com (8.11.6/8.11.6/d: solo.mc,v 1.42 2002/05/23 22:21:11 root Exp $) with SMTP id g6TI2jE27521
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 18:02:46 GMT
Message-ID: <D9223EB959A5D511A98F00508B68C20C0F2F05D0@orsmsx108.jf.intel.com>
From: "Menon, Sunanda R" <sunanda.r.menon@intel.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: building the kernel
Date: Mon, 29 Jul 2002 11:02:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, "make insert" succeeded. I am using the 2002070313 release from
www.nsa.gov/selinux.
I haven't tried "make menuconfig" of a clean linux kernel from
www.kernel.org.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Monday, July 29, 2002 10:38 AM
To: Menon, Sunanda R
Cc: 'selinux@tycho.nsa.gov'
Subject: Re: building the kernel



On Mon, 29 Jul 2002, Menon, Sunanda R wrote:

> I downloaded 2.4 LSM based SE linux( Option 1 everything in one part),
> unzipped into SELinux directory in Redhat 6.2 Linux.
>  I went thru the "Building kernel" part of the documentation. When I do
the
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
