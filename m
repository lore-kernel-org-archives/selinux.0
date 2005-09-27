Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCvBNs021833
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:57:12 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCpkpk004506
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:51:46 GMT
Message-Id: <200509271251.j8RCpoYs026127@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 17/17
Date: Tue, 27 Sep 2005 08:51:50 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0040_01C5C340.B3567C40"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0040_01C5C340.B3567C40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This updates the module readme.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0040_01C5C340.B3567C40
Content-Type: application/octet-stream;
	name="selinux-doc_README.MODULES.DIFF"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinux-doc_README.MODULES.DIFF"

diff -purN -x .svn selinux-doc/README.MODULES selinux-doc/README.MODULES=0A=
--- selinux-doc/README.MODULES	2005-09-26 14:02:41.000000000 -0400=0A=
+++ selinux-doc/README.MODULES	2005-09-26 17:40:39.000000000 -0400=0A=
@@ -21,7 +21,7 @@ macros.=0A=
 =0A=
 This syslog.mod contains the symbolic policy from syslog.te. For=0A=
 comprehensiveness it is also appropriate to add the file contexts for=0A=
-that particular module to it. To do this use the sepackagemodule=0A=
+that particular module to it. To do this use the semodule_package=0A=
 command:=0A=
 	semodule_package syslogd.pp syslogd.mod syslogd.fc=0A=
 =0A=
@@ -32,22 +32,16 @@ syslog related files.=0A=
 =0A=
 3. Adding a module to your system=0A=
 =0A=
-To add a module to your systems module store you must first initialize =
your module store.=0A=
-	semodule -v -m=0A=
-=0A=
-(The -v adds verbosity)=0A=
-=0A=
-Once your module store is initialized can add a base module to your=0A=
-system. After building a policy.conf from your current policy you can=0A=
+After building a policy.conf from your current policy you can=0A=
 use that as your base module. First we'll build it:=0A=
 	checkmodule policy.conf -o base.mod=0A=
 	semodule_package base.pp base.mod file_contexts/file_contexts=0A=
 =0A=
 Now that we have a base policy package we'll add it:=0A=
-	semodule -v -b base.pp=0A=
+	semodule -b base.pp=0A=
 =0A=
 Once you have a base module installed you can install a module:=0A=
-	semodule -v -i syslogd.pp=0A=
+	semodule -i syslogd.pp=0A=
 =0A=
 So your system policy should now be loaded with only the base policy=0A=
 and syslogd, you can verify it with the semodule command:=0A=
@@ -82,19 +76,21 @@ policy, in this case in the base policy.=0A=
 present elsewhere this module will not be able to be added to the=0A=
 system policy.=0A=
 =0A=
-optional { require { type klogd_t; } allow klogd_t domain : process =
signal; }=0A=
+optional { =0A=
+	require { type klogd_t; } =0A=
+	allow klogd_t domain : process signal; =0A=
+}=0A=
 =0A=
-The above statement specifies that the type klogd_t is optional, and=0A=
-if present the optional klogd will be set to true. This identifier can=0A=
-then be used in the optional block.  =0A=
-=0A=
-5. Example semod.conf=0A=
-=0A=
-In your policy modules directory (generally=0A=
-/etc/selinux/$SELINUXTYPE/modules) there is a semod.conf configuration=0A=
-file for semodule, initially created by semodule -m from a template=0A=
-file (typically /usr/share/semod/semod.conf). The file allows a few=0A=
-customizations to the behaviour of semodule. =0A=
+In the above optional block, if the type klogd_t is declared in the=0A=
+base policy or another module then include the allow rule in the=0A=
+final policy.  Required identifiers may only be used within their=0A=
+optional block.=0A=
+=0A=
+5. Example semanage.conf=0A=
+=0A=
+To change the default behavior of libsemanage you can copy the sample =0A=
+libsemanage.conf from /usr/share/semanage/semanage.conf to =0A=
+/etc/selinux/$SELINUXTYPE/modules. =0A=
 =0A=
 First you can specify how semodule (via libsemanage) will interact=0A=
 with the module store:=0A=
@@ -102,12 +98,12 @@ with the module store:=0A=
 This statement indicates that libsemanage will write directly to the=0A=
 store on the filesystem.  Other options to be supported in the future=0A=
 include a Unix domain socket path for communicating with a local=0A=
-policy management daemon, and a hostname:port pair for communiting=0A=
+policy management daemon, and a hostname:port pair for communicating=0A=
 with a remote policy management daemon.=0A=
 =0A=
 Next you can set the kernel policy version you wish to use. If you do=0A=
 not specify one it uses the latest that libsepol understands:=0A=
-	policy-version =3D 19=0A=
+	policy-version =3D 20=0A=
 This is only needed when there is a mismatch between the latest policy=0A=
 version supported by the kernel and the latest policy version=0A=
 supported by libsepol.=0A=
@@ -165,7 +161,7 @@ module syslog 1.2;=0A=
 =0A=
 require {=0A=
 # in this policy all the module requirements are in one place but they =
can be spread throughout=0A=
-# the policy, such as when a macro declares it's own dependancies.=0A=
+# the policy, such as when a macro declares its own dependancies.=0A=
 =0A=
 	bool allow_ypbind;=0A=
 	attribute domain, privmem, privlog, file_type, daemon;=0A=
@@ -178,18 +174,19 @@ require {=0A=
 	type initrc_devpts_t, var_t, var_run_t, devtty_t, sysadm_home_dir_t;=0A=
 	type removable_t, locale_t, mount_t, net_conf_t, var_yp_t, var_log_t;=0A=
 	type reserved_port_t, port_t, tmp_t, initrc_var_run_t, proc_kmsg_t;=0A=
-	type kernel_t, file_t, tty_device_t, tmpfs_t, devpts_t, unlabeled_t;=0A=
+	type kernel_t, file_t, tty_device_t, tmpfs_t, devpts_t, unlabeled_t, =
netif_t;=0A=
 	class fd { use };=0A=
 	class process { siginh noatsecure transition rlimitinh sigchld sigkill =
sigstop signull signal fork };=0A=
-	class dir { rmdir create rename setattr link reparent unlink write =
add_name remove_name read getattr lock search ioctl };=0A=
+	class dir { rmdir create rename setattr link reparent unlink write =0A=
+		    add_name remove_name read getattr lock search ioctl };=0A=
 	class lnk_file { setattr unlink rename create link read getattr lock =
ioctl };=0A=
 	class file { entrypoint execute create ioctl read getattr lock write =
setattr append link unlink rename execmod };=0A=
 	class chr_file { ioctl read getattr lock write append };=0A=
 	class filesystem getattr;=0A=
 	class udp_socket { name_bind create ioctl read getattr write setattr =
append bind connect =0A=
 			   getopt setopt shutdown send_msg recv_msg node_bind };=0A=
-	class tcp_socket { name_bind node_bind create ioctl read getattr write =
setattr append bind =0A=
-	 		   connect getopt setopt shutdown listen accept send_msg recv_msg };=0A=
+	class tcp_socket { name_bind node_bind create ioctl read getattr write =
setattr append =0A=
+			   bind connect getopt setopt shutdown listen accept send_msg =
recv_msg };=0A=
 	class netif { tcp_recv udp_recv rawip_recv tcp_send udp_send =
rawip_send };=0A=
 	class node { tcp_recv tcp_send udp_send rawip_send udp_recv rawip_recv =
};=0A=
 	class sock_file { create ioctl read getattr lock write setattr append =
link unlink rename };=0A=
@@ -244,7 +241,7 @@ allow privlog devlog_t:lnk_file read;=0A=
 =0A=
 optional {=0A=
 	require {=0A=
-		type system_crond_t, type crond_log_t;=0A=
+		type system_crond_t crond_log_t;=0A=
 	}=0A=
 	# Write to the cron log.=0A=
 	allow syslogd_t crond_log_t:file rw_file_perms;=0A=

------=_NextPart_000_0040_01C5C340.B3567C40--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
