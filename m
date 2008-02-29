Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T0hr4Q025023
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 19:43:53 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T0hq2Z012285
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 00:43:52 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/37] KEYS: Increase the payload size when instantiating a
	key [ver #34]
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 29 Feb 2008 00:43:38 +0000
Message-ID: <20080229004338.4142.73865.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
References: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Increase the size of a payload that can be used to instantiate a key in
add_key() and keyctl_instantiate_key().  This permits huge CIFS SPNEGO blobs to
be passed around.  The limit is raised to 1MB.  If kmalloc() can't allocate a
buffer of sufficient size, vmalloc() will be tried instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyctl.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)


diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d9ca15c..8ec8432 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -19,6 +19,7 @@
 #include <linux/capability.h>
 #include <linux/string.h>
 #include <linux/err.h>
+#include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
@@ -62,9 +63,10 @@ asmlinkage long sys_add_key(const char __user *_type,
 	char type[32], *description;
 	void *payload;
 	long ret;
+	bool vm;
 
 	ret = -EINVAL;
-	if (plen > 32767)
+	if (plen > 1024 * 1024 - 1)
 		goto error;
 
 	/* draw all the data into kernel space */
@@ -81,11 +83,18 @@ asmlinkage long sys_add_key(const char __user *_type,
 	/* pull the payload in if one was supplied */
 	payload = NULL;
 
+	vm = false;
 	if (_payload) {
 		ret = -ENOMEM;
 		payload = kmalloc(plen, GFP_KERNEL);
-		if (!payload)
-			goto error2;
+		if (!payload) {
+			if (plen <= PAGE_SIZE)
+				goto error2;
+			vm = true;
+			payload = vmalloc(plen);
+			if (!payload)
+				goto error2;
+		}
 
 		ret = -EFAULT;
 		if (copy_from_user(payload, _payload, plen) != 0)
@@ -113,7 +122,10 @@ asmlinkage long sys_add_key(const char __user *_type,
 
 	key_ref_put(keyring_ref);
  error3:
-	kfree(payload);
+	if (!vm)
+		kfree(payload);
+	else
+		vfree(payload);
  error2:
 	kfree(description);
  error:
@@ -821,9 +833,10 @@ long keyctl_instantiate_key(key_serial_t id,
 	key_ref_t keyring_ref;
 	void *payload;
 	long ret;
+	bool vm = false;
 
 	ret = -EINVAL;
-	if (plen > 32767)
+	if (plen > 1024 * 1024 - 1)
 		goto error;
 
 	/* the appropriate instantiation authorisation key must have been
@@ -843,8 +856,14 @@ long keyctl_instantiate_key(key_serial_t id,
 	if (_payload) {
 		ret = -ENOMEM;
 		payload = kmalloc(plen, GFP_KERNEL);
-		if (!payload)
-			goto error;
+		if (!payload) {
+			if (plen <= PAGE_SIZE)
+				goto error;
+			vm = true;
+			payload = vmalloc(plen);
+			if (!payload)
+				goto error;
+		}
 
 		ret = -EFAULT;
 		if (copy_from_user(payload, _payload, plen) != 0)
@@ -877,7 +896,10 @@ long keyctl_instantiate_key(key_serial_t id,
 	}
 
 error2:
-	kfree(payload);
+	if (!vm)
+		kfree(payload);
+	else
+		vfree(payload);
 error:
 	return ret;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
