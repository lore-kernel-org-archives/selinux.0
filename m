Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PL3RrT024909
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 17:03:27 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PL2Osn003994
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 21:02:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom London <selinux@gmail.com>
Subject: Re: hald - r/w access to /dev/usb/lp0?
Date: Sun, 26 Sep 2004 07:03:22 +1000
Cc: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <4c4ba153040925112714a5f9ac@mail.gmail.com> <200409260534.51592.russell@coker.com.au> <4c4ba15304092512542d749951@mail.gmail.com>
In-Reply-To: <4c4ba15304092512542d749951@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a0dVBtth8VKEBOe"
Message-Id: <200409260703.22135.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_a0dVBtth8VKEBOe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 26 Sep 2004 05:54, Tom London <selinux@gmail.com> wrote:
> Understand and agree about read access, but  the AVC
> shows it wanting write access as well.
>
> Your patch allows read/getattr/ioctl. but not write. I can certainly
> imagine a dialog protocol that would require both read and write,
> but I'm not certain if this is in fact used here.
>
> What do you think?

I think we should allow write as well, I've attached a new patch.

If it wanted write access to fixed_disk_device_t or something then we would 
have to look into it seriously.  But write to a printer doesn't seem so 
important and it's something that is needed for some status queries.

If hald ever goes as far as querying the paper size then it'll definitely need 
such access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_a0dVBtth8VKEBOe
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
+allow hald_t printer_device_t:chr_file rw_file_perms;
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)

--Boundary-00=_a0dVBtth8VKEBOe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
