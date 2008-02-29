Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T0hubN025049
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 19:43:56 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T0htVG000363
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 00:43:55 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/37] KEYS: Check starting keyring as part of search [ver #34]
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 29 Feb 2008 00:43:44 +0000
Message-ID: <20080229004343.4142.27423.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
References: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Check the starting keyring as part of the search to (a) see if that is what
we're searching for, and (b) to check it is still valid for searching.

The scenario:  User in process A does things that cause things to be
created in its process session keyring.  The user then does an su to
another user and starts a new process, B.  The two processes now
share the same process session keyring.

Process B does an NFS access which results in an upcall to gssd.
When gssd attempts to instantiate the context key (to be linked
into the process session keyring), it is denied access even though it
has an authorization key.

The order of calls is:

   keyctl_instantiate_key()
      lookup_user_key()				    (the default: case)
         search_process_keyrings(current)
	    search_process_keyrings(rka->context)   (recursive call)
	       keyring_search_aux()

keyring_search_aux() verifies the keys and keyrings underneath the
top-level keyring it is given, but that top-level keyring is neither
fully validated nor checked to see if it is the thing being searched for.

This patch changes keyring_search_aux() to:
1) do more validation on the top keyring it is given and
2) check whether that top-level keyring is the thing being searched for


Signed-off-by: Kevin Coffman <kwc@citi.umich.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)


diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 88292e3..76b89b2 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -292,7 +292,7 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 
 	struct keyring_list *keylist;
 	struct timespec now;
-	unsigned long possessed;
+	unsigned long possessed, kflags;
 	struct key *keyring, *key;
 	key_ref_t key_ref;
 	long err;
@@ -318,6 +318,32 @@ key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 	now = current_kernel_time();
 	err = -EAGAIN;
 	sp = 0;
+	
+	/* firstly we should check to see if this top-level keyring is what we
+	 * are looking for */
+	key_ref = ERR_PTR(-EAGAIN);
+	kflags = keyring->flags;
+	if (keyring->type == type && match(keyring, description)) {
+		key = keyring;
+
+		/* check it isn't negative and hasn't expired or been
+		 * revoked */
+		if (kflags & (1 << KEY_FLAG_REVOKED))
+			goto error_2;
+		if (key->expiry && now.tv_sec >= key->expiry)
+			goto error_2;
+		key_ref = ERR_PTR(-ENOKEY);
+		if (kflags & (1 << KEY_FLAG_NEGATIVE))
+			goto error_2;
+		goto found;
+	}
+
+	/* otherwise, the top keyring must not be revoked, expired, or
+	 * negatively instantiated if we are to search it */
+	key_ref = ERR_PTR(-EAGAIN);
+	if (kflags & ((1 << KEY_FLAG_REVOKED) | (1 << KEY_FLAG_NEGATIVE)) ||
+	    (keyring->expiry && now.tv_sec >= keyring->expiry))
+		goto error_2;
 
 	/* start processing a new keyring */
 descend:
@@ -331,13 +357,14 @@ descend:
 	/* iterate through the keys in this keyring first */
 	for (kix = 0; kix < keylist->nkeys; kix++) {
 		key = keylist->keys[kix];
+		kflags = key->flags;
 
 		/* ignore keys not of this type */
 		if (key->type != type)
 			continue;
 
 		/* skip revoked keys and expired keys */
-		if (test_bit(KEY_FLAG_REVOKED, &key->flags))
+		if (kflags & (1 << KEY_FLAG_REVOKED))
 			continue;
 
 		if (key->expiry && now.tv_sec >= key->expiry)
@@ -352,8 +379,8 @@ descend:
 					context, KEY_SEARCH) < 0)
 			continue;
 
-		/* we set a different error code if we find a negative key */
-		if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
+		/* we set a different error code if we pass a negative key */
+		if (kflags & (1 << KEY_FLAG_NEGATIVE)) {
 			err = -ENOKEY;
 			continue;
 		}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
