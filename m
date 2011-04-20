From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] SELinux: security_read_policy should take a size_t not
	ssize_t
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 20 Apr 2011 10:42:50 -0400
Message-ID: <20110420144250.17305.20265.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110420144243.17305.13584.stgit@paris.rdu.redhat.com>
References: <20110420144243.17305.13584.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The len should be an size_t but is a ssize_t.  Easy enough fix to silence
build warnings.  We have no need for signed-ness.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 2cf6708..3ba4feb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -86,7 +86,7 @@ extern int selinux_policycap_openperm;
 int security_mls_enabled(void);
 
 int security_load_policy(void *data, size_t len);
-int security_read_policy(void **data, ssize_t *len);
+int security_read_policy(void **data, size_t *len);
 size_t security_policydb_len(void);
 
 int security_policycap_supported(unsigned int req_cap);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc5f116..5072aa7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3189,7 +3189,7 @@ out:
  * @len: length of data in bytes
  *
  */
-int security_read_policy(void **data, ssize_t *len)
+int security_read_policy(void **data, size_t *len)
 {
 	int rc;
 	struct policy_file fp;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
