From: Thomas Meyer <thomas@m3y3r.de>
To: paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Date: Sat, 07 Oct 2017 16:02:21 +0200
Subject: [PATCH] selinux: Fix bool initialization/comparison
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -550,7 +550,7 @@ int mls_compute_sid(struct context *scon
 
 		/* Fallthrough */
 	case AVTAB_CHANGE:
-		if ((tclass == policydb.process_class) || (sock == true))
+		if ((tclass == policydb.process_class) || (sock))
 			/* Use the process MLS attributes. */
 			return mls_context_cpy(newcontext, scontext);
 		else
diff -u -p a/security/selinux/ss/services.c b/security/selinux/ss/services.c
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1656,7 +1656,7 @@ static int security_compute_sid(u32 ssid
 	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
 		newcontext.role = tcontext->role;
 	} else {
-		if ((tclass == policydb.process_class) || (sock == true))
+		if ((tclass == policydb.process_class) || (sock))
 			newcontext.role = scontext->role;
 		else
 			newcontext.role = OBJECT_R_VAL;
@@ -1668,7 +1668,7 @@ static int security_compute_sid(u32 ssid
 	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
 		newcontext.type = tcontext->type;
 	} else {
-		if ((tclass == policydb.process_class) || (sock == true)) {
+		if ((tclass == policydb.process_class) || (sock)) {
 			/* Use the type of process. */
 			newcontext.type = scontext->type;
 		} else {
