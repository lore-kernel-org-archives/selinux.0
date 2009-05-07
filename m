From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, method@manicmethod.com
Cc: "David P. Quigley" <dpquigl@moss-guppy.epoch.ncsc.mil>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH] libsemanage: Add Ruby Bindings
Date: Thu,  7 May 2009 10:55:15 -0400
Message-Id: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@moss-guppy.epoch.ncsc.mil>

This patch adds a SWIG specification file for ruby bindings for libsemanage.
The spec file is almost identical to the python SWIG file with the exception
that all list generating typemaps have been removed and the python related
functions have been replaced with the corresponding ruby ones. Finally the
Makefile is modified to be able to build the new bindings. Something to note is
that on 64-bit systems ruby.h might be found somewhere under /usr/lib64 instead
of /usr/lib so LIBDIR=/usr/lib64 will be needed to build the ruby bindings from
source.

Below is an example using the ruby bindings and produces the similar output
to semodule -l

#!/usr/bin/ruby
require "semanage"

handle = Semanage.semanage_handle_create

Semanage.semanage_select_store(handle, "targeted", Semanage::SEMANAGE_CON_DIRECT)
Semanage.semanage_connect(handle)
module_info = Semanage.semanage_module_list(handle)

modules = Array.new()
module_info[2].times do |n|
        temp_module = Semanage.semanage_module_list_nth(module_info[1], n)
        mod_string = Semanage.semanage_module_get_name(temp_module).to_s + " " \
                        + Semanage.semanage_module_get_version(temp_module).to_s
        modules.push(mod_string)
end

        puts "List of Installed Modules"
modules.each do |str|
        puts str
end

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 libsemanage/src/Makefile            |   37 +++++-
 libsemanage/src/semanageswig_ruby.i |  225 +++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+), 4 deletions(-)
 create mode 100644 libsemanage/src/semanageswig_ruby.i

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 4a3d3c6..cfb9558 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -6,6 +6,10 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
 PYINC ?= /usr/include/${PYLIBVER}
 PYLIBDIR ?= $(LIBDIR)/${PYLIBVER}
+RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
+RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
+RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 
 DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
 
@@ -24,31 +28,49 @@ LIBVERSION = 1
 LIBA=libsemanage.a
 TARGET=libsemanage.so
 SWIGIF= semanageswig_python.i
+SWIGRUBYIF= semanageswig_ruby.i
 SWIGCOUT= semanageswig_wrap.c
+SWIGRUBYCOUT= semanageswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
 SWIGSO=_semanage.so
 SWIGFILES=$(SWIGSO) semanage.py 
+SWIGRUBYSO=_rubysemanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.o conf-parse.o
-LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.lo conf-parse.lo
+
+SWIGGEN=$(SWIGCOUT) $(SWIGRUBYCOUT)
+SRCS= $(filter-out $(SWIGGEN),$(wildcard *.c))
+
+OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
+LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
-GENERATED=$(SWIGCOUT) $(wildcard conf-*.[ch])
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
+
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(wildcard conf-*.[ch])
 
 all: $(LIBA) $(LIBSO) 
 
 pywrap: all $(SWIGLOBJ) $(SWIGSO) 
 
+rubywrap: all $(SWIGRUBYSO)
+
 $(SWIGLOBJ): $(SWIGCOUT)
 	$(CC) $(filter-out -Werror, $(CFLAGS)) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
+$(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
+	$(CC) $(filter-out -Werror,$(CFLAGS)) -I$(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+
 $(SWIGSO): $(SWIGLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -l$(PYLIBVER) -L$(LIBDIR) -Wl,-soname,$@,-z,defs
 
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage -L$(LIBDIR) -Wl,-soname,$@
+
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	ranlib $@
@@ -86,6 +108,9 @@ conf-scan.lo:  conf-scan.c
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $^
 
+$(SWIGRUBYCOUT): $(SWIGRUBYIF)
+	$(SWIGRUBY) $^
+
 swigify: $(SWIGIF)
 	$(SWIG) $^
 
@@ -101,6 +126,10 @@ install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages
 	install -m 755 $(SWIGFILES) $(PYLIBDIR)/site-packages
 
+install-rubywrap: rubywrap
+	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
+	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
+
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
@@ -113,4 +142,4 @@ distclean: clean
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
 
-.PHONY: all clean pywrap swigify install install-pywrap distclean
+.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
diff --git a/libsemanage/src/semanageswig_ruby.i b/libsemanage/src/semanageswig_ruby.i
new file mode 100644
index 0000000..e030e4a
--- /dev/null
+++ b/libsemanage/src/semanageswig_ruby.i
@@ -0,0 +1,225 @@
+/* Author Dave Quigley
+ * based on semanageswig_python.i by Spencer Shimko
+ */
+
+%header %{
+        #include <stdlib.h>
+        #include <semanage/semanage.h>
+
+        #define STATUS_SUCCESS 0
+        #define STATUS_ERR -1
+%}
+/* a few helpful typemaps are available in this library */
+%include <typemaps.i>
+
+/* wrap all int*'s so they can be used for results 
+   if it becomes necessary to send in data this should be changed to INOUT */
+%apply int *OUTPUT { int * };
+%apply int *OUTPUT { size_t * };
+%apply int *OUTPUT { unsigned int * };
+
+%typemap(in, numinputs=0) char **(char *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) char** {
+        %append_output(SWIG_FromCharPtr(*$1));
+        free(*$1);
+}
+
+%typemap(in, numinputs=0) char ***(char **temp=NULL) {
+        $1 = &temp;
+}
+
+/* the wrapper will setup this parameter for passing... the resulting ruby functions
+   will not take the semanage_module_info_t ** parameter */
+%typemap(in, numinputs=0) semanage_module_info_t **(semanage_module_info_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_module_info_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+/** context typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_context_t ** parameter */
+%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_context_t** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+/** boolean typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_bool_t *** parameter */
+%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_bool_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_bool_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** fcontext typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_fcontext_t *** parameter */
+%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_fcontext_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_fcontext_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** interface typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_iface_t *** parameter */
+%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_iface_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_iface_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** seuser typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_seuser_t *** parameter */
+%typemap(in, numinputs=0) semanage_seuser_t ***(semanage_seuser_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_seuser_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_seuser_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** user typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_user_t *** parameter */
+%typemap(in, numinputs=0) semanage_user_t ***(semanage_user_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_user_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_user_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** port typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_port_t *** parameter */
+%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_port_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_port_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+/** node typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_node_t *** parameter */
+%typemap(in, numinputs=0) semanage_node_t ***(semanage_node_t **temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(in, numinputs=0) semanage_node_t **(semanage_node_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_node_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+
+%typemap(argout) semanage_node_key_t ** {
+        $result = SWIG_Ruby_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
+        $1 = &temp;
+}
+
+%include "semanageswig.i"
-- 
1.6.0.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
