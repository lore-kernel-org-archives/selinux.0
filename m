Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB1FdNJx000769
 for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2015 10:39:23 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] secilc/docs: Add documentation for neverallowx rules
Date: Tue, 1 Dec 2015 10:38:30 -0500
Message-ID: <1448984310-17097-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1448984310-17097-1-git-send-email-slawrence@tresys.com>
References: <1448984310-17097-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 secilc/docs/cil_access_vector_rules.xml            | 67 ++++++++++++++++++++++
 .../docs/cil_class_and_permission_statements.xml   |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/secilc/docs/cil_access_vector_rules.xml b/secilc/docs/cil_access_vector_rules.xml
index 985fc3d..e768558 100644
--- a/secilc/docs/cil_access_vector_rules.xml
+++ b/secilc/docs/cil_access_vector_rules.xml
@@ -448,4 +448,71 @@
          </programlisting>
       </sect2>
 
+      <sect2 id="neverallowx">
+         <title>neverallowx</title>
+         <para>Never allow access rights defined for extended permissions. This is a compiler enforced action that will stop compilation until the offending rules are modified.</para>
+         <para>Note that these rules can be over-ridden by the CIL compiler command line parameter <literal>-N</literal> or <literal>--disable-neverallow</literal> flags.</para>
+         <para><emphasis role="bold">Rule definition:</emphasis></para>
+         <programlisting><![CDATA[(neverallowx source_id target_id|self permissionx_id)]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2.25 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal>neverallowx</literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal>neverallowx</literal> keyword.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>source_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>target_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
+                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>permissionx_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single named or anonymous <literal><link linkend="permissionx">permissionx</link></literal>.</para>
+                  </entry>
+               </row>
+            </tbody></tgroup>
+         </informaltable>
+
+         <para><emphasis role="bold">Example:</emphasis></para>
+         <para>This example will not compile as <literal>type_3</literal> is not allowed to be a source type and ioctl range for the <literal><link linkend="allowx">allowx</link></literal> rule:</para>
+         <programlisting><![CDATA[
+(class property_service (ioctl))
+
+(block av_rules
+    (type type_1)
+    (type type_2)
+    (type type_3)
+    (typeattribute all_types)
+    (typeattributeset all_types ((all)))
+
+    (neverallowx type_3 all_types (ioctl property_service (range 0x2000 0x20FF)))
+    ; This rule will fail compilation:
+    (allowx type_3 self (ioctl property_service (0x20A0)))
+)]]>
+         </programlisting>
+      </sect2>
+
    </sect1>
diff --git a/secilc/docs/cil_class_and_permission_statements.xml b/secilc/docs/cil_class_and_permission_statements.xml
index 20c3eb7..f4982e0 100644
--- a/secilc/docs/cil_class_and_permission_statements.xml
+++ b/secilc/docs/cil_class_and_permission_statements.xml
@@ -508,7 +508,7 @@
 
       <sect2 id="permissionx">
          <title>permissionx</title>
-         <para>Defines a named extended permission, which can be used in the <literal><link linkend="allowx">allowx</link></literal>, <literal><link linkend="auditallowx">auditallowx</link></literal>, and <literal><link linkend="dontauditx">dontauditx</link></literal> statements.</para>
+         <para>Defines a named extended permission, which can be used in the <literal><link linkend="allowx">allowx</link></literal>, <literal><link linkend="auditallowx">auditallowx</link></literal>, <literal><link linkend="dontauditx">dontauditx</link></literal>, and <literal><link linkend="neverallowx">neverallowx</link></literal> statements.</para>
          <para><emphasis role="bold">Statement definition:</emphasis></para>
          <programlisting><![CDATA[(permissionx permissionx_id (kind class_id (permission ... | expr ...)))]]></programlisting>
          <para><emphasis role="bold">Where:</emphasis></para>
-- 
2.4.3
