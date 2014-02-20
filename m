Date: Thu, 20 Feb 2014 23:44:04 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
To: Eric Paris <eparis@parisplace.org>
In-Reply-To: <20140220212635.7EC19C007AB@frontend1.nyi.mail.srv.osa>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
 <53065B50.1030004@redhat.com>
 <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
 <CACLa4psP63Q7YYMxVA1Ei6r6AmDSrCGn+=q0-ZFrawUF2apQMA@mail.gmail.com>
 <20140220212635.7EC19C007AB@frontend1.nyi.mail.srv.osa>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-a6lhHhW+9yyTfYKf7NFi"
Message-Id: <20140220234907.001CFC007AA@frontend1.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-a6lhHhW+9yyTfYKf7NFi
Content-Type: multipart/alternative; boundary="=-DfjTXqF6DbNczYKaVpdP"

--=-DfjTXqF6DbNczYKaVpdP
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, Feb 20, 2014 at 4:21 PM, Colin Walters <walters@verbum.org> 
wrote:
> 
> I'm testing this suggested patch now.
> 
I tweaked the suggestion a bit because the selinux_path() API call made 
the most sense inside selinux-setup.c.  Attached patch works for me.




--=-DfjTXqF6DbNczYKaVpdP
Content-Type: text/html; charset=utf-8

On Thu, Feb 20, 2014 at 4:21 PM, Colin Walters &lt;walters@verbum.org&gt; wrote:<br>
<blockquote type="cite"><div><br></div><div>I'm testing this suggested patch now.</div></blockquote><br><div>I tweaked the suggestion a bit because the selinux_path() API call made the most sense inside selinux-setup.c. &nbsp;Attached patch works for me.</div><div><br></div><div><br></div>
--=-DfjTXqF6DbNczYKaVpdP--

--=-a6lhHhW+9yyTfYKf7NFi
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-selinux-Don-t-attempt-to-load-policy-in-initramfs-if.patch

>From ae5f54b4d34320528db8fd1bb24ab7479d081594 Mon Sep 17 00:00:00 2001
From: Colin Walters <walters@verbum.org>
Date: Thu, 20 Feb 2014 10:15:10 -0500
Subject: [PATCH] selinux: Don't attempt to load policy in initramfs if it
 doesn't exist

Currently on at least Fedora, SELinux policy does not come in the
initramfs.  systemd will attempt to load *both* in the initramfs and
in the real root.

Now, the selinux_init_load_policy() API has a regular error return
value, as well as an "enforcing" boolean.  To determine enforcing
state, it looks for /etc/selinux/config as well as the presence of
"enforcing=" on the kernel command line.

Ordinarily, neither of those exist in the initramfs, so it will return
"unknown" for enforcing, and systemd will simply ignore the failure to
load policy.

Then later after we switch to the real root, we have the config file,
and all will work properly.

Except...this all blows up if someone explicitly specifies enforcing=1
on the kernel command line.  Then systemd will fail to load the
nonexistent policy in the initramfs and freeze.

This patch tweaks the logic so we attempt to load policy from the
initramfs only if we see it exists.  We always attempt to load from
the real root - but selinux_setup() is a noop if policy is already
loaded, so the case of "policy successfully loaded in initramfs, not
in the real root" will work.

Lots-of-very-painful-debugging-by: Colin Walters <walters@verbum.org>
---
 src/core/main.c          | 2 +-
 src/core/selinux-setup.c | 9 ++++++++-
 src/core/selinux-setup.h | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/core/main.c b/src/core/main.c
index 58c3a9e..49f237a 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -1296,7 +1296,7 @@ int main(int argc, char *argv[]) {
 
                 if (!skip_setup) {
                         mount_setup_early();
-                        if (selinux_setup(&loaded_policy) < 0)
+                        if (selinux_setup(in_initrd(), &loaded_policy) < 0)
                                 goto finish;
                         if (ima_setup() < 0)
                                 goto finish;
diff --git a/src/core/selinux-setup.c b/src/core/selinux-setup.c
index 7a32ed5..ee0ac32 100644
--- a/src/core/selinux-setup.c
+++ b/src/core/selinux-setup.c
@@ -43,7 +43,7 @@ static int null_log(int type, const char *fmt, ...) {
 }
 #endif
 
-int selinux_setup(bool *loaded_policy) {
+int selinux_setup(bool in_initrd, bool *loaded_policy) {
 
 #ifdef HAVE_SELINUX
        int enforce = 0;
@@ -54,6 +54,13 @@ int selinux_setup(bool *loaded_policy) {
 
        assert(loaded_policy);
 
+       /* Don't load policy in the initrd if we don't appear to have
+        * it.  For the real root, we check below if we've already
+        * loaded policy, and return gracefully.
+        */
+       if (in_initrd && access(selinux_path(), F_OK) == -1)
+               return 0;
+
        /* Turn off all of SELinux' own logging, we want to do that */
        cb.func_log = null_log;
        selinux_set_callback(SELINUX_CB_LOG, cb);
diff --git a/src/core/selinux-setup.h b/src/core/selinux-setup.h
index 39e2bc2..9291144 100644
--- a/src/core/selinux-setup.h
+++ b/src/core/selinux-setup.h
@@ -23,4 +23,4 @@
 
 #include <stdbool.h>
 
-int selinux_setup(bool *loaded_policy);
+int selinux_setup(bool in_initrd, bool *loaded_policy);
-- 
1.8.3.1


--=-a6lhHhW+9yyTfYKf7NFi--
