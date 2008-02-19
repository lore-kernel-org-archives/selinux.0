Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JA3H8j019170
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 05:03:18 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1JA3Gj8011460
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 10:03:16 GMT
Date: Tue, 19 Feb 2008 11:03:12 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: refpolicy: patch for Debian cracklib-runtime daily cron job
Message-ID: <20080219100312.GA19763@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the package cracklib-runtime on Debian contains a daily maintenance script
/etc/cron.daily/cracklib-runtime, that calls
    update-cracklib and that calls
	crack_mkdict, witch is a shell script. :)
Run of the job daily cron job emits:

audit(1203412448.496:30): avc:  denied  { execute } for  pid=1961 comm="crack_mkdict" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:crack_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
audit(1203412448.496:31): avc:  denied  { read } for  pid=1961 comm="crack_mkdict" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:crack_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

A patch is attached that suppresses these two denials.
Thanks.
Regards
-- 
Zito

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="usermanage.deb.patch"

Index: policy/modules/admin/usermanage.te
===================================================================
--- policy/modules/admin/usermanage.te	(revision 2610)
+++ policy/modules/admin/usermanage.te	(working copy)
@@ -153,6 +153,7 @@
 files_read_usr_files(crack_t)
 
 corecmd_exec_bin(crack_t)
+corecmd_exec_shell(crack_t)
 
 libs_use_ld_so(crack_t)
 libs_use_shared_libs(crack_t)

--cNdxnHkX5QqsyA0e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
