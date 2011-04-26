From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/6] SELinux: rename filename_compute_type argument to *type
	instead of *con
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:07:45 -0400
Message-ID: <20110426180745.20636.30651.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

filename_compute_type() takes as arguments the numeric value of the type of
the subject and target.  It does not take a context.  Thus the names are
misleading.  Fix the argument names.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/services.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3d427d0..40aa930 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1359,13 +1359,13 @@ out:
 }
 
 static void filename_compute_type(struct policydb *p, struct context *newcontext,
-				  u32 scon, u32 tcon, u16 tclass,
+				  u32 stype, u32 ttype, u16 tclass,
 				  const char *objname)
 {
 	struct filename_trans *ft;
 	for (ft = p->filename_trans; ft; ft = ft->next) {
-		if (ft->stype == scon &&
-		    ft->ttype == tcon &&
+		if (ft->stype == stype &&
+		    ft->ttype == ttype &&
 		    ft->tclass == tclass &&
 		    !strcmp(ft->name, objname)) {
 			newcontext->type = ft->otype;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
