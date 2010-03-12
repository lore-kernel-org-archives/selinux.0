Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CHoJTB003827
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:50:19 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CHnxiT026219
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 17:49:59 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2CHoInh011506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:50:18 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2CHoGqa015936
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 12:50:16 -0500
Message-ID: <4B9A7ED7.6050805@redhat.com>
Date: Fri, 12 Mar 2010 12:50:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This simple patch fixes the output of sepolgen to match what Chris
 expects for upstream policy.
Content-Type: multipart/mixed;
 boundary="------------060809030902060807070505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060809030902060807070505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060809030902060807070505
Content-Type: text/plain;
 name="sepolgen_allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sepolgen_allow.patch"

diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index 71121d7..3eda2fd 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -127,7 +127,7 @@ class AccessVector:
         return self.to_string()
 
     def to_string(self):
-        return "allow %s %s : %s %s;" % (self.src_type, self.tgt_type,
+        return "allow %s %s:%s %s;" % (self.src_type, self.tgt_type,
                                         self.obj_class, self.perms.to_space_str())
 
     def __cmp__(self, other):

--------------060809030902060807070505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
