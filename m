Message-Id: <200509262348.j8QNmZYs018845@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 7/7 
Date: Mon, 26 Sep 2005 19:48:35 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00AA_01C5C2D3.485BA220"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00AA_01C5C2D3.485BA220
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes the file semod.conf. This file is moved to semanage.conf
in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00AA_01C5C2D3.485BA220
Content-Type: application/octet-stream;
	name="7-remove-semodconf.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="7-remove-semodconf.diff"

--- libsemanage/src/semod.conf	2005-09-19 09:03:15.000000000 -0400=0A=
+++ libsemanage/src/semod.conf	1969-12-31 19:00:00.000000000 -0500=0A=
@@ -1,96 +0,0 @@=0A=
-# Authors: Jason Tang <jtang@tresys.com>=0A=
-#=0A=
-# Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
-#=0A=
-#  This library is free software; you can redistribute it and/or=0A=
-#  modify it under the terms of the GNU Lesser General Public=0A=
-#  License as published by the Free Software Foundation; either=0A=
-#  version 2.1 of the License, or (at your option) any later version.=0A=
-#=0A=
-#  This library is distributed in the hope that it will be useful,=0A=
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
-#  Lesser General Public License for more details.=0A=
-#=0A=
-#  You should have received a copy of the GNU Lesser General Public=0A=
-#  License along with this library; if not, write to the Free Software=0A=
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
-=0A=
-# Specify how libsemanage will interact with the module store.  The =
three=0A=
-# options are:=0A=
-#=0A=
-#  "direct"     - libsemanage will write directly to the store.=0A=
-#  /foo/bar     - Write by way of a policy server, whose named socket=0A=
-#                 is at /foo/bar.  The path must begin with a '/'.=0A=
-#  foo.com:4242 - Establish a TCP connection to a remote policy server=0A=
-#                 at foo.com.  If there is a colon then the remainder=0A=
-#                 is interpreted as a port number; otherwise default=0A=
-#                 to port 4242.=0A=
-module-store =3D direct=0A=
-=0A=
-# When generating the final linked and expanded policy, by default=0A=
-# semodule will set the policy version to POLICYDB_VERSION_MAX, as=0A=
-# given in <sepol/policydb.h>.  Change this setting if a different=0A=
-# version is necessary.=0A=
-#policy-version =3D 19=0A=
-=0A=
-# After a policy has been created this library will attempt to load it=0A=
-# by calling the load_policy utility.  If there are special=0A=
-# requirements (e.g., read booleans from a certain file) then add them=0A=
-# here.  Below are the default values.  Within 'args', the special=0A=
-# sequence "$@" will be replaced with the policy filename.=0A=
-#[load_policy]=0A=
-#path =3D /usr/sbin/load_policy=0A=
-#args =3D -b $@=0A=
-#[end]=0A=
-=0A=
-# In addition to loading a policy libsemanage will validate file =
contexts=0A=
-# by calling the setfiles utility.  As above, "$@" will be replaced=0A=
-# with the policy filename.  In addition "$<" will be replaced with=0A=
-# the file contexts filename.=0A=
-#[setfiles]=0A=
-#path =3D /usr/sbin/setfiles=0A=
-#args =3D -q -c $@ $<=0A=
-#[end]=0A=
-=0A=
-# Each program specified within a [verify] block is run during=0A=
-# committing.  There are three types of verifies allowed: module,=0A=
-# linked, and kernel.  Multiple verifies may exist for a stage; place=0A=
-# each program within its own [verify] block.  For each stage the=0A=
-# programs are executed in the order given below.  If a program ever=0A=
-# returns a non-zero value then the entire commit is aborted.=0A=
-#=0A=
-# Module verifies are executed for each source module prior to=0A=
-# linking.  After they have been linked each link verifier is run=0A=
-# against the linked base module.  Finally, each kernel verifier is=0A=
-# run against the final expanded kernel policy.  If these verifiers=0A=
-# all exit with a return value of 0 then that kernel policy will be=0A=
-# loaded.=0A=
-#=0A=
-# 'path' gives a path the verificaton program.  'args' is any=0A=
-# free-form string that supplies command line arguments to the=0A=
-# verifier.  Within args single quotes, double quotes, and backslashes=0A=
-# are metacharacters handled similarly to bash.  Within 'args', the=0A=
-# special sequence "$@" will be replaced with a filename to the entity=0A=
-# being checked: source module for module verifiers, linked module for=0A=
-# linked, kernel policy for kernel.  The sequence "$<" will be=0A=
-# replaced with the previous filename, if applicable.  If an older=0A=
-# version does not exist "$<" expands to an empty string.=0A=
-#[verify module]=0A=
-#path =3D /usr/bin/some_module_verifier=0A=
-#args =3D -Wall -ansi -pedantic $@ $<=0A=
-#[end]=0A=
-=0A=
-#[verify module]=0A=
-#path =3D /another/module/verify/program=0A=
-#args =3D -With -some_more arguments=0A=
-#[end]=0A=
-=0A=
-#[verify linked]=0A=
-#path =3D /usr/local/bin/some_link_verifier=0A=
-#[end]=0A=
-=0A=
-#[verify kernel]=0A=
-#path =3D /usr/sbin/kernel_verifier=0A=
-#args =3D "some argument" "some other parameter" -k $@=0A=
-#[end]=0A=

------=_NextPart_000_00AA_01C5C2D3.485BA220--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
