Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u788KT1l011906
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 04:20:29 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com
 (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
 by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u788KRgr003334
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 04:20:27 -0400
Date: Mon, 8 Aug 2016 04:20:25 -0400 (EDT)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <191872440.3506154.1470644425890.JavaMail.zimbra@redhat.com>
In-Reply-To: <1470644006-8191-1-git-send-email-vmojzis@redhat.com>
References: <1470644006-8191-1-git-send-email-vmojzis@redhat.com>
Subject: Re: [PATCH] setroubleshoot: Fix sealert message for capability2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Please disregard this patch. I accidentally sent it to the wrong address.

----- Original Message -----
From: "Vit Mojzis" <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: plautrba@redhat.com, "Vit Mojzis" <vmojzis@redhat.com>
Sent: Monday, August 8, 2016 10:13:26 AM
Subject: [PATCH] setroubleshoot: Fix sealert message for capability2

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
