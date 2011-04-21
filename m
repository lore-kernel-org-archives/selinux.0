Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEUenv016384
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:30:40 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEUcTB001176
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:30:39 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/9] TOMOYO: Derive the new domain for an exec'd process in
 tomoyo_bprm_set_creds()
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:30:32 +0100
Message-ID: <20110421143032.31318.45423.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Derive the new domain for an exec'd process in tomoyo_bprm_set_creds() rather
than in tomoyo_bprm_check_security().  bprm_set_creds() is called for each new
recurse through search_binary_handler() by prepare_binprm() being called first.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/tomoyo/tomoyo.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9d3a828..5a72868 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -39,7 +39,7 @@ static void tomoyo_cred_free(struct cred *cred)
 
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
-	int rc;
+	int rc, idx, err;
 
 	rc = cap_bprm_set_creds(bprm);
 	if (rc)
@@ -65,12 +65,15 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 */
 	atomic_dec(&((struct tomoyo_domain_info *)
 		     bprm->cred->security)->users);
-	/*
-	 * Tell tomoyo_bprm_check_security() is called for the first time of an
-	 * execve operation.
+
+	/* Check that the caller has execute permission on the program they
+	 * actually asked to run and install the new domain into the
+	 * credentials being constructed.
 	 */
-	bprm->cred->security = NULL;
-	return 0;
+	idx = tomoyo_read_lock();
+	err = tomoyo_find_next_domain(bprm);
+	tomoyo_read_unlock(idx);
+	return err;
 }
 
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
@@ -78,16 +81,6 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 	struct tomoyo_domain_info *domain = bprm->cred->security;
 
 	/*
-	 * Execute permission is checked against pathname passed to do_execve()
-	 * using current domain.
-	 */
-	if (!domain) {
-		const int idx = tomoyo_read_lock();
-		const int err = tomoyo_find_next_domain(bprm);
-		tomoyo_read_unlock(idx);
-		return err;
-	}
-	/*
 	 * Read permission is checked against interpreters using next domain.
 	 */
 	return tomoyo_check_open_permission(domain, &bprm->file->f_path, O_RDONLY);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
