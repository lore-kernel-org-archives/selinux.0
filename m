Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAJAeIi022548
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 14:10:40 -0500 (EST)
Received: from nightfall.hsol.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAJAdR8009040
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 19:10:42 GMT
Subject: [PATCH] polgen spec
From: Miguel Bolanos <mike@hsol.net>
To: SE Linux list <selinux@tycho.nsa.gov>
Cc: dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-2OC4uhI07FeKLnstIsZZ"
Message-Id: <1102706029.3886.36.camel@selene.hsol.net>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 13:14:00 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2OC4uhI07FeKLnstIsZZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

Introducing .spec file for polgen
best wishes

Mike


--=-2OC4uhI07FeKLnstIsZZ
Content-Disposition: attachment; filename=polgen-spec.diff
Content-Type: text/x-patch; name=polgen-spec.diff; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff -ruN polgen-0.8.orig/polgen.spec polgen-0.8/polgen.spec
--- polgen-0.8.orig/polgen.spec	1969-12-31 18:00:00.000000000 -0600
+++ polgen-0.8/polgen.spec	2004-12-09 08:04:31.033592952 -0600
@@ -0,0 +1,44 @@
+Summary: SELinux policy generation scripts
+Name: polgen
+Version: 0.8
+Release: 1
+License: GPL
+Group: Development/System 
+Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
+Prefix: %{_prefix}
+BuildRoot: %{_tmppath}/%{name}-buildroot
+Requires: python
+
+%description
+Security-enhanced Linux is a patch of the Linux® kernel and a number
+of utilities with enhanced security functionality designed to add
+mandatory access controls to Linux.  The Security-enhanced Linux
+kernel contains new architectural components originally developed to
+improve the security of the Flask operating system. These
+architectural components provide general support for the enforcement
+of many kinds of mandatory access control policies, including those
+based on the concepts of Type Enforcement®, Role-based Access
+Control, and Multi-level Security.
+
+This package contains polgen, a collection of scripts and tools 
+developed by the MITRE corporation to automate the SELinux
+policy generation process.
+
+%prep
+%setup -q
+
+%build
+make CFLAGS="%{optflags}"
+
+%install
+rm -rf ${RPM_BUILD_ROOT}
+mkdir -p ${RPM_BUILD_ROOT}%{_bindir}
+make DESTDIR="${RPM_BUILD_ROOT}" install
+
+%clean
+rm -rf ${RPM_BUILD_ROOT}
+
+%files
+%defattr(-,root,root)
+
+%changelog

--=-2OC4uhI07FeKLnstIsZZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
