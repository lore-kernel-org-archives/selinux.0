Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PJZ0rT024690
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 15:35:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PJXvsn002929
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 19:33:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, Tom London <selinux@gmail.com>
Subject: Re: hald - r/w access to /dev/usb/lp0?
Date: Sun, 26 Sep 2004 05:34:51 +1000
References: <4c4ba153040925112714a5f9ac@mail.gmail.com>
In-Reply-To: <4c4ba153040925112714a5f9ac@mail.gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bhcVBeqYSdYX03h"
Message-Id: <200409260534.51592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_bhcVBeqYSdYX03h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 26 Sep 2004 04:27, Tom London <selinux@gmail.com> wrote:
> When haldaemon starts, and typically just after the text 'login:'
> appears but before the graphical stuff takes over, I get:
>
> Sep 25 10:28:57 fedora kernel: audit(1096133337.944:0): avc:  denied
> { read write } for  pid=3187 exe=/usr/sbin/hald name=lp0 dev=tmpfs
> ino=5073 scontext=system_u:system_r:hald_t
> tcontext=system_u:object_r:printer_device_t tclass=chr_file
>
> referring to /dev/usb/lp0.
>
> Does hald need read/write access to the printer_device?

Does hald need it right now?  Probably, but I'm not sure.

Will it need such access in the future to perform the tasks that it is 
designed for?  Definitely!  There is a lot of variation among printer 
hardware and hald is the correct program to inform you of what type of 
printer you have just connected.  I've attached a patch to add the access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bhcVBeqYSdYX03h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-24 06:31:21.000000000 +1000
+++ domains/program/unused/hald.te	2004-09-26 05:32:06.000000000 +1000
@@ -38,6 +38,7 @@
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
+allow hald_t printer_device_t:chr_file { getattr read ioctl };
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)

--Boundary-00=_bhcVBeqYSdYX03h--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
