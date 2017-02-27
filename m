Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnve023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:55 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6574A56065D
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:53 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/6] libselinux: initialize temp value in SWIG wrapper to
 prevent freeing garbage
Date: Mon, 27 Feb 2017 21:39:35 +0100
Message-Id: <20170227203935.23674-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently this Python program triggers a segmentation fault in
libselinux SWIG wrapper:

    import selinux
    selinux.get_ordered_context_list()

gdb shows that the segmentation fault occurs when freeing some memory:

    Reading symbols from python...(no debugging symbols found)...done.
    Starting program: /usr/bin/python -c import\
    selinux\;selinux.get_ordered_context_list\(\)
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/usr/lib/libthread_db.so.1".

    Program received signal SIGSEGV, Segmentation fault.
    0x00007ffff789a304 in free () from /usr/lib/libc.so.6
    (gdb) bt
    #0  0x00007ffff789a304 in free () from /usr/lib/libc.so.6
    #1  0x00007ffff6011499 in freeconary (con=0x7ffff6ac5d00) at
    freeconary.c:14
    #2  0x00007ffff6296899 in _wrap_get_ordered_context_list
    (self=<optimized out>, args=<optimized out>) at
    selinuxswig_wrap.c:6185
    #3  0x00007ffff741891f in _PyCFunction_FastCallDict () from
    /usr/lib/libpython3.6m.so.1.0
    ...

SWIG generated the following code for _wrap_get_ordered_context_list():

    char ***arg3 = (char ***) 0 ;
    char **temp3 ;
    arg3 = &temp3;
    if (!PyArg_ParseTuple(args, "OO:get_ordered_context_list",&obj0,&obj1))
        SWIG_fail;
    /* ... */
  fail:
    if (*arg3) freeconary(*arg3);

If PyArg_ParseTuple fails, freeconary() is called on the value of
"temp3", which has not been initialized. Fix this by initializing temp
to NULL in the SWIG template.

A similar issue exists with security_get_boolean_names(). Fix it too.

This issue has been found using clang's static analyzer, on a system
which uses SWIG 3.0.12.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinuxswig.i | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinuxswig.i b/libselinux/src/selinuxswig.i
index 687c43bc6d7d..dbdb4c3d72d4 100644
--- a/libselinux/src/selinuxswig.i
+++ b/libselinux/src/selinuxswig.i
@@ -18,7 +18,7 @@
 %typedef unsigned mode_t;
 %typedef unsigned pid_t;
 
-%typemap(in, numinputs=0) (char ***names, int *len) (char **temp1, int temp2) {
+%typemap(in, numinputs=0) (char ***names, int *len) (char **temp1=NULL, int temp2) {
 	$1 = &temp1;
 	$2 = &temp2;
 }
@@ -33,7 +33,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) (char ***) (char **temp) {
+%typemap(in, numinputs=0) (char ***) (char **temp=NULL) {
 	$1 = &temp;
 }
 
-- 
2.11.1
