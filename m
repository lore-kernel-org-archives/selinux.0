Date: Mon, 8 Feb 2010 10:14:40 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: [PATCH][RFC] selinux: fix a couple of sparse warnings
Message-ID: <alpine.LRH.2.00.1002081013130.25332@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please review.

These warnings were introduced in commit 
44c2d9bdd7022ca7d240d5adc009296fc1c6ce08

----


    selinux: fix a couple of sparse warnings
    
    Fix a couple of sparse warnings for callers of
    context_struct_to_string, which takes a *u32, not an *int.
    
    These cases are harmless as the values are not used.
    
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4e976f5..0e5c3a4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -455,7 +455,8 @@ static void security_dump_masked_av(struct context *scontext,
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
 	char *permission_names[32];
-	int index, length;
+	int index;
+	u32 length;
 	bool need_comma = false;
 
 	if (!permissions)
@@ -807,7 +808,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	if (rc) {
 		char *old_name = NULL;
 		char *new_name = NULL;
-		int length;
+		u32 length;
 
 		if (!context_struct_to_string(old_context,
 					      &old_name, &length) &&



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
