From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix off-by-one in setprocattr
Date: Tue, 31 Jan 2017 11:54:04 -0500
Message-Id: <1485881644-17740-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux tries to support setting/clearing of /proc/pid/attr attributes
from the shell by ignoring terminating newlines and treating an
attribute value that begins with a NUL or newline as an attempt to
clear the attribute.  However, the test for clearing attributes has
always been wrong; it has an off-by-one error, and this could further
lead to reading past the end of the allocated buffer since commit
bb646cdb12e75d82258c2f2e7746d5952d3e321a ("proc_pid_attr_write():
switch to memdup_user()").  Fix the off-by-one error.

Even with this fix, setting and clearing /proc/pid/attr attributes
from the shell is not straightforward since the interface does not
support multiple write() calls (so shells that write the value and
newline separately will set and then immediately clear the attribute,
requiring use of echo -n to set the attribute), whereas trying to use
echo -n "" to clear the attribute causes the shell to skip the
write() call altogether since POSIX says that a zero-length write
causes no side effects. Thus, one must use echo -n to set and echo
without -n to clear, as in the following example:
$ echo -n unconfined_u:object_r:user_home_t:s0 > /proc/$$/attr/fscreate
$ cat /proc/$$/attr/fscreate
unconfined_u:object_r:user_home_t:s0
$ echo "" > /proc/$$/attr/fscreate
$ cat /proc/$$/attr/fscreate

Note the use of /proc/$$ rather than /proc/self, as otherwise
the cat command will read its own attribute value, not that of the shell.

There are no users of this facility to my knowledge; possibly we
should just get rid of it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a5398fe..6a047bf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5882,7 +5882,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		return error;
 
 	/* Obtain a SID for the context, if one was specified. */
-	if (size && str[1] && str[1] != '\n') {
+	if (size && str[0] && str[0] != '\n') {
 		if (str[size-1] == '\n') {
 			str[size-1] = 0;
 			size--;
-- 
2.7.4
