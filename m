Message-ID: <488F6057.1010403@redhat.com>
Date: Tue, 29 Jul 2008 14:24:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ruby bindings patch for libselinux
References: <4876284A.5070606@redhat.com>	 <1217336636.20373.175.camel@moss-spartans.epoch.ncsc.mil>	 <488F2CF8.2010600@redhat.com> <1217343711.20373.206.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217343711.20373.206.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050803060904070706070308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050803060904070706070308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Tue, 2008-07-29 at 10:45 -0400, Daniel J Walsh wrote:
>>> Rather than commenting out or #ifdef'ing python binding code, just
>>> remove it from this file.
>> I left it in t he hopes that someone who knew ruby would come in and fix it.
> 
> Better to just strip it and they can always look at the python bindings
> later if they want.
> 
>>> What are the build dependencies?  Doesn't build for me on F8 or F9 with
>>> ruby, ruby-libs and ruby-devel installed.
>> Build fine for me on F9 and Rawhide.
>>
>> Spec file has:
>>
>> BuildRequires: python-devel ruby-devel ruby libsepol-static >=
>> %{libsepolver} swig
> 
> Ah, ok - now it builds for me.
>
Added your fixes.


--------------050803060904070706070308
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/Makefile libselinux-2.0.69/Makefile
--- nsalibselinux/Makefile	2008-06-12 23:25:14.000000000 -0400
+++ libselinux-2.0.69/Makefile	2008-07-29 14:21:44.000000000 -0400
@@ -29,6 +29,9 @@
 pywrap: 
 	$(MAKE) -C src pywrap
 
+rubywrap: 
+	$(MAKE) -C src rubywrap
+
 install: 
 	$(MAKE) -C include install
 	$(MAKE) -C src install
@@ -38,6 +41,9 @@
 install-pywrap: 
 	$(MAKE) -C src install-pywrap 
 
+install-rubywrap: 
+	$(MAKE) -C src install-rubywrap 
+
 relabel: 
 	$(MAKE) -C src relabel
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.69/src/Makefile
--- nsalibselinux/src/Makefile	2008-06-22 09:40:25.000000000 -0400
+++ libselinux-2.0.69/src/Makefile	2008-07-29 14:15:39.000000000 -0400
@@ -7,16 +7,24 @@
 PYINC ?= /usr/include/$(PYLIBVER)
 PYLIB ?= /usr/lib/$(PYLIBVER)
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
+RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
+RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
+RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 
 LIBVERSION = 1
 
 LIBA=libselinux.a 
 TARGET=libselinux.so
 SWIGIF= selinuxswig_python.i
+SWIGRUBYIF= selinuxswig_ruby.i
 SWIGCOUT= selinuxswig_wrap.c
+SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
+SWIGRUBYSO=_rubyselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYSO=audit2why.so
 
@@ -29,7 +37,9 @@
 ifeq ($(DISABLE_RPM),y)
 	UNUSED_SRCS+=rpm.c
 endif
-SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out audit2why.c $(SWIGCOUT),$(wildcard *.c)))
+
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT)
+SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out audit2why.c $(GENERATED),$(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
@@ -44,12 +54,14 @@
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
-GENERATED=$(SWIGCOUT)
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
 all: $(LIBA) $(LIBSO) 
 
 pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
 
+rubywrap: all $(SWIGRUBYSO)
+
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
@@ -57,9 +69,15 @@
 $(SWIGLOBJ): $(SWIGCOUT)
 	$(CC) $(filter-out -Werror,$(CFLAGS)) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
+$(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
+	$(CC) $(filter-out -Werror,$(CFLAGS)) -I$(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+
 $(SWIGSO): $(SWIGLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
+
 $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
@@ -79,6 +97,9 @@
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $^
 
+$(SWIGRUBYCOUT): $(SWIGRUBYIF)
+	$(SWIGRUBY) $^
+
 swigify: $(SWIGIF)
 	$(SWIG) $^
 
@@ -95,6 +116,10 @@
 	install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
 	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages/selinux/__init__.py
 
+install-rubywrap: rubywrap
+	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
+	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
+
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
@@ -102,7 +127,7 @@
 	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
 
 distclean: clean
-	rm -f $(SWIGCOUT) $(SWIGFILES)
+	rm -f $(GENERATED) $(SWIGFILES)
 
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_ruby.i libselinux-2.0.69/src/selinuxswig_ruby.i
--- nsalibselinux/src/selinuxswig_ruby.i	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.69/src/selinuxswig_ruby.i	2008-07-29 14:17:14.000000000 -0400
@@ -0,0 +1,52 @@
+/* Author: Dan Walsh
+   Based on selinuxswig_python.i by James Athey
+ */
+
+%module selinux
+%{
+	#include "selinux/selinux.h"
+%}
+
+/* return a sid along with the result */
+%typemap(argout) (security_id_t * sid) {
+	if (*$1) {
+                %append_output(SWIG_NewPointerObj(*$1, $descriptor(security_id_t), 0));
+	} 
+}
+
+%typemap(in,numinputs=0) security_id_t *(security_id_t temp) {
+  $1 = &temp;
+}
+
+%typemap(in,noblock=1,numinputs=0) security_context_t * (security_context_t temp = 0) {
+	$1 = &temp;
+}
+%typemap(freearg,match="in") security_context_t * "";
+%typemap(argout,noblock=1) security_context_t * {
+	if (*$1) {
+		%append_output(SWIG_FromCharPtr(*$1));
+		freecon(*$1);
+	}
+}
+
+%typemap(in,noblock=1,numinputs=0) char ** (char * temp = 0) {
+	$1 = &temp;
+}
+%typemap(freearg,match="in") char ** "";
+%typemap(argout,noblock=1) char ** {
+	if (*$1) {
+		%append_output(SWIG_FromCharPtr(*$1));
+		free(*$1);
+	}
+}
+
+%typemap(freearg,match="in") char * const [] {
+	int i = 0;
+	while($1[i]) {
+		free($1[i]);
+		i++;
+	}
+	free($1);
+}
+
+%include "selinuxswig.i"

--------------050803060904070706070308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
