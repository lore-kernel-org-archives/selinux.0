Message-ID: <42407E27.7020901@redhat.com>
Date: Tue, 22 Mar 2005 15:20:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest diff.
References: <424062D4.8090708@redhat.com>
In-Reply-To: <424062D4.8090708@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080309070202060002000003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080309070202060002000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Diff to previous diff for unconfined apache policy.

Dan

--------------080309070202060002000003
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

-+++ policy-1.23.4/domains/program/unused/apache.te	2005-03-22 12:19:28.267021536 -0500
++++ policy-1.23.4/domains/program/unused/apache.te	2005-03-22 13:41:52.893324080 -0500
 @@ -42,6 +42,9 @@
  # Allow http daemon to communicate with the TTY
  bool httpd_tty_comm false;
@@ -200,18 +205,28 @@
  can_ypbind(httpd_t)
  
  ###################
-@@ -352,3 +360,8 @@
+@@ -352,3 +360,18 @@
  allow httpd_sys_script_t var_lib_t:dir search;
  dontaudit httpd_t selinux_config_t:dir search;
  r_dir_file(httpd_t, cert_t)
 +
++#
++# unconfined domain for apache scripts.  Only to be used as a last resort
++#
 +type httpd_unconfined_script_exec_t, file_type, sysadmfile, customizable;
-+type httpd_unconfined_t, domain;
-+unconfined_domain(httpd_unconfined_t)
-+domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_t)
++type httpd_unconfined_script_t, domain, nscd_client_domain;
++role system_r types httpd_unconfined_script_t;
++unconfined_domain(httpd_unconfined_script_t)
++if (httpd_enable_cgi) {
++domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
++domain_auto_trans(httpd_suexec_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
++allow httpd_t httpd_unconfined_script_t:process { signal sigkill sigstop };
++allow httpd_t httpd_unconfined_script_exec_t:dir r_dir_perms;
++}
++

--------------080309070202060002000003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
