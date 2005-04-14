Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3ELcq7C021766
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 17:38:52 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3ELWJIT004045
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:32:19 GMT
Subject: Description of the httpdcontent attribute [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-93O7N1lSaJ8SF33SY2Zq"
Date: Thu, 14 Apr 2005 17:35:07 -0400
Message-Id: <1113514507.6056.37.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-93O7N1lSaJ8SF33SY2Zq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds to the description of the httpdcontent attribute.

David


--=-93O7N1lSaJ8SF33SY2Zq
Content-Disposition: attachment; filename=UDiffs.attrib
Content-Type: text/x-patch; name=UDiffs.attrib; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: attrib.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/attrib.te,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 attrib.te
--- attrib.te	13 Apr 2005 04:15:14 -0000	1.1.1.2
+++ attrib.te	14 Apr 2005 20:51:56 -0000
@@ -427,7 +427,11 @@
 # For clients of nscd that can use shmem interface.
 attribute nscd_shmem_domain;
 
-# For labeling of content for httpd
+# For labeling of content for httpd.  This attribute is only used by
+# the httpd_unified domain, which says treat all httpdcontent the
+# same.  If you want content to be served in a "non-unified" system
+# you must specifically add "r_dir_file(httpd_t, your_content_t)" to
+# your policy.
 attribute httpdcontent;
 
 # For labeling of domains whos transition can be disabled

--=-93O7N1lSaJ8SF33SY2Zq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
