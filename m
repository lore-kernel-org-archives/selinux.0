Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2SKEmx6002082
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 15:14:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2SKBElY007765
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 20:11:14 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h2SKBEKX007762
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 20:11:14 GMT
Received: from acme ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.12.8/8.9.3) with ESMTP id h2SKEbLF008006
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 15:14:37 -0500
From: "david caplan" <dac@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: usermod/group* patch
Date: Fri, 28 Mar 2003 15:14:36 -0500
Message-ID: <GBEAJBKHFOBIBBJBCGAGEEBGCLAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003A_01C2F53C.BEED70B0"
In-Reply-To: <200303281419.JAA04415@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01C2F53C.BEED70B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Attached is a patch which adds the usermod utility and the corresponding set
of group utilities to the spasswd wrapper utility set.  The patch changes
the Makefile for .../selinux/utils/spasswd and adds a set of policy files
(groupadd.te,fc) for the group utilities.

The .../selinux/utils/spasswd/Makefile patch creates s-wrappers for usermod,
groupadd, groupdel, groupmod, and gpasswd.  These are all similar to
suseradd, suserdel, etc.

The groupadd.te,fc policy used the useradd.te policy as a base. Some rules
and permissions were trimmed out and some dontaudit rules were added.

I generated the patch against the latest cvs version of selinux.

David

------=_NextPart_000_003A_01C2F53C.BEED70B0
Content-Type: application/octet-stream;
	name="group.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="group.patch"

diff -ruN old/nsa/selinux/policy/domains/program/groupadd.te =
new/nsa/selinux/policy/domains/program/groupadd.te=0A=
--- old/nsa/selinux/policy/domains/program/groupadd.te	Wed Dec 31 =
19:00:00 1969=0A=
+++ new/nsa/selinux/policy/domains/program/groupadd.te	Fri Mar 28 =
12:06:02 2003=0A=
@@ -0,0 +1,60 @@=0A=
+#DESC Groupadd - Manage system groups=0A=
+#=0A=
+# Authors:  David Caplan, dac@tresys.com=0A=
+#	    (Based on useradd.te by Chris Vance <cvance@tislabs.com>)=0A=
+#=0A=
+=0A=
+#################################=0A=
+#=0A=
+# Rules for the groupadd_t domain.=0A=
+#=0A=
+# groupadd_t is the domain of the groupadd/mod/del programs when=0A=
+# executed through the sgroupadd/mod/del wrapper.=0A=
+type groupadd_t, domain, privlog, auth, privowner;=0A=
+role sysadm_r types groupadd_t;=0A=
+=0A=
+general_domain_access(groupadd_t)=0A=
+uses_shlib(groupadd_t)=0A=
+=0A=
+type groupadd_exec_t, file_type, sysadmfile, exec_type;=0A=
+domain_auto_trans(sysadm_t, groupadd_exec_t, groupadd_t )=0A=
+=0A=
+# Use capabilities.=0A=
+# need more if users can run gpasswd=0A=
+allow groupadd_t groupadd_t:capability { dac_override };=0A=
+=0A=
+# Allow access to context for shadow file=0A=
+allow groupadd_t security_t:security { context_to_sid };=0A=
+=0A=
+# Inherit and use descriptors from login.=0A=
+allow groupadd_t privfd:fd use;=0A=
+=0A=
+# Execute /usr/sbin/{groupadd,groupdel,groupmod}, /usr/bin/gpasswd.=0A=
+allow groupadd_t { bin_t sbin_t }:dir r_dir_perms;=0A=
+can_exec(groupadd_t, { sbin_t bin_t })=0A=
+=0A=
+# Update /etc/shadow and /etc/passwd=0A=
+file_type_auto_trans(groupadd_t, etc_t, shadow_t)=0A=
+allow groupadd_t etc_t:file create_file_perms;=0A=
+=0A=
+allow groupadd_t { etc_t shadow_t }:file { relabelfrom relabelto };=0A=
+=0A=
+# some apps ask for these accesses, but seems to work regardless=0A=
+dontaudit groupadd_t initrc_var_run_t:file { write };=0A=
+dontaudit groupadd_t { var_run_t device_t var_t }:dir { search };=0A=
+=0A=
+# Access terminals.=0A=
+allow groupadd_t ttyfile:chr_file rw_file_perms;=0A=
+allow groupadd_t ptyfile:chr_file rw_file_perms;=0A=
+ifdef(`gnome-pty-helper.te', `allow groupadd_t gphdomain:fd use;')=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
diff -ruN old/nsa/selinux/policy/file_contexts/program/groupadd.fc =
new/nsa/selinux/policy/file_contexts/program/groupadd.fc=0A=
--- old/nsa/selinux/policy/file_contexts/program/groupadd.fc	Wed Dec 31 =
19:00:00 1969=0A=
+++ new/nsa/selinux/policy/file_contexts/program/groupadd.fc	Fri Mar 28 =
06:43:28 2003=0A=
@@ -0,0 +1,10 @@=0A=
+# groupadd=0A=
+/usr/local/selinux/bin/sgroupadd	system_u:object_r:groupadd_exec_t=0A=
+/usr/local/selinux/bin/sgroupdel	system_u:object_r:groupadd_exec_t=0A=
+/usr/local/selinux/bin/sgroupmod	system_u:object_r:groupadd_exec_t=0A=
+/usr/local/selinux/bin/sgpasswd		system_u:object_r:groupadd_exec_t=0A=
+/usr/bin/sgroupmod		system_u:object_r:groupadd_exec_t=0A=
+/usr/bin/sgroupadd               system_u:object_r:groupadd_exec_t=0A=
+/usr/bin/sgroupdel               system_u:object_r:groupadd_exec_t=0A=
+/usr/bin/sgpasswd               system_u:object_r:groupadd_exec_t=0A=
+=0A=
diff -ruN old/nsa/selinux/policy/file_contexts/program/useradd.fc =
new/nsa/selinux/policy/file_contexts/program/useradd.fc=0A=
--- old/nsa/selinux/policy/file_contexts/program/useradd.fc	Fri Sep 27 =
12:05:17 2002=0A=
+++ new/nsa/selinux/policy/file_contexts/program/useradd.fc	Fri Mar 28 =
06:42:08 2003=0A=
@@ -1,5 +1,7 @@=0A=
 # useradd=0A=
 /usr/local/selinux/bin/suseradd	system_u:object_r:useradd_exec_t=0A=
 /usr/local/selinux/bin/suserdel	system_u:object_r:useradd_exec_t=0A=
+/usr/local/selinux/bin/susermod	system_u:object_r:useradd_exec_t=0A=
+/usr/bin/susermod		system_u:object_r:useradd_exec_t=0A=
 /usr/bin/suseradd               system_u:object_r:useradd_exec_t=0A=
 /usr/bin/suserdel               system_u:object_r:useradd_exec_t=0A=
diff -ruN old/nsa/selinux/utils/spasswd/Makefile =
new/nsa/selinux/utils/spasswd/Makefile=0A=
--- old/nsa/selinux/utils/spasswd/Makefile	Fri Sep 27 10:54:54 2002=0A=
+++ new/nsa/selinux/utils/spasswd/Makefile	Fri Mar 28 06:41:02 2003=0A=
@@ -1,15 +1,21 @@=0A=
 PASSWD=3D/usr/bin/passwd=0A=
+GPASSWD=3D/usr/bin/gpasswd=0A=
 CHFN=3D/usr/bin/chfn=0A=
 CHSH=3D/usr/bin/chsh=0A=
 USERADD=3D/usr/sbin/useradd=0A=
 USERDEL=3D/usr/sbin/userdel=0A=
+USERMOD=3D/usr/sbin/usermod=0A=
+GROUPADD=3D/usr/sbin/groupadd=0A=
+GROUPDEL=3D/usr/sbin/groupdel=0A=
+GROUPMOD=3D/usr/sbin/groupmod=0A=
 VIPW=3D/usr/sbin/vipw=0A=
 =0A=
 CFLAGS +=3D -Wall -g -I/usr/local/selinux/include=0A=
 LDFLAGS +=3D -L/usr/local/selinux/lib=0A=
 LIBS +=3D -lsecure=0A=
 =0A=
-PROGS =3D spasswd sadminpasswd suseradd suserdel svipw schfn schsh=0A=
+PROGS =3D spasswd sadminpasswd suseradd suserdel svipw schfn schsh =
sgpasswd susermod \=0A=
+	sgroupadd sgroupdel sgroupmod=0A=
 DESTDIR =3D /usr/local/selinux/bin=0A=
 =0A=
 all:  $(PROGS)=0A=
@@ -38,6 +44,21 @@=0A=
 schsh.o: spasswd.c=0A=
 	$(CC) $(CFLAGS) -DPASSWD=3D\"$(CHSH)\" -c -o $@ $<=0A=
 =0A=
+sgpasswd.o: spasswd.c=0A=
+	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=3D\"$(GPASSWD)\" -c -o $@ $<=0A=
+=0A=
+susermod.o: spasswd.c=0A=
+	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=3D\"$(USERMOD)\" -c -o $@ $<=0A=
+=0A=
+sgroupadd.o: spasswd.c=0A=
+	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=3D\"$(GROUPADD)\" -c -o $@ $<=0A=
+=0A=
+sgroupdel.o: spasswd.c=0A=
+	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=3D\"$(GROUPDEL)\" -c -o $@ $<=0A=
+=0A=
+sgroupmod.o: spasswd.c=0A=
+	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=3D\"$(GROUPMOD)\" -c -o $@ $<=0A=
+=0A=
 install: all=0A=
 	install -m 555 -o root -g root $(PROGS) $(DESTDIR)=0A=
 =0A=

------=_NextPart_000_003A_01C2F53C.BEED70B0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
