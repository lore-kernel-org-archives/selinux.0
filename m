Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJJZPIi023242
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 14:35:26 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJJZSlF016304
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 19:35:28 GMT
Subject: Re: patch: misc policy additions
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Colin Walters <walters@verbum.org>, SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041110102439.GA2541@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de>
	 <1100046550.26388.8.camel@nexus.verbum.private>
	 <20041110102439.GA2541@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1100893088.31793.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 14:38:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  Except for the following chunk:

diff -urN orig/domains/program/restorecon.te mod/domains/program/restorecon.te
--- orig/domains/program/restorecon.te  2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/restorecon.te   2004-11-09 21:50:48.000000000 +0100
@@ -41,7 +41,7 @@
 allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
 allow restorecon_t unlabeled_t:dir read;
 allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfrom relabelto };
-allow restorecon_t { device_t device_type }:{ chr_file blk_file } { getattr relabelfrom relabelto };
+allow restorecon_t { device_t device_type ttyfile }:{ chr_file blk_file } { getattr relabelfrom relabelto };
 ifdef(`distro_redhat', `
 allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relabelfrom relabelto };
 ')

Why do you want to restorecon_t to relabel a ttyfile?  
The only contexts with the ttyfile attribute are user_tty_device_t,
staff_tty_device_t, and sysadm_tty_device_t.  The tty is relabeled to
these from an initial tty_device_t context, so the only thing that I see
this permission doing is to allow a current session to be relabeled from
one of these three contexts to tty_device_t.  Why would we want to do
that?

I noticed that the line above the one you want to change duplicates
permissions, so I removed it.

On Wed, 2004-11-10 at 05:24, Thomas Bleher wrote:
> * Colin Walters <walters@verbum.org> [2004-11-10 03:37]:
> > On Tue, 2004-11-09 at 22:04 +0100, Thomas Bleher wrote:
> > 
> > +ifdef(`distro_suse', `
> > +# because of libraries in /var/lib/samba/bin
> > +allow ldconfig_t { var_lib_t bin_t }:dir search;
> > +allow ldconfig_t var_lib_t:lnk_file read;
> > 
> > I know this is under distro_suse, but wouldn't it be better to label
> > these files as lib_t, and have that be ifdef(`distro_suse') in the
> > samba.fc?
> 
> You are right, the second line is not needed, all symlinks are labeled
> lib_t. I did not move it to samba.te because these are client libs,
> samba itself is not installed.
> 
> > -# read /proc/meminfo, /proc/self/mounts and /etc/mtab
> > -allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };
> > +# read /proc/meminfo, /proc/self/mounts, /etc/localtime and /etc/mtab
> > +allow nrpe_t { self proc_t etc_runtime_t locale_t }:file { getattr read };
> > 
> > The convention here seems to be: read_locale(nrpe_t)  That does allow
> > one to turn off reading of locale files in a centralized place.
> 
> OK, fixed.
> 
> Updated patch is attached.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
