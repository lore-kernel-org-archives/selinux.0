Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QDElrT027212
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 09:14:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QDDh76013544
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:13:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, Tom London <selinux@gmail.com>
Subject: Re: reconnecting USB p rinter
Date: Sun, 26 Sep 2004 23:14:37 +1000
References: <4c4ba1530409251901fa541f6@mail.gmail.com>
In-Reply-To: <4c4ba1530409251901fa541f6@mail.gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9CsVBmGRrdQzfY8"
Message-Id: <200409262314.37967.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_9CsVBmGRrdQzfY8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 26 Sep 2004 12:01, Tom London <selinux@gmail.com> wrote:
> Running strict/enforcing, w/USB printer.
>
> Reconnecting printer (after pulling the plug) yields the following:

allow hald_t urandom_device_t:chr_file { read };

The above line should go unconditionally in hald.te not in cups.te.  The 
reason is that hald might access urandom_device_t for many things other than 
printer configuration, and we don't want the other things to suddenly stop 
working if we remove the cups policy.

Also for neat policy I think it's best not to put {} around a single item.

I've attached a diff between the policy in my tree for hal and cups and that 
of the CVS.  Please note that removing the dontaudit from cups.te is 
deliberate, there is a matching allow rule later in the same file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_9CsVBmGRrdQzfY8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/cups.te	2004-09-23 22:31:16.000000000 +1000
+++ domains/program/unused/cups.te	2004-09-26 23:11:26.000000000 +1000
@@ -31,7 +31,6 @@
 allow cupsd_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t urandom_device_t:chr_file { getattr read };
 dontaudit cupsd_t random_device_t:chr_file ioctl;
-dontaudit cupsd_t device_t:lnk_file { read }; 
 
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
@@ -156,6 +155,7 @@
 allow ptal_t printer_device_t:chr_file { ioctl read write };
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
+r_dir_file(ptal_t, usbfs_t)
 allow cupsd_t ptal_var_run_t:sock_file { write setattr };
 allow cupsd_t ptal_t:unix_stream_socket { connectto };
 allow cupsd_t ptal_var_run_t:dir { search };
@@ -167,4 +167,6 @@
 ifdef(`hald.te', `
 allow cupsd_t hald_t:dbus { send_msg };
 allow hald_t cupsd_t:dbus { send_msg };
+allow hald_t cupsd_etc_t:dir search;
+allow hald_t printconf_t:file { getattr read };
 ')
--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-24 06:31:21.000000000 +1000
+++ domains/program/unused/hald.te	2004-09-26 23:10:58.000000000 +1000
@@ -38,6 +38,8 @@
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
+allow hald_t printer_device_t:chr_file rw_file_perms;
+allow hald_t urandom_device_t:chr_file read;
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)

--Boundary-00=_9CsVBmGRrdQzfY8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
