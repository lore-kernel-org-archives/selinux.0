Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BFHbZI019938
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 11:17:37 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BFGk0o009067
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 15:16:47 GMT
Subject: Re: Supporting multiple python versions
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157983761.26420.46.camel@sgc>
References: <1157729493.31336.14.camel@wintermute.xmldesign.de>
	 <200609091116.10256.russell@coker.com.au>  <1157983761.26420.46.camel@sgc>
Content-Type: multipart/mixed; boundary="=-KgN4CySXSwNbAlpLcAur"
Date: Mon, 11 Sep 2006 17:12:41 +0200
Message-Id: <1157987561.15350.49.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KgN4CySXSwNbAlpLcAur
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Christopher,
Attached is my current version of adding python multiversion
precompilation support. It supports the multiversion case okay, but I
fear it doesn't support private modules yet.
Some applications, lets say mailman, won't be run with different python
versions. They'll always use the default python version (in constrast to
python libraries). These won't have their .pyc files
in /var/lib/python-support apparently...
But that would mean python-support also needs to be able to write /usr
(python-support is called during package installation or python upgrade;
lets say Debian switches /usr/bin/python from 2.4 to 2.5, then
upgrade-python-modules will recompile all private python modules).
Should we
- allow python-support to write usr_t (it's only run by dpkg_t or
sysadm_t, both of which can write usr_t anyway; no regular user should
be allowed into pythoncompile_t)
- make a file context like ^/usr/(.*)\.pyc$ -f as python_compiled_t and
add a filetrans rule usr_t python_compiled_t for pythoncompile_t?

best regards,
Erich Schubert
--=20
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  There is no branch of mathematics, however abstract, which may not  //\
 some day be applied to phenomena of the real world. --- Lobatchevsky V_/=
_
                F=FCr jedes Problem gibt es eine L=F6sung,
                   die einfach, klar und falsch ist.

--=-KgN4CySXSwNbAlpLcAur
Content-Disposition: attachment; filename=python-support.diff
Content-Type: text/x-patch; name=python-support.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: policy/modules/system/pythonsupport.fc
===================================================================
--- policy/modules/system/pythonsupport.fc	(Revision 0)
+++ policy/modules/system/pythonsupport.fc	(Revision 223)
@@ -0,0 +1,2 @@
+/usr/sbin/update-python-modules	--	gen_context(system_u:object_r:pythoncompile_exec_t,s0)
+/var/lib/python-support(/.*)?		gen_context(system_u:object_r:python_compiled_t,s0)
Index: policy/modules/system/userdomain.if
===================================================================
--- policy/modules/system/userdomain.if	(Revision 222)
+++ policy/modules/system/userdomain.if	(Revision 223)
@@ -835,6 +835,10 @@
 	')
 
 	optional_policy(`
+		pythonsupport_compiled_read($1_t)
+	')
+
+	optional_policy(`
 		quota_dontaudit_getattr_db($1_t)
 	')
 
Index: policy/modules/system/pythonsupport.te
===================================================================
--- policy/modules/system/pythonsupport.te	(Revision 0)
+++ policy/modules/system/pythonsupport.te	(Revision 223)
@@ -0,0 +1,44 @@
+policy_module(pythonsupport,0.0.1)
+
+########################################
+#
+# Declarations
+#
+
+type pythoncompile_t;
+type pythoncompile_exec_t;
+domain_type(pythoncompile_t)
+domain_entry_file(pythoncompile_t, pythoncompile_exec_t)
+
+role system_r types pythoncompile_t;
+role sysadm_r types pythoncompile_t;
+
+type python_compiled_t;
+files_type(python_compiled_t)
+
+########################################
+#
+# python-support local policy
+#
+
+kernel_read_system_state(pythoncompile_t)
+kernel_read_kernel_sysctls(pythoncompile_t)
+
+corecmd_exec_bin(pythoncompile_t)
+corecmd_exec_sbin(pythoncompile_t)
+
+files_read_etc_files(pythoncompile_t)
+files_read_usr_files(pythoncompile_t)
+
+libs_use_ld_so(pythoncompile_t)
+libs_use_shared_libs(pythoncompile_t)
+libs_use_lib_files(pythoncompile_t)
+
+miscfiles_read_localization(pythoncompile_t)
+
+
+# create compiled python modules
+allow pythoncompile_t python_compiled_t:dir manage_dir_perms;
+allow pythoncompile_t python_compiled_t:file manage_file_perms;
+allow pythoncompile_t python_compiled_t:lnk_file manage_file_perms;
+files_var_lib_filetrans(pythoncompile_t, python_compiled_t, dir)
Index: policy/modules/system/selinuxutil.te
===================================================================
--- policy/modules/system/selinuxutil.te	(Revision 222)
+++ policy/modules/system/selinuxutil.te	(Revision 223)
@@ -624,6 +624,10 @@
 	userdom_read_generic_user_home_content_files(semanage_t)
 ')
 
+optional_policy(`
+	pythonsupport_compiled_read(semanage_t)
+')
+
 ########################################
 #
 # Setfiles local policy
Index: policy/modules/system/pythonsupport.if
===================================================================
--- policy/modules/system/pythonsupport.if	(Revision 0)
+++ policy/modules/system/pythonsupport.if	(Revision 223)
@@ -0,0 +1,55 @@
+## <summary>Support for precompiling python modules</summary>
+## <desc>
+##	<p>
+##		Debians python-support will precompile installed python
+##		packages for installed python versions. This way,
+##		the python2.3-foobar and python2.4-foobar (and 2.5) packages
+##		could be merged into one python-foobar while keeping the
+##		dependency information useful.
+##	</p>
+## </desc>
+#
+
+########################################
+## <summary>
+##	Execute the python-support utility to precompile modules.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`pythonsupport_domtrans',`
+	gen_require(`
+		type pythoncompile_t, pythoncompile_exec_t;
+	')
+
+	domain_auto_trans($1,pythoncompile_exec_t,pythoncompile_t)
+
+	allow $1 pythoncompile_t:fd use;
+	allow pythoncompile_t $1:fd use;
+	allow $1 pythoncompile_t:fifo_file rw_file_perms;
+	allow $1 pythoncompile_t:process sigchld;
+')
+
+########################################
+## <summary>
+##	Read compiled python modules
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to read the compiled python modules.
+##	</summary>
+## </param>
+#
+interface(`pythonsupport_compiled_read',`
+	gen_require(`
+		type python_compiled_t;
+	')
+
+	files_search_var_lib($1)
+	allow $1 python_compiled_t:dir r_dir_perms;
+	allow $1 python_compiled_t:file r_file_perms;
+	allow $1 python_compiled_t:lnk_file r_file_perms;
+')
Index: policy/modules/admin/apt.te
===================================================================
--- policy/modules/admin/apt.te	(Revision 222)
+++ policy/modules/admin/apt.te	(Revision 223)
@@ -125,6 +125,10 @@
 #')
 
 optional_policy(`
+	pythonsupport_domtrans(apt_t)
+')
+
+optional_policy(`
 	# dpkg interaction
 	dpkg_read_db(apt_t)
 	dpkg_domtrans(apt_t)

--=-KgN4CySXSwNbAlpLcAur--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
