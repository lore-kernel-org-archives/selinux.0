Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4KHrXZ026646
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:17:53 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4KHocx016749
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 20:17:50 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA4KDVip009805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 14:13:31 -0600
To: selinux@tycho.nsa.gov
Subject: selinux-doc patchset 2 of 2: Quoting attribute values
References: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
	<1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil>
	<87fz3qqc20.fsf@glaurung.internal.golden-gryphon.com>
	<1099575909.3174.9.camel@moss-spartans.epoch.ncsc.mil>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Thu, 04 Nov 2004 14:13:30 -0600
In-Reply-To: <1099575909.3174.9.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Thu, 04 Nov 2004 08:45:10 -0500")
Message-ID: <877jp1qsnp.fsf_-_@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        Since attribute values need to be quoted unless  SHORTTAG YES
 is specified,  this patchset, the second of two, does that.  Please
 note that this patch assumes that the previous patchset that modified
 the ID name tokens has already been applied.

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=quoting.diff
Content-Description: Quote attribute values

* looking for srivasta@debian.org--2003-primary/selinux-doc--debian--1.0--patch-1 to compare with
* comparing to srivasta@debian.org--2003-primary/selinux-doc--debian--1.0--patch-1
M  module/inode.sgml
M  module/ip.sgml
M  module/ipc.sgml
M  module/netdev.sgml
M  module/sb.sgml
M  module/skb.sgml
M  module/socket.sgml
M  module/system.sgml
M  module/task.sgml
M  policy/arch.sgml
M  module/biblio.sgml
M  policy/biblio.sgml
M  policy/lang.sgml
M  module/binprm.sgml
M  module/file.sgml

* modified files

--- orig/module/biblio.sgml
+++ mod/module/biblio.sgml
@@ -3,14 +3,14 @@
 
 <biblioentry id="LoscoccoFreenix01">
   <abbrev>LoscoccoFreenix2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
     </authorgroup>
     <title>Integrating Flexible Support for Security Policies into the Linux Operating System</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the FREENIX Track: 2001 USENIX Annual Technical Conference</title>
     <publisher>
       <publishername>The USENIX Association</publishername>
@@ -21,14 +21,14 @@
 
 <biblioentry id="LoscoccoNSATR01">
   <abbrev>LoscoccoNSATR2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
     </authorgroup>
     <title>Integrating Flexible Support for Security Policies into the Linux Operating System</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>NSA Technical Report</title>
     <pubdate>February 2001</pubdate>
   </biblioset>
@@ -36,7 +36,7 @@
 
 <biblioentry id="LoscoccoNISS98">
   <abbrev>LoscoccoNISS1998</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
@@ -47,7 +47,7 @@
     </authorgroup>
     <title>The Inevitability of Failure:  The Flawed Assumption of Security in Modern Computing Environments</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the 21st National Information Systems Security Conference</title>
     <pubdate>October 1998</pubdate>
   </biblioset>
@@ -55,7 +55,7 @@
 
 <biblioentry id="SpencerUsenixSec99">
   <abbrev>SpencerUsenixSec1999</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Ray</firstname><surname>Spencer</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
@@ -66,7 +66,7 @@
     </authorgroup>
     <title>The Flask Security Architecture:  System Support for Diverse Security Policies</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the Eighth USENIX Security Symposium</title>
     <publisher>
       <publishername>The USENIX Association</publishername>
@@ -86,11 +86,11 @@
 
 <biblioentry id="MorrisSeloptOverview02">
   <abbrev>MorrisSeloptOverview2002</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <author><firstname>James</firstname><surname>Morris</surname></author>
     <title>Overview of SELinux Labeled Networking Support via CIPSO/FIPS-188 IP Options</title>
   </biblioset>
-  <biblioset relation=file>
+  <biblioset relation="file">
     <title>selopt-overview.txt</title>
     <pubdate>February 2002</pubdate>
   </biblioset>
@@ -98,11 +98,11 @@
 
 <biblioentry id="MorrisSCMP01">
   <abbrev>MorrisSCMP2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <author><firstname>James</firstname><surname>Morris</surname></author>
     <title>Security Context Mapping Protocol</title>
   </biblioset>
-  <biblioset relation=file>
+  <biblioset relation="file">
     <title>scmp-draft.txt</title>
     <pubdate>December 30, 2001</pubdate>
   </biblioset>


--- orig/module/binprm.sgml
+++ mod/module/binprm.sgml
@@ -79,9 +79,9 @@
 the same time, so it does not need this permission to the shell
 program.
 
-<table id="NochangeSidTable" frame=all>
+<table id="NochangeSidTable" frame="all">
 <title>Permission Checks if Task SID is not changing on exec</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -110,9 +110,9 @@
 programs are referred to as entrypoint programs for the SID.  These
 permission checks are shown in <xref linkend="ChangeSidTable">.
 
-<table id="ChangeSidTable" frame=all>
+<table id="ChangeSidTable" frame="all">
 <title>Permission Checks if Task SID is changing on exec</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -160,9 +160,9 @@
 unchanged and the task is sent a SIGKILL to terminate it.
 These permission checks are shown in <xref linkend="PtraceShareTable">.
 
-<table id="PtraceShareTable" frame=all>
+<table id="PtraceShareTable" frame="all">
 <title>Permission Checks if Task SID is changing on exec</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>


--- orig/module/file.sgml
+++ mod/module/file.sgml
@@ -32,9 +32,9 @@
 };
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>file_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -183,9 +183,9 @@
 <xref linkend="IopermTable"> shows the permission checks performed for each
 command.
 
-<table id="IopermTable" frame=all>
+<table id="IopermTable" frame="all">
 <title>I/O Control Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <colspec colwidth="40*">
 <colspec colwidth="20*">
 <colspec colwidth="20*">
@@ -317,9 +317,9 @@
 The basic permission checks performed for each command are shown in
 <xref linkend="FilecontrolTable">.
 
-<table id="FilecontrolTable" frame=all>
+<table id="FilecontrolTable" frame="all">
 <title>File Control Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
     <entry>Command</entry>


--- orig/module/inode.sgml
+++ mod/module/inode.sgml
@@ -35,9 +35,9 @@
 };
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>inode_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -162,9 +162,9 @@
 of the modes listed in <xref linkend="InodeclassesTable">, 
 then it defaults to the file security class.
 
-<table id="InodeclassesTable" frame=all>
+<table id="InodeclassesTable" frame="all">
 <title>Inode Security Classes</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Mode</entry>
@@ -421,9 +421,9 @@
 <function>security_transition_sid</function> interface.  The function
 then checks permissions as described in <xref linkend="CreatepermTable">.
 
-<table id="CreatepermTable" frame=all>
+<table id="CreatepermTable" frame="all">
 <title>Create Permission Checks</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -472,9 +472,9 @@
 permission checks for these operations are shown in 
 <xref linkend="LinkpermTable"> and <xref linkend="UnlinkpermTable">.
 
-<table id="LinkpermTable" frame=all>
+<table id="LinkpermTable" frame="all">
 <title>Link Permission Checks</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -497,9 +497,9 @@
 </tgroup>
 </table>
 
-<table id="UnlinkpermTable" frame=all>
+<table id="UnlinkpermTable" frame="all">
 <title>Unlink or Rmdir Permission Checks</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -551,9 +551,9 @@
 checked if the file is a directory and its parent directory is being
 changed by the rename.
 
-<table id="RenamepermTable" frame=all>
+<table id="RenamepermTable" frame="all">
 <title>Basic Rename Permission Checks</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -581,9 +581,9 @@
 </tgroup>
 </table>
 
-<table id="AdditionalrenameTable" frame=all>
+<table id="AdditionalrenameTable" frame="all">
 <title>Additional Rename Permission Checks if NewFile Exists</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -606,9 +606,9 @@
 </tgroup>
 </table>
 
-<table id="AdditionalparentTable" frame=all>
+<table id="AdditionalparentTable" frame="all">
 <title>Additional Rename Permission Checks if Reparenting</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
 <entry>Source</entry>
@@ -664,9 +664,9 @@
 could be omitted from this hook, but it is performed to ensure that all
 directory modifications are mediated by the policy.
 
-<table id="DirpermsTable" frame=all>
+<table id="DirpermsTable" frame="all">
 <title>Directory Permission Checks</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Mask</entry>
@@ -705,9 +705,9 @@
 <constant>O_APPEND</constant> flag is not subsequently cleared unless
 the process has <constant>write</constant> permission to the file.
 
-<table id="NondirpermTable" frame=all>
+<table id="NondirpermTable" frame="all">
 <title>Non-Directory Permission Checks</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Mask</entry>
@@ -746,9 +746,9 @@
 file, the permission checks are all described in 
 <xref linkend="MiscinodeTable">.
 
-<table id="MiscinodeTable" frame=all>
+<table id="MiscinodeTable" frame="all">
 <title>Remaining Inode Hook Permission Checks</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Hook</entry>


--- orig/module/ip.sgml
+++ mod/module/ip.sgml
@@ -46,9 +46,9 @@
 source node.  The permission checked for each protocol type is shown
 in <xref linkend="PacketrcvTable">.
 
-<table id="PacketrcvTable" frame=all>
+<table id="PacketrcvTable" frame="all">
 <title>Packet Receive Permissions</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Protocol</entry>
@@ -145,9 +145,9 @@
 <function>selinux_skb_set_owner_w</function> hook sets the message
 SID.
 
-<table id="PacketsndTable" frame=all>
+<table id="PacketsndTable" frame="all">
 <title>Packet Send Permissions</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Protocol</entry>


--- orig/module/ipc.sgml
+++ mod/module/ipc.sgml
@@ -24,9 +24,9 @@
 };
 </programlisting>
 
-<table id="IpcSecurityStructTable" frame=all>
+<table id="IpcSecurityStructTable" frame="all">
 <title>ipc_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -84,9 +84,9 @@
         avc_entry_ref_t avcr;
 };
 </programlisting>
-<table frame=all>
+<table frame="all">
 <title>msg_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -271,9 +271,9 @@
 necessary, but ensure that all IPC accesses are mediated by the
 policy.
 
-<table id="IpcpermTable" frame=all>
+<table id="IpcpermTable" frame="all">
 <title>ipc_permission Permission Checks</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Flag</entry>
@@ -336,9 +336,9 @@
 are shown in <xref linkend="SemcontrolTable">.
 
 
-<table id="SemcontrolTable" frame=all>
+<table id="SemcontrolTable" frame="all">
 <title> Semaphore Control Permissions</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
     <entry>Operation</entry>
@@ -423,9 +423,9 @@
 operation being performed. The permissions required for each operation
 are shown in <xref linkend="ShmcontrolTable">.
 
-<table id="ShmcontrolTable" frame=all>
+<table id="ShmcontrolTable" frame="all">
 <title> Shared Memory Control Permissions</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
     <entry>Operation</entry>
@@ -496,9 +496,9 @@
 operation being performed.  The permissions required for each
 operation are shown in <xref linkend="MsgcontrolTable">.
 
-<table id="MsgcontrolTable" frame=all>
+<table id="MsgcontrolTable" frame="all">
 <title> Message Queue Control Permissions</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
     <entry>Operation</entry>
@@ -549,9 +549,9 @@
 the security server to obtain a SID based on the SID of the task and
 the SID of the message queue.
 
-<table id="MsgsndTable" frame=all>
+<table id="MsgsndTable" frame="all">
 <title>Message Send Permissions</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
     <entry>Source</entry>
@@ -602,9 +602,9 @@
 process and may cause the calling process to block waiting for
 messages that are accessible.
 
-<table id="MsgrcvTable" frame=all>
+<table id="MsgrcvTable" frame="all">
 <title>Message Receive Permissions</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
     <entry>Source</entry>


--- orig/module/netdev.sgml
+++ mod/module/netdev.sgml
@@ -29,9 +29,9 @@
         avc_entry_ref_t avcr;
 };
 </programlisting>
-<table frame=all>
+<table frame="all">
 <title>netdev_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>


--- orig/module/sb.sgml
+++ mod/module/sb.sgml
@@ -30,9 +30,9 @@
 };
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>superblock_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -270,9 +270,9 @@
 The permission checks for the super_block hooks are summarized
 in <xref linkend="FspermTable">.
 
-<table id="FspermTable" frame=all>
+<table id="FspermTable" frame="all">
 <title>Filesystem Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
 <entry>Hook</entry>


--- orig/module/skb.sgml
+++ mod/module/skb.sgml
@@ -43,9 +43,9 @@
 };      
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>skb_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>


--- orig/module/socket.sgml
+++ mod/module/socket.sgml
@@ -31,9 +31,9 @@
 }
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>sock_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -122,9 +122,9 @@
 This SID is used to label outgoing packets from
 a socket that has no user space socket structure associated with it.
 
-<table id="SockclassTable" frame=all>
+<table id="SockclassTable" frame="all">
 <title> Socket Security Classes</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row><entry>Protocol Family</entry><entry>Type</entry>
 		<entry>Security Class</entry></row>
@@ -259,9 +259,9 @@
 functions, excluding the optional extended socket call processing, is
 then described in the following subsections.
 
-<table id="SocklayerTable" frame=all>
+<table id="SocklayerTable" frame="all">
 <title>Socket Layer Hook Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <colspec colwidth="35*">
 <colspec colwidth="20*">
 <colspec colwidth="20*">
@@ -442,9 +442,9 @@
 </para>
 
 <para>
-<table id="ConpermTable" frame=all>
+<table id="ConpermTable" frame="all">
 <title>Connection Establishment Permission Checks</title>
-<tgroup cols=5 align=left>
+<tgroup cols="5" align="left">
 <colspec colwidth="35*">
 <colspec colwidth="15*">
 <colspec colwidth="20*">
@@ -508,9 +508,9 @@
 <constant>sendto</constant> permission between the sending socket and
 the receiving socket.  These permission checks are summarized in 
 <xref linkend="DomaincheckTable">.
-<table id="DomaincheckTable" frame=all>
+<table id="DomaincheckTable" frame="all">
 <title>Unix Domain Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <colspec colwidth="40*">
 <colspec colwidth="20*">
 <colspec colwidth="20*">
@@ -583,9 +583,9 @@
         access_vector_t conn_perm;     /* connection permission */
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>Extended inode_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -641,9 +641,9 @@
 };
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>open_request_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>


--- orig/module/system.sgml
+++ mod/module/system.sgml
@@ -83,8 +83,8 @@
 
 <sect3><title>Summary of Capability-Related Permission Checks</title>
 <para>
-<table frame=all><title>Capability-Related Permission Checks</title>
-<tgroup cols=4 align=left>
+<table frame="all"><title>Capability-Related Permission Checks</title>
+<tgroup cols="4" align="left">
 <thead>
 <row>
 <entry>Hook Function</entry>
@@ -144,9 +144,9 @@
 future, e.g. a permission to control what files can be used for
 accounting, so these hooks may be used at a later point in time.
 
-<table id="SysdeferTable" frame=all>
+<table id="SysdeferTable" frame="all">
 <title>System Hook Functions that Defer to Capable</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
 <entry>Hook</entry>
@@ -183,7 +183,7 @@
 The <structname>ctl_sid</structname> structure is used to map a name
 from the sysctl namespace to a SID. This structure resembles the
 <structname>ctl_table</structname> structure defined in <filename
-class=headerfile>sysctl.h</filename>, with entries for the sysctl
+class="headerfile">sysctl.h</filename>, with entries for the sysctl
 name (which is an integer), the associated string from the
 <filename>/proc/sys</filename> namespace, and the
 <acronym>SID</acronym> to be used for the entry. The last field is an
@@ -229,9 +229,9 @@
 as a file for read or write operations on a variable.
 <xref linkend="SysctlpermTable"> shows the permission checks associated with
 each requested operation.
-<table id="SysctlpermTable" frame=all>
+<table id="SysctlpermTable" frame="all">
 <title>sysctl Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
 <entry>Operation Value</entry>
@@ -342,9 +342,9 @@
 secondary module to permit it to perform additional capability
 checking.
 
-<table id="SysremainTable" frame=all>
+<table id="SysremainTable" frame="all">
 <title>Remaining System Hook Function Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
 <entry>Hook Function</entry>


--- orig/module/task.sgml
+++ mod/module/task.sgml
@@ -26,9 +26,9 @@
 };
 </programlisting>
 
-<table frame=all>
+<table frame="all">
 <title>task_security_struct</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <colspec colwidth="20*">
 <colspec colwidth="80*">
 <thead>
@@ -172,9 +172,9 @@
 <function>task_has_security</function> function checks whether a task
 has permission to use one of the security server system calls.
 
-<table id="TskhelpTable" frame=all>
+<table id="TskhelpTable" frame="all">
 <title>Task Helper Function Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <thead>
 <row>
 <entry>Function</entry>
@@ -231,9 +231,9 @@
 permission checks are summarized in <xref linkend="TskpermTable">.  These
 functions call the <function>task_has_perm</function> helper function.
 
-<table id="TskpermTable" frame=all>
+<table id="TskpermTable" frame="all">
 <title>Task Hook Function Permission Checks</title>
-<tgroup cols=4 align=left>
+<tgroup cols="4" align="left">
 <colspec colwidth="40*">
 <colspec colwidth="20*">
 <colspec colwidth="20*">


--- orig/policy/arch.sgml
+++ mod/policy/arch.sgml
@@ -153,9 +153,9 @@
 example policy configuration is compiled.  The Flask configuration
 files are listed in <xref linkend="flaskconfigtable">.
 
-<table id="flaskconfigtable" frame=all>
+<table id="flaskconfigtable" frame="all">
 <title>Architecture Configuration Files</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Filename</entry>


--- orig/policy/biblio.sgml
+++ mod/policy/biblio.sgml
@@ -3,14 +3,14 @@
 
 <biblioentry id="BoebertNCSC85">
   <abbrev>BoebertNCSC1985</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>W.</firstname><surname>Boebert</surname></author>
       <author><firstname>R.</firstname><surname>Kain</surname></author>
     </authorgroup>
     <title>A Practical Alternative to Hierarchical Integrity Policies</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the Eighth National Computer Security Conference</title>
     <pubdate>1985</pubdate>
   </biblioset>
@@ -18,14 +18,14 @@
 
 <biblioentry id="FerraioloNCSC92">
   <abbrev>FerraioloNCSC1992</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>David</firstname><surname>Ferraiolo</surname></author>
       <author><firstname>Richard</firstname><surname>Kuhn</surname></author>
     </authorgroup>
     <title>Role-Based Access Controls</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the 15th National Computer Security Conference</title>
     <pubdate>October 1992</pubdate>
   </biblioset>
@@ -33,14 +33,14 @@
 
 <biblioentry id="LoscoccoFreenix01">
   <abbrev>LoscoccoFreenix2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
     </authorgroup>
     <title>Integrating Flexible Support for Security Policies into the Linux Operating System</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the FREENIX Track: 2001 USENIX Annual Technical Conference</title>
     <publisher>
       <publishername>The USENIX Association</publishername>
@@ -51,14 +51,14 @@
 
 <biblioentry id="LoscoccoOLS01">
   <abbrev>LoscoccoOLS2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
     </authorgroup>
     <title>Meeting Critical Security Objectives with Security-Enhanced Linux</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the 2001 Ottawa Linux Symposium</title>
     <pubdate>July 2001</pubdate>
   </biblioset>
@@ -66,14 +66,14 @@
 
 <biblioentry id="LoscoccoNSATR01">
   <abbrev>LoscoccoNSATR2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Peter</firstname><surname>Loscocco</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
     </authorgroup>
     <title>Integrating Flexible Support for Security Policies into the Linux Operating System</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>NSA Technical Report</title>
     <pubdate>February 2001</pubdate>
   </biblioset>
@@ -81,14 +81,14 @@
 
 <biblioentry id="SmalleyNAITR01">
   <abbrev>SmalleyNAITR2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
       <author><firstname>Timothy</firstname><surname>Fraser</surname></author>
     </authorgroup>
     <title>A Security Policy Configuration for the Security-Enhanced Linux</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>NAI Labs Technical Report</title>
     <pubdate>February 2001</pubdate>
   </biblioset>
@@ -96,7 +96,7 @@
 
 <biblioentry id="SmalleyModuleTR01">
   <abbrev>SmalleyModuleTR2001</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
       <author><firstname>Chris</firstname><surname>Vance</surname></author>
@@ -104,7 +104,7 @@
     </authorgroup>
     <title>Implementing SELinux as a Linux Security Module</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>NAI Labs Report #01-043</title>
     <pubdate>December 2001</pubdate>
   </biblioset>
@@ -112,7 +112,7 @@
 
 <biblioentry id="SpencerUsenixSec99">
   <abbrev>SpencerUsenixSec1999</abbrev>
-  <biblioset relation=article>
+  <biblioset relation="article">
     <authorgroup>
       <author><firstname>Ray</firstname><surname>Spencer</surname></author>
       <author><firstname>Stephen</firstname><surname>Smalley</surname></author>
@@ -123,7 +123,7 @@
     </authorgroup>
     <title>The Flask Security Architecture:  System Support for Diverse Security Policies</title>
   </biblioset>
-  <biblioset relation=journal>
+  <biblioset relation="journal">
     <title>Proceedings of the Eighth USENIX Security Symposium</title>
     <publisher>
       <publishername>The USENIX Association</publishername>


--- orig/policy/lang.sgml
+++ mod/policy/lang.sgml
@@ -244,9 +244,9 @@
 type_transition cardmgr_t tmp_t:devfile_class_set cardmgr_dev_t;
 </programlisting>
 
-<table id="classmacros" frame=all>
+<table id="classmacros" frame="all">
 <title>Class Macros</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Macro Name</entry>
@@ -420,9 +420,9 @@
 allow sshd_t sshd_tmp_t:dir create_dir_perms;
 </programlisting>
 
-<table id="filepermmacros" frame=all>
+<table id="filepermmacros" frame="all">
 <title>File Permission Macros</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Macro Name</entry>
@@ -486,9 +486,9 @@
 </tgroup>
 </table>
 
-<table id="socketpermmacros" frame=all>
+<table id="socketpermmacros" frame="all">
 <title>Socket Permission Macros</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Macro Name</entry>
@@ -516,9 +516,9 @@
 </tgroup>
 </table>
 
-<table id="ipcpermmacros" frame=all>
+<table id="ipcpermmacros" frame="all">
 <title>IPC Permission Macros</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Macro Name</entry>
@@ -582,9 +582,9 @@
 As with other macros, care should be taken when using these macros to
 avoid granting unintended permissions.
 
-<table id="teavmacros" frame=all>
+<table id="teavmacros" frame="all">
 <title>TE Access Vector Rule Macros</title>
-<tgroup cols=3 align=left>
+<tgroup cols="3" align="left">
 <thead>
 <row>
     <entry>Macro Name</entry>
@@ -772,9 +772,9 @@
 directory rather than in the <constant>types</constant> directory.
 The <filename>assert.te</filename> file specifies TE assertions.
 
-<table id="teconfigtable" frame=all>
+<table id="teconfigtable" frame="all">
 <title>TE Configuration Files</title>
-<tgroup cols=2 align=left>
+<tgroup cols="2" align="left">
 <thead>
 <row>
     <entry>Filename</entry>




--=-=-=


-- 
To be, or what? Sylvester Stallone
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
