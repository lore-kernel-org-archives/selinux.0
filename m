Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OAuVrT025134
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 06:56:31 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OAuTCV028490
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:56:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 29B72BF76
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:56:26 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 31034-02 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 11:56:22 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id A0F6EBF28
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:56:21 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzZ9R-0007ae-IS
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 12:07:41 +0100
Date: Tue, 24 Aug 2004 12:07:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: running make relabel from a cronjob
Message-ID: <20040824110741.GI25356@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

the following patches allow the attached /etc/cron.d/selinux program
to successfully run.

this is for a user-only system where root access will not be given
out, and there won't be any maintenance or support, either.

i heard from someone that Fedora also has a cronjob doing a make
relabel too, so i am slightly confused that the strict selinux policy
doesn't presently have this already oh well.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=g

--- /usr/share/selinux/policy/default/domains/program/setfiles.te	2004-08-02 08:28:37.000000000 +0100
+++ setfiles.te	2004-08-24 12:03:19.000000000 +0100
@@ -49,9 +49,14 @@
 
 allow setfiles_t etc_runtime_t:file read;
 allow setfiles_t etc_t:file read;
+allow setfiles_t automount_etc_t:file { getattr read };
 allow setfiles_t proc_t:file { getattr read };
 dontaudit setfiles_t proc_t:lnk_file { getattr read };
 
 # for config files in a home directory
 allow setfiles_t home_type:file r_file_perms;
 dontaudit setfiles_t sysadm_tty_device_t:chr_file { relabelfrom };
+
+# allow setfiles to be run from crond
+allow setfiles_t crond_t:fifo_file { read write };
+
--- /usr/share/selinux/policy/default/domains/program/crond.te	2004-08-02 08:28:37.000000000 +0100
+++ crond.te	2004-08-24 12:03:26.000000000 +0100
@@ -202,3 +202,11 @@
 r_dir_file(system_crond_t, file_context_t)
 can_getsecurity(system_crond_t)
 ')
+
+
+allow system_crond_t policy_src_t:file { read };
+	#EXE=/usr/bin/make  NAME=Makefile   :  read
+
+can_exec(system_crond_t, setfiles_exec_t)
+domain_auto_trans(system_crond_t,  setfiles_exec_t, setfiles_t)
+

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=selinux

# run every 6 hours to restore contexts on filesystem
# ... just in case of damage...

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user	command
* 0,6,12,18	* * *	root    nice -20 make -C /etc/selinux/src relabel

--T4sUOijqQbZv57TR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
