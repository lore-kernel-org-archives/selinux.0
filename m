Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DL1Y1r007949
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 17:01:34 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id AEEED564946
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 23:01:14 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 22:34:22 +0200
Message-Id: <20180413203424.20542-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180413203424.20542-1-nicolas.iooss@m4x.org>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/5] libselinux: label_file: fix memory management
 in store_stem()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If store_stem() fails to expand the memory allocated on data->stem_arr,
some things go wrong:
* the memory referenced by "buf" is leaked,
* data->alloc_stems has been increased without data->stem_arr having
  been expanded. So the next time store_stem() is called, the function
  will behave as if the buffer holds enough space, and will write data
  after the end of data->stem_arr.

The first issue is being spotted by clang's static analyzer, which warns
about leaking variable "stem" in find_stem_from_spec() (this function
calls store_stem()).

This both issues by freeing buf when realloc(data->stem_arr) fails, and
by not increasing data->alloc_stems when this happens.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/label_file.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 3f9ce53b7ffe..1ab139e962f2 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -278,12 +278,14 @@ static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
 
 	if (data->alloc_stems == num) {
 		struct stem *tmp_arr;
-
-		data->alloc_stems = data->alloc_stems * 2 + 16;
+		int alloc_stems = data->alloc_stems * 2 + 16;
 		tmp_arr = realloc(data->stem_arr,
-				  sizeof(*tmp_arr) * data->alloc_stems);
-		if (!tmp_arr)
+				  sizeof(*tmp_arr) * alloc_stems);
+		if (!tmp_arr) {
+			free(buf);
 			return -1;
+		}
+		data->alloc_stems = alloc_stems;
 		data->stem_arr = tmp_arr;
 	}
 	data->stem_arr[num].len = stem_len;
-- 
2.17.0
