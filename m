From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 5/6] SELinux: generic hashtab entry counter
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:08:03 -0400
Message-ID: <20110426180803.20636.18062.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of a hashtab entry counter function only useful for range
transition rules make a function generic for any hashtable to use.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70c863b..ca7a723 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3066,7 +3066,7 @@ static int genfs_write(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int range_count(void *key, void *data, void *ptr)
+static int hashtab_cnt(void *key, void *data, void *ptr)
 {
 	int *cnt = ptr;
 	*cnt = *cnt + 1;
@@ -3114,7 +3114,7 @@ static int range_write(struct policydb *p, void *fp)
 
 	/* count the number of entries in the hashtab */
 	nel = 0;
-	rc = hashtab_map(p->range_tr, range_count, &nel);
+	rc = hashtab_map(p->range_tr, hashtab_cnt, &nel);
 	if (rc)
 		return rc;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
