Message-ID: <41756DB7.8070704@redhat.com>
Date: Tue, 19 Oct 2004 15:40:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: unified_type patch for apache.
Content-Type: multipart/mixed;
 boundary="------------050409090601010307050800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050409090601010307050800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We are looking into adding the attached patch for apache policy.  
Basically it is a boolean that will eliminate the difference between the way
httpd handles content.   So setting unified_apache will make all content 
the same and fall back to DAC as far as cgi executables.  This will
allow easier transition to SELinux and allow relabeling of the 
/var/www/html directory to not stop apache from working.  It will be 
turned on
by default in targeted policy and off in strict policy.

Comments?

Dan

--------------050409090601010307050800
Content-Type: text/plain;
 name="policy-1.17.30-unified.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-1.17.30-unified.patch"

--- policy-1.17.30/macros/program/apache_macros.te.unified	2004-10-18 16:59:38.000000000 -0400
+++ policy-1.17.30/macros/program/apache_macros.te	2004-10-19 15:28:52.891959534 -0400
@@ -1,26 +1,9 @@
 
 define(`apache_domain', `
 
-undefine(`apache_single_user')
-ifdef(`single_userdomain', `
-ifelse($1, sys, `', `
-define(`apache_single_user')
-')dnl end if
-')dnl end ifdef single_userdomain
-
-ifdef(`apache_single_user', `
-typealias $1_home_t alias httpd_$1_content_t;
-typealias $1_home_t alias httpd_$1_htaccess_t;
-typealias $1_home_t alias httpd_$1_script_exec_t;
-typealias $1_home_t alias httpd_$1_script_ro_t;
-typealias $1_home_t alias httpd_$1_script_rw_t;
-typealias $1_home_t alias httpd_$1_script_ra_t;
-file_type_auto_trans(httpd_$1_script_t, tmp_t, $1_tmp_t)
-', `
-
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
+type httpd_$1_content_t, file_type, homedirfile, httpdcontent, sysadmfile;
 ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 ')
@@ -29,6 +12,8 @@
 #
 type httpd_$1_htaccess_t, file_type, sysadmfile;
 
+# This type is used for executable scripts files
+#
 type httpd_$1_script_exec_t, file_type, sysadmfile;
 
 # Type that CGI scripts run as
@@ -70,10 +55,10 @@
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
-type httpd_$1_script_ro_t, file_type, sysadmfile;
-type httpd_$1_script_rw_t, file_type, sysadmfile;
+type httpd_$1_script_ro_t, file_type, httpdcontent, sysadmfile;
+type httpd_$1_script_rw_t, file_type, httpdcontent, sysadmfile;
+type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile;
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
-type httpd_$1_script_ra_t, file_type, sysadmfile;
 
 ifdef(`slocate.te', `
 ifelse($1, `sys', `', `
@@ -122,6 +107,19 @@
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
 
+if (unified_apache) {
+create_dir_file(httpd_$1_script_t, httpdcontent)
+}
+
+if (httpd_enable_cgi) && (unified_apache) {
+ifelse($1, sys, `
+domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
+domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
+', `
+domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
+')
+}
+
 ifelse($1, sys, `
 #
 # If a user starts a script by hand it gets the proper context
@@ -130,7 +128,6 @@
 role sysadm_r types httpd_$1_script_t;
 ', `
 
-ifdef(`single_userdomain', `', `
 # If a user starts a script by hand it gets the proper context
 domain_auto_trans($1_t, httpd_$1_script_exec_t, httpd_$1_script_t)
 role $1_r types httpd_$1_script_t;
@@ -143,7 +140,7 @@
 create_dir_file($1_crond_t, httpd_$1_content_t)
 allow $1_t { httpd_$1_content_t httpd_$1_script_exec_t }:{ dir file lnk_file } { relabelto relabelfrom };
 ifdef(`mozilla.te', `
-r_dir_file($1_mozilla_t, { httpd_$1_script_exec_t httpd_$1_content_t })
+r_dir_file($1_mozilla_t, { httpd_$1_script_exec_t httpd_$1_content_t }
 ')
 
 ######################################################################
@@ -159,7 +156,6 @@
 
 create_dir_file($1_t, { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t })
 allow $1_t { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:{ file dir lnk_file } { relabelto relabelfrom };
-')dnl end ifdef single_userdomain
 
 # allow accessing files/dirs below the users home dir
 if (httpd_enable_homedirs) {
@@ -182,5 +178,4 @@
 #########################################
 allow httpd_$1_script_t httpd_log_t:file append;
 
-')dnl end apache_single_user
 ')
--- policy-1.17.30/domains/program/unused/apache.te.unified	2004-10-18 16:59:38.000000000 -0400
+++ policy-1.17.30/domains/program/unused/apache.te	2004-10-19 14:54:09.520437117 -0400
@@ -21,6 +21,10 @@
 ###############################################################################
 type http_port_t, port_type, reserved_port_type;
 
+attribute httpdcontent;
+
+bool unified_apache false;
+
 # Allow httpd cgi support
 bool httpd_enable_cgi false;
 

--------------050409090601010307050800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
