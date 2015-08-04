From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: support specifying file_contexts.bin file path
Date: Tue,  4 Aug 2015 13:56:57 -0400
Message-Id: <1438711017-5038-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

At present, the label_file backend expects to be provided the path
to the text file_contexts file and always appends the .bin suffix
when checking for the binary file_contexts.bin file.  If one
attempts to directly specify the path to a file_contexts.bin file
to selabel_open(), it will fail as the code will append a second
.bin suffix to it.  Check to see if the file path already has a .bin
suffix and do not append it in that case.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3252523..b658968 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -111,9 +111,16 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	uint32_t i, magic, version;
 	uint32_t entry_len, stem_map_len, regex_array_len;
 
-	rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
-	if (rc >= (int)sizeof(mmap_path))
-		return -1;
+	len = strlen(path);
+	if (len > 4 && !strcmp(&path[len-4], ".bin")) {
+		if (len >= sizeof(mmap_path))
+			return -1;
+		strcpy(mmap_path, path);
+	} else {
+		rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
+		if (rc >= (int)sizeof(mmap_path))
+			return -1;
+	}
 
 	mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
 	if (mmapfd < 0)
-- 
2.1.0
