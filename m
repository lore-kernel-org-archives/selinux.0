Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAJAeIi022550
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 14:10:41 -0500 (EST)
Received: from nightfall.hsol.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAJAgR8009042
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 19:10:43 GMT
Subject: [PATCH] packages specs
From: Miguel Bolanos <mike@hsol.net>
To: SE Linux list <selinux@tycho.nsa.gov>
Cc: dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-aoKk5YC7UPa0tQdt5TOu"
Message-Id: <1102706031.3886.38.camel@selene.hsol.net>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 13:14:09 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aoKk5YC7UPa0tQdt5TOu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

This patch just removes the hardcoded names on the source definitions
for the packages specs.
best wishes

Mike


--=-aoKk5YC7UPa0tQdt5TOu
Content-Disposition: attachment; filename=specs.diff
Content-Type: text/x-patch; name=specs.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- checkpolicy-1.18/checkpolicy.spec.orig	2004-12-09 01:11:34.981563712 -0600
+++ checkpolicy-1.18/checkpolicy.spec	2004-12-09 01:12:37.202104752 -0600
@@ -4,7 +4,7 @@
 Release: 1
 License: GPL
 Group: Development/System
-Source: http://www.nsa.gov/selinux/archives/checkpolicy-%{version}.tgz
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 Prefix: %{_prefix}
 BuildRoot: %{_tmppath}/%{name}-buildroot
 BuildRequires: byacc flex libsepol-devel 
--- libselinux-1.18/libselinux.spec.orig	2004-12-09 01:13:36.189137360 -0600
+++ libselinux-1.18/libselinux.spec	2004-12-09 01:14:38.269699680 -0600
@@ -4,7 +4,7 @@
 Release: 1
 License: Public domain (uncopyrighted)
 Group: System Environment/Libraries
-Source: http://www.nsa.gov/selinux/archives/libselinux-%{version}.tgz
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
 
 %description
--- libsepol-1.2/libsepol.spec.orig	2004-12-09 01:15:37.202740496 -0600
+++ libsepol-1.2/libsepol.spec	2004-12-09 01:16:15.499918440 -0600
@@ -4,7 +4,7 @@
 Release: 1
 License: GPL
 Group: System Environment/Libraries
-Source: http://www.nsa.gov/selinux/archives/libsepol-%{version}.tgz
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 Prefix: %{_prefix}
 BuildRoot: %{_tmppath}/%{name}-buildroot
 Provides: libsepol.so
--- policycoreutils-1.18/policycoreutils.spec.orig	2004-12-09 01:19:21.133697816 -0600
+++ policycoreutils-1.18/policycoreutils.spec	2004-12-09 01:20:05.283985952 -0600
@@ -4,7 +4,7 @@
 Release: 1
 License: GPL
 Group: System Environment/Base
-Source: http://www.nsa.gov/selinux/archives/policycoreutils-%{version}.tgz
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 
 Prefix: %{_prefix}
 BuildRequires: libselinux-devel libsepol-devel 
--- selinux-doc-1.14/selinux-doc.spec.orig	2004-12-09 01:21:17.186055176 -0600
+++ selinux-doc-1.14/selinux-doc.spec	2004-12-09 01:23:00.199394768 -0600
@@ -4,7 +4,7 @@
 Release: 1
 License: Public Use License v1.0 
 Group: System Environment/Base
-Source: http://www.nsa.gov/selinux/archives/selinux-doc-1.14.tgz
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 Prefix: %{_prefix}
 BuildRoot: %{_tmppath}/%{name}-buildroot
 BuildArch: noarch

--=-aoKk5YC7UPa0tQdt5TOu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
