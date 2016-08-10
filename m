From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH 4/5] genfs_read: fix use heap-use-after-free
Date: Wed, 10 Aug 2016 14:51:21 -0700
Message-Id: <1470865882-22435-4-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
References: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The newc variable is calloc'd and assigned to a new
owner during a loop. After the first assignment of newc
to newgenfs->head, the subsequent iteration could fail
before the newc is reseated with a new heap allocation
pointer. When the subsequent iteration fails, the
newc variable is freed. Later, an attempt it made to
free the same pointer assigned to newgenfs->head.

To correct this, clear newc after every loop iteration.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/policydb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6a80f94..971793d 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2812,6 +2812,8 @@ static int genfs_read(policydb_t * p, struct policy_file *fp)
 				l->next = newc;
 			else
 				newgenfs->head = newc;
+			/* clear newc after a new owner has the pointer */
+			newc = NULL;
 		}
 	}
 
-- 
1.9.1
