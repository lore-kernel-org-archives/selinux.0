Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBBGR3Yg017363
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 11:27:03 -0500
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] secilc/docs: Convert DocBook documentation into github
 markdown
Date: Fri, 11 Dec 2015 11:26:13 -0500
Message-ID: <1449851173-9054-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Converting to github markdown allows for easier integration with the
SELinux project wiki and viewing of documentation directly on github without
creating PDFs or reading through DocBook XML.

The conversion of DocBook to github markdown would not format tables or
keyword links properly. By maintaining the documentation in github
markdown in the repository, the content is well formatted with a table of
contents when viewing in the github wiki or in the repository.

The migration from DocBook to github markdown was done using Pandoc and
manual fixups. Mappings of CIL keywords to headings that were lost in the DocBook
conversion were added back. An introduction and design philosphy was
also pulled from the SELinux project wiki to provide more cohesion
to the current documentation.

Running make will now convert the github markdown into PDF and HTML.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 secilc/.gitignore                                  |   1 +
 secilc/docs/CIL_Reference_Guide.xml                | 573 ----------------
 secilc/docs/Makefile                               |  86 ++-
 secilc/docs/README.md                              | 154 +++++
 secilc/docs/cil_access_vector_rules.md             | 428 ++++++++++++
 secilc/docs/cil_access_vector_rules.xml            | 518 ---------------
 secilc/docs/cil_call_macro_statements.md           | 130 ++++
 secilc/docs/cil_call_macro_statements.xml          | 174 -----
 secilc/docs/cil_class_and_permission_statements.md | 522 +++++++++++++++
 .../docs/cil_class_and_permission_statements.xml   | 604 -----------------
 secilc/docs/cil_conditional_statements.md          | 222 +++++++
 secilc/docs/cil_conditional_statements.xml         | 269 --------
 secilc/docs/cil_constraint_statements.md           | 313 +++++++++
 secilc/docs/cil_constraint_statements.xml          | 363 ----------
 secilc/docs/cil_container_statements.md            | 296 +++++++++
 secilc/docs/cil_container_statements.xml           | 424 ------------
 secilc/docs/cil_context_statement.md               |  77 +++
 secilc/docs/cil_context_statement.xml              | 100 ---
 secilc/docs/cil_default_object_statements.md       | 183 +++++
 secilc/docs/cil_default_object_statements.xml      | 215 ------
 secilc/docs/cil_file_labeling_statements.md        | 228 +++++++
 secilc/docs/cil_file_labeling_statements.xml       | 302 ---------
 secilc/docs/cil_introduction.md                    |  59 ++
 secilc/docs/cil_mls_labeling_statements.md         | 638 ++++++++++++++++++
 secilc/docs/cil_mls_labeling_statements.xml        | 733 ---------------------
 secilc/docs/cil_network_labeling_statements.md     | 201 ++++++
 secilc/docs/cil_network_labeling_statements.xml    | 244 -------
 secilc/docs/cil_policy_config_statements.md        | 113 ++++
 secilc/docs/cil_policy_config_statements.xml       | 118 ----
 secilc/docs/cil_reference_guide.md                 | 298 +++++++++
 secilc/docs/cil_role_statements.md                 | 320 +++++++++
 secilc/docs/cil_role_statements.xml                | 374 -----------
 secilc/docs/cil_sid_statements.md                  | 125 ++++
 secilc/docs/cil_sid_statements.xml                 | 142 ----
 secilc/docs/cil_type_statements.md                 | 502 ++++++++++++++
 secilc/docs/cil_type_statements.xml                | 581 ----------------
 secilc/docs/cil_user_statements.md                 | 455 +++++++++++++
 secilc/docs/cil_user_statements.xml                | 528 ---------------
 secilc/docs/cil_xen_statements.md                  | 200 ++++++
 secilc/docs/cil_xen_statements.xml                 | 227 -------
 40 files changed, 5518 insertions(+), 6522 deletions(-)
 delete mode 100644 secilc/docs/CIL_Reference_Guide.xml
 create mode 100644 secilc/docs/README.md
 create mode 100644 secilc/docs/cil_access_vector_rules.md
 delete mode 100644 secilc/docs/cil_access_vector_rules.xml
 create mode 100644 secilc/docs/cil_call_macro_statements.md
 delete mode 100644 secilc/docs/cil_call_macro_statements.xml
 create mode 100644 secilc/docs/cil_class_and_permission_statements.md
 delete mode 100644 secilc/docs/cil_class_and_permission_statements.xml
 create mode 100644 secilc/docs/cil_conditional_statements.md
 delete mode 100644 secilc/docs/cil_conditional_statements.xml
 create mode 100644 secilc/docs/cil_constraint_statements.md
 delete mode 100644 secilc/docs/cil_constraint_statements.xml
 create mode 100644 secilc/docs/cil_container_statements.md
 delete mode 100644 secilc/docs/cil_container_statements.xml
 create mode 100644 secilc/docs/cil_context_statement.md
 delete mode 100644 secilc/docs/cil_context_statement.xml
 create mode 100644 secilc/docs/cil_default_object_statements.md
 delete mode 100644 secilc/docs/cil_default_object_statements.xml
 create mode 100644 secilc/docs/cil_file_labeling_statements.md
 delete mode 100644 secilc/docs/cil_file_labeling_statements.xml
 create mode 100644 secilc/docs/cil_introduction.md
 create mode 100644 secilc/docs/cil_mls_labeling_statements.md
 delete mode 100644 secilc/docs/cil_mls_labeling_statements.xml
 create mode 100644 secilc/docs/cil_network_labeling_statements.md
 delete mode 100644 secilc/docs/cil_network_labeling_statements.xml
 create mode 100644 secilc/docs/cil_policy_config_statements.md
 delete mode 100644 secilc/docs/cil_policy_config_statements.xml
 create mode 100644 secilc/docs/cil_reference_guide.md
 create mode 100644 secilc/docs/cil_role_statements.md
 delete mode 100644 secilc/docs/cil_role_statements.xml
 create mode 100644 secilc/docs/cil_sid_statements.md
 delete mode 100644 secilc/docs/cil_sid_statements.xml
 create mode 100644 secilc/docs/cil_type_statements.md
 delete mode 100644 secilc/docs/cil_type_statements.xml
 create mode 100644 secilc/docs/cil_user_statements.md
 delete mode 100644 secilc/docs/cil_user_statements.xml
 create mode 100644 secilc/docs/cil_xen_statements.md
 delete mode 100644 secilc/docs/cil_xen_statements.xml

diff --git a/secilc/.gitignore b/secilc/.gitignore
index 98c367a..f659d80 100644
--- a/secilc/.gitignore
+++ b/secilc/.gitignore
@@ -4,3 +4,4 @@ policy.*
 file_contexts
 docs/html
 docs/pdf
+docs/tmp
diff --git a/secilc/docs/CIL_Reference_Guide.xml b/secilc/docs/CIL_Reference_Guide.xml
deleted file mode 100644
index e089079..0000000
--- a/secilc/docs/CIL_Reference_Guide.xml
+++ /dev/null
@@ -1,573 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML//EN"
-               "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
-   [ <!ENTITY policy_config_statements SYSTEM "cil_policy_config_statements.xml">
-     <!ENTITY container_statements SYSTEM "cil_container_statements.xml">
-     <!ENTITY call_macro_statements SYSTEM "cil_call_macro_statements.xml">
-     <!ENTITY default_object_statements SYSTEM "cil_default_object_statements.xml">
-     <!ENTITY user_statements SYSTEM "cil_user_statements.xml">
-     <!ENTITY role_statements SYSTEM "cil_role_statements.xml">
-     <!ENTITY type_statements SYSTEM "cil_type_statements.xml">
-     <!ENTITY class_and_permission_statements SYSTEM "cil_class_and_permission_statements.xml">
-     <!ENTITY access_vector_rules SYSTEM "cil_access_vector_rules.xml">
-     <!ENTITY conditional_statements SYSTEM "cil_conditional_statements.xml">
-     <!ENTITY constraint_statements SYSTEM "cil_constraint_statements.xml">
-     <!ENTITY mls_labeling_statements SYSTEM "cil_mls_labeling_statements.xml">
-     <!ENTITY context_statement SYSTEM "cil_context_statement.xml">
-     <!ENTITY sid_statements SYSTEM "cil_sid_statements.xml">
-     <!ENTITY file_labeling_statements SYSTEM "cil_file_labeling_statements.xml">
-     <!ENTITY network_labeling_statements SYSTEM "cil_network_labeling_statements.xml">
-     <!ENTITY xen_statements SYSTEM "cil_xen_statements.xml">
-
-      <!-- This is to load in the latest example policy.cil file -->
-     <!ENTITY policy_cil SYSTEM "../test/policy.cil">
-
-   ]>
-
-<article lang="en_GB">
-   <articleinfo>
-      <title>Common Interface Language (CIL) Reference Guide</title>
-   </articleinfo>
-
-   <sect1>
-      <title>CIL Information</title>
-      <orderedlist>
-         <listitem><para>Not all possible alternate statement permutations are shown, however there should be enough variation to work out any other valid formats. There is also an example <filename>policy.cil</filename> file shown in the <link linkend="example_policy">Appendix</link>.</para></listitem>
-         <listitem><para>The MLS components on contexts and user statements must be declared even if the policy does not support MCS/MLS. </para></listitem>
-         <listitem><para>The CIL compiler will not build a policy unless it also has as a minimum: one <literal><link linkend="allow">allow</link></literal> rule, one <literal><link linkend="sid">sid</link></literal>, <literal><link linkend="sidorder">sidorder</link></literal> and <literal><link linkend="sidcontext">sidcontext</link></literal> statement. </para></listitem>
-         <listitem><para>The role <literal>object_r</literal> must be explicitly associated to contexts used for labeling objects. The original <emphasis role="bold"><literal>checkpolicy</literal></emphasis><literal>(8)</literal> and <emphasis role="bold"><literal>checkmodule</literal></emphasis><literal>(8)</literal> compilers did this by default - CIL does not.</para></listitem>
-         <listitem><para>Be aware that CIL allows <literal><link linkend="class">class</link></literal> statements to be declared in a namespace, however the policy author needs to note that applications (and the kernel) generally reference a class by its well known class identifier (e.g. <literal>zygote</literal>) however if declared in a namespace (e.g. <literal>(block zygote (class zygote (...)))</literal> or <literal>(block zygote (class class (...)))</literal>) it would be prefixed with that namespace (e.g. <literal>zygote.zygote</literal> or  <literal>zygote.class</literal>). Unless the application / kernel code was updated the class would never be resolved, therefore it is recommended that classes are declared in the global namespace.</para></listitem>
-         <listitem><para>Where possible use <literal><link linkend="typeattribute">typeattribute</link></literal>'s when defining source/target <literal><link linkend="allow">allow</link></literal> rules instead of multiple <literal>allow</literal> rules with individual <literal><link linkend="type">type</link></literal>'s. This will lead to the generation of much smaller kernel policy files.</para></listitem>
-         <listitem><para>The <ulink url="http://github.com/SELinuxProject/cil/wiki"></ulink> site explains the language however some of the statement definitions are dated.</para></listitem>
-      </orderedlist>
-      <sect2>
-         <title>Declarations</title>
-         <para>Declarations may be named or anonymous and have three different forms:</para>
-         <orderedlist>
-            <listitem><para>Named declarations - These create new objects that introduce a name or identifier, for example:</para>
-            <para><literal>(type process)</literal> - creates a <literal>type</literal> with an identifier of <literal>process</literal>.</para>
-            <para><literal>(typeattribute domain)</literal> - creates a <literal>typeattribute</literal> with an identifier of <literal>domain</literal>.</para>
-            <para><literal>(class file (read write))</literal> - creates a <literal>class</literal> with an identifier of <literal>file</literal> that has <literal>read</literal> and <literal>write</literal> permissions associated to it.</para>
-            <para>The list of declaration type statement keywords are:</para>
-            <simplelist type="inline">
-               <member><literal><link linkend="block">block</link></literal></member>
-               <member><literal><link linkend="optional">optional</link></literal></member>
-               <member><literal><link linkend="common">common</link></literal></member>
-               <member><literal><link linkend="class">class</link></literal></member>
-               <member><literal><link linkend="classmap">classmap</link></literal></member>
-               <member><literal><link linkend="classmapping">classmapping</link></literal></member>
-               <member><literal><link linkend="sid">sid</link></literal></member>
-               <member><literal><link linkend="user">user</link></literal></member>
-               <member><literal><link linkend="role">role</link></literal></member>
-               <member><literal><link linkend="roleattribute">roleattribute</link></literal></member>
-               <member><literal><link linkend="type">type</link></literal></member>
-               <member><literal><link linkend="classpermission">classpermission</link></literal></member>
-               <member><literal><link linkend="classpermissionset">classpermissionset</link></literal></member>
-               <member><literal><link linkend="typeattribute">typeattribute</link></literal></member>
-               <member><literal><link linkend="typealias">typealias</link></literal></member>
-               <member><literal><link linkend="tunable">tunable</link></literal></member>
-               <member><literal><link linkend="sensitivity">sensitivity</link></literal></member>
-               <member><literal><link linkend="sensitivityalias">sensitivityalias</link></literal></member>
-               <member><literal><link linkend="category">category</link></literal></member>
-               <member><literal><link linkend="categoryalias">categoryalias</link></literal></member>
-               <member><literal><link linkend="categoryset">categoryset</link></literal></member>
-               <member><literal><link linkend="level">level</link></literal></member>
-               <member><literal><link linkend="levelrange">levelrange</link></literal></member>
-               <member><literal><link linkend="context">context</link></literal></member>
-               <member><literal><link linkend="ipaddr">ipaddr</link></literal></member>
-               <member><literal><link linkend="macro">macro</link></literal></member>
-               <member><literal><link linkend="policycap">policycap</link></literal></member>
-            </simplelist>
-            </listitem>
-            <listitem><para>Explicit anonymous declarations - These are currently restricted to IP addesses where they can be declared directly in statements by enclosing them within parentheses e.g. <literal>(127.0.0.1)</literal> or <literal>(::1)</literal>. See the <link linkend="network_labeling">Network Labeling Statements</link> section for examples.</para></listitem>
-            <listitem><para>Anonymous declarations - These have been previously declared and the object already exists, therefore they may be referenced by their name or identifier within statements. For example the following declare all the components required to specify a context:</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(category c0)
-(role object_r)
-
-(block unconfined
-    (user user)
-    (type object)
-)]]>
-         </programlisting>
-         <simpara>now a <literal><link linkend="portcon">portcon</link></literal> statement can be defined that uses these individual components to build a context as follows:</simpara>
-         <programlisting><![CDATA[(portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))]]></programlisting>
-         </listitem>
-         </orderedlist>
-      </sect2>
-
-      <sect2>
-         <title>Definitions</title>
-         <para>Statements that build on the objects, for example:</para>
-         <itemizedlist mark="none">
-            <listitem><para><literal>(typeattributeset domain (process))</literal> - Adds the <literal>type</literal> '<literal>process</literal>' to the <literal>typeattribute</literal> '<literal>domain</literal>'.</para></listitem>
-            <listitem><para><literal>(allow domain process (file (read write))))</literal> - Adds an <literal>allow</literal> rule referencing <literal>domain</literal>, <literal>process</literal> and the <literal>file class</literal>.</para></listitem>
-         </itemizedlist>
-         <para>Definitions may be repeated many times throughout the policy. Duplicates will resolve to a single definition during compilation.</para>
-      </sect2>
-      <sect2>
-         <title>Symbol Character Set</title>
-         <para>Symbols (any string not enclosed in double quotes) must only contain alphanumeric <literal>[a-z A-Z] [0-9]</literal> characters plus the following special characters: <literal>\.@=/-_$%@+!|&amp;^:</literal></para>
-         <para>However symbols are checked for any specific character set limitations, for example:</para>
-         <itemizedlist>
-            <listitem><para>Names or identifiers must start with an alpa character <literal>[a-z A-Z]</literal>, the remainder may be alphanumeric <literal>[a-z A-Z] [0-9]</literal> characters plus underscore <literal>[_]</literal> or hyphen <literal>[-]</literal>.</para></listitem>
-            <listitem><para>IP addresses must conform to IPv4 or IPv6 format.</para></listitem>
-            <listitem><para>Memory, ports, irqs must be numeric <literal>[0-9]</literal>.</para></listitem>
-         </itemizedlist>
-      </sect2>
-      <sect2>
-         <title>String Character Set</title>
-         <para>Strings are enclosed within double quotes (e.g. <literal>"This is a string"</literal>), and may contain any character except the double quote (").</para>
-      </sect2>
-      <sect2>
-         <title>Comments</title>
-         <para>Comments start with a semicolon '<literal>;</literal>' and end when a new line is started.</para>
-      </sect2>
-      <sect2>
-         <title>Namespaces</title>
-         <para>CIL supports namespaces via containers such as the <literal>block</literal> statement. When a block is resolved to form the parent / child relationship a dot '<literal>.</literal>' is used, for example the following <literal>allow</literal> rule:</para>
-         <programlisting><![CDATA[
-(block example_ns
-    (type process)
-    (type object)
-    (class file (open read write getattr))
-
-    (allow process object (file (open read getattr)))
-)]]>
-      </programlisting>
-         <para>will resolve to the following kernel policy language statement:</para>
-         <programlisting><![CDATA[allow example_ns.process example_ns.object : example_ns.file { open read getattr };]]></programlisting>
-      </sect2>
-      <sect2>
-         <title>Global Namespace</title>
-         <para>CIL has a global namespace that is always present. Any symbol that is declared outside a container is in the global namespace. To reference a symbol in global namespace, the symbol should be prefixed with a dot '<literal>.</literal>' as shown in the following example:</para>
-         <programlisting><![CDATA[
-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
-; This example has three namespace 'tmpfs' types declared:
-;    1) Global .tmpfs
-;    2) file.tmpfs
-;    3) other_ns.tmpfs
-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
-
-; This type is the global tmpfs:
-(type tmpfs)
-
-(block file
-    ; file namespace tmpfs
-    (type tmpfs)
-    (class file (open read write getattr))
-
-    ; This rule will reference the local namespace for src and tgt:
-    (allow tmpfs tmpfs (file (open)))
-    ; Resulting policy rule:
-    ; allow file.tmpfs file.tmpfs : file.file open;
-
-    ; This rule will reference the local namespace for src and global for tgt:
-    (allow tmpfs .tmpfs (file (read)))
-    ; Resulting policy rule:
-    ; allow file.tmpfs tmpfs : file.file read;
-
-    ; This rule will reference the global namespace for src and tgt:
-    (allow .tmpfs .tmpfs (file (write)))
-    ; Resulting policy rule:
-    ; allow tmpfs tmpfs : file.file write;
-
-    ; This rule will reference the other_ns namespace for src and
-    ; local namespace for tgt:
-    (allow other_ns.tmpfs tmpfs (file (getattr)))
-    ; Resulting policy rule:
-    ; allow other_ns.tmpfs file.tmpfs : file.file getattr;
-)
-
-(block other_ns
-    (type tmpfs)
-)]]>
-         </programlisting>
-         <para>Should the symbol not be prefixed with a dot, the current namespace would be searched first and then the global namespace (provided there is not a symbol of that name in the current namespace).</para>
-      </sect2>
-      <sect2>
-         <title>Expressions</title>
-         <para>Expressions may occur in the following CIL statements:
-         <simplelist type="inline">
-            <member><literal><link linkend="booleanif">booleanif</link></literal></member>
-            <member><literal><link linkend="tunableif">tunableif</link></literal></member>
-            <member><literal><link linkend="classpermissionset">classpermissionset</link></literal></member>
-            <member><literal><link linkend="typeattributeset">typeattributeset</link></literal></member>
-            <member><literal><link linkend="roleattributeset">roleattributeset</link></literal></member>
-            <member><literal><link linkend="categoryset">categoryset</link></literal></member>
-            <member><literal><link linkend="constrain">constrain</link></literal></member>
-            <member><literal><link linkend="mlsconstrain">mlsconstrain</link></literal></member>
-            <member><literal><link linkend="validatetrans">validatetrans</link></literal></member>
-            <member><literal><link linkend="validatetrans">validatetrans</link></literal></member>
-         </simplelist></para>
-         <para>CIL expressions use the <ulink url="http://www.cs.man.ac.uk/~pjj/cs212/fix.html">prefix</ulink> or Polish notation and may be nested (note that the kernel policy language uses postfix or reverse Polish notation). The syntax is as follows, where the parenthesis are part of the syntax:</para>
-         <programlisting><![CDATA[
-expr_set = (name ... | expr ...)
-expr = (expr_key expr_set ...)
-expr_key = and | or | xor | not | all | eq | neq | dom | domby | incomp | range]]>
-         </programlisting>
-         <para>The number of <literal>expr_set</literal>'s in an <literal>expr</literal> is dependent on the statement type (there are four different classes as defined below) that also influence the valid <literal>expr_key</literal> entries (e.g. <literal>dom</literal>, <literal>domby</literal>, <literal>incomp</literal> are only allowed in constraint statements).</para>
-
-         <informaltable frame="all">
-            <tgroup cols="5"><tbody>
-               <row>
-                  <entry valign="bottom"><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para/>
-                     <para/>
-                     <para/>
-                     <para><emphasis role="bold">expr_key</emphasis></para>
-                  </entry>
-                  <entry valign="top" align="center"><?dbhtml bgcolor="lightgreen" ?><?dbfo bgcolor="lightgreen" ?><?dblatex bgcolor="green" ?>
-                     <para><emphasis role="bold">classpermissionset</emphasis></para>
-                     <para><emphasis role="bold">roleattributeset</emphasis></para>
-                     <para><emphasis role="bold">typeattributeset</emphasis></para>
-                  </entry>
-                  <entry valign="top" align="center"><?dbhtml bgcolor="lightgreen" ?><?dbfo bgcolor="lightgreen" ?><?dblatex bgcolor="green" ?>
-                     <para><emphasis role="bold">categoryset</emphasis></para>
-                  </entry>
-                  <entry valign="top" align="center"><?dbhtml bgcolor="lightgreen" ?><?dbfo bgcolor="lightgreen" ?><?dblatex bgcolor="green" ?>
-                     <para><emphasis role="bold">booleanif</emphasis></para>
-                     <para><emphasis role="bold">tunableif</emphasis></para>
-                  </entry>
-                  <entry valign="top" align="center"><?dbhtml bgcolor="lightgreen" ?><?dbfo bgcolor="lightgreen" ?><?dblatex bgcolor="green" ?>
-                     <para><emphasis role="bold">constrain</emphasis></para>
-                     <para><emphasis role="bold">mlsconstrain</emphasis></para>
-                     <para><emphasis role="bold">validatetrans</emphasis></para>
-                     <para><emphasis role="bold">mlsvalidatetrans</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>dom</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>domby</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>incomp</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>eq</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>ne</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>and</literal></emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>or</literal></emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>not</literal></emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>xor</literal></emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>all</literal></emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-               </row>
-               <row>
-                  <entry><?dbhtml bgcolor="orange" ?><?dbfo bgcolor="orange" ?><?dblatex bgcolor="orange" ?>
-                     <para><emphasis role="bold"><literal>range</literal></emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry align="center"><?dbhtml bgcolor="lightgray" ?><?dbfo bgcolor="lightgray" ?><?dblatex bgcolor="lightgray" ?>
-                     <para><emphasis role="bold">X</emphasis></para>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-                  <entry>
-                     <para/>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <orderedlist>
-            <listitem>
-               <para>The <literal><link linkend="classpermissionset">classpermissionset</link></literal>,
-<literal><link linkend="roleattributeset">roleattributeset</link></literal> and <literal><link linkend="typeattributeset">typeattributeset</link></literal> statements allow <literal>expr_set</literal> to mix names and <literal>expr</literal>s with <literal>expr_key</literal> values of: <literal>and</literal>, <literal>or</literal>, <literal>xor</literal>, <literal>not</literal>, <literal>all</literal> as shown in the examples:</para>
-               <para>This example includes all <literal>fs_type type</literal> entries except <literal>file.usermodehelper</literal> and <literal>file.proc_security</literal> in the associated <literal>typeattribute</literal> identifier <literal>all_fs_type_except_usermodehelper_and_proc_security</literal>:</para>
-               <programlisting><![CDATA[
-(typeattribute all_fs_type_except_usermodehelper_and_proc_security)
-
-(typeattributeset all_fs_type_except_usermodehelper_and_proc_security
-    (and
-        (and
-            fs_type
-            (not file.usermodehelper)
-        )
-        (not file.proc_security)
-    )
-)]]>
-            </programlisting>
-            <para>The <literal>cps_1 classpermissionset</literal> identifier includes all permissions except <literal>load_policy</literal> and <literal>setenforce</literal>:</para>
-            <programlisting><![CDATA[
-(class security (compute_av compute_create compute_member check_context load_policy compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot read_policy))
-
-(classpermission cps_1)
-
-(classpermissionset cps_1 (security (not (load_policy setenforce))))]]>
-            </programlisting>
-
-            <para>This example includes all permissions in the associated <literal>classpermissionset</literal> identifer <literal>security_all_perms</literal>:</para>
-            <programlisting><![CDATA[
-(class security (compute_av compute_create compute_member check_context load_policy
-    compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot
-    read_policy)
-)
-
-(classpermission security_all_perms)
-
-(classpermissionset security_all_perms (security (all)))]]>
-            </programlisting>
-            </listitem>
-
-            <listitem>
-               <para>The <literal><link linkend="categoryset">categoryset</link></literal> statement allows <literal>expr_set</literal> to mix names and <literal>expr_key</literal> values of: <literal>and</literal>, <literal>or</literal>, <literal>not</literal>, <literal>xor</literal>, <literal>all</literal>, <literal>range</literal> as shown in the examples.</para>
-               <para>Category expressions are also allowed in <literal><link linkend="sensitivitycategory">sensitivitycategory</link></literal>, <literal><link linkend="level">level</link></literal>, and <literal><link linkend="levelrange">levelrange</link></literal> statements.</para>
-            </listitem>
-
-            <listitem>
-               <para>The <literal><link linkend="booleanif">booleanif</link></literal> and <literal><link linkend="tunableif">tunableif</link></literal> statements only allow an <literal>expr_set</literal> to have one <literal>name</literal> or <literal>expr</literal> with <literal>expr_key</literal> values of <literal>and</literal>, <literal>or</literal>, <literal>xor</literal>, <literal>not</literal>, <literal>eq</literal>, <literal>neq</literal> as shown in the examples:</para>
-               <programlisting><![CDATA[
-(booleanif disableAudio
-    (false
-        (allow process device.audio_device (chr_file_set (rw_file_perms)))
-    )
-)]]>
-               </programlisting>
-               <programlisting><![CDATA[
-(booleanif (and (not disableAudio) (not disableAudioCapture))
-    (true
-        (allow process device.audio_capture_device (chr_file_set (rw_file_perms)))
-    )
-)]]>
-            </programlisting>
-            </listitem>
-
-            <listitem>
-               <para>The <literal><link linkend="constrain">constrain</link></literal>, <literal><link linkend="mlsconstrain">mlsconstrain</link></literal>, <literal><link linkend="validatetrans">validatetrans</link></literal> and <literal><link linkend="mlsvalidatetrans">mlsvalidatetrans</link></literal> statements only allow an <literal>expr_set</literal> to have one <literal>name</literal> or <literal>expr</literal> with <literal>expr_key</literal> values of <literal>and</literal>, <literal>or</literal>, <literal>not</literal>, <literal>all</literal>, <literal>eq</literal>, <literal>neq</literal>, <literal>dom</literal>, <literal>domby</literal>, <literal>incomp</literal>. When <literal>expr_key</literal> is <literal>dom</literal>, <literal>domby</literal> or <literal>incomp</literal>, it must be followed by a string (e.g. <literal>h1</literal>, <literal>l2</literal>) and another string or a set of <literal>name</literal>s. The following examples show CIL constraint statements and their policy language equivalents:</para>
-               <programlisting><![CDATA[
-; Process transition:  Require equivalence unless the subject is trusted.
-(mlsconstrain (process (transition dyntransition))
-    (or (and (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))
-
-; The equivalent policy language mlsconstrain statememt is:
-;mlsconstrain process { transition dyntransition }
-;    ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);]]>
-               </programlisting>
-               <programlisting><![CDATA[
-; Process read operations: No read up unless trusted.
-(mlsconstrain (process (getsched getsession getpgid getcap getattr ptrace share))
-    (or (dom l1 l2) (eq t1 mlstrustedsubject)))
-
-; The equivalent policy language mlsconstrain statememt is:
-;mlsconstrain process { getsched getsession getpgid getcap getattr ptrace share }
-;    (l1 dom l2 or t1 == mlstrustedsubject);]]>
-            </programlisting>
-            </listitem>
-         </orderedlist>
-      </sect2>
-
-      <sect2 id="name">
-         <title>Name String</title>
-         <para>Used to define <literal><link linkend="macro">macro</link></literal> statement parameter string types:</para>
-         <programlisting><![CDATA[
-(call macro1("__kmsg__"))
-
-(macro macro1 ((string ARG1))
-    (typetransition audit.process device.device chr_file ARG1 device.klog_device)
-)]]>
-         </programlisting>
-         <para>Alternatively:</para>
-         <programlisting><![CDATA[
-(call macro1("__kmsg__"))
-
-(macro macro1 ((name ARG1))
-    (typetransition audit.process device.device chr_file ARG1 device.klog_device)
-)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2>
-         <title>self</title>
-         <para>The <literal>self</literal> keyword may be used as the target in AVC rule statements, and means that the target is the same as the source as shown in the following example:.</para>
-         <programlisting><![CDATA[(allow unconfined.process self (file (read write)))]]></programlisting>
-      </sect2>
-   </sect1>
-
-   &policy_config_statements;
-   &container_statements;
-   &call_macro_statements;
-   &default_object_statements;
-   &user_statements;
-   &role_statements;
-   &type_statements;
-   &class_and_permission_statements;
-   &access_vector_rules;
-   &conditional_statements;
-   &constraint_statements;
-   &mls_labeling_statements;
-   &context_statement;
-   &sid_statements;
-   &file_labeling_statements;
-   &network_labeling_statements;
-   &xen_statements;
-
-   <!-- This section will copy in the latest example ../test/policy.cil file -->
-   <appendix id="example_policy">
-      <title>Example CIL Policy</title>
-         <para>This is the example <filename>policy.cil</filename> file taken from the CIL compiler source code.</para>
-         <programlisting>&policy_cil;
-         </programlisting>
-         <para/>
-   </appendix>
-
-</article>
-
-
diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index 1655f59..bcbc2e3 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -1,41 +1,61 @@
-HTMLDIR ?= ./html
-PDFDIR ?= ./pdf
+CWD ?= $(shell pwd)
+HTMLDIR ?= $(CWD)/html
+PDFDIR ?= $(CWD)/pdf
+TMPDIR ?= $(CWD)/tmp
+TESTDIR ?= $(CWD)/../test
+
+# All the markdown files that make up the guide:
+FILE_LIST ?= cil_introduction.md \
+	cil_reference_guide.md \
+	cil_access_vector_rules.md \
+	cil_call_macro_statements.md \
+	cil_class_and_permission_statements.md \
+	cil_conditional_statements.md \
+	cil_constraint_statements.md \
+	cil_container_statements.md \
+	cil_context_statement.md \
+	cil_default_object_statements.md \
+	cil_file_labeling_statements.md \
+	cil_mls_labeling_statements.md \
+	cil_network_labeling_statements.md \
+	cil_policy_config_statements.md \
+	cil_role_statements.md \
+	cil_sid_statements.md \
+	cil_type_statements.md \
+	cil_user_statements.md \
+	cil_xen_statements.md
+
+PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
+
+PDF_OUT=CIL_Reference_Guide.pdf
+HTML_OUT=CIL_Reference_Guide.html
+PANDOC = pandoc
 
-# The CIL Reference Guide first part
-CIL_REF_GUIDE = CIL_Reference_Guide.xml
-# All the docbook files that make up the guide:
-FILE_LIST ?= $(CIL_REF_GUIDE) $(wildcard cil*.xml)
-# xmlto generates a *.proc file that can be removed.
-PROC_FILE = CIL_Reference_Guide.proc
-
-# look for xmlto and dblatex packages
-XMLTO = $(shell which xmlto 2> /dev/null | grep / | head -n1)
-DBLATEX = $(shell which dblatex 2> /dev/null | grep / | head -n1)
+all: html pdf
 
-# If no xmlto then exit as cannot proceed.
-ifeq ($(XMLTO),)
-$(error xmlto package not found - install package.)
-endif
+$(TMPDIR):
+	mkdir -p $(TMPDIR)
 
-all: html pdf
+$(TMPDIR)/%.md: %.md | $(TMPDIR)
+	cp -f $< $(TMPDIR)/
+	@# Substitute markdown links for conversion into PDF links
+	sed -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
 
-html: $(FILE_LIST)
-	$(XMLTO) html $(CIL_REF_GUIDE)
-	@mkdir -p $(HTMLDIR)
-	@for m in *.html; do if [ -f $$m ]; then mv $$m $(HTMLDIR); fi; done
-	@rm -f $(PROC_FILE)
+$(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
+	cp -f $< $@
+	@# add a title for the TOC to policy.cil. This is needed to play nicely with the PDF conversion.
+	sed -i '1i Example Policy\n=========\n```' $@
+	echo '```' >> $@
 
+html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+	mkdir -p $(HTMLDIR)
+	$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
 
-pdf: $(FILE_LIST)
-# Check if dblatex is available
-ifeq ($(DBLATEX),)
-	$(error dblatex package not found - install package for a pdf document.)
-endif
-	$(XMLTO) --with-dblatex pdf  $(CIL_REF_GUIDE)
-	@mkdir -p $(PDFDIR)
-	@for m in *.pdf; do if [ -f $$m ]; then mv $$m $(PDFDIR); fi; done
-	@rm -f $(PROC_FILE)
+pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+	mkdir -p $(PDFDIR)
+	$(PANDOC) --standalone --toc --latex-engine=xelatex $^ -o $(PDFDIR)/$(PDF_OUT)
 
 clean:
-	@rm -rf html/
-	@rm -rf pdf/
+	rm -rf $(HTMLDIR)
+	rm -rf $(PDFDIR)
+	rm -rf $(TMPDIR)
diff --git a/secilc/docs/README.md b/secilc/docs/README.md
new file mode 100644
index 0000000..aada78f
--- /dev/null
+++ b/secilc/docs/README.md
@@ -0,0 +1,154 @@
+CIL (Common Intermediate Language)
+===============
+## Table of Contents
+
+* [Introduction](cil_introduction.md#Introduction)
+  * [Design Philosophy](cil_introduction.md#design-philosophy)
+  * [Goals and Primary Features](cil_introduction.md#goals-and-primary-features)
+  * [Design Overview](cil_introduction.md#design-overview)
+
+* [CIL Information](cil_reference_guide.md#cil-information)
+  * [Declarations](cil_reference_guide.md#declarations)
+  * [Definitions](cil_reference_guide.md#definitions)
+  * [Symbol Character Set](cil_reference_guide.md#symbol-character-set)
+  * [String Character Set](cil_reference_guide.md#string-character-set)
+  * [Comments](cil_reference_guide.md#comments)
+  * [Namespaces](cil_reference_guide.md#namespaces)
+  * [Global Namespace](cil_reference_guide.md#global-namespace)
+  * [Expressions](cil_reference_guide.md#expressions)
+  * [Name String](cil_reference_guide.md#name-string)
+  * [self](cil_reference_guide.md#self)
+  * [Example CIL Policy](../test/policy.cil)
+
+* [Access Vector Rules](cil_access_vector_rules.md#access-vector-rules)
+  * [allow](cil_access_vector_rules.md#allow)
+  * [auditallow](cil_access_vector_rules.md#auditallow)
+  * [dontaudit](cil_access_vector_rules.md#dontaudit)
+  * [neverallow](cil_access_vector_rules.md#neverallow)
+  * [allowx](cil_access_vector_rules.md#allowx)
+  * [auditallowx](cil_access_vector_rules.md#auditallowx)
+  * [dontauditx](cil_access_vector_rules.md#dontauditx)
+  * [neverallowx](cil_access_vector_rules.md#neverallowx)
+
+* [Call / Macro Statements](cil_call_macro_statements.md#call--macro-statements)
+  * [call](cil_call_macro_statements.md#call)
+  * [macro](cil_call_macro_statements.md#macro)
+
+* [Class and Permission Statements](cil_class_and_permission_statements.md#class-and-permission-statements)
+  * [common](cil_class_and_permission_statements.md#common)
+  * [classcommon](cil_class_and_permission_statements.md#classcommon)
+  * [class](cil_class_and_permission_statements.md#class)
+  * [classorder](cil_class_and_permission_statements.md#classorder)
+  * [classpermission](cil_class_and_permission_statements.md#classpermission)
+  * [classpermissionset](cil_class_and_permission_statements.md#classpermissionset)
+  * [classmap](cil_class_and_permission_statements.md#classmap)
+  * [classmapping](cil_class_and_permission_statements.md#classmapping)
+  * [permissionx](cil_class_and_permission_statements.md#permissionx)
+
+* [Conditional Statements](cil_conditional_statements.md#conditional-statements)
+  * [boolean](cil_conditional_statements.md#boolean)
+  * [booleanif](cil_conditional_statements.md#booleanif)
+  * [tunable](cil_conditional_statements.md#tunable)
+  * [tunableif](cil_conditional_statements.md#tunableif)
+
+* [Constraint Statements](cil_constraint_statements.md#constraint-statements)
+  * [constrain](cil_constraint_statements.md#constrain)
+  * [validatetrans](cil_constraint_statements.md#validatetrans)
+  * [mlsconstrain](cil_constraint_statements.md#mlsconstrain)
+  * [mlsvalidatetrans](cil_constraint_statements.md#mlsvalidatetrans)
+
+* [Container Statements](cil_container_statements.md#container-statements)
+  * [block](cil_container_statements.md#block)
+  * [blockabstract](cil_container_statements.md#blockabstract)
+  * [blockinherit](cil_container_statements.md#blockinherit)
+  * [optional](cil_container_statements.md#optional)
+  * [in](cil_container_statements.md#in)
+
+* [Context Statement](cil_context_statement.md#context-statement)
+  * [context](cil_context_statement.md#context)
+
+* [Default Object Statements](cil_default_object_statements.md#default-object-statements)
+  * [defaultuser](cil_default_object_statements.md#defaultuser)
+  * [defaultrole](cil_default_object_statements.md#defaultrole)
+  * [defaulttype](cil_default_object_statements.md#defaulttype)
+  * [defaultrange](cil_default_object_statements.md#defaultrange)
+
+* [File Labeling Statements](cil_file_labeling_statements.md#file-labeling-statements)
+  * [filecon](cil_file_labeling_statements.md#filecon)
+  * [fsuse](cil_file_labeling_statements.md#fsuse)
+  * [genfscon](cil_file_labeling_statements.md#genfscon)
+
+* [Multi-Level Security Labeling Statements](cil_mls_labeling_statements.md#multi-level-security-labeling-statements)
+  * [sensitivity](cil_mls_labeling_statements.md#sensitivity)
+  * [sensitivityalias](cil_mls_labeling_statements.md#sensitivityalias)
+  * [sensitivityaliasactual](cil_mls_labeling_statements.md#sensitivityaliasactual)
+  * [sensitivityorder](cil_mls_labeling_statements.md#sensitivityorder)
+  * [category](cil_mls_labeling_statements.md#category)
+  * [categoryalias](cil_mls_labeling_statements.md#categoryalias)
+  * [categoryaliasactual](cil_mls_labeling_statements.md#categoryaliasactual)
+  * [categoryorder](cil_mls_labeling_statements.md#categoryorder)
+  * [categoryset](cil_mls_labeling_statements.md#categoryset)
+  * [sensitivitycategory](cil_mls_labeling_statements.md#sensitivitycategory)
+  * [level](cil_mls_labeling_statements.md#level)
+  * [levelrange](cil_mls_labeling_statements.md#levelrange)
+  * [rangetransition](cil_mls_labeling_statements.md#rangetransition)
+  * [mlsconstrain](cil_mls_labeling_statements.md#mlsconstrain)
+  * [mlsvalidatetrans](cil_mls_labeling_statements.md#mlsvalidatetrans)
+
+* [Network Labeling Statements](cil_network_labeling_statements.md#network-labeling-statements)
+  * [ipaddr](cil_network_labeling_statements.md#ipaddr)
+  * [netifcon](cil_network_labeling_statements.md#netifcon)
+  * [nodecon](cil_network_labeling_statements.md#nodecon)
+  * [portcon](cil_network_labeling_statements.md#portcon)
+
+* [Policy Configuration Statements](cil_policy_config_statements.md#policy-configuration-statements)
+  * [mls](cil_policy_config_statements.md#mls)
+  * [handleunknown](cil_policy_config_statements.md#handleunknown)
+  * [policycap](cil_policy_config_statements.md#policycap)
+
+* [Role Statements](cil_role_statements.md#role-statements)
+  * [role](cil_role_statements.md#role)
+  * [roletype](cil_role_statements.md#roletype)
+  * [roleattribute](cil_role_statements.md#roleattribute)
+  * [roleattributeset](cil_role_statements.md#roleattributeset)
+  * [roleallow](cil_role_statements.md#roleallow)
+  * [roletransition](cil_role_statements.md#roletransition)
+  * [rolebounds](cil_role_statements.md#rolebounds)
+
+* [SID Statements](cil_sid_statements.md#sid-statements)
+  * [sid](cil_sid_statements.md#sid)
+  * [sidorder](cil_sid_statements.md#sidorder)
+  * [sidcontext](cil_sid_statements.md#sidcontext)
+
+* [Type Statements](cil_type_statements.md#type-statements)
+  * [type](cil_type_statements.md#type)
+  * [typealias](cil_type_statements.md#typealias)
+  * [typealiasactual](cil_type_statements.md#typealiasactual)
+  * [typeattribute](cil_type_statements.md#typeattribute)
+  * [typeattributeset](cil_type_statements.md#typeattributeset)
+  * [typebounds](cil_type_statements.md#typebounds)
+  * [typechange](cil_type_statements.md#typechange)
+  * [typemember](cil_type_statements.md#typemember)
+  * [typetransition](cil_type_statements.md#typetransition)
+  * [typepermissive](cil_type_statements.md#typepermissive)
+
+* [User Statements](cil_user_statements.md#user-statements)
+  * [user](cil_user_statements.md#user)
+  * [userrole](cil_user_statements.md#userrole)
+  * [userattribute](cil_user_statements.md#userattribute)
+  * [userattributeset](cil_user_statements.md#userattributeset)
+  * [userlevel](cil_user_statements.md#userlevel)
+  * [userrange](cil_user_statements.md#userrange)
+  * [userbounds](cil_user_statements.md#userbounds)
+  * [userprefix](cil_user_statements.md#userprefix)
+  * [selinuxuser](cil_user_statements.md#selinuxuser)
+  * [selinuxuserdefault](cil_user_statements.md#selinuxuserdefault)
+
+* [Xen Statements](cil_xen_statements.md#xen-statements)
+  * [iomemcon](cil_xen_statements.md#iomemcon)
+  * [ioportcon](cil_xen_statements.md#ioportcon)
+  * [pcidevicecon](cil_xen_statements.md#pcidevicecon)
+  * [pirqcon](cil_xen_statements.md#pirqcon)
+  * [devicetreecon](cil_xen_statements.md#devicetreecon)
+
+* [Example Policy](../test/policy.cil#example-policy)
diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
new file mode 100644
index 0000000..9c03c71
--- /dev/null
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -0,0 +1,428 @@
+Access Vector Rules
+===================
+
+allow
+-----
+
+Specifies the access allowed between a source and target type. Note that access may be refined by constraint rules based on the source, target and class ([`validatetrans`](cil_constraint_statements.md#validatetrans) or [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans)) or source, target class and permissions ([`constrain`](cil_constraint_statements.md#constrain) or [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) statements).
+
+**Rule definition:**
+
+    (allow source_id target_id|self classpermissionset_id ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>allow</code></p></td>
+<td align="left"><p>The <code>allow</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show a selection of possible permutations of [`allow`](cil_access_vector_rules.md#allow) rules:
+
+    (class binder (impersonate call set_context_mgr transfer receive))
+    (class property_service (set))
+    (class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
+
+    (classpermission cps_zygote)
+    (classpermissionset cps_zygote (zygote (not (specifyids))))
+
+    (classmap android_classes (set_1 set_2 set_3))
+
+    (classmapping android_classes set_1 (binder (all)))
+    (classmapping android_classes set_1 (property_service (set)))
+    (classmapping android_classes set_1 (zygote (not (specifycapabilities))))
+
+    (classmapping android_classes set_2 (binder (impersonate call set_context_mgr transfer)))
+    (classmapping android_classes set_2 (zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith)))
+
+    (classmapping android_classes set_3 cps_zygote)
+    (classmapping android_classes set_3 (binder (impersonate call set_context_mgr)))
+
+    (block av_rules
+        (type type_1)
+        (type type_2)
+        (type type_3)
+        (type type_4)
+        (type type_5)
+
+        (typeattribute all_types)
+        (typeattributeset all_types (all))
+
+    ; These examples have named and anonymous classpermissionset's and
+    ; classmap/classmapping statements
+        (allow type_1 self (property_service (set)))          ; anonymous
+        (allow type_2 self (zygote (specifyids)))             ; anonymous
+        (allow type_3 self cps_zygote)                        ; named
+        (allow type_4 self (android_classes (set_3)))         ; classmap/classmapping
+        (allow all_types all_types (android_classes (set_2))) ; classmap/classmapping
+
+    ;; This rule will cause the build to fail unless --disable-neverallow
+    ;    (neverallow type_5 all_types (property_service (set)))
+        (allow type_5 type_5 (property_service (set)))
+        (allow type_1 all_types (property_service (set)))
+    )
+
+auditallow
+----------
+
+Audit the access rights defined if there is a valid allow rule. Note: It does NOT allow access, it only audits the event.
+
+**Rule definition:**
+
+    (auditallow source_id target_id|self classpermissionset_id ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="29%" />
+<col width="70%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>auditallow</code></p></td>
+<td align="left"><p>The <code>auditallow</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will log an audit event whenever the corresponding [`allow`](cil_access_vector_rules.md#allow) rule grants access to the specified permissions:
+
+    (allow release_app.process secmark_demo.browser_packet (packet (send recv append bind)))
+
+    (auditallow release_app.process secmark_demo.browser_packet (packet (send recv)))
+
+
+dontaudit
+---------
+
+Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
+
+Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
+
+**Rule definition:**
+
+    (dontaudit source_id target_id|self classpermissionset_id ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>dontaudit</code></p></td>
+<td align="left"><p>The <code>dontaudit</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will not audit the denied access:
+
+    (dontaudit zygote.process self (capability (fsetid)))
+
+neverallow
+----------
+
+Never allow access rights defined. This is a compiler enforced action that will stop compilation until the offending rules are modified.
+
+Note that these rules can be over-ridden by the CIL compiler command line parameter `-N` or `--disable-neverallow` flags.
+
+**Rule definition:**
+
+    (neverallow source_id target_id|self classpermissionset_id ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>neverallow</code></p></td>
+<td align="left"><p>The <code>neverallow</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will not compile as `type_3` is not allowed to be a source type for the [`allow`](cil_access_vector_rules.md#allow) rule:
+
+    (class property_service (set))
+
+    (block av_rules
+        (type type_1)
+        (type type_2)
+        (type type_3)
+        (typeattribute all_types)
+        (typeattributeset all_types ((all)))
+
+        (neverallow type_3 all_types (property_service (set)))
+        ; This rule will fail compilation:
+        (allow type_3 self (property_service (set)))
+    )
+
+allowx
+------
+
+Specifies the access allowed between a source and target type using extended permissions. Unlike the [`allow`](cil_access_vector_rules.md#allow) statement, the statements [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans), [`constrain`](cil_constraint_statements.md#constrain), and [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) do not limit accesses granted by [`allowx`](cil_access_vector_rules.md#allowx).
+
+**Rule definition:**
+
+    (allowx source_id target_id|self permissionx_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>allowx</code></p></td>
+<td align="left"><p>The <code>allowx</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code>, or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code>, or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permissionx_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show a selection of possible permutations of [`allowx`](cil_access_vector_rules.md#allowx) rules:
+
+    (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
+
+    (permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
+    (allowx type_3 type_4 ioctl_nodebug)
+
+
+
+auditallowx
+-----------
+
+Audit the access rights defined if there is a valid [`allowx`](cil_access_vector_rules.md#allowx) rule. It does NOT allow access, it only audits the event.
+
+**Rule definition:**
+
+    (auditallowx source_id target_id|self permissionx_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>auditallowx</code></p></td>
+<td align="left"><p>The <code>auditallowx</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permissionx_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example will log an audit event whenever the corresponding [`allowx`](cil_access_vector_rules.md#allowx) rule grants access to the specified extended permissions:
+
+    (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
+
+    (auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
+
+
+dontauditx
+----------
+
+Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
+
+Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
+
+**Rule definition:**
+
+    (dontauditx source_id target_id|self permissionx_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>dontauditx</code></p></td>
+<td align="left"><p>The <code>dontauditx</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permissionx_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example will not audit the denied access:
+
+    (dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
+
+
+neverallowx
+----------
+Never allow access rights defined for extended permissions. This is a compiler enforced action that will stop compilation until the offending rules are modified.
+
+Note that these rules can be over-ridden by the CIL compiler command line parameter `-N` or `--disable-neverallow` flags.
+
+**Rule definition:**
+
+    (neverallowx source_id target_id|self permissionx_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>neverallows</code></p></td>
+<td align="left"><p>The <code>neverallowx</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_id</code></p></td>
+<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_id</code></p></td>
+<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
+<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permissionx_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>permissionx</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example will not compile as `type_3` is not allowed to be a source type and ioctl range for the [`allowx`](cil_access_vector_rules.md#allowx) rule:
+
+	(class property_service (ioctl))
+	(block av_rules
+		(type type_1)
+		(type type_2)
+		(type type_3)
+		(typeattribute all_types)
+		(typeattributeset all_types ((all)))
+		(neverallowx type_3 all_types (ioctl property_service (range 0x2000 0x20FF)))
+		; This rule will fail compilation:
+		(allowx type_3 self (ioctl property_service (0x20A0)))
+	)
diff --git a/secilc/docs/cil_access_vector_rules.xml b/secilc/docs/cil_access_vector_rules.xml
deleted file mode 100644
index e768558..0000000
--- a/secilc/docs/cil_access_vector_rules.xml
+++ /dev/null
@@ -1,518 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- access_vector_rules.xml -->
-
-   <sect1 id="av_rules">
-      <title>Access Vector Rules</title>
-      <sect2 id="allow">
-         <title>allow</title>
-         <para>Specifies the access allowed between a source and target type. Note that access may be refined by constraint rules based on the source, target and class (<literal><link linkend="validatetrans">validatetrans</link></literal> or <literal><link linkend="mlsvalidatetrans">mlsvalidatetrans</link></literal>) or source, target class and permissions (<literal><link linkend="constrain">constrain</link></literal> or <literal><link linkend="mlsconstrain">mlsconstrain</link></literal> statements).</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(allow source_id target_id|self classpermissionset_id ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="allow">allow</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="allow">allow</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show a selection of possible permutations of <literal><link linkend="allow">allow</link></literal> rules:</para>
-         <programlisting><![CDATA[
-(class binder (impersonate call set_context_mgr transfer receive))
-(class property_service (set))
-(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
-
-(classpermission cps_zygote)
-(classpermissionset cps_zygote (zygote (not (specifyids))))
-
-(classmap android_classes (set_1 set_2 set_3))
-
-(classmapping android_classes set_1 (binder (all)))
-(classmapping android_classes set_1 (property_service (set)))
-(classmapping android_classes set_1 (zygote (not (specifycapabilities))))
-
-(classmapping android_classes set_2 (binder (impersonate call set_context_mgr transfer)))
-(classmapping android_classes set_2 (zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith)))
-
-(classmapping android_classes set_3 cps_zygote)
-(classmapping android_classes set_3 (binder (impersonate call set_context_mgr)))
-
-(block av_rules
-    (type type_1)
-    (type type_2)
-    (type type_3)
-    (type type_4)
-    (type type_5)
-
-    (typeattribute all_types)
-    (typeattributeset all_types (all))
-
-; These examples have named and anonymous classpermissionset's and
-; classmap/classmapping statements
-    (allow type_1 self (property_service (set)))          ; anonymous
-    (allow type_2 self (zygote (specifyids)))             ; anonymous
-    (allow type_3 self cps_zygote)                        ; named
-    (allow type_4 self (android_classes (set_3)))         ; classmap/classmapping
-    (allow all_types all_types (android_classes (set_2))) ; classmap/classmapping
-
-;; This rule will cause the build to fail unless --disable-neverallow
-;    (neverallow type_5 all_types (property_service (set)))
-    (allow type_5 type_5 (property_service (set)))
-    (allow type_1 all_types (property_service (set)))
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="auditallow">
-         <title>auditallow</title>
-         <para>Audit the access rights defined if there is a valid allow rule. Note: It does NOT allow access, it only audits the event.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(auditallow source_id target_id|self classpermissionset_id ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.5 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>auditallow</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>auditallow</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will log an audit event whenever the corresponding <literal><link linkend="allow">allow</link></literal> rule grants access to the specified permissions:</para>
-         <programlisting><![CDATA[
-(allow release_app.process secmark_demo.browser_packet (packet (send recv append bind)))
-
-(auditallow release_app.process secmark_demo.browser_packet (packet (send recv)))
-]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="dontaudit">
-         <title>dontaudit</title>
-         <para>Do not audit the access rights defined when access denied. This stops excessive log entries for known events.</para>
-         <para>Note that these rules can be omitted by the CIL compiler command line parameter <literal>-D</literal> or <literal>--disable-dontaudit</literal> flags.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(dontaudit source_id target_id|self classpermissionset_id ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>dontaudit</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>dontaudit</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will not audit the denied access:</para>
-         <programlisting><![CDATA[(dontaudit zygote.process self (capability (fsetid)))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="neverallow">
-         <title>neverallow</title>
-         <para>Never allow access rights defined. This is a compiler enforced action that will stop compilation until the offending rules are modified.</para>
-         <para>Note that these rules can be over-ridden by the CIL compiler command line parameter <literal>-N</literal> or <literal>--disable-neverallow</literal> flags.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(neverallow source_id target_id|self classpermissionset_id ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>neverallow</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>neverallow</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will not compile as <literal>type_3</literal> is not allowed to be a source type for the <literal><link linkend="allow">allow</link></literal> rule:</para>
-         <programlisting><![CDATA[
-(class property_service (set))
-
-(block av_rules
-    (type type_1)
-    (type type_2)
-    (type type_3)
-    (typeattribute all_types)
-    (typeattributeset all_types ((all)))
-
-    (neverallow type_3 all_types (property_service (set)))
-    ; This rule will fail compilation:
-    (allow type_3 self (property_service (set)))
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="allowx">
-         <title>allowx</title>
-         <para>Specifies the access allowed between a source and target type using extended permissions. Unlike the <literal><link linkend="allow">allow</link></literal> statement, the statements <literal><link linkend="validatetrans">validatetrans</link></literal>, <literal><link linkend="mlsvalidatetrans">mlsvalidatetrans</link></literal>, <literal><link linkend="constrain">constrain</link></literal>, and <literal><link linkend="mlsconstrain">mlsconstrain</link></literal> do not limit accesses granted by <literal><link linkend="allowx">allowx</link></literal>.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(allowx source_id target_id|self permissionx_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="allowx">allowx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="allowx">allowx</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal>, or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal>, or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permissionx_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="permissionx">permissionx</link></literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show a selection of possible permutations of <literal><link linkend="allowx">allowx</link></literal> rules:</para>
-         <programlisting><![CDATA[
-(allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
-
-(permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
-(allowx type_3 type_4 ioctl_nodebug)
-]]>
-
-         </programlisting>
-      </sect2>
-
-      <sect2 id="auditallowx">
-         <title>auditallowx</title>
-         <para>Audit the access rights defined if there is a valid <literal><link linkend="allowx">allowx</link></literal> rule. It does NOT allow access, it only audits the event.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(auditallowx source_id target_id|self permissionx_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="auditallowx">auditallowx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="auditallowx">auditallowx</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permissionx_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="permissionx">permissionx</link></literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example will log an audit event whenever the corresponding <literal><link linkend="allowx">allowx</link></literal> rule grants access to the specified extended permissions:</para>
-         <programlisting><![CDATA[
-(allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
-
-(auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
-]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="dontauditx">
-         <title>dontauditx</title>
-         <para>Do not audit the access rights defined when access denied. This stops excessive log entries for known events.</para>
-         <para>Note that these rules can be omitted by the CIL compiler command line parameter <literal>-D</literal> or <literal>--disable-dontaudit</literal> flags.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(dontauditx source_id target_id|self permissionx_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="dontauditx">dontauditx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="dontauditx">dontauditx</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permissionx_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="permissionx">permissionx</link></literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example will not audit the denied access:</para>
-         <programlisting><![CDATA[
-(dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
-]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="neverallowx">
-         <title>neverallowx</title>
-         <para>Never allow access rights defined for extended permissions. This is a compiler enforced action that will stop compilation until the offending rules are modified.</para>
-         <para>Note that these rules can be over-ridden by the CIL compiler command line parameter <literal>-N</literal> or <literal>--disable-neverallow</literal> flags.</para>
-         <para><emphasis role="bold">Rule definition:</emphasis></para>
-         <programlisting><![CDATA[(neverallowx source_id target_id|self permissionx_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>neverallowx</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>neverallowx</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined source <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously defined target <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                     <para>The <literal>self</literal> keyword may be used instead to signify that source and target are the same.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permissionx_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="permissionx">permissionx</link></literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will not compile as <literal>type_3</literal> is not allowed to be a source type and ioctl range for the <literal><link linkend="allowx">allowx</link></literal> rule:</para>
-         <programlisting><![CDATA[
-(class property_service (ioctl))
-
-(block av_rules
-    (type type_1)
-    (type type_2)
-    (type type_3)
-    (typeattribute all_types)
-    (typeattributeset all_types ((all)))
-
-    (neverallowx type_3 all_types (ioctl property_service (range 0x2000 0x20FF)))
-    ; This rule will fail compilation:
-    (allowx type_3 self (ioctl property_service (0x20A0)))
-)]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
new file mode 100644
index 0000000..17c46ed
--- /dev/null
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -0,0 +1,130 @@
+Call / Macro Statements
+=======================
+
+call
+----
+
+Instantiate a [macro](#macro) within the current namespace. There may be zero or more parameters passed to the macro (with zero parameters this is similar to the [`blockinherit`](cil_container_statements.md#blockinherit) ([`call`](cil_call_macro_statements.md#call)) / [`blockabstract`](cil_container_statements.md#blockabstract) ([`macro`](cil_call_macro_statements.md#macro)) statements).
+
+Each parameter passed contains an argument to be resolved by the [macro](#macro), these can be named or anonymous but must conform to the parameter types defined in the [`macro`](cil_call_macro_statements.md#macro) statement.
+
+**Statement definition:**
+
+    (call macro_id [(param ...)])
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>call</code></p></td>
+<td align="left"><p>The <code>call</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>macro_id</code></p></td>
+<td align="left"><p>The identifier of the <code>macro</code> to be instantiated.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>param</code></p></td>
+<td align="left"><p>Zero or more parameters that are passed to the macro.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`macro`](cil_call_macro_statements.md#macro) statement for an example.
+
+macro
+-----
+
+Declare a macro in the current namespace with its associated parameters. The macro identifier is used by the [`call`](cil_call_macro_statements.md#call) statement to instantiate the macro and resolve any parameters. The call statement may be within the body of a macro.
+
+Note that when resolving macros the callers namespace is not checked, only the following places:
+
+-   Items defined inside the macro
+
+-   Items passed into the macro as arguments
+
+-   Items defined in the same namespace of the macro
+
+-   Items defined in the global namespace
+
+**Statement definition:**
+
+    (macro macro_id ([(param_type param_id) ...])
+        cil_statements
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>macro</code></p></td>
+<td align="left"><p>The <code>macro</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>macro_id</code></p></td>
+<td align="left"><p>The <code>macro</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>param_type</code></p></td>
+<td align="left"><p>Zero or more parameters that are passed to the macro. The <code>param_type</code> is a keyword used to determine the declaration type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</code>).</p>
+<p>The list of valid <code>param_type</code> entries are: <code>type</code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <code>level</code> (named or anonymous), <code>levelrange</code> (named or anonymous), <code>class</code>, <code>classpermission</code> (named or anonymous), <code>ipaddr</code> (named or anonymous), <code>block</code>, <code>name</code> (a string), <code>classmap</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>param_id</code></p></td>
+<td align="left"><p>The parameter identifier used to reference the entry within the macro body (e.g. <code>ARG1</code>).</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example will instantiate the `binder_call` macro in the calling namespace (`my_domain`) and replace `ARG1` with `appdomain` and `ARG2` with `binderservicedomain`:
+
+    (block my_domain
+        (call binder_call (appdomain binderservicedomain))
+    )
+
+    (macro binder_call ((type ARG1) (type ARG2))
+        (allow ARG1 ARG2 (binder (call transfer)))
+        (allow ARG2 ARG1 (binder (transfer)))
+        (allow ARG1 ARG2 (fd (use)))
+    )
+
+This example does not pass any parameters to the macro but adds a [`type`](cil_type_statements.md#type) identifier to the current namespace:
+
+    (block unconfined
+        (call add_type)
+        ....
+
+        (macro add_type ()
+            (type exec)
+        )
+    )
+
+This example passes an anonymous and named IP address to the macro:
+
+    (ipaddr netmask_1 255.255.255.0)
+    (context netlabel_1 (system.user object_r unconfined.object low_low)
+
+    (call build_nodecon ((192.168.1.64) netmask_1))
+
+    (macro build_nodecon ((ipaddr ARG1) (ipaddr ARG2))
+        (nodecon ARG1 ARG2  netlabel_1)
+    )
diff --git a/secilc/docs/cil_call_macro_statements.xml b/secilc/docs/cil_call_macro_statements.xml
deleted file mode 100644
index b783515..0000000
--- a/secilc/docs/cil_call_macro_statements.xml
+++ /dev/null
@@ -1,174 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- call_macro_statements.xml -->
-
-   <sect1>
-      <title>Call / Macro Statements</title>
-      <sect2 id="call">
-         <title>call</title>
-         <para>Instantiate a <link linkend="macro">macro</link> within the current namespace. There may be zero or more parameters passed to the macro (with zero parameters this is similar to the <literal><link linkend="blockinherit">blockinherit</link></literal> (<literal><link linkend="call">call</link></literal>) / <literal><link linkend="blockabstract">blockabstract</link></literal> (<literal><link linkend="macro">macro</link></literal>) statements).</para>
-         <para>Each parameter passed contains an argument to be resolved by the <link linkend="macro">macro</link>, these can be named or anonymous but must conform to the parameter types defined in the <literal><link linkend="macro">macro</link></literal> statement.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(call macro_id [(param ...)])]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="call">call</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="call">call</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>macro_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The identifier of the <literal><link linkend="macro">macro</link></literal> to be instantiated.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>param</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more parameters that are passed to the macro.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="macro">macro</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="macro">
-         <title>macro</title>
-         <para>Declare a macro in the current namespace with its associated parameters. The macro identifier is used by the <literal><link linkend="call">call</link></literal> statement to instantiate the macro and resolve any parameters. The call statement may be within the body of a macro.</para>
-
-         <para>Note that when resolving macros the callers namespace is not checked, only the following places:
-            <itemizedlist>
-              <listitem><simpara>Items defined inside the macro</simpara></listitem>
-              <listitem><simpara>Items passed into the macro as arguments</simpara></listitem>
-              <listitem><simpara>Items defined in the same namespace of the macro</simpara></listitem>
-              <listitem><simpara>Items defined in the global namespace</simpara></listitem>
-            </itemizedlist>
-         </para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(macro macro_id ([(param_type param_id) ...])
-    cil_statements
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="macro">macro</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="macro">macro</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>macro_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="macro">macro</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>param_type</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more parameters that are passed to the macro. The <literal>param_type</literal> is a keyword used to determine the declaration type (e.g. <literal>type</literal>, <literal>class</literal>, <literal>categoryset</literal>).</para>
-                     <para>The list of valid <literal>param_type</literal> entries are:
-                     <simplelist type="inline">
-                        <member><literal><link linkend="type">type</link></literal></member>
-                        <member><literal><link linkend="typealias">typealias</link></literal></member>
-                        <member><literal><link linkend="role">role</link></literal></member>
-                        <member><literal><link linkend="user">user</link></literal></member>
-                        <member><literal><link linkend="sensitivity">sensitivity</link></literal></member>
-                        <member><literal><link linkend="sensitivityalias">sensitivityalias</link></literal></member>
-                        <member><literal><link linkend="category">category</link></literal></member>
-                        <member><literal><link linkend="categoryalias">categoryalias</link></literal></member>
-                        <member><literal><link linkend="categoryset">categoryset</link></literal> (named or anonymous)</member>
-                        <member><literal><link linkend="level">level</link></literal> (named or anonymous)</member>
-                        <member><literal><link linkend="levelrange">levelrange</link></literal> (named or anonymous)</member>
-                        <member><literal><link linkend="class">class</link></literal></member>
-                        <member><literal><link linkend="classpermission">classpermission</link></literal> (named or anonymous)</member>
-                        <member><literal><link linkend="ipaddr">ipaddr</link></literal> (named or anonymous)</member>
-                        <member><literal><link linkend="boolean">block</link></literal></member>
-                        <member><literal><link linkend="name">name</link></literal> (a string)</member>
-                        <member><literal><link linkend="classmap">classmap</link></literal></member>
-                     </simplelist></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>param_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The parameter identifier used to reference the entry within the macro body (e.g. <literal>ARG1</literal>).</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example will instantiate the <literal>binder_call</literal> macro in the calling namespace (<literal>my_domain</literal>) and replace <literal>ARG1</literal> with <literal>appdomain</literal> and <literal>ARG2</literal> with <literal>binderservicedomain</literal>:</para>
-         <programlisting><![CDATA[
-(block my_domain
-    (call binder_call (appdomain binderservicedomain))
-)
-
-(macro binder_call ((type ARG1) (type ARG2))
-    (allow ARG1 ARG2 (binder (call transfer)))
-    (allow ARG2 ARG1 (binder (transfer)))
-    (allow ARG1 ARG2 (fd (use)))
-)]]>
-         </programlisting>
-
-         <para>This example does not pass any parameters to the macro but adds a <literal>type</literal> identifier to the current namespace:</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (call add_type)
-    ....
-
-    (macro add_type ()
-        (type exec)
-    )
-)]]>
-         </programlisting>
-
-         <para>This example passes an anonymous and named IP address to the macro:</para>
-         <programlisting><![CDATA[
-(ipaddr netmask_1 255.255.255.0)
-(context netlabel_1 (system.user object_r unconfined.object low_low)
-
-(call build_nodecon ((192.168.1.64) netmask_1))
-
-(macro build_nodecon ((ipaddr ARG1) (ipaddr ARG2))
-    (nodecon ARG1 ARG2  netlabel_1)
-)]]>
-         </programlisting>
-      </sect2>
-   </sect1>
diff --git a/secilc/docs/cil_class_and_permission_statements.md b/secilc/docs/cil_class_and_permission_statements.md
new file mode 100644
index 0000000..290af50
--- /dev/null
+++ b/secilc/docs/cil_class_and_permission_statements.md
@@ -0,0 +1,522 @@
+Class and Permission Statements
+===============================
+
+common
+------
+
+Declares a common identifier in the current namespace with a set of common permissions that can be used by one or more [`class`](cil_class_and_permission_statements.md#class) identifiers. The [`classcommon`](cil_class_and_permission_statements.md#classcommon) statement is used to associate a [`common`](cil_class_and_permission_statements.md#common) identifier to a specific [`class`](cil_class_and_permission_statements.md#class) identifier.
+
+**Statement definition:**
+
+    (common common_id (permission_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>common</code></p></td>
+<td align="left"><p>The <code>common</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>common_id</code></p></td>
+<td align="left"><p>The <code>common</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>permission_id</code></p></td>
+<td align="left"><p>One or more permissions.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This common statement will associate the [`common`](cil_class_and_permission_statements.md#common) identifier '`file`' with the list of permissions:
+
+    (common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
+
+classcommon
+-----------
+
+Associate a [`class`](cil_class_and_permission_statements.md#class) identifier to a one or more permissions declared by a [`common`](cil_class_and_permission_statements.md#common) identifier.
+
+**Statement definition:**
+
+    (classcommon class_id common_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classcommon</code></p></td>
+<td align="left"><p>The <code>classcommon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>common_id</code></p></td>
+<td align="left"><p>A single previously declared <code>common</code> identifier that defines the common permissions for that class.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This associates the `dir` class with the list of permissions declared by the `file common` identifier:
+
+    (common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
+
+    (classcommon dir file)
+
+class
+-----
+
+Declares a class and zero or more permissions in the current namespace.
+
+**Statement definition:**
+
+    (class class_id (permission_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>class</code></p></td>
+<td align="left"><p>The <code>class</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>The <code>class</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>permission_id</code></p></td>
+<td align="left"><p>Zero or more permissions declared for the class. Note that if zero permissions, an empty list is required as shown in the example.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example defines a set of permissions for the `binder` class indentifier:
+
+    (class binder (impersonate call set_context_mgr transfer receive))
+
+This example defines a common set of permissions to be used by the `sem` class, the `(class sem ())` does not define any other permissions (i.e. an empty list):
+
+    (common ipc (create destroy getattr setattr read write associate unix_read unix_write))
+
+    (classcommon sem ipc)
+    (class sem ())
+
+and will produce the following set of permissions for the `sem` class identifier of:
+
+    (class sem (create destroy getattr setattr read write associate unix_read unix_write))
+
+This example, with the following combination of the [`common`](cil_class_and_permission_statements.md#common), [`classcommon`](cil_class_and_permission_statements.md#classcommon) and [`class`](cil_class_and_permission_statements.md#class) statements:
+
+    (common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
+
+    (classcommon dir file)
+    (class dir (add_name remove_name reparent search rmdir open audit_access execmod))
+
+will produce a set of permissions for the `dir` class identifier of:
+
+    (class dir (add_name remove_name reparent search rmdir open audit_access execmod ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
+
+classorder
+----------
+
+Defines the order of [class](#class)'s. This is a mandatory statement. Multiple [`classorder`](cil_class_and_permission_statements.md#classorder) statements declared in the policy will form an ordered list.
+
+**Statement definition:**
+
+    (classorder (class_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classorder</code></p></td>
+<td align="left"><p>The <code>classorder</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>One or more <code>class</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This will produce an ordered list of "`file dir process`"
+
+    (class process)
+    (class file)
+    (class dir)
+    (classorder (file dir))
+    (classorder (dir process))
+
+**Unordered Classorder Statement:**
+
+If users do not have knowledge of the existing [`classorder`](#classorder), the `unordered` keyword may be used in a [`classorder`](#classorder) statement. The [classes](#class) in an unordered statement are appended to the existing [`classorder`](#classorder). A class in an ordered statement always supercedes the class redeclaration in an unordered statement. The `unordered` keyword must be the first item in the [`classorder`](#classorder) listing.
+
+**Example:**
+
+This will produce an unordered list of "`file dir foo a bar baz`"
+
+	(class file)
+	(class dir)
+	(class foo)
+	(class bar)
+	(class baz)
+	(class a)
+	(classorder (file dir))
+	(classorder (dir foo))
+	(classorder (unordered a))
+	(classorder (unordered bar foo baz))
+
+classpermission
+---------------
+
+Declares a class permission set identifier in the current namespace that can be used by one or more [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset)s to associate one or more classes and permissions to form a named set.
+
+**Statement definition:**
+
+    (classpermission classpermissionset_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classpermission</code></p></td>
+<td align="left"><p>The <code>classpermission</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>The <code>classpermissionset</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset) statement for examples.
+
+classpermissionset
+------------------
+
+Defines a class permission set identifier in the current namespace that associates a class and one or more permissions to form a named set. Nested expressions may be used to determine the required permissions as shown in the examples. Anonymous [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset)s may be used in av rules and constraints.
+
+**Statement definition:**
+
+    (classpermissionset classpermissionset_id (class_id (permission_id | expr ...)))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classpermissionset</code></p></td>
+<td align="left"><p>The <code>classpermissionset</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>The <code>classpermissionset</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permission_id</code></p></td>
+<td align="left"><p>Zero or more permissions required by the class.</p>
+<p>Note that there must be at least one <code>permission</code> identifier or <code>expr</code> declared).</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (permission_id ...) (permission_id ...))</code></p>
+<p><code>    (or  (permission_id ...) (permission_id ...))</code></p>
+<p><code>    (xor (permission_id ...) (permission_id ...))</code></p>
+<p><code>    (not (permission_id ...))</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These class permission set statements will resolve to the permission sets shown in the kernel policy language [`allow`](cil_access_vector_rules.md#allow) rules:
+
+    (class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
+
+    (type test_1)
+    (type test_2)
+    (type test_3)
+    (type test_4)
+    (type test_5)
+
+    ; NOT
+    (classpermission zygote_1)
+    (classpermissionset zygote_1 (zygote
+        (not
+            (specifyinvokewith specifyseinfo)
+        )
+    ))
+    (allow unconfined.process test_1 zygote_1)
+    ;; allow unconfined.process test_1 : zygote { specifyids specifyrlimits specifycapabilities } ;
+
+    ; AND - ALL - NOT - Equiv to test_1
+    (classpermission zygote_2)
+    (classpermissionset zygote_2 (zygote
+        (and
+            (all)
+            (not (specifyinvokewith specifyseinfo))
+        )
+    ))
+    (allow unconfined.process test_2 zygote_2)
+    ;; allow unconfined.process test_2 : zygote { specifyids specifyrlimits specifycapabilities  } ;
+
+    ; OR
+    (classpermission zygote_3)
+    (classpermissionset zygote_3 (zygote ((or (specifyinvokewith) (specifyseinfo)))))
+    (allow unconfined.process test_3 zygote_3)
+    ;; allow unconfined.process test_3 : zygote { specifyinvokewith specifyseinfo } ;
+
+    ; XOR - This will not produce an allow rule as the XOR will remove all the permissions:
+    (classpermission zygote_4)
+    (classpermissionset zygote_4 (zygote (xor (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo) (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))))
+
+    ; ALL
+    (classpermission zygote_all_perms)
+    (classpermissionset zygote_all_perms (zygote (all)))
+    (allow unconfined.process test_5 zygote_all_perms)
+    ;; allow unconfined.process test_5 : zygote { specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo } ;
+
+classmap
+--------
+
+Declares a class map identifier in the current namespace and one or more class mapping identifiers. This will allow:
+
+1.  Multiple [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset)s to be linked to a pair of [`classmap`](cil_class_and_permission_statements.md#classmap) / [`classmapping`](cil_class_and_permission_statements.md#classmapping) identifiers.
+
+2.  Multiple [`class`](cil_class_and_permission_statements.md#class)s to be associated to statements and rules that support a list of classes:
+
+    typetransition
+    typechange
+    typemember
+    rangetransition
+    roletransition
+    defaultuser
+    defaultrole
+    defaulttype
+    defaultrange
+    validatetrans
+    mlsvalidatetrans
+
+**Statement definition:**
+
+    (classmap classmap_id (classmapping_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classmap</code></p></td>
+<td align="left"><p>The <code>classmap</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classmap_id</code></p></td>
+<td align="left"><p>The <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>classmapping_id</code></p></td>
+<td align="left"><p>One or more <code>classmapping</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`classmapping`](cil_class_and_permission_statements.md#classmapping) statement for examples.
+
+classmapping
+------------
+
+Define sets of [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset)s (named or anonymous) to form a consolidated [`classmapping`](cil_class_and_permission_statements.md#classmapping) set. Generally there are multiple [`classmapping`](cil_class_and_permission_statements.md#classmapping) statements with the same [`classmap`](cil_class_and_permission_statements.md#classmap) and [`classmapping`](cil_class_and_permission_statements.md#classmapping) identifiers that form a set of different [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset)'s. This is useful when multiple class / permissions are required in rules such as the [`allow`](cil_access_vector_rules.md#allow) rules (as shown in the examples).
+
+**Statement definition:**
+
+    (classmapping classmap_id classmapping_id classpermissionset_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>classmapping</code></p></td>
+<td align="left"><p>The <code>classmapping</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classmap_id</code></p></td>
+<td align="left"><p>A single previously declared <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>classmapping_id</code></p></td>
+<td align="left"><p>The <code>classmapping</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named <code>classpermissionset</code> identifier or a single anonymous <code>classpermissionset</code> using <code>expr</code>'s as required (see the <code>classpermissionset</code> statement).</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These class mapping statements will resolve to the permission sets shown in the kernel policy language [`allow`](cil_access_vector_rules.md#allow) rules:
+
+    (class binder (impersonate call set_context_mgr transfer receive))
+    (class property_service (set))
+    (class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
+
+    (classpermission cps_zygote)
+    (classpermissionset cps_zygote (zygote (not (specifyids))))
+
+    (classmap android_classes (set_1 set_2 set_3))
+
+    (classmapping android_classes set_1 (binder (all)))
+    (classmapping android_classes set_1 (property_service (set)))
+    (classmapping android_classes set_1 (zygote (not (specifycapabilities))))
+
+    (classmapping android_classes set_2 (binder (impersonate call set_context_mgr transfer)))
+    (classmapping android_classes set_2 (zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith)))
+
+    (classmapping android_classes set_3 cps_zygote)
+    (classmapping android_classes set_3 (binder (impersonate call set_context_mgr)))
+
+    (block map_example
+        (type type_1)
+        (type type_2)
+        (type type_3)
+
+        (allow type_1 self (android_classes (set_1)))
+        (allow type_2 self (android_classes (set_2)))
+        (allow type_3 self (android_classes (set_3)))
+    )
+
+    ; The above will resolve to the following AV rules:
+    ;; allow map_example.type_1 map_example.type_1 : binder { impersonate call set_context_mgr transfer receive } ;
+    ;; allow map_example.type_1 map_example.type_1 : property_service set ;
+    ;; allow map_example.type_1 map_example.type_1 : zygote { specifyids specifyrlimits specifyinvokewith specifyseinfo } ;
+
+    ;; allow map_example.type_2 map_example.type_2 : binder { impersonate call set_context_mgr transfer } ;
+    ;; allow map_example.type_2 map_example.type_2 : zygote { specifyids specifyrlimits specifycapabilities specifyinvokewith } ;
+
+    ;; allow map_example.type_3 map_example.type_3 : binder { impersonate call set_context_mgr } ;
+    ;; allow map_example.type_3 map_example.type_3 : zygote { specifyrlimits specifycapabilities specifyinvokewith specifyseinfo } ;
+
+permissionx
+-----------
+
+Defines a named extended permission, which can be used in the [`allowx`](cil_access_vector_rules.md#allowx), [`auditallowx`](cil_access_vector_rules.md#auditallowx), [`dontauditx`](cil_access_vector_rules.md#dontauditx), and  [`neverallowx`](cil_access_vector_rules.md#neverallowx) statements.
+
+**Statement definition:**
+
+    (permissionx permissionx_id (kind class_id (permission ... | expr ...)))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>permissionx</code></p></td>
+<td align="left"><p>The <code>permissionx</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>kind</code></p></td>
+<td align="left"><p>A keyword specifying how to interpret the extended permission values. Must be one of:</p>
+<table>
+<thead>
+<tr class="header">
+<th align="left"><p><strong>kind</strong></p></th>
+<th align="left"><p><strong>description</strong></p></th>
+</tr>
+</thead>
+<tbody>
+<tr class="odd">
+<td align="left"><p>ioctl</p></td>
+<td align="left"><p>Permissions define a whitelist of ioctl values. Permission values must range from <code>0x0000</code> to <code>0xFFFF</code>, inclusive.</p></td>
+</tr>
+</tbody>
+</table></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>permission</code></p></td>
+<td align="left"><p>One or more numeric values, specified in decimal, or hexadecimal if prefixed with 0x, or octal if prefixed with 0. Values are interpreted based on the value of <code>kind</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>An expression, with valid operators and syntax:</p>
+<p><code>    (range (permission ...) (permission ...))</code></p>
+<p><code>    (and (permission ...) (permission ...))</code></p>
+<p><code>    (or  (permission ...) (permission ...))</code></p>
+<p><code>    (xor (permission ...) (permission ...))</code></p>
+<p><code>    (not (permission ...))</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+    (permissionx ioctl_1 (ioctl tcp_socket (0x2000 0x3000 0x4000)))
+    (permissionx ioctl_2 (ioctl tcp_socket (range 0x6000 0x60FF)))
+    (permissionx ioctl_3 (ioctl tcp_socket (and (range 0x8000 0x90FF) (not (range 0x8100 0x82FF)))))
diff --git a/secilc/docs/cil_class_and_permission_statements.xml b/secilc/docs/cil_class_and_permission_statements.xml
deleted file mode 100644
index f4982e0..0000000
--- a/secilc/docs/cil_class_and_permission_statements.xml
+++ /dev/null
@@ -1,604 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- class_and_permission_statements.xml -->
-
-   <sect1>
-      <title>Class and Permission Statements</title>
-      <sect2 id="common">
-         <title>common</title>
-         <para>Declares a common identifier in the current namespace with a set of common permissions that can be used by one or more <literal><link linkend="class">class</link></literal> identifiers. The <literal><link linkend="classcommon">classcommon</link></literal> statement is used to associate a <literal><link linkend="common">common</link></literal> identifier to a specific <literal><link linkend="class">class</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(common common_id (permission_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="common">common</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="common">common</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>common_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="common">common</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permission_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more permissions.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This common statement will associate the <literal><link linkend="common">common</link></literal> identifier '<literal>file</literal>' with the list of permissions:</para>
-         <programlisting><![CDATA[
-(common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="classcommon">
-         <title>classcommon</title>
-         <para>Associate a <literal><link linkend="class">class</link></literal> identifier to a one or more permissions declared by a <literal><link linkend="common">common</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classcommon class_id common_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="classcommon">classcommon</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classcommon">classcommon</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>common_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="common">common</link></literal> identifier that defines the common permissions for that class.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This associates the <literal>dir</literal> class with the list of permissions declared by the <literal>file common</literal> identifier:</para>
-         <programlisting><![CDATA[
-(common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
-
-(classcommon dir file)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="class">
-         <title>class</title>
-         <para>Declares a class and zero or more permissions in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(class class_id (permission_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="class">class</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="class">class</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="class">class</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permission_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more permissions declared for the class. Note that if zero permissions, an empty list is required as shown in the example.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example defines a set of permissions for the <literal>binder</literal> class indentifier:</para>
-         <programlisting><![CDATA[(class binder (impersonate call set_context_mgr transfer receive))]]>
-         </programlisting>
-
-         <para>This example defines a common set of permissions to be used by the <literal>sem</literal> class, the <literal>(class sem ())</literal> does not define any other permissions (i.e. an empty list):</para>
-         <programlisting><![CDATA[
-(common ipc (create destroy getattr setattr read write associate unix_read unix_write))
-
-(classcommon sem ipc)
-(class sem ())]]>
-         </programlisting>
-         <simpara>and will produce the following set of permissions for the <literal>sem</literal> class identifier of:</simpara>
-         <programlisting><![CDATA[(class sem (create destroy getattr setattr read write associate unix_read unix_write))]]>
-         </programlisting>
-
-         <para>This example, with the following combination of the <literal><link linkend="common">common</link></literal>, <literal><link linkend="classcommon">classcommon</link></literal> and <literal><link linkend="class">class</link></literal> statements:</para>
-         <programlisting><![CDATA[
-(common file (ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))
-
-(classcommon dir file)
-(class dir (add_name remove_name reparent search rmdir open audit_access execmod))]]>
-         </programlisting>
-         <simpara>will produce a set of permissions for the <literal>dir</literal> class identifier of:</simpara>
-         <programlisting><![CDATA[(class dir (add_name remove_name reparent search rmdir open audit_access execmod ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton))]]>
-         </programlisting>
-      </sect2>
-      <sect2 id="classorder">
-         <title>classorder</title>
-         <para>Defines the order of <link linkend="class">class</link>'s. This is a mandatory statement. Multiple <literal>classorder</literal> statements declared in the policy will form an ordered list.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classorder (class_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>classorder</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>classorder</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more <literal><link linkend="class">class</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will produce an ordered list of "<literal>file dir process</literal>"</para>
-         <programlisting><![CDATA[
-(class process)
-(class file)
-(class dir)
-(classorder (file dir))
-(classorder (dir process))]]>
-      </programlisting>
-         <para><emphasis role="bold">Unordered Classorder Statement:</emphasis></para>
-         <para>If users do not have knowledge of the existing classorder, the <literal>unordered</literal> keyword may be used in a <literal>classorder</literal> statement. The <link linkend="class">class</link>es in an unordered statement are appended to the existing classorder. A class in an ordered statement always supercedes the class redeclaration in an unordered statement. The <literal>unordered</literal> keyword must be the first item in the classorder listing.</para>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will produce an ordered list of "<literal>file dir foo a bar baz</literal>"</para>
-         <programlisting><![CDATA[
-(class file)
-(class dir)
-(class foo)
-(class bar)
-(class baz)
-(class a)
-(classorder (file dir))
-(classorder (dir foo))
-(classorder (unordered a))
-(classorder (unordered bar foo baz))]]>
-      </programlisting>
-      </sect2>
-     <sect2 id="classpermission">
-         <title>classpermission</title>
-         <para>Declares a class permission set identifier in the current namespace that can be used by one or more <literal><link linkend="classpermissionset">classpermissionset</link></literal>s to associate one or more classes and permissions to form a named set.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classpermission classpermissionset_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="classpermission">classpermission</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classpermission">classpermission</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classpermissionset">classpermissionset</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="classpermissionset">classpermissionset</link></literal> statement for examples.</para>
-      </sect2>
-
-      <sect2 id="classpermissionset">
-         <title>classpermissionset</title>
-         <para>Defines a class permission set identifier in the current namespace that associates a class and one or more permissions to form a named set. Nested expressions may be used to determine the required permissions as shown in the examples. Anonymous <literal>classpermissionset</literal>s may be used in av rules and constraints.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classpermissionset classpermissionset_id (class_id (permission_id | expr ...)))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="classpermissionset">classpermissionset</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classpermissionset">classpermissionset</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classpermissionset">classpermissionset</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permission_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more permissions required by the class.</para>
-                     <para>Note that there must be at least one <literal>permission</literal> identifier or <literal>expr</literal> declared).</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (permission_id ...) (permission_id ...))</literal></simpara>
-                     <simpara><literal>    (or  (permission_id ...) (permission_id ...))</literal></simpara>
-                     <simpara><literal>    (xor (permission_id ...) (permission_id ...))</literal></simpara>
-                     <simpara><literal>    (not (permission_id ...))</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These class permission set statements will resolve to the permission sets shown in the kernel policy language <literal><link linkend="allow">allow</link></literal> rules:</para>
-         <programlisting><![CDATA[
-(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
-
-(type test_1)
-(type test_2)
-(type test_3)
-(type test_4)
-(type test_5)
-
-; NOT
-(classpermission zygote_1)
-(classpermissionset zygote_1 (zygote
-    (not
-        (specifyinvokewith specifyseinfo)
-    )
-))
-(allow unconfined.process test_1 zygote_1)
-;; allow unconfined.process test_1 : zygote { specifyids specifyrlimits specifycapabilities } ;
-
-; AND - ALL - NOT - Equiv to test_1
-(classpermission zygote_2)
-(classpermissionset zygote_2 (zygote
-    (and
-        (all)
-        (not (specifyinvokewith specifyseinfo))
-    )
-))
-(allow unconfined.process test_2 zygote_2)
-;; allow unconfined.process test_2 : zygote { specifyids specifyrlimits specifycapabilities  } ;
-
-; OR
-(classpermission zygote_3)
-(classpermissionset zygote_3 (zygote ((or (specifyinvokewith) (specifyseinfo)))))
-(allow unconfined.process test_3 zygote_3)
-;; allow unconfined.process test_3 : zygote { specifyinvokewith specifyseinfo } ;
-
-; XOR - This will not produce an allow rule as the XOR will remove all the permissions:
-(classpermission zygote_4)
-(classpermissionset zygote_4 (zygote (xor (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo) (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))))
-
-; ALL
-(classpermission zygote_all_perms)
-(classpermissionset zygote_all_perms (zygote (all)))
-(allow unconfined.process test_5 zygote_all_perms)
-;; allow unconfined.process test_5 : zygote { specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo } ;]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="classmap">
-         <title>classmap</title>
-         <para>Declares a class map identifier in the current namespace and one or more class mapping identifiers. This will allow:</para>
-         <orderedlist>
-            <listitem><para>Multiple <literal><link linkend="classpermissionset">classpermissionset</link></literal>s to be linked to a pair of <literal><link linkend="classmap">classmap</link></literal> / <literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para></listitem>
-            <listitem><para>Multiple <literal><link linkend="class">class</link></literal>s to be associated to statements and rules that support a list of classes:</para>
-            <simplelist type="inline">
-               <member><literal><link linkend="typetransition">typetransition</link></literal></member>
-               <member><literal><link linkend="typechange">typechange</link></literal></member>
-               <member><literal><link linkend="typemember">typemember</link></literal></member>
-               <member><literal><link linkend="rangetransition">rangetransition</link></literal></member>
-               <member><literal><link linkend="roletransition">roletransition</link></literal></member>
-               <member><literal><link linkend="defaultuser">defaultuser</link></literal></member>
-               <member><literal><link linkend="defaultrole">defaultrole</link></literal></member>
-               <member><literal><link linkend="defaulttype">defaulttype</link></literal></member>
-               <member><literal><link linkend="defaultrange">defaultrange</link></literal></member>
-               <member><literal><link linkend="validatetrans">validatetrans</link></literal></member>
-               <member><literal><link linkend="mlsvalidatetrans">mlsvalidatetrans</link></literal></member>
-            </simplelist></listitem>
-         </orderedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classmap classmap_id (classmapping_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="classmap">classmap</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classmap">classmap</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classmap_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classmapping_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more <literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="classmapping">classmapping</link></literal> statement for examples.</para>
-      </sect2>
-
-      <sect2 id="classmapping">
-         <title>classmapping</title>
-         <para>Define sets of <literal><link linkend="classpermissionset">classpermissionset</link></literal>s (named or anonymous) to form a consolidated <literal><link linkend="classmapping">classmapping</link></literal> set. Generally there are multiple <literal><link linkend="classmapping">classmapping</link></literal> statements with the same <literal><link linkend="classmap">classmap</link></literal> and <literal><link linkend="classmapping">classmapping</link></literal> identifiers that form a set of different <literal><link linkend="classpermissionset">classpermissionset</link></literal>'s. This is useful when multiple class / permissions are required in rules such as the <literal><link linkend="allow">allow</link></literal> rules (as shown in the examples).</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(classmapping classmap_id classmapping_id classpermissionset_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="classmapping">classmapping</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classmapping">classmapping</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classmap_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classmapping_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="classmapping">classmapping</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named <literal><link linkend="classpermissionset">classpermissionset</link></literal> identifier or a single anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> using <literal>expr</literal>'s as required (see the <literal><link linkend="classpermissionset">classpermissionset</link></literal> statement).</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These class mapping statements will resolve to the permission sets shown in the kernel policy language <literal><link linkend="allow">allow</link></literal> rules:</para>
-         <programlisting><![CDATA[
-(class binder (impersonate call set_context_mgr transfer receive))
-(class property_service (set))
-(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
-
-(classpermission cps_zygote)
-(classpermissionset cps_zygote (zygote (not (specifyids))))
-
-(classmap android_classes (set_1 set_2 set_3))
-
-(classmapping android_classes set_1 (binder (all)))
-(classmapping android_classes set_1 (property_service (set)))
-(classmapping android_classes set_1 (zygote (not (specifycapabilities))))
-
-(classmapping android_classes set_2 (binder (impersonate call set_context_mgr transfer)))
-(classmapping android_classes set_2 (zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith)))
-
-(classmapping android_classes set_3 cps_zygote)
-(classmapping android_classes set_3 (binder (impersonate call set_context_mgr)))
-
-(block map_example
-    (type type_1)
-    (type type_2)
-    (type type_3)
-
-    (allow type_1 self (android_classes (set_1)))
-    (allow type_2 self (android_classes (set_2)))
-    (allow type_3 self (android_classes (set_3)))
-)
-
-; The above will resolve to the following AV rules:
-;; allow map_example.type_1 map_example.type_1 : binder { impersonate call set_context_mgr transfer receive } ;
-;; allow map_example.type_1 map_example.type_1 : property_service set ;
-;; allow map_example.type_1 map_example.type_1 : zygote { specifyids specifyrlimits specifyinvokewith specifyseinfo } ;
-
-;; allow map_example.type_2 map_example.type_2 : binder { impersonate call set_context_mgr transfer } ;
-;; allow map_example.type_2 map_example.type_2 : zygote { specifyids specifyrlimits specifycapabilities specifyinvokewith } ;
-
-;; allow map_example.type_3 map_example.type_3 : binder { impersonate call set_context_mgr } ;
-;; allow map_example.type_3 map_example.type_3 : zygote { specifyrlimits specifycapabilities specifyinvokewith specifyseinfo } ;]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="permissionx">
-         <title>permissionx</title>
-         <para>Defines a named extended permission, which can be used in the <literal><link linkend="allowx">allowx</link></literal>, <literal><link linkend="auditallowx">auditallowx</link></literal>, <literal><link linkend="dontauditx">dontauditx</link></literal>, and <literal><link linkend="neverallowx">neverallowx</link></literal> statements.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(permissionx permissionx_id (kind class_id (permission ... | expr ...)))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="permissionx">permissionx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="permissionx">permissionx</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>kind</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword specifying how to interpret the extended permission values. Must be one of:</para>
-                     <para>
-                        <informaltable frame="all">
-                           <tgroup cols="2">
-                              <colspec colwidth=".5 in"/>
-                              <colspec colwidth="*"/>
-                              <thead>
-                              <row>
-                                 <entry align="center">
-                                    <para><emphasis role="bold">kind</emphasis></para>
-                                 </entry>
-                                 <entry align="center">
-                                    <para><emphasis role="bold">description</emphasis></para>
-                                 </entry>
-                              </row>
-                              </thead>
-                              <tbody>
-                              <row>
-                                 <entry>
-                                    <para>ioctl</para>
-                                 </entry>
-                                 <entry>
-                                    <para>Permissions define a whitelist of ioctl values. Permission values must range from <literal>0x0000</literal> to <literal>0xFFFF</literal>, inclusive.</para>
-                                 </entry>
-                              </row>
-                           </tbody></tgroup>
-                        </informaltable>
-                     </para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>permission</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more numeric values, specified in decimal, or hexadecimal if prefixed with 0x, or octal if prefixed with 0. Values are interpreted based on the value of <literal>kind</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>An expression, with valid operators and syntax:</para>
-                     <simpara><literal>    (range (permission ...) (permission ...))</literal></simpara>
-                     <simpara><literal>    (and (permission ...) (permission ...))</literal></simpara>
-                     <simpara><literal>    (or  (permission ...) (permission ...))</literal></simpara>
-                     <simpara><literal>    (xor (permission ...) (permission ...))</literal></simpara>
-                     <simpara><literal>    (not (permission ...))</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <programlisting><![CDATA[
-(permissionx ioctl_1 (ioctl tcp_socket (0x2000 0x3000 0x4000)))
-(permissionx ioctl_2 (ioctl tcp_socket (range 0x6000 0x60FF)))
-(permissionx ioctl_3 (ioctl tcp_socket (and (range 0x8000 0x90FF) (not (range 0x8100 0x82FF)))))
-]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
new file mode 100644
index 0000000..f30d2cc
--- /dev/null
+++ b/secilc/docs/cil_conditional_statements.md
@@ -0,0 +1,222 @@
+Conditional Statements
+======================
+
+boolean
+-------
+
+Declares a run time boolean as true or false in the current namespace. The [`booleanif`](cil_conditional_statements.md#booleanif) statement contains the CIL code that will be in the binary policy file.
+
+**Statement definition:**
+
+    (boolean boolean_id true|false)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>boolean</code></p></td>
+<td align="left"><p>The <code>boolean</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>boolean_id</code></p></td>
+<td align="left"><p>The <code>boolean</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>true | false</code></p></td>
+<td align="left"><p>The initial state of the boolean. This can be changed at run time using <strong><code>setsebool</code></strong><code>(8)</code> and its status queried using <strong><code>getsebool</code></strong><code>(8)</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`booleanif`](cil_conditional_statements.md#booleanif) statement for an example.
+
+booleanif
+---------
+
+Contains the run time conditional statements that are instantiated in the binary policy according to the computed boolean identifier(s) state.
+
+[`call`](cil_call_macro_statements.md#call) statements are allowed within a [`booleanif`](cil_conditional_statements.md#booleanif), however the contents of the resulting macro must be limited to those of the [`booleanif`](cil_conditional_statements.md#booleanif) statement (i.e. [`allow`](cil_access_vector_rules.md#allow), [`auditallow`](cil_access_vector_rules.md#auditallow), [`dontaudit`](cil_access_vector_rules.md#dontaudit), [`typemember`](cil_type_statements.md#typemember), [`typetransition`](cil_type_statements.md#typetransition), [`typechange`](cil_type_statements.md#typechange) and the compile time [`tunableif`](cil_conditional_statements.md#tunableif) statement)).
+
+**Statement definition:**
+
+    (booleanif boolean_id | expr ...)
+        (true
+            cil_statements
+            ...)
+        (false
+            cil_statements
+            ...)
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>booleanif</code></p></td>
+<td align="left"><p>The <code>booleanif</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>boolean_id</code></p></td>
+<td align="left"><p>Either a single <code>boolean</code> identifier or one or more <code>expr</code>'s.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (boolean_id boolean_id))</code></p>
+<p><code>    (or  (boolean_id boolean_id))</code></p>
+<p><code>    (xor (boolean_id boolean_id))</code></p>
+<p><code>    (eq  (boolean_id boolean_id))</code></p>
+<p><code>    (neq (boolean_id boolean_id))</code></p>
+<p><code>    (not (boolean_id))</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>true</code></p></td>
+<td align="left"><p>An optional set of CIL statements that will be instantiated when the <code>boolean</code> is evaluated as <code>true</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>false</code></p></td>
+<td align="left"><p>An optional set of CIL statements that will be instantiated when the <code>boolean</code> is evaluated as <code>false</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+The second example also shows the kernel policy language equivalent:
+
+    (boolean disableAudio false)
+
+    (booleanif disableAudio
+        (false
+            (allow process mediaserver.audio_device (chr_file_set (rw_file_perms)))
+        )
+    )
+
+    (boolean disableAudioCapture false)
+
+    ;;; if(!disableAudio && !disableAudioCapture) {
+    (booleanif (and (not disableAudio) (not disableAudioCapture))
+        (true
+            (allow process mediaserver.audio_capture_device (chr_file_set (rw_file_perms)))
+        )
+    )
+
+tunable
+-------
+
+Tunables are similar to booleans, however they are used to manage areas of CIL statements that may or may not be in the final CIL policy that will be compiled (whereas booleans are embedded in the binary policy and can be enabled or disabled during run-time).
+
+Note that tunables can be treated as booleans by the CIL compiler command line parameter `-P` or `--preserve-tunables` flags.
+
+**Statement definition:**
+
+    (tunable tunable_id true|false)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>tunable</code></p></td>
+<td align="left"><p>The <code>tunable</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>tunable_id</code></p></td>
+<td align="left"><p>The <code>tunable</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>true | false</code></p></td>
+<td align="left"><p>The initial state of the <code>tunable</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`tunableif`](cil_conditional_statements.md#tunableif) statement for an example.
+
+tunableif
+---------
+
+Compile time conditional statement that may or may not add CIL statements to be compiled.
+
+**Statement definition:**
+
+    (tunableif tunable_id | expr ...)
+        (true
+            cil_statements
+            ...)
+        (false
+            cil_statements
+            ...)
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>tunableif</code></p></td>
+<td align="left"><p>The <code>tunableif</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>tunable_id</code></p></td>
+<td align="left"><p>Either a single <code>tunable</code> identifier or one or more <code>expr</code>'s.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (tunable_id tunable_id))</code></p>
+<p><code>    (or  (tunable_id tunable_id))</code></p>
+<p><code>    (xor (tunable_id tunable_id))</code></p>
+<p><code>    (eq  (tunable_id tunable_id))</code></p>
+<p><code>    (neq (tunable_id tunable_id))</code></p>
+<p><code>    (not (tunable_id))</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>true</code></p></td>
+<td align="left"><p>An optional set of CIL statements that will be instantiated when the <code>tunable</code> is evaluated as <code>true</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>false</code></p></td>
+<td align="left"><p>An optional set of CIL statements that will be instantiated when the <code>tunable</code> is evaluated as <code>false</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will not add the range transition rule to the binary policy:
+
+    (tunable range_trans_rule false)
+
+    (block init
+        (class process (process))
+        (type process)
+
+        (tunableif range_trans_rule
+            (true
+                (rangetransition process sshd.exec process low_high)
+            )
+        ) ; End tunableif
+    ) ; End block
diff --git a/secilc/docs/cil_conditional_statements.xml b/secilc/docs/cil_conditional_statements.xml
deleted file mode 100644
index aa30afa..0000000
--- a/secilc/docs/cil_conditional_statements.xml
+++ /dev/null
@@ -1,269 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- conditional_statements.xml -->
-
-   <sect1>
-      <title>Conditional Statements</title>
-      <sect2 id="boolean">
-         <title>boolean</title>
-         <para>Declares a run time boolean as true or false in the current namespace. The <literal><link linkend="booleanif">booleanif</link></literal> statement contains the CIL code that will be in the binary policy file.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(boolean boolean_id true|false)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="boolean">boolean</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="boolean">boolean</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>boolean_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="boolean">boolean</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>true | false</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The initial state of the boolean. This can be changed at run time using <emphasis role="bold"><literal>setsebool</literal></emphasis><literal>(8)</literal> and its status queried using  <emphasis role="bold"><literal>getsebool</literal></emphasis><literal>(8)</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="booleanif">booleanif</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="booleanif">
-         <title>booleanif</title>
-         <para>Contains the run time conditional statements that are instantiated in the binary policy according to the computed boolean identifier(s) state.</para>
-         <para><literal><link linkend="call">call</link></literal> statements are allowed within a <literal><link linkend="booleanif">booleanif</link></literal>, however the contents of the resulting macro must be limited to those of the <literal><link linkend="booleanif">booleanif</link></literal> statement (i.e. <literal><link linkend="allow">allow</link></literal>, <literal><link linkend="auditallow">auditallow</link></literal>, <literal><link linkend="dontaudit">dontaudit</link></literal>, <literal><link linkend="typemember">typemember</link></literal>, <literal><link linkend="typetransition">typetransition</link></literal>, <literal><link linkend="typechange">typechange</link></literal> and the compile time <literal><link linkend="tunableif">tunableif</link></literal> statement)).</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(booleanif boolean_id | expr ...)
-    (true
-        cil_statements
-        ...)
-    (false
-        cil_statements
-        ...)
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="booleanif">booleanif</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="booleanif">booleanif</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>boolean_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Either a single <literal><link linkend="boolean">boolean</link></literal> identifier or one or more <literal>expr</literal>'s.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (boolean_id boolean_id))</literal></simpara>
-                     <simpara><literal>    (or  (boolean_id boolean_id))</literal></simpara>
-                     <simpara><literal>    (xor (boolean_id boolean_id))</literal></simpara>
-                     <simpara><literal>    (eq  (boolean_id boolean_id))</literal></simpara>
-                     <simpara><literal>    (neq (boolean_id boolean_id))</literal></simpara>
-                     <simpara><literal>    (not (boolean_id))</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>true</literal></para>
-                  </entry>
-                  <entry>
-                     <para>An optional set of CIL statements that will be instantiated when the <literal><link linkend="boolean">boolean</link></literal> is evaluated as <literal>true</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>false</literal></para>
-                  </entry>
-                  <entry>
-                     <para>An optional set of CIL statements that will be instantiated when the <literal><link linkend="boolean">boolean</link></literal> is evaluated as <literal>false</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>The second example also shows the kernel policy language equivalent:</para>
-         <programlisting><![CDATA[
-(boolean disableAudio false)
-
-(booleanif disableAudio
-    (false
-        (allow process mediaserver.audio_device (chr_file_set (rw_file_perms)))
-    )
-)]]>
-         </programlisting>
-         <programlisting><![CDATA[
-(boolean disableAudioCapture false)
-
-;;; if(!disableAudio && !disableAudioCapture) {
-(booleanif (and (not disableAudio) (not disableAudioCapture))
-    (true
-        (allow process mediaserver.audio_capture_device (chr_file_set (rw_file_perms)))
-    )
-)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="tunable">
-         <title>tunable</title>
-         <para>Tunables are similar to booleans, however they are used to manage areas of CIL statements that may or may not be in the final CIL policy that will be compiled (whereas booleans are embedded in the binary policy and can be enabled or disabled during run-time).</para>
-         <para>Note that tunables can be treated as booleans by the CIL compiler command line parameter <literal>-P</literal> or <literal>--preserve-tunables</literal> flags.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(tunable tunable_id true|false)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>tunable</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="tunable">tunable</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>tunable_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="tunable">tunable</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>true | false</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The initial state of the <literal><link linkend="tunable">tunable</link></literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="tunableif">tunableif</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="tunableif">
-         <title>tunableif</title>
-         <para>Compile time conditional statement that may or may not add CIL statements to be compiled.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(tunableif tunable_id | expr ...)
-    (true
-        cil_statements
-        ...)
-    (false
-        cil_statements
-        ...)
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>tunableif</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="tunableif">tunableif</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>tunable_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Either a single <literal><link linkend="tunable">tunable</link></literal> identifier or one or more <literal>expr</literal>'s.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (tunable_id tunable_id))</literal></simpara>
-                     <simpara><literal>    (or  (tunable_id tunable_id))</literal></simpara>
-                     <simpara><literal>    (xor (tunable_id tunable_id))</literal></simpara>
-                     <simpara><literal>    (eq  (tunable_id tunable_id))</literal></simpara>
-                     <simpara><literal>    (neq (tunable_id tunable_id))</literal></simpara>
-                     <simpara><literal>    (not (tunable_id))</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>true</literal></para>
-                  </entry>
-                  <entry>
-                     <para>An optional set of CIL statements that will be instantiated when the <literal><link linkend="tunable">tunable</link></literal> is evaluated as <literal>true</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>false</literal></para>
-                  </entry>
-                  <entry>
-                     <para>An optional set of CIL statements that will be instantiated when the <literal><link linkend="tunable">tunable</link></literal> is evaluated as <literal>false</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will not add the range transition rule to the binary policy:</para>
-         <programlisting><![CDATA[
-(tunable range_trans_rule false)
-
-(block init
-    (class process (process))
-    (type process)
-
-    (tunableif range_trans_rule
-        (true
-            (rangetransition process sshd.exec process low_high)
-        )
-    ) ; End tunableif
-) ; End block]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_constraint_statements.md b/secilc/docs/cil_constraint_statements.md
new file mode 100644
index 0000000..df03ae6
--- /dev/null
+++ b/secilc/docs/cil_constraint_statements.md
@@ -0,0 +1,313 @@
+Constraint Statements
+=====================
+
+constrain
+---------
+
+Enable constraints to be placed on the specified permissions of the object class based on the source and target security context components.
+
+**Statement definition:**
+
+    (constrain classpermissionset_id ... expression | expr ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>constrain</code></p></td>
+<td align="left"><p>The <code>constrain</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expression</code></p></td>
+<td align="left"><p>There must be one constraint <code>expression</code> or one or more <code>expr</code>'s. The expression consists of an operator and two operands as follows:</p>
+<p><code>    (op u1 u2)</code></p>
+<p><code>    (role_op r1 r2)</code></p>
+<p><code>    (op t1 t2)</code></p>
+<p><code>    (op u1 user_id)</code></p>
+<p><code>    (op u2 user_id)</code></p>
+<p><code>    (op r1 role_id)</code></p>
+<p><code>    (op r2 role_id)</code></p>
+<p><code>    (op t1 type_id)</code></p>
+<p><code>    (op t2 type_id)</code></p>
+<p>where:</p>
+<p><code>  u1, r1, t1 = Source context: user, role or type</code></p>
+<p><code>  u2, r2, t2 = Target context: user, role or type</code></p>
+<p>and:</p>
+<p><code>  op      : eq neq</code></p>
+<p><code>  role_op : eq neq dom domby incomp</code></p>
+<p><code>  user_id : A single user or userattribute identifier.</code></p>
+<p><code>  role_id : A single role or roleattribute identifier.</code></p>
+<p><code>  type_id : A single type, typealias or typeattribute identifier.</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and expression expression)</code></p>
+<p><code>    (or  expression expression)</code></p>
+<p><code>    (not expression)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+Two constrain statements are shown with their equivalent kernel policy language statements:
+
+    ;; constrain { file } { write }
+    ;;    (( t1 == unconfined.process  ) and ( t2 == unconfined.object  ) or ( r1 eq r2 ));
+    (constrain (file (write))
+        (or
+            (and
+                (eq t1 unconfined.process)
+                (eq t2 unconfined.object)
+            )
+            (eq r1 r2)
+        )
+    )
+
+    ;; constrain { file } { read }
+    ;;    (not( t1 == unconfined.process  ) and ( t2 == unconfined.object  ) or ( r1 eq r2 ));
+    (constrain (file (read))
+        (not
+            (or
+                (and
+                    (eq t1 unconfined.process)
+                    (eq t2 unconfined.object)
+                )
+                (eq r1 r2)
+            )
+        )
+    )
+
+validatetrans
+-------------
+
+The [`validatetrans`](cil_constraint_statements.md#validatetrans) statement is only used for `file` related object classes where it is used to control the ability to change the objects security context based on old, new and the current process security context.
+
+**Statement definition:**
+
+    (validatetrans class_id expression | expr ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>validatetrans</code></p></td>
+<td align="left"><p>The <code>validatetrans</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expression</code></p></td>
+<td align="left"><p>There must be one constraint <code>expression</code> or one or more <code>expr</code>'s. The expression consists of an operator and two operands as follows:</p>
+<p><code>    (op u1 u2)</code></p>
+<p><code>    (role_op r1 r2)</code></p>
+<p><code>    (op t1 t2)</code></p>
+<p><code>    (op u1 user_id)</code></p>
+<p><code>    (op u2 user_id)</code></p>
+<p><code>    (op u3 user_id)</code></p>
+<p><code>    (op r1 role_id)</code></p>
+<p><code>    (op r2 role_id)</code></p>
+<p><code>    (op r3 role_id)</code></p>
+<p><code>    (op t1 type_id)</code></p>
+<p><code>    (op t2 type_id)</code></p>
+<p><code>    (op t3 type_id)</code></p>
+<p>where:</p>
+<p><code>  u1, r1, t1 = Old context: user, role or type</code></p>
+<p><code>  u2, r2, t2 = New context: user, role or type</code></p>
+<p><code>  u3, r3, t3 = Process context: user, role or type</code></p>
+<p>and:</p>
+<p><code>  op      : eq neq</code></p>
+<p><code>  role_op : eq neq dom domby incomp</code></p>
+<p><code>  user_id : A single user or userattribute identifier.</code></p>
+<p><code>  role_id : A single role or roleattribute identifier.</code></p>
+<p><code>  type_id : A single type, typealias or typeattribute identifier.</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and expression expression)</code></p>
+<p><code>    (or  expression expression)</code></p>
+<p><code>    (not expression)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+A validate transition statement with the equivalent kernel policy language statement:
+
+    ; validatetrans { file } ( t1 == unconfined.process  );
+
+    (validatetrans file (eq t1 unconfined.process))
+
+mlsconstrain
+------------
+
+Enable MLS constraints to be placed on the specified permissions of the object class based on the source and target security context components.
+
+**Statement definition:**
+
+    (mlsconstrain classpermissionset_id ... expression | expr ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>mlsconstrain</code></p></td>
+<td align="left"><p>The <code>mlsconstrain</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>classpermissionset_id</code></p></td>
+<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expression</code></p></td>
+<td align="left"><p>There must be one constraint <code>expression</code> or one or more <code>expr</code>'s. The expression consists of an operator and two operands as follows:</p>
+<p><code>    (op u1 u2)</code></p>
+<p><code>    (mls_role_op r1 r2)</code></p>
+<p><code>    (op t1 t2)</code></p>
+<p><code>    (mls_role_op l1 l2)</code></p>
+<p><code>    (mls_role_op l1 h2)</code></p>
+<p><code>    (mls_role_op h1 l2)</code></p>
+<p><code>    (mls_role_op h1 h2)</code></p>
+<p><code>    (mls_role_op l1 h1)</code></p>
+<p><code>    (mls_role_op l2 h2)</code></p>
+<p><code>    (op u1 user_id)</code></p>
+<p><code>    (op u2 user_id)</code></p>
+<p><code>    (op r1 role_id)</code></p>
+<p><code>    (op r2 role_id)</code></p>
+<p><code>    (op t1 type_id)</code></p>
+<p><code>    (op t2 type_id)</code></p>
+<p>where:</p>
+<p><code>  u1, r1, t1, l1, h1 = Source context: user, role, type, low level or high level</code></p>
+<p><code>  u2, r2, t2, l2, h2 = Target context: user, role, type, low level or high level</code></p>
+<p>and:</p>
+<p><code>  op          : eq neq</code></p>
+<p><code>  mls_role_op : eq neq dom domby incomp</code></p>
+<p><code>  user_id     : A single user or userattribute identifier.</code></p>
+<p><code>  role_id     : A single role or roleattribute identifier.</code></p>
+<p><code>  type_id     : A single type, typealias or typeattribute identifier.</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and expression expression)</code></p>
+<p><code>    (or  expression expression)</code></p>
+<p><code>    (not expression)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An MLS constrain statement with the equivalent kernel policy language statement:
+
+    ;; mlsconstrain { file } { open }
+    ;;     (( l1 eq l2 ) and ( u1 == u2 ) or ( r1 != r2 ));
+
+    (mlsconstrain (file (open))
+        (or
+            (and
+                (eq l1 l2)
+                (eq u1 u2)
+            )
+            (neq r1 r2)
+        )
+    )
+
+mlsvalidatetrans
+----------------
+
+The [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans) statement is only used for `file` related object classes where it is used to control the ability to change the objects security context based on old, new and the current process security context.
+
+**Statement definition:**
+
+    (mlsvalidatetrans class_id expression | expr ...)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>mlsvalidatetrans</code></p></td>
+<td align="left"><p>The <code>mlsvalidatetrans</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expression</code></p></td>
+<td align="left"><p>There must be one constraint <code>expression</code> or one or more <code>expr</code>'s. The expression consists of an operator and two operands as follows:</p>
+<p><code>    (op u1 u2)</code></p>
+<p><code>    (mls_role_op r1 r2)</code></p>
+<p><code>    (op t1 t2)</code></p>
+<p><code>    (mls_role_op l1 l2)</code></p>
+<p><code>    (mls_role_op l1 h2)</code></p>
+<p><code>    (mls_role_op h1 l2)</code></p>
+<p><code>    (mls_role_op h1 h2)</code></p>
+<p><code>    (mls_role_op l1 h1)</code></p>
+<p><code>    (mls_role_op l2 h2)</code></p>
+<p><code>    (op u1 user_id)</code></p>
+<p><code>    (op u2 user_id)</code></p>
+<p><code>    (op u3 user_id)</code></p>
+<p><code>    (op r1 role_id)</code></p>
+<p><code>    (op r2 role_id)</code></p>
+<p><code>    (op r3 role_id)</code></p>
+<p><code>    (op t1 type_id)</code></p>
+<p><code>    (op t2 type_id)</code></p>
+<p><code>    (op t3 type_id)</code></p>
+<p>where:</p>
+<p><code>  u1, r1, t1, l1, h1 = Source context: user, role, type, low level or high level</code></p>
+<p><code>  u2, r2, t2, l2, h2 = Target context: user, role, type, low level or high level</code></p>
+<p><code>  u3, r3, t3         = Process context: user, role or type</code></p>
+<p>and:</p>
+<p><code>  op          : eq neq</code></p>
+<p><code>  mls_role_op : eq neq dom domby incomp</code></p>
+<p><code>  user_id     : A single user or userattribute identifier.</code></p>
+<p><code>  role_id     : A single role or roleattribute identifier.</code></p>
+<p><code>  type_id     : A single type, typealias or typeattribute identifier.</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and expression expression)</code></p>
+<p><code>    (or  expression expression)</code></p>
+<p><code>    (not expression)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An MLS validate transition statement with the equivalent kernel policy language statement:
+
+    ;; mlsvalidatetrans { file } ( l1 domby h2 );
+
+    (mlsvalidatetrans file (domby l1 h2))
diff --git a/secilc/docs/cil_constraint_statements.xml b/secilc/docs/cil_constraint_statements.xml
deleted file mode 100644
index 8ef1642..0000000
--- a/secilc/docs/cil_constraint_statements.xml
+++ /dev/null
@@ -1,363 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- constraint_statements.xml -->
-
-   <sect1>
-      <title>Constraint Statements</title>
-      <sect2 id="constrain">
-         <title>constrain</title>
-         <para>Enable constraints to be placed on the specified permissions of the object class based on the source and target security context components.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(constrain classpermissionset_id ... expression | expr ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>constrain</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>constrain</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expression</literal></para>
-                  </entry>
-                  <entry>
-                     <para>There must be one constraint <literal>expression</literal> or one or more <literal>expr</literal>'s. The expression consists of an operator and two operands as follows:</para>
-                        <simpara><literal>    (op u1 u2)</literal></simpara>
-                        <simpara><literal>    (role_op r1 r2)</literal></simpara>
-                        <simpara><literal>    (op t1 t2)</literal></simpara>
-                        <simpara><literal>    (op u1 user_id)</literal></simpara>
-                        <simpara><literal>    (op u2 user_id)</literal></simpara>
-                        <simpara><literal>    (op r1 role_id)</literal></simpara>
-                        <simpara><literal>    (op r2 role_id)</literal></simpara>
-                        <simpara><literal>    (op t1 type_id)</literal></simpara>
-                        <simpara><literal>    (op t2 type_id)</literal></simpara>
-                     <simpara>where:</simpara>
-                        <simpara><literal>  u1, r1, t1 = Source context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                        <simpara><literal>  u2, r2, t2 = Target context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                     <simpara>and:</simpara>
-                        <simpara><literal>  op      : eq neq</literal></simpara>
-                        <simpara><literal>  role_op : eq neq dom domby incomp</literal></simpara>
-                        <simpara><literal>  user_id : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  role_id : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  type_id : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and expression expression)</literal></simpara>
-                     <simpara><literal>    (or  expression expression)</literal></simpara>
-                     <simpara><literal>    (not expression)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>Two constrain statements are shown with their equivalent kernel policy language statements:</para>
-         <programlisting><![CDATA[
-;; constrain { file } { write }
-;;    (( t1 == unconfined.process  ) and ( t2 == unconfined.object  ) or ( r1 eq r2 ));
-(constrain (file (write))
-    (or
-        (and
-            (eq t1 unconfined.process)
-            (eq t2 unconfined.object)
-        )
-        (eq r1 r2)
-    )
-)
-
-;; constrain { file } { read }
-;;    (not( t1 == unconfined.process  ) and ( t2 == unconfined.object  ) or ( r1 eq r2 ));
-(constrain (file (read))
-    (not
-        (or
-            (and
-                (eq t1 unconfined.process)
-                (eq t2 unconfined.object)
-            )
-            (eq r1 r2)
-        )
-    )
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="validatetrans">
-         <title>validatetrans</title>
-         <para>The <literal>validatetrans</literal> statement is only used for <literal>file</literal> related object classes where it is used to control the ability to change the objects security context based on old, new and the current process security context.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(validatetrans class_id expression | expr ...)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>validatetrans</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>validatetrans</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expression</literal></para>
-                  </entry>
-                  <entry>
-                     <para>There must be one constraint <literal>expression</literal> or one or more <literal>expr</literal>'s. The expression consists of an operator and two operands as follows:</para>
-                        <simpara><literal>    (op u1 u2)</literal></simpara>
-                        <simpara><literal>    (role_op r1 r2)</literal></simpara>
-                        <simpara><literal>    (op t1 t2)</literal></simpara>
-                        <simpara><literal>    (op u1 user_id)</literal></simpara>
-                        <simpara><literal>    (op u2 user_id)</literal></simpara>
-                        <simpara><literal>    (op u3 user_id)</literal></simpara>
-                        <simpara><literal>    (op r1 role_id)</literal></simpara>
-                        <simpara><literal>    (op r2 role_id)</literal></simpara>
-                        <simpara><literal>    (op r3 role_id)</literal></simpara>
-                        <simpara><literal>    (op t1 type_id)</literal></simpara>
-                        <simpara><literal>    (op t2 type_id)</literal></simpara>
-                        <simpara><literal>    (op t3 type_id)</literal></simpara>
-                     <simpara>where:</simpara>
-                        <simpara><literal>  u1, r1, t1 = Old context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                        <simpara><literal>  u2, r2, t2 = New context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                        <simpara><literal>  u3, r3, t3 = Process context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                     <simpara>and:</simpara>
-                        <simpara><literal>  op      : eq neq</literal></simpara>
-                        <simpara><literal>  role_op : eq neq dom domby incomp</literal></simpara>
-                        <simpara><literal>  user_id : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  role_id : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  type_id : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and expression expression)</literal></simpara>
-                     <simpara><literal>    (or  expression expression)</literal></simpara>
-                     <simpara><literal>    (not expression)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>A validate transition statement with the equivalent kernel policy language statement:</para>
-         <programlisting><![CDATA[
-; validatetrans { file } ( t1 == unconfined.process  );
-
-(validatetrans file (eq t1 unconfined.process))]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="mlsconstrain">
-         <title>mlsconstrain</title>
-         <para>Enable MLS constraints to be placed on the specified permissions of the object class based on the source and target security context components.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(mlsconstrain classpermissionset_id ... expression | expr ...)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>mlsconstrain</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>mlsconstrain</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>classpermissionset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single named or anonymous <literal><link linkend="classpermissionset">classpermissionset</link></literal> or a single set of <literal><link linkend="classmap">classmap</link></literal>/<literal><link linkend="classmapping">classmapping</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expression</literal></para>
-                  </entry>
-                  <entry>
-                     <para>There must be one constraint <literal>expression</literal> or one or more <literal>expr</literal>'s. The expression consists of an operator and two operands as follows:</para>
-                        <simpara><literal>    (op u1 u2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op r1 r2)</literal></simpara>
-                        <simpara><literal>    (op t1 t2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 l2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 h2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op h1 l2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op h1 h2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 h1)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l2 h2)</literal></simpara>
-                        <simpara><literal>    (op u1 user_id)</literal></simpara>
-                        <simpara><literal>    (op u2 user_id)</literal></simpara>
-                        <simpara><literal>    (op r1 role_id)</literal></simpara>
-                        <simpara><literal>    (op r2 role_id)</literal></simpara>
-                        <simpara><literal>    (op t1 type_id)</literal></simpara>
-                        <simpara><literal>    (op t2 type_id)</literal></simpara>
-                     <simpara>where:</simpara>
-                        <simpara><literal>  u1, r1, t1, l1, h1 = Source context: <link linkend="user">user</link>, <link linkend="role">role</link>, <link linkend="type">type</link>, <link linkend="level">low level</link> or <link linkend="level">high level</link></literal></simpara>
-                        <simpara><literal>  u2, r2, t2, l2, h2 = Target context: <link linkend="user">user</link>, <link linkend="role">role</link>, <link linkend="type">type</link>, <link linkend="level">low level</link> or <link linkend="level">high level</link></literal></simpara>
-                     <simpara>and:</simpara>
-                        <simpara><literal>  op          : eq neq</literal></simpara>
-                        <simpara><literal>  mls_role_op : eq neq dom domby incomp</literal></simpara>
-                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  role_id     : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  type_id     : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and expression expression)</literal></simpara>
-                     <simpara><literal>    (or  expression expression)</literal></simpara>
-                     <simpara><literal>    (not expression)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An MLS constrain statement with the equivalent kernel policy language statement:</para>
-         <programlisting><![CDATA[
-;; mlsconstrain { file } { open }
-;;     (( l1 eq l2 ) and ( u1 == u2 ) or ( r1 != r2 ));
-
-(mlsconstrain (file (open))
-    (or
-        (and
-            (eq l1 l2)
-            (eq u1 u2)
-        )
-        (neq r1 r2)
-    )
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="mlsvalidatetrans">
-         <title>mlsvalidatetrans</title>
-         <para>The <literal>mlsvalidatetrans</literal> statement is only used for <literal>file</literal> related object classes where it is used to control the ability to change the objects security context based on old, new and the current process security context.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(mlsvalidatetrans class_id expression | expr ...)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>mlsvalidatetrans</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>mlsvalidatetrans</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expression</literal></para>
-                  </entry>
-                  <entry>
-                     <para>There must be one constraint <literal>expression</literal> or one or more <literal>expr</literal>'s. The expression consists of an operator and two operands as follows:</para>
-                        <simpara><literal>    (op u1 u2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op r1 r2)</literal></simpara>
-                        <simpara><literal>    (op t1 t2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 l2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 h2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op h1 l2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op h1 h2)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l1 h1)</literal></simpara>
-                        <simpara><literal>    (mls_role_op l2 h2)</literal></simpara>
-                        <simpara><literal>    (op u1 user_id)</literal></simpara>
-                        <simpara><literal>    (op u2 user_id)</literal></simpara>
-                        <simpara><literal>    (op u3 user_id)</literal></simpara>
-                        <simpara><literal>    (op r1 role_id)</literal></simpara>
-                        <simpara><literal>    (op r2 role_id)</literal></simpara>
-                        <simpara><literal>    (op r3 role_id)</literal></simpara>
-                        <simpara><literal>    (op t1 type_id)</literal></simpara>
-                        <simpara><literal>    (op t2 type_id)</literal></simpara>
-                        <simpara><literal>    (op t3 type_id)</literal></simpara>
-                     <simpara>where:</simpara>
-                        <simpara><literal>  u1, r1, t1, l1, h1 = Source context: <link linkend="user">user</link>, <link linkend="role">role</link>, <link linkend="type">type</link>, <link linkend="level">low level</link> or <link linkend="level">high level</link></literal></simpara>
-                        <simpara><literal>  u2, r2, t2, l2, h2 = Target context: <link linkend="user">user</link>, <link linkend="role">role</link>, <link linkend="type">type</link>, <link linkend="level">low level</link> or <link linkend="level">high level</link></literal></simpara>
-                        <simpara><literal>  u3, r3, t3         = Process context: <link linkend="user">user</link>, <link linkend="role">role</link> or <link linkend="type">type</link></literal></simpara>
-                     <simpara>and:</simpara>
-                        <simpara><literal>  op          : eq neq</literal></simpara>
-                        <simpara><literal>  mls_role_op : eq neq dom domby incomp</literal></simpara>
-                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  role_id     : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
-                        <simpara><literal>  type_id     : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and expression expression)</literal></simpara>
-                     <simpara><literal>    (or  expression expression)</literal></simpara>
-                     <simpara><literal>    (not expression)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An MLS validate transition statement with the equivalent kernel policy language statement:</para>
-         <programlisting><![CDATA[
-;; mlsvalidatetrans { file } ( l1 domby h2 );
-
-(mlsvalidatetrans file (domby l1 h2))]]>
-      </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
new file mode 100644
index 0000000..a570cb2
--- /dev/null
+++ b/secilc/docs/cil_container_statements.md
@@ -0,0 +1,296 @@
+Container Statements
+====================
+
+block
+-----
+
+Start a new namespace where any CIL statement is valid.
+
+**Statement definition:**
+
+    (block block_id
+        cil_statement
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>block</code></p></td>
+<td align="left"><p>The <code>block</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>block_id</code></p></td>
+<td align="left"><p>The namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`blockinherit`](cil_container_statements.md#blockinherit) statement for an example.
+
+blockabstract
+-------------
+
+Declares the namespace as a 'template' and does not generate code until instantiated by another namespace that has a [`blockinherit`](cil_container_statements.md#blockinherit) statement.
+
+**Statement definition:**
+
+    (block block_id
+        (blockabstract template_id)
+        cil_statement
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>block</code></p></td>
+<td align="left"><p>The <code>block</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>block_id</code></p></td>
+<td align="left"><p>The namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>blockabstract</code></p></td>
+<td align="left"><p>The <code>blockabstract</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>template_id</code></p></td>
+<td align="left"><p>The abstract namespace identifier. This must match the <code>block_id</code> entry.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements forming the abstract block.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`blockinherit`](cil_container_statements.md#blockinherit) statement for an example.
+
+blockinherit
+------------
+
+Used to add common policy rules to the current namespace via a template that has been defined with the [`blockabstract`](cil_container_statements.md#blockabstract) statement. All [`blockinherit`](cil_container_statements.md#blockinherit) statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.
+
+**Statement definition:**
+
+    (block block_id
+        (blockinherit template_id)
+        cil_statement
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>block</code></p></td>
+<td align="left"><p>The <code>block</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>block_id</code></p></td>
+<td align="left"><p>The namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>blockinherit</code></p></td>
+<td align="left"><p>The <code>blockinherit</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>template_id</code></p></td>
+<td align="left"><p>The inherited namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example contains a template `client_server` that is instantiated in two blocks (`netserver_app` and `netclient_app`):
+
+    ; This is the template block:
+    (block client_server
+        (blockabstract client_server)
+
+        ; Log file labeling
+        (type log_file)
+        (typeattributeset file_type (log_file))
+        (typeattributeset data_file_type (log_file))
+        (allow process log_file (dir (write search create setattr add_name)))
+        (allow process log_file (file (create open append getattr setattr)))
+        (roletype object_r log_file)
+        (context log_file_context (u object_r log_file low_low))
+
+        ; Process labeling
+        (type process)
+        (typeattributeset domain (process))
+        (call app_domain (process))
+        (call net_domain (process))
+    )
+
+    ; This is a policy block that will inherit the abstract block above:
+    (block netclient_app
+        ; Add common policy rules to namespace:
+        (blockinherit client_server)
+        ; Label the log files
+        (filecon "/data/data/com.se4android.netclient/.*" file log_file_context)
+    )
+
+    ; This is another policy block that will inherit the abstract block above:
+    (block netserver_app
+       ; Add common policy rules to namespace:
+        (blockinherit client_server)
+
+        ; Label the log files
+        (filecon "/data/data/com.se4android.netserver/.*" file log_file_context)
+    )
+
+    ; This is an example of how blockinherits resolve inherits before copying
+    (block a
+        (type one))
+
+    (block b
+        ; Notice that block a is declared here as well
+        (block a
+            (type two)))
+
+    ; This will first copy the contents of block b, which results in type b.a.two being copied.
+    ; Next, the contents of block a will be copied which will result in type a.one.
+    (block ab
+        (blockinherit b)
+        (blockinherit a))
+
+optional
+--------
+
+Declare an [`optional`](cil_container_statements.md#optional) namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy. [`tunableif`](cil_conditional_statements.md#tunableif) and [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in optional containers. The same restrictions apply to CIL policy statements within [`optional`](cil_container_statements.md#optional)'s that apply to kernel policy statements, i.e. only the policy statements shown in the following table are valid:
+
+|                     |                |                    |                    |
+| ------------------- | -------------- | ------------------ | ------------------ |
+| [`allow`](cil_access_vector_rules.md#allow)             | [`allowx`](cil_access_vector_rules.md#allowx)       | [`auditallow`](cil_access_vector_rules.md#auditallow)       | [`auditallowx`](cil_access_vector_rules.md#auditallowx)      |
+| [`booleanif`](cil_conditional_statements.md#booleanif)         | [`dontaudit`](cil_access_vector_rules.md#dontaudit)    | [`dontauditx`](cil_access_vector_rules.md#dontauditx)       | [`typepermissive`](cil_type_statements.md#typepermissive)   |
+| [`rangetransition`](cil_mls_labeling_statements.md#rangetransition)   | [`role`](cil_role_statements.md#role)         | [`roleallow`](cil_role_statements.md#roleallow)        | [`roleattribute`](cil_role_statements.md#roleattribute)    |
+| [`roletransition`](cil_role_statements.md#roletransition)    | [`type`](cil_type_statements.md#type)         | [`typealias`](cil_type_statements.md#typealias)        | [`typeattribute`](cil_type_statements.md#typeattribute)    |
+| [`typechange`](cil_type_statements.md#typechange)        | [`typemember`](cil_type_statements.md#typemember)   | [`typetransition`](cil_type_statements.md#typetransition)   |                    |
+
+**Statement definition:**
+
+    (optional optional_id
+        cil_statement
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>optional</code></p></td>
+<td align="left"><p>The <code>optional</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>optional_id</code></p></td>
+<td align="left"><p>The <code>optional</code> namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will instantiate the optional block `ext_gateway.move_file` into policy providing all optional CIL statements can be resolved:
+
+    (block ext_gateway
+        ......
+        (optional move_file
+            (typetransition process msg_filter.move_file.in_queue file msg_filter.move_file.in_file)
+            (allow process msg_filter.move_file.in_queue (dir (read getattr write search add_name)))
+            (allow process msg_filter.move_file.in_file (file (write create getattr)))
+            (allow msg_filter.move_file.in_file unconfined.object (filesystem (associate)))
+            (typetransition msg_filter.int_gateway.process msg_filter.move_file.out_queue file
+                msg_filter.move_file.out_file)
+            (allow msg_filter.int_gateway.process msg_filter.move_file.out_queue (dir (read write search)))
+            (allow msg_filter.int_gateway.process msg_filter.move_file.out_file (file (read getattr unlink)))
+        ) ; End optional block
+
+        .....
+    ) ; End block
+
+in
+--
+
+Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statement is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) or [`tunableif`](cil_conditional_statements.md#tunableif) statements.
+
+**Statement definition:**
+
+    (in container_id
+        cil_statement
+        ...
+    )
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>in</code></p></td>
+<td align="left"><p>The <code>in</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>container_id</code></p></td>
+<td align="left"><p>A valid <code>block</code>, <code>optional</code> or <code>macro</code> namespace identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>cil_statement</code></p></td>
+<td align="left"><p>Zero or more valid CIL statements.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This will add rules to the container named `system_server`:
+
+    (in system_server
+        (dontaudit process secmark_demo.dns_packet (packet (send recv)))
+        (allow process secmark_demo.dns_packet (packet (send recv)))
+    )
diff --git a/secilc/docs/cil_container_statements.xml b/secilc/docs/cil_container_statements.xml
deleted file mode 100644
index 3e3d2f6..0000000
--- a/secilc/docs/cil_container_statements.xml
+++ /dev/null
@@ -1,424 +0,0 @@
-
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- container_statements.xml -->
-
-   <sect1>
-      <title>Container Statements</title>
-      <sect2 id="block">
-         <title>block</title>
-         <para>Start a new namespace where any CIL statement is valid.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(block block_id
-    cil_statement
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>block</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="block">block</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>block_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="blockinherit">blockinherit</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="blockabstract">
-         <title>blockabstract</title>
-         <para>Declares the namespace as a 'template' and does not generate code until instantiated by another namespace that has a <literal><link linkend="blockinherit">blockinherit</link></literal> statement.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(block block_id
-    (blockabstract template_id)
-    cil_statement
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>block</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="block">block</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>block_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>blockabstract</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="blockabstract">blockabstract</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>template_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The abstract namespace identifier. This must match the <literal><link linkend="block">block_id</link></literal> entry.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements forming the abstract block.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="blockinherit">blockinherit</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="blockinherit">
-         <title>blockinherit</title>
-         <para>Used to add common policy rules to the current namespace via a template that has been defined with the <literal><link linkend="blockabstract">blockabstract</link></literal> statement. All <literal><link linkend="blockinherit">blockinherit</link></literal> statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(block block_id
-    (blockinherit template_id)
-    cil_statement
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>block</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="block">block</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>block_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>blockinherit</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="blockinherit">blockinherit</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>template_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The inherited namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example contains a template <literal>client_server</literal> that is instantiated in two blocks (<literal>netserver_app</literal> and <literal>netclient_app</literal>):</para>
-         <programlisting><![CDATA[
-; This is the template block:
-(block client_server
-    (blockabstract client_server)
-
-    ; Log file labeling
-    (type log_file)
-    (typeattributeset file_type (log_file))
-    (typeattributeset data_file_type (log_file))
-    (allow process log_file (dir (write search create setattr add_name)))
-    (allow process log_file (file (create open append getattr setattr)))
-    (roletype object_r log_file)
-    (context log_file_context (u object_r log_file low_low))
-
-    ; Process labeling
-    (type process)
-    (typeattributeset domain (process))
-    (call app_domain (process))
-    (call net_domain (process))
-)
-
-; This is a policy block that will inherit the abstract block above:
-(block netclient_app
-    ; Add common policy rules to namespace:
-    (blockinherit client_server)
-    ; Label the log files
-    (filecon "/data/data/com.se4android.netclient/.*" file log_file_context)
-)
-
-; This is another policy block that will inherit the abstract block above:
-(block netserver_app
-   ; Add common policy rules to namespace:
-    (blockinherit client_server)
-
-    ; Label the log files
-    (filecon "/data/data/com.se4android.netserver/.*" file log_file_context)
-)
-
-; This is an example of how blockinherits resolve inherits before copying
-(block a
-    (type one))
-
-(block b
-    ; Notice that block a is declared here as well
-    (block a
-        (type two)))
-
-; This will first copy the contents of block b, which results in type b.a.two being copied.
-; Next, the contents of block a will be copied which will result in type a.one.
-(block ab
-    (blockinherit b)
-    (blockinherit a))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="optional">
-         <title>optional</title>
-         <para>Declare an <literal><link linkend="optional">optional</link></literal> namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy. <literal><link linkend="tunableif">tunableif</link></literal> and <literal><link linkend="macro">macro</link></literal> statements are not allowed in optional containers. The same restrictions apply to CIL policy statements within <literal><link linkend="optional">optional</link></literal>'s that apply to kernel policy statements, i.e. only the policy statements shown in the following table are valid:</para>
-
-         <informaltable frame="all">
-            <tgroup cols="4">
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="allow">allow</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="allowx">allowx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="auditallow">auditallow</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="auditallowx">auditallowx</link></literal></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="booleanif">booleanif</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="dontaudit">dontaudit</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="dontauditx">dontauditx</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="typepermissive">typepermissive</link></literal></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="rangetransition">rangetransition</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="role">role</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="roleallow">roleallow</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="roleattribute">roleattribute</link></literal></para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="roletransition">roletransition</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="type">type</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="typealias">typealias</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="typeattribute">typeattribute</link></literal></para>
-                  </entry>
-              </row>
-              <row>
-                  <entry>
-                     <para><literal><link linkend="typechange">typechange</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="typemember">typemember</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para><literal><link linkend="typetransition">typetransition</link></literal></para>
-                  </entry>
-               </row>
-               </tbody>
-            </tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(optional optional_id
-    cil_statement
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>optional</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="optional">optional</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>optional_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="optional">optional</link></literal> namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will instantiate the optional block <literal>ext_gateway.move_file</literal> into policy providing all optional CIL statements can be resolved:</para>
-         <programlisting><![CDATA[
-(block ext_gateway
-    ......
-    (optional move_file
-        (typetransition process msg_filter.move_file.in_queue file msg_filter.move_file.in_file)
-        (allow process msg_filter.move_file.in_queue (dir (read getattr write search add_name)))
-        (allow process msg_filter.move_file.in_file (file (write create getattr)))
-        (allow msg_filter.move_file.in_file unconfined.object (filesystem (associate)))
-        (typetransition msg_filter.int_gateway.process msg_filter.move_file.out_queue file
-            msg_filter.move_file.out_file)
-        (allow msg_filter.int_gateway.process msg_filter.move_file.out_queue (dir (read write search)))
-        (allow msg_filter.int_gateway.process msg_filter.move_file.out_file (file (read getattr unlink)))
-    ) ; End optional block
-
-    .....
-) ; End block]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="in">
-         <title>in</title>
-         <para>Allows the insertion of CIL statements into a named container (<literal><link linkend="block">block</link></literal>, <literal><link linkend="optional">optional</link></literal> or <literal><link linkend="macro">macro</link></literal>). This statement is not allowed in <literal><link linkend="booleanif">booleanif</link></literal> or <literal><link linkend="tunableif">tunableif</link></literal> statements.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[
-(in container_id
-    cil_statement
-    ...
-)]]>
-         </programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>in</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>in</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>container_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A valid <literal><link linkend="block">block</link></literal>, <literal><link linkend="optional">optional</link></literal> or <literal><link linkend="macro">macro</link></literal> namespace identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>cil_statement</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more valid CIL statements.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will add rules to the container named <literal>system_server</literal>:</para>
-         <programlisting><![CDATA[
-(in system_server
-    (dontaudit process secmark_demo.dns_packet (packet (send recv)))
-    (allow process secmark_demo.dns_packet (packet (send recv)))
-)]]>
-         </programlisting>
-      </sect2>
-   </sect1>
-
diff --git a/secilc/docs/cil_context_statement.md b/secilc/docs/cil_context_statement.md
new file mode 100644
index 0000000..57ad3c6
--- /dev/null
+++ b/secilc/docs/cil_context_statement.md
@@ -0,0 +1,77 @@
+Context Statement
+=================
+
+Contexts are formed using previously declared parameters and may be named or anonymous where:
+
+-   Named - The context is declared with a context identifer that is used as a reference.
+
+-   Anonymous - They are defined within the CIL labeling statement using user, role etc. identifiers.
+
+Each type is shown in the examples.
+
+context
+-------
+
+Declare an SELinux security context identifier for labeling. The range (or current and clearance levels) MUST be defined whether the policy is MLS/MCS enabled or not.
+
+**Statement definition:**
+
+    (context context_id (user_id role_id type_id levelrange_id)))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>context</code></p></td>
+<td align="left"><p>The <code>context</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>The <code>context</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A single previously declared <code>user</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>levelrange_id</code></p></td>
+<td align="left"><p>A single previously declared <code>levelrange</code> identifier. This entry may also be defined by anonymous or named <code>level</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code> or <code>categoryset</code> as discussed in the <a href="#mls_labeling_statements">Multi-Level Security Labeling Statements</a> section and shown in the examples.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example uses a named context definition:
+
+    (context runas_exec_context (u object_r exec low_low))
+
+    (filecon "/system/bin/run-as" file runas_exec_context)
+
+to resolve/build a `file_contexts` entry of (assuming MLS enabled policy):
+
+    /system/bin/run-as  -- u:object_r:runas.exec:s0-s0
+
+This example uses an anonymous context where the previously declared `user role type levelrange` identifiers are used to specifiy two [`portcon`](cil_network_labeling_statements.md#portcon) statements:
+
+    (portcon udp 1024 (test.user object_r test.process ((s0) (s1))))
+    (portcon tcp 1024 (test.user object_r test.process (system_low system_high)))
+
+This example uses an anonymous context for the first and named context for the second in a [`netifcon`](cil_network_labeling_statements.md#netifcon) statement:
+
+    (context netif_context (test.user object_r test.process ((s0 (c0)) (s1 (c0)))))
+
+    (netifcon eth04 (test.user object_r test.process ((s0 (c0)) (s1 (c0)))) netif_context)
diff --git a/secilc/docs/cil_context_statement.xml b/secilc/docs/cil_context_statement.xml
deleted file mode 100644
index 648278a..0000000
--- a/secilc/docs/cil_context_statement.xml
+++ /dev/null
@@ -1,100 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- context_statement.xml -->
-
-   <sect1>
-      <title>Context Statement</title>
-      <para>Contexts are formed using previously declared parameters and may be named or anonymous where:</para>
-      <itemizedlist mark="none">
-         <listitem><para>Named - The context is declared with a context identifer that is used as a reference.</para></listitem>
-         <listitem><para>Anonymous - They are defined within the CIL labeling statement using user, role etc. identifiers.</para></listitem>
-      </itemizedlist>
-      <para>Each type is shown in the examples.</para>
-
-      <sect2 id="context">
-         <title>context</title>
-         <para>Declare an SELinux security context identifier for labeling. The range (or current and clearance levels) MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(context context_id (user_id role_id type_id levelrange_id)))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal><link linkend="context">context</link></literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="context">context</link></literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="context">context</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>levelrange_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="levelrange">levelrange</link></literal> identifier. This entry may also be defined by anonymous or named <literal><link linkend="level">level</link></literal>, <literal><link linkend="sensitivity">sensitivity</link></literal>, <literal><link linkend="sensitivityalias">sensitivityalias</link></literal>, <literal><link linkend="category">category</link></literal>, <literal><link linkend="categoryalias">categoryalias</link></literal> or <literal><link linkend="categoryset">categoryset</link></literal> as discussed in the <link linkend="mls_labeling_statements">Multi-Level Security Labeling Statements</link> section and shown in the examples.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example uses a named context definition:</para>
-            <programlisting><![CDATA[
-(context runas_exec_context (u object_r exec low_low))
-
-(filecon "/system/bin/run-as" file runas_exec_context)]]>
-            </programlisting>
-         <simpara>to resolve/build a <literal>file_contexts</literal> entry of (assuming MLS enabled policy):</simpara>
-            <programlisting><![CDATA[/system/bin/run-as  -- u:object_r:runas.exec:s0-s0]]></programlisting>
-
-         <para>This example uses an anonymous context where the previously declared <literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal> identifiers are used to specifiy two <literal><link linkend="portcon">portcon</link></literal> statements:</para>
-            <programlisting><![CDATA[
-(portcon udp 1024 (test.user object_r test.process ((s0) (s1))))
-(portcon tcp 1024 (test.user object_r test.process (system_low system_high)))]]>
-            </programlisting>
-
-         <para>This example uses an anonymous context for the first and named context for the second in a <literal><link linkend="netifcon">netifcon</link></literal> statement:</para>
-            <programlisting><![CDATA[
-(context netif_context (test.user object_r test.process ((s0 (c0)) (s1 (c0)))))
-
-(netifcon eth04 (test.user object_r test.process ((s0 (c0)) (s1 (c0)))) netif_context)]]>
-            </programlisting>
-
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_default_object_statements.md b/secilc/docs/cil_default_object_statements.md
new file mode 100644
index 0000000..73d84d6
--- /dev/null
+++ b/secilc/docs/cil_default_object_statements.md
@@ -0,0 +1,183 @@
+Default Object Statements
+=========================
+
+These rules allow a default user, role, type and/or range to be used when computing a context for a new object. These require policy version 27 or 28 with kernels 3.5 or greater.
+
+defaultuser
+-----------
+
+Allows the default user to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27.
+
+**Statement definition:**
+
+    (defaultuser class_id default)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>defaultuser</code></p></td>
+<td align="left"><p>The <code>defaultuser</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier, or a list of previously declared <code>class</code> or <code>classmap</code> identifiers enclosed within parentheses.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>default</code></p></td>
+<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+When creating new `binder`, `property_service`, `zygote` or `memprotect` objects the [`user`](cil_user_statements.md#user) component of the new security context will be taken from the `source` context:
+
+    (class binder (impersonate call set_context_mgr transfer receive))
+    (class property_service (set))
+    (class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
+    (class memprotect (mmap_zero))
+
+    (classmap android_classes (android))
+    (classmapping android_classes android (binder (all)))
+    (classmapping android_classes android (property_service (set)))
+    (classmapping android_classes android (zygote (not (specifycapabilities))))
+
+    (defaultuser (android_classes memprotect) source)
+
+    ; Will produce the following in the binary policy file:
+    ;; default_user binder source;
+    ;; default_user zygote source;
+    ;; default_user property_service source;
+    ;; default_user memprotect source;
+
+defaultrole
+-----------
+
+Allows the default role to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27.
+
+    (defaultrole class_id default)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>defaultrole</code></p></td>
+<td align="left"><p>The <code>defaultrole</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier, or a list of previously declared <code>class</code> or <code>classmap</code> identifiers enclosed within parentheses.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>default</code></p></td>
+<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+When creating new `binder`, `property_service` or `zygote` objects the [`role`](cil_role_statements.md#role) component of the new security context will be taken from the `target` context:
+
+    (class binder (impersonate call set_context_mgr transfer receive))
+    (class property_service (set))
+    (class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
+
+    (defaultrole (binder property_service zygote) target)
+
+    ; Will produce the following in the binary policy file:
+    ;; default_role binder target;
+    ;; default_role zygote target;
+    ;; default_role property_service target;
+
+defaulttype
+-----------
+
+Allows the default type to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 28.
+
+**Statement definition:**
+
+    (defaulttype class_id default)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>defaulttype</code></p></td>
+<td align="left"><p>The <code>defaulttype</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier, or a list of previously declared <code>class</code> or <code>classmap</code> identifiers enclosed within parentheses.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>default</code></p></td>
+<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+When creating a new `socket` object, the [`type`](cil_type_statements.md#type) component of the new security context will be taken from the `source` context:
+
+    (defaulttype socket source)
+
+defaultrange
+------------
+
+Allows the default level or range to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27.
+
+**Statement definition:**
+
+    (defaultrange class_id default range)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>defaultrange</code></p></td>
+<td align="left"><p>The <code>defaultrange</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier, or a list of previously declared <code>class</code> or <code>classmap</code> identifiers enclosed within parentheses.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>default</code></p></td>
+<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>range</code></p></td>
+<td align="left"><p>A keyword of either <code>low</code>, <code>high</code> or <code>low-high</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+When creating a new `file` object, the appropriate `range` component of the new security context will be taken from the `target` context:
+
+    (defaultrange file target low_high)
diff --git a/secilc/docs/cil_default_object_statements.xml b/secilc/docs/cil_default_object_statements.xml
deleted file mode 100644
index c654435..0000000
--- a/secilc/docs/cil_default_object_statements.xml
+++ /dev/null
@@ -1,215 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- default_object_statements.xml -->
-
-   <sect1>
-      <title>Default Object Statements</title>
-      <para>These rules allow a default user, role, type and/or range to be used when computing a context for a new object. These require policy version 27 or 28 with kernels 3.5 or greater.</para>
-      <sect2 id="defaultuser">
-         <title>defaultuser</title>
-         <para>Allows the default user to be taken from the source or target context when computing a new context for the object <literal><link linkend="class">class</link></literal> identifier. Requires policy version 27.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(defaultuser class_id default)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>defaultuser</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>defaultuser</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier, or a list of previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifiers enclosed within parentheses.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>default</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>source</literal> or <literal>target</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>When creating new <literal>binder</literal>, <literal>property_service</literal>, <literal>zygote</literal> or <literal>memprotect</literal> objects the <literal><link linkend="user">user</link></literal> component of the new security context will be taken from the <literal>source</literal> context:</para>
-         <programlisting><![CDATA[
-(class binder (impersonate call set_context_mgr transfer receive))
-(class property_service (set))
-(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
-(class memprotect (mmap_zero))
-
-(classmap android_classes (android))
-(classmapping android_classes android (binder (all)))
-(classmapping android_classes android (property_service (set)))
-(classmapping android_classes android (zygote (not (specifycapabilities))))
-
-(defaultuser (android_classes memprotect) source)
-
-; Will produce the following in the binary policy file:
-;; default_user binder source;
-;; default_user zygote source;
-;; default_user property_service source;
-;; default_user memprotect source;]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="defaultrole">
-         <title>defaultrole</title>
-         <para>Allows the default role to be taken from the source or target context when computing a new context for the object <literal><link linkend="class">class</link></literal> identifier. Requires policy version 27.</para>
-         <programlisting><![CDATA[(defaultrole class_id default)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>defaultrole</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>defaultrole</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier, or a list of previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifiers enclosed within parentheses.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>default</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>source</literal> or <literal>target</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>When creating new <literal>binder</literal>, <literal>property_service</literal> or <literal>zygote</literal> objects the <literal><link linkend="role">role</link></literal> component of the new security context will be taken from the <literal>target</literal> context:</para>
-         <programlisting><![CDATA[
-(class binder (impersonate call set_context_mgr transfer receive))
-(class property_service (set))
-(class zygote (specifyids specifyrlimits specifycapabilities specifyinvokewith specifyseinfo))
-
-(defaultrole (binder property_service zygote) target)
-
-; Will produce the following in the binary policy file:
-;; default_role binder target;
-;; default_role zygote target;
-;; default_role property_service target;]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="defaulttype">
-         <title>defaulttype</title>
-         <para>Allows the default type to be taken from the source or target context when computing a new context for the object <literal><link linkend="class">class</link></literal> identifier. Requires policy version 28.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(defaulttype class_id default)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>defaulttype</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>defaulttype</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier, or a list of previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifiers enclosed within parentheses.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>default</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>source</literal> or <literal>target</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>When creating a new <literal>socket</literal> object, the <literal><link linkend="type">type</link></literal> component of the new security context will be taken from the <literal>source</literal> context:</para>
-         <programlisting><![CDATA[(defaulttype socket source)]]></programlisting>
-      </sect2>
-
-      <sect2 id="defaultrange">
-         <title>defaultrange</title>
-         <para>Allows the default level or range to be taken from the source or target context when computing a new context for the object <literal><link linkend="class">class</link></literal> identifier. Requires policy version 27.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(defaultrange class_id default range)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>defaultrange</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>defaultrange</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier, or a list of previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifiers enclosed within parentheses.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>default</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>source</literal> or <literal>target</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>range</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>low</literal>, <literal>high</literal> or <literal>low-high</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>When creating a new <literal>file</literal> object, the appropriate <literal><link linkend="levelrange">range</link></literal> component of the new security context will be taken from the <literal>target</literal> context:</para>
-         <programlisting><![CDATA[(defaultrange file target low_high)]]></programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/cil_file_labeling_statements.md
new file mode 100644
index 0000000..3175ebc
--- /dev/null
+++ b/secilc/docs/cil_file_labeling_statements.md
@@ -0,0 +1,228 @@
+File Labeling Statements
+========================
+
+filecon
+-------
+
+Define entries for labeling files. The compiler will produce these entries in a file called **`file_contexts`**`(5)` by default in the `cwd`. The compiler option `[-f|--filecontext <filename>]` may be used to specify a different path or file name.
+
+**Statement definition:**
+
+    (filecon "path" file_type context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>filecon</code></p></td>
+<td align="left"><p>The <code>filecon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>path</code></p></td>
+<td align="left"><p>A string representing the file path that may be in the form of a regular expression. The string must be enclosed within double quotes (e.g. <code>&quot;/this/is/a/path(/.*)?&quot;</code>)</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>file_type</code></p></td>
+<td align="left"><p>A single keyword representing a file type in the <code>file_contexts</code> file as follows:</p>
+<table>
+<colgroup>
+<col width="44%" />
+<col width="55%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><strong>keyword</strong></p></td>
+<td align="left"><p><strong>file_contexts entry</strong></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>file</code></p></td>
+<td align="left"><p><code>--</code></p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>dir</code></p></td>
+<td align="left"><p><code>-d</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>char</code></p></td>
+<td align="left"><p><code>-c</code></p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>block</code></p></td>
+<td align="left"><p><code>-b</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>socket</code></p></td>
+<td align="left"><p><code>-s</code></p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>pipe</code></p></td>
+<td align="left"><p><code>-p</code></p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>symlink</code></p></td>
+<td align="left"><p><code>-l</code></p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>any</code></p></td>
+<td align="left"><p>no entry</p></td>
+</tr>
+</tbody>
+</table></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>The security context to be allocated to the file, which may be:</p>
+<ul>
+<li><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></li>
+<li><p>An empty context list represented by <code>()</code> can be used to indicate that matching files should not be re-labeled. This will be interpreted as <code>&lt;&lt;none&gt;&gt;</code> within the <strong><code>file_contexts</code></strong><code>(5)</code> file.</p></li>
+</ul></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples use one named, one anonymous and one empty context definition:
+
+    (context runas_exec_context (u object_r exec low_low))
+
+    (filecon "/system/bin/run-as" file runas_exec_context)
+    (filecon "/dev/socket/wpa_wlan[0-9]" any u:object_r:wpa.socket:s0-s0)
+    (filecon "/data/local/mine" dir ())
+
+to resolve/build `file_contexts` entries of (assuming MLS enabled policy):
+
+    /system/bin/run-as  -- u:object_r:runas.exec:s0
+    /dev/socket/wpa_wlan[0-9]   u:object_r:wpa.socket:s0
+    /data/local/mine -d <<none>>
+
+fsuse
+-----
+
+Label filesystems that support SELinux security contexts.
+
+**Statement definition:**
+
+    (fsuse fstype fsname context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>fsuse</code></p></td>
+<td align="left"><p>The <code>fsuse</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>fstype</code></p></td>
+<td align="left"><p>A single keyword representing the type of filesystem as follows:</p>
+<ul>
+<li><p><code>task</code> - For pseudo filesystems supporting task related services such as pipes and sockets.</p></li>
+<li><p><code>trans</code> - For pseudo filesystems such as pseudo terminals and temporary objects.</p></li>
+<li><p><code>xattr</code> - Filesystems supporting the extended attribute <code>security.selinux</code>. The labeling is persistent for filesystems that support extended attributes.</p></li>
+</ul></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>fsname</code></p></td>
+<td align="left"><p>Name of the supported filesystem (e.g. <code>ext4</code> or <code>pipefs</code>).</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>The security context to be allocated to the network interface.</p>
+<p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+The [context](#context) identifiers are declared in the `file` namespace and the [`fsuse`](cil_file_labeling_statements.md#fsuse) statements in the global namespace:
+
+    (block file
+        (type labeledfs)
+        (roletype object_r labeledfs)
+        (context labeledfs_context (u object_r labeledfs low_low))
+
+        (type pipefs)
+        (roletype object_r pipefs)
+        (context pipefs_context (u object_r pipefs low_low))
+        ...
+    )
+
+    (fsuse xattr ex4 file.labeledfs_context)
+    (fsuse xattr btrfs file.labeledfs_context)
+
+    (fsuse task pipefs file.pipefs_context)
+    (fsuse task sockfs file.sockfs_context)
+
+    (fsuse trans devpts file.devpts_context)
+    (fsuse trans tmpfs file.tmpfs_context)
+
+genfscon
+--------
+
+Used to allocate a security context to filesystems that cannot support any of the [`fsuse`](cil_file_labeling_statements.md#fsuse) file labeling options. Generally a filesystem would have a single default security context assigned by [`genfscon`](cil_file_labeling_statements.md#genfscon) from the root `(/)` that would then be inherited by all files and directories on that filesystem. The exception to this is the `/proc` filesystem, where directories can be labeled with a specific security context (as shown in the examples).
+
+**Statement definition:**
+
+    (genfscon fsname path context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>genfscon</code></p></td>
+<td align="left"><p>The <code>genfscon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>fsname</code></p></td>
+<td align="left"><p>Name of the supported filesystem (e.g. <code>rootfs</code> or <code>proc</code>).</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>path</code></p></td>
+<td align="left"><p>If <code>fsname</code> is <code>proc</code>, then the partial path (see examples). For all other types this must be ‘<code>/</code>’.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+The [context](#context) identifiers are declared in the `file` namespace and the [`genfscon`](cil_file_labeling_statements.md#genfscon) statements are then inserted using the [`in`](cil_container_statements.md#in) container statement:
+
+    (file
+        (type rootfs)
+        (roletype object_r rootfs)
+        (context rootfs_context (u object_r rootfs low_low))
+
+        (type proc)
+        (roletype object_r proc)
+        (context rootfs_context (u object_r proc low_low))
+        ...
+    )
+
+    (in file
+        (genfscon rootfs / rootfs_context)
+        ; proc labeling can be further refined (longest matching prefix).
+        (genfscon proc / proc_context)
+        (genfscon proc /net/xt_qtaguid/ctrl qtaguid_proc_context)
+        (genfscon proc /sysrq-trigger sysrq_proc_context)
+        (genfscon selinuxfs / selinuxfs_context)
+    )
diff --git a/secilc/docs/cil_file_labeling_statements.xml b/secilc/docs/cil_file_labeling_statements.xml
deleted file mode 100644
index 8cfdb24..0000000
--- a/secilc/docs/cil_file_labeling_statements.xml
+++ /dev/null
@@ -1,302 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- file_labeling_statements.xml -->
-
-   <sect1>
-      <title>File Labeling Statements</title>
-      <sect2 id="filecon">
-         <title>filecon</title>
-         <para>Define entries for labeling files. The compiler will produce these entries in a file called <emphasis role="bold"><literal>file_contexts</literal></emphasis><literal>(5)</literal> by default in the <literal>cwd</literal>. The compiler option <literal>[-f|--filecontext &lt;filename>]</literal> may be used to specify a different path or file name.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(filecon "path" file_type context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>filecon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>filecon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>path</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A string representing the file path that may be in the form of a regular expression. The string must be enclosed within double quotes (e.g. <literal>"/this/is/a/path(/.*)?"</literal>)</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>file_type</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single keyword representing a file type in the <literal>file_contexts</literal> file as follows:</para>
-                     <para>
-                        <informaltable frame="all">
-                           <tgroup cols="2">
-                           <colspec colwidth="1 in"/>
-                           <colspec colwidth="1.25 in"/>
-                              <tbody>
-                              <row>
-                                 <entry>
-                                    <para><emphasis role="bold">keyword</emphasis></para>
-                                 </entry>
-                                 <entry>
-                                    <para><emphasis role="bold">file_contexts entry</emphasis></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>file</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>--</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>dir</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-d</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>char</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-c</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>block</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-b</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>socket</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-s</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>pipe</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-p</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>symlink</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para><literal>-l</literal></para>
-                                 </entry>
-                              </row>
-                              <row>
-                                 <entry>
-                                    <para><literal>any</literal></para>
-                                 </entry>
-                                 <entry>
-                                    <para>no entry</para>
-                                 </entry>
-                              </row>
-                           </tbody></tgroup>
-                        </informaltable>
-                     </para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The security context to be allocated to the file, which may be:</para>
-                     <itemizedlist>
-                        <listitem><para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para></listitem>
-                        <listitem><para>An empty context list represented by <literal>()</literal> can be used to indicate that matching files should not be re-labeled. This will be interpreted as <literal>&lt;&lt;none>></literal> within the <emphasis role="bold"><literal>file_contexts</literal></emphasis><literal>(5)</literal> file.</para></listitem>
-                     </itemizedlist>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples use one named, one anonymous and one empty context definition:</para>
-            <programlisting><![CDATA[
-(context runas_exec_context (u object_r exec low_low))
-
-(filecon "/system/bin/run-as" file runas_exec_context)
-(filecon "/dev/socket/wpa_wlan[0-9]" any u:object_r:wpa.socket:s0-s0)
-(filecon "/data/local/mine" dir ())]]>
-            </programlisting>
-         <simpara>to resolve/build <literal>file_contexts</literal> entries of (assuming MLS enabled policy):</simpara>
-            <programlisting><![CDATA[
-/system/bin/run-as  -- u:object_r:runas.exec:s0
-/dev/socket/wpa_wlan[0-9]   u:object_r:wpa.socket:s0
-/data/local/mine -d <<none>>]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="fsuse">
-         <title>fsuse</title>
-         <para>Label filesystems that support SELinux security contexts.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(fsuse fstype fsname context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>fsuse</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>fsuse</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>fstype</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single keyword representing the type of filesystem as follows:</para>
-                     <itemizedlist mark="none">
-                        <listitem><simpara><literal>task</literal> - For pseudo filesystems supporting task related services such as pipes and sockets.</simpara></listitem>
-                        <listitem><simpara><literal>trans</literal> - For pseudo filesystems such as pseudo terminals and temporary objects.</simpara></listitem>
-                        <listitem><simpara><literal>xattr</literal> - Filesystems supporting the extended attribute <literal>security.selinux</literal>. The labeling is persistent for filesystems that support extended attributes.</simpara></listitem>
-                     </itemizedlist>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>fsname</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Name of the supported filesystem (e.g. <literal>ext4</literal> or <literal>pipefs</literal>).</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The security context to be allocated to the network interface.</para>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>The <link linkend="context">context</link> identifiers are declared in the <literal>file</literal> namespace and the <literal>fsuse</literal> statements in the global namespace:</para>
-         <programlisting><![CDATA[
-(block file
-    (type labeledfs)
-    (roletype object_r labeledfs)
-    (context labeledfs_context (u object_r labeledfs low_low))
-
-    (type pipefs)
-    (roletype object_r pipefs)
-    (context pipefs_context (u object_r pipefs low_low))
-    ...
-)
-
-(fsuse xattr ex4 file.labeledfs_context)
-(fsuse xattr btrfs file.labeledfs_context)
-
-(fsuse task pipefs file.pipefs_context)
-(fsuse task sockfs file.sockfs_context)
-
-(fsuse trans devpts file.devpts_context)
-(fsuse trans tmpfs file.tmpfs_context)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="genfscon">
-         <title>genfscon</title>
-         <para>Used to allocate a security context to filesystems that cannot support any of the <literal><link linkend="fsuse">fsuse</link></literal> file labeling options. Generally a filesystem would have a single default security context assigned by <literal>genfscon</literal> from the root <literal>(/)</literal> that would then be inherited by all files and directories on that filesystem. The exception to this is the <literal>/proc</literal> filesystem, where directories can be labeled with a specific security context (as shown in the examples).</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(genfscon fsname path context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>genfscon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>genfscon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>fsname</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Name of the supported filesystem (e.g. <literal>rootfs</literal> or <literal>proc</literal>).</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>path</literal></para>
-                  </entry>
-                  <entry>
-                     <para>If <literal>fsname</literal> is <literal>proc</literal>, then the partial path (see examples). For all other types this must be ‘<literal>/</literal>’.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>The <link linkend="context">context</link> identifiers are declared in the <literal>file</literal> namespace and the <literal>genfscon</literal> statements are then inserted using the <literal><link linkend="in">in</link></literal> container statement:</para>
-         <programlisting><![CDATA[
-(file
-    (type rootfs)
-    (roletype object_r rootfs)
-    (context rootfs_context (u object_r rootfs low_low))
-
-    (type proc)
-    (roletype object_r proc)
-    (context rootfs_context (u object_r proc low_low))
-    ...
-)
-
-(in file
-    (genfscon rootfs / rootfs_context)
-    ; proc labeling can be further refined (longest matching prefix).
-    (genfscon proc / proc_context)
-    (genfscon proc /net/xt_qtaguid/ctrl qtaguid_proc_context)
-    (genfscon proc /sysrq-trigger sysrq_proc_context)
-    (genfscon selinuxfs / selinuxfs_context)
-)]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_introduction.md b/secilc/docs/cil_introduction.md
new file mode 100644
index 0000000..c9f52e6
--- /dev/null
+++ b/secilc/docs/cil_introduction.md
@@ -0,0 +1,59 @@
+Introduction
+===================
+
+The SELinux Common Intermediate Language (CIL) is designed to be a language that sits between one or more high level policy languages (such as the current module language) and the low-level kernel policy representation. The intermediate language provides several benefits:
+
+* Enables the creation of multiple high-level languages that can both consume and produce language constructs with more features than the raw kernel policy (e.g., interfaces). Pushing these features into CIL enables cross-language interaction.
+
+* Eases the creation of high-level languages, encouraging the creation of more domain specific policy languages (e.g., CDS Framework, Lobster, and Shrimp).
+
+* Provides a semantically rich representation suitable for policy analysis, allowing the analysis of the output of multiple high-level languages using a single analysis tool set without losing needed high-level information.
+
+Design Philosophy
+------------------
+
+CIL is guided by several key decision principles:
+
+* Be an intermediate language - provide rich semantics needed for cross-language interaction but not for convenience. If a feature can be handled by a high-level language without sacrificing cross-language interoperability leave the feature out. Less is more.
+
+* Facilitate easy parsing and generation - provide clear, simple syntax that is easy to parse and to generate by high-level compilers, analysis tools, and policy generation tools. Machine processing should be prioritized higher than human processing when there is a conflict as humans should be reading and writing high-level languages instead.
+
+* Fully and faithfully represent the kernel language - the ultimate goal of CIL is the generation of the policy that will be enforced by the kernel. That policy must be full represented so that all of the policy can be represented in CIL. And that representation should not adorn, obscure, or otherwise hide the kernel policy. CIL should allow additional high-level language semantics but should not abstract away the essence of the kernel enforcement. Be C (portable assembler) not a pure functional language (which hides how the processor actually works).
+
+* The only good binary file format is a non-existent one - CIL is meant for a source policy oriented world, so assume and leverage that. The only binary policy format moving forward should be for communication with the kernel.
+
+* Enable backwards compatibility but don't be a slave to it - source, but not binary, compatibility with existing policies is a goal but not an absolute requirement. Where necessary it is assumed that manual or automated policy conversion will be required to move to enable the freedom needed to make CIL compelling.
+
+* Don't fix what isn't broken - CIL is an opportunity to make bold changes to SELinux policy, but there is no reason to re-think core concepts that are working well. All changes to existing language constructs need a clear and compelling reason. One key aspect of the current policy to retain is it's order-independent, declarative style.
+
+* No more M4 - the pervasive use of M4 and pre-processing in general has eased policy creation, but the side-effects cause many additional problems. CIL should eliminate the need for a pre-processor.
+
+* Shift more compilation work to happen per-module instead of globally - the current toolchain performance is often driven by the size of the policy and the need to have the entire policy loaded to do much of the processing. If possible, make it possible to do more compilation of one module at a time to increase performance. At the very least, clearly identify and manage language constructs that cause work on the global policy.
+
+Goals and Primary Features
+-----
+
+CIL is meant to enable several features that are currently difficult or impossible to achieve with the current policy languages and tools. While generality is always a goal, with CIL there are also several well-known and clear motivating language needs.
+
+* Policy customization without breaking updates - one of the challenges in SELinux is allowing a system builder or administrator to change the access allowed on a system - including removing unwanted access - while not preventing the application of future policy updates from the vendor. It is desirable, therefore, to allow an administrator to make changes to vendor policy without necessitating the direct modification of the shipped policy files. This is most clearly seen when an administrator wants to remove access allowed by a vendor policy that is not already controlled by a policy boolean.
+
+* Interfaces as a first class feature - interfaces, and macros before them, have been a successful mechanism to allow policy authors to define related sets of access and easily grant that access to new types. However, this success has been hampered by interfaces existing solely as pre-processor constructs, preventing compilers, management tools, and analysis tools from understanding them. This has many unintended consequences, including the need to recompile all modules to include the changes to an interface. Interfaces or some similar construct should become first class language features.
+
+* Rich policy relationships - templates, interfaces, and attributes are currently the only means of quickly creating new types or sets of types with commonly needed access. However, use of these constructs require up-front design by the policy developer, limiting their use by system builders and administrators to rapidly create or mold existing policy. Policy authors need language features to create new types or modules based upon existing ones with large or small changes. These features should allow ad-hoc creation of new policy modules or types related to existing types.
+
+* Support for policy management - semanage and related tools currently make policy modifications using private data stores and code to directly manipulate the binary policy format before it is generated for loading into the kernel. These tools should be able to generate and consume CIL to accomplish the same goals.
+
+Design Overview
+------------------
+
+The design is aims to provide simplicity in several ways:
+
+1. The syntax is extremely regular and easy to parse being based upon s-expressions.
+2. The statements are reduced to the bare minimum. There is one - and only one - way to express any given syntax.
+3. The statements are unambiguous and overlap in very well defined ways. This is in contrast to the current language where a statement, such as a role statement, might be a declaration, a further definition, or both depending on context.
+
+The language, like the existing policy languages, is declarative. It removes all of the ordering constraints from the previous languages. Finally, the language is meant to be processed in source form as a single compilation unit - there is no module-by-module compilation. This has advantages (no need for compiled disk representation, better error reporting, simpler processing) with the primary disadvantage of space. However, this is not a problem in practice as the linking process for the binary policy modules required the entire representation in memory as well. It is, in many ways, a natural result of the declarative nature of the language.
+
+In many ways, this design document describes what is different between the current language and CIL. For example, types have exactly the same semantics as they currently do, CIL simply uses a different syntax for declaring and referencing them. Consequently, no space is spent describing the semantics of types and only a small amount of space spent discussing the new syntax separate from interaction with new CIL features. Contrastingly, CIL has new constructs for creating, managing, and traversing namespace. There is a corresponding amount of space describing the semantics of those features.
+
+When referring to current semantics it is important to note that there are currently three separate policy languages in common usage: the reference policy syntax created in M4 (which includes interfaces and templates), the module syntax understood by checkmodule, and what is commonly called the kernel policy which is the policy understood by checkpolicy. In general, CIL preserves the current kernel policy almost unchanged (just with different syntax) and layers on features from the module language, reference policy, and novel new features. When discussing current semantics, if the context is not clear attempts will be made to clarify which policy language is being referenced.
diff --git a/secilc/docs/cil_mls_labeling_statements.md b/secilc/docs/cil_mls_labeling_statements.md
new file mode 100644
index 0000000..9b3a36a
--- /dev/null
+++ b/secilc/docs/cil_mls_labeling_statements.md
@@ -0,0 +1,638 @@
+Multi-Level Security Labeling Statements
+========================================
+
+Because there are many options for MLS labeling, the examples show a limited selection of statements, however there is a simple policy that will build shown in the [`levelrange`](cil_mls_labeling_statements.md#levelrange) section.
+
+sensitivity
+-----------
+
+Declare a sensitivity identifier in the current namespace. Multiple [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) statements in the policy will form an ordered list.
+
+**Statement definition:**
+
+    (sensitivity sensitivity_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sensitivity</code></p></td>
+<td align="left"><p>The <code>sensitivity</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sensitivity_id</code></p></td>
+<td align="left"><p>The <code>sensitivity</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares three [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) identifiers:
+
+    (sensitivity s0)
+    (sensitivity s1)
+    (sensitivity s2)
+
+sensitivityalias
+----------------
+
+Declares a sensitivity alias identifier in the current namespace. See the [`sensitivityaliasactual`](cil_mls_labeling_statements.md#sensitivityaliasactual) statement for an example that associates the [`sensitivityalias`](cil_mls_labeling_statements.md#sensitivityalias) identifier.
+
+**Statement definition:**
+
+    (sensitivityalias sensitivityalias_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sensitivityalias</code></p></td>
+<td align="left"><p>The <code>sensitivityalias</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sensitivityalias_id</code></p></td>
+<td align="left"><p>The <code>sensitivityalias</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`sensitivityaliasactual`](cil_mls_labeling_statements.md#sensitivityaliasactual) statement.
+
+sensitivityaliasactual
+----------------------
+
+Associates a previously declared [`sensitivityalias`](cil_mls_labeling_statements.md#sensitivityalias) identifier to a previously declared [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) identifier.
+
+**Statement definition:**
+
+    (sensitivityaliasactual sensitivityalias_id sensitivity_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="29%" />
+<col width="70%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sensitivityaliasactual</code></p></td>
+<td align="left"><p>The <code>sensitivityaliasactual</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sensitivityalias_id</code></p></td>
+<td align="left"><p>A single previously declared <code>sensitivityalias</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>sensitivity_id</code></p></td>
+<td align="left"><p>A single previously declared <code>sensitivity</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate sensitivity `s0` with two sensitivity alias's:
+
+    (sensitivity s0)
+    (sensitivityalias unclassified)
+    (sensitivityalias SystemLow)
+    (sensitivityaliasactual unclassified s0)
+    (sensitivityaliasactual SystemLow s0)
+
+sensitivityorder
+----------------
+
+Define the sensitivity order - lowest to highest. Multiple [`sensitivityorder`](cil_mls_labeling_statements.md#sensitivityorder) statements in the policy will form an ordered list.
+
+**Statement definition:**
+
+    (sensitivityorder (sensitivity_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sensitivityorder</code></p></td>
+<td align="left"><p>The <code>sensitivityorder</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sensitivity_id</code></p></td>
+<td align="left"><p>One or more previously declared <code>sensitivity</code> or <code>sensitivityalias</code> identifiers..</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example shows two [`sensitivityorder`](cil_mls_labeling_statements.md#sensitivityorder) statements that when compiled will form an ordered list. Note however that the second [`sensitivityorder`](cil_mls_labeling_statements.md#sensitivityorder) statement starts with `s2` so that the ordered list can be built.
+
+    (sensitivity s0)
+    (sensitivityalias s0 SystemLow)
+    (sensitivity s1)
+    (sensitivity s2)
+    (sensitivityorder (SystemLow s1 s2))
+
+    (sensitivity s3)
+    (sensitivity s4)
+    (sensitivityalias s4 SystemHigh)
+    (sensitivityorder (s2 s3 SystemHigh))
+
+category
+--------
+
+Declare a category identifier in the current namespace. Multiple category statements declared in the policy will form an ordered list.
+
+**Statement definition:**
+
+    (category category_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>category</code></p></td>
+<td align="left"><p>The <code>category</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>category_id</code></p></td>
+<td align="left"><p>The <code>category</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares a three [`category`](cil_mls_labeling_statements.md#category) identifiers:
+
+    (category c0)
+    (category c1)
+    (category c2)
+
+categoryalias
+-------------
+
+Declares a category alias identifier in the current namespace. See the [`categoryaliasactual`](cil_mls_labeling_statements.md#categoryaliasactual) statement for an example that associates the [`categoryalias`](cil_mls_labeling_statements.md#categoryalias) identifier.
+
+**Statement definition:**
+
+    (categoryalias categoryalias_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>categoryalias</code></p></td>
+<td align="left"><p>The <code>categoryalias</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>categoryalias_id</code></p></td>
+<td align="left"><p>The <code>categoryalias</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+categoryaliasactual
+-------------------
+
+Associates a previously declared [`categoryalias`](cil_mls_labeling_statements.md#categoryalias) identifier to a previously declared [`category`](cil_mls_labeling_statements.md#category) identifier.
+
+**Statement definition:**
+
+    (categoryaliasactual categoryalias_id category_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>categoryaliasactual</code></p></td>
+<td align="left"><p>The <code>categoryaliasactual</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>categoryalias_id</code></p></td>
+<td align="left"><p>A single previously declared <code>categoryalias</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>category_id</code></p></td>
+<td align="left"><p>A single previously declared <code>category</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+Declares a category `c0`, a category alias of `documents`, and then associates them:
+
+    (category c0)
+    (categoryalias documents)
+    (categoryaliasactual documents c0)
+
+categoryorder
+-------------
+
+Define the category order. Multiple [`categoryorder`](cil_mls_labeling_statements.md#categoryorder) statements declared in the policy will form an ordered list. Note that this statement orders the categories to allow validation of category ranges.
+
+**Statement definition:**
+
+    (categoryorder (category_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>categoryorder</code></p></td>
+<td align="left"><p>The <code>categoryorder</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>category_id</code></p></td>
+<td align="left"><p>One or more previously declared <code>category</code> or <code>categoryalias</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example orders one category alias and nine categories:
+
+    (categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9)
+
+categoryset
+-----------
+
+Declare an identifier for a set of contiguous or non-contiguous categories in the current namespace.
+
+Notes:
+
+-   Category expressions are allowed in [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`sensitivitycategory`](cil_mls_labeling_statements.md#sensitivitycategory), [`level`](cil_mls_labeling_statements.md#level), and [`levelrange`](cil_mls_labeling_statements.md#levelrange) statements.
+
+-   Category sets are not allowed in [`categoryorder`](cil_mls_labeling_statements.md#categoryorder) statements.
+
+**Statement definition:**
+
+    (categoryset categoryset_id (category_id ... | expr ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>categoryset</code></p></td>
+<td align="left"><p>The <code>categoryset</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>categoryset_id</code></p></td>
+<td align="left"><p>The <code>categoryset</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>category_id</code></p></td>
+<td align="left"><p>Zero or more previously declared <code>category</code> or <code>categoryalias</code> identifiers.</p>
+<p>Note that there must be at least one <code>category_id</code> identifier or <code>expr</code> parameter declared.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (category_id ...) (category_id ...))</code></p>
+<p><code>    (or  (category_id ...) (category_id ...))</code></p>
+<p><code>    (xor (category_id ...) (category_id ...))</code></p>
+<p><code>    (not (category_id ...))</code></p>
+<p><code>    (range category_id category_id)</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show a selection of [`categoryset`](cil_mls_labeling_statements.md#categoryset) statements:
+
+    ; Declare categories with two alias's:
+    (category c0)
+    (categoryalias documents)
+    (categoryaliasactual documents c0)
+    (category c1)
+    (category c2)
+    (category c3)
+    (category c4)
+    (categoryalias spreadsheets)
+    (categoryaliasactual spreadsheets c4)
+
+    ; Set the order to determine ranges:
+    (categoryorder (c0 c1 c2 c3 spreadsheets))
+
+    (categoryset catrange_1 (range c2 c3))
+
+    ; Two methods to associate all categories:
+    (categoryset all_cats (range c0 c4))
+    (categoryset all_cats1 (all))
+
+    (categoryset catset_1 (documents c1))
+    (categoryset catset_2 (c2 c3))
+    (categoryset catset_3 (c4))
+
+    (categoryset just_c0 (xor (c1 c2) (documents c1 c2)))
+
+sensitivitycategory
+-------------------
+
+Associate a [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) identifier with one or more [category](#category)'s. Multiple definitions for the same [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) form an ordered list of categories for that sensitivity. This statement is required before a [`level`](cil_mls_labeling_statements.md#level) identifier can be declared.
+
+**Statement definition:**
+
+    (sensitivitycategory sensitivity_id categoryset_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sensitivitycategory</code></p></td>
+<td align="left"><p>The <code>sensitivitycategory</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sensitivity_id</code></p></td>
+<td align="left"><p>A single previously declared <code>sensitivity</code> or <code>sensitivityalias</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>categoryset_id</code></p></td>
+<td align="left"><p>A single previously declared <code>categoryset</code> (named or anonymous), or a list of <code>category</code> and/or <code>categoryalias</code> identifiers. The examples show each variation.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These [`sensitivitycategory`](cil_mls_labeling_statements.md#sensitivitycategory) examples use a selection of [`category`](cil_mls_labeling_statements.md#category), [`categoryalias`](cil_mls_labeling_statements.md#categoryalias) and [`categoryset`](cil_mls_labeling_statements.md#categoryset)'s:
+
+    (sensitivitycategory s0 catrange_1)
+    (sensitivitycategory s0 catset_1)
+    (sensitivitycategory s0 catset_3)
+    (sensitivitycategory s0 (all))
+    (sensitivitycategory unclassified (range documents c2))
+
+level
+-----
+
+Declare a [`level`](cil_mls_labeling_statements.md#level) identifier in the current namespace and associate it to a previously declared [`sensitivity`](cil_mls_labeling_statements.md#sensitivity) and zero or more categories. Note that if categories are required, then before this statement can be resolved the [`sensitivitycategory`](cil_mls_labeling_statements.md#sensitivitycategory) statement must be used to associate categories with the sensitivity.
+
+**Statement definition:**
+
+    level level_id (sensitivity_id [categoryset_id])
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>level</code></p></td>
+<td align="left"><p>The <code>level</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>level_id</code></p></td>
+<td align="left"><p>The <code>level</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>sensitivity_id</code></p></td>
+<td align="left"><p>A single previously declared <code>sensitivity</code> or <code>sensitivityalias</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>categoryset_id</code></p></td>
+<td align="left"><p>A single previously declared <code>categoryset</code> (named or anonymous), or a list of <code>category</code> and/or <code>categoryalias</code> identifiers. The examples show each variation.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These [`level`](cil_mls_labeling_statements.md#level) examples use a selection of [`category`](cil_mls_labeling_statements.md#category), [`categoryalias`](cil_mls_labeling_statements.md#categoryalias) and [`categoryset`](cil_mls_labeling_statements.md#categoryset)'s:
+
+    (level systemLow (s0))
+    (level level_1 (s0))
+    (level level_2 (s0 (catrange_1)))
+    (level level_3 (s0 (all_cats)))
+    (level level_4 (unclassified (c2 c3 c4)))
+
+levelrange
+----------
+
+Declare a level range identifier in the current namespace and associate a current and clearance level.
+
+**Statement definition:**
+
+    (levelrange levelrange_id (low_level_id high_level_id))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>levelrange</code></p></td>
+<td align="left"><p>The <code>levelrange</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>levelrange_id</code></p></td>
+<td align="left"><p>The <code>levelrange</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>low_level_id</code></p></td>
+<td align="left"><p>The current level specified by a previously declared <code>level</code> identifier. This may be formed by named or anonymous components as discussed in the <code>level</code> section and shown in the examples.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>high_level_id</code></p></td>
+<td align="left"><p>The clearance or high level specified by a previously declared <code>level</code> identifier. This may be formed by named or anonymous components as discussed in the <code>level</code> section and shown in the examples.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example policy shows [`levelrange`](cil_mls_labeling_statements.md#levelrange) statement and all the other MLS labeling statements discussed in this section and will compile as a standalone policy:
+
+    (handleunknown allow)
+    (mls true)
+
+    ; There must be least one set of SID statements in a policy:
+    (sid kernel)
+    (sidorder (kernel))
+    (sidcontext kernel unconfined.context_1)
+
+    (sensitivitycategory s0 (c4 c2 c3 c1 c0 c3))
+
+    (category c0)
+    (categoryalias documents)
+    (categoryaliasactual documents c0)
+    (category c1)
+    (category c2)
+    (category c3)
+    (category c4)
+    (categoryalias spreadsheets)
+    (categoryaliasactual spreadsheets c4)
+
+    (categoryorder (c0 c1 c2 c3 spreadsheets))
+
+    (categoryset catrange_1 (range c2 c3))
+    (categoryset all_cats (range c0 c4))
+    (categoryset all_cats1 (all))
+
+    (categoryset catset_1 (documents c1))
+    (categoryset catset_2 (c2 c3))
+    (categoryset catset_3 (c4))
+
+    (categoryset just_c0 (xor (c1 c2) (documents c1 c2)))
+
+    (sensitivity s0)
+    (sensitivityalias unclassified)
+    (sensitivityaliasactual unclassified s0)
+
+    (sensitivityorder (s0))
+    (sensitivitycategory s0 (c0))
+
+    (sensitivitycategory s0 catrange_1)
+    (sensitivitycategory s0 catset_1)
+    (sensitivitycategory s0 catset_3)
+    (sensitivitycategory s0 (all))
+    (sensitivitycategory s0 (range documents c2))
+
+    (level systemLow (s0))
+    (level level_1 (s0))
+    (level level_2 (s0 (catrange_1)))
+    (level level_3 (s0 (all_cats)))
+    (level level_4 (unclassified (c2 c3 c4)))
+
+    (levelrange levelrange_2 (level_2 level_2))
+    (levelrange levelrange_1 ((s0) level_2))
+    (levelrange low_low (systemLow systemLow))
+
+    (context context_2 (unconfined.user object_r unconfined.object (level_1 level_3)))
+
+    ; Define object_r role. This must be assigned in CIL.
+    (role object_r)
+
+    (block unconfined
+        (user user)
+        (role role)
+        (type process)
+        (type object)
+        (userrange user (systemLow systemLow))
+        (userlevel user systemLow)
+        (userrole user role)
+        (userrole user object_r)
+        (roletype role process)
+        (roletype role object)
+        (roletype object_r object)
+
+        (class file (open execute read write))
+
+        ; There must be least one allow rule in a policy:
+        (allow process self (file (read)))
+
+        (context context_1 (user object_r object low_low))
+    ) ; End unconfined namespace
+
+rangetransition
+---------------
+
+Allows an objects level to transition to a different level. Generally used to ensure processes run with their correct MLS range, for example `init` would run at `SystemHigh` and needs to initialise / run other processes at their correct MLS range.
+
+**Statement definition:**
+
+    (rangetransition source_id target_id class_id new_range_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>rangetransition</code></p></td>
+<td align="left"><p>The <code>rangetransition</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>new_range_id</code></p></td>
+<td align="left"><p>The new MLS range for the object class that is a previously declared <code>levelrange</code> identifier. This entry may also be defined as an anonymous or named <code>level</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code> or <code>categoryset</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This rule will transition the range of `sshd.exec` to `s0 - s1:c0.c3` on execution from the `init.process`:
+
+    (sensitivity s0)
+    (sensitivity s1)
+    (sensitivityorder s0 s1)
+    (category c0)
+    ...
+    (level systemlow (s0)
+    (level systemhigh (s1 (c0 c1 c2)))
+    (levelrange low_high (systemlow systemhigh))
+
+    (rangetransition init.process sshd.exec process low_high)
diff --git a/secilc/docs/cil_mls_labeling_statements.xml b/secilc/docs/cil_mls_labeling_statements.xml
deleted file mode 100644
index 3738789..0000000
--- a/secilc/docs/cil_mls_labeling_statements.xml
+++ /dev/null
@@ -1,733 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- mls_labeling_statements.xml -->
-
-   <sect1 id="mls_labeling_statements">
-      <title>Multi-Level Security Labeling Statements</title>
-         <para>Because there are many options for MLS labeling, the examples show a limited selection of statements, however there is a simple policy that will build shown in the <literal><link linkend="levelrange">levelrange</link></literal> section.</para>
-      <sect2 id="sensitivity">
-         <title>sensitivity</title>
-         <para>Declare a sensitivity identifier in the current namespace. Multiple <literal>sensitivity</literal> statements in the policy will form an ordered list.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sensitivity sensitivity_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sensitivity</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="sensitivity">sensitivity</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares three <literal><link linkend="sensitivity">sensitivity</link></literal> identifiers:</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(sensitivity s1)
-(sensitivity s2)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="sensitivityalias">
-         <title>sensitivityalias</title>
-         <para>Declares a sensitivity alias identifier in the current namespace. See the <literal><link linkend="sensitivityaliasactual">sensitivityaliasactual</link></literal> statement for an example that associates the <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sensitivityalias sensitivityalias_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sensitivityalias</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sensitivityalias</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivityalias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="sensitivityaliasactual">sensitivityaliasactual</link></literal> statement.</para>
-      </sect2>
-
-      <sect2 id="sensitivityaliasactual">
-         <title>sensitivityaliasactual</title>
-         <para>Associates a previously declared <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier to a previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sensitivityaliasactual sensitivityalias_id sensitivity_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.5 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sensitivityaliasactual</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sensitivityaliasactual</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivityalias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate sensitivity <literal>s0</literal> with two sensitivity alias's:</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(sensitivityalias unclassified)
-(sensitivityalias SystemLow)
-(sensitivityaliasactual unclassified s0)
-(sensitivityaliasactual SystemLow s0)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="sensitivityorder">
-         <title>sensitivityorder</title>
-         <para>Define the sensitivity order - lowest to highest. Multiple <literal><link linkend="sensitivityorder">sensitivityorder</link></literal> statements in the policy will form an ordered list.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sensitivityorder (sensitivity_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sensitivityorder</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sensitivityorder</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> or <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifiers..</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example shows two <literal><link linkend="sensitivityorder">sensitivityorder</link></literal> statements that when compiled will form an ordered list. Note however that the second <literal><link linkend="sensitivityorder">sensitivityorder</link></literal> statement starts with <literal>s2</literal> so that the ordered list can be built.</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(sensitivityalias s0 SystemLow)
-(sensitivity s1)
-(sensitivity s2)
-(sensitivityorder (SystemLow s1 s2))
-
-(sensitivity s3)
-(sensitivity s4)
-(sensitivityalias s4 SystemHigh)
-(sensitivityorder (s2 s3 SystemHigh))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="category">
-         <title>category</title>
-         <para>Declare a category identifier in the current namespace. Multiple category statements declared in the policy will form an ordered list.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(category category_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>category</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>category</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>category_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="category">category</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares a three <literal><link linkend="category">category</link></literal> identifiers:</para>
-         <programlisting><![CDATA[
-(category c0)
-(category c1)
-(category c2)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="categoryalias">
-         <title>categoryalias</title>
-         <para>Declares a category alias identifier in the current namespace. See the <literal><link linkend="categoryaliasactual">categoryaliasactual</link></literal> statement for an example that associates the <literal><link linkend="categoryalias">categoryalias</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(categoryalias categoryalias_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>categoryalias</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>categoryalias</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>categoryalias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="categoryalias">categoryalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-      </sect2>
-
-      <sect2 id="categoryaliasactual">
-         <title>categoryaliasactual</title>
-         <para>Associates a previously declared <literal><link linkend="categoryalias">categoryalias</link></literal> identifier to a previously declared <literal><link linkend="category">category</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(categoryaliasactual categoryalias_id category_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>categoryaliasactual</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>categoryaliasactual</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>categoryalias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="categoryalias">categoryalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>category_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="category">category</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>Declares a category <literal>c0</literal>, a category alias of <literal>documents</literal>, and then associates them:</para>
-         <programlisting><![CDATA[
-(category c0)
-(categoryalias documents)
-(categoryaliasactual documents c0)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="categoryorder">
-         <title>categoryorder</title>
-         <para>Define the category order. Multiple <literal><link linkend="categoryorder">categoryorder</link></literal> statements declared in the policy will form an ordered list. Note that this statement orders the categories to allow validation of category ranges.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(categoryorder (category_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>categoryorder</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>categoryorder</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>category_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more previously declared <literal><link linkend="category">category</link></literal> or <literal><link linkend="categoryalias">categoryalias</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example orders one category alias and nine categories:</para>
-         <programlisting><![CDATA[(categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="categoryset">
-         <title>categoryset</title>
-         <para>Declare an identifier for a set of contiguous or non-contiguous categories in the current namespace.</para>
-         <para>Notes:</para>
-         <itemizedlist>
-            <listitem><para>Category expressions are allowed in <literal><link linkend="categoryset">categoryset</link></literal>, <literal><link linkend="sensitivitycategory">sensitivitycategory</link></literal>, <literal><link linkend="level">level</link></literal>, and <literal><link linkend="levelrange">levelrange</link></literal> statements.</para></listitem>
-            <listitem><para>Category sets are not allowed in <literal><link linkend="categoryorder">categoryorder</link></literal> statements.</para></listitem>
-         </itemizedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(categoryset categoryset_id (category_id ... | expr ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>categoryset</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>categoryset</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>categoryset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="categoryset">categoryset</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>category_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more previously declared <literal><link linkend="category">category</link></literal> or <literal><link linkend="categoryalias">categoryalias</link></literal> identifiers.</para>
-                     <para>Note that there must be at least one <literal>category_id</literal> identifier or <literal>expr</literal> parameter declared.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (category_id ...) (category_id ...))</literal></simpara>
-                     <simpara><literal>    (or  (category_id ...) (category_id ...))</literal></simpara>
-                     <simpara><literal>    (xor (category_id ...) (category_id ...))</literal></simpara>
-                     <simpara><literal>    (not (category_id ...))</literal></simpara>
-                     <simpara><literal>    (range category_id category_id)</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show a selection of <literal><link linkend="categoryset">categoryset</link></literal> statements:</para>
-         <programlisting><![CDATA[
-; Declare categories with two alias's:
-(category c0)
-(categoryalias documents)
-(categoryaliasactual documents c0)
-(category c1)
-(category c2)
-(category c3)
-(category c4)
-(categoryalias spreadsheets)
-(categoryaliasactual spreadsheets c4)
-
-; Set the order to determine ranges:
-(categoryorder (c0 c1 c2 c3 spreadsheets))
-
-(categoryset catrange_1 (range c2 c3))
-
-; Two methods to associate all categories:
-(categoryset all_cats (range c0 c4))
-(categoryset all_cats1 (all))
-
-(categoryset catset_1 (documents c1))
-(categoryset catset_2 (c2 c3))
-(categoryset catset_3 (c4))
-
-(categoryset just_c0 (xor (c1 c2) (documents c1 c2)))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="sensitivitycategory">
-         <title>sensitivitycategory</title>
-         <para>Associate a <literal><link linkend="sensitivity">sensitivity</link></literal> identifier with one or more <link linkend="category">category</link>'s. Multiple definitions for the same <literal><link linkend="sensitivity">sensitivity</link></literal> form an ordered list of categories for that sensitivity. This statement is required before a <literal><link linkend="level">level</link></literal> identifier can be declared.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sensitivitycategory sensitivity_id categoryset_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sensitivitycategory</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sensitivitycategory</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> or <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>categoryset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="categoryset">categoryset</link></literal> (named or anonymous), or a list of <literal><link linkend="category">category</link></literal> and/or <literal><link linkend="categoryalias">categoryalias</link></literal> identifiers. The examples show each variation.
-</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These <literal>sensitivitycategory</literal> examples use a selection of <literal><link linkend="category">category</link></literal>, <literal><link linkend="categoryalias">categoryalias</link></literal> and <literal><link linkend="categoryset">categoryset</link></literal>'s:</para>
-         <programlisting><![CDATA[
-(sensitivitycategory s0 catrange_1)
-(sensitivitycategory s0 catset_1)
-(sensitivitycategory s0 catset_3)
-(sensitivitycategory s0 (all))
-(sensitivitycategory unclassified (range documents c2))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="level">
-         <title>level</title>
-         <para>Declare a <literal><link linkend="level">level</link></literal> identifier in the current namespace and associate it to a previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> and zero or more categories. Note that if categories are required, then before this statement can be resolved the <literal><link linkend="sensitivitycategory">sensitivitycategory</link></literal> statement must be used to associate categories with the sensitivity.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[level level_id (sensitivity_id [categoryset_id])]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>level</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>level</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>level_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="level">level</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sensitivity_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="sensitivity">sensitivity</link></literal> or <literal><link linkend="sensitivityalias">sensitivityalias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>categoryset_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="categoryset">categoryset</link></literal> (named or anonymous), or a list of <literal><link linkend="category">category</link></literal> and/or <literal><link linkend="categoryalias">categoryalias</link></literal> identifiers. The examples show each variation.
-</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These <literal>level</literal> examples use a selection of <literal><link linkend="category">category</link></literal>, <literal><link linkend="categoryalias">categoryalias</link></literal> and <literal><link linkend="categoryset">categoryset</link></literal>'s:</para>
-         <programlisting><![CDATA[
-(level systemLow (s0))
-(level level_1 (s0))
-(level level_2 (s0 (catrange_1)))
-(level level_3 (s0 (all_cats)))
-(level level_4 (unclassified (c2 c3 c4)))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="levelrange">
-         <title>levelrange</title>
-         <para>Declare a level range identifier in the current namespace and associate a current and clearance level.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(levelrange levelrange_id (low_level_id high_level_id))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>levelrange</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>levelrange</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>levelrange_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="levelrange">levelrange</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>low_level_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The current level specified by a previously declared <literal><link linkend="level">level</link></literal> identifier. This may be formed by named or anonymous components as discussed in the <literal><link linkend="level">level</link></literal> section and shown in the examples.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>high_level_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The clearance or high level specified by a previously declared <literal><link linkend="level">level</link></literal> identifier. This may be formed by named or anonymous components as discussed in the <literal><link linkend="level">level</link></literal> section and shown in the examples.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example policy shows <literal><link linkend="levelrange">levelrange</link></literal> statement and all the other MLS labeling statements discussed in this section and will compile as a standalone policy:</para>
-         <programlisting><![CDATA[
-(handleunknown allow)
-(mls true)
-
-; There must be least one set of SID statements in a policy:
-(sid kernel)
-(sidorder (kernel))
-(sidcontext kernel unconfined.context_1)
-
-(sensitivitycategory s0 (c4 c2 c3 c1 c0 c3))
-
-(category c0)
-(categoryalias documents)
-(categoryaliasactual documents c0)
-(category c1)
-(category c2)
-(category c3)
-(category c4)
-(categoryalias spreadsheets)
-(categoryaliasactual spreadsheets c4)
-
-(categoryorder (c0 c1 c2 c3 spreadsheets))
-
-(categoryset catrange_1 (range c2 c3))
-(categoryset all_cats (range c0 c4))
-(categoryset all_cats1 (all))
-
-(categoryset catset_1 (documents c1))
-(categoryset catset_2 (c2 c3))
-(categoryset catset_3 (c4))
-
-(categoryset just_c0 (xor (c1 c2) (documents c1 c2)))
-
-(sensitivity s0)
-(sensitivityalias unclassified)
-(sensitivityaliasactual unclassified s0)
-
-(sensitivityorder (s0))
-(sensitivitycategory s0 (c0))
-
-(sensitivitycategory s0 catrange_1)
-(sensitivitycategory s0 catset_1)
-(sensitivitycategory s0 catset_3)
-(sensitivitycategory s0 (all))
-(sensitivitycategory s0 (range documents c2))
-
-(level systemLow (s0))
-(level level_1 (s0))
-(level level_2 (s0 (catrange_1)))
-(level level_3 (s0 (all_cats)))
-(level level_4 (unclassified (c2 c3 c4)))
-
-(levelrange levelrange_2 (level_2 level_2))
-(levelrange levelrange_1 ((s0) level_2))
-(levelrange low_low (systemLow systemLow))
-
-(context context_2 (unconfined.user object_r unconfined.object (level_1 level_3)))
-
-; Define object_r role. This must be assigned in CIL.
-(role object_r)
-
-(block unconfined
-    (user user)
-    (role role)
-    (type process)
-    (type object)
-    (userrange user (systemLow systemLow))
-    (userlevel user systemLow)
-    (userrole user role)
-    (userrole user object_r)
-    (roletype role process)
-    (roletype role object)
-    (roletype object_r object)
-
-    (class file (open execute read write))
-
-    ; There must be least one allow rule in a policy:
-    (allow process self (file (read)))
-
-    (context context_1 (user object_r object low_low))
-) ; End unconfined namespace]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="rangetransition">
-         <title>rangetransition</title>
-         <para>Allows an objects level to transition to a different level. Generally used to ensure processes run with their correct MLS range, for example <literal>init</literal> would run at <literal>SystemHigh</literal> and needs to initialise / run other processes at their correct MLS range.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(rangetransition source_id target_id class_id new_range_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>rangetransition</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>rangetransition</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>new_range_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The new MLS range for the object class that is a previously declared <literal><link linkend="levelrange">levelrange</link></literal> identifier. This entry may also be defined as an anonymous or named <literal><link linkend="level">level</link></literal>, <literal><link linkend="sensitivity">sensitivity</link></literal>, <literal><link linkend="sensitivityalias">sensitivityalias</link></literal>, <literal><link linkend="category">category</link></literal>, <literal><link linkend="categoryalias">categoryalias</link></literal> or <literal><link linkend="categoryset">categoryset</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This rule will transition the range of <literal>sshd.exec</literal> to <literal>s0 - s1:c0.c3</literal> on execution from the <literal>init.process</literal>:</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(sensitivity s1)
-(sensitivityorder s0 s1)
-(category c0)
-...
-(level systemlow (s0)
-(level systemhigh (s1 (c0 c1 c2)))
-(levelrange low_high (systemlow systemhigh))
-
-(rangetransition init.process sshd.exec process low_high)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2>
-         <title>mlsconstrain</title>
-         <para>This is described in the <link linkend="mlsconstrain">Contraints</link> section.</para>
-      </sect2>
-
-      <sect2>
-         <title>mlsvalidatetrans</title>
-         <para>This is described in the <link linkend="mlsvalidatetrans">Contraints</link> section.</para>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
new file mode 100644
index 0000000..183b350
--- /dev/null
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -0,0 +1,201 @@
+Network Labeling Statements
+===========================
+
+ipaddr
+------
+
+Declares a named IP address in IPv4 or IPv6 format that may be referenced by other CIL statements (i.e. [`netifcon`](cil_network_labeling_statements.md#netifcon)).
+
+Notes:
+
+-   CIL statements utilising an IP address may reference a named IP address or use an anonymous address, the examples will show each option.
+
+-   IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
+
+**Statement definition:**
+
+    (ipaddr ipaddr_id ip_address)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>ipaddr</code></p></td>
+<td align="left"><p>The <code>ipaddr</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>ipaddr_id</code></p></td>
+<td align="left"><p>The IP address identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>ip_address</code></p></td>
+<td align="left"><p>A correctly formatted IP address in IPv4 or IPv6 format.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares a named IP address and also passes an 'explicit anonymously declared' IP address to a macro:
+
+    (ipaddr netmask_1 255.255.255.0)
+    (context netlabel_1 (system.user object_r unconfined.object low_low)
+
+    (call build_nodecon ((192.168.1.64) netmask_1))
+
+    (macro build_nodecon ((ipaddr ARG1) (ipaddr ARG2))
+        (nodecon ARG1 ARG2  netlabel_1))
+
+netifcon
+--------
+
+Label network interface objects (e.g. `eth0`).
+
+**Statement definition:**
+
+    (netifcon netif_name netif_context_id packet_context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>netifcon</code></p></td>
+<td align="left"><p>The <code>netifcon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>netif_name</code></p></td>
+<td align="left"><p>The network interface name (e.g. <code>wlan0</code>).</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>netif_context_id</code></p></td>
+<td align="left"><p>The security context to be allocated to the network interface.</p>
+<p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>packet_context_id</code></p></td>
+<td align="left"><p>The security context to be allocated to packets. Note that these are defined but currently unused as the <strong><code>iptables</code></strong><code>(8)</code> SECMARK services should be used to label packets.</p>
+<p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show named and anonymous [`netifcon`](cil_network_labeling_statements.md#netifcon) statements:
+
+    (context context_1 (unconfined.user object_r unconfined.object low_low))
+    (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
+
+    (netifcon eth0 context_1 (unconfined.user object_r unconfined.object levelrange_1))
+    (netifcon eth1 context_1 (unconfined.user object_r unconfined.object ((s0) level_1)))
+    (netifcon eth3 context_1 context_2)
+
+nodecon
+-------
+
+Label network address objects that represent IPv4 or IPv6 IP addresses and network masks.
+
+IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
+
+**Statement definition:**
+
+    (nodecon subnet_id netmask_id context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>nodecon</code></p></td>
+<td align="left"><p>The <code>nodecon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>subnet_id</code></p></td>
+<td align="left"><p>A previously declared <code>ipaddr</code> identifier, or an anonymous IPv4 or IPv6 formatted address.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>netmask_id</code></p></td>
+<td align="left"><p>A previously declared <code>ipaddr</code> identifier, or an anonymous IPv4 or IPv6 formatted address.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show named and anonymous [`nodecon`](cil_network_labeling_statements.md#nodecon) statements:
+
+    (context context_1 (unconfined.user object_r unconfined.object low_low))
+    (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
+
+    (ipaddr netmask_1 255.255.255.0)
+    (ipaddr ipv4_1 192.168.1.64)
+
+    (nodecon netmask_1 ipv4_1 context_2)
+    (nodecon (255.255.255.0) (192.168.1.64) context_1)
+    (nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
+
+portcon
+-------
+
+Label a udp or tcp port.
+
+**Statement definition:**
+
+    (portcon protocol port|(port_low port_high) context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>portcon</code></p></td>
+<td align="left"><p>The <code>portcon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>protocol</code></p></td>
+<td align="left"><p>The protocol keyword <code>tcp</code> or <code>udp</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>port |</code></p>
+<p><code>(port_low port_high)</code></p></td>
+<td align="left"><p>A single port to apply the context, or a range of ports.</p>
+<p>The entries must consist of numerics <code>[0-9]</code>.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show named and anonymous [`portcon`](cil_network_labeling_statements.md#portcon) statements:
+
+    (portcon tcp 1111 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
+    (portcon tcp 2222 (unconfined.user object_r unconfined.object levelrange_2))
+    (portcon tcp 3333 (unconfined.user object_r unconfined.object levelrange_1))
+    (portcon udp 4444 (unconfined.user object_r unconfined.object ((s0) level_2)))
+    (portcon tcp (2000 20000) (unconfined.user object_r unconfined.object (systemlow level_3)))
diff --git a/secilc/docs/cil_network_labeling_statements.xml b/secilc/docs/cil_network_labeling_statements.xml
deleted file mode 100644
index 1047108..0000000
--- a/secilc/docs/cil_network_labeling_statements.xml
+++ /dev/null
@@ -1,244 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- network_labeling_statements.xml -->
-
-   <sect1 id="network_labeling">
-      <title>Network Labeling Statements</title>
-      <sect2 id="ipaddr">
-         <title>ipaddr</title>
-         <para>Declares a named IP address in IPv4 or IPv6 format that may be referenced by other CIL statements (i.e. <literal>netifcon</literal>).</para>
-         <para>Notes:</para>
-         <itemizedlist>
-            <listitem><para>CIL statements utilising an IP address may reference a named IP address or use an anonymous address, the examples will show each option.</para></listitem>
-
-            <listitem><para>IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. <literal>(127.0.0.1)</literal> or <literal>(::1)</literal>.</para></listitem>
-         </itemizedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(ipaddr ipaddr_id ip_address)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>ipaddr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>ipaddr</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>ipaddr_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The IP address identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>ip_address</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A correctly formatted IP address in IPv4 or IPv6 format.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares a named IP address and also passes an 'explicit anonymously declared' IP address to a macro:</para>
-         <programlisting><![CDATA[
-(ipaddr netmask_1 255.255.255.0)
-(context netlabel_1 (system.user object_r unconfined.object low_low)
-
-(call build_nodecon ((192.168.1.64) netmask_1))
-
-(macro build_nodecon ((ipaddr ARG1) (ipaddr ARG2))
-    (nodecon ARG1 ARG2  netlabel_1))]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="netifcon">
-         <title>netifcon</title>
-         <para>Label network interface objects (e.g. <literal>eth0</literal>).</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(netifcon netif_name netif_context_id packet_context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>netifcon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>netifcon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>netif_name</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The network interface name (e.g. <literal>wlan0</literal>).</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>netif_context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The security context to be allocated to the network interface.</para>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>packet_context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The security context to be allocated to packets. Note that these are defined but currently unused as the <emphasis role="bold"><literal>iptables</literal></emphasis><literal>(8)</literal> SECMARK services should be used to label packets.</para>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show named and anonymous <literal>netifcon</literal> statements:</para>
-         <programlisting><![CDATA[
-(context context_1 (unconfined.user object_r unconfined.object low_low))
-(context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
-
-(netifcon eth0 context_1 (unconfined.user object_r unconfined.object levelrange_1))
-(netifcon eth1 context_1 (unconfined.user object_r unconfined.object ((s0) level_1)))
-(netifcon eth3 context_1 context_2)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="nodecon">
-         <title>nodecon</title>
-         <para>Label network address objects that represent IPv4 or IPv6 IP addresses and network masks.</para>
-         <para>IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. <literal>(127.0.0.1)</literal> or <literal>(::1)</literal>.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(nodecon subnet_id netmask_id context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>nodecon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>nodecon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>subnet_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="ipaddr">ipaddr</link></literal> identifier, or an anonymous IPv4 or IPv6 formatted address.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>netmask_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="ipaddr">ipaddr</link></literal> identifier, or an anonymous IPv4 or IPv6 formatted address.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show named and anonymous <literal>nodecon</literal> statements:</para>
-         <programlisting><![CDATA[
-(context context_1 (unconfined.user object_r unconfined.object low_low))
-(context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
-
-(ipaddr netmask_1 255.255.255.0)
-(ipaddr ipv4_1 192.168.1.64)
-
-(nodecon netmask_1 ipv4_1 context_2)
-(nodecon (255.255.255.0) (192.168.1.64) context_1)
-(nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="portcon">
-         <title>portcon</title>
-         <para>Label a udp or tcp port.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(portcon protocol port|(port_low port_high) context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>portcon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>portcon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>protocol</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The protocol keyword <literal>tcp</literal> or <literal>udp</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>port |</literal></para>
-                     <para><literal>(port_low port_high)</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single port to apply the context, or a range of ports.</para>
-                     <para>The entries must consist of numerics <literal>[0-9]</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show named and anonymous <literal>portcon</literal> statements:</para>
-         <programlisting><![CDATA[
-(portcon tcp 1111 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
-(portcon tcp 2222 (unconfined.user object_r unconfined.object levelrange_2))
-(portcon tcp 3333 (unconfined.user object_r unconfined.object levelrange_1))
-(portcon udp 4444 (unconfined.user object_r unconfined.object ((s0) level_2)))
-(portcon tcp (2000 20000) (unconfined.user object_r unconfined.object (systemlow level_3)))]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_policy_config_statements.md b/secilc/docs/cil_policy_config_statements.md
new file mode 100644
index 0000000..392976f
--- /dev/null
+++ b/secilc/docs/cil_policy_config_statements.md
@@ -0,0 +1,113 @@
+Policy Configuration Statements
+===============================
+
+mls
+---
+
+Defines whether the policy is built as an MLS or non-MLS policy by the CIL compiler. There MUST only be one [`mls`](cil_policy_config_statements.md#mls) entry in the policy otherwise the compiler will exit with an error.
+
+Note that this can be over-ridden by the CIL compiler command line parameter `-M true|false` or `--mls true|false` flags.
+
+**Statement definition:**
+
+    (mls boolean)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>mls</code></p></td>
+<td align="left"><p>The <code>mls</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>boolean</code></p></td>
+<td align="left"><p>Set to either <code>true</code> or <code>false</code>.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+    (mls true)
+
+handleunknown
+-------------
+
+Defines how the kernel will handle unknown object classes and permissions when loading the policy. There MUST only be one [`handleunknown`](cil_policy_config_statements.md#handleunknown) entry in the policy otherwise the compiler will exit with an error.
+
+Note that this can be over-ridden by the CIL compiler command line parameter `-U` or `--handle-unknown` flags.
+
+**Statement definition:**
+
+    (handleunknown action)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="20%" />
+<col width="80%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>handleunknown</code></p></td>
+<td align="left"><p>The <code>handleunknown</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>action</code></p></td>
+<td align="left"><p>A keyword of either <code>allow</code>, <code>deny</code> or <code>reject</code>. The kernel will handle these keywords as follows:</p>
+<p><code>    allow</code> unknown class / permissions. This will set the returned AV with all 1's.</p>
+<p><code>    deny</code> unknown class / permissions (the default). This will set the returned AV with all 0's.</p>
+<p><code>    reject</code> loading the policy if it does not contain all the object classes / permissions.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This will allow unknown classes / permissions to be present in the policy:
+
+    (handleunknown allow)
+
+policycap
+---------
+
+Allow policy capabilities to be enabled via policy. These should be declared in the global namespace and be valid policy capabilities as they are checked against those known in libsepol by the CIL compiler.
+
+**Statement definition:**
+
+    (policycap policycap_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>policycap</code></p></td>
+<td align="left"><p>The <code>policycap</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>policycap_id</code></p></td>
+<td align="left"><p>The <code>policycap</code> identifer (e.g. <code>open_perms</code>).</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+These set two valid policy capabilities:
+
+    ; Enable networking controls.
+    (policycap network_peer_controls)
+
+    ; Enable open permission check.
+    (policycap open_perms)
diff --git a/secilc/docs/cil_policy_config_statements.xml b/secilc/docs/cil_policy_config_statements.xml
deleted file mode 100644
index 771e4dd..0000000
--- a/secilc/docs/cil_policy_config_statements.xml
+++ /dev/null
@@ -1,118 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- policy_config_statements.xml -->
-
-   <sect1>
-      <title>Policy Configuration Statements</title>
-      <sect2 id="mls">
-         <title>mls</title>
-         <para>Defines whether the policy is built as an MLS or non-MLS policy by the CIL compiler. There MUST only be one <literal>mls</literal> entry in the policy otherwise the compiler will exit with an error.</para>
-         <para>Note that this can be over-ridden by the CIL compiler command line parameter <literal>-M true|false</literal> or <literal>--mls true|false</literal> flags.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(mls boolean)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>mls</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>mls</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>boolean</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Set to either <literal>true</literal> or <literal>false</literal>.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <programlisting><![CDATA[(mls true)]]></programlisting>
-      </sect2>
-
-      <sect2 id="handleunknown">
-         <title>handleunknown</title>
-         <para>Defines how the kernel will handle unknown object classes and permissions when loading the policy. There MUST only be one <literal>handleunknown</literal> entry in the policy otherwise the compiler will exit with an error.</para>
-         <para>Note that this can be over-ridden by the CIL compiler command line parameter <literal>-U</literal> or <literal>--handle-unknown</literal> flags.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(handleunknown action)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="1.5 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>handleunknown</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>handleunknown</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>action</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A keyword of either <literal>allow</literal>, <literal>deny</literal> or <literal>reject</literal>. The kernel will handle these keywords as follows:</para>
-                     <simpara><literal>    allow</literal> unknown class / permissions. This will set the returned AV with all 1's.</simpara>
-                     <simpara><literal>    deny</literal> unknown class / permissions (the default). This will set the returned AV with all 0's.</simpara>
-                     <simpara><literal>    reject</literal> loading the policy if it does not contain all the object classes / permissions.</simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will allow unknown classes / permissions to be present in the policy:</para>
-         <programlisting><![CDATA[(handleunknown allow)]]></programlisting>
-      </sect2>
-
-      <sect2 id="policycap">
-         <title>policycap</title>
-         <para>Allow policy capabilities to be enabled via policy. These should be declared in the global namespace and be valid policy capabilities as they are checked against those known in libsepol by the CIL compiler.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(policycap policycap_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>policycap</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>policycap</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>policycap_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>policycap</literal> identifer (e.g. <literal>open_perms</literal>).</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>These set two valid policy capabilities:</para>
-         <programlisting><![CDATA[
-; Enable networking controls.
-(policycap network_peer_controls)
-
-; Enable open permission check.
-(policycap open_perms)]]>
-         </programlisting>
-      </sect2>
-   </sect1>
-
diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
new file mode 100644
index 0000000..d179c3c
--- /dev/null
+++ b/secilc/docs/cil_reference_guide.md
@@ -0,0 +1,298 @@
+CIL Information
+===============
+
+1.  Not all possible alternate statement permutations are shown, however there should be enough variation to work out any other valid formats. There is also an example [`policy.cil`](../test/policy.cil#example-policy) file in the test directory.
+
+2.  The MLS components on contexts and user statements must be declared even if the policy does not support MCS/MLS.
+
+3.  The CIL compiler will not build a policy unless it also has as a minimum: one [`allow`](cil_access_vector_rules.md#allow) rule, one [`sid`](cil_sid_statements.md#sid), [`sidorder`](cil_sid_statements.md#sidorder) and [`sidcontext`](cil_sid_statements.md#sidcontext) statement.
+
+4.  The role `object_r` must be explicitly associated to contexts used for labeling objects. The original **`checkpolicy`**`(8)` and **`checkmodule`**`(8)` compilers did this by default - CIL does not.
+
+5.  Be aware that CIL allows [`class`](cil_class_and_permission_statements.md#class) statements to be declared in a namespace, however the policy author needs to note that applications (and the kernel) generally reference a class by its well known class identifier (e.g. `zygote`) however if declared in a namespace (e.g. `(block zygote (class zygote (...)))` or `(block zygote (class class (...)))`) it would be prefixed with that namespace (e.g. `zygote.zygote` or `zygote.class`). Unless the application / kernel code was updated the class would never be resolved, therefore it is recommended that classes are declared in the global namespace.
+
+6.  Where possible use [`typeattribute`](cil_type_statements.md#typeattribute)'s when defining source/target [`allow`](cil_access_vector_rules.md#allow) rules instead of multiple [`allow`](cil_access_vector_rules.md#allow) rules with individual [`type`](cil_type_statements.md#type)'s. This will lead to the generation of much smaller kernel policy files.
+
+7.  The [](http://github.com/SELinuxProject/cil/wiki) site explains the language however some of the statement definitions are dated.
+
+Declarations
+------------
+
+Declarations may be named or anonymous and have three different forms:
+
+1.  Named declarations - These create new objects that introduce a name or identifier, for example:
+
+    `(type process)` - creates a [`type`](cil_type_statements.md#type) with an identifier of `process`.
+
+    `(typeattribute domain)` - creates a [`typeattribute`](cil_type_statements.md#typeattribute) with an identifier of `domain`.
+
+    `(class file (read write))` - creates a [`class`](cil_class_and_permission_statements.md#class) with an identifier of `file` that has `read` and `write` permissions associated to it.
+
+    The list of declaration type statement keywords are:
+
+    block
+    optional
+    common
+    class
+    classmap
+    classmapping
+    sid
+    user
+    role
+    roleattribute
+    type
+    classpermission
+    classpermissionset
+    typeattribute
+    typealias
+    tunable
+    sensitivity
+    sensitivityalias
+    category
+    categoryalias
+    categoryset
+    level
+    levelrange
+    context
+    ipaddr
+    macro
+    policycap
+2.  Explicit anonymous declarations - These are currently restricted to IP addesses where they can be declared directly in statements by enclosing them within parentheses e.g. `(127.0.0.1)` or `(::1)`. See the [Network Labeling Statements](#network_labeling) section for examples.
+
+3.  Anonymous declarations - These have been previously declared and the object already exists, therefore they may be referenced by their name or identifier within statements. For example the following declare all the components required to specify a context:
+
+        (sensitivity s0)
+        (category c0)
+        (role object_r)
+
+        (block unconfined
+            (user user)
+            (type object)
+        )
+
+    now a [`portcon`](cil_network_labeling_statements.md#portcon) statement can be defined that uses these individual components to build a context as follows:
+
+        (portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))
+
+Definitions
+-----------
+
+Statements that build on the objects, for example:
+
+-   `(typeattributeset domain (process))` - Adds the [`type`](cil_type_statements.md#type) '`process`' to the [`typeattribute`](cil_type_statements.md#typeattribute) '`domain`'.
+
+-   `(allow domain process (file (read write))))` - Adds an [`allow`](cil_access_vector_rules.md#allow) rule referencing `domain`, `process` and the `file class`.
+
+Definitions may be repeated many times throughout the policy. Duplicates will resolve to a single definition during compilation.
+
+Symbol Character Set
+--------------------
+
+Symbols (any string not enclosed in double quotes) must only contain alphanumeric `[a-z A-Z] [0-9]` characters plus the following special characters: `\.@=/-_$%@+!|&^:`
+
+However symbols are checked for any specific character set limitations, for example:
+
+-   Names or identifiers must start with an alpa character `[a-z A-Z]`, the remainder may be alphanumeric `[a-z A-Z] [0-9]` characters plus underscore `[_]` or hyphen `[-]`.
+
+-   IP addresses must conform to IPv4 or IPv6 format.
+
+-   Memory, ports, irqs must be numeric `[0-9]`.
+
+String Character Set
+--------------------
+
+Strings are enclosed within double quotes (e.g. `"This is a string"`), and may contain any character except the double quote (").
+
+Comments
+--------
+
+Comments start with a semicolon '`;`' and end when a new line is started.
+
+Namespaces
+----------
+
+CIL supports namespaces via containers such as the [`block`](cil_container_statements.md#block) statement. When a block is resolved to form the parent / child relationship a dot '`.`' is used, for example the following [`allow`](cil_access_vector_rules.md#allow) rule:
+
+    (block example_ns
+        (type process)
+        (type object)
+        (class file (open read write getattr))
+
+        (allow process object (file (open read getattr)))
+    )
+
+will resolve to the following kernel policy language statement:
+
+    allow example_ns.process example_ns.object : example_ns.file { open read getattr };
+
+Global Namespace
+----------------
+
+CIL has a global namespace that is always present. Any symbol that is declared outside a container is in the global namespace. To reference a symbol in global namespace, the symbol should be prefixed with a dot '`.`' as shown in the following example:
+
+    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+    ; This example has three namespace 'tmpfs' types declared:
+    ;    1) Global .tmpfs
+    ;    2) file.tmpfs
+    ;    3) other_ns.tmpfs
+    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+    ; This type is the global tmpfs:
+    (type tmpfs)
+
+    (block file
+        ; file namespace tmpfs
+        (type tmpfs)
+        (class file (open read write getattr))
+
+        ; This rule will reference the local namespace for src and tgt:
+        (allow tmpfs tmpfs (file (open)))
+        ; Resulting policy rule:
+        ; allow file.tmpfs file.tmpfs : file.file open;
+
+        ; This rule will reference the local namespace for src and global for tgt:
+        (allow tmpfs .tmpfs (file (read)))
+        ; Resulting policy rule:
+        ; allow file.tmpfs tmpfs : file.file read;
+
+        ; This rule will reference the global namespace for src and tgt:
+        (allow .tmpfs .tmpfs (file (write)))
+        ; Resulting policy rule:
+        ; allow tmpfs tmpfs : file.file write;
+
+        ; This rule will reference the other_ns namespace for src and
+        ; local namespace for tgt:
+        (allow other_ns.tmpfs tmpfs (file (getattr)))
+        ; Resulting policy rule:
+        ; allow other_ns.tmpfs file.tmpfs : file.file getattr;
+    )
+
+    (block other_ns
+        (type tmpfs)
+    )
+
+Should the symbol not be prefixed with a dot, the current namespace would be searched first and then the global namespace (provided there is not a symbol of that name in the current namespace).
+
+Expressions
+-----------
+
+Expressions may occur in the following CIL statements: [`booleanif`](cil_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statements.md#tunableif), [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typeattributeset), [`roleattributeset`](cil_role_statements.md#roleattributeset), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.md#validatetrans), [`validatetrans`](cil_constraint_statements.md#validatetrans)
+
+CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.html) or Polish notation and may be nested (note that the kernel policy language uses postfix or reverse Polish notation). The syntax is as follows, where the parenthesis are part of the syntax:
+
+    expr_set = (name ... | expr ...)
+    expr = (expr_key expr_set ...)
+    expr_key = and | or | xor | not | all | eq | neq | dom | domby | incomp | range
+
+The number of `expr_set`'s in an `expr` is dependent on the statement type (there are four different classes as defined below) that also influence the valid `expr_key` entries (e.g. `dom`, `domby`, `incomp` are only allowed in constraint statements).
+
+| expr_key | classpermissionset roleattributeset typeattributeset | categoryset | booleanif tunableif | constrain mlsconstrain validatetrans mlsvalidatetrans |
+|:----------:|:----------:|:----------:|:----------:|:----------:|
+| **`dom`**    |                        |                      |                      | **X**           |
+| **`domby`**  |                        |                      |                      | **X**           |
+| **`incomp`** |                        |                      |                      | **X**           |
+| **`eq`**     |                        |                      | **X**                | **X**           |
+| **`ne`**     |                        |                      | **X**                | **X**           |
+| **`and`**    | **X**                  | **X**                | **X**                | **X**           |
+| **`or`**     | **X**                  | **X**                | **X**                | **X**           |
+| **`not`**    | **X**                  | **X**                | **X**                | **X**           |
+| **`xor`**    | **X**                  | **X**                | **X**                |                 |
+| **`all`**    | **X**                  | **X**                |                      |                 |
+| **`range`**  |                        | **X**                |                      |                 |
+
+1.  The [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset), [`roleattributeset`](cil_role_statements.md#roleattributeset) and [`typeattributeset`](cil_type_statements.md#typeattributeset) statements allow `expr_set` to mix names and `expr`s with `expr_key` values of: `and`, `or`, `xor`, `not`, `all` as shown in the examples:
+
+    This example includes all `fs_type type` entries except `file.usermodehelper` and `file.proc_security` in the associated [`typeattribute`](cil_type_statements.md#typeattribute) identifier `all_fs_type_except_usermodehelper_and_proc_security`:
+
+        (typeattribute all_fs_type_except_usermodehelper_and_proc_security)
+
+        (typeattributeset all_fs_type_except_usermodehelper_and_proc_security
+            (and
+                (and
+                    fs_type
+                    (not file.usermodehelper)
+                )
+                (not file.proc_security)
+            )
+        )
+
+    The `cps_1 classpermissionset` identifier includes all permissions except `load_policy` and `setenforce`:
+
+        (class security (compute_av compute_create compute_member check_context load_policy compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot read_policy))
+
+        (classpermission cps_1)
+
+        (classpermissionset cps_1 (security (not (load_policy setenforce))))
+
+    This example includes all permissions in the associated [`classpermissionset`](cil_class_and_permission_statements.md#classpermissionset) identifer `security_all_perms`:
+
+        (class security (compute_av compute_create compute_member check_context load_policy
+            compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot
+            read_policy)
+        )
+
+        (classpermission security_all_perms)
+
+        (classpermissionset security_all_perms (security (all)))
+
+2.  The [`categoryset`](cil_mls_labeling_statements.md#categoryset) statement allows `expr_set` to mix names and `expr_key` values of: `and`, `or`, `not`, `xor`, `all`, `range` as shown in the examples.
+
+    Category expressions are also allowed in [`sensitivitycategory`](cil_mls_labeling_statements.md#sensitivitycategory), [`level`](cil_mls_labeling_statements.md#level), and [`levelrange`](cil_mls_labeling_statements.md#levelrange) statements.
+
+3.  The [`booleanif`](cil_conditional_statements.md#booleanif) and [`tunableif`](cil_conditional_statements.md#tunableif) statements only allow an `expr_set` to have one `name` or `expr` with `expr_key` values of `and`, `or`, `xor`, `not`, `eq`, `neq` as shown in the examples:
+
+        (booleanif disableAudio
+            (false
+                (allow process device.audio_device (chr_file_set (rw_file_perms)))
+            )
+        )
+
+        (booleanif (and (not disableAudio) (not disableAudioCapture))
+            (true
+                (allow process device.audio_capture_device (chr_file_set (rw_file_perms)))
+            )
+        )
+
+4.  The [`constrain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.md#validatetrans) and [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans) statements only allow an `expr_set` to have one `name` or `expr` with `expr_key` values of `and`, `or`, `not`, `all`, `eq`, `neq`, `dom`, `domby`, `incomp`. When `expr_key` is `dom`, `domby` or `incomp`, it must be followed by a string (e.g. `h1`, `l2`) and another string or a set of `name`s. The following examples show CIL constraint statements and their policy language equivalents:
+
+        ; Process transition:  Require equivalence unless the subject is trusted.
+        (mlsconstrain (process (transition dyntransition))
+            (or (and (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))
+
+        ; The equivalent policy language mlsconstrain statememt is:
+        ;mlsconstrain process { transition dyntransition }
+        ;    ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);
+
+        ; Process read operations: No read up unless trusted.
+        (mlsconstrain (process (getsched getsession getpgid getcap getattr ptrace share))
+            (or (dom l1 l2) (eq t1 mlstrustedsubject)))
+
+        ; The equivalent policy language mlsconstrain statememt is:
+        ;mlsconstrain process { getsched getsession getpgid getcap getattr ptrace share }
+        ;    (l1 dom l2 or t1 == mlstrustedsubject);
+
+Name String
+-----------
+
+Used to define [`macro`](cil_call_macro_statements.md#macro) statement parameter string types:
+
+    (call macro1("__kmsg__"))
+
+    (macro macro1 ((string ARG1))
+        (typetransition audit.process device.device chr_file ARG1 device.klog_device)
+    )
+
+Alternatively:
+
+    (call macro1("__kmsg__"))
+
+    (macro macro1 ((name ARG1))
+        (typetransition audit.process device.device chr_file ARG1 device.klog_device)
+    )
+
+self
+----
+
+The [`self`](cil_reference_guide.md#self) keyword may be used as the target in AVC rule statements, and means that the target is the same as the source as shown in the following example:.
+
+    (allow unconfined.process self (file (read write)))
diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
new file mode 100644
index 0000000..0c4cadb
--- /dev/null
+++ b/secilc/docs/cil_role_statements.md
@@ -0,0 +1,320 @@
+Role Statements
+===============
+
+role
+----
+
+Declares a role identifier in the current namespace.
+
+**Statement definition:**
+
+    (role role_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>role</code></p></td>
+<td align="left"><p>The <code>role</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>role_id</code></p></td>
+<td align="left"><p>The <code>role</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares two roles: `object_r` in the global namespace and `unconfined.role`:
+
+    (role object_r)
+
+    (block unconfined
+        (role role)
+    )
+
+roletype
+--------
+
+Authorises a [`role`](cil_role_statements.md#role) to access a [`type`](cil_type_statements.md#type) identifier.
+
+**Statement definition:**
+
+    (role role_id type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>roletype</code></p></td>
+<td align="left"><p>The <code>roletype</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> or <code>roleattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will declare [`role`](cil_role_statements.md#role) and [`type`](cil_type_statements.md#type) identifiers, then associate them:
+
+    (block unconfined
+        (role role)
+        (type process)
+        (roletype role process)
+    )
+
+roleattribute
+-------------
+
+Declares a role attribute identifier in the current namespace. The identifier may have zero or more [`role`](cil_role_statements.md#role) and [`roleattribute`](cil_role_statements.md#roleattribute) identifiers associated to it via the [`typeattributeset`](cil_type_statements.md#typeattributeset) statement.
+
+**Statement definition:**
+
+    (roleattribute roleattribute_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>roleattribute</code></p></td>
+<td align="left"><p>The <code>roleattribute</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>roleattribute_id</code></p></td>
+<td align="left"><p>The <code>roleattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will declare a role attribute `roles.role_holder` that will have an empty set:
+
+    (block roles
+        (roleattribute role_holder)
+    )
+
+roleattributeset
+----------------
+
+Allows the association of one or more previously declared [`role`](cil_role_statements.md#role) identifiers to a [`roleattribute`](cil_role_statements.md#roleattribute) identifier. Expressions may be used to refine the associations as shown in the examples.
+
+**Statement definition:**
+
+    (roleattributeset roleattribute_id (role_id ... | expr ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>roleattributeset</code></p></td>
+<td align="left"><p>The <code>roleattributeset</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>roleattribute_id</code></p></td>
+<td align="left"><p>A single previously declared <code>roleattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>role_id</code></p></td>
+<td align="left"><p>Zero or more previously declared <code>role</code> or <code>roleattribute</code> identifiers.</p>
+<p>Note that there must be at least one <code>role_id</code> or <code>expr</code> parameter declared.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (role_id ...) (role_id ...))</code></p>
+<p><code>    (or  (role_id ...) (role_id ...))</code></p>
+<p><code>    (xor (role_id ...) (role_id ...))</code></p>
+<p><code>    (not (role_id ...))</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will declare three roles and two role attributes, then associate all the roles to them as shown:
+
+    (block roles
+        (role role_1)
+        (role role_2)
+        (role role_3)
+
+        (roleattribute role_holder)
+        (roleattributeset role_holder (role_1 role_2 role_3))
+
+        (roleattribute role_holder_all)
+        (roleattributeset role_holder_all (all))
+    )
+
+roleallow
+---------
+
+Authorise the current role to assume a new role.
+
+Notes:
+
+-   May require a [`roletransition`](cil_role_statements.md#roletransition) rule to ensure transition to the new role.
+
+-   This rule is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) statements.
+
+**Statement definition:**
+
+    (roleallow current_role_id new_role_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>roleallow</code></p></td>
+<td align="left"><p>The <code>roleallow</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>current_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> or <code>roleattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>new_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> or <code>roleattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`roletransition`](cil_role_statements.md#roletransition) statement for an example.
+
+roletransition
+--------------
+
+Specify a role transition from the current role to a new role when computing a context for the target type. The [`class`](cil_class_and_permission_statements.md#class) identifier would normally be `process`, however for kernel versions 2.6.39 with policy version \>= 25 and above, any valid class may be used. Note that a [`roleallow`](cil_role_statements.md#roleallow) rule must be used to authorise the transition.
+
+**Statement definition:**
+
+    (roletransition current_role_id target_type_id class_id new_role_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>roletransition</code></p></td>
+<td align="left"><p>The <code>roletransition</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>current_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> or <code>roleattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>new_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> identifier to be set on transition.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will authorise the `unconfined.role` to assume the `msg_filter.role` role, and then transition to that role:
+
+    (block ext_gateway
+        (type process)
+        (type exec)
+
+        (roletype msg_filter.role process)
+        (roleallow unconfined.role msg_filter.role)
+        (roletransition unconfined.role exec process msg_filter.role)
+    )
+
+rolebounds
+----------
+
+Defines a hierarchical relationship between roles where the child role cannot have more privileges than the parent.
+
+Notes:
+
+-   It is not possible to bind the parent role to more than one child role.
+
+-   While this is added to the binary policy, it is not enforced by the SELinux kernel services.
+
+**Statement definition:**
+
+    (rolebounds parent_role_id child_role_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>rolebounds</code></p></td>
+<td align="left"><p>The <code>rolebounds</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>parent_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>child_role_id</code></p></td>
+<td align="left"><p>A single previously declared <code>role</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+In this example the role `test` cannot have greater priviledges than `unconfined.role`:
+
+    (role test)
+
+    (unconfined
+        (role role)
+        (rolebounds role .test)
+    )
diff --git a/secilc/docs/cil_role_statements.xml b/secilc/docs/cil_role_statements.xml
deleted file mode 100644
index 47ca8c7..0000000
--- a/secilc/docs/cil_role_statements.xml
+++ /dev/null
@@ -1,374 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- role_statements.xml -->
-
-
-
-   <sect1>
-      <title>Role Statements</title>
-      <sect2 id="role">
-         <title>role</title>
-         <para>Declares a role identifier in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(role role_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>role</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>role</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>role</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares two roles: <literal>object_r</literal> in the global namespace and <literal>unconfined.role</literal>:</para>
-         <programlisting><![CDATA[
-(role object_r)
-
-(block unconfined
-    (role role)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="roletype">
-         <title>roletype</title>
-         <para>Authorises a <literal><link linkend="role">role</link></literal> to access a <literal><link linkend="type">type</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(role role_id type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>roletype</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roletype</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will declare <literal><link linkend="role">role</link></literal> and <literal><link linkend="type">type</link></literal> identifiers, then associate them:</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (role role)
-    (type process)
-    (roletype role process)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="roleattribute">
-         <title>roleattribute</title>
-         <para>Declares a role attribute identifier in the current namespace. The identifier may have zero or more <literal><link linkend="role">role</link></literal> and <literal><link linkend="roleattribute">roleattribute</link></literal> identifiers associated to it via the <literal><link linkend="roleattributeset">typeattributeset</link></literal> statement.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(roleattribute roleattribute_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>roleattribute</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roleattribute</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>roleattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roleattribute</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will declare a role attribute <literal>roles.role_holder</literal> that will have an empty set:</para>
-         <programlisting><![CDATA[
-(block roles
-    (roleattribute role_holder)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="roleattributeset">
-         <title>roleattributeset</title>
-         <para>Allows the association of one or more previously declared <literal><link linkend="role">role</link></literal> identifiers to a <literal><link linkend="roleattribute">roleattribute</link></literal> identifier. Expressions may be used to refine the associations as shown in the examples.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(roleattributeset roleattribute_id (role_id ... | expr ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>roleattributeset</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roleattributeset</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>roleattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifiers.</para>
-                     <para>Note that there must be at least one <literal>role_id</literal> or <literal>expr</literal> parameter declared.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (role_id ...) (role_id ...))</literal></simpara>
-                     <simpara><literal>    (or  (role_id ...) (role_id ...))</literal></simpara>
-                     <simpara><literal>    (xor (role_id ...) (role_id ...))</literal></simpara>
-                     <simpara><literal>    (not (role_id ...))</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will declare three roles and two role attributes, then associate all the roles to them as shown:</para>
-         <programlisting><![CDATA[
-(block roles
-    (role role_1)
-    (role role_2)
-    (role role_3)
-
-    (roleattribute role_holder)
-    (roleattributeset role_holder (role_1 role_2 role_3))
-
-    (roleattribute role_holder_all)
-    (roleattributeset role_holder_all (all))
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="roleallow">
-         <title>roleallow</title>
-         <para>Authorise the current role to assume a new role.</para>
-         <para>Notes:</para>
-         <itemizedlist>
-            <listitem><para>May require a <literal><link linkend="roletransition">roletransition</link></literal> rule to ensure transition to the new role.</para></listitem>
-            <listitem><para>This rule is not allowed in <literal><link linkend="booleanif">booleanif</link></literal> statements.</para></listitem>
-         </itemizedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(roleallow current_role_id new_role_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>roleallow</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roleallow</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>current_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>new_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="roletransition">roletransition</link></literal> statement for an example.</para>
-      </sect2>
-
-      <sect2 id="roletransition">
-         <title>roletransition</title>
-         <para>Specify a role transition from the current role to a new role when computing a context for the target type. The <literal><link linkend="class">class</link></literal> identifier would normally be <literal>process</literal>, however for kernel versions 2.6.39 with policy version >= 25 and above, any valid class may be used. Note that a <literal><link linkend="roleallow">roleallow</link></literal> rule must be used to authorise the transition.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(roletransition current_role_id target_type_id class_id new_role_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>roletransition</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>roletransition</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>current_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>new_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> identifier to be set on transition.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will authorise the <literal>unconfined.role</literal> to assume the <literal>msg_filter.role</literal> role, and then transition to that role:</para>
-         <programlisting><![CDATA[
-(block ext_gateway
-    (type process)
-    (type exec)
-
-    (roletype msg_filter.role process)
-    (roleallow unconfined.role msg_filter.role)
-    (roletransition unconfined.role exec process msg_filter.role)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="rolebounds">
-         <title>rolebounds</title>
-         <para>Defines a hierarchical relationship between roles where the child role cannot have more privileges than the parent.</para>
-         <para>Notes:</para>
-         <itemizedlist>
-            <listitem><para>It is not possible to bind the parent role to more than one child role.</para></listitem>
-            <listitem><para>While this is added to the binary policy, it is not enforced by the SELinux kernel services.</para></listitem>
-         </itemizedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(rolebounds parent_role_id child_role_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>rolebounds</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>rolebounds</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>parent_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>child_role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="role">role</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>In this example the role <literal>test</literal> cannot have greater priviledges than <literal>unconfined.role</literal>:</para>
-         <programlisting><![CDATA[
-(role test)
-
-(unconfined
-    (role role)
-    (rolebounds role .test)
-)]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_sid_statements.md b/secilc/docs/cil_sid_statements.md
new file mode 100644
index 0000000..a9b2537
--- /dev/null
+++ b/secilc/docs/cil_sid_statements.md
@@ -0,0 +1,125 @@
+SID Statements
+==============
+
+sid
+---
+
+Declares a new SID identifier in the current namespace.
+
+**Statement definition:**
+
+    (sid sid_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sid</code></p></td>
+<td align="left"><p>The <code>sid</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sid_id</code></p></td>
+<td align="left"><p>The <code>sid</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+These examples show three [`sid`](cil_sid_statements.md#sid) declarations:
+
+    (sid kernel)
+    (sid security)
+    (sid igmp_packet)
+
+sidorder
+--------
+
+Defines the order of [sid](#sid)'s. This is a mandatory statement when SIDs are defined. Multiple [`sidorder`](cil_sid_statements.md#sidorder) statements declared in the policy will form an ordered list.
+
+**Statement definition:**
+
+    (sidorder (sid_id ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sidorder</code></p></td>
+<td align="left"><p>The <code>sidorder</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sid_id</code></p></td>
+<td align="left"><p>One or more <code>sid</code> identifiers.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This will produce an ordered list of "`kernel security unlabeled`"
+
+    (sid kernel)
+    (sid security)
+    (sid unlabeled)
+    (sidorder (kernel security))
+    (sidorder (security unlabeled))
+
+sidcontext
+----------
+
+Associates an SELinux security [context](#context) to a previously declared [`sid`](cil_sid_statements.md#sid) identifier.
+
+**Statement definition:**
+
+    (sidcontext sid_id context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>sidcontext</code></p></td>
+<td align="left"><p>The <code>sidcontext</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>sid_id</code></p></td>
+<td align="left"><p>A single previously declared <code>sid</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This shows two named security context examples plus an anonymous context:
+
+    ; Two named context:
+    (sid kernel)
+    (context kernel_context (u r process low_low))
+    (sidcontext kernel kernel_context)
+
+    (sid security)
+    (context security_context (u object_r process low_low))
+    (sidcontext security security_context)
+
+    ; An anonymous context:
+    (sid unlabeled)
+    (sidcontext unlabeled (u object_r ((s0) (s0))))
diff --git a/secilc/docs/cil_sid_statements.xml b/secilc/docs/cil_sid_statements.xml
deleted file mode 100644
index c0ca3ff..0000000
--- a/secilc/docs/cil_sid_statements.xml
+++ /dev/null
@@ -1,142 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- sid_statements.xml -->
-
-   <sect1>
-      <title>SID Statements</title>
-      <sect2 id="sid">
-         <title>sid</title>
-         <para>Declares a new SID identifier in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sid sid_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sid</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sid</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sid_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sid</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>These examples show three <literal>sid</literal> declarations:</para>
-            <programlisting><![CDATA[
-(sid kernel)
-(sid security)
-(sid igmp_packet)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="sidorder">
-         <title>sidorder</title>
-         <para>Defines the order of <link linkend="sid">sid</link>'s. This is a mandatory statement when SIDs are defined. Multiple <literal>sidorder</literal> statements declared in the policy will form an ordered list.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sidorder (sid_id ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sidorder</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sidorder</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sid_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>One or more <literal><link linkend="sid">sid</link></literal> identifiers.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will produce an ordered list of "<literal>kernel security unlabeled</literal>"</para>
-         <programlisting><![CDATA[
-(sid kernel)
-(sid security)
-(sid unlabeled)
-(sidorder (kernel security))
-(sidorder (security unlabeled))]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="sidcontext">
-         <title>sidcontext</title>
-         <para>Associates an SELinux security <link linkend="context">context</link> to a previously declared <literal><link linkend="sid">sid</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(sidcontext sid_id context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>sidcontext</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>sidcontext</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>sid_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="sid">sid</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This shows two named security context examples plus an anonymous context:</para>
-         <programlisting><![CDATA[
-; Two named context:
-(sid kernel)
-(context kernel_context (u r process low_low))
-(sidcontext kernel kernel_context)
-
-(sid security)
-(context security_context (u object_r process low_low))
-(sidcontext security security_context)
-
-; An anonymous context:
-(sid unlabeled)
-(sidcontext unlabeled (u object_r ((s0) (s0))))]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
new file mode 100644
index 0000000..f9dd3a7
--- /dev/null
+++ b/secilc/docs/cil_type_statements.md
@@ -0,0 +1,502 @@
+Type Statements
+===============
+
+type
+----
+
+Declares a type identifier in the current namespace.
+
+**Statement definition:**
+
+    (type type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>type</code></p></td>
+<td align="left"><p>The <code>type</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>type_id</code></p></td>
+<td align="left"><p>The <code>type</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares a type identifier `bluetooth.process`:
+
+    (block bluetooth
+        (type process)
+    )
+
+typealias
+---------
+
+Declares a type alias in the current namespace.
+
+**Statement definition:**
+
+    (typealias typealias_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typealias</code></p></td>
+<td align="left"><p>The <code>typealias</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typealias_id</code></p></td>
+<td align="left"><p>The <code>typealias</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+See the [`typealiasactual`](cil_type_statements.md#typealiasactual) statement for an example that associates the [`typealias`](cil_type_statements.md#typealias) identifier.
+
+typealiasactual
+---------------
+
+Associates a previously declared [`typealias`](cil_type_statements.md#typealias) identifier to a previously declared [`type`](cil_type_statements.md#type) identifier.
+
+**Statement definition:**
+
+    (typealiasactual typealias_id type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typealiasactual</code></p></td>
+<td align="left"><p>The <code>typealiasactual</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typealias_id</code></p></td>
+<td align="left"><p>A single previously declared <code>typealias</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will alias `unconfined.process` as `unconfined_t` in the global namespace:
+
+    (typealias unconfined_t)
+    (typealiasactual unconfined_t unconfined.process)
+
+    (block unconfined
+        (type process)
+    )
+
+typeattribute
+-------------
+
+Declares a type attribute identifier in the current namespace. The identifier may have zero or more [`type`](cil_type_statements.md#type), [`typealias`](cil_type_statements.md#typealias) and [`typeattribute`](cil_type_statements.md#typeattribute) identifiers associated to it via the [`typeattributeset`](cil_type_statements.md#typeattributeset) statement.
+
+**Statement definition:**
+
+    (typeattribute typeattribute_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typeattribute</code></p></td>
+<td align="left"><p>The <code>typeattribute</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typeattribute_id</code></p></td>
+<td align="left"><p>The <code>typeattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example declares a type attribute `domain` in global namespace that will have an empty set:
+
+    (typeattribute domain)
+
+typeattributeset
+----------------
+
+Allows the association of one or more previously declared [`type`](cil_type_statements.md#type), [`typealias`](cil_type_statements.md#typealias) or [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to a [`typeattribute`](cil_type_statements.md#typeattribute) identifier. Expressions may be used to refine the associations as shown in the examples.
+
+**Statement definition:**
+
+    (typeattributeset typeattribute_id (type_id ... | expr ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typeattributeset</code></p></td>
+<td align="left"><p>The <code>typeattributeset</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typeattribute_id</code></p></td>
+<td align="left"><p>A single previously declared <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>type_id</code></p></td>
+<td align="left"><p>Zero or more previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifiers.</p>
+<p>Note that there must be at least one <code>type_id</code> or <code>expr</code> parameter declared.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (type_id ...) (type_id ...))</code></p>
+<p><code>    (or  (type_id ...) (type_id ...))</code></p>
+<p><code>    (xor (type_id ...) (type_id ...))</code></p>
+<p><code>    (not (type_id ...))</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example will take all the policy types and exclude those in `appdomain`. It is equivalent to `~appdomain` in the kernel policy language.
+
+    (typeattribute not_in_appdomain)
+
+    (typeattributeset not_in_appdomain (not (appdomain)))
+
+This example is equivalent to `{ domain -kernel.process -ueventd.process -init.process }` in the kernel policy language:
+
+    (typeattribute na_kernel_or_ueventd_or_init_in_domain)
+
+    (typeattributeset na_kernel_or_ueventd_or_init_in_domain
+        (and
+            (and
+                (and
+                    (domain)
+                    (not (kernel.process))
+                )
+                (not (ueventd.process))
+            )
+            (not (init.process))
+        )
+    )
+
+typebounds
+----------
+
+This defines a hierarchical relationship between domains where the bounded domain cannot have more permissions than its bounding domain (the parent).
+
+Requires kernel 2.6.28 and above to control the security context associated to threads in multi-threaded applications. Note that an [`allow`](cil_access_vector_rules.md#allow) rule must be used to authorise the bounding.
+
+**Statement definition:**
+
+    (typebounds parent_type_id child_type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typebounds</code></p></td>
+<td align="left"><p>The <code>typebounds</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>parent_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier that is the parent domain.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>child_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier that is the bound (child) domain.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+In this example the `httpd.child.process` cannot have `file (write)` due to lack of permissions on `httpd.process` which is the parent. It means the child domain will always have equal or less privileges than the parent:
+
+    (class file (getattr read write))
+
+    (block httpd
+        (type process)
+        (type object)
+
+        (typebounds process child.process)
+        ; The parent is allowed file 'getattr' and 'read':
+        (allow process object (file (getattr read)))
+
+        (block child
+            (type process)
+            (type object)
+
+            ; However the child process has been given 'write' access that will be denied.
+            (allow process httpd.object (file (read write)))
+        )
+    )
+
+typechange
+----------
+
+The type change rule is used to define a different label of an object for userspace SELinux-aware applications. These applications would use **`security_compute_relabel`**`(3)` and [`typechange`](cil_type_statements.md#typechange) rules in the policy to determine the new context to be applied. Note that an [`allow`](cil_access_vector_rules.md#allow) rule must be used to authorise the change.
+
+**Statement definition:**
+
+    (typechange source_type_id target_type_id class_id change_type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typechange</code></p></td>
+<td align="left"><p>The <code>typechange</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>change_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier that will become the new type.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+Whenever **`security_compute_relabel`**`(3)` is called with the following parameters:
+
+`    scon=unconfined.object tcon=unconfined.object class=file`
+
+the function will return a context of:
+
+`    unconfined.object:object_r:unconfined.change_label:s0`
+
+    (class file (getattr read write))
+
+    (block unconfined
+        (type process)
+        (type object)
+        (type change_label)
+
+        (typechange object object file change_label)
+    )
+
+typemember
+----------
+
+The type member rule is used to define a new polyinstantiated label of an object for SELinux-aware applications. These applications would use **`avc_compute_member`**`(3)` or **`security_compute_member`**`(3)` with the [`typemember`](cil_type_statements.md#typemember) rules in the policy to determine the context to be applied. The application would then manage any required polyinstantiation. Note that an [`allow`](cil_access_vector_rules.md#allow) rule must be used to authorise the membership.
+
+**Statement definition:**
+
+    (typemember source_type_id target_type_id class_id member_type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typemember</code></p></td>
+<td align="left"><p>The <code>typemember</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>member_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier that will become the new member type.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+Whenever **`avc_compute_member`**`(3)` or **`security_compute_member`**`(3)` is called with the following parameters:
+
+`    scon=unconfined.object tcon=unconfined.object class=file`
+
+the function will return a context of:
+
+`    unconfined.object:object_r:unconfined.member_label:s0`
+
+    (class file (getattr read write))
+
+    (block unconfined
+        (type process)
+        (type object)
+        (type change_label)
+
+        (typemember object object file member_label)
+    )
+
+typetransition
+--------------
+
+The type transition rule specifies the labeling and object creation allowed between the `source_type` and `target`\_type when a domain transition is requested. Kernels from 2.6.39 with policy versions from 25 and above also support a 'name transition' rule, however this is not allowed inside conditionals and currently only supports the file classes. Note that an [`allow`](cil_access_vector_rules.md#allow) rule must be used to authorise the transition.
+
+**Statement definition:**
+
+    (typetransition source_type_id target_type_id class_id [object_name] default_type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typetransition</code></p></td>
+<td align="left"><p>The <code>typetransition</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>target_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>class_id</code></p></td>
+<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>object_name</code></p></td>
+<td align="left"><p>A optional string within double quotes representing an object name for the 'name transition' rule. This string will be matched against the objects name (if a path then the last component of that path). If the string matches exactly, the <code>default_type_id</code> will then become the new type.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>default_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier that will become the new type.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example shows a process transition rule with its supporting [`allow`](cil_access_vector_rules.md#allow) rule:
+
+    (macro domain_auto_trans ((type ARG1) (type ARG2) (type ARG3))
+        ; Allow the necessary permissions.
+        (call domain_trans (ARG1 ARG2 ARG3))
+        ; Make the transition occur by default.
+        (typetransition ARG1 ARG2 process ARG3)
+    )
+
+This example shows a file object transition rule with its supporting [`allow`](cil_access_vector_rules.md#allow) rule:
+
+    (macro tmpfs_domain ((type ARG1))
+        (type tmpfs)
+        (typeattributeset file_type (tmpfs))
+        (typetransition ARG1 file.tmpfs file tmpfs)
+        (allow ARG1 tmpfs (file (read write execute execmod)))
+    )
+
+This example shows the 'name transition' rule with its supporting [`allow`](cil_access_vector_rules.md#allow) rule:
+
+    (macro write_klog ((type ARG1))
+        (typetransition ARG1 device.device chr_file "__kmsg__" device.klog_device)
+        (allow ARG1 device.klog_device (chr_file (create open write unlink)))
+        (allow ARG1 device.device (dir (write add_name remove_name)))
+    )
+
+typepermissive
+--------------
+
+Policy database version 23 introduced the permissive statement to allow the named domain to run in permissive mode instead of running all SELinux domains in permissive mode (that was the only option prior to version 23). Note that the permissive statement only tests the source context for any policy denial.
+
+**Statement definition:**
+
+    (typepermissive source_type_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>typepermissive</code></p></td>
+<td align="left"><p>The <code>typepermissive</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>source_type_id</code></p></td>
+<td align="left"><p>A single previously declared <code>type</code> or <code>typealias</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will allow SELinux to run the `healthd.process` domain in permissive mode even when enforcing is enabled:
+
+    (block healthd
+        (type process)
+        (typepermissive process)
+
+        (allow ...)
+    )
diff --git a/secilc/docs/cil_type_statements.xml b/secilc/docs/cil_type_statements.xml
deleted file mode 100644
index b140f86..0000000
--- a/secilc/docs/cil_type_statements.xml
+++ /dev/null
@@ -1,581 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- type_statements.xml -->
-
-   <sect1>
-      <title>Type Statements</title>
-      <sect2 id="type">
-         <title>type</title>
-         <para>Declares a type identifier in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(type type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>type</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>type</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>type</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares a type identifier <literal>bluetooth.process</literal>:</para>
-         <programlisting><![CDATA[
-(block bluetooth
-    (type process)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typealias">
-         <title>typealias</title>
-         <para>Declares a type alias in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typealias typealias_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typealias</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typealias</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>typealias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typealias</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>See the <literal><link linkend="typealiasactual">typealiasactual</link></literal> statement for an example that associates the <literal><link linkend="typealias">typealias</link></literal> identifier.</para>
-      </sect2>
-
-      <sect2 id="typealiasactual">
-         <title>typealiasactual</title>
-         <para>Associates a previously declared <literal><link linkend="typealias">typealias</link></literal> identifier to a previously declared <literal><link linkend="type">type</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typealiasactual typealias_id type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typealiasactual</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typealiasactual</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>typealias_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="typealias">typealias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will alias <literal>unconfined.process</literal> as <literal>unconfined_t</literal> in the global namespace:</para>
-         <programlisting><![CDATA[
-(typealias unconfined_t)
-(typealiasactual unconfined_t unconfined.process)
-
-(block unconfined
-    (type process)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typeattribute">
-         <title>typeattribute</title>
-         <para>Declares a type attribute identifier in the current namespace. The identifier may have zero or more <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> and <literal><link linkend="typeattribute">typeattribute</link></literal> identifiers associated to it via the <literal><link linkend="typeattributeset">typeattributeset</link></literal> statement.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typeattribute typeattribute_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typeattribute</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typeattribute</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>typeattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example declares a type attribute <literal>domain</literal> in global namespace that will have an empty set:</para>
-         <programlisting><![CDATA[(typeattribute domain)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typeattributeset">
-         <title>typeattributeset</title>
-         <para>Allows the association of one or more previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifiers to a <literal><link linkend="typeattribute">typeattribute</link></literal> identifier. Expressions may be used to refine the associations as shown in the examples.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typeattributeset typeattribute_id (type_id ... | expr ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typeattributeset</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typeattributeset</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>typeattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifiers.</para>
-                     <para>Note that there must be at least one <literal>type_id</literal> or <literal>expr</literal> parameter declared.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (type_id ...) (type_id ...))</literal></simpara>
-                     <simpara><literal>    (or  (type_id ...) (type_id ...))</literal></simpara>
-                     <simpara><literal>    (xor (type_id ...) (type_id ...))</literal></simpara>
-                     <simpara><literal>    (not (type_id ...))</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example will take all the policy types and exclude those in <literal>appdomain</literal>. It is equivalent to <literal>~appdomain</literal> in the kernel policy language.</para>
-         <programlisting><![CDATA[
-(typeattribute not_in_appdomain)
-
-(typeattributeset not_in_appdomain (not (appdomain)))]]>
-         </programlisting>
-         <para>This example is equivalent to <literal>{ domain -kernel.process -ueventd.process -init.process }</literal> in the kernel policy language:</para>
-         <programlisting><![CDATA[
-(typeattribute na_kernel_or_ueventd_or_init_in_domain)
-
-(typeattributeset na_kernel_or_ueventd_or_init_in_domain
-    (and
-        (and
-            (and
-                (domain)
-                (not (kernel.process))
-            )
-            (not (ueventd.process))
-        )
-        (not (init.process))
-    )
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typebounds">
-         <title>typebounds</title>
-         <para>This defines a hierarchical relationship between domains where the bounded domain cannot have more permissions than its bounding domain (the parent).</para>
-         <para>Requires kernel 2.6.28 and above to control the security context associated to threads in multi-threaded applications. Note that an <literal><link linkend="allow">allow</link></literal> rule must be used to authorise the bounding.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typebounds parent_type_id child_type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typebounds</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typebounds</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>parent_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier that is the parent domain.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>child_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier that is the bound (child) domain.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>In this example the <literal>httpd.child.process</literal> cannot have <literal>file (write)</literal> due to lack of permissions on <literal>httpd.process</literal> which is the parent. It means the child domain will always have equal or less privileges than the parent:</para>
-         <programlisting><![CDATA[
-(class file (getattr read write))
-
-(block httpd
-    (type process)
-    (type object)
-
-    (typebounds process child.process)
-    ; The parent is allowed file 'getattr' and 'read':
-    (allow process object (file (getattr read)))
-
-    (block child
-        (type process)
-        (type object)
-
-        ; However the child process has been given 'write' access that will be denied.
-        (allow process httpd.object (file (read write)))
-    )
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typechange">
-         <title>typechange</title>
-         <para>The type change rule is used to define a different label of an object for userspace SELinux-aware applications. These applications would use <emphasis role="bold"><literal>security_compute_relabel</literal></emphasis><literal>(3)</literal> and <literal>typechange</literal> rules in the policy to determine the new context to be applied. Note that an <literal><link linkend="allow">allow</link></literal> rule must be used to authorise the change.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typechange source_type_id target_type_id class_id change_type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typechange</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typechange</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>change_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier that will become the new type.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>Whenever <emphasis role="bold"><literal>security_compute_relabel</literal></emphasis><literal>(3)</literal> is called with the following parameters:</para>
-         <simpara><literal>    scon=unconfined.object tcon=unconfined.object class=file</literal></simpara>
-         <simpara>the function will return a context of:</simpara>
-         <simpara><literal>    unconfined.object:object_r:unconfined.change_label:s0</literal></simpara>
-         <programlisting><![CDATA[
-(class file (getattr read write))
-
-(block unconfined
-    (type process)
-    (type object)
-    (type change_label)
-
-    (typechange object object file change_label)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typemember">
-         <title>typemember</title>
-         <para>The type member rule is used to define a new polyinstantiated label of an object for SELinux-aware applications. These applications would use <emphasis role="bold"><literal>avc_compute_member</literal></emphasis><literal>(3)</literal> or <emphasis role="bold"><literal>security_compute_member</literal></emphasis><literal>(3)</literal> with the <literal>typemember</literal> rules in the policy to determine the context to be applied. The application would then manage any required polyinstantiation. Note that an <literal><link linkend="allow">allow</link></literal> rule must be used to authorise the membership.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typemember source_type_id target_type_id class_id member_type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typemember</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typemember</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>member_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier that will become the new member type.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>Whenever <emphasis role="bold"><literal>avc_compute_member</literal></emphasis><literal>(3)</literal> or <emphasis role="bold"><literal>security_compute_member</literal></emphasis><literal>(3)</literal> is called with the following parameters:</para>
-         <simpara><literal>    scon=unconfined.object tcon=unconfined.object class=file</literal></simpara>
-         <simpara>the function will return a context of:</simpara>
-         <simpara><literal>    unconfined.object:object_r:unconfined.member_label:s0</literal></simpara>
-         <programlisting><![CDATA[
-(class file (getattr read write))
-
-(block unconfined
-    (type process)
-    (type object)
-    (type change_label)
-
-    (typemember object object file member_label)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="typetransition">
-         <title>typetransition</title>
-         <para>The type transition rule specifies the labeling and object creation allowed between the <literal>source_type</literal> and <literal>target</literal>_type when a domain transition is requested. Kernels from 2.6.39 with policy versions from 25 and above also support a 'name transition' rule, however this is not allowed inside conditionals and currently only supports the file classes. Note that an <literal><link linkend="allow">allow</link></literal> rule must be used to authorise the transition.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typetransition source_type_id target_type_id class_id [object_name] default_type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typetransition</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typetransition</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>target_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal>, <literal><link linkend="typealias">typealias</link></literal> or <literal><link linkend="typeattribute">typeattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>class_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="class">class</link></literal> or <literal><link linkend="classmap">classmap</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>object_name</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A optional string within double quotes representing an object name for the 'name transition' rule. This string will be matched against the objects name (if a path then the last component of that path). If the string matches exactly, the <literal>default_type_id</literal> will then become the new type.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>default_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier that will become the new type.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Examples:</emphasis></para>
-         <para>This example shows a process transition rule with its supporting <literal><link linkend="allow">allow</link></literal> rule:</para>
-         <programlisting><![CDATA[
-(macro domain_auto_trans ((type ARG1) (type ARG2) (type ARG3))
-    ; Allow the necessary permissions.
-    (call domain_trans (ARG1 ARG2 ARG3))
-    ; Make the transition occur by default.
-    (typetransition ARG1 ARG2 process ARG3)
-)]]>
-         </programlisting>
-
-         <para>This example shows a file object transition rule with its supporting <literal><link linkend="allow">allow</link></literal> rule:</para>
-         <programlisting><![CDATA[
-(macro tmpfs_domain ((type ARG1))
-    (type tmpfs)
-    (typeattributeset file_type (tmpfs))
-    (typetransition ARG1 file.tmpfs file tmpfs)
-    (allow ARG1 tmpfs (file (read write execute execmod)))
-)]]>
-         </programlisting>
-
-         <para>This example shows the 'name transition' rule with its supporting <literal><link linkend="allow">allow</link></literal> rule:</para>
-         <programlisting><![CDATA[
-(macro write_klog ((type ARG1))
-    (typetransition ARG1 device.device chr_file "__kmsg__" device.klog_device)
-    (allow ARG1 device.klog_device (chr_file (create open write unlink)))
-    (allow ARG1 device.device (dir (write add_name remove_name)))
-)]]>
-         </programlisting>
-
-      </sect2>
-
-      <sect2 id="typepermissive">
-         <title>typepermissive</title>
-         <para>Policy database version 23 introduced the permissive statement to allow the named domain to run in permissive mode instead of running all SELinux domains in permissive mode (that was the only option prior to version 23). Note that the permissive statement only tests the source context for any policy denial.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(typepermissive source_type_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>typepermissive</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>typepermissive</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>source_type_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="type">type</link></literal> or <literal><link linkend="typealias">typealias</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will allow SELinux to run the <literal>healthd.process</literal> domain in permissive mode even when enforcing is enabled:</para>
-         <programlisting><![CDATA[
-(block healthd
-    (type process)
-    (typepermissive process)
-
-    (allow ...)
-)]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
new file mode 100644
index 0000000..4075187
--- /dev/null
+++ b/secilc/docs/cil_user_statements.md
@@ -0,0 +1,455 @@
+User Statements
+===============
+
+user
+----
+
+Declares an SELinux user identifier in the current namespace.
+
+**Statement definition:**
+
+    (user user_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>user</code></p></td>
+<td align="left"><p>The <code>user</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>The SELinux <code>user</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This will declare an SELinux user as `unconfined.user`:
+
+    (block unconfined
+        (user user)
+    )
+
+userrole
+--------
+
+Associates a previously declared [`user`](cil_user_statements.md#user) identifier with a previously declared [`role`](cil_role_statements.md#role) identifier.
+
+**Statement definition:**
+
+    (userrole user_id role_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userrole</code></p></td>
+<td align="left"><p>The <code>userrole</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> or <code>userattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>role_id</code></p></td>
+<td align="left"><p>A previously declared <code>role</code> or <code>roleattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate `unconfined.user` to `unconfined.role`:
+
+    (block unconfined
+        (user user)
+        (role role)
+        (userrole user role)
+    )
+
+userattribute
+-------------
+
+Declares a user attribute identifier in the current namespace. The identifier may have zero or more [`user`](cil_user_statements.md#user) and [`userattribute`](cil_user_statements.md#userattribute) identifiers associated to it via the [`userattributeset`](cil_user_statements.md#userattributeset) statement.
+
+**Statement definition:**
+
+    (userattribute userattribute_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userattribute</code></p></td>
+<td align="left"><p>The <code>userattribute</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>userattribute_id</code></p></td>
+<td align="left"><p>The <code>userattribute</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will declare a user attribute `users.user_holder` that will have an empty set:
+
+    (block users
+        (userattribute user_holder)
+    )
+
+userattributeset
+----------------
+
+Allows the association of one or more previously declared [`user`](cil_user_statements.md#user) or [`userattribute`](cil_user_statements.md#userattribute) identifiers to a [`userattribute`](cil_user_statements.md#userattribute) identifier. Expressions may be used to refine the associations as shown in the examples.
+
+**Statement definition:**
+
+    (userattributeset userattribute_id (user_id ... | expr ...))
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userattributeset</code></p></td>
+<td align="left"><p>The <code>userattributeset</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>userattribute_id</code></p></td>
+<td align="left"><p>A single previously declared <code>userattribute</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>Zero or more previously declared <code>user</code> or <code>userattribute</code> identifiers.</p>
+<p>Note that there must be at least one <code>user_id</code> or <code>expr</code> parameter declared.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>expr</code></p></td>
+<td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
+<p><code>    (and (user_id ...) (user_id ...))</code></p>
+<p><code>    (or  (user_id ...) (user_id ...))</code></p>
+<p><code>    (xor (user_id ...) (user_id ...))</code></p>
+<p><code>    (not (user_id ...))</code></p>
+<p><code>    (all)</code></p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will declare three users and two user attributes, then associate all the users to them as shown:
+
+    (block users
+        (user user_1)
+        (user user_2)
+        (user user_3)
+
+        (userattribute user_holder)
+        (userattributeset user_holder (user_1 user_2 user_3))
+
+        (userattribute user_holder_all)
+        (userattributeset user_holder_all (all))
+    )
+
+userlevel
+---------
+
+Associates a previously declared [`user`](cil_user_statements.md#user) identifier with a previously declared [`level`](cil_mls_labeling_statements.md#level) identifier. The [`level`](cil_mls_labeling_statements.md#level) may be named or anonymous.
+
+**Statement definition:**
+
+    (userlevel user_id level_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userlevel</code></p></td>
+<td align="left"><p>The <code>userlevel</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>level_id</code></p></td>
+<td align="left"><p>A previously declared <code>level</code> identifier. This may consist of a single <code>sensitivity</code> with zero or more mixed named and anonymous <code>category</code>'s as discussed in the <code>level</code> statement.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate `unconfined.user` with a named [`level`](cil_mls_labeling_statements.md#level) of `systemlow`:
+
+    (sensitivity s0)
+    (level systemlow (s0))
+
+    (block unconfined
+        (user user)
+         (userlevel user systemlow)
+        ; An anonymous example:
+        ;(userlevel user (s0))
+    )
+
+userrange
+---------
+
+Associates a previously declared [`user`](cil_user_statements.md#user) identifer with a previously declared [`levelrange`](cil_mls_labeling_statements.md#levelrange) identifier. The [`levelrange`](cil_mls_labeling_statements.md#levelrange) may be named or anonymous.
+
+**Statement definition:**
+
+    (userrange user_id levelrange_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userrange</code></p></td>
+<td align="left"><p>The <code>userrange</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>levelrange_id</code></p></td>
+<td align="left"><p>A previously declared <code>levelrange</code> identifier. This may be formed by named or anonymous components as discussed in the <code>levelrange</code> statement and shown in the examples.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate `unconfined.user` with a named [`levelrange`](cil_mls_labeling_statements.md#levelrange) of `low_high`, other anonymous examples are also shown:
+
+    (category c0)
+    (category c1)
+    (categoryorder (c0 c1))
+    (sensitivity s0)
+    (sensitivity s1)
+    (dominance (s0 s1))
+    (sensitivitycategory s0 (c0 c1))
+    (level systemLow (s0))
+    (level systemHigh (s0 (c0 c1)))
+    (levelrange low_high (systemLow systemHigh))
+
+    (block unconfined
+        (user user)
+        (role role)
+        (userrole user role)
+        ; Named example:
+        (userrange user low_high)
+        ; Anonymous examples:
+        ;(userrange user (systemLow systemHigh))
+        ;(userrange user (systemLow (s0 (c0 c1))))
+        ;(userrange user ((s0) (s0 (c0 c1))))
+    )
+
+userbounds
+----------
+
+Defines a hierarchical relationship between users where the child user cannot have more priviledges than the parent.
+
+Notes:
+
+-   It is not possible to bind the parent to more than one child.
+
+-   While this is added to the binary policy, it is not enforced by the SELinux kernel services.
+
+**Statement definition:**
+
+    (userbounds parent_user_id child_user_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userbounds</code></p></td>
+<td align="left"><p>The <code>userbounds</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>parent_user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>child_user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+The user `test` cannot have greater priviledges than `unconfined.user`:
+
+    (user test)
+
+    (unconfined
+        (user user)
+        (userbounds user .test)
+    )
+
+userprefix
+----------
+
+Declare a user prefix that will be replaced by the file labeling utilities described at [http://selinuxproject.org/page/PolicyStoreConfigurationFiles](http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_contexts.template_File) that details the `file_contexts` entries.
+
+**Statement definition:**
+
+    (userprefix user_id prefix)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>userprefix</code></p></td>
+<td align="left"><p>The <code>userprefix</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>prefix</code></p></td>
+<td align="left"><p>The string to be used by the file labeling utilities.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate `unconfined.admin` user with a prefix of "[`user`](cil_user_statements.md#user)":
+
+    (block unconfined
+        (user admin
+        (userprefix admin user)
+    )
+
+selinuxuser
+-----------
+
+Associates a GNU/Linux user to a previously declared [`user`](cil_user_statements.md#user) identifier with a previously declared MLS [`userrange`](cil_user_statements.md#userrange). Note that the [`userrange`](cil_user_statements.md#userrange) is required even if the policy is non-MCS/MLS.
+
+**Statement definition:**
+
+    (selinuxuser user_name user_id userrange_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>selinuxuser</code></p></td>
+<td align="left"><p>The <code>selinuxuser</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_name</code></p></td>
+<td align="left"><p>A string representing the GNU/Linux user name</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>userrange_id</code></p></td>
+<td align="left"><p>A previously declared <code>userrange</code> identifier that has been associated to the <code>user</code> identifier. This may be formed by named or anonymous components as discussed in the <code>userrange</code> statement and shown in the examples.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will associate `unconfined.admin` user with a GNU / Linux user "`admin_1`":
+
+    (block unconfined
+        (user admin)
+        (selinuxuser admin_1 admin low_low)
+    )
+
+selinuxuserdefault
+------------------
+
+Declares the default SELinux user. Only one [`selinuxuserdefault`](cil_user_statements.md#selinuxuserdefault) statement is allowed in the policy. Note that the [`userrange`](cil_user_statements.md#userrange) identifier is required even if the policy is non-MCS/MLS.
+
+**Statement definition:**
+
+    (selinuxuserdefault user_id userrange_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>selinuxuserdefault</code></p></td>
+<td align="left"><p>The <code>selinuxuserdefault</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>user_id</code></p></td>
+<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>userrange_id</code></p></td>
+<td align="left"><p>A previously declared <code>userrange</code> identifier that has been associated to the <code>user</code> identifier. This may be formed by named or anonymous components as discussed in the <code>userrange</code> statement and shown in the examples.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will define the `unconfined.user` as the default SELinux user:
+
+    (block unconfined
+        (user user)
+        (selinuxuserdefault user low_low)
+    )
diff --git a/secilc/docs/cil_user_statements.xml b/secilc/docs/cil_user_statements.xml
deleted file mode 100644
index 38a7d6e..0000000
--- a/secilc/docs/cil_user_statements.xml
+++ /dev/null
@@ -1,528 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-              <!-- user_statements.xml -->
-
-   <sect1>
-      <title>User Statements</title>
-      <sect2 id="user">
-         <title>user</title>
-         <para>Declares an SELinux user identifier in the current namespace.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(user user_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>user</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>user</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The SELinux <literal>user</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This will declare an SELinux user as <literal>unconfined.user</literal>:</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (user user)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="userrole">
-         <title>userrole</title>
-         <para>Associates a previously declared <literal><link linkend="user">user</link></literal> identifier with a previously declared <literal><link linkend="role">role</link></literal> identifier.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userrole user_id role_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userrole</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userrole</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>role_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="role">role</link></literal> or <literal><link linkend="roleattribute">roleattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate <literal>unconfined.user</literal> to <literal>unconfined.role</literal>:</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (user user)
-    (role role)
-    (userrole user role)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="userattribute">
-         <title>userattribute</title>
-         <para>Declares a user attribute identifier in the current namespace. The identifier may have zero or more <literal><link linkend="user">user</link></literal> and <literal><link linkend="userattribute">userattribute</link></literal> identifiers associated to it via the <literal><link linkend="userattributeset">userattributeset</link></literal> statement.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userattribute userattribute_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userattribute</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userattribute</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>userattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userattribute</literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will declare a user attribute <literal>users.user_holder</literal> that will have an empty set:</para>
-         <programlisting><![CDATA[
-(block users
-    (userattribute user_holder)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="userattributeset">
-         <title>userattributeset</title>
-         <para>Allows the association of one or more previously declared <literal><link linkend="user">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifiers to a <literal><link linkend="userattribute">userattribute</link></literal> identifier. Expressions may be used to refine the associations as shown in the examples.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userattributeset userattribute_id (user_id ... | expr ...))]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userattributeset</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userattributeset</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>userattribute_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single previously declared <literal><link linkend="roleattribute">userattribute</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more previously declared <literal><link linkend="role">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifiers.</para>
-                     <para>Note that there must be at least one <literal>user_id</literal> or <literal>expr</literal> parameter declared.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>expr</literal></para>
-                  </entry>
-                  <entry>
-                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
-                     <simpara><literal>    (and (user_id ...) (user_id ...))</literal></simpara>
-                     <simpara><literal>    (or  (user_id ...) (user_id ...))</literal></simpara>
-                     <simpara><literal>    (xor (user_id ...) (user_id ...))</literal></simpara>
-                     <simpara><literal>    (not (user_id ...))</literal></simpara>
-                     <simpara><literal>    (all)</literal></simpara>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will declare three users and two user attributes, then associate all the users to them as shown:</para>
-         <programlisting><![CDATA[
-(block users
-    (user user_1)
-    (user user_2)
-    (user user_3)
-
-    (userattribute user_holder)
-    (userattributeset user_holder (user_1 user_2 user_3))
-
-    (userattribute user_holder_all)
-    (userattributeset user_holder_all (all))
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="userlevel">
-         <title>userlevel</title>
-         <para>Associates a previously declared <literal><link linkend="user">user</link></literal> identifier with a previously declared <literal><link linkend="level">level</link></literal> identifier. The <literal><link linkend="level">level</link></literal> may be named or anonymous.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userlevel user_id level_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userlevel</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userlevel</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>level_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="level">level</link></literal> identifier. This may consist of a single <literal><link linkend="sensitivity">sensitivity</link></literal> with zero or more mixed named and anonymous <literal><link linkend="category">category</link></literal>'s as discussed in the <literal><link linkend="level">level</link></literal> statement.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate <literal>unconfined.user</literal> with a named <literal><link linkend="level">level</link></literal> of <literal>systemlow</literal>:</para>
-         <programlisting><![CDATA[
-(sensitivity s0)
-(level systemlow (s0))
-
-(block unconfined
-    (user user)
-     (userlevel user systemlow)
-    ; An anonymous example:
-    ;(userlevel user (s0))
-)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="userrange">
-         <title>userrange</title>
-         <para>Associates a previously declared <literal><link linkend="user">user</link></literal> identifer with a previously declared <literal><link linkend="levelrange">levelrange</link></literal> identifier. The <literal><link linkend="levelrange">levelrange</link></literal> may be named or anonymous.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userrange user_id levelrange_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userrange</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userrange</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>levelrange_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="levelrange">levelrange</link></literal> identifier. This may be formed by named or anonymous components as discussed in the <literal><link linkend="levelrange">levelrange</link></literal> statement and shown in the examples.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate <literal>unconfined.user</literal> with a named <literal><link linkend="levelrange">levelrange</link></literal> of <literal>low_high</literal>, other anonymous examples are also shown:</para>
-         <programlisting><![CDATA[
-(category c0)
-(category c1)
-(categoryorder (c0 c1))
-(sensitivity s0)
-(sensitivity s1)
-(dominance (s0 s1))
-(sensitivitycategory s0 (c0 c1))
-(level systemLow (s0))
-(level systemHigh (s0 (c0 c1)))
-(levelrange low_high (systemLow systemHigh))
-
-(block unconfined
-    (user user)
-    (role role)
-    (userrole user role)
-    ; Named example:
-    (userrange user low_high)
-    ; Anonymous examples:
-    ;(userrange user (systemLow systemHigh))
-    ;(userrange user (systemLow (s0 (c0 c1))))
-    ;(userrange user ((s0) (s0 (c0 c1))))
-)]]>
-      </programlisting>
-      </sect2>
-
-      <sect2 id="userbounds">
-         <title>userbounds</title>
-         <para>Defines a hierarchical relationship between users where the child user cannot have more priviledges than the parent.</para>
-         <para>Notes:</para>
-         <itemizedlist>
-            <listitem><para>It is not possible to bind the parent to more than one child.</para></listitem>
-            <listitem><para>While this is added to the binary policy, it is not enforced by the SELinux kernel services.</para></listitem>
-         </itemizedlist>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userbounds parent_user_id child_user_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userbounds</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userbounds</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>parent_user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>child_user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>The user <literal>test</literal> cannot have greater priviledges than <literal>unconfined.user</literal>:</para>
-         <programlisting><![CDATA[
-(user test)
-
-(unconfined
-    (user user)
-    (userbounds user .test)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="userprefix">
-         <title>userprefix</title>
-         <para>Declare a user prefix that will be replaced by the file labeling utilities described at <ulink url="http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_contexts.template_File">http://selinuxproject.org/page/PolicyStoreConfigurationFiles</ulink> that details the <filename>file_contexts</filename> entries.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(userprefix user_id prefix)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>userprefix</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>userprefix</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>prefix</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The string to be used by the file labeling utilities.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate <literal>unconfined.admin</literal> user with a prefix of "<literal>user</literal>":</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (user admin
-    (userprefix admin user)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="selinuxuser">
-         <title>selinuxuser</title>
-         <para>Associates a GNU/Linux user to a previously declared <literal><link linkend="user">user</link></literal> identifier with a previously declared MLS <literal><link linkend="userrange">userrange</link></literal>. Note that the <literal><link linkend="userrange">userrange</link></literal> is required even if the policy is non-MCS/MLS.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(selinuxuser user_name user_id userrange_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>selinuxuser</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>selinuxuser</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_name</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A string representing the GNU/Linux user name</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>userrange_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="userrange">userrange</link></literal> identifier that has been associated to the <literal>user</literal> identifier. This may be formed by named or anonymous components as discussed in the <literal><link linkend="userrange">userrange</link></literal> statement and shown in the examples.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will associate <literal>unconfined.admin</literal> user with a GNU / Linux user "<literal>admin_1</literal>":</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (user admin)
-    (selinuxuser admin_1 admin low_low)
-)]]>
-         </programlisting>
-      </sect2>
-
-      <sect2 id="selinuxuserdefault">
-         <title>selinuxuserdefault</title>
-         <para>Declares the default SELinux user. Only one <literal>selinuxuserdefault</literal> statement is allowed in the policy. Note that the <literal><link linkend="userrange">userrange</link></literal> identifier is required even if the policy is non-MCS/MLS.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(selinuxuserdefault user_id userrange_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>selinuxuserdefault</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>selinuxuserdefault</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>user_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>userrange_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="userrange">userrange</link></literal> identifier that has been associated to the <literal><link linkend="user">user</link></literal> identifier. This may be formed by named or anonymous components as discussed in the <literal><link linkend="userrange">userrange</link></literal> statement and shown in the examples.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>This example will define the <literal>unconfined.user</literal> as the default SELinux user:</para>
-         <programlisting><![CDATA[
-(block unconfined
-    (user user)
-    (selinuxuserdefault user low_low)
-)]]>
-         </programlisting>
-      </sect2>
-
-   </sect1>
diff --git a/secilc/docs/cil_xen_statements.md b/secilc/docs/cil_xen_statements.md
new file mode 100644
index 0000000..5ae03e6
--- /dev/null
+++ b/secilc/docs/cil_xen_statements.md
@@ -0,0 +1,200 @@
+Xen Statements
+==============
+
+Policy version 30 introduced the [`devicetreecon`](cil_xen_statements.md#devicetreecon) statement and also expanded the existing I/O memory range to 64 bits in order to support hardware with more than 44 bits of physical address space (32-bit count of 4K pages).
+
+See the ["XSM/FLASK Configuration"](http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt) document for further information ([](http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt))
+
+iomemcon
+--------
+
+Label i/o memory. This may be a single memory location or a range.
+
+**Statement definition:**
+
+    (iomemcon mem_addr|(mem_low mem_high) context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>iomemcon</code></p></td>
+<td align="left"><p>The <code>iomemcon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>mem_addr |</code></p>
+<p><code>(mem_low mem_high)</code></p></td>
+<td align="left"><p>A single memory address to apply the context, or a range of addresses.</p>
+<p>The entries must consist of numerics <code>[0-9]</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An anonymous context for a memory address range of `0xfebe0-0xfebff`:
+
+    (iomemcon (1043424 1043455) (unconfined.user object_r unconfined.object low_low))
+
+ioportcon
+---------
+
+Label i/o ports. This may be a single port or a range.
+
+**Statement definition:**
+
+    (ioportcon port|(port_low port_high) context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>ioportcon</code></p></td>
+<td align="left"><p>The <code>ioportcon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>port |</code></p>
+<p><code>(port_low port_high)</code></p></td>
+<td align="left"><p>A single port to apply the context, or a range of ports.</p>
+<p>The entries must consist of numerics <code>[0-9]</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An anonymous context for a single port of :`0xecc0`:
+
+    (ioportcon 60608 (unconfined.user object_r unconfined.object low_low))
+
+pcidevicecon
+------------
+
+Label a PCI device.
+
+**Statement definition:**
+
+    (pcidevicecon device context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>pcidevicecon</code></p></td>
+<td align="left"><p>The <code>pcidevicecon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>device</code></p></td>
+<td align="left"><p>The device number.The entries must consist of numerics <code>[0-9]</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An anonymous context for a pci device address of `0xc800`:
+
+    (pcidevicecon 51200 (unconfined.user object_r unconfined.object low_low))
+
+pirqcon
+-------
+
+Label an interrupt level.
+
+**Statement definition:**
+
+    (pirqcon irq_level context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>pirqcon</code></p></td>
+<td align="left"><p>The <code>pirqcon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>irq_level</code></p></td>
+<td align="left"><p>The interrupt request number. The entries must consist of numerics <code>[0-9]</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An anonymous context for IRQ 33:
+
+    (pirqcon 33 (unconfined.user object_r unconfined.object low_low))
+
+devicetreecon
+-------------
+
+Label device tree nodes.
+
+**Statement definition:**
+
+    (devicetreecon path context_id)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>devicetreecon</code></p></td>
+<td align="left"><p>The <code>devicetreecon</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>path</code></p></td>
+<td align="left"><p>The device tree path. If this contains spaces enclose within <code>&quot;&quot;</code>.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>context_id</code></p></td>
+<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+An anonymous context for the specified path:
+
+    (devicetreecon "/this is/a/path" (unconfined.user object_r unconfined.object low_low))
diff --git a/secilc/docs/cil_xen_statements.xml b/secilc/docs/cil_xen_statements.xml
deleted file mode 100644
index c72ef6c..0000000
--- a/secilc/docs/cil_xen_statements.xml
+++ /dev/null
@@ -1,227 +0,0 @@
-<!-- Common Interface Language (CIL) Reference Guide -->
-           <!-- xen_statements.xml -->
-
-   <sect1>
-      <title>Xen Statements</title>
-      <para>Policy version 30 introduced the <literal><link linkend="devicetreecon">devicetreecon</link></literal> statement and also expanded the existing I/O memory range to 64 bits in order to support hardware with more than 44 bits of physical address space (32-bit count of 4K pages).</para>
-      <para>See the <ulink url="http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt">"XSM/FLASK Configuration"</ulink> document for further information (<ulink url="http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt"></ulink>)</para>
-      <sect2 id="iomemcon">
-         <title>iomemcon</title>
-         <para>Label i/o memory. This may be a single memory location or a range.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(iomemcon mem_addr|(mem_low mem_high) context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>iomemcon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>iomemcon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>mem_addr |</literal></para>
-                     <para><literal>(mem_low mem_high)</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single memory address to apply the context, or a range of addresses.</para>
-                     <para>The entries must consist of numerics <literal>[0-9]</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An anonymous context for a memory address range of <literal>0xfebe0-0xfebff</literal>:</para>
-         <programlisting><![CDATA[(iomemcon (1043424 1043455) (unconfined.user object_r unconfined.object low_low))]]></programlisting>
-      </sect2>
-
-      <sect2 id="ioportcon">
-         <title>ioportcon</title>
-         <para>Label i/o ports. This may be a single port or a range.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(ioportcon port|(port_low port_high) context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2.25 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>ioportcon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>ioportcon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>port |</literal></para>
-                     <para><literal>(port_low port_high)</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A single port to apply the context, or a range of ports.</para>
-                     <para>The entries must consist of numerics <literal>[0-9]</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An anonymous context for a single port of :<literal>0xecc0</literal>:</para>
-         <programlisting><![CDATA[(ioportcon 60608 (unconfined.user object_r unconfined.object low_low))]]></programlisting>
-      </sect2>
-
-      <sect2 id="pcidevicecon">
-         <title>pcidevicecon</title>
-         <para>Label a PCI device.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(pcidevicecon device context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>pcidevicecon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>pcidevicecon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>device</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The device number.The entries must consist of numerics <literal>[0-9]</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An anonymous context for a pci device address of <literal>0xc800</literal>:</para>
-         <programlisting><![CDATA[(pcidevicecon 51200 (unconfined.user object_r unconfined.object low_low))]]></programlisting>
-      </sect2>
-
-      <sect2 id="pirqcon">
-         <title>pirqcon</title>
-         <para>Label an interrupt level.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(pirqcon irq_level context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>pirqcon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>pirqcon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>irq_level</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The interrupt request number. The entries must consist of numerics <literal>[0-9]</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An anonymous context for IRQ 33:</para>
-         <programlisting><![CDATA[(pirqcon 33 (unconfined.user object_r unconfined.object low_low))]]></programlisting>
-      </sect2>
-
-      <sect2 id="devicetreecon">
-         <title>devicetreecon</title>
-         <para>Label device tree nodes.</para>
-         <para><emphasis role="bold">Statement definition:</emphasis></para>
-         <programlisting><![CDATA[(devicetreecon path context_id)]]></programlisting>
-         <para><emphasis role="bold">Where:</emphasis></para>
-         <informaltable frame="all">
-            <tgroup cols="2">
-            <colspec colwidth="2 *"/>
-            <colspec colwidth="6 *"/>
-               <tbody>
-               <row>
-                  <entry>
-                     <para><literal>devicetreecon</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The <literal>devicetreecon</literal> keyword.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>path</literal></para>
-                  </entry>
-                  <entry>
-                     <para>The device tree path. If this contains spaces enclose within <literal>""</literal>.</para>
-                  </entry>
-               </row>
-               <row>
-                  <entry>
-                     <para><literal>context_id</literal></para>
-                  </entry>
-                  <entry>
-                     <para>A previously declared <literal><link linkend="context">context</link></literal> identifier or an anonymous security context (<literal><link linkend="user">user</link> <link linkend="role">role</link> <link linkend="type">type</link> <link linkend="levelrange">levelrange</link></literal>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</para>
-                  </entry>
-               </row>
-            </tbody></tgroup>
-         </informaltable>
-
-         <para><emphasis role="bold">Example:</emphasis></para>
-         <para>An anonymous context for the specified path:</para>
-         <programlisting><![CDATA[(devicetreecon "/this is/a/path" (unconfined.user object_r unconfined.object low_low))]]></programlisting>
-      </sect2>
-
-   </sect1>
-- 
2.4.3
