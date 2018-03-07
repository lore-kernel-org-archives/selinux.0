Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w27F418p009766
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 10:04:01 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Wed,  7 Mar 2018 10:05:38 -0500
Message-Id: <20180307150538.14932-1-jwcart2@tycho.nsa.gov>
Subject: [PATCH] libsepol: Prevent freeing unitialized value in ibendport
 handling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Iooss reports:
In sepol_ibendport_key_create(), if sepol_ibendport_alloc_ibdev_name()
fails to allocate tmp_key->ibdev_name, sepol_ibendport_key_free() is
called to free the memory associated with tmp_key, which results in
free() being called on uninitialized tmp_key->ibdev_name.

This issue is reported by clang's static analyzer with the following
message:

    ibendport_record.c:115:2: warning: 1st function call argument is an
    uninitialized value
            free(key->ibdev_name);
            ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/ibendport_record.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
index 912aeb53..bc56f090 100644
--- a/libsepol/src/ibendport_record.c
+++ b/libsepol/src/ibendport_record.c
@@ -32,14 +32,11 @@ struct sepol_ibendport_key {
 int sepol_ibendport_alloc_ibdev_name(sepol_handle_t *handle,
 				     char **ibdev_name)
 {
-	char *tmp_ibdev_name = NULL;
-
-	tmp_ibdev_name = calloc(1, IB_DEVICE_NAME_MAX);
+	*ibdev_name = calloc(1, IB_DEVICE_NAME_MAX);
 
-	if (!tmp_ibdev_name)
+	if (!*ibdev_name)
 		goto omem;
 
-	*ibdev_name = tmp_ibdev_name;
 	return STATUS_SUCCESS;
 
 omem:
-- 
2.13.6
