Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEY9II017501
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:34:09 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEY6Ts005031
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:34:06 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/45] KEYS: Make key_serial() a function if CONFIG_KEYS=y
	[ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:30:46 +0000
Message-ID: <20080328143046.3483.46994.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make key_serial() an inline function rather than a macro if CONFIG_KEYS=y.
This prevents double evaluation of the key pointer and also provides better
type checking.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


diff --git a/include/linux/key.h b/include/linux/key.h
index ad02d9c..c45c962 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -264,7 +264,10 @@ extern int keyring_add_key(struct key *keyring,
 
 extern struct key *key_lookup(key_serial_t id);
 
-#define key_serial(key) ((key) ? (key)->serial : 0)
+static inline key_serial_t key_serial(struct key *key)
+{
+	return key ? key->serial : 0;
+}
 
 #ifdef CONFIG_SYSCTL
 extern ctl_table key_sysctls[];


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
