Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA26860
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 11:09:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA21280
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 16:09:09 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id QAA21270
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 16:09:09 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id fAKG9fN21244
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 11:09:41 -0500 (EST)
Date: Tue, 20 Nov 2001 11:09:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] Bug fix for selinux_inode_delete hook
Message-ID: <Pine.GSO.4.33.0111201101420.17556-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1006272581=:17556"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1006272581=:17556
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch fixes a bug in the selinux_inode_delete hook function
in the latest release.  Sorry for not catching this prior to the release.
This hook function should only call clear_psid if the inode is associated
with a superblock that uses persistent SIDs.  This is particularly a
problem if the inode does not have an associated superblock at all.  You
can apply this patch by saving it to ~/delete.patch, changing to the
selinux directory, and running 'patch -p1 < ~/delete.patch'.  This patch
is for the hooks.c file, which is located in selinux/module/selinux_plug
in the SELinux archive or in lsm/security/selinux when SELinux is inserted
into the kernel tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-959030623-1006272581=:17556
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="delete.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0111201109410.17556@raven>
Content-Description: 
Content-Disposition: attachment; filename="delete.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jDQpk
aWZmIC11IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEu
Njkgc2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL2hvb2tzLmM6MS43MA0K
LS0tIHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9ob29rcy5jOjEuNjkJ
U2F0IE5vdiAxNyAwODo1ODo0NiAyMDAxDQorKysgc2VsaW51eC9tb2R1bGUv
c2VsaW51eF9wbHVnL2hvb2tzLmMJTW9uIE5vdiAxOSAyMjoyNDozMiAyMDAx
DQpAQCAtMjE1OSw3ICsyMTU5LDEyIEBADQogDQogc3RhdGljIHZvaWQgc2Vs
aW51eF9pbm9kZV9kZWxldGUoc3RydWN0IGlub2RlICppbm9kZSkNCiB7DQot
CWNsZWFyX3BzaWQoaW5vZGUpOw0KKwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
ID0gaW5vZGUtPmlfc2I7IA0KKwlpZiAoc2IpIHsNCisJCXN0cnVjdCBzdXBl
cmJsb2NrX3NlY3VyaXR5X3N0cnVjdCAqc2JzZWMgPSBzYi0+c19zZWN1cml0
eTsNCisJCWlmIChzYnNlYyAmJiBzYnNlYy0+dXNlc19wc2lkcykNCisJCQlj
bGVhcl9wc2lkKGlub2RlKTsNCisJfQ0KIH0NCiANCiANCg==
---559023410-959030623-1006272581=:17556--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
