Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFON1o011098
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:24:23 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNGjq025808
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:24:17 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865788nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:24:17 -0800 (PST)
Message-ID: <cadfc0e40711260724o315b36dfj8b1e0d66c4f2d61a@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:24:17 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 10/10] PAM Namespace: spec file
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- pam.spec	2007-09-25 15:26:29.000000000 -0500
+++ pam-0.99.8.1.spec	2007-11-26 09:13:30.000000000 -0600
@@ -44,6 +44,15 @@ Patch44: pam-0.99.7.1-namespace-homedir.
 Patch45: pam-0.99.8.1-selinux-permit.patch
 Patch46: pam-0.99.8.1-succif-in-operator.patch
 Patch47: pam-0.99.8.1-xauth-no-free.patch
+Patch48: pam-0.99.8.1-mkpolydir.patch
+Patch49: pam-0.99.8.1-ns-expand-home.patch
+Patch50: pam-0.99.8.1-ns-no-setexeccon-options.patch
+Patch51: pam-0.99.8.1-ns-poly-share.patch
+Patch52: pam-0.99.8.1-ns-config-parse.patch
+Patch53: pam-0.99.8.1-ns-ignore-if-user-excluded.patch
+Patch54: pam-0.99.8.1-ns-wrong-user-ns.patch
+Patch55: pam-0.99.8.1-ns-config-init-script.patch
+Patch56: pam-0.99.8.1-ns-eacces-nopoly.patch

 BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires: cracklib, cracklib-dicts >= 2.8
@@ -115,6 +124,15 @@ popd
 %patch45 -p1 -b .permit
 %patch46 -p1 -b .in-operator
 %patch47 -p1 -b .no-free
+%patch48 -p1 -b .mkpolydir
+%patch49 -p1 -b .ns-expand-home
+%patch50 -p1 -b .ns-no-setexeccon-options
+%patch51 -p1 -b .ns-poly-share
+%patch52 -p1 -b .ns-config-parse
+%patch53 -p1 -b .ns-ignore-if-user-excluded
+%patch54 -p1 -b .ns-wrong-user-ns
+%patch55 -p1 -b .ns-config-init-script
+%patch56 -p1 -b .ns-eacces-nopoly

 autoreconf

@@ -296,6 +314,21 @@ fi
 if [ ! -a /var/log/tallylog ] ; then
 	install -m 600 /dev/null /var/log/tallylog
 fi
+if [ -f /etc/security/namespace.conf ] ; then
+   /bin/awk '{
+  if (index($1, "#") != 1) {
+    if (NF == 3) {
+      print sprintf("%s none run_init", $0);
+    } else if (NF == 4) {
+      print sprintf("%s run_init", $0);
+    } else {
+      print $0;
+    }
+  } else {
+    print $0
+  }
+}' /etc/security/namespace.conf > temp; mv temp /etc/security/namespace.conf
+fi

 %postun -p /sbin/ldconfig

@@ -374,6 +407,7 @@ fi
 /%{_lib}/security/pam_wheel.so
 /%{_lib}/security/pam_xauth.so
 /%{_lib}/security/pam_filter
+/%{_lib}/security/pam_mkpolydir.so
 %dir %{_sysconfdir}/security
 %config(noreplace) %{_sysconfdir}/security/access.conf
 %config(noreplace) %{_sysconfdir}/security/chroot.conf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
