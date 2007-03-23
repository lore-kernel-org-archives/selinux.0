Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJvBYI007941
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:57:11 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJv9sr014468
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:57:09 GMT
Message-ID: <4604310E.70906@redhat.com>
Date: Fri, 23 Mar 2007 15:57:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Apache wants to read krb5kdc.conf file
Content-Type: multipart/mixed;
 boundary="------------090805060605030208020909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090805060605030208020909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

kadmind trys to setattr on krb5kdc file.  Just a library checking access.



--------------090805060605030208020909
Content-Type: text/x-patch;
 name="kerberos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kerberos.patch"

--- nsaserefpolicy/policy/modules/services/kerberos.if	2007-02-26 14:17:21.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/kerberos.if	2007-03-22 15:06:59.000000000 -0400
@@ -94,6 +94,27 @@
 
 ########################################
 ## <summary>
+##	Read the kerberos kdc configuration file (/etc/krb5kdc.conf).
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`kerberos_read_kdc_config',`
+	gen_require(`
+		type krb5kdc_conf_t;
+	')
+
+	files_search_etc($1)
+	allow $1 krb5kdc_conf_t:file read_file_perms;
+
+')
+
+########################################
+## <summary>
 ##	Do not audit attempts to write the kerberos
 ##	configuration file (/etc/krb5.conf).
 ## </summary>
--- nsaserefpolicy/policy/modules/services/kerberos.te	2007-03-20 23:38:09.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/kerberos.te	2007-03-22 15:06:59.000000000 -0400
@@ -68,7 +68,7 @@
 dontaudit kadmind_t krb5_conf_t:file write;
 
 read_files_pattern(kadmind_t,krb5kdc_conf_t,krb5kdc_conf_t)
-dontaudit kadmind_t krb5kdc_conf_t:file write;
+dontaudit kadmind_t krb5kdc_conf_t:file { write setattr };
 
 allow kadmind_t krb5kdc_principal_t:file { getattr lock read write setattr };
 
--- nsaserefpolicy/policy/modules/services/apache.te	2007-03-20 23:38:06.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/apache.te	2007-03-22 15:06:59.000000000 -0400
@@ -383,6 +400,7 @@
 
 optional_policy(`
 	kerberos_use(httpd_t)
+	kerberos_read_kdc_config(httpd_t)
 ')
 
 optional_policy(`

--------------090805060605030208020909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
