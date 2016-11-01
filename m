From: william.c.roberts@intel.com
To: nicolas.iooss@m4x.org, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] libselinux: fix compiler flags for linux + clang
Date: Tue,  1 Nov 2016 13:23:24 -0700
Message-Id: <1478031804-13993-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

As reported by Nicolas Iooss, the clang + linux build seems
broken:

 clang-3.9: warning: argument unused during compilation: '-undefined
dynamic_lookup'
  /usr/bin/ld: unrecognised option: -install_name
  clang-3.9: error: linker command failed with exit code 1 (use -v to
see invocation)

We already have those options set for Darwin, just drop them from the
clang side.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ae40f80..b92fe1c 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -73,13 +73,12 @@ override CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
 else
 override CFLAGS += -Wunused-command-line-argument
-override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
-LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include
 override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
+LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
 PCRE_LDFLAGS ?= -lpcre
-- 
2.7.4
