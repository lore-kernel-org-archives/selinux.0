Date: Thu, 20 Feb 2014 15:42:25 +0000
From: Colin Walters <walters@verbum.org>
Subject: [PATCH] selinux: Only attempt to load policy exactly once, in the
 real root
To: SELinux-NSA <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xK4JJQqGk1bWAiw/VVvt"
Message-Id: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-xK4JJQqGk1bWAiw/VVvt
Content-Type: multipart/alternative; boundary="=-g3D/w43wcDHh75dYPFTQ"

--=-g3D/w43wcDHh75dYPFTQ
Content-Type: text/plain; charset=utf-8; format=flowed

Currently on at least Fedora, SELinux policy does not come in
the initramfs. systemd will attempt to load *both* in the
initramfs and in the real root.

Now, the selinux_init_load_policy() API has a regular error return
value, as well as an "enforcing" boolean. To determine enforcing
state, it looks for /etc/selinux/config as well as the presence
of "enforcing=" on the kernel command line.

Ordinarily, neither of those exist in the initramfs, so it will return
"unknown" for enforcing, and systemd will simply ignore the failure to
load policy.

Then later after we switch to the real root, we have the config file,
and all will work properly.

Except...this all blows up if someone explicitly specifies enforcing=1
on the kernel command line. Then systemd will fail to load the
nonexistent policy in the initramfs and freeze.

What this patch does is quite simple - we add an internal API that
says where we expect to find policy, and attempt to load it exactly
from there. Right now since I'm not aware of anyone who does
policy-in-initramfs, this function is hardcoded to return false.

Lots-of-very-painful-debugging-by: Colin Walters <walters@verbum.org>
---
 src/core/main.c | 6 ++++--
 src/core/selinux-setup.c | 10 ++++++++++
 src/core/selinux-setup.h | 2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)




--=-g3D/w43wcDHh75dYPFTQ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently on at least Fedora, SELinux policy does not come in<div>the initr=
amfs.  systemd will attempt to load *both* in the</div><div>initramfs and i=
n the real root.</div><div><br></div><div>Now, the selinux_init_load_policy=
() API has a regular error return</div><div>value, as well as an "enforcing=
" boolean.  To determine enforcing</div><div>state, it looks for /etc/selin=
ux/config as well as the presence</div><div>of "enforcing=3D" on the kernel=
 command line.</div><div><br></div><div>Ordinarily, neither of those exist =
in the initramfs, so it will return</div><div>"unknown" for enforcing, and =
systemd will simply ignore the failure to</div><div>load policy.</div><div>=
<br></div><div>Then later after we switch to the real root, we have the con=
fig file,</div><div>and all will work properly.</div><div><br></div><div>Ex=
cept...this all blows up if someone explicitly specifies enforcing=3D1</div=
><div>on the kernel command line.  Then systemd will fail to load the</div>=
<div>nonexistent policy in the initramfs and freeze.</div><div><br></div><d=
iv>What this patch does is quite simple - we add an internal API that</div>=
<div>says where we expect to find policy, and attempt to load it exactly</d=
iv><div>from there.  Right now since I'm not aware of anyone who does</div>=
<div>policy-in-initramfs, this function is hardcoded to return false.</div>=
<div><br></div><div>Lots-of-very-painful-debugging-by: Colin Walters &lt;wa=
lters@verbum.org&gt;</div><div>---</div><div>&nbsp;src/core/main.c         =
 |  6 ++++--</div><div>&nbsp;src/core/selinux-setup.c | 10 ++++++++++</div>=
<div>&nbsp;src/core/selinux-setup.h |  2 ++</div><div>&nbsp;3 files changed=
, 16 insertions(+), 2 deletions(-)</div><div><br></div><div><br></div>=

--=-g3D/w43wcDHh75dYPFTQ--

--=-xK4JJQqGk1bWAiw/VVvt
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-selinux-Only-attempt-to-load-policy-exactly-once-in-.patch

>From b109b6e0c1ea7509f08a09d66072c86bea279a06 Mon Sep 17 00:00:00 2001
From: Colin Walters <walters@verbum.org>
Date: Thu, 20 Feb 2014 10:15:10 -0500
Subject: [PATCH] selinux: Only attempt to load policy exactly once, in the
 real root

Currently on at least Fedora, SELinux policy does not come in
the initramfs.  systemd will attempt to load *both* in the
initramfs and in the real root.

Now, the selinux_init_load_policy() API has a regular error return
value, as well as an "enforcing" boolean.  To determine enforcing
state, it looks for /etc/selinux/config as well as the presence
of "enforcing=" on the kernel command line.

Ordinarily, neither of those exist in the initramfs, so it will return
"unknown" for enforcing, and systemd will simply ignore the failure to
load policy.

Then later after we switch to the real root, we have the config file,
and all will work properly.

Except...this all blows up if someone explicitly specifies enforcing=1
on the kernel command line.  Then systemd will fail to load the
nonexistent policy in the initramfs and freeze.

What this patch does is quite simple - we add an internal API that
says where we expect to find policy, and attempt to load it exactly
from there.  Right now since I'm not aware of anyone who does
policy-in-initramfs, this function is hardcoded to return false.

Lots-of-very-painful-debugging-by: Colin Walters <walters@verbum.org>
---
 src/core/main.c          |  6 ++++--
 src/core/selinux-setup.c | 10 ++++++++++
 src/core/selinux-setup.h |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/core/main.c b/src/core/main.c
index 58c3a9e..8a13b54 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -1296,8 +1296,10 @@ int main(int argc, char *argv[]) {
 
                 if (!skip_setup) {
                         mount_setup_early();
-                        if (selinux_setup(&loaded_policy) < 0)
-                                goto finish;
+                        if (in_initrd() == selinux_load_policy_in_initramfs()) {
+                                if (selinux_setup(&loaded_policy) < 0)
+                                        goto finish;
+                        }
                         if (ima_setup() < 0)
                                 goto finish;
                         if (smack_setup() < 0)
diff --git a/src/core/selinux-setup.c b/src/core/selinux-setup.c
index 7a32ed5..f689149 100644
--- a/src/core/selinux-setup.c
+++ b/src/core/selinux-setup.c
@@ -37,6 +37,16 @@
 #include "util.h"
 #include "log.h"
 
+/**
+ * At present, I'm not aware of a SELinux user who loads the policy
+ * from the initramfs.  If you are such a user, you can flip this
+ * define with a patch.  Alternatively in the future, this information
+ * could come from the kernel command line.
+ */
+bool selinux_load_policy_in_initramfs(void) {
+        return false;
+}
+
 #ifdef HAVE_SELINUX
 static int null_log(int type, const char *fmt, ...) {
         return 0;
diff --git a/src/core/selinux-setup.h b/src/core/selinux-setup.h
index 39e2bc2..d3f3bbc 100644
--- a/src/core/selinux-setup.h
+++ b/src/core/selinux-setup.h
@@ -23,4 +23,6 @@
 
 #include <stdbool.h>
 
+bool selinux_load_policy_in_initramfs(void);
+
 int selinux_setup(bool *loaded_policy);
-- 
1.8.3.1


--=-xK4JJQqGk1bWAiw/VVvt--
