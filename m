Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6HJrSrT005352
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 15:53:38 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6HJrQRh007699
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 19:53:27 GMT
Received: from bern.cip.ifi.lmu.de (bern.cip.informatik.uni-muenchen.de [141.84.214.132])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 26A8543571
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 21:53:27 +0200 (CEST)
Date: Sat, 17 Jul 2004 21:53:26 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: file_contexts patch
Message-ID: <20040717195326.GA16762@bern.cip.ifi.lmu.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au> <20040716224252.GD4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <200407171159.00489.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

* Russell Coker <russell@coker.com.au> [2004-07-17 05:16]:
> On Sat, 17 Jul 2004 08:42, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > > Why does kdesktop_lock need to be labelled as screensaver_exec_t?  The
> > > problem that caused the creation of the screen saver policy has only been
> > > reported under GNOME, and kdesktop_lock has been working well for me for
> > > years without such policy.
> >
> > The screensaver policy has auth_chkpwd which is needed when locking the
> > screen IIRC. The only problem is that kdesktop_lock doesn't use
> > unix_chkpwd but has its own program (kcheckpass). I have labeled it
> > chkpwd_exec_t which works fine, but unfortunately kcheckpass needs some
> > additional permissions (from macros/program/chkpwd_macros.te):
> 
> kcheckpass should use PAM and therefore use unix_chkpwd.

Doh. Of course you are right. I checked again and kcheckpass does the
right thing and calls PAM but the SuSE PAM implementation doesn't use
unix_chkpwd yet.
So you can dismiss that part of my patch.

> > > What is /dev/usbscanner?  It's not in devices.txt in the kernel source
> > > and not installed by default on any Debian or Fedora system.
> >
> > Call it a SuSE oddity:
> > # ls -l /dev/usbscanner /dev/usb/scanner0
> > crw-rw----    1 root     root     180,  48 Sep  9  2002 /dev/usb/scanner0
> > crw-r--r--    1 root     root     180,  48 Sep  9  2002 /dev/usbscanner
> > (why they have different permissions there I can't imagine)
> 
> Could you file a bug report in the SUSE bug tracking system about this?

Done.
 
> Maybe we should have a suse.te and suse.fc for such things?  One thing we want 
> to avoid if possible is having entries in types.fc for distribution specific 
> names which bloat types.fc and make setfiles run more slowly.

I think this is a good idea. I have a few other policy snippets which
are needed on SuSE but won't be suitable for general policy.
As a start, I have attached a small suse.te and suse.fc.
Can this be included in CVS?

Thomas

PS: Thanks for your feedback and advise!

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="suse.te"

# DESC: SuSE-specific policy
#
# Author: Thomas Bleher <ThomasBleher@gmx.de>
#
# Note: For many of these permissions it would be better to change the scripts

# policy for cron
# ===============
create_dir_file(system_crond_t, tetex_data_t)

# backup of the rpm-database (/var/backup...)
allow system_crond_t var_t:dir { add_name remove_name write };
allow system_crond_t var_t:file { create unlink write };

# policy for initrc
# =================
# move /var/log/boot.msg
allow initrc_t var_log_t:dir { add_name remove_name write };
# /usr/sbin/zic wants to link /etc/localtime
allow initrc_t locale_t:file { link unlink };
# for /tmp/.X11-unix and so on (see /etc/init.d/boot.localnet)
allow initrc_t { xdm_xserver_tmp_t tmp_t }:dir { setattr };

# other stuff
# ===========
# gpg (when called from rpm) wants this so it doesn't dump core on errors
allow rpm_t self:process setrlimit;

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="suse.fc"

# suse specific file_contexts

/var/lib/samba/bin(/.*)?                                system_u:object_r:bin_t
/var/lib/samba/bin/.*\.so(\.[^/]*)*             -l      system_u:object_r:lib_t
/usr/lib/samba/classic/.*                       --      system_u:object_r:bin_t
/usr/lib/samba/classic/[^/]*\.so(\.[^/]*)*      --      system_u:object_r:shlib_t

/u?dev/usbscanner	-c	system_u:object_r:scanner_device_t

# suse puts shell scripts there :-(
/usr/share/apache2/.*  --      system_u:object_r:bin_t

--rwEMma7ioTxnRzrJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
