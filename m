Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i816I1rT018524
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 02:18:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i816Hueu021420
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 06:17:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: hald/hal-hotplug-map
Date: Wed, 1 Sep 2004 16:17:50 +1000
Cc: Tom London <selinux@comcast.net>, Daniel J Walsh <dwalsh@redhat.com>
References: <41323F6B.4020701@comcast.net> <4132465C.6080806@comcast.net>
In-Reply-To: <4132465C.6080806@comcast.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OmWNBbY45PtK9vZ"
Message-Id: <200409011617.50445.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_OmWNBbY45PtK9vZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 30 Aug 2004 07:10, Tom London <selinux@comcast.net> wrote:
> Oops.... hald.fc should be
> # hald - hardware informationd daemon
> /usr/sbin/hald          --      system_u:object_r:hald_exec_t
> /usr/libexec/hal-hotplug-map    --      system_u:object_r:hald_exec_t
>
> Otherwise hal.dev and hal.hotplug get erroneously relabeled.

It's a difficult decision about whether to allow hald_t to execute bin_t or to 
label the file as hald_exec_t.  At this time I think that labelling it as 
hald_exec_t is better as it prevents hald from executing many different 
program files.

I've attached a little patch which implements this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_OmWNBbY45PtK9vZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hald.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hald.diff"

--- /usr/src/se/policy/file_contexts/program/hald.fc	2004-08-18 22:42:50.000000000 +1000
+++ file_contexts/program/hald.fc	2004-09-01 12:48:28.000000000 +1000
@@ -1,2 +1,3 @@
 # hald - hardware informationd daemon
 /usr/sbin/hald		--	system_u:object_r:hald_exec_t
+/usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
--- /usr/src/se/policy/domains/program/unused/hald.te	2004-08-28 12:05:02.000000000 +1000
+++ domains/program/unused/hald.te	2004-09-01 16:14:10.000000000 +1000
@@ -12,6 +12,8 @@
 #
 daemon_domain(hald, `, dbus_client_domain, fs_domain')
 
+can_exec(hald_t, hald_exec_t)
+
 allow hald_t { etc_t etc_runtime_t }:file { getattr read };
 allow hald_t self:unix_stream_socket create_stream_socket_perms;
 allow hald_t self:unix_dgram_socket create_socket_perms;
@@ -30,6 +32,7 @@
 can_network(hald_t)
 can_ypbind(hald_t)
 
+allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
 allow hald_t event_device_t:chr_file { getattr read };
 

--Boundary-00=_OmWNBbY45PtK9vZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
