Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7HFpgFo010607
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 11:51:42 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7HFp8UO007827
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 15:51:10 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: setools: Missing function prototypes
Date: Mon, 17 Aug 2009 10:39:19 -0500
Message-ID: <87k51230wo.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        During automated builds on IA64 machines in Debian,  setools
 failed to build due to missing function prototypes, and implicit
 conversion from int to pointer. A patch follows.

        manoj

======================================================================

Missing function prototypes are likely to cause setools to
segfault on architectures where the size of a pointer is greater than the
size of an integer, such as ia64 and amd64.

 Function `toplevel_get_log_mls_lvl' implicitly converted to pointer at filter_view.c:846
 Function `toplevel_get_log_mls_clr' implicitly converted to pointer at filter_view.c:859

This patch adds the prototypes, and the doxygen comments to the header
file.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 seaudit/toplevel.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/seaudit/toplevel.h b/seaudit/toplevel.h
index dd8729e..19fb664 100644
--- a/seaudit/toplevel.h
+++ b/seaudit/toplevel.h
@@ -155,6 +155,30 @@ apol_vector_t *toplevel_get_log_roles(toplevel_t * top);
 apol_vector_t *toplevel_get_log_types(toplevel_t * top);
 
 /**
+ * Return a vector of strings corresponding to all mls levels
+ * found within currently opened log files.  The vector will be sorted
+ * alphabetically.
+ *
+ * @param top Toplevel containing seaudit log object.
+ *
+ * @return Vector of sorted types, or NULL if no log is loaded.  The
+ * caller must call apol_vector_destroy() upon the return value.
+ */
+apol_vector_t *toplevel_get_log_mls_lvl(toplevel_t * top);
+
+/**
+ * Return a vector of strings corresponding to all mls clearance
+ * found within currently opened log files.  The vector will be sorted
+ * alphabetically.
+ *
+ * @param top Toplevel containing seaudit log object.
+ *
+ * @return Vector of sorted types, or NULL if no log is loaded.  The
+ * caller must call apol_vector_destroy() upon the return value.
+ */
+apol_vector_t *toplevel_get_log_mls_clr(toplevel_t * top);
+
+/**
  * Return a vector of strings corresponding to all mls
  * levels found within the current log file.  
  * The vector will be sorted alphabetically.
-- 
1.6.3.3


-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
