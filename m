Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SGYIrT026427
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 12:34:18 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SGYCdb016769
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 16:34:17 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id EEFE7C0A9
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 17:34:07 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C16KW-0003wS-Qd
	for selinux@tycho.nsa.gov; Sat, 28 Aug 2004 17:45:28 +0100
Date: Sat, 28 Aug 2004 17:45:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patches for xdm.te for kdm 3.3
Message-ID: <20040828164528.GC11546@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i'm running kdm 3.3, also i'm running an "immediate user login" with no
password.

added these to get it to work.

also as you can see i changed the type of /etc/qt3 to etc_runtime_t.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xdm.patch"

--- /usr/share/selinux/policy/default.1.14/domains/program/xdm.te	2004-08-02 08:28:37.000000000 +0100
+++ domains/program/xdm.te	2004-08-28 17:30:08.000000000 +0100
@@ -28,7 +28,7 @@
 # for xdmctl
 allow xdm_t xdm_var_run_t:fifo_file create_file_perms;
 allow initrc_t xdm_var_run_t:fifo_file unlink;
-file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file)
+file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, { dir fifo_file} )
 
 tmp_domain(xdm)
 var_lib_domain(xdm)
@@ -183,7 +183,8 @@
 
 allow xdm_t self:process { setpgid setsched };
 allow xdm_t etc_t:lnk_file read;
-allow xdm_t etc_runtime_t:file { getattr read };
+allow xdm_t etc_runtime_t:file { getattr read lock };
+allow xdm_t etc_runtime_t:dir { getattr search };
 
 # wdm has its own config dir /etc/X11/wdm
 # this is ugly, daemons should not create files under /etc!
@@ -327,3 +328,55 @@
 allow xdm_t crack_db_t:file r_file_perms;
 ')
 r_dir_file(xdm_t, selinux_config_t)
+
+# ARGH. damn qt libraries.
+# had to change /etc/qt3 to etc_runtime_t too
+allow xdm_t etc_runtime_t:file { write };
+	#EXE=/usr/bin/kdm_greet  NAME=.qtrc.lock   :  write
+	#EXE=/usr/bin/kdm_greet  NAME=.qt_plugins_3.2rc.lock   :  write
+	#EXE=/usr/bin/krootimage  NAME=.qtrc.lock   :  write
+	#EXE=/usr/bin/krootimage  NAME=.qt_plugins_3.2rc.lock   :  write
+
+# ARGH.
+dontaudit xdm_t sbin_t:dir { getattr };
+	#EXE=/usr/bin/kdm_greet  PATH=/usr/local/sbin   :  getattr
+	#EXE=/usr/bin/kdm_greet  PATH=/usr/sbin   :  getattr
+	#EXE=/usr/bin/kdm_greet  PATH=/sbin   :  getattr
+
+allow xdm_xserver_t initrc_tmp_t:dir { search };
+	#EXE=/usr/X11R6/bin/XFree86  NAME=.font-unix   :  search
+
+# allow xdm to run halt
+
+allow xdm_t init_t:process { signal };
+	#EXE=/sbin/halt   :  signal
+
+allow xdm_t xdm_t:capability { sys_boot };
+	#EXE=/sbin/halt   :  sys_boot
+
+can_exec(xdm_t, init_exec_t)
+	#EXE=/sbin/shutdown  NAME=init   :  execute
+
+
+allow xdm_xserver_t var_run_t:file { getattr read };
+	#EXE=/usr/X11R6/bin/XFree86  PATH=/var/run/xauth/A:0-4iQaw9   :  getattr
+	#EXE=/bin/cat  NAME=A:0-4iQaw9   :  read
+
+can_exec(xdm_t, xsession_exec_t)
+	#EXE=/usr/bin/kdm  PATH=/etc/kde3/kdm/Xstartup   :  execute_no_trans
+
+
+allow xdm_t xdm_var_run_t:sock_file { create setattr unlink };
+	#EXE=/usr/bin/kdm  NAME=socket   :  create
+
+
+allow xdm_xserver_t zero_device_t:chr_file { read write };
+	#EXE=/usr/X11R6/bin/XFree86  NAME=zero   :  read write
+
+
+allow xdm_t xdm_var_run_t:dir { rmdir setattr create };
+	#EXE=/usr/bin/kdm  NAME=xdmctl   :  create
+
+# to access /var/run/utmp
+allow xdm_t initrc_var_run_t:file { getattr };
+

--C7zPtVaVf+AK4Oqc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
