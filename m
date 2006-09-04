Subject: [PATCH] pam_namespace: add a new option for trusted programs to
	control unmount from pam_sm_close_session
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: sds@tycho.nsa.gov, sgrubb@redhat.com, dwalsh@redaht.com, tmraz@redhat.com,
        klaus@atsec.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 04 Sep 2006 17:04:55 -0400
Message-Id: <1157403895.7223.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch adds a new argument to pam_namespace. This new argument
was needed to support trusted commands such as newrole that 
perform pam_open_session from a child process and pam_close_session
from the parent. With this new argument, no_unmount_on_close, 
pam_sm_close_session will not unmount polyinstantiated directory.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 README.xml          |    8 ++++++++
 pam_namespace.8.xml |   19 +++++++++++++++++++
 pam_namespace.c     |   17 +++++++++++++++++
 pam_namespace.h     |    1 +
 4 files changed, 45 insertions(+)

diff -Naurp Linux-PAM-0.99.6.2-090406/modules/pam_namespace/README.xml Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/README.xml
--- Linux-PAM-0.99.6.2-090406/modules/pam_namespace/README.xml	2006-09-04 17:31:21.000000000 +0000
+++ Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/README.xml	2006-09-04 17:14:16.000000000 +0000
@@ -121,6 +121,14 @@ ARGUMENTS RECOGNIZED:
 	the restrictive mode of 000. Using this option, an administrator
 	can choose to ignore the mode of the instance parent.
 
+    no_unmount_on_close
+	For certain trusted programs such as newrole, open session
+	is called from a child process while the parent perfoms
+	close session and pam end functions. For these commands
+	use this option to instruct pam_close_session to not
+	unmount the bind mounted polyinstantiated directory in the
+	parent.
+
 MODULE SERVICES PROVIDED:
 	session            open_session and close_session
 
diff -Naurp Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.8.xml Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.8.xml
--- Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.8.xml	2006-09-04 17:31:21.000000000 +0000
+++ Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.8.xml	2006-09-04 17:14:00.000000000 +0000
@@ -43,6 +43,9 @@
       <arg choice="opt">
         ignore_instance_parent_mode
       </arg>
+      <arg choice="opt">
+        no_unmount_on_close
+      </arg>
     </cmdsynopsis>
   </refsynopsisdiv>
 
@@ -179,6 +182,22 @@
         </listitem>
       </varlistentry>
 
+      <varlistentry>
+        <term>
+          <option>no_unmount_on_close</option>
+        </term>
+        <listitem>
+          <para>
+	    For certain trusted programs such as newrole, open session
+	    is called from a child process while the parent perfoms
+	    close session and pam end functions. For these commands
+	    use this option to instruct pam_close_session to not
+	    unmount the bind mounted polyinstantiated directory in the
+            parent.
+          </para>
+        </listitem>
+      </varlistentry>
+
     </variablelist>
   </refsect1>
 
diff -Naurp Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.c Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.c
--- Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.c	2006-09-04 17:31:21.000000000 +0000
+++ Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.c	2006-09-04 17:49:54.000000000 +0000
@@ -1266,11 +1266,28 @@ PAM_EXTERN int pam_sm_close_session(pam_
             idata.flags |= PAMNS_DEBUG;
         if (strcmp(argv[i], "ignore_config_error") == 0)
             idata.flags |= PAMNS_IGN_CONFIG_ERR;
+        if (strcmp(argv[i], "no_unmount_on_close") == 0)
+            idata.flags |= PAMNS_NO_UNMOUNT_ON_CLOSE;
     }
 
     if (idata.flags & PAMNS_DEBUG)
         pam_syslog(idata.pamh, LOG_DEBUG, "close_session - start");
 
+    /*
+     * For certain trusted programs such as newrole, open session
+     * is called from a child process while the parent perfoms
+     * close session and pam end functions. For these commands
+     * pam_close_session should not perform the unmount of the
+     * polyinstantiatied directory because it will result in
+     * undoing of parents polyinstantiatiaion. These commands
+     * will invoke pam_namespace with the "no_unmount_on_close"
+     * argument.
+     */
+    if (idata.flags & PAMNS_NO_UNMOUNT_ON_CLOSE) {
+        pam_syslog(idata.pamh, LOG_DEBUG, "close_session - sucessful");
+        return PAM_SUCCESS;
+    }
+
     /* 
      * Lookup user and fill struct items
      */
diff -Naurp Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.h Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.h
--- Linux-PAM-0.99.6.2-090406/modules/pam_namespace/pam_namespace.h	2006-09-04 17:45:45.000000000 +0000
+++ Linux-PAM-0.99.6.2-090406+pnspatch/modules/pam_namespace/pam_namespace.h	2006-09-04 17:43:57.000000000 +0000
@@ -86,6 +86,7 @@
 #define PAMNS_GEN_HASH        0x00002000 /* Generate md5 hash for inst names */
 #define PAMNS_IGN_CONFIG_ERR  0x00004000 /* Ignore format error in conf file */
 #define PAMNS_IGN_INST_PARENT_MODE  0x00008000 /* Ignore instance parent mode */
+#define PAMNS_NO_UNMOUNT_ON_CLOSE  0x00010000 /* no unmount at session close */
 
 /*
  * Polyinstantiation method options, based on user, security context



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
