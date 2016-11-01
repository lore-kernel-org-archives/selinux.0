From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bill.c.roberts@gmail.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: avc_internal.c: allow building with clang
Date: Tue,  1 Nov 2016 17:01:44 -0400
Message-Id: <1478034104-25583-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Resolves the following errors from clang:
avc_internal.c:105:25: error: cast from 'char *' to 'struct nlmsghdr *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
        struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
                               ^~~~~~~~~~~~~~~~~~~~~~
avc_internal.c:161:25: error: cast from 'char *' to 'struct nlmsghdr *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
        struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
                               ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/avc_internal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index be94857..26f3360 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -96,7 +96,7 @@ void avc_netlink_close(void)
 	fd = -1;
 }
 
-static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
+static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
 {
 	int rc;
 	struct pollfd pfd = { fd, POLLIN | POLLPRI, 0 };
@@ -155,7 +155,7 @@ static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
 	return 0;
 }
 
-static int avc_netlink_process(char *buf)
+static int avc_netlink_process(void *buf)
 {
 	int rc;
 	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
-- 
2.7.4
