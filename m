Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UKh3rT007916
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:43:03 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UKgEAE021735
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 20:42:14 GMT
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Tom London <selinux@comcast.net>, russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <41323421.7050904@comcast.net>
References: <4130CF1B.3090909@comcast.net>
	 <200408291737.17497.russell@coker.com.au>  <41323421.7050904@comcast.net>
Content-Type: text/plain
Message-Id: <1093898533.3227.28.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 30 Aug 2004 16:42:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Russell and Tom.  Merged into sourceforge policy using
r_dir_file() for selinux_config_t, file_context_t, and
default_context_t.

Showing only the part changed from Russell's patch:

--- domains/program/unused/udev.te	27 Aug 2004 13:14:05 -0000	1.17
+++ domains/program/unused/udev.te	30 Aug 2004 19:36:44 -0000
@@ -32,19 +31,19 @@
 allow udev_t device_t:blk_file create_file_perms;
 allow udev_t device_t:chr_file create_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
-allow udev_t etc_t:file { getattr read execute };
+allow udev_t device_t:lnk_file create_lnk_perms;
+allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
-can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
+allow udev_t bin_t:lnk_file read;
+can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
 can_exec(udev_t, udev_exec_t)
-can_exec(udev_t, hostname_exec_t)
-can_exec(udev_t, iptables_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
-# to read the file_contexts file?
-r_dir_file(udev_t, policy_config_t)
+# to read the file_contexts file
+r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };

On Sun, 2004-08-29 at 15:53, Tom London wrote:
> Russell,
> 
> The following changes to udev.te seem needed....
> (If udev shouldn't be reading file_contexts, then dontaudit?)
> 
> Please correct/improve,
>    tom
> 
> --- /tmp/patches/udev.te        2004-08-29 11:35:48.000000000 -0700
> +++ udev.te     2004-08-29 12:40:58.000000000 -0700
> @@ -44,7 +44,9 @@
> 
>  # to read the file_contexts file
>  allow udev_t { selinux_config_t default_context_t }:dir search;
> -allow udev_t default_context_t:file { getattr read };
> +allow udev_t { selinux_config_t default_context_t }:file { getattr read };
> +allow udev_t file_context_t:dir { search };
> +allow udev_t file_context_t:file { getattr read };
> 
>  allow udev_t policy_config_t:dir { search };
>  allow udev_t proc_t:file { read };
> 
> 
> Russell Coker wrote:
> 
> >On Sun, 29 Aug 2004 04:29, Tom London <selinux@comcast.net> wrote:
> >  
> >
> >>Newest Rawhide updates (including udev-030-10, mkinitrd-4.1.8-1,
> >>kernel-2.6.8-1.532, and selinux-policy-strict-1.17.5-2)
> >>now boots in strict/enforcing.
> >>    
> >>
> >
> >I've attached a diff against the CVS policy as well as the .te and .fc files 
> >for udev changes which fix this and address some other issues as well.
> >
> >Please try it out and let me know how it goes.
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
