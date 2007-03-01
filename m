Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21GcR63007514
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:38:27 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21GdkJC012825
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 16:39:47 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l21Gdj6m030469
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:39:45 -0500
Subject: [PATCH]  sepolgen: better match refpolicy style in output
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 11:39:09 -0500
Message-Id: <1172767149.30103.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes the output of sepolgen better match the reference
policy by:

* removing the space between target types and object classes (e.g., 
  allow foo bar:file read).
* using self when the source and target match.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 614125805eda sepolgen/src/sepolgen/refpolicy.py
--- a/sepolgen/src/sepolgen/refpolicy.py	Thu Mar 01 11:10:46 2007 -0500
+++ b/sepolgen/src/sepolgen/refpolicy.py	Thu Mar 01 11:14:39 2007 -0500
@@ -427,7 +427,10 @@ class AVRule(Leaf):
         rule.
         """
         self.src_types.add(av.src_type)
-        self.tgt_types.add(av.tgt_type)
+        if av.src_type == av.tgt_type:
+            self.tgt_types.add("self")
+        else:
+            self.tgt_types.add(av.tgt_type)
         self.obj_classes.add(av.obj_class)
         self.perms.update(av.perms)
 
@@ -436,7 +439,7 @@ class AVRule(Leaf):
         that is a valid policy language representation (assuming
         that the types, object class, etc. are valie).
         """
-        return "%s %s %s : %s %s;" % (self.__rule_type_str(),
+        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
                                      self.src_types.to_space_str(),
                                      self.tgt_types.to_space_str(),
                                      self.obj_classes.to_space_str(),



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
