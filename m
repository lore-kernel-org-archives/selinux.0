Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6QG8JWO009595
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 12:08:19 -0400
Received: from nm2.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p6QG8Ile012446
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 16:08:18 GMT
Message-ID: <1311696497.4797.YahooMailClassic@web87014.mail.ird.yahoo.com>
Date: Tue, 26 Jul 2011 17:08:17 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Incoming flood of updates to SELinux userspace - Missing patch
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E27324A.50309@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Eric, this patch is missing from your list.

[PATCH 1/1] mapping fix for invalid class/perms after selinux_set_mapping call‏

The patch covers:
When selinux_set_mapping(3) is used to set the class and permissions allowed by an object manager, then an invalid class and/or permissions are selected (e.g. using security_class_to_string), then mapping.c in libselinux forces an assert. This patch removes the asserts and allows the functions to return a class/perm of 0 (unknown) with errno set to EINVAL. A minor patch to set EINVAL in security_av_perm_to_string_compat is also included. All the functions to convert perms & classes to strings and back should now return the correct errno with or without mapping enabled.


---
libselinux/src/mapping.c   |   41 ++++++++++++++++++++++++++++-------------
libselinux/src/stringrep.c |    4 +++-
2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index f9858ce..5bbb450 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -6,7 +6,6 @@
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
-#include <assert.h>
#include <selinux/selinux.h>
#include <selinux/avc.h>
#include "mapping.h"
@@ -103,8 +102,13 @@ unmap_class(security_class_t tclass)
    if (tclass < current_mapping_size)
        return current_mapping[tclass].value;

-    assert(current_mapping_size == 0);
-    return tclass;
+    /* If here no mapping set or the class requested is not valid. */
+    if (current_mapping_size != 0) {
+        errno = EINVAL;
+        return 0;
+    }
+    else
+        return tclass;
}

access_vector_t
@@ -116,16 +120,19 @@ unmap_perm(security_class_t tclass, access_vector_t tperm)

        for (i=0; i<current_mapping[tclass].num_perms; i++)
            if (tperm & (1<<i)) {
-                assert(current_mapping[tclass].perms[i]);
                kperm |= current_mapping[tclass].perms[i];
                tperm &= ~(1<<i);
            }
-        assert(tperm == 0);
        return kperm;
    }

-    assert(current_mapping_size == 0);
-    return tperm;
+    /* If here no mapping set or the perm requested is not valid. */
+    if (current_mapping_size != 0) {
+        errno = EINVAL;
+        return 0;
+    }
+    else
+        return tperm;
}

/*
@@ -141,8 +148,13 @@ map_class(security_class_t kclass)
        if (current_mapping[i].value == kclass)
            return i;

-    assert(current_mapping_size == 0);
-    return kclass;
+/* If here no mapping set or the class requested is not valid. */
+    if (current_mapping_size != 0) {
+        errno = EINVAL;
+        return 0;
+    }
+    else    
+        return kclass;
}

access_vector_t
@@ -157,11 +169,14 @@ map_perm(security_class_t tclass, access_vector_t kperm)
                tperm |= 1<<i;
                kperm &= ~current_mapping[tclass].perms[i];
            }
-        assert(kperm == 0);
-        return tperm;
-    }

-    assert(current_mapping_size == 0);
+        if (tperm == 0) {
+            errno = EINVAL;
+            return 0;
+        }
+        else
+            return tperm;
+    }
    return kperm;
}

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index b19bce7..f0167e7 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -401,8 +401,10 @@ static const char *security_av_perm_to_string_compat(security_class_t tclass,
    access_vector_t common_base = 0;
    unsigned int i;

-    if (!av)
+    if (!av) {
+        errno = EINVAL;
        return NULL;
+    }

    for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
        if (av_inherit[i].tclass == tclass) {
-- 
1.7.3.2



Richard

--- On Wed, 20/7/11, Eric Paris <eparis@redhat.com> wrote:

> From: Eric Paris <eparis@redhat.com>
> Subject: Incoming flood of updates to SELinux userspace
> To: selinux@tycho.nsa.gov
> Date: Wednesday, 20 July, 2011, 20:53
> I decided to take on as a personal
> challenge the effort of trying to get
> everything that Fedora and Red Hat have done with SELinux
> userspace into
> the upstream trees.  My process has been to try to
> pick apart the
> gigantic patch that Fedora carries and break that into
> reasonable size
> patches with descriptive and meaningful changelogs. 
> As I'm breaking
> them up I'm also attempting to review them for
> appropriateness of
> inclusion.  As I find that patches that I either think
> are wrong, or I
> can't explain, or whatever, I'm also committing those to my
> tree, but
> trying to make sure it is clear that is the case.  I
> would quickly like
> to switch Fedora to using my tree as its 'upstream' instead
> of the
> Tresys tree.  Remember, my tree is going to contain
> everything in
> Fedora, even if I don't think it's a good idea or ready to
> be merged
> with the real upstream tree.
> 
> I've asked Dan (and everyone) to start reviewing patches in
> my tree a
> couple per day.  He is going to send an e-mail to this
> list stating that
> he believes a patch is ready to commit.  If both Dan
> and I agree that
> the patch in question is appropriate for upstream I will
> commit it to
> the real upstream repo.  As I commit patches upstream
> every day I will
> rebase my private tree.  My private tree is NOT
> stable.
> 
> If you would like to participate, PLEASE DO! 
> Reviewing patches is easy!
>  All you have to do is:
> 
> git clone http://oss.tresys.com/git/selinux.git
> selinux-userspace
> cd selinux-userspace
> edit .git/config and add:
> 
> [remote "eparis"]
>        fetch =
> +refs/heads/*:refs/remotes/eparis/*
>        url =
> git://git.infradead.org/users/eparis/selinux-userspace.git
> 
> git remote update
> git format-patch -o /tmp/patches/
> origin/master..eparis/master
> 
> I'd suggest that every day you wish to review you run:
> 
> rm -rf /tmp/patches
> git remote update
> git format-patch -o /tmp/patches/
> origin/master..eparis/master
> 
> Because my repo will be constantly rebasing and changing as
> I push
> patches into the upstream repo.
> 
> If you have ever posted a patch for SELinux userspace and
> you don't find
> it in my tree, in my mind it's lost forever.  Please
> resend it.  Just
> because I put it in my tree doesn't mean it's going to go
> upstream, but
> if I don't put it in my private tracking tree, we can rest
> assured it's
> not headed that way!
> 
> Please let me know if anyone has any problems, thoughts,
> concerns,
> issues, or comments about how I'm doing things!
> 
> -Eric
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
