From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
        trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        aviro@redhat.com, steved@redhat.com
Subject: [PATCH 26/19] CacheFiles: Don't include linux/proc_fs.h
Date: Fri, 17 Nov 2006 10:01:30 +0000
Message-ID: <4709.1163757690@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Don't include linux/proc_fs.h anymore as we no longer use procfs.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 0c055a9..2c22d35 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -20,7 +20,6 @@ #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/namespace.h>
 #include <linux/statfs.h>
-#include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include "internal.h"
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
