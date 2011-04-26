From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/6] SELinux: fix comment to state filename_compute_type takes
	an objname not a qstr
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:07:39 -0400
Message-ID: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

filename_compute_type used to take a qstr, but it now takes just a name.
Fix the comments to indicate it is an objname, not a qstr.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/services.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5072aa7..3d427d0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1478,7 +1478,7 @@ static int security_compute_sid(u32 ssid,
 		newcontext.type = avdatum->data;
 	}
 
-	/* if we have a qstr this is a file trans check so check those rules */
+	/* if we have a objname this is a file trans check so check those rules */
 	if (objname)
 		filename_compute_type(&policydb, &newcontext, scontext->type,
 				      tcontext->type, tclass, objname);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
