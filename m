Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u788DY2Q011193
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 04:13:34 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8DBD8E3E5
 for <selinux@tycho.nsa.gov>; Mon,  8 Aug 2016 08:13:31 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] setroubleshoot: Fix sealert message for capability2
Date: Mon,  8 Aug 2016 10:13:26 +0200
Message-Id: <1470644006-8191-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Sealert didn't know "capability2" class which caused capability2
denials (e.g. block_suspend) to be reported as "access" denials.

fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1360392

type=AVC msg=audit(1468324670.938:596175): avc:  denied
{ block_suspend } for  pid=8442 comm="smtp" capability=36
scontext=system_u:system_r:postfix_smtp_t:s0
tcontext=system_u:system_r:postfix_smtp_t:s0 tclass=capability2

SELinux is preventing smtp from block_suspend access on the capability2 Unknown.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 framework/src/setroubleshoot/signature.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/framework/src/setroubleshoot/signature.py b/framework/src/setroubleshoot/signature.py
index 77ecc35..1f60c74 100755
--- a/framework/src/setroubleshoot/signature.py
+++ b/framework/src/setroubleshoot/signature.py
@@ -212,6 +212,7 @@ class_dict['process'] = _("process")
 class_dict['filesystem'] = _("filesystem")
 class_dict['node'] = _("node")
 class_dict['capability'] = _("capability")
+class_dict['capability2'] = _("capability2")
 
 def translate_class(tclass):
     if tclass in list(class_dict.keys()):
@@ -447,7 +448,7 @@ class SEFaultSignatureInfo(XmlSerialize):
         if self.tclass == "process":
             return P_(_("SELinux is preventing %s from using the %s access on a process."), _("SELinux is preventing %s from using the '%s' accesses on a process."), len(self.sig.access)) % (self.spath, ", ".join(self.sig.access))
 
-        if self.tclass == "capability":
+        if self.tclass in ["capability", "capability2"]:
             return P_(_("SELinux is preventing %s from using the %s capability."), _("SELinux is preventing %s from using the '%s' capabilities."), len(self.sig.access)) % (self.spath, ", ".join(self.sig.access))
         if self.tpath == "(null)":
             return P_(_("SELinux is preventing %s from %s access on the %s labeled %s."), _("SELinux is preventing %s from '%s' accesses on the %s labeled %s."), len(self.sig.access)) % (self.spath, ", ".join(self.sig.access), translate_class(self.tclass), self.tcontext.type)
-- 
2.5.5
