Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m42EUpC2029429
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 10:30:51 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m42EUnJ3029915
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 14:30:50 GMT
Date: Fri, 2 May 2008 16:30:42 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Cc: debian-ssh@lists.debian.org
Subject: [refpolicy] initrc_t access to sshd /proc to adjust OOM killer
Message-ID: <20080502143041.GA26592@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the startup script of Open SSH server on the Debian Sid adjusts the OOM
killer to not kill sshd in the condition of OOM. It simply does

    printf '%s' "$SSHD_OOM_ADJUST" >"/proc/$PID/oom_adj" || true

BTW: I am not certain if this do exactly what was intended, because this
parameter is inherited by all child processes, as one can see using
attached simple script.

Nevertheless I don't know how to enable such write under SE Linux. It
triggers:

[   66.417499] type=1400 audit(1209737438.955:6): avc:  denied  { write
} for  pid=1600 comm="S16ssh" name="oom_adj" dev=proc ino=70952 s
context=system_u:system_r:initrc_t:s0
tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=file

I wrote attached patch, but the denial still appears.

sid:~# sesearch --allow -s initrc_t  -t sshd_t -c file 
WARNING: This policy contained disabled aliases; they have been removed.
Found 3 semantic av rules:
   allow @ttr1634 @ttr2356 : file { ioctl read getattr lock }; 
   allow initrc_t sshd_t : file { ioctl write getattr lock append }; 
   allow initrc_t @ttr2356 : file { ioctl read getattr lock }; 

sid:~# sestatus   
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 22
Policy from config file:        refpolicy
sid:~# uname -a
Linux sid 2.6.25-1-686 #1 SMP Mon Apr 28 13:54:58 UTC 2008 i686 GNU/Linux

What am I doing wrong please?
Best Regards
-- 
Zito

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ps_oom_adj

#!/bin/bash
ps axf|perl -lpe '
    my $adj = "";
    if (m/^\s*(\d+)/) {
	if ( open(my $fh, "<", "/proc/$1/oom_adj") ) {
	    $adj = <$fh>;
	    chomp $adj;
	    close($fh);
	}
    } else {
	$adj = "OMA";
    }
    $_ = sprintf("%3s %s", $adj, $_);
'

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ssh-oom-adj

---
 policy/modules/services/ssh.if |   19 +++++++++++++++++++
 policy/modules/system/init.te  |    2 ++
 2 files changed, 21 insertions(+)

Index: refpolicy-svn/policy/modules/services/ssh.if
===================================================================
--- refpolicy-svn.orig/policy/modules/services/ssh.if	2008-05-02 14:36:38.000000000 +0200
+++ refpolicy-svn/policy/modules/services/ssh.if	2008-05-02 14:37:51.000000000 +0200
@@ -626,6 +626,25 @@
 
 ########################################
 ## <summary>
+##	Allow to write to files of ssh server under /proc
+##	primarily to adjust the OOM killer.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow access.
+##	</summary>
+## </param>
+#
+interface(`ssh_proc_write',`
+	gen_require(`
+		type sshd_t;
+	')
+
+	allow $1 sshd_t:file write_file_perms;
+')
+
+########################################
+## <summary>
 ##	Connect to SSH daemons over TCP sockets.  (Deprecated)
 ## </summary>
 ## <param name="domain">
Index: refpolicy-svn/policy/modules/system/init.te
===================================================================
--- refpolicy-svn.orig/policy/modules/system/init.te	2008-05-02 14:36:43.000000000 +0200
+++ refpolicy-svn/policy/modules/system/init.te	2008-05-02 14:36:43.000000000 +0200
@@ -743,6 +743,8 @@
 
 optional_policy(`
 	ssh_dontaudit_read_server_keys(initrc_t)
+# Debian startup script adjusts OOM killer to not kill sshd.
+	ssh_proc_write(initrc_t)
 ')
 
 optional_policy(`

--vtzGhvizbBRQ85DL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
