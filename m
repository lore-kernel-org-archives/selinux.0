Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k51GqIVd005695
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 12:52:18 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k51GqGPk015110
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 16:52:17 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k51Gq9ro020048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 12:52:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k51Gq9cH248876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 10:52:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k51Gq8C4017542
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 10:52:09 -0600
Message-ID: <447F1B33.9000700@us.ibm.com>
Date: Thu, 01 Jun 2006 12:52:03 -0400
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
MIME-Version: 1.0
To: janak@us.ibm.com
CC: russell@coker.com.au, tmraz@redhat.com, dwalsh@redhat.com,
        valdis.kletnieks@vt.edu, sgrubb@redhat.com, klaus@atsec.com,
        selinux@tycho.nsa.gov
Subject: [PATCH] pam_namespace : option to check instance parent mode and
 man page(s) updates - v2
References: <44710A40.4060309@us.ibm.com> <200605221105.55104.russell@coker.com.au> <4471BA2C.7090806@us.ibm.com> <447E0B6E.5020902@us.ibm.com>
In-Reply-To: <447E0B6E.5020902@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040004080409000907030208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040004080409000907030208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch, which applies on top of the latest pam_namespace in rawhide, 
adds a new command line option to allow an admin to bypass checking of 
the instance parent mode. It also updates namespace.conf and pam_namespace
man pages to add text relating this new option, interaction with 
share-subtree and possible config changes that would allow the use of
pam_namespace with gdm and polyinstantiation of /tmp. 

The only changes to this patch since the last time it was posted on
the selinux mailing list yesterday, are the documentation updates to
change the instance parent mode references to 000 from 1000. Sticky
bits are not needed since the directory itself is not writable.

Signed-off-by: Janak Desai <janak@us.ibm.com>

--- 

README               |   95 ++++++++++++++++++++++++++++++--------------------- namespace.conf       |   22 +++++++++--
 namespace.conf.5.xml |   42 +++++++++++++---------
 pam_namespace.8.xml  |   79 ++++++++++++++++++++++++++++++++++++++++++
 pam_namespace.c      |   49 +++++++++++++++++++++++++-
 5 files changed, 227 insertions(+), 60 deletions(-)





--------------040004080409000907030208
Content-Type: text/x-patch;
 name="pns0530a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pns0530a.patch"

diff -Naurp pam_namespace0530/modules/pam_namespace/README pam_namespace0530+patch/modules/pam_namespace/README
--- pam_namespace0530/modules/pam_namespace/README	2006-05-31 18:57:41.000000000 +0000
+++ pam_namespace0530+patch/modules/pam_namespace/README	2006-06-01 16:31:44.000000000 +0000
@@ -3,17 +3,17 @@ pam_namespace module:
 Setup a private namespace with polyinstantiated directories.
 
 THEORY OF OPERATION:
-The pam namespace module consults /etc/security/namespace.conf 
+The pam namespace module consults /etc/security/namespace.conf
 configuration file and sets up a private namespace with polyinstantiated
 directories for a session managed by PAM. A skeleton namespace.conf
-installed by default provides example for polyinstantiating /tmp 
+installed by default provides example for polyinstantiating /tmp, /var/tmp
 and users' home directory.
 
 If an executable script /etc/security/namespace.init exists, it
 is used to initialize the namespace every time a new instance directory
 is created. The script receives the polyinstantiated directory path
 and the instance directory path as its arguments.
-                        
+
 Each line in namespace.conf describes a limit for a user in the form:
 
 <polydir>  <instance_prefix>  <method>  <list_of_uids>
@@ -29,7 +29,7 @@ Where:
         the prefix to generate the final instance directory path.
         This directory is created if it did not exist already, and is then
 	bind mounted on the <polydir> to provide an instance of <polydir>
-	based on the <method> column. The special string $HOME is replaced with 
+	based on the <method> column. The special string $HOME is replaced with
 	the user's home directory, and $USER with the username.
 	This field cannot be blank.
 
@@ -54,43 +54,60 @@ EXAMPLE /etc/security/namespace.conf con
 # /var/tmp, whereas home directories will be polyinstantiated for all
 # users. The user name and/or context is appended to the instance prefix.
 #
-/tmp     /tmp-inst/       both      root,adm
-/var/tmp /var/tmp-inst/   both      root,adm
-$HOME    $HOME.inst-      context
-    
-ARGUMENTS RECOGNIZED:
-    debug		Verbose logging by syslog
+# Note that instance directories do not have to reside inside the
+# polyinstantiated directory. In the examples below, instances of /tmp
+# will be created in /tmp-inst directory, where as instances of /var/tmp
+# and users home directories will reside within the directories that
+# are being polyinstantiated.
+#
+# Instance parent directories must exist for the polyinstantiation
+# mechanism to work. By default, they should be created with the mode
+# of 000. pam_namespace module will enforce this mode unless it
+# is explicitly called with an argument to ignore the mode of the
+# instance parent. System administrators should use this argument with
+# caution, as it will reduce security and isolation achieved by
+# polyinstantiation.
+#
+/tmp     /tmp-inst/       	both      root,adm
+/var/tmp /var/tmp/tmp-inst/   	both      root,adm
+$HOME    $HOME/$USER.inst/inst- context
 
-    unmnt_remnt		For programs such as su and newrole, the login
-			session has already setup a polyinstantiated 
-			namespace. For these programs, polyinstantiation
-			is performed based on new user id or security
-			context, however the command first needs to 
-			undo the polyinstantiation performed by login.
-			This argument instructs the command to 
-			first undo previous polyinstantiation before
-			proceeding with new polyinstantiation based on
-			new id/context.
-
-    unmnt_only		For trusted programs that want to undo any
-			existing bind mounts and process instance 
-			directories on their own, this argument allows
-			them to unmount currently mounted instance
-			directories.
-
-    require_selinux	If selinux is not enabled, return failure.
-
-    gen_hash		Instead of using the security context string
-			for the instance name, generate and use its
-			md5 hash.
-
-    ignore_config_error	If a line in the configuration file corresponding
-			to a polyinstantiated directory contains format
-			error, skip that line process the next line.
-			Without this option, pam will return an error
-			to the calling program resulting in termination
-			of the session.
+ARGUMENTS RECOGNIZED:
+    debug
+	Verbose logging by syslog
 
+    unmnt_remnt
+	For programs such as su and newrole, the login session has
+	already setup a polyinstantiated namespace. For these programs,
+	polyinstantiation is performed based on new user id or security
+	context, however the command first needs to undo the
+	polyinstantiation performed by login. This argument instructs
+	the command to first undo previous polyinstantiation before
+	proceeding with new polyinstantiation based on new id/context.
+
+    unmnt_only
+	For trusted programs that want to undo any existing bind mounts
+	and process instance directories on their own, this argument
+	allows them to unmount currently mounted instance directories.
+
+    require_selinux
+	If selinux is not enabled, return failure.
+
+    gen_hash
+	Instead of using the security context string for the instance
+	name, generate and use its md5 hash.
+
+    ignore_config_error
+	If a line in the configuration file corresponding to a
+	polyinstantiated directory contains format error, skip that
+	line process the next line. Without this option, pam will return
+	an error to the calling program resulting in termination
+	of the session.
+
+    ignore_instance_parent_mode
+	Instance parent directories by default are expected to have
+	the restrictive mode of 000. Using this option, an administrator
+	can choose to ignore the mode of the instance parent.
 
 MODULE SERVICES PROVIDED:
 	session            open_session and close_session
diff -Naurp pam_namespace0530/modules/pam_namespace/namespace.conf pam_namespace0530+patch/modules/pam_namespace/namespace.conf
--- pam_namespace0530/modules/pam_namespace/namespace.conf	2006-05-31 18:57:41.000000000 +0000
+++ pam_namespace0530+patch/modules/pam_namespace/namespace.conf	2006-06-01 16:31:44.000000000 +0000
@@ -1,7 +1,7 @@
 # /etc/security/namespace.conf
 #
 # See /usr/share/doc/pam-*/txts/README.pam_namespace for more information.
-# 
+#
 # Uncommenting the following three lines will polyinstantiate
 # /tmp, /var/tmp and user's home directories. /tmp and /var/tmp will
 # be polyinstantiated based on both security context as well as user
@@ -11,6 +11,20 @@
 # directories will be polyinstantiated for all users. The user name
 # and/or context is appended to the instance prefix.
 #
-#/tmp     /tmp.inst/          both      adm
-#/var/tmp /var/tmp.inst/      both      adm
-#$HOME    $HOME.inst-         context
+# Note that instance directories do not have to reside inside the
+# polyinstantiated directory. In the examples below, instances of /tmp
+# will be created in /tmp-inst directory, where as instances of /var/tmp
+# and users home directories will reside within the directories that
+# are being polyinstantiated.
+#
+# Instance parent directories must exist for the polyinstantiation
+# mechanism to work. By default, they should be created with the mode
+# of 000. pam_namespace module will enforce this mode unless it
+# is explicitly called with an argument to ignore the mode of the
+# instance parent. System administrators should use this argument with
+# caution, as it will reduce security and isolation achieved by
+# polyinstantiation.
+#
+#/tmp     /tmp-inst/       	both      root,adm
+#/var/tmp /var/tmp/tmp-inst/   	both      root,adm
+#$HOME    $HOME/$USER.inst/inst- context
diff -Naurp pam_namespace0530/modules/pam_namespace/namespace.conf.5.xml pam_namespace0530+patch/modules/pam_namespace/namespace.conf.5.xml
--- pam_namespace0530/modules/pam_namespace/namespace.conf.5.xml	2006-05-31 18:57:41.000000000 +0000
+++ pam_namespace0530+patch/modules/pam_namespace/namespace.conf.5.xml	2006-06-01 16:31:44.000000000 +0000
@@ -43,7 +43,7 @@
    </para>
 
     <para>
-      <replaceable>polydir</replaceable> <replaceable>instance_prefex</replaceable> <replaceable>method</replaceable> <replaceable>list_of_uids</replaceable>
+      <replaceable>polydir</replaceable> <replaceable> instance_prefix</replaceable> <replaceable> method</replaceable> <replaceable> list_of_uids</replaceable>
     </para>
 
     <para>
@@ -59,11 +59,14 @@
       of &lt;polydir&gt;. The directory security context, or optionally its
       md5sum string (32 hex characters), is appended to the prefix to
       generate the final instance directory path. This directory is
-      created if it did not exist already, and is then bind mounted on
-      the &lt;polydir&gt; to provide an instance of &lt;polydir&gt; based on the
+      created if it did not exist already, and is then bind mounted on the
+      &lt;polydir&gt; to provide an instance of &lt;polydir&gt; based on the
       &lt;method&gt; column. The special string $HOME is replaced with the
-      user's home directory, and $USER with the username. This field
-      cannot be blank.
+      user's home directory, and $USER with the username. This field cannot
+      be blank. The directory where polyinstantiated instances are to be
+      created, must exist and must have, by default, the mode of 000.  The
+      requirement that the instance parent be of mode 000 can be overridden
+      with the command line option &lt;ignore_instance_parent_mode&gt;
     </para>
 
     <para>
@@ -92,20 +95,27 @@
       <filename>/etc/security/namespace.conf</filename>.
     </para>
 
-    <para>
+    <literallayout>
       # The following three lines will polyinstantiate /tmp,
       # /var/tmp and user's home directories. /tmp and /var/tmp
-      # will be polyinstantiated based on both security context as well
-      # as user name, whereas home directory will be polyinstantiated
-      # based on security context only. Polyinstantiation will not be
-      # performed for user root and adm for directories /tmp and
-      # /var/tmp, whereas home directories will be polyinstantiated for
-      # all users.
+      # will be polyinstantiated based on both security context
+      # as well as user name, whereas home directory will be
+      # polyinstantiated based on security context only.
+      # Polyinstantiation will not be performed for user root
+      # and adm for directories /tmp and /var/tmp, whereas home
+      # directories will be polyinstantiated for all users.
       #
-      /tmp     /tmp/tmp.inst-$USER-       both      root,adm
-      /var/tmp /var/tmp/tmp.inst-$USER-   both      root,adm
-      $HOME    $HOME.inst-                context
-    </para>
+      # Note that instance directories do not have to reside inside
+      # the polyinstantiated directory. In the examples below,
+      # instances of /tmp will be created in /tmp-inst directory,
+      # where as instances of /var/tmp and users home directories
+      # will reside within the directories that are being
+      # polyinstantiated.
+      #
+      /tmp     /tmp-inst/       	both      root,adm
+      /var/tmp /var/tmp/tmp-inst/   	both      root,adm
+      $HOME    $HOME/$USER.inst/inst- context
+    </literallayout>
 
     <para>
       For the &lt;service&gt;s you need polyinstantiation (login for example)
diff -Naurp pam_namespace0530/modules/pam_namespace/pam_namespace.8.xml pam_namespace0530+patch/modules/pam_namespace/pam_namespace.8.xml
--- pam_namespace0530/modules/pam_namespace/pam_namespace.8.xml	2006-05-31 18:57:41.000000000 +0000
+++ pam_namespace0530+patch/modules/pam_namespace/pam_namespace.8.xml	2006-06-01 16:31:44.000000000 +0000
@@ -40,6 +40,9 @@
       <arg choice="opt">
         ignore_config_error
       </arg>
+      <arg choice="opt">
+        ignore_instance_parent_mode
+      </arg>
     </cmdsynopsis>
   </refsynopsisdiv>
 
@@ -56,6 +59,19 @@
       directory is created. The script receives the polyinstantiated
       directory path and the instance directory path as its arguments.
     </para>
+
+    <para>
+      The pam_namespace module disassociates the session namespace from
+      the parent namespace. Any mounts/unmounts performed in the parent
+      namespace, such as mounting of devices, are not reflected in the
+      session namespace. To propogate selected mount/unmount events from
+      the parent namespace into the disassociated session namespace, an
+      administrator may use the special shared-subtree feature. For
+      additional information on shared-subtree feature, please refer to
+      the mount(8) man page and the shared-subtree description at
+      http://lwn.net/Articles/159077 and http://lwn.net/Articles/159092.
+    </para>
+
   </refsect1>
 
   <refsect1 id="pam_namespace-options">
@@ -148,6 +164,21 @@
         </listitem>
       </varlistentry>
 
+      <varlistentry>
+        <term>
+          <option>ignore_instance_parent_mode</option>
+        </term>
+        <listitem>
+          <para>
+	    Instance parent directories by default are expected to have
+	    the restrictive mode of 000. Using this option, an administrator
+	    can choose to ignore the mode of the instance parent. This option
+            should be used with caution as it will reduce security and
+            isolation goals of the polyinstantiation mechanism.
+          </para>
+        </listitem>
+      </varlistentry>
+
     </variablelist>
   </refsect1>
 
@@ -200,6 +231,51 @@
     </variablelist>
   </refsect1>
 
+  <refsect1 id="pam_namespace-examples">
+    <title>EXAMPLES</title>
+
+    <para>
+      For the &lt;service&gt;s you need polyinstantiation (login for example)
+      put the following line in /etc/pam.d/&lt;service&gt; as the last line for
+      session group:
+    </para>
+
+    <para>
+      session  required  pam_namespace.so [arguments]
+    </para>
+
+    <para>
+      To use polyinstantiation with graphical display manager gdm, insert the
+      following line, before exit 0, in /etc/gdm/PostSession/Default:
+    </para>
+
+    <para>
+      /usr/sbin/gdm-safe-restart
+    </para>
+
+    <para>
+      This allows gdm to restart after each session and appropriately adjust
+      namesapces of display manager and the X server. If polyinstantiation of
+      /tmp is desired along with the graphical environment, then addtional
+      configuration changes are needed to address the interaction of X server
+      and font server namespaces with their use of /tmp to create communication
+      sockets. Perform the following changes to use graphical environment
+      with polyinstantiation of /tmp:
+    </para>
+
+    <para>
+    <literallayout>
+      1. Setup default init state to 3, by modifying /etc/inittab
+      2. Disable the use of font server by commenting out "FontPath"
+         line in /etc/X11/xorg.conf.
+      3. Ensure that the login service is setup to use pam_namespace,
+         as described above, by modifying /etc/pam.d/login.
+      4. Use the "startx" command after a successful terminal login.
+    </literallayout>
+    </para>
+
+  </refsect1>
+
   <refsect1 id="pam_namespace-see_also">
     <title>SEE ALSO</title>
     <para>
@@ -210,6 +286,9 @@
         <refentrytitle>pam.d</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>,
       <citerefentry>
+        <refentrytitle>mount</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
         <refentrytitle>pam</refentrytitle><manvolnum>8</manvolnum>
       </citerefentry>.
     </para>
diff -Naurp pam_namespace0530/modules/pam_namespace/pam_namespace.c pam_namespace0530+patch/modules/pam_namespace/pam_namespace.c
--- pam_namespace0530/modules/pam_namespace/pam_namespace.c	2006-05-31 18:57:41.000000000 +0000
+++ pam_namespace0530+patch/modules/pam_namespace/pam_namespace.c	2006-06-01 16:31:44.000000000 +0000
@@ -85,6 +85,7 @@
 #define PAMNS_CTXT_BASED_INST 0x00000800 /* Context based instance needed */
 #define PAMNS_GEN_HASH        0x00002000 /* Generate md5 hash for inst names */
 #define PAMNS_IGN_CONFIG_ERR  0x00004000 /* Ignore format error in conf file */
+#define PAMNS_IGN_INST_PARENT_MODE  0x00008000 /* Ignore instance parent mode */
 
 /*
  * Polyinstantiation method options, based on user, security context
@@ -630,8 +631,9 @@ static int create_dirs(const struct poly
 	struct instance_data *idata)
 #endif
 {
-    struct stat statbuf, newstatbuf;
+    struct stat statbuf, newstatbuf, instpbuf;
     int fd, pid, status;
+    char *inst_parent, *trailing_slash;
 
     /*
      * stat the directory to polyinstantiate, so its owner-group-mode
@@ -653,6 +655,49 @@ static int create_dirs(const struct poly
     }
 
     /*
+     * stat the instance parent path to make sure it exists
+     * and is a directory. Check that its mode is 000 (unless the
+     * admin explicitly instructs to ignore the instance parent
+     * mode by the "ignore_instance_parent_mode" argument).
+     */
+    inst_parent = (char *) malloc(strlen(ipath)+1);
+    if (!inst_parent) {
+	pam_syslog(idata->pamh, LOG_ERR, "Error allocating pathname string");
+        return PAM_SESSION_ERR;
+    }
+
+    strcpy(inst_parent, ipath);
+    trailing_slash = strrchr(inst_parent, '/');
+    if (trailing_slash)
+        *trailing_slash = '\0';
+
+    if (stat(inst_parent, &instpbuf) < 0) {
+        pam_syslog(idata->pamh, LOG_ERR, "Error stating %s, %m", inst_parent);
+        free(inst_parent);
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * Make sure we are dealing with a directory
+     */
+    if (!S_ISDIR(instpbuf.st_mode)) {
+	pam_syslog(idata->pamh, LOG_ERR, "Instance parent %s is not a dir",
+		inst_parent);
+        free(inst_parent);
+        return PAM_SESSION_ERR;
+    }
+
+    if ((idata->flags & PAMNS_IGN_INST_PARENT_MODE) == 0) {
+        if (instpbuf.st_mode & (S_IRWXU|S_IRWXG|S_IRWXO)) {
+	    pam_syslog(idata->pamh, LOG_ERR, "Mode of inst parent %s not 000",
+		    inst_parent);
+            free(inst_parent);
+            return PAM_SESSION_ERR;
+        }
+    }
+    free(inst_parent);
+
+    /*
      * Create instance directory and set its security context to the context
      * returned by the security policy. Set its mode and ownership
      * attributes to match that of the original directory that is being
@@ -1157,6 +1202,8 @@ PAM_EXTERN int pam_sm_open_session(pam_h
             idata.flags |= PAMNS_GEN_HASH;
         if (strcmp(argv[i], "ignore_config_error") == 0)
             idata.flags |= PAMNS_IGN_CONFIG_ERR;
+        if (strcmp(argv[i], "ignore_instance_parent_mode") == 0)
+            idata.flags |= PAMNS_IGN_INST_PARENT_MODE;
         if (strcmp(argv[i], "unmnt_remnt") == 0)
             unmnt = UNMNT_REMNT;
         if (strcmp(argv[i], "unmnt_only") == 0)

--------------040004080409000907030208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
