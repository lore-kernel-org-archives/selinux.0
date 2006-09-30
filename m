Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8U3t2Bv011321
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 23:55:02 -0400
Received: from ccerelbas01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8U3sS9n000903
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 03:54:28 GMT
Message-ID: <451DEA8B.2070609@hp.com>
Date: Fri, 29 Sep 2006 23:54:51 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: RFC tweak for lpd.if to make it fit CUPS
Content-Type: multipart/mixed;
 boundary="------------040505050706020803010809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040505050706020803010809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've been playing around with the printing portion of the policy a bit
and would like to suggest some changes.  Looking at the source for
lpd.if it seems the the policy was originally written with a lpr/lpd in
mind that is not CUPS.  There are comments referencing a lightweight
mode, and $1_lpr_t is allowed to read and write to the spool directly.
CUPS does not do these things.  Attached is a patch I've applied to my
systems that allows CUPS to work just fine in Targeted and MLS mode with
13 less allow rules.

One side effect of this is that from $1_lpr_t access is no longer given
to print_spool_t.  If however we were then to allow access for
administrators (say: sysadm_r) to print_spool_t we can then use that
check to enable lprm and lpq for admins, but still restricting normal
users to only seeing their jobs.  This eliminates the need for the
helper program lspp-access.

Do the attached changes make sense?

Does the addition of this rule seem reasonable?

allow sysadm_lpr_t print_spool_t:file read;


Lastly in order to determine if a user is authorized to print to a given
printer based on a comparison of their level to that of the printer I'd
like to propose this rule:

allow $1_lpr_t printer_device_t:file write

Thanks
-matt


--------------040505050706020803010809
Content-Type: text/x-patch;
 name="cups-policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cups-policy.patch"

--- policy/modules/services/lpd.if	2006-09-25 15:11:36.000000000 -0400
+++ policy/modules/services/lpd.if-new	2006-09-29 18:41:22.000000000 -0400
@@ -65,31 +65,31 @@
 	allow $1_lpr_t self:netlink_route_socket r_netlink_socket_perms;
 	
 	# lpr can run in lightweight mode, without a local print spooler.
-	allow $1_lpr_t lpd_var_run_t:dir search;
-	allow $1_lpr_t lpd_var_run_t:sock_file write;
-	files_read_var_files($1_lpr_t)
+	#allow $1_lpr_t lpd_var_run_t:dir search;
+	#allow $1_lpr_t lpd_var_run_t:sock_file write;
+	#files_read_var_files($1_lpr_t)
 
 	# Connect to lpd via a Unix domain socket.
-	allow $1_lpr_t printer_t:sock_file rw_file_perms;
-	allow $1_lpr_t lpd_t:unix_stream_socket connectto;
+	#allow $1_lpr_t printer_t:sock_file rw_file_perms;
+	#allow $1_lpr_t lpd_t:unix_stream_socket connectto;
 	# Send SIGHUP to lpd.
-	allow $1_lpr_t lpd_t:process signal;
+	#allow $1_lpr_t lpd_t:process signal;
 
 	can_exec($1_lpr_t,lpr_exec_t)
 
-	allow $1_lpr_t $1_lpr_tmp_t:dir create_dir_perms;
-	allow $1_lpr_t $1_lpr_tmp_t:file create_file_perms;
-	files_tmp_filetrans($1_lpr_t, $1_lpr_tmp_t, { file dir })
-
-	allow $1_lpr_t $1_print_spool_t:file create_file_perms;
-	allow $1_lpr_t print_spool_t:dir rw_dir_perms;
-	type_transition $1_lpr_t print_spool_t:file $1_print_spool_t;
+	#allow $1_lpr_t $1_lpr_tmp_t:dir create_dir_perms;
+	#allow $1_lpr_t $1_lpr_tmp_t:file create_file_perms;
+	#files_tmp_filetrans($1_lpr_t, $1_lpr_tmp_t, { file dir })
+
+	#allow $1_lpr_t $1_print_spool_t:file create_file_perms;
+	#allow $1_lpr_t print_spool_t:dir rw_dir_perms;
+	#type_transition $1_lpr_t print_spool_t:file $1_print_spool_t;
 	# Read and write shared files in the spool directory.
-	allow $1_lpr_t print_spool_t:file rw_file_perms;
+	#allow $1_lpr_t print_spool_t:file rw_file_perms;
 
-	allow $1_lpr_t printconf_t:dir r_dir_perms;
-	allow $1_lpr_t printconf_t:file r_file_perms;
-	allow $1_lpr_t printconf_t:lnk_file { getattr read };
+	#allow $1_lpr_t printconf_t:dir r_dir_perms;
+	#allow $1_lpr_t printconf_t:file r_file_perms;
+	#allow $1_lpr_t printconf_t:lnk_file { getattr read };
 
 	dontaudit $1_lpr_t $2:unix_stream_socket { read write };
 


--------------040505050706020803010809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
