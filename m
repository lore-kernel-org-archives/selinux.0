From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] Keys: Let keyctl_chown() change a key's owner
Date: Thu, 15 Jun 2006 15:09:56 +0100
To: mdlemay@epoch.ncsc.mil, sds@tycho.nsa.gov, jmorris@redhat.com
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com
Message-Id: <20060615140956.15380.64999.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060615140948.15380.41826.stgit@warthog.cambridge.redhat.com>
References: <20060615140948.15380.41826.stgit@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Fredrik Tolf <fredrik@dolda2000.com>

The attached patch lets keyctl_chown() change a key's owner, including
attempting to transfer the quota burden to the new user.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 security/keys/keyctl.c |   56 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ed71d86..7c9a6b0 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -672,6 +672,7 @@ long keyctl_read_key(key_serial_t keyid,
  */
 long keyctl_chown_key(key_serial_t id, uid_t uid, gid_t gid)
 {
+	struct key_user *newowner, *zapowner = NULL;
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
@@ -695,19 +696,50 @@ long keyctl_chown_key(key_serial_t id, u
 	if (!capable(CAP_SYS_ADMIN)) {
 		/* only the sysadmin can chown a key to some other UID */
 		if (uid != (uid_t) -1 && key->uid != uid)
-			goto no_access;
+			goto error_put;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (gid != (gid_t) -1 && gid != key->gid && !in_group_p(gid))
-			goto no_access;
+			goto error_put;
 	}
 
-	/* change the UID (have to update the quotas) */
+	/* change the UID */
 	if (uid != (uid_t) -1 && uid != key->uid) {
-		/* don't support UID changing yet */
-		ret = -EOPNOTSUPP;
-		goto no_access;
+		ret = -ENOMEM;
+		newowner = key_user_lookup(uid);
+		if (!newowner)
+			goto error_put;
+
+		/* transfer the quota burden to the new user */
+		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
+			spin_lock(&newowner->lock);
+			if (newowner->qnkeys + 1 >= KEYQUOTA_MAX_KEYS ||
+			    newowner->qnbytes + key->quotalen >=
+			    KEYQUOTA_MAX_BYTES)
+				goto quota_overrun;
+
+			newowner->qnkeys++;
+			newowner->qnbytes += key->quotalen;
+			spin_unlock(&newowner->lock);
+
+			spin_lock(&key->user->lock);
+			key->user->qnkeys--;
+			key->user->qnbytes -= key->quotalen;
+			spin_unlock(&key->user->lock);
+		}
+
+		atomic_dec(&key->user->nkeys);
+		atomic_inc(&newowner->nkeys);
+
+		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+			atomic_dec(&key->user->nikeys);
+			atomic_inc(&newowner->nikeys);
+		}
+
+		zapowner = key->user;
+		key->user = newowner;
+		key->uid = uid;
 	}
 
 	/* change the GID */
@@ -716,12 +748,20 @@ long keyctl_chown_key(key_serial_t id, u
 
 	ret = 0;
 
- no_access:
+error_put:
 	up_write(&key->sem);
 	key_put(key);
- error:
+	if (zapowner)
+		key_user_put(zapowner);
+error:
 	return ret;
 
+quota_overrun:
+	spin_unlock(&newowner->lock);
+	zapowner = newowner;
+	ret = -EDQUOT;
+	goto error_put;
+
 } /* end keyctl_chown_key() */
 
 /*****************************************************************************/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
