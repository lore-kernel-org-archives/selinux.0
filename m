Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05707
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 06:47:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA23239
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 10:46:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA23235
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 10:46:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 073F292466
	for <selinux@tycho.nsa.gov>; Mon,  9 Sep 2002 20:47:40 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 4698D7DF
	for <selinux@tycho.nsa.gov>; Mon,  9 Sep 2002 12:47:30 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: mailing lists
Date: Mon, 9 Sep 2002 12:47:29 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5B36T7YPI0SGEXXH732J"
Message-Id: <200209091247.29878.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_5B36T7YPI0SGEXXH732J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached new policy files for the mailman mailing list manager.

The policy for the CGI scripts is only 90% complete, I suspect that we'll need 
to review the entire way that the httpd policy works and make it work 
properly for bulk hosting before I can get something I'm satisfied with in 
this regard.

I have also setup a mailing list for general discussion that's vaguely related 
to SE Linux.  The subscription address is selinux-talk-request@coker.com.au
send the command "help" for information about the list and the command 
"subscribe" to subscribe to it.  NB The web page for the list is not yet 
functioning.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_5B36T7YPI0SGEXXH732J
Content-Type: text/plain;
  charset="us-ascii";
  name="mailman.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mailman.te"


type mailman_data_t, file_type, sysadmfile;
type mailman_archive_t, file_type, sysadmfile;

type mailman_log_t, file_type, sysadmfile, logfile;
type mailman_lock_t, file_type, sysadmfile, lockfile;

define(`mailman_domain', `
type mailman_$1_t, domain, privlog;
type mailman_$1_exec_t, file_type, sysadmfile, exec_type;
role system_r types mailman_$1_t;
file_type_auto_trans(mailman_$1_t, var_log_t, mailman_log_t)
rw_dir_create_file(mailman_$1_t, mailman_data_t)
uses_shlib(mailman_$1_t)
can_exec_any(mailman_$1_t)
allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
allow mailman_$1_t var_lib_t:dir search;
allow mailman_$1_t var_lib_t:lnk_file read;
allow mailman_$1_t device_t:dir search;
allow mailman_$1_t etc_runtime_t:file { read getattr };
allow mailman_$1_t etc_t:lnk_file read;
file_type_auto_trans(mailman_$1_t, var_lock_t, mailman_lock_t)
allow mailman_$1_t fs_t:filesystem getattr;
can_network(mailman_$1_t)
allow mailman_$1_t resolv_conf_t:file { getattr read };
allow mailman_$1_t self:unix_stream_socket create_socket_perms;
')


mailman_domain(cgi)
mailman_domain(queue)
mailman_domain(mail)

create_dir_file(mailman_queue_t, mailman_archive_t)

domain_auto_trans(httpd_user_script_process_t, mailman_cgi_exec_t, mailman_cgi_t)


allow mailman_cgi_t httpd_t:process sigchld;
allow mailman_cgi_t httpd_t:fd use;
allow mailman_cgi_t httpd_t:fifo_file { getattr read write ioctl };
allow mailman_cgi_t httpd_user_script_t:dir search;


allow mta_delivery_agent mailman_data_t:dir search;
allow mta_delivery_agent mailman_data_t:lnk_file read;
dontaudit mailman_mail_t mta_delivery_agent:tcp_socket { read write };
domain_auto_trans_read(mta_delivery_agent, mailman_mail_exec_t, mailman_mail_t)
allow mailman_mail_t self:unix_dgram_socket create_socket_perms;

domain_auto_trans(system_crond_t, mailman_queue_exec_t, mailman_queue_t)
allow mailman_queue_t crond_t:fd use;
allow mailman_queue_t crond_t:fifo_file write;


# so MTA can access /var/lib/mailman/mail/wrapper
allow mta_delivery_agent var_lib_t:dir search;

--------------Boundary-00=_5B36T7YPI0SGEXXH732J
Content-Type: text/plain;
  charset="us-ascii";
  name="mailman.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mailman.fc"

# mailman list server
/usr/lib/cgi-bin/mailman/.*	system_u:object_r:mailman_cgi_exec_t
/var/log/mailman(/.*)?		system_u:object_r:mailman_log_t
/usr/lib/mailman/cron/qrunner	system_u:object_r:mailman_queue_exec_t
/var/lib/mailman(/.*)?		system_u:object_r:mailman_data_t
/usr/lib/mailman/mail/wrapper	system_u:object_r:mailman_mail_exec_t
/var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t

--------------Boundary-00=_5B36T7YPI0SGEXXH732J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
