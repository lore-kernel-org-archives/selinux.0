Message-ID: <49D4069A.9000600@ak.jp.nec.com>
Date: Thu, 02 Apr 2009 09:28:10 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Subject: Re: Correct manner to handler undefined classes/permissions? (Re:
 Some ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>	 <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>	 <49D3171A.3020708@ak.jp.nec.com> <1238589935.24074.3.camel@localhost.localdomain>
In-Reply-To: <1238589935.24074.3.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------090105080301080909060109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090105080301080909060109
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
>> My preference is filling up the undefined access vectores with
>> policydb.allow_unknown. It seems to me quite natural.
> 
> I believe that is what the kernel does during policy load, by defining
> the policydb->undefined_perms[] array.

Oops, I misread the kernel code.

>> Userspace object managers also have same issue.
>> Now it's unclear for me what is the preferable behavior.
>> For example, how should it handle the db_database:{superuser}
>> on the older security policy?

It is useful for userspace object manager, if libselinux has an
interface something like: int security_deny_unknown(void);

This interface can suggest applications preferable behavior when
string_to_security_class() or string_to_av_perm() returns invalid
value which means the security policy does not define required
ones.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------090105080301080909060109
Content-Type: text/x-patch;
 name="libselinux-security_deny_unknown.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-security_deny_unknown.patch"

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 libselinux/include/selinux/selinux.h        |    3 ++
 libselinux/man/man3/security_deny_unknown.3 |   21 ++++++++++++++
 libselinux/src/deny_unknown.c               |   40 +++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h           |    1 +
 4 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fab083e..01a8912 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -301,6 +301,9 @@ extern int security_disable(void);
 /* Get the policy version number. */
 extern int security_policyvers(void);
 
+/* Get the behavior for undefined classes/permissions */
+extern int security_deny_unknown(void);
+
 /* Get the boolean names */
 extern int security_get_boolean_names(char ***names, int *len);
 
diff --git a/libselinux/man/man3/security_deny_unknown.3 b/libselinux/man/man3/security_deny_unknown.3
index e69de29..1fce3eb 100644
--- a/libselinux/man/man3/security_deny_unknown.3
+++ b/libselinux/man/man3/security_deny_unknown.3
@@ -0,0 +1,21 @@
+.TH "security_deny_unknown" "3" "2 April 2009" "kaigai@ak.jp.nec.com" "SELinux API documentation"
+.SH "NAME"
+security_deny_unknown \- get the preferable behavior on undefined object classes and access vectores
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B int security_deny_unknown(void);
+
+.SH "DESCRIPTION"
+.B security_deny_unknown
+returns 0 if SELinux allows undefined actions or actions on undefined object classes, 1 if not allowed, and -1 on error.
+Application should perform according to the result when
+.B string_to_security_class
+or
+.B string_to_av_perm
+return invalid value which means the current policy does not support required ones.
+
+.SH "SEE ALSO"
+.BR string_to_security_class (3),
+.BR string_to_av_perm (3),
+.BR selinux (8)
diff --git a/libselinux/src/deny_unknown.c b/libselinux/src/deny_unknown.c
index e69de29..c93998a 100644
--- a/libselinux/src/deny_unknown.c
+++ b/libselinux/src/deny_unknown.c
@@ -0,0 +1,40 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include <stdio.h>
+#include <limits.h>
+
+int security_deny_unknown(void)
+{
+	int fd, ret, deny_unknown = 0;
+	char path[PATH_MAX];
+	char buf[20];
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof(path), "%s/deny_unknown", selinux_mnt);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	memset(buf, 0, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (ret < 0)
+		return -1;
+
+	if (sscanf(buf, "%d", &deny_unknown) != 1)
+		return -1;
+
+	return deny_unknown;
+}
+
+hidden_def(security_deny_unknown);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8b4c6d4..5c551d4 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -51,6 +51,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(setsockcreatecon_raw)
     hidden_proto(security_getenforce)
     hidden_proto(security_setenforce)
+    hidden_proto(security_deny_unknown)
     hidden_proto(selinux_binary_policy_path)
     hidden_proto(selinux_default_context_path)
     hidden_proto(selinux_securetty_types_path)

--------------090105080301080909060109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
