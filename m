Subject: Re: Installation of policy source
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <3F624B45.2050109@diyab.net>
References: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
	 <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
	 <3F624B45.2050109@diyab.net>
Content-Type: text/plain
Message-Id: <1063636005.13311.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 10:26:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-09-12 at 18:40, Diyab wrote:
> That's fine if you use rpms but not everyone does.  I agree that the 
> install-src step should be mentioned in the documentation but I don't 
> see any reason it needs to be noted in the makefile.  Once you run 
> install-src you won't be doing it again after it's installed.

This patch includes both rpm-based and non-rpm-based instructions.

--- selinux-doc-1.1/README	2003-08-05 09:06:41.000000000 -0400
+++ selinux-doc/README	2003-09-15 10:21:01.000000000 -0400
@@ -1,6 +1,6 @@
 CHANGES
 -------
-This is a new version of SELinux targeted for submission to mainline Linux.
+This is a new version of SELinux that has been accepted into mainline Linux.
 It diverges from the old SELinux in several respects:
 
 1) The networking hooks that were rejected for 2.5 have been dropped.
@@ -90,13 +90,14 @@
 old SELinux.  See PORTING for a discussion of how the policy has
 changed from the old SELinux.
 
-6) patched libraries, daemons and utilities
+6) patched daemons and utilities
 Several packages have been patched for SELinux.  The SELinux patches
 have been rewritten to use the libselinux interfaces (see PORTING).
 
 There is a patch to glibc (glibc-secureexec.patch) to support secure
 transitions for role/domain changes, but this change has now been
 upstreamed (and is generalized for arbitrary Linux security modules).
+Please verify that your glibc supports the AT_SECURE auxv entry.
 
 Of the other SELinux patches, the most critical patches are the ones
 for login (util-linux-selinux.patch), sshd (openssh-selinux.patch),
@@ -133,35 +134,60 @@
 	Capabilities Support (CONFIG_SECURITY_CAPABILITIES)
 	NSA SELinux Support (CONFIG_SECURITY_SELINUX)
 	NSA SELinux Development Support (CONFIG_SECURITY_SELINUX_DEVELOP)
-
+	NSA SELinux boot parameter (CONFIG_SECURITY_SELINUX_BOOTPARAM)
 
 BUILDING AND INSTALLING
 ------------------------
-0) Obtain the libattr-devel and libattr packages and install them.
-These are required for building libselinux and applications that use
-libselinux functions that performs calls to the xattr API.  You may
-also want to obtain and install the attr package in order to use the
-getfattr and setfattr utilities to directly manipulate the attributes
-of individual files.
-
 1) Configure, build and install the SELinux-patched kernel, and
 configure your boot manager so you can boot it.
-
-It is also recommended that you configure and build a separate kernel
+	cd linux-2.6
+	make menuconfig
+	make 
+	make modules_install
+	make install
+
+If you do not enable the NSA SELinux boot parameter option
+(CONFIG_SECURITY_SELINUX_BOOTPARAM) in your kernel configuration, then
+it is also recommended that you configure and build a separate kernel
 that has the Ext[23] Security Labels options enabled but SELinux
 disabled for use as a maintenance kernel.  This maintenance kernel can
 be used to manipulate the file security labels without interference by
-the SELinux module to perform emergency recovery.  
+the SELinux module to perform emergency recovery.  If you did enable
+the NSA SELinux boot parameter option, then you can simply boot with
+"selinux=0" to disable the SELinux module at boot time to perform
+emergency recovery.
 
 You may want to configure and build a 2.4+EA kernel if you still want
 to boot 2.4 kernels on your system, as unmodified 2.4 kernels will not
 boot after you have assigned the SELinux EAs to the root filesystem.
 
 2) Build and install the checkpolicy policy compiler.
+	rpmbuild -tb checkpolicy-*.tgz
+	rpm -Uvh /usr/src/redhat/RPMS/i386/checkpolicy*.rpm
+
+	-or-
+
+	cd selinux-usr/checkpolicy
+	make install
 
 3) Build and install libselinux.
+	rpmbuild -tb libselinux-*.tgz
+	rpm -Uvh /usr/src/redhat/RPMS/i386/libselinux*.rpm
+
+	-or-
+
+	cd selinux-usr/libselinux
+	make install
+	/sbin/ldconfig
 
 4) Build and install the policy core utilities.
+	rpmbuild -tb policycoreutils-*.tgz
+	rpm -Uvh /usr/src/redhat/RPMS/i386/policycoreutils*.rpm
+
+	-or-
+	
+	cd selinux-usr/policycoreutils
+	make install
 
 5) Customize your policy configuration, and then build and install the policy.
 Customization of the policy includes:
@@ -191,13 +217,32 @@
 configuration will be used in step 10 when you assign extended
 attributes to the filesystem.
 
-6) Build and install the SELinux-patched libraries, daemons and utilities.
+To build and install the policy:
+	rpmbuild -tb policy-*.tgz
+	rpm -Uvh /usr/src/redhat/RPMS/noarch/policy-*.rpm
+
+	-or-
+	
+	cd selinux-usr/policy
+	make install install-src		
+
+6) Build and install the SELinux-patched daemons and utilities.
 Note that the SELinux-patched utilities are now installed directly to
 their standard locations rather than under /usr/local/selinux.  If you 
 have a /usr/local/selinux directory from the old 2.4 SELinux, make sure 
 that you do not include /usr/local/selinux/{bin,sbin} in your path when 
 using the new SELinux, since the APIs are different.
 
+If you build from SRPMs, use the following command to build the binary RPMS:
+	rpmbuild --define "WITH_SELINUX 1" --rebuild *.src.rpm
+Then install the binary RPMs as usual.
+
+You will likely want a version of glibc that handles the AT_SECURE
+auxv entry provided by the kernel so that domain transitions will
+enable glibc secure mode.  Check your glibc to see if such support has
+been added.  The change has been upstreamed and is available in
+rawhide.
+
 7) Create an initrd with load_policy, the binary policy file, and a
 /linuxrc that will perform the initial policy load prior to mounting
 the root filesystem.  For example, you might modify your mkinitrd
@@ -258,11 +303,16 @@
 System processes should have the system_u user identity and the
 system_r role.  Each system process with a different executable should
 have its own separate domain.  If some system processes are running in
-the initrc_t domain, then either we have not moved it into a separate
-domain yet or the pathname for the executable in
-policy/file_contexts/{types.fc,program/*.fc} is not correct.  You
-should either disable any system processes left in the initrc_t domain
-(if you do not need them) or define new domains for them.
+the initrc_t domain, then there are several possible reasons:
+- The .te file for the program wasn't moved up from the
+policy/domains/program/unused directory before building the policy.
+- The pathname for the program in its .fc file (in the
+ policy/file_contexts/program directory) doesn't match your system.
+- A domain has not yet been defined for the program in the example policy.
+
+You should either disable any system processes left in the initrc_t
+domain (if you do not need them) or place them into a different
+domain, possibly defining new domains if necessary.
 
 Your user processes should have your user identity and the sysadm_r
 role.  Your shell and most of its children will have the sysadm_t
@@ -306,9 +356,23 @@
 error in your policy configuration that renders your system
 unuseable).
 
-15) If you subsequently reboot with a non-SELinux kernel, be sure to
-run setfiles again before booting SELinux to reset your file security
-contexts properly.
+You may find the contributed policy/newrules.pl script useful in
+generating additional 'allow' rules from the log messages for your
+policy, but the generated rules should be carefully reviewed to ensure
+that they are consistent with your security goals.  You may find it
+desirable to define new domains and/or types rather than simply
+granting the permission for an existing domain and/or type in order to
+preserve existing security guarantees.  You may also find that certain
+permission denials require other kinds of policy changes, e.g. changes
+to the RBAC or constraints configurations.  You may also find that
+certain permission denials are not fatal to the application and you
+may not want to grant these permissions due to your security goals.
+In that case, you may wish to simply suppress logging of the denial
+via an 'dontaudit' rule.
+
+15) If you subsequently reboot with a non-SELinux kernel (or with
+"selinux=0"), be sure to run setfiles again before booting SELinux to
+reset your file security contexts properly.
 
 
 EXPERIMENTING WITH THE NEW API


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
