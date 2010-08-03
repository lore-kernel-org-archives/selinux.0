From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: type_bounds_sanity_check has a meaningless variable
	declaration
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 03 Aug 2010 15:26:05 -0400
Message-ID: <20100803192605.1788.92228.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type is not used at all, stop declaring and assigning it.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index b7ef93e..3ff0c24 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1606,11 +1606,11 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 
 static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 {
-	struct type_datum *upper, *type;
+	struct type_datum *upper;
 	struct policydb *p = datap;
 	int depth = 0;
 
-	upper = type = datum;
+	upper = datum;
 	while (upper->bounds) {
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			printk(KERN_ERR "SELinux: type %s: "


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
