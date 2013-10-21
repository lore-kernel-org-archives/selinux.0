Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LJGs2a029207
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 15:16:57 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so3757173eak.32
        for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 12:16:56 -0700 (PDT)
Received: from yow-turd.ottawa.windriver.com ([128.224.252.2])
        by mx.google.com with ESMTPSA id w6sm36621954eeo.12.2013.10.21.12.16.54
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 12:16:55 -0700 (PDT)
From: Joe MacDonald <joe@deserted.net>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux: avoid shadowing 'stat' in load_mmap
Date: Mon, 21 Oct 2013 15:16:40 -0400
Message-Id: <1382383000-16439-3-git-send-email-joe@deserted.net>
In-Reply-To: <1382383000-16439-2-git-send-email-joe@deserted.net>
References: <1382383000-16439-1-git-send-email-joe@deserted.net>
 <1382383000-16439-2-git-send-email-joe@deserted.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

   label_file.c: In function ‘load_mmap’:
   label_file.c:238:81: error: declaration of ‘stat’ shadows a global declaration [-Werror=shadow]
   cc1: all warnings being treated as errors

Signed-off-by: Joe MacDonald <joe@deserted.net>
---
 libselinux/src/label_file.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 51520cf..af7c227 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -235,7 +235,7 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
-static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *stat)
+static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *sb)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	char mmap_path[PATH_MAX + 1];
@@ -266,13 +266,13 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	}
 
 	/* if mmap is old, ignore it */
-	if (mmap_stat.st_mtime < stat->st_mtime) {
+	if (mmap_stat.st_mtime < sb->st_mtime) {
 		close(mmapfd);
 		return -1;
 	}
 
-	if (mmap_stat.st_mtime == stat->st_mtime &&
-	    mmap_stat.st_mtim.tv_nsec < stat->st_mtim.tv_nsec) {
+	if (mmap_stat.st_mtime == sb->st_mtime &&
+	    mmap_stat.st_mtim.tv_nsec < sb->st_mtim.tv_nsec) {
 		close(mmapfd);
 		return -1;
 	}
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
