Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6H1x6rT002991
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 21:59:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6H1wfbx012028
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 01:58:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: file_contexts patch
Date: Sat, 17 Jul 2004 11:59:00 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au> <20040716224252.GD4940@obadja.jmh.mhn.de>
In-Reply-To: <20040716224252.GD4940@obadja.jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407171159.00489.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 17 Jul 2004 08:42, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > Why does kdesktop_lock need to be labelled as screensaver_exec_t?  The
> > problem that caused the creation of the screen saver policy has only been
> > reported under GNOME, and kdesktop_lock has been working well for me for
> > years without such policy.
>
> The screensaver policy has auth_chkpwd which is needed when locking the
> screen IIRC. The only problem is that kdesktop_lock doesn't use
> unix_chkpwd but has its own program (kcheckpass). I have labeled it
> chkpwd_exec_t which works fine, but unfortunately kcheckpass needs some
> additional permissions (from macros/program/chkpwd_macros.te):

kcheckpass should use PAM and therefore use unix_chkpwd.

> ifelse($1, `system', `', `allow $1_chkpwd_t $1_t:unix_stream_socket { read
> write };') # read KDesktop
> allow system_chkpwd_t $1_home_t:dir read;
> # write to .xsession-errors
> allow system_chkpwd_t $1_home_t:file write;
> (Or something like that. I live on NFS and just converted the rules)
>
> I do not know if this is mergable into mainline.

It's not something that we want to do if we can avoid it.

> > What is /dev/usbscanner?  It's not in devices.txt in the kernel source
> > and not installed by default on any Debian or Fedora system.
>
> Call it a SuSE oddity:
> # ls -l /dev/usbscanner /dev/usb/scanner0
> crw-rw----    1 root     root     180,  48 Sep  9  2002 /dev/usb/scanner0
> crw-r--r--    1 root     root     180,  48 Sep  9  2002 /dev/usbscanner
> (why they have different permissions there I can't imagine)

Could you file a bug report in the SUSE bug tracking system about this?

I suggest that you request that /dev/usbscanner become a sym-link 
to /dev/usb/scanner0.  Then it will match the devices.txt in the kernel 
source, have no problems with consistency of permissions, and not need any 
modifications to the SE Linux policy.

Maybe we should have a suse.te and suse.fc for such things?  One thing we want 
to avoid if possible is having entries in types.fc for distribution specific 
names which bloat types.fc and make setfiles run more slowly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
