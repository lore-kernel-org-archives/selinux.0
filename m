From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov, slawrence@tresys.com, dgdegra@tycho.nsa.gov
Subject: [PATCH] libsepol: Fix building Xen policy with devicetreecon
Date: Mon, 23 Mar 2015 15:58:32 +0000
Message-Id: <1427126312-14010-1-git-send-email-richard_c_haines@btinternet.com>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Problems fixed:
1) Fix core dump when building CIL policy (corrupted double-linked list)
   by Steve Lawrence <slawrence@tresys.com>
2) Binary policy failed to read with devicetreecon statement.
3) Free path name - With a Xen policy running secilc/valgrind
   there are no memory errors.

Also added devicetreecon statement to CIL policy.cil and updated the CIL
Reference Guide.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/cil/docs/cil_xen_statements.xml | 44 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c         |  2 --
 libsepol/cil/test/policy.cil             |  1 +
 libsepol/src/policydb.c                  |  6 +++--
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/docs/cil_xen_statements.xml b/libsepol/cil/docs/cil_xen_statements.xml
index 1035b68..c72ef6c 100644
--- a/libsepol/cil/docs/cil_xen_statements.xml
+++ b/libsepol/cil/docs/cil_xen_statements.xml
@@ -3,6 +3,7 @@
 
    <sect1>
       <title>Xen Statements</title>
+      <para>Policy version 30 introduced the <literal><link linkend="devicetreecon">devicetreecon</link></literal> statement and also expanded the existing I/O memory range to 64 bits in order to support hardware with more than 44 bits of physical address space (32-bit count of 4K pages).</para>
       <para>See the <ulink url="http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt">"XSM/FLASK Configuration"</ulink> document for further information (<ulink url="http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt"></ulink>)</para>
       <sect2 id="iomemcon">
          <title>iomemcon</title>
@@ -180,4 +181,47 @@
          <programlisting><![CDATA[(pirqcon 33 (unconfined.user object_r unconfined.object low_low))]]></programlisting>
       </sect2>
 
+      <sect2 id="devicetreecon">
+         <title>devicetreecon</title>
+         <para>Label device tree nodes.</para>
+         <para><emphasis role="bold">Statement definition:</emphasis></para>
+         <programlisting><![CDATA[(devicetreecon path context_id)]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal>devicetreecon</literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal>devicetreecon</literal> keyword.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>path</literal></para>
+                  </entry>
+                  <entry>
+                     <para>The device tree path. If this contains spaces enclose within <literal>""</literal>.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>context_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
+                  </entry>
+               </row>
+            </tbody></tgroup>
+         </informaltable>
+
+         <para><emphasis role="bold">Example:</emphasis></para>
+         <para>An anonymous context for the specified path:</para>
+         <programlisting><![CDATA[(devicetreecon "/this is/a/path" (unconfined.user object_r unconfined.object low_low))]]></programlisting>
+      </sect2>
+
    </sect1>
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 973b2d7..92c3e09 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4583,8 +4583,6 @@ void cil_destroy_devicetreecon(struct cil_devicetreecon *devicetreecon)
 		return;
 	}
 
-	free(devicetreecon->path);
-
 	if (devicetreecon->context_str == NULL && devicetreecon->context != NULL) {
 		cil_destroy_context(devicetreecon->context);
 	}
diff --git a/libsepol/cil/test/policy.cil b/libsepol/cil/test/policy.cil
index 9c76cad..25c8545 100644
--- a/libsepol/cil/test/policy.cil
+++ b/libsepol/cil/test/policy.cil
@@ -250,6 +250,7 @@
 	(iomemcon (0 255) system_u_bin_t_l2h)
 	(ioportcon (22 22) system_u_bin_t_l2h)
 	(pcidevicecon 345 system_u_bin_t_l2h)
+	(devicetreecon "/this is/a/path" system_u_bin_t_l2h)
 
 	(constrain (files (read)) (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
 	(constrain char_w (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b45b662..d1c0018 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1274,7 +1274,7 @@ void ocontext_xen_free(ocontext_t **ocontexts)
 			c = c->next;
 			context_destroy(&ctmp->context[0]);
 			context_destroy(&ctmp->context[1]);
-			if (i == OCON_ISID)
+			if (i == OCON_ISID || i == OCON_XEN_DEVICETREE)
 				free(ctmp->u.name);
 			free(ctmp);
 		}
@@ -2559,11 +2559,13 @@ static int ocontext_read_xen(struct policydb_compat_info *info,
 				rc = next_entry(buf, fp, sizeof(uint32_t));
 				if (rc < 0)
 					return -1;
-				len = le32_to_cpu(buf[1]);
+				len = le32_to_cpu(buf[0]);
 				c->u.name = malloc(len + 1);
 				if (!c->u.name)
 					return -1;
 				rc = next_entry(c->u.name, fp, len);
+				if (rc < 0)
+					return -1;
 				c->u.name[len] = 0;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
-- 
2.1.0
