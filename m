Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JHHecL004539
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 13:17:40 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JHHdrk006178
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 17:17:39 GMT
Message-ID: <4627A425.7030800@redhat.com>
Date: Thu, 19 Apr 2007 13:17:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Additional textrel_shlib_t
Content-Type: multipart/mixed;
 boundary="------------040703040306070601050404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040703040306070601050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040703040306070601050404
Content-Type: text/x-patch;
 name="libraries.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libraries.patch"

--- nsaserefpolicy/policy/modules/system/libraries.fc	2007-04-10 16:13:39.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/libraries.fc	2007-04-17 10:00:22.000000000 -0400
@@ -82,6 +81,7 @@
 /opt/netbeans(.*/)?jdk.*/linux/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/cxoffice/lib/wine/.+\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/ibm/java2-ppc64-50/jre/bin/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/f-secure/fspms/libexec/librapi.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_gentoo',`
 # despite the extensions, they are actually libs
@@ -132,6 +132,7 @@
 /usr/(.*/)?nvidia/.+\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib/transgaming_cedega/gddb_parser.so --	gen_context(system_u:object_r:shlib_t,s0)
 
 /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/nvidia/.+\.so(\..*)? --	gen_context(system_u:object_r:textrel_shlib_t,s0)

--------------040703040306070601050404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
