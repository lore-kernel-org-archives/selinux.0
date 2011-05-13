Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4D7rVCK023968
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2011 03:53:31 -0400
Received: from nm3.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p4D7rTJO003819
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2011 07:53:29 GMT
Message-ID: <341576.18480.qm@web87002.mail.ird.yahoo.com>
Date: Fri, 13 May 2011 08:53:28 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Patch Review Process - Missing patch for selinux_set_mapping
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4DC84776.8080708@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve,

This patch is missing from your list. I sent on March 30th:

[PATCH 1/1] mapping fix for invalid class/perms after selinux_set_mapping call‏

Please find another libselinux patch. I've tested quite extensively with the compute_av and string functions with and without mapping and seems okay.  

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

If you need me to re-submit for latest git let me know.

Richard


--- On Mon, 9/5/11, Steve Lawrence <slawrence@tresys.com> wrote:

> From: Steve Lawrence <slawrence@tresys.com>
> Subject: Re: Patch Review Process
> To: "Guido Trentalancia" <guido@trentalancia.com>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Date: Monday, 9 May, 2011, 20:58
> On 05/09/2011 03:21 PM, Guido
> Trentalancia wrote:
> > Hello Steve !
> > 
> > On Mon, 2011-05-09 at 11:14 -0400, Steve Lawrence
> wrote:
> >> Recently, I've not been merging patches at the
> rate that I would like.
> >> The delay is a problem itself, but it has also
> meant that people aren't
> >> certain of the status of the patches that have
> been submitted.
> >>
> > [cut]
> >>
> >> Finally, if anyone has any suggestions on ways to
> make the patch review
> >> process better, my ears are all open.
> > 
> > Yes, adding at least the name and/or email address of
> the submitter to
> > the "Current Patch Queue" will probably help.
> > 
> > Regards,
> > 
> > Guido
> 
> Sounds reasonable to me. The patch queue with names and
> emails is below:
> 
> Current Patch Queue:
> 
> checkpolicy: fix filename identifier
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=130442985211760&w=2
> 
> selabel_open fix processing of substitution files (update)
> Richard Haines <richard_c_haines@btinternet.com>
> http://marc.info/?l=selinux&m=130314146920796&w=2
> 
> selinux_file_context_verify function returns wrong value
> Richard Haines <richard_c_haines@btinternet.com>
> http://marc.info/?l=selinux&m=129968866831934&w=2
> 
> Fix boolean handling in semanage
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=125433524126271&w=2
> 
> Add modules support to semanage
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=125433587727297&w=2
> 
> sandbox changes
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226611027331&w=2
> 
> libselinux mountpoint changing
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=130444622801373&w=2
> 
> Add note to checkmodule man page about versions
> Jason Axelson <jaxelson@referentia.com>
> http://marc.info/?l=selinux&m=127913558418720&w=2
> 
> Bug in restorecond for the first user logged in
> Chris Adams <cmadams@hiwaay.net>
> http://marc.info/?t=128164314700001&r=1&w=2
> 
> transactions in semanage man page
> Russell Coker <russell@coker.com.au>
> http://marc.info/?l=selinux&m=127959379422398&w=2
> 
> libsemanage python3 support
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=128025784525867&w=2
> 
> libselinux python3 support
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226509225674&w=2
> 
> SETools patch: adding exclude type feature in queries
> Roberto Sassu <roberto.sassu@polito.it>
> http://marc.info/?l=selinux&m=128448149528834&w=2
> 
> Move newrole to file caps/libcapng
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226621227513&w=2
> 
> Improve semodule performance
> Matthew Robertson <Matthew.L.Robertson@boeing.com>
> http://marc.info/?l=selinux&m=128043503603540&w=2
> 
> Fix warning messages generated by GCC 4.6
> Justin P. Mattock <justinmattock@gmail.com>
> http://marc.info/?l=selinux&m=127845525722194&w=2
> 
> sepolgen kernel policy version check
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=128948444127169&w=2
> 
> Remove DEFAULTUSER handling from get_context_list
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226509425687&w=2
> 
> sepolgen current patch from Fedora
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226551726416&w=2
> 
> Improved error message for load_policy
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226567426640&w=2
> 
> Semanage patch
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129233335310866&w=2
> 
> restorecond: Ignore IN_IGNORED inotify events
> Martin Orr <martin@martinorr.name>
> http://marc.info/?l=selinux&m=125380417916233&w=2
> 
> setfiles/restorecond patch
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226589026919&w=2
> 
> policycoreutils:  update audit2allow manpage
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129304945226866&w=2
> 
> libsemanage: include MCS/MLS level when generating
> files_contexts.homedirs
> Russell Coker <russell@coker.com.au>
> http://marc.info/?l=selinux&m=129421658323663&w=2
> 
> setfiles: provide an option to avoid abortion on a missing
> file
> Guido Trentalancia <guido@trentalancia.com>
> http://marc.info/?l=selinux&m=129819885027010&w=2
> 
> minor improvements and clean-ups for setfiles
> Guido Trentalancia <guido@trentalancia.com>
> http://marc.info/?l=selinux&m=129819262321520&w=2
> 
> policycoreutils scripts updates
> Daniel J Walsh <dwalsh@redhat.com>
> http://marc.info/?l=selinux&m=129226648427897&w=2
> 
> Fix options for policycoreutils binaries
> Guido Trentalancia <guido@trentalancia.com>
> http://marc.info/?l=selinux&m=125718355929168&w=2
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
