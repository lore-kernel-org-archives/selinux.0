Subject: hal - denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112031473.2914.109.camel@moss-spartans.epoch.ncsc.mil>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
	 <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
	 <1112029334.3350.2.camel@cobra.ivg2.net>
	 <1112029488.2914.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1112030817.3350.6.camel@cobra.ivg2.net>
	 <1112031473.2914.109.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 18:14:30 -0500
Message-Id: <1112483670.14277.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, here is what hald required to stop complaining.
Which ones should be dontaudit? I take it you won't like
allowing hald to write to /selinux, and read /dev/mem.

re: dmidecode - 
dmidecode decodes the DMI data present in x86 and IA64 BIOS's.

Can't that be made to run in its own domain?

diff -aur policy.old/domains/program/hald.te
policy/domains/program/hald.te
--- policy.old/domains/program/hald.te  2005-04-02 17:37:37.000000000
-0500
+++ policy/domains/program/hald.te      2005-04-02 18:06:02.000000000
-0500
@@ -43,6 +43,7 @@
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file read;
+allow hald_t mouse_device_t:chr_file { read ioctl };

 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
@@ -73,3 +74,20 @@
 tmp_domain(hald)
 allow hald_t mnt_t:dir search;
 r_dir_file(hald_t, proc_net_t)
+
+# For /usr/libexec/hald-add-selinux-mount-option
+allow hald_t security_t:dir search;
+allow hald_t security_t:file { read write };
+allow hald_t security_t:security check_context;
+
+# For /usr/libxexc/hald-addon-acpi - writes to /var/run/acpid.socket
+allow hald_t apmd_var_run_t:sock_file write;
+allow hald_t apmd_t:unix_stream_socket connectto;
+
+# For /usr/sbin/dmidecode
+# Violates assertion
+#allow hald_t memory_device_t:chr_file read;
+allow hald_t self:capability sys_rawio;
+
+# ??
+allow hald_t lvm_control_t:chr_file getattr;


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
