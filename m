Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7VCsTah016574
 for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2015 08:54:36 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH v2 3/3] secilc: Add documentation/examples for allowx,
 auditallowx, dontauditx, and permissionx
Date: Mon, 31 Aug 2015 08:53:57 -0400
Message-ID: <1441025637-18267-4-git-send-email-slawrence@tresys.com>
In-Reply-To: <1441025637-18267-1-git-send-email-slawrence@tresys.com>
References: <1441025637-18267-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Also removes *bounds statements in policy.cil, which had bounds
violations and are better tested in other test files.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 secilc/docs/cil_access_vector_rules.xml            | 172 +++++++++++++++++++++
 .../docs/cil_class_and_permission_statements.xml   |  95 ++++++++++++
 secilc/docs/cil_container_statements.xml           |  23 ++-
 secilc/test/policy.cil                             |   9 +-
 4 files changed, 288 insertions(+), 11 deletions(-)

diff --git a/secilc/docs/cil_access_vector_rules.xml b/secilc/docs/cil_access_vector_rules.xml
index d3ce095..985fc3d 100644
--- a/secilc/docs/cil_access_vector_rules.xml
+++ b/secilc/docs/cil_access_vector_rules.xml
@@ -276,4 +276,176 @@
          </programlisting>
       </sect2>
 
+      <sect2 id="allowx">
+         <title>allowx</title>
+         <para>Specifies the access allowed between a source and target type using extended permissions. Unlike the <literal><link linkend="allow">allow</link></literal> statement, the statements <literal><link linkend="validatetrans">validatetrans</link></literal>, <literal><link linkend="mlsvalidatetrans">mlsvalidatetrans</link></literal>, <literal><link linkend="constrain">constrain</link></literal>, and <literal><link linkend="mlsconstrain">mlsconstrain</link></literal> do not limit accesses granted by <literal><link linkend="allowx">allowx</link></literal>.</para>
+         <para><emphasis role="bold">Rule definition:</emphasis></para>
+         <programlisting><![CDATA[(allowx source_id target_id|self permissionx_id)]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2.25 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal><link linkend="allowx">allowx</link></literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal><link linkend="allowx">allowx</link></literal> keyword.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>source_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal>, or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>target_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal>, or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
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
+         <para><emphasis role="bold">Examples:</emphasis></para>
+         <para>These examples show a selection of possible permutations of <literal><link linkend="allowx">allowx</link></literal> rules:</para>
+         <programlisting><![CDATA[
+(allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
+
+(permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
+(allowx type_3 type_4 ioctl_nodebug)
+]]>
+
+         </programlisting>
+      </sect2>
+
+      <sect2 id="auditallowx">
+         <title>auditallowx</title>
+         <para>Audit the access rights defined if there is a valid <literal><link linkend="allowx">allowx</link></literal> rule. It does NOT allow access, it only audits the event.</para>
+         <para><emphasis role="bold">Rule definition:</emphasis></para>
+         <programlisting><![CDATA[(auditallowx source_id target_id|self permissionx_id)]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2.25 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal><link linkend="auditallowx">auditallowx</link></literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal><link linkend="auditallowx">auditallowx</link></literal> keyword.</para>
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
+         <para><emphasis role="bold">Examples:</emphasis></para>
+         <para>This example will log an audit event whenever the corresponding <literal><link linkend="allowx">allowx</link></literal> rule grants access to the specified extended permissions:</para>
+         <programlisting><![CDATA[
+(allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
+
+(auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
+]]>
+         </programlisting>
+      </sect2>
+
+      <sect2 id="dontauditx">
+         <title>dontauditx</title>
+         <para>Do not audit the access rights defined when access denied. This stops excessive log entries for known events.</para>
+         <para>Note that these rules can be omitted by the CIL compiler command line parameter <literal>-D</literal> or <literal>--disable-dontaudit</literal> flags.</para>
+         <para><emphasis role="bold">Rule definition:</emphasis></para>
+         <programlisting><![CDATA[(dontauditx source_id target_id|self permissionx_id)]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2.25 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal><link linkend="dontauditx">dontauditx</link></literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal><link linkend="dontauditx">dontauditx</link></literal> keyword.</para>
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
+         <para><emphasis role="bold">Examples:</emphasis></para>
+         <para>This example will not audit the denied access:</para>
+         <programlisting><![CDATA[
+(dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
+]]>
+         </programlisting>
+      </sect2>
+
    </sect1>
diff --git a/secilc/docs/cil_class_and_permission_statements.xml b/secilc/docs/cil_class_and_permission_statements.xml
index 25929b1..2926d7c 100644
--- a/secilc/docs/cil_class_and_permission_statements.xml
+++ b/secilc/docs/cil_class_and_permission_statements.xml
@@ -490,4 +490,99 @@
          </programlisting>
       </sect2>
 
+      <sect2 id="permissionx">
+         <title>permissionx</title>
+         <para>Defines a named extended permission, which can be used in the <literal><link linkend="allowx">allowx</link></literal>, <literal><link linkend="auditallowx">auditallowx</link></literal>, and <literal><link linkend="dontauditx">dontauditx</link></literal> statements.</para>
+         <para><emphasis role="bold">Statement definition:</emphasis></para>
+         <programlisting><![CDATA[(permissionx permissionx_id (kind class_id (permission ... | expr ...)))]]></programlisting>
+         <para><emphasis role="bold">Where:</emphasis></para>
+         <informaltable frame="all">
+            <tgroup cols="2">
+            <colspec colwidth="2.25 *"/>
+            <colspec colwidth="6 *"/>
+               <tbody>
+               <row>
+                  <entry>
+                     <para><literal><link linkend="permissionx">permissionx</link></literal></para>
+                  </entry>
+                  <entry>
+                     <para>The <literal><link linkend="permissionx">permissionx</link></literal> keyword.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>kind</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A keyword specifying how to interpret the extended permission values. Must be one of:</para>
+                     <para>
+                        <informaltable frame="all">
+                           <tgroup cols="2">
+                              <colspec colwidth=".5 in"/>
+                              <colspec colwidth="*"/>
+                              <thead>
+                              <row>
+                                 <entry align="center">
+                                    <para><emphasis role="bold">kind</emphasis></para>
+                                 </entry>
+                                 <entry align="center">
+                                    <para><emphasis role="bold">description</emphasis></para>
+                                 </entry>
+                              </row>
+                              </thead>
+                              <tbody>
+                              <row>
+                                 <entry>
+                                    <para>ioctl</para>
+                                 </entry>
+                                 <entry>
+                                    <para>Permissions define a whitelist of ioctl values. Permission values must range from <literal>0x0000</literal> to <literal>0xFFFF</literal>, inclusive.</para>
+                                 </entry>
+                              </row>
+                           </tbody></tgroup>
+                        </informaltable>
+                     </para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>class_id</literal></para>
+                  </entry>
+                  <entry>
+                     <para>A single previously declared <literal><link linkend="class">class</link></literal> identifier.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>permission</literal></para>
+                  </entry>
+                  <entry>
+                     <para>One or more numeric values, specified in decimal, or hexadecimal if prefixed with 0x, or octal if prefixed with 0. Values are interpreted based on the value of <literal>kind</literal>.</para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
+                     <para><literal>expr</literal></para>
+                  </entry>
+                  <entry>
+                     <para>An expression, with valid operators and syntax:</para>
+                     <simpara><literal>    (range (permission ...) (permission ...))</literal></simpara>
+                     <simpara><literal>    (and (permission ...) (permission ...))</literal></simpara>
+                     <simpara><literal>    (or  (permission ...) (permission ...))</literal></simpara>
+                     <simpara><literal>    (xor (permission ...) (permission ...))</literal></simpara>
+                     <simpara><literal>    (not (permission ...))</literal></simpara>
+                     <simpara><literal>    (all)</literal></simpara>
+                  </entry>
+               </row>
+            </tbody></tgroup>
+         </informaltable>
+         <para><emphasis role="bold">Examples:</emphasis></para>
+         <programlisting><![CDATA[
+(permissionx ioctl_1 (ioctl tcp_socket (0x2000 0x3000 0x4000)))
+(permissionx ioctl_2 (ioctl tcp_socket (range 0x6000 0x60FF)))
+(permissionx ioctl_3 (ioctl tcp_socket (and (range 0x8000 0x90FF) (not (range 0x8100 0x82FF)))))
+]]>
+         </programlisting>
+      </sect2>
+
    </sect1>
diff --git a/secilc/docs/cil_container_statements.xml b/secilc/docs/cil_container_statements.xml
index 6bdd1ab..3e3d2f6 100644
--- a/secilc/docs/cil_container_statements.xml
+++ b/secilc/docs/cil_container_statements.xml
@@ -241,19 +241,30 @@
                      <para><literal><link linkend="allow">allow</link></literal></para>
                   </entry>
                   <entry>
+                     <para><literal><link linkend="allowx">allowx</link></literal></para>
+                  </entry>
+                  <entry>
                      <para><literal><link linkend="auditallow">auditallow</link></literal></para>
                   </entry>
                   <entry>
+                     <para><literal><link linkend="auditallowx">auditallowx</link></literal></para>
+                  </entry>
+               </row>
+               <row>
+                  <entry>
                      <para><literal><link linkend="booleanif">booleanif</link></literal></para>
                   </entry>
                   <entry>
                      <para><literal><link linkend="dontaudit">dontaudit</link></literal></para>
                   </entry>
-               </row>
-               <row>
+                  <entry>
+                     <para><literal><link linkend="dontauditx">dontauditx</link></literal></para>
+                  </entry>
                   <entry>
                      <para><literal><link linkend="typepermissive">typepermissive</link></literal></para>
                   </entry>
+               </row>
+               <row>
                   <entry>
                      <para><literal><link linkend="rangetransition">rangetransition</link></literal></para>
                   </entry>
@@ -263,11 +274,11 @@
                   <entry>
                      <para><literal><link linkend="roleallow">roleallow</link></literal></para>
                   </entry>
-               </row>
-               <row>
                   <entry>
                      <para><literal><link linkend="roleattribute">roleattribute</link></literal></para>
                   </entry>
+               </row>
+               <row>
                   <entry>
                      <para><literal><link linkend="roletransition">roletransition</link></literal></para>
                   </entry>
@@ -277,11 +288,11 @@
                   <entry>
                      <para><literal><link linkend="typealias">typealias</link></literal></para>
                   </entry>
-               </row>
-               <row>
                   <entry>
                      <para><literal><link linkend="typeattribute">typeattribute</link></literal></para>
                   </entry>
+              </row>
+              <row>
                   <entry>
                      <para><literal><link linkend="typechange">typechange</link></literal></para>
                   </entry>
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index 25c8545..0b532a9 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -91,6 +91,9 @@
 	;;(allow console_t console_device_t file_rw)
 	(allow console_t console_device_t (files (read)))
 
+	(permissionx ioctl_test (ioctl files (and (range 0x1600 0x19FF) (not (range 0x1750 0x175F)))))
+	(allowx console_t console_device_t ioctl_test)
+
 	(boolean secure_mode false)
 	(boolean console_login true)
 	
@@ -114,9 +117,6 @@
 	(typealias sbin_t)
 	(typealiasactual sbin_t bin_t)
 	(typepermissive device_t) 
-	(typebounds device_t bin_t)
-	;;(typebounds bin_t kernel_t)    ;; This statement and the next can be used
-	;;(typebounds kernel_t device_t) ;; to verify that circular bounds can be found 
 	(typemember device_t bin_t file exec_t)
 	(typetransition device_t console_t files console_device_t)
 
@@ -203,7 +203,6 @@
 	(roletype exec_role bin_t)
 	(roletype exec_role exec_type)
 	(roleallow system_r user_r)
-	(rolebounds system_r user_r)
 	(roletransition system_r bin_t file user_r)
 
 	(userrole foo_u foo_role)
@@ -213,7 +212,6 @@
 	(userrole system_u system_r)
 	(userlevel system_u low)
 	(userrange system_u low_high)
-	(userbounds system_u user_u)
 
 	(userrole user_u user_r)
 	(userlevel user_u (s0 (range c0 c2)))
@@ -286,6 +284,7 @@
 
 (macro all ((type x))
 	(allow x bin_t (policy.file (execute)))
+	(allowx x bin_t (ioctl policy.file (range 0x1000 0x11FF)))
 )
 (call all (bin_t))
 
-- 
2.4.3
