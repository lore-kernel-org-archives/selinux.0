From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/3] flex_arrays: allow zero length flex arrays
To: dave@linux.vnet.ibm.com
Cc: steffen.klassert@secunet.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Mon, 25 Apr 2011 21:45:37 -0400
Message-ID: <20110426014537.1740.68472.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426014531.1740.24077.stgit@paris.rdu.redhat.com>
References: <20110426014531.1740.24077.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just like kmalloc will allow one to allocate a 0 length segment of memory
flex arrays should do the same thing.  It should bomb if you try to use
something, but it should at least allow the allocation.

Based-on-patch-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 lib/flex_array.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/lib/flex_array.c b/lib/flex_array.c
index 0c33b24..2554a5f 100644
--- a/lib/flex_array.c
+++ b/lib/flex_array.c
@@ -253,9 +253,16 @@ int flex_array_prealloc(struct flex_array *fa, unsigned int start,
 	unsigned int end;
 	struct flex_array_part *part;
 
+	if (!fa->total_nr_elements && !start)
+		return 0;
+	if (start >= fa->total_nr_elements)
+		return -ENOSPC;
+	if (!nr_elements)
+		return 0;
+
 	end = start + nr_elements - 1;
 
-	if (start >= fa->total_nr_elements || end >= fa->total_nr_elements)
+	if (end >= fa->total_nr_elements)
 		return -ENOSPC;
 	if (elements_fit_in_base(fa))
 		return 0;
@@ -346,6 +353,8 @@ int flex_array_shrink(struct flex_array *fa)
 	int part_nr;
 	int ret = 0;
 
+	if (!fa->total_nr_elements)
+		return 0;
 	if (elements_fit_in_base(fa))
 		return ret;
 	for (part_nr = 0; part_nr < FLEX_ARRAY_NR_BASE_PTRS; part_nr++) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
