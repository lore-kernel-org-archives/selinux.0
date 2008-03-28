Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SF6SdR024796
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 11:06:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SF4qUe018693
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 15:06:26 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/45] KEYS: Allow clients to set key perms in
	key_create_or_update() [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:30:31 +0000
Message-ID: <20080328143031.3483.6520.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Arun Raghavan <arunsr@cse.iitk.ac.in>

The key_create_or_update() function provided by the keyring code has a default
set of permissions that are always applied to the key when created. This might
not be desirable to all clients.

Here's a patch that adds a "perm" parameter to the function to address this,
which can be set to KEY_PERM_UNDEF to revert to the current behaviour.

Signed-off-by: Arun Raghavan <arunsr@cse.iitk.ac.in>
Acked-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h    |    3 +++
 security/keys/key.c    |   18 ++++++++++--------
 security/keys/keyctl.c |    3 ++-
 3 files changed, 15 insertions(+), 9 deletions(-)


diff --git a/include/linux/key.h b/include/linux/key.h
index 163f864..8b0bd33 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -67,6 +67,8 @@ struct key;
 #define KEY_OTH_SETATTR	0x00000020
 #define KEY_OTH_ALL	0x0000003f
 
+#define KEY_PERM_UNDEF	0xffffffff
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
@@ -232,6 +234,7 @@ extern key_ref_t key_create_or_update(key_ref_t keyring,
 				      const char *description,
 				      const void *payload,
 				      size_t plen,
+				      key_perm_t perm,
 				      unsigned long flags);
 
 extern int key_update(key_ref_t key,
diff --git a/security/keys/key.c b/security/keys/key.c
index 654d23b..d98c619 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -757,11 +757,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			       const char *description,
 			       const void *payload,
 			       size_t plen,
+			       key_perm_t perm,
 			       unsigned long flags)
 {
 	struct key_type *ktype;
 	struct key *keyring, *key = NULL;
-	key_perm_t perm;
 	key_ref_t key_ref;
 	int ret;
 
@@ -806,15 +806,17 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			goto found_matching_key;
 	}
 
-	/* decide on the permissions we want */
-	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
-	perm |= KEY_USR_VIEW | KEY_USR_SEARCH | KEY_USR_LINK | KEY_USR_SETATTR;
+	/* if the client doesn't provide, decide on the permissions we want */
+	if (perm == KEY_PERM_UNDEF) {
+		perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
+		perm |= KEY_USR_VIEW | KEY_USR_SEARCH | KEY_USR_LINK | KEY_USR_SETATTR;
 
-	if (ktype->read)
-		perm |= KEY_POS_READ | KEY_USR_READ;
+		if (ktype->read)
+			perm |= KEY_POS_READ | KEY_USR_READ;
 
-	if (ktype == &key_type_keyring || ktype->update)
-		perm |= KEY_USR_WRITE;
+		if (ktype == &key_type_keyring || ktype->update)
+			perm |= KEY_USR_WRITE;
+	}
 
 	/* allocate a new key */
 	key = key_alloc(ktype, description, current->fsuid, current->fsgid,
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 1698bf9..5f0d85b 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -111,7 +111,8 @@ asmlinkage long sys_add_key(const char __user *_type,
 	/* create or update the requested key and add it to the target
 	 * keyring */
 	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, KEY_ALLOC_IN_QUOTA);
+				       payload, plen, KEY_PERM_UNDEF,
+				       KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
