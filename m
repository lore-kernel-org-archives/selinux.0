Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5BKiiVa009666
 for <selinux@tycho.nsa.gov>; Sun, 11 Jun 2017 16:44:45 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7DCC1564678
 for <selinux@tycho.nsa.gov>; Sun, 11 Jun 2017 22:44:39 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol: destroy the expanded level when
 mls_semantic_level_expand() fails
Date: Sun, 11 Jun 2017 22:44:16 +0200
Message-Id: <20170611204416.5550-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In mls_semantic_range_expand(), when a call to
mls_semantic_level_expand() fails, the function destroys the semantic
level instead of the expanded one. This leads to a use-after-free which
is reported by gcc's Address Sanitizer:

libsepol.mls_semantic_level_expand: mls_semantic_level_expand: invalid sensitivity level found 128/0.
libsepol.sepol_module_package_read: invalid module in module package (at section 0)
Failed to read policy package
=================================================================
==24456==ERROR: AddressSanitizer: heap-use-after-free on address 0x60200000ee58 at pc 0x7fe6c4fb96b4 bp 0x7fffa5ea6b70 sp 0x7fffa5ea6b60
READ of size 8 at 0x60200000ee58 thread T0
    #0 0x7fe6c4fb96b3 in mls_semantic_level_destroy /usr/src/selinux/libsepol/src/mls.c:755
    #1 0x7fe6c4fb9b88 in mls_semantic_range_destroy /usr/src/selinux/libsepol/src/mls.c:802
    #2 0x7fe6c500e8ab in user_datum_destroy /usr/src/selinux/libsepol/src/policydb.c:535
    #3 0x7fe6c500e980 in user_destroy /usr/src/selinux/libsepol/src/policydb.c:1390
    #4 0x7fe6c4f36c48 in hashtab_map /usr/src/selinux/libsepol/src/hashtab.c:235
    #5 0x7fe6c50152da in symtabs_destroy /usr/src/selinux/libsepol/src/policydb.c:1595
    #6 0x7fe6c5015433 in policydb_destroy /usr/src/selinux/libsepol/src/policydb.c:1503
    #7 0x7fe6c5040e0d in sepol_policydb_free /usr/src/selinux/libsepol/src/policydb_public.c:82
    #8 0x7fe6c4fbc503 in sepol_module_package_free /usr/src/selinux/libsepol/src/module.c:143
    #9 0x7fe6c4fefefb in sepol_ppfile_to_module_package /usr/src/selinux/libsepol/src/module_to_cil.c:4293
    #10 0x401e51 in main /usr/src/selinux/policycoreutils/hll/pp/pp.c:124
    #11 0x7fe6c4add510 in __libc_start_main (/usr/lib/libc.so.6+0x20510)
    #12 0x402589 in _start (/usr/src/selinux/DESTDIR/usr/libexec/selinux/hll/pp+0x402589)

0x60200000ee58 is located 8 bytes inside of 16-byte region [0x60200000ee50,0x60200000ee60)
freed by thread T0 here:
    #0 0x7fe6c5537ae0 in __interceptor_free /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:45
    #1 0x7fe6c4fb969b in mls_semantic_level_destroy /usr/src/selinux/libsepol/src/mls.c:757
    #2 0x7fe6c4f02a57 in mls_semantic_range_expand /usr/src/selinux/libsepol/src/expand.c:948
    #3 0x7fe6c5007a98 in policydb_user_cache /usr/src/selinux/libsepol/src/policydb.c:939
    #4 0x7fe6c4f36c48 in hashtab_map /usr/src/selinux/libsepol/src/hashtab.c:235
    #5 0x7fe6c5013859 in policydb_index_others /usr/src/selinux/libsepol/src/policydb.c:1286
    #6 0x7fe6c5020b65 in policydb_read /usr/src/selinux/libsepol/src/policydb.c:4342
    #7 0x7fe6c4fc0cdb in sepol_module_package_read /usr/src/selinux/libsepol/src/module.c:618
    #8 0x7fe6c4ff008d in sepol_ppfile_to_module_package /usr/src/selinux/libsepol/src/module_to_cil.c:4276
    #9 0x401e51 in main /usr/src/selinux/policycoreutils/hll/pp/pp.c:124
    #10 0x7fe6c4add510 in __libc_start_main (/usr/lib/libc.so.6+0x20510)

previously allocated by thread T0 here:
    #0 0x7fe6c5537e40 in __interceptor_malloc /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:62
    #1 0x7fe6c5004efc in mls_read_semantic_level_helper /usr/src/selinux/libsepol/src/policydb.c:1976
    #2 0x7fe6c500f596 in mls_read_semantic_range_helper /usr/src/selinux/libsepol/src/policydb.c:2010
    #3 0x7fe6c500f596 in user_read /usr/src/selinux/libsepol/src/policydb.c:3258
    #4 0x7fe6c502055b in policydb_read /usr/src/selinux/libsepol/src/policydb.c:4286
    #5 0x7fe6c4fc0cdb in sepol_module_package_read /usr/src/selinux/libsepol/src/module.c:618
    #6 0x7fe6c4ff008d in sepol_ppfile_to_module_package /usr/src/selinux/libsepol/src/module_to_cil.c:4276
    #7 0x401e51 in main /usr/src/selinux/policycoreutils/hll/pp/pp.c:124
    #8 0x7fe6c4add510 in __libc_start_main (/usr/lib/libc.so.6+0x20510)

SUMMARY: AddressSanitizer: heap-use-after-free /usr/src/selinux/libsepol/src/mls.c:755 in mls_semantic_level_destroy
Shadow bytes around the buggy address:
  0x0c047fff9d70: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d90: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9da0: fa fa fa fa fa fa fa fa fa fa 01 fa fa fa 01 fa
  0x0c047fff9db0: fa fa 01 fa fa fa 01 fa fa fa 01 fa fa fa 01 fa
=>0x0c047fff9dc0: fa fa 00 00 fa fa 00 00 fa fa fd[fd]fa fa fd fd
  0x0c047fff9dd0: fa fa fd fd fa fa fd fd fa fa fd fa fa fa fd fd
  0x0c047fff9de0: fa fa 04 fa fa fa 00 01 fa fa fd fd fa fa fd fd
  0x0c047fff9df0: fa fa fd fd fa fa fd fd fa fa 00 00 fa fa fd fd
  0x0c047fff9e00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9e10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==24456==ABORTING

This issue has been found while fuzzing hll/pp with the American Fuzzy
Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 283c93a803ce..6f1b235e92e2 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -939,7 +939,7 @@ int mls_semantic_range_expand(mls_semantic_range_t * sr, mls_range_t * r,
 		return -1;
 
 	if (mls_semantic_level_expand(&sr->level[1], &r->level[1], p, h) < 0) {
-		mls_semantic_level_destroy(&sr->level[0]);
+		mls_level_destroy(&r->level[0]);
 		return -1;
 	}
 
-- 
2.13.0
