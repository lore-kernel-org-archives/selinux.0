Date: Thu, 17 Aug 2006 16:43:22 -0400
From: Caleb Case <ccase@tresys.com>
Message-Id: <200608172043.k7HKhMXj009918@localhost.localdomain>
To: selinux@tycho.nsa.gov
Subject: [patch 1/1] make indent target update
Cc: kmacmillan@mentalrootkit.com, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The current make indent invokes the distclean target which removes generated files.  This approach instead pushes the decision of which files to indent down into the respective makefiles and does not force a distclean.  Tests are not indented.

On a clean trunk, make indent changes these files (that previously they were not):

libsemanage/src/semanage_store.c
libsepol/src/mls.c
libsepol/src/users.c
libsepol/src/link.c
checkpolicy/module_compiler.c
libselinux/src/procattr.c
libselinux/src/fgetfilecon.c
libselinux/src/lgetfilecon.c
libselinux/src/getfilecon.c

---
 Makefile                                  |    6 ++++--
 checkpolicy/Makefile                      |    4 ++++
 libselinux/Makefile                       |    7 ++++++-
 libselinux/include/Makefile               |    4 ++++
 libselinux/src/Makefile                   |    6 ++++++
 libselinux/utils/Makefile                 |    3 +++
 libsemanage/Makefile                      |    4 ++++
 libsemanage/include/Makefile              |    3 +++
 libsemanage/src/Makefile                  |    5 +++++
 libsepol/Makefile                         |    5 +++++
 libsepol/include/Makefile                 |    3 +++
 libsepol/src/Makefile                     |    3 +++
 libsepol/utils/Makefile                   |    3 +++
 policycoreutils/Makefile                  |    2 +-
 policycoreutils/audit2allow/Makefile      |    2 ++
 policycoreutils/audit2why/Makefile        |    3 +++
 policycoreutils/load_policy/Makefile      |    3 +++
 policycoreutils/newrole/Makefile          |    3 +++
 policycoreutils/po/Makefile               |    2 ++
 policycoreutils/restorecon/Makefile       |    3 +++
 policycoreutils/restorecond/Makefile      |    3 +++
 policycoreutils/run_init/Makefile         |    3 +++
 policycoreutils/scripts/Makefile          |    2 ++
 policycoreutils/secon/Makefile            |    3 +++
 policycoreutils/semanage/Makefile         |    2 ++
 policycoreutils/semodule/Makefile         |    6 +++++-
 policycoreutils/semodule_deps/Makefile    |    6 +++++-
 policycoreutils/semodule_expand/Makefile  |    6 +++++-
 policycoreutils/semodule_link/Makefile    |    6 +++++-
 policycoreutils/semodule_package/Makefile |    6 +++++-
 policycoreutils/sestatus/Makefile         |    3 +++
 policycoreutils/setfiles/Makefile         |    3 +++
 policycoreutils/setsebool/Makefile        |    6 +++++-
 33 files changed, 119 insertions(+), 10 deletions(-)

Index: ps-api.quilt/Makefile
===================================================================
--- ps-api.quilt.orig/Makefile
+++ ps-api.quilt/Makefile
@@ -31,5 +31,7 @@ test:
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 
-indent: distclean # do not indent the generated files
-	find . -name "*.[ch]" -exec sh ./Lindent {} \;		
+indent:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
Index: ps-api.quilt/checkpolicy/Makefile
===================================================================
--- ps-api.quilt.orig/checkpolicy/Makefile
+++ ps-api.quilt/checkpolicy/Makefile
@@ -18,6 +18,8 @@ CHECKMODOBJS = $(CHECKOBJS) checkmodule.
 
 LDLIBS=$(LIBDIR)/libsepol.a -lfl
 
+GENERATED=lex.yy.c y.tab.c y.tab.h
+
 all:  $(TARGETS)
 	$(MAKE) -C test
 
@@ -55,3 +57,5 @@ clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
 	$(MAKE) -C test clean
 
+indent:
+	../Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
Index: ps-api.quilt/libselinux/Makefile
===================================================================
--- ps-api.quilt.orig/libselinux/Makefile
+++ ps-api.quilt/libselinux/Makefile
@@ -21,4 +21,9 @@ clean distclean:
 	$(MAKE) -C src $@
 	$(MAKE) -C utils clean
 
-test:
\ No newline at end of file
+indent:
+	$(MAKE) -C src $@
+	$(MAKE) -C utils $@
+	$(MAKE) -C include $@
+
+test:
Index: ps-api.quilt/libselinux/include/Makefile
===================================================================
--- ps-api.quilt.orig/libselinux/include/Makefile
+++ ps-api.quilt/libselinux/include/Makefile
@@ -5,3 +5,7 @@ INCDIR ?= $(PREFIX)/include/selinux
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
+
+indent:
+	../../Lindent $(wildcard selinux/*.h)
+
Index: ps-api.quilt/libselinux/src/Makefile
===================================================================
--- ps-api.quilt.orig/libselinux/src/Makefile
+++ ps-api.quilt/libselinux/src/Makefile
@@ -31,6 +31,8 @@ endif
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
+GENERATED=$(SWIGCOUT)
+
 all: $(LIBA) $(LIBSO) 
 
 pywrap: all $(SWIGSO)
@@ -80,3 +82,7 @@ clean: 
 
 distclean: clean
 	rm -f $(SWIGCOUT) $(SWIGFILES)
+
+indent:
+	../../Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
+
Index: ps-api.quilt/libselinux/utils/Makefile
===================================================================
--- ps-api.quilt.orig/libselinux/utils/Makefile
+++ ps-api.quilt/libselinux/utils/Makefile
@@ -18,5 +18,8 @@ install: all
 clean:
 	rm -f $(TARGETS) *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel:
 
Index: ps-api.quilt/libsemanage/Makefile
===================================================================
--- ps-api.quilt.orig/libsemanage/Makefile
+++ ps-api.quilt/libsemanage/Makefile
@@ -19,4 +19,8 @@ clean distclean:
 	$(MAKE) -C src $@
 	$(MAKE) -C tests $@
 
+indent:
+	$(MAKE) -C src $@
+	$(MAKE) -C include $@
+
 test:
Index: ps-api.quilt/libsemanage/include/Makefile
===================================================================
--- ps-api.quilt.orig/libsemanage/include/Makefile
+++ ps-api.quilt/libsemanage/include/Makefile
@@ -5,3 +5,6 @@ INCDIR ?= $(PREFIX)/include/semanage
 install:
 	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
 	install -m 644 $(wildcard semanage/*.h) $(INCDIR)
+
+indent:
+	../../Lindent $(wildcard semanage/*.h)
Index: ps-api.quilt/libsemanage/src/Makefile
===================================================================
--- ps-api.quilt.orig/libsemanage/src/Makefile
+++ ps-api.quilt/libsemanage/src/Makefile
@@ -37,6 +37,8 @@ override CFLAGS += -I../include -I$(INCL
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
+GENERATED=$(SWIGCOUT) $(wildcard conf-*.[ch])
+
 all: $(LIBA) $(LIBSO) 
 
 pywrap: all $(SWIGLOBJ) $(SWIGSO) 
@@ -96,4 +98,7 @@ clean: 
 distclean: clean
 	rm -f $(SWIGCOUT) $(SWIGFILES)
 
+indent:
+	../../Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
+
 .PHONY: all clean pywrap swigify install install-pywrap distclean
Index: ps-api.quilt/libsepol/Makefile
===================================================================
--- ps-api.quilt.orig/libsepol/Makefile
+++ ps-api.quilt/libsepol/Makefile
@@ -16,6 +16,11 @@ clean:
 	$(MAKE) -C utils clean
 	$(MAKE) -C tests clean
 
+indent:
+	$(MAKE) -C src $@
+	$(MAKE) -C include $@
+	$(MAKE) -C utils $@
+
 test:
 	$(MAKE) -C tests test
 
Index: ps-api.quilt/libsepol/include/Makefile
===================================================================
--- ps-api.quilt.orig/libsepol/include/Makefile
+++ ps-api.quilt/libsepol/include/Makefile
@@ -7,3 +7,6 @@ install:
 	test -d $(INCDIR)/policydb || install -m 755 -d $(INCDIR)/policydb
 	install -m 644 $(wildcard sepol/*.h) $(INCDIR)
 	install -m 644 $(wildcard sepol/policydb/*.h) $(INCDIR)/policydb
+
+indent:
+	../../Lindent $(wildcard sepol/*.h)
Index: ps-api.quilt/libsepol/src/Makefile
===================================================================
--- ps-api.quilt.orig/libsepol/src/Makefile
+++ ps-api.quilt/libsepol/src/Makefile
@@ -42,3 +42,6 @@ relabel:
 clean: 
 	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/libsepol/utils/Makefile
===================================================================
--- ps-api.quilt.orig/libsepol/utils/Makefile
+++ ps-api.quilt/libsepol/utils/Makefile
@@ -17,5 +17,8 @@ install: all
 clean:
 	-rm -f $(TARGETS) *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel:
 
Index: ps-api.quilt/policycoreutils/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/Makefile
+++ ps-api.quilt/policycoreutils/Makefile
@@ -1,6 +1,6 @@
 SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
 
-all install relabel clean: 
+all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
Index: ps-api.quilt/policycoreutils/audit2allow/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/audit2allow/Makefile
+++ ps-api.quilt/policycoreutils/audit2allow/Makefile
@@ -21,4 +21,6 @@ install: all
 
 clean:
 
+indent:
+
 relabel:
Index: ps-api.quilt/policycoreutils/audit2why/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/audit2why/Makefile
+++ ps-api.quilt/policycoreutils/audit2why/Makefile
@@ -24,4 +24,7 @@ install: all
 clean:
 	-rm -f $(TARGETS) *.o
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel:
Index: ps-api.quilt/policycoreutils/load_policy/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/load_policy/Makefile
+++ ps-api.quilt/policycoreutils/load_policy/Makefile
@@ -21,5 +21,8 @@ install: all
 clean:
 	-rm -f $(TARGETS) *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel:
 	/sbin/restorecon $(SBINDIR)/load_policy 
Index: ps-api.quilt/policycoreutils/newrole/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/newrole/Makefile
+++ ps-api.quilt/policycoreutils/newrole/Makefile
@@ -52,5 +52,8 @@ endif
 clean:
 	rm -f $(TARGETS) *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel: install
 	/sbin/restorecon $(BINDIR)/newrole
Index: ps-api.quilt/policycoreutils/po/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/po/Makefile
+++ ps-api.quilt/policycoreutils/po/Makefile
@@ -64,6 +64,8 @@ clean:
 	@rm -fv *mo *~ .depend
 	@rm -rf tmp
 
+indent:
+
 install: $(MOFILES)
 	@for n in $(MOFILES); do \
 	    l=`basename $$n .mo`; \
Index: ps-api.quilt/policycoreutils/restorecon/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/restorecon/Makefile
+++ ps-api.quilt/policycoreutils/restorecon/Makefile
@@ -21,5 +21,8 @@ install: all
 clean:
 	-rm -f restorecon *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel: install
 	/sbin/restorecon $(SBINDIR)/restorecon
Index: ps-api.quilt/policycoreutils/restorecond/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/restorecond/Makefile
+++ ps-api.quilt/policycoreutils/restorecond/Makefile
@@ -30,3 +30,6 @@ relabel: install
 clean:
 	-rm -f restorecond *.o *~
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/run_init/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/run_init/Makefile
+++ ps-api.quilt/policycoreutils/run_init/Makefile
@@ -45,5 +45,8 @@ endif
 clean:
 	-rm -f $(TARGETS) *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel: install
 	/sbin/restorecon $(SBINDIR)/run_init $(SBINDIR)/open_init_pty
Index: ps-api.quilt/policycoreutils/scripts/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/scripts/Makefile
+++ ps-api.quilt/policycoreutils/scripts/Makefile
@@ -21,4 +21,6 @@ install: all
 
 clean:
 
+indent:
+
 relabel:
Index: ps-api.quilt/policycoreutils/secon/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/secon/Makefile
+++ ps-api.quilt/policycoreutils/secon/Makefile
@@ -29,6 +29,9 @@ relabel:
 clean:
 	rm -f *.o core* secon *~ *.bak
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 bare: clean
 
 .PHONY: clean bare
Index: ps-api.quilt/policycoreutils/semanage/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semanage/Makefile
+++ ps-api.quilt/policycoreutils/semanage/Makefile
@@ -20,4 +20,6 @@ install: all
 
 clean:
 
+indent:
+
 relabel:
Index: ps-api.quilt/policycoreutils/semodule/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semodule/Makefile
+++ ps-api.quilt/policycoreutils/semodule/Makefile
@@ -23,4 +23,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule *.o 
+	-rm -f semodule *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/semodule_deps/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semodule_deps/Makefile
+++ ps-api.quilt/policycoreutils/semodule_deps/Makefile
@@ -22,4 +22,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule_deps *.o 
+	-rm -f semodule_deps *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/semodule_expand/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semodule_expand/Makefile
+++ ps-api.quilt/policycoreutils/semodule_expand/Makefile
@@ -22,4 +22,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule_expand *.o 
+	-rm -f semodule_expand *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/semodule_link/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semodule_link/Makefile
+++ ps-api.quilt/policycoreutils/semodule_link/Makefile
@@ -22,4 +22,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule_link *.o 
+	-rm -f semodule_link *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/semodule_package/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/semodule_package/Makefile
+++ ps-api.quilt/policycoreutils/semodule_package/Makefile
@@ -22,4 +22,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule_package *.o 
+	-rm -f semodule_package *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+
Index: ps-api.quilt/policycoreutils/sestatus/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/sestatus/Makefile
+++ ps-api.quilt/policycoreutils/sestatus/Makefile
@@ -24,4 +24,7 @@ install: all
 clean:
 	rm -f sestatus *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel:
Index: ps-api.quilt/policycoreutils/setfiles/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/setfiles/Makefile
+++ ps-api.quilt/policycoreutils/setfiles/Makefile
@@ -28,5 +28,8 @@ install: all
 clean:
 	rm -f setfiles *.o 
 
+indent:
+	../../Lindent $(wildcard *.[ch])
+
 relabel: install
 	/sbin/restorecon $(SBINDIR)/setfiles
Index: ps-api.quilt/policycoreutils/setsebool/Makefile
===================================================================
--- ps-api.quilt.orig/policycoreutils/setsebool/Makefile
+++ ps-api.quilt/policycoreutils/setsebool/Makefile
@@ -23,4 +23,8 @@ install: all
 relabel:
 
 clean:
-	-rm -f setsebool *.o 
+	-rm -f setsebool *.o
+
+indent:
+	../../Lindent $(wildcard *.[ch])
+


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
