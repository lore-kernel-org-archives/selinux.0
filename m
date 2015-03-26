Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2QJV8Ei025427
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 15:31:08 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: Move secilc out of libsepol
Date: Thu, 26 Mar 2015 15:30:42 -0400
Message-ID: <1427398242-13577-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since the secilc compiler is independent of libsepol, move secilc out of
libsepol. Linke secilc dynamically rather than statically with libsepol.

- Move secilc source, test policies, docs, and secilc manpage to secilc
  directory.
- Remove unneeded Makefile from libsepol/cil. To build secilc, run make
  in the secilc directory.
- Add target to install the secilc binary to /usr/bin/.
- Create an Android makefile for secilc and move secilc out of libsepol
  Android makefile.
- Add cil_set_mls to libsepol public API as it is needed by secilc.
- Remove policy.conf from testing since it is no longer used.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 Makefile                                           |   2 +-
 libsepol/Android.mk                                |  15 ---
 libsepol/cil/Makefile                              | 102 ---------------
 libsepol/cil/test/policy.conf                      | 143 ---------------------
 libsepol/src/libsepol.map.in                       |   1 +
 secilc/.gitignore                                  |   6 +
 secilc/Android.mk                                  |  31 +++++
 {libsepol/cil => secilc}/COPYING                   |   0
 secilc/Makefile                                    |  47 +++++++
 {libsepol/cil => secilc}/README                    |  26 ++--
 .../cil => secilc}/docs/CIL_Reference_Guide.xml    |   0
 {libsepol/cil => secilc}/docs/Makefile             |  17 +--
 .../docs/cil_access_vector_rules.xml               |   0
 .../docs/cil_call_macro_statements.xml             |   0
 .../docs/cil_class_and_permission_statements.xml   |   0
 .../docs/cil_conditional_statements.xml            |   0
 .../docs/cil_constraint_statements.xml             |   0
 .../docs/cil_container_statements.xml              |   0
 .../cil => secilc}/docs/cil_context_statement.xml  |   0
 .../docs/cil_default_object_statements.xml         |   0
 {libsepol/cil => secilc}/docs/cil_design.dia       | Bin
 {libsepol/cil => secilc}/docs/cil_design.jpeg      | Bin
 .../docs/cil_file_labeling_statements.xml          |   0
 .../docs/cil_mls_labeling_statements.xml           |   0
 .../docs/cil_network_labeling_statements.xml       |   0
 .../docs/cil_policy_config_statements.xml          |   0
 .../cil => secilc}/docs/cil_role_statements.xml    |   0
 .../cil => secilc}/docs/cil_sid_statements.xml     |   0
 .../cil => secilc}/docs/cil_type_statements.xml    |   0
 .../cil => secilc}/docs/cil_user_statements.xml    |   0
 .../cil => secilc}/docs/cil_xen_statements.xml     |   0
 {libsepol/cil/docs => secilc}/secilc.8.xml         |   0
 {libsepol/cil => secilc}/secilc.c                  |  36 +++---
 {libsepol/cil => secilc}/test/block_test.cil       |   0
 {libsepol/cil => secilc}/test/in_test.cil          |   0
 {libsepol/cil => secilc}/test/integration.cil      |   0
 {libsepol/cil => secilc}/test/minimum.cil          |   0
 .../cil => secilc}/test/name_resolution_test.cil   |   0
 {libsepol/cil => secilc}/test/optional_test.cil    |   0
 {libsepol/cil => secilc}/test/policy.cil           |   0
 40 files changed, 116 insertions(+), 310 deletions(-)
 delete mode 100644 libsepol/cil/Makefile
 delete mode 100644 libsepol/cil/test/policy.conf
 create mode 100644 secilc/.gitignore
 create mode 100644 secilc/Android.mk
 rename {libsepol/cil => secilc}/COPYING (100%)
 create mode 100644 secilc/Makefile
 rename {libsepol/cil => secilc}/README (73%)
 rename {libsepol/cil => secilc}/docs/CIL_Reference_Guide.xml (100%)
 rename {libsepol/cil => secilc}/docs/Makefile (81%)
 rename {libsepol/cil => secilc}/docs/cil_access_vector_rules.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_call_macro_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_class_and_permission_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_conditional_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_constraint_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_container_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_context_statement.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_default_object_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_design.dia (100%)
 rename {libsepol/cil => secilc}/docs/cil_design.jpeg (100%)
 rename {libsepol/cil => secilc}/docs/cil_file_labeling_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_mls_labeling_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_network_labeling_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_policy_config_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_role_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_sid_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_type_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_user_statements.xml (100%)
 rename {libsepol/cil => secilc}/docs/cil_xen_statements.xml (100%)
 rename {libsepol/cil/docs => secilc}/secilc.8.xml (100%)
 rename {libsepol/cil => secilc}/secilc.c (90%)
 rename {libsepol/cil => secilc}/test/block_test.cil (100%)
 rename {libsepol/cil => secilc}/test/in_test.cil (100%)
 rename {libsepol/cil => secilc}/test/integration.cil (100%)
 rename {libsepol/cil => secilc}/test/minimum.cil (100%)
 rename {libsepol/cil => secilc}/test/name_resolution_test.cil (100%)
 rename {libsepol/cil => secilc}/test/optional_test.cil (100%)
 rename {libsepol/cil => secilc}/test/policy.cil (100%)

diff --git a/Makefile b/Makefile
index f71faab..93e10de 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils # policy
+SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy secilc policycoreutils # policy
 PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index ab4bcd1..3e4700b 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -135,18 +135,3 @@ LOCAL_SRC_FILES := $(common_src_files)
 LOCAL_MODULE_CLASS := STATIC_LIBRARIES
 
 include $(BUILD_STATIC_LIBRARY)
-
-##
-# secilc
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := secilc
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes)
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := cil/secilc.c
-LOCAL_STATIC_LIBRARIES := libsepol
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
diff --git a/libsepol/cil/Makefile b/libsepol/cil/Makefile
deleted file mode 100644
index 9f52ee4..0000000
--- a/libsepol/cil/Makefile
+++ /dev/null
@@ -1,102 +0,0 @@
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
-INCLUDEDIR ?= $(PREFIX)/include
-SRCDIR ?= ./src
-TESTDIR ?= ./test
-UNITDIR ?= $(TESTDIR)/unit
-LIBCILDIR ?= $(SRCDIR)
-
-LEX = flex
-
-DEBUG = 0
-
-SECILC = secilc
-
-UNIT = unit_tests
-
-SECILC_SRCS := secilc.c
-SECILC_OBJS := $(patsubst %.c,%.o,$(SECILC_SRCS))
-
-TEST_SRCS := $(wildcard $(UNITDIR)/*.c)
-TEST_OBJS := $(patsubst %.c,%.o,$(TEST_SRCS))
-
-LIBCIL_GENERATED := $(LIBCILDIR)/cil_lexer.c
-LIBCIL_SRCS  := $(wildcard $(LIBCILDIR)/*.c) $(LIBCIL_GENERATED)
-LIBCIL_OBJS := $(patsubst %.c,%.o,$(LIBCIL_SRCS))
-LIBCIL_INCLUDES := $(wildcard $(LIBCILDIR)/*.h)
-
-LIBCIL_STATIC := $(SRCDIR)/libcil.a
-
-LIBSEPOL_STATIC = /usr/lib/libsepol.a
-
-LIBS =
-LDFLAGS =
-COVCFLAGS = -fprofile-arcs -ftest-coverage -O0
-
-CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
-
-ifeq ($(DEBUG),1)
-	override CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -DDEBUG
-	override LDFLAGS += -g
-else
-	override CFLAGS += -O2
-endif
-
-override CFLAGS += -I./include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
-
-ARCH := $(patsubst i%86,i386,$(shell uname -m))
-ifneq (,$(filter i386,$(ARCH)))
-	TLSFLAGS += -mno-tls-direct-seg-refs
-endif
-ifneq (,$(filter x86_64,$(ARCH)))
-	override LDFLAGS += -I/usr/lib64
-	override LIBSEPOL_STATIC = /usr/lib64/libsepol.a
-endif
-
-all: $(SECILC)
-
-%.o: %.c $(LIBCIL_INCLUDES)
-	$(CC) $(CFLAGS) -c -o $@ $<
-
-$(LIBCIL_STATIC): $(LIBCIL_OBJS)
-	$(AR) rcs $@ $^
-	ranlib $@
-
-$(LIBCIL_GENERATED): $(LIBCILDIR)/cil_lexer.l
-	$(LEX) -t $< > $@
-
-$(UNIT): $(TEST_OBJS) $(LIBCIL_STATIC)
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBCIL_STATIC) $(LIBSEPOL_STATIC) $(LDFLAGS)
-
-$(SECILC): $(SECILC_OBJS) $(LIBCIL_STATIC)
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBCIL_STATIC) $(LIBSEPOL_STATIC) $(LDFLAGS)
-
-unit: $(SECILC) $(UNIT)
-
-# Requires lcov 1.9+ (--ignore-errors)
-coverage: CFLAGS += $(COVCFLAGS)
-coverage: clean unit
-	./unit_tests
-	test -d cov || mkdir cov
-	lcov --directory src --capture --output-file cov/app.info --ignore-errors source -b src
-	lcov --remove cov/app.info '/usr/include/*' --remove cov/app.info 'sepol/*' --output-file cov/app.info
-	genhtml -o ./cov/html ./cov/app.info
-
-test: $(SECILC)
-	./$(SECILC) test/policy.cil
-
-clean:
-	rm -f $(SECILC)
-	rm -f $(LIBCIL_STATIC)
-	rm -f $(TEST_OBJS) $(SECILC_OBJS)
-	rm -rf cov src/*.gcda src/*.gcno *.gcda *.gcno
-	rm -f $(LIBCIL_OBJS)
-
-bare: clean
-	rm -f $(LIBCIL_GENERATED)
-	rm -f $(UNIT)
-	rm -f policy.*
-	rm -f file_contexts
-
-.PHONY: all bare clean coverage test unit
diff --git a/libsepol/cil/test/policy.conf b/libsepol/cil/test/policy.conf
deleted file mode 100644
index 938af91..0000000
--- a/libsepol/cil/test/policy.conf
+++ /dev/null
@@ -1,143 +0,0 @@
-class file
-class process
-class char
-
-sid kernel
-sid security
-sid unlabeled
-
-common file {ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton }
-
-class file inherits file { execute_no_trans entrypoint execmod open audit_access }
-class char inherits file { foo transition }
-class process { open }
-
-sensitivity s0 alias sens0;
-sensitivity s1;
-
-dominance { s0 s1 }
-
-category c0 alias cat0;
-category c1;
-category c2;
-
-level s0:c0.c2;
-level s1:c0.c2;
-
-mlsconstrain file { open } (not (((l1 eq l2) and (u1 eq u2)) or (r1 eq r2)));
-mlsconstrain file { open } (((l1 eq l2) and (u1 eq u2)) or (r1 != r2));
-mlsconstrain file { open } (l1 dom h2);
-mlsconstrain file { open } (h1 domby l2);
-mlsconstrain file { open } (l1 incomp l2);
-
-mlsvalidatetrans file (h1 domby l2);
-
-attribute foo_type;
-attribute bar_type;
-attribute baz_type;
-attribute exec_type;
-
-type bin_t, bar_type, exec_type;
-type kernel_t, foo_type, exec_type, baz_type;
-type security_t, baz_type;
-type unlabeled_t, baz_type;
-
-type exec_t, baz_type;
-type console_t, baz_type;
-type auditadm_t, baz_type;
-type console_device_t, baz_type;
-type user_tty_device_t, baz_type;
-type device_t, baz_type;
-type getty_t, baz_type;
-type a_t, baz_type;
-type b_t, baz_type;
-
-typealias bin_t alias sbin_t;
-
-bool secure_mode false;
-bool console_login true;
-bool b1 false;
-
-role system_r;
-role user_r;
-role system_r types bin_t; 
-role system_r types kernel_t; 
-role system_r types security_t; 
-role system_r types unlabeled_t; 
-
-policycap open_perms;
-permissive device_t;
-
-range_transition device_t console_t : file s0:c0 - s1:c0.c1;
-
-type_transition device_t console_t : file console_device_t;
-type_member device_t bin_t : file exec_t;
-
-if console_login{
-	type_change auditadm_t console_device_t : file user_tty_device_t;
-}
-
-role_transition system_r bin_t user_r;
-
-auditallow device_t auditadm_t: file { open };
-dontaudit device_t auditadm_t: file { read };
-
-allow system_r user_r;
-
-allow console_t console_device_t: char { write setattr };
-allow console_t console_device_t: file { open read getattr };
-allow foo_type self: file { execute };
-allow bin_t device_t: file { execute };
-allow bin_t exec_t: file { execute };
-allow bin_t bin_t: file { execute };
-allow a_t b_t : file { write };
-allow console_t console_device_t: file { read write getattr setattr lock append };
-allow kernel_t kernel_t : file { execute };
-
-if b1 {
-	allow a_t b_t : file { read };
-}
-
-if secure_mode{
-	auditallow device_t exec_t: file { read write };
-}
-
-if console_login{
-	allow getty_t console_device_t: file { getattr open read write append };
-}
-else {
-	dontaudit getty_t console_device_t: file { getattr open read write append };
-}
-
-if (not ((secure_mode eq console_login) xor ((secure_mode or console_login) and secure_mode))){
-	allow bin_t exec_t: file { execute };
-}
-
-user system_u roles system_r level s0:c0 range s0:c0 - s1:c0,c1; 
-user user_u roles user_r level s0:c0 range s0:c0 - s0:c0;
-
-validatetrans file (t1 == exec_t);
-
-constrain char transition (not (((t1 eq exec_t) and (t2 eq bin_t)) or (r1 eq r2)));
-constrain file { open } (r1 dom r2);
-constrain file { open }	(r1 domby r2);
-constrain file { open }	(r1 incomp r2);
-constrain file { open read getattr } (not (((t1 eq exec_t) and (t2 eq bin_t)) or (r1 eq r2)));
-constrain char { write setattr } (not (((t1 eq exec_t) and (t2 eq bin_t)) or (r1 eq r2)));
-
-
-sid kernel system_u:system_r:kernel_t:s0:c0 - s1:c0,c1
-sid security system_u:system_r:security_t:s0:c0 - s1:c0,c1
-sid unlabeled system_u:system_r:unlabeled_t:s0:c0 - s1:c0,c1
-
-fs_use_xattr ext3 system_u:system_r:bin_t:s0:c0 - s1:c0,c1;
-
-genfscon proc /usr/bin system_u:system_r:bin_t:s0:c0 - s1:c0,c1
-
-portcon tcp 22 system_u:system_r:bin_t:s0:c0 - s1:c0,c1
-portcon udp 25 system_u:system_r:bin_t:s0:c0 - s1:c0,c1
-
-netifcon eth0 system_u:system_r:bin_t:s0:c0 - s1:c0,c1 system_u:system_r:bin_t:s0:c0 - s1:c0,c1
-
-nodecon 192.25.35.200 192.168.1.1 system_u:system_r:bin_t:s0:c0 - s1:c0,c1
-nodecon 2001:db8:ac10:fe01:: 2001:de0:da88:2222:: system_u:system_r:bin_t:s0:c0 - s1:c0,c1
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 1285314..0ae0f1a 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -44,5 +44,6 @@ LIBSEPOL_1.1 {
 	cil_filecons_to_string;
 	cil_set_target_platform;
 	cil_set_policy_version;
+	cil_set_mls;
   local: *;
 } LIBSEPOL_1.0;
diff --git a/secilc/.gitignore b/secilc/.gitignore
new file mode 100644
index 0000000..98c367a
--- /dev/null
+++ b/secilc/.gitignore
@@ -0,0 +1,6 @@
+secilc
+secilc.8
+policy.*
+file_contexts
+docs/html
+docs/pdf
diff --git a/secilc/Android.mk b/secilc/Android.mk
new file mode 100644
index 0000000..b80955c
--- /dev/null
+++ b/secilc/Android.mk
@@ -0,0 +1,31 @@
+LOCAL_PATH:= $(call my-dir)
+
+common_src_files := secilc.c
+
+common_cflags := \
+	-Wall -Wshadow -O2 \
+	-pipe -fno-strict-aliasing \
+	-Wno-return-type
+
+ifeq ($(HOST_OS), darwin)
+common_cflags += -DDARWIN
+endif
+
+common_includes := \
+	$(LOCAL_PATH)/../libsepol/cil/include/ \
+	$(LOCAL_PATH)/../libsepol/include/ \
+
+##
+# secilc
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := secilc
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes)
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := ./secilc.c
+LOCAL_SHARED_LIRARIES := libsepol
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_HOST_EXECUTABLE)
diff --git a/libsepol/cil/COPYING b/secilc/COPYING
similarity index 100%
rename from libsepol/cil/COPYING
rename to secilc/COPYING
diff --git a/secilc/Makefile b/secilc/Makefile
new file mode 100644
index 0000000..d6767fa
--- /dev/null
+++ b/secilc/Makefile
@@ -0,0 +1,47 @@
+PREFIX ?= $(DESTDIR)/usr
+BINDIR ?= $(PREFIX)/bin
+MANDIR ?= $(PREFIX)/share/man
+INCLUDEDIR ?= $(PREFIX)/include
+TESTDIR ?= ./test
+
+LDFLAGS = -lsepol
+SECILC = secilc
+SECILC_SRCS := secilc.c
+SECILC_OBJS := $(patsubst %.c,%.o,$(SECILC_SRCS))
+
+# The secilc man page:
+MANPAGE = secilc.8
+XMLTO = $(shell which xmlto 2> /dev/null | grep / | head -n1)
+
+CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
+
+override CFLAGS += -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+
+$(SECILC): $(SECILC_OBJS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+all: $(SECILC) man
+
+test: $(SECILC)
+	./$(SECILC) test/policy.cil
+
+man: $(MANPAGE).xml
+	$(XMLTO) man $(MANPAGE).xml
+
+install: all man
+	-mkdir -p $(BINDIR)
+	-mkdir -p $(MANDIR)/man8
+	install -m 755 $(SECILC) $(BINDIR)
+	install -m 644 $(MANPAGE) $(MANDIR)/man8
+
+doc:
+	$(MAKE) -C docs
+
+clean:
+	rm -f $(SECILC)
+	rm -f $(SECILC_OBJS)
+	rm -f policy.*
+	rm -f file_contexts
+	rm -f $(MANPAGE)
+
+.PHONY: all clean test install doc
diff --git a/libsepol/cil/README b/secilc/README
similarity index 73%
rename from libsepol/cil/README
rename to secilc/README
index e25f849..14b8cc8 100644
--- a/libsepol/cil/README
+++ b/secilc/README
@@ -11,34 +11,30 @@ INTRODUCTION
 DEPENDENCIES
 
 	gcc >= 4.5.1
-	libsepol-static >= 2.1.4
-	lcov >= 1.9
-	flex >= 2.5.35
+	libsepol >= 2.4
 
 
 BUILD STEPS
 
-	Open a terminal client and execute the following command to download the source code:
-
-			git clone https://github.com/SELinuxProject/cil.git
-
-	Change directory into the "cil" directory.
 	Run "make" with one of the following targets:
 
 	make
-		Build the CIL compiler (secilc)
+		Build the CIL compiler (secilc).
 
-	make unit
-		Build the unit_test application to run unit tests
+	make test
+		Pass a sample policy to test with the compiler.
 
-	make coverage
-		Build the unit test binary and create coverage reports
+	make install
+		Install the secilc compiler and man page to disk.
 
 	make clean
-		Remove temporary build files
+		Remove temporary build files.
+
+	make man
+		Build the secilc man page.
 
 	make bare
-		Remove temporary build files and compile binaries
+		Remove temporary build files and compile binaries.
 
 
 USAGE
diff --git a/libsepol/cil/docs/CIL_Reference_Guide.xml b/secilc/docs/CIL_Reference_Guide.xml
similarity index 100%
rename from libsepol/cil/docs/CIL_Reference_Guide.xml
rename to secilc/docs/CIL_Reference_Guide.xml
diff --git a/libsepol/cil/docs/Makefile b/secilc/docs/Makefile
similarity index 81%
rename from libsepol/cil/docs/Makefile
rename to secilc/docs/Makefile
index cf18e36..1655f59 100644
--- a/libsepol/cil/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -1,6 +1,5 @@
 HTMLDIR ?= ./html
 PDFDIR ?= ./pdf
-MAN8DIR ?= ./man8
 
 # The CIL Reference Guide first part
 CIL_REF_GUIDE = CIL_Reference_Guide.xml
@@ -9,10 +8,6 @@ FILE_LIST ?= $(CIL_REF_GUIDE) $(wildcard cil*.xml)
 # xmlto generates a *.proc file that can be removed.
 PROC_FILE = CIL_Reference_Guide.proc
 
-# The secilc man page:
-MANPAGE = secilc.8.xml
-
-
 # look for xmlto and dblatex packages
 XMLTO = $(shell which xmlto 2> /dev/null | grep / | head -n1)
 DBLATEX = $(shell which dblatex 2> /dev/null | grep / | head -n1)
@@ -22,7 +17,7 @@ ifeq ($(XMLTO),)
 $(error xmlto package not found - install package.)
 endif
 
-all: html pdf man
+all: html pdf
 
 html: $(FILE_LIST)
 	$(XMLTO) html $(CIL_REF_GUIDE)
@@ -41,10 +36,6 @@ endif
 	@for m in *.pdf; do if [ -f $$m ]; then mv $$m $(PDFDIR); fi; done
 	@rm -f $(PROC_FILE)
 
-
-man: $(MANPAGE)
-	$(XMLTO) man $(MANPAGE)
-	@mkdir -p $(MAN8DIR)
-	@for m in *.8; do if [ -f $$m ]; then mv $$m $(MAN8DIR); fi; done
-	@rm -f $(MANPAGE).proc
-
+clean:
+	@rm -rf html/
+	@rm -rf pdf/
diff --git a/libsepol/cil/docs/cil_access_vector_rules.xml b/secilc/docs/cil_access_vector_rules.xml
similarity index 100%
rename from libsepol/cil/docs/cil_access_vector_rules.xml
rename to secilc/docs/cil_access_vector_rules.xml
diff --git a/libsepol/cil/docs/cil_call_macro_statements.xml b/secilc/docs/cil_call_macro_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_call_macro_statements.xml
rename to secilc/docs/cil_call_macro_statements.xml
diff --git a/libsepol/cil/docs/cil_class_and_permission_statements.xml b/secilc/docs/cil_class_and_permission_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_class_and_permission_statements.xml
rename to secilc/docs/cil_class_and_permission_statements.xml
diff --git a/libsepol/cil/docs/cil_conditional_statements.xml b/secilc/docs/cil_conditional_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_conditional_statements.xml
rename to secilc/docs/cil_conditional_statements.xml
diff --git a/libsepol/cil/docs/cil_constraint_statements.xml b/secilc/docs/cil_constraint_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_constraint_statements.xml
rename to secilc/docs/cil_constraint_statements.xml
diff --git a/libsepol/cil/docs/cil_container_statements.xml b/secilc/docs/cil_container_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_container_statements.xml
rename to secilc/docs/cil_container_statements.xml
diff --git a/libsepol/cil/docs/cil_context_statement.xml b/secilc/docs/cil_context_statement.xml
similarity index 100%
rename from libsepol/cil/docs/cil_context_statement.xml
rename to secilc/docs/cil_context_statement.xml
diff --git a/libsepol/cil/docs/cil_default_object_statements.xml b/secilc/docs/cil_default_object_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_default_object_statements.xml
rename to secilc/docs/cil_default_object_statements.xml
diff --git a/libsepol/cil/docs/cil_design.dia b/secilc/docs/cil_design.dia
similarity index 100%
rename from libsepol/cil/docs/cil_design.dia
rename to secilc/docs/cil_design.dia
diff --git a/libsepol/cil/docs/cil_design.jpeg b/secilc/docs/cil_design.jpeg
similarity index 100%
rename from libsepol/cil/docs/cil_design.jpeg
rename to secilc/docs/cil_design.jpeg
diff --git a/libsepol/cil/docs/cil_file_labeling_statements.xml b/secilc/docs/cil_file_labeling_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_file_labeling_statements.xml
rename to secilc/docs/cil_file_labeling_statements.xml
diff --git a/libsepol/cil/docs/cil_mls_labeling_statements.xml b/secilc/docs/cil_mls_labeling_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_mls_labeling_statements.xml
rename to secilc/docs/cil_mls_labeling_statements.xml
diff --git a/libsepol/cil/docs/cil_network_labeling_statements.xml b/secilc/docs/cil_network_labeling_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_network_labeling_statements.xml
rename to secilc/docs/cil_network_labeling_statements.xml
diff --git a/libsepol/cil/docs/cil_policy_config_statements.xml b/secilc/docs/cil_policy_config_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_policy_config_statements.xml
rename to secilc/docs/cil_policy_config_statements.xml
diff --git a/libsepol/cil/docs/cil_role_statements.xml b/secilc/docs/cil_role_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_role_statements.xml
rename to secilc/docs/cil_role_statements.xml
diff --git a/libsepol/cil/docs/cil_sid_statements.xml b/secilc/docs/cil_sid_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_sid_statements.xml
rename to secilc/docs/cil_sid_statements.xml
diff --git a/libsepol/cil/docs/cil_type_statements.xml b/secilc/docs/cil_type_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_type_statements.xml
rename to secilc/docs/cil_type_statements.xml
diff --git a/libsepol/cil/docs/cil_user_statements.xml b/secilc/docs/cil_user_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_user_statements.xml
rename to secilc/docs/cil_user_statements.xml
diff --git a/libsepol/cil/docs/cil_xen_statements.xml b/secilc/docs/cil_xen_statements.xml
similarity index 100%
rename from libsepol/cil/docs/cil_xen_statements.xml
rename to secilc/docs/cil_xen_statements.xml
diff --git a/libsepol/cil/docs/secilc.8.xml b/secilc/secilc.8.xml
similarity index 100%
rename from libsepol/cil/docs/secilc.8.xml
rename to secilc/secilc.8.xml
diff --git a/libsepol/cil/secilc.c b/secilc/secilc.c
similarity index 90%
rename from libsepol/cil/secilc.c
rename to secilc/secilc.c
index f4e32b3..923151c 100644
--- a/libsepol/cil/secilc.c
+++ b/secilc/secilc.c
@@ -34,7 +34,7 @@
 #include <getopt.h>
 #include <sys/stat.h>
 
-#include <cil/cil.h>
+#include <sepol/cil/cil.h>
 #include <sepol/policydb.h>
 
 void usage(char *prog)
@@ -210,13 +210,13 @@ int main(int argc, char *argv[])
 	for (i = optind; i < argc; i++) {
 		file = fopen(argv[i], "r");
 		if (!file) {
-			cil_log(CIL_ERR, "Could not open file: %s\n", argv[i]);
+			fprintf(stderr, "Could not open file: %s\n", argv[i]);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 		rc = stat(argv[i], &filedata);
 		if (rc == -1) {
-			cil_log(CIL_ERR, "Could not stat file: %s\n", argv[i]);
+			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
 			goto exit;
 		}
 		file_size = filedata.st_size;	
@@ -224,7 +224,7 @@ int main(int argc, char *argv[])
 		buffer = malloc(file_size);
 		rc = fread(buffer, file_size, 1, file);
 		if (rc != 1) {
-			cil_log(CIL_ERR, "Failure reading file: %s\n", argv[i]);
+			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
 			goto exit;
 		}
 		fclose(file);
@@ -232,7 +232,7 @@ int main(int argc, char *argv[])
 
 		rc = cil_add_file(db, argv[i], buffer, file_size);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failure adding %s\n", argv[i]);
+			fprintf(stderr, "Failure adding %s\n", argv[i]);
 			goto exit;
 		}
 
@@ -242,13 +242,13 @@ int main(int argc, char *argv[])
 
 	rc = cil_compile(db);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to compile cildb: %d\n", rc);
+		fprintf(stderr, "Failed to compile cildb: %d\n", rc);
 		goto exit;
 	}
 
 	rc = cil_build_policydb(db, &pdb);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to build policydb\n");
+		fprintf(stderr, "Failed to build policydb\n");
 		goto exit;
 	}
 
@@ -256,29 +256,27 @@ int main(int argc, char *argv[])
 		int size = snprintf(NULL, 0, "policy.%d", policyvers);
 		output = malloc((size + 1) * sizeof(char));
 		if (output == NULL) {
-			cil_log(CIL_ERR, "Failed to create output filename\n");
+			fprintf(stderr, "Failed to create output filename\n");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 		if (snprintf(output, size + 1, "policy.%d", policyvers) != size) {
-			cil_log(CIL_ERR, "Failed to create output filename\n");
+			fprintf(stderr, "Failed to create output filename\n");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 	}
 
-	cil_log(CIL_INFO, "Writing binary to %s\n", output);
-
 	binary = fopen(output, "w");
 	if (binary == NULL) {
-		cil_log(CIL_ERR, "Failure opening binary file for writing\n");
+		fprintf(stderr, "Failure opening binary file for writing\n");
 		rc = SEPOL_ERR;
 		goto exit;
 	}
 
 	rc = sepol_policy_file_create(&pf);
 	if (rc != 0) {
-		cil_log(CIL_ERR, "Failed to create policy file: %d\n", rc);
+		fprintf(stderr, "Failed to create policy file: %d\n", rc);
 		goto exit;
 	}
 
@@ -286,18 +284,16 @@ int main(int argc, char *argv[])
 
 	rc = sepol_policydb_write(pdb, pf);
 	if (rc != 0) {
-		cil_log(CIL_ERR, "Failed to write binary policy: %d\n", rc);
+		fprintf(stderr, "Failed to write binary policy: %d\n", rc);
 		goto exit;
 	}
 
 	fclose(binary);
 	binary = NULL;
 
-	cil_log(CIL_INFO, "Writing file contexts\n");
-	
 	rc = cil_filecons_to_string(db, &fc_buf, &fc_size);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_ERR, "Failed to get file context data\n");
+		fprintf(stderr, "Failed to get file context data\n");
 		goto exit;
 	}
 
@@ -308,12 +304,12 @@ int main(int argc, char *argv[])
 	}
 
 	if (file_contexts == NULL) {
-		cil_log(CIL_ERR, "Failed to open file_contexts file\n");
+		fprintf(stderr, "Failed to open file_contexts file\n");
 		goto exit;
 	}
 	
 	if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) != fc_size) {
-		cil_log(CIL_ERR, "Failed to write file_contexts file\n");
+		fprintf(stderr, "Failed to write file_contexts file\n");
 		goto exit;
 	}
 
@@ -323,8 +319,6 @@ int main(int argc, char *argv[])
 	rc = SEPOL_OK;
 
 exit:
-	cil_log(CIL_INFO,"Exiting\n");
-
 	if (binary != NULL) {
 		fclose(binary);
 	}
diff --git a/libsepol/cil/test/block_test.cil b/secilc/test/block_test.cil
similarity index 100%
rename from libsepol/cil/test/block_test.cil
rename to secilc/test/block_test.cil
diff --git a/libsepol/cil/test/in_test.cil b/secilc/test/in_test.cil
similarity index 100%
rename from libsepol/cil/test/in_test.cil
rename to secilc/test/in_test.cil
diff --git a/libsepol/cil/test/integration.cil b/secilc/test/integration.cil
similarity index 100%
rename from libsepol/cil/test/integration.cil
rename to secilc/test/integration.cil
diff --git a/libsepol/cil/test/minimum.cil b/secilc/test/minimum.cil
similarity index 100%
rename from libsepol/cil/test/minimum.cil
rename to secilc/test/minimum.cil
diff --git a/libsepol/cil/test/name_resolution_test.cil b/secilc/test/name_resolution_test.cil
similarity index 100%
rename from libsepol/cil/test/name_resolution_test.cil
rename to secilc/test/name_resolution_test.cil
diff --git a/libsepol/cil/test/optional_test.cil b/secilc/test/optional_test.cil
similarity index 100%
rename from libsepol/cil/test/optional_test.cil
rename to secilc/test/optional_test.cil
diff --git a/libsepol/cil/test/policy.cil b/secilc/test/policy.cil
similarity index 100%
rename from libsepol/cil/test/policy.cil
rename to secilc/test/policy.cil
-- 
1.9.3
