Message-ID: <4B5685D5.7040307@ak.jp.nec.com>
Date: Wed, 20 Jan 2010 13:25:57 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jacques Thomas <jthomas@cs.purdue.edu>, SE Linux <selinux@tycho.nsa.gov>,
        method@manicmethod.com
Subject: [PATCH 1/2] selinux: remove dead code in type_attribute_bounds_av()
References: <4AF71B05.8030707@cs.purdue.edu>	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>	 <4B14934F.9050401@cs.purdue.edu> <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil> <4B54339F.8070501@ak.jp.nec.com>
In-Reply-To: <4B54339F.8070501@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes dead code in type_attribute_bounds_av().

Due to the historical reason, the type boundary feature is delivered
from hierarchical types in libsepol, it has supported boundary features
both of subject type (domain; in most cases) and target type.

However, we don't have any actual use cases in bounded target types,
and it tended to make conceptual confusion.
So, this patch removes the dead code to apply boundary checks on the
target types. I makes clear the TYPEBOUNDS restricts privileges of
a certain domain bounded to any other domain.

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/ss/services.c |   36 ++----------------------------------
 1 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3b42b15..a63593e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -523,9 +523,10 @@ static void type_attribute_bounds_av(struct context *scontext,
 		= policydb.type_val_to_struct[scontext->type - 1];
 	struct type_datum *target
 		= policydb.type_val_to_struct[tcontext->type - 1];
-	u32 masked = 0;

 	if (source->bounds) {
+		u32 masked;
+
 		memset(&lo_avd, 0, sizeof(lo_avd));

 		memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
@@ -538,40 +539,7 @@ static void type_attribute_bounds_av(struct context *scontext,
 		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
 			return;		/* no masked permission */
 		masked = ~lo_avd.allowed & avd->allowed;
-	}
-
-	if (target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-
-		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
-		lo_tcontext.type = target->bounds;
-
-		context_struct_compute_av(scontext,
-					  &lo_tcontext,
-					  tclass,
-					  &lo_avd);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}
-
-	if (source->bounds && target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-		/*
-		 * lo_scontext and lo_tcontext are already
-		 * set up.
-		 */
-
-		context_struct_compute_av(&lo_scontext,
-					  &lo_tcontext,
-					  tclass,
-					  &lo_avd);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}

-	if (masked) {
 		/* mask violated permissions */
 		avd->allowed &= ~masked;

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
