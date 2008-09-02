Subject: [PATCH] SELinux: memory leak in security_context_to_sid_core
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 02 Sep 2008 17:15:11 -0400
Message-Id: <1220390111.2962.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Memory leak in security_context_to_sid_core() as a result of the
deferred context patches.  Code audit found another possible leak in
string_to_context_struct() so I fixed that error path as well.

This is a regression since 2.6.26.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/ss/services.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b52f923..e1090c1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -805,18 +805,20 @@ static int string_to_context_struct(struct policydb *pol,
 
 	if ((p - scontext) < scontext_len) {
 		rc = -EINVAL;
-		goto out;
+		goto out_destroy;
 	}
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(pol, ctx)) {
 		rc = -EINVAL;
-		context_destroy(ctx);
-		goto out;
+		goto out_destroy;
 	}
 	rc = 0;
 out:
 	return rc;
+out_destroy:
+	context_destroy(ctx);
+	goto out;
 }
 
 static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
@@ -868,10 +870,9 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	} else if (rc)
 		goto out;
 	rc = sidtab_context_to_sid(&sidtab, &context, sid);
-	if (rc)
-		context_destroy(&context);
 out:
 	read_unlock(&policy_rwlock);
+	context_destroy(&context);
 	kfree(scontext2);
 	kfree(str);
 	return rc;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
