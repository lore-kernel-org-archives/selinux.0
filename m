Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCtjNs021762
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:55:46 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCoPcJ006490
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:50:25 GMT
Message-Id: <200509271250.j8RCoSYs026113@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 13/17
Date: Tue, 27 Sep 2005 08:50:28 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0034_01C5C340.82CE5250"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0034_01C5C340.82CE5250
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds the renamed semanage.conf.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0034_01C5C340.82CE5250
Content-Type: application/octet-stream;
	name="libsemanage_src_semanage.conf.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_semanage.conf.diff"

--- libsemanage/src/semanage.conf	1969-12-31 19:00:00.000000000 -0500=0A=
+++ libsemanage/src/semanage.conf	2005-09-22 15:29:15.000000000 -0400=0A=
@@ -0,0 +1,106 @@=0A=
+# Authors: Jason Tang <jtang@tresys.com>=0A=
+#=0A=
+# Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
+#=0A=
+#  This library is free software; you can redistribute it and/or=0A=
+#  modify it under the terms of the GNU Lesser General Public=0A=
+#  License as published by the Free Software Foundation; either=0A=
+#  version 2.1 of the License, or (at your option) any later version.=0A=
+#=0A=
+#  This library is distributed in the hope that it will be useful,=0A=
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+#  Lesser General Public License for more details.=0A=
+#=0A=
+#  You should have received a copy of the GNU Lesser General Public=0A=
+#  License along with this library; if not, write to the Free Software=0A=
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+#=0A=
+# Specify how libsemanage will interact with a SELinux policy manager.=0A=
+# The four options are:=0A=
+#=0A=
+#  "source"     - libsemanage manipulates a source SELinux policy=0A=
+#  "direct"     - libsemanage will write directly to a module store.=0A=
+#  /foo/bar     - Write by way of a policy management server, whose=0A=
+#                 named socket is at /foo/bar.  The path must begin=0A=
+#                 with a '/'.=0A=
+#  foo.com:4242 - Establish a TCP connection to a remote policy=0A=
+#                 management server at foo.com.  If there is a colon=0A=
+#                 then the remainder is interpreted as a port number;=0A=
+#                 otherwise default to port 4242.=0A=
+module-store =3D direct=0A=
+=0A=
+# When generating the final linked and expanded policy, by default=0A=
+# semanage will set the policy version to POLICYDB_VERSION_MAX, as=0A=
+# given in <sepol/policydb.h>.  Change this setting if a different=0A=
+# version is necessary.=0A=
+#policy-version =3D 19=0A=
+=0A=
+# After a policy has been created this library will attempt to load it=0A=
+# by calling the load_policy utility.  If there are special=0A=
+# requirements (e.g., read booleans from a certain file) then add them=0A=
+# here.  Below are the default values.  The path should be absolute=0A=
+# (i.e., beginning with a slash).  Within 'args', the special sequence=0A=
+# "$@" will be replaced with the policy filename.=0A=
+#=0A=
+# Note that this option is ignored when using a policy management=0A=
+# server.=0A=
+#[load_policy]=0A=
+#path =3D /usr/sbin/load_policy=0A=
+#args =3D -b $@=0A=
+#[end]=0A=
+=0A=
+# In addition to loading a policy libsemanage will validate file=0A=
+# contexts by calling the setfiles utility.  As above, "$@" will be=0A=
+# replaced with the policy filename.  In addition "$<" will be=0A=
+# replaced with the file contexts filename.=0A=
+#=0A=
+# Note that this option is ignored when using a policy management=0A=
+# server.=0A=
+#[setfiles]=0A=
+#path =3D /usr/sbin/setfiles=0A=
+#args =3D -q -c $@ $<=0A=
+#[end]=0A=
+=0A=
+# Each program specified within a [verify] block is run during=0A=
+# committing.  There are three types of verifies allowed: module,=0A=
+# linked, and kernel.  Multiple verifies may exist for a stage; place=0A=
+# each program within its own [verify] block.  For each stage the=0A=
+# programs are executed in the order given below.  If a program ever=0A=
+# returns a non-zero value then the entire commit is aborted.=0A=
+#=0A=
+# Module verifies are executed for each source module prior to=0A=
+# linking.  After they have been linked each link verifier is run=0A=
+# against the linked base module.  Finally, each kernel verifier is=0A=
+# run against the final expanded kernel policy.  If these verifiers=0A=
+# all exit with a return value of 0 then that kernel policy will be=0A=
+# loaded.=0A=
+#=0A=
+# 'path' gives a path the verificaton program.  'args' is any=0A=
+# free-form string that supplies command line arguments to the=0A=
+# verifier.  Within args single quotes, double quotes, and backslashes=0A=
+# are metacharacters handled similarly to bash.  Within 'args', the=0A=
+# special sequence "$@" will be replaced with a filename to the entity=0A=
+# being checked: source module for module verifiers, linked module for=0A=
+# linked, kernel policy for kernel.=0A=
+#=0A=
+# Note that this option is ignored when using a policy management=0A=
+# server.=0A=
+#[verify module]=0A=
+#path =3D /usr/bin/some_module_verifier=0A=
+#args =3D -Wall -ansi -pedantic $@=0A=
+#[end]=0A=
+=0A=
+#[verify module]=0A=
+#path =3D /another/module/verify/program=0A=
+#args =3D -With -some_more arguments=0A=
+#[end]=0A=
+=0A=
+#[verify linked]=0A=
+#path =3D /usr/local/bin/some_link_verifier=0A=
+#[end]=0A=
+=0A=
+#[verify kernel]=0A=
+#path =3D /usr/sbin/kernel_verifier=0A=
+#args =3D "some argument" "some other parameter" -k $@=0A=
+#[end]=0A=

------=_NextPart_000_0034_01C5C340.82CE5250--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
