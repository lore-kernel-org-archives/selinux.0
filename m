Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54KwRcB021419
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:58:27 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 976142D4504
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 20:58:25 +0000 (UTC)
Subject: [PATCH v3 5/6] selinux-testsuite: fix compile problems in tests/shm
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 16:58:24 -0400
Message-ID: <20150604205824.19614.33472.stgit@localhost>
In-Reply-To: <20150604205708.19614.64746.stgit@localhost>
References: <20150604205708.19614.64746.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Resolve the following problems:

make[2]: Entering directory '/home/pmoore/sources/selinux-testsuite/selinux_testsuite-upstream/tests/shm'
cc -g -O0 -Wall -D_GNU_SOURCE    shmctl.c   -o shmctl
shmctl.c: In function 'main':
shmctl.c:11:6: warning: variable 'num' set but not used
  int num = 1;
      ^
cc -g -O0 -Wall -D_GNU_SOURCE    shmat.c   -o shmat
shmat.c: In function 'main':
shmat.c:11:6: warning: variable 'num' set but not used
  int num = 1;
      ^
cc -g -O0 -Wall -D_GNU_SOURCE    shmget.c   -o shmget
shmget.c: In function 'main':
shmget.c:11:6: warning: variable 'num' set but not used
  int num = 1;
      ^

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/shm/shmat.c  |    6 +-----
 tests/shm/shmctl.c |    6 +-----
 tests/shm/shmget.c |    6 +-----
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/tests/shm/shmat.c b/tests/shm/shmat.c
index 89ac299..704d676 100644
--- a/tests/shm/shmat.c
+++ b/tests/shm/shmat.c
@@ -8,20 +8,16 @@
 int main(int argc, char **argv)
 {
 	int ch;
-	int num = 1;
 	int key = 0x8888;
 	int id;
 	int error;
 	char *buf;
 
-	while ((ch = getopt(argc, argv, "k:-n:")) != -1) {
+	while ((ch = getopt(argc, argv, "k:")) != -1) {
 		switch (ch) {
 		case 'k':
 			key = atoi(optarg);
 			break;
-		case 'n':
-			num = atoi(optarg);
-			break;
 		}
 	}
 
diff --git a/tests/shm/shmctl.c b/tests/shm/shmctl.c
index 78397b6..d17a804 100644
--- a/tests/shm/shmctl.c
+++ b/tests/shm/shmctl.c
@@ -8,20 +8,16 @@
 int main(int argc, char **argv)
 {
 	int ch;
-	int num = 1;
 	int key = 0x8888;
 	int id;
 	int error;
 	struct shmid_ds buf;
 
-	while ((ch = getopt(argc, argv, "k:-n:")) != -1) {
+	while ((ch = getopt(argc, argv, "k:")) != -1) {
 		switch (ch) {
 		case 'k':
 			key = atoi(optarg);
 			break;
-		case 'n':
-			num = atoi(optarg);
-			break;
 		}
 	}
 
diff --git a/tests/shm/shmget.c b/tests/shm/shmget.c
index a04da25..42d6394 100644
--- a/tests/shm/shmget.c
+++ b/tests/shm/shmget.c
@@ -8,18 +8,14 @@
 int main(int argc, char **argv)
 {
 	int ch;
-	int num = 1;
 	int key = 0x8888;
 	int id;
 
-	while ((ch = getopt(argc, argv, "k:-n:")) != -1) {
+	while ((ch = getopt(argc, argv, "k:")) != -1) {
 		switch (ch) {
 		case 'k':
 			key = atoi(optarg);
 			break;
-		case 'n':
-			num = atoi(optarg);
-			break;
 		}
 	}
 
