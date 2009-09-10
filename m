Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AJf4HW024091
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 15:41:04 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AJgOjU022184
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 19:42:25 GMT
Subject: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary="=-ZsMMJF09EJlSo5vA4U7k"
Date: Thu, 10 Sep 2009 21:40:56 +0200
Message-Id: <1252611656.2486.44.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZsMMJF09EJlSo5vA4U7k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a new policy for the dkim-filter application.

Chris, is the policy OK/ready for merge?

--=-ZsMMJF09EJlSo5vA4U7k
Content-Disposition: attachment; filename="dkimfilter.fc"
Content-Type: text/plain; name="dkimfilter.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/dkim-filter	--	gen_context(system_u:object_r:dkimfilter_exec_t,s0)

/var/db/dkim(/.*)?		gen_context(system_u:object_r:dkimfilter_private_key_t,s0)
/var/run/dkim-filter(/.*)?	gen_context(system_u:object_r:dkimfilter_var_run_t,s0)

--=-ZsMMJF09EJlSo5vA4U7k
Content-Disposition: attachment; filename="dkimfilter.if"
Content-Type: text/plain; name="dkimfilter.if"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

########################################
## <summary>
##      Connect to dkim-filter over an unix stream socket.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`dkimfilter_stream_connect',`
	gen_require(`
		type dkimfilter_t, dkimfilter_var_run_t;
	')

	files_search_pids($1)
	stream_connect_pattern($1, dkimfilter_var_run_t, dkimfilter_var_run_t, dkimfilter_t)
')

--=-ZsMMJF09EJlSo5vA4U7k
Content-Disposition: attachment; filename="dkimfilter.te"
Content-Type: text/plain; name="dkimfilter.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(dkimfilter, 1.0.0)

########################################
#
# Declarations
#

type dkimfilter_t;
type dkimfilter_exec_t;
init_daemon_domain(dkimfilter_t, dkimfilter_exec_t)

type dkimfilter_var_run_t;
files_pid_file(dkimfilter_var_run_t)

type dkimfilter_private_key_t;
files_type(dkimfilter_private_key_t)

########################################
#
# Local policy
#

allow dkimfilter_t self:capability { setgid setuid };

read_files_pattern(dkimfilter_t, dkimfilter_private_key_t, dkimfilter_private_key_t)
manage_files_pattern(dkimfilter_t, dkimfilter_var_run_t, dkimfilter_var_run_t)
manage_sock_files_pattern(dkimfilter_t, dkimfilter_var_run_t, dkimfilter_var_run_t)

files_read_etc_files(dkimfilter_t)

libs_read_lib_files(dkimfilter_t)

miscfiles_read_localization(dkimfilter_t)

logging_send_syslog_msg(dkimfilter_t)

dev_read_urand(dkimfilter_t)

kernel_read_kernel_sysctls(dkimfilter_t)

sysnet_dns_name_resolve(dkimfilter_t)

--=-ZsMMJF09EJlSo5vA4U7k
Content-Disposition: attachment; filename="sendmail.te.diff"
Content-Type: text/x-patch; name="sendmail.te.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/policy/modules/services/sendmail.te b/policy/modules/services/sendmail.te
index f3f0d44..c102ecb 100644
--- a/policy/modules/services/sendmail.te
+++ b/policy/modules/services/sendmail.te
@@ -130,6 +130,10 @@ optional_policy(`
 	udev_read_db(sendmail_t)
 ')
 
+optional_policy(`
+	dkimfilter_stream_connect(sendmail_t)
+')
+
 ifdef(`TODO',`
 allow sendmail_t etc_mail_t:dir rw_dir_perms;
 allow sendmail_t etc_mail_t:file manage_file_perms;

--=-ZsMMJF09EJlSo5vA4U7k--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
