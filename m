Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00671
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:00:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA17883
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 13:59:06 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id NAA17879
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 13:59:03 GMT
Date: Tue, 8 Oct 2002 16:00:33 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Apache 2 file contexts
Message-ID: <20021008160033.A5253@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having just installed Apache 2 (from the sid Debian packages) on my
SELinux test system, I found that it works flawless once some additions
to the apache.fc file have been made. Here's a preliminary patch, I
haven't yet experimented with CGIs, vhosts and SSL:


*** /usr/share/selinux/policy/default/file_contexts/program/apache.fc   Wed Oct  2 02:12:59 2002
--- apache.fc   Tue Oct  8 17:54:13 2002
***************
*** 9,22 ****
  /etc/httpd/conf(/.*)?         system_u:object_r:httpd_config_t
  /etc/httpd/logs                       system_u:object_r:httpd_log_files_t
  /etc/httpd/modules            system_u:object_r:httpd_modules_t
  /usr/lib/apache(/.*)?         system_u:object_r:httpd_modules_t
  /usr/sbin/httpd                       system_u:object_r:httpd_exec_t
  /usr/sbin/apache              system_u:object_r:httpd_exec_t
  /usr/sbin/suexec              system_u:object_r:httpd_suexec_exec_t
  /usr/lib/cgi-bin/(nph-)?cgiwrap(d)? system_u:object_r:httpd_suexec_exec_t
  /usr/lib/apache/suexec                system_u:object_r:httpd_suexec_exec_t
  /var/log/httpd(/.*)?          system_u:object_r:httpd_log_files_t
! /var/log/apache(/.*)?         system_u:object_r:httpd_log_files_t
  /var/log/cgiwrap.log.*                system_u:object_r:httpd_log_files_t
  /var/cache/ssl.*\.sem         system_u:object_r:httpd_cache_t
! /var/run/apache.pid.*         system_u:object_r:httpd_var_run_t
--- 9,28 ----
  /etc/httpd/conf(/.*)?         system_u:object_r:httpd_config_t
  /etc/httpd/logs                       system_u:object_r:httpd_log_files_t
  /etc/httpd/modules            system_u:object_r:httpd_modules_t
+ /etc/apache(2)?(/.*)?         system_u:object_r:httpd_config_t
+ /etc/vhosts                   system_u:object_r:httpd_config_t
+ /usr/lib/cgi-bin(/.*)?                system_u:object_r:httpd_sys_script_t
  /usr/lib/apache(/.*)?         system_u:object_r:httpd_modules_t
+ /usr/lib/apache2/modules(/.*)?        system_u:object_r:httpd_modules_t
  /usr/sbin/httpd                       system_u:object_r:httpd_exec_t
  /usr/sbin/apache              system_u:object_r:httpd_exec_t
+ /usr/sbin/apache2             system_u:object_r:httpd_exec_t
  /usr/sbin/suexec              system_u:object_r:httpd_suexec_exec_t
+ /usr/lib/apache2/suexec2      system_u:object_r:httpd_suexec_exec_t
  /usr/lib/cgi-bin/(nph-)?cgiwrap(d)? system_u:object_r:httpd_suexec_exec_t
  /usr/lib/apache/suexec                system_u:object_r:httpd_suexec_exec_t
  /var/log/httpd(/.*)?          system_u:object_r:httpd_log_files_t
! /var/log/apache(2)?(/.*)?     system_u:object_r:httpd_log_files_t
  /var/log/cgiwrap.log.*                system_u:object_r:httpd_log_files_t
  /var/cache/ssl.*\.sem         system_u:object_r:httpd_cache_t
! /var/run/apache(2)?.pid.*     system_u:object_r:httpd_var_run_t


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
