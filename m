Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U5QVNs024712
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 01:26:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U5KmxX023375
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 05:20:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 448D961B01
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 15:20:44 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06439-04 for <selinux@tycho.nsa.gov>;
	Fri, 30 Sep 2005 15:20:43 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9D04561AFB
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 15:20:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: postfix.te
Date: Fri, 30 Sep 2005 15:20:35 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qsMPDgz3LXrXcDp"
Message-Id: <200509301520.42488.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_qsMPDgz3LXrXcDp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Where did the recent patch for postfix.te come from?

r_dir_file(postfix_$1_t, cert_t)

The above is added to the macro postfix_domain().  This is a bad idea, we want 
to restrict access to cert_t not allow commands run by unprivileged users 
such as "mailq" to read it.

Do we know which domains actually need this access?

file_type_auto_trans({ sysadm_mail_t system_mail_t postfix_master_t }, etc_t, 
etc_aliases_t)

The above was added within the distro_redhat section.  Do we have a plan to 
change the way the aliases file is managed in FC5 or RHEL5?  
Currently /etc/aliases is read the /etc/postfix/aliases.db is produced as a 
result.  So the above line is not needed (and grants postfix_master_t write 
access to etc_t:dir which is not desired).

# for SSP

The changes to the urandom_device_t access didn't remove the above comment and 
leaves it unattached.

dontaudit postfix_smtpd_t { home_root_t boot_t }:dir getattr;

The above line is added in the section with a comment referring to prng_exch.  
Why is that access needed and what does it have to do with prng_exch?

r_dir_file(postfix_local_t, etc_mail_t)
can_exec(postfix_local_t, bin_t)

These two additions are bad.  Firstly etc_mail_t is defined in sendmail.te.  
There should not be any dependencies between the different mail server .te 
files.

As for the reference to bin_t, I can only guess that it's to execute 
spamassasin when spamassasin.te is not installed (spamassasin has some files 
in /etc/mail).

Is it possible to have the postfix "local" execute spamassasin directly or 
would that be from someone who has spamassasin running from procmail (which 
seems to be the most common way of running spamassasin on a server) and not 
having procmail.te installed?

I suggest the attached patch to fix these issues.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_qsMPDgz3LXrXcDp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/postfix.te.orig	2005-09-30 15:17:51.000000000 +1000
+++ domains/program/postfix.te	2005-09-30 15:19:52.000000000 +1000
@@ -54,7 +54,6 @@
 allow postfix_$1_t proc_net_t:dir search;
 allow postfix_$1_t proc_net_t:file { getattr read };
 can_exec(postfix_$1_t, postfix_$1_exec_t)
-r_dir_file(postfix_$1_t, cert_t)
 allow postfix_$1_t { urandom_device_t random_device_t }:chr_file { read getattr };
 
 allow postfix_$1_t tmp_t:dir getattr;
@@ -103,7 +102,6 @@
 can_exec({ sysadm_mail_t system_mail_t }, postfix_master_exec_t)
 ifdef(`distro_redhat', `
 file_type_auto_trans({ sysadm_mail_t system_mail_t postfix_master_t }, postfix_etc_t, etc_aliases_t)
-file_type_auto_trans({ sysadm_mail_t system_mail_t postfix_master_t }, etc_t, etc_aliases_t)
 ', `
 file_type_auto_trans({ sysadm_mail_t system_mail_t }, etc_t, etc_aliases_t)
 ')
@@ -145,8 +143,6 @@
 # for ls to get the current context
 allow postfix_master_t self:file { getattr read };
 
-# for SSP
-
 # allow access to deferred queue and allow removing bogus incoming entries
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
 allow postfix_master_t postfix_spool_t:file create_file_perms;
@@ -186,7 +182,6 @@
 
 # for prng_exch
 allow postfix_smtpd_t postfix_spool_t:file rw_file_perms;
-dontaudit postfix_smtpd_t { home_root_t boot_t }:dir getattr;
 allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms;
 
 postfix_server_domain(local, `, mta_delivery_agent')
@@ -198,7 +193,7 @@
 ')
 allow postfix_local_t etc_aliases_t:file r_file_perms;
 allow postfix_local_t self:fifo_file rw_file_perms;
-allow postfix_local_t postfix_local_t:process { setsched setrlimit };
+allow postfix_local_t self:process { setsched setrlimit };
 allow postfix_local_t postfix_spool_t:file rw_file_perms;
 # for .forward - maybe we need a new type for it?
 allow postfix_local_t postfix_private_t:dir search;
@@ -351,8 +346,5 @@
 dontaudit postfix_map_t var_t:dir search;
 can_network_server(postfix_map_t)
 allow postfix_map_t port_type:tcp_socket name_connect;
-r_dir_file(postfix_local_t, etc_mail_t)
 allow postfix_local_t mail_spool_t:dir { remove_name };
 allow postfix_local_t mail_spool_t:file { unlink };
-can_exec(postfix_local_t, bin_t)
-

--Boundary-00=_qsMPDgz3LXrXcDp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
