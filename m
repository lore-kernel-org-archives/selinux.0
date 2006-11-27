Message-ID: <456B38A9.3090102@mentalrootkit.com>
Date: Mon, 27 Nov 2006 14:12:41 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
Subject: Re: Compiling libsepol with -fPIC instead of -fpic
References: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>	 <4561E044.6050006@mentalrootkit.com>	 <1164143156.13758.125.camel@moss-spartans.epoch.ncsc.mil>	 <45636F88.3020608@mentalrootkit.com> <1164211105.13758.171.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164211105.13758.171.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-11-21 at 16:28 -0500, Karl MacMillan wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2006-11-20 at 12:05 -0500, Karl MacMillan wrote:
>>>> Manoj Srivastava wrote:
>>>> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>> Is the problem truly limited to libsepol, or is it also an issue with
>>> libsemanage and/or libselinux?
>>>
>>> Possibly we could define it as a variable in the Makefile (e.g. PIC ?=
>>> -fpic) with a default of -fpic and allow you to build them with make
>>> PIC=-fPIC on SPARC to avoid any effect on x86.
>>>
>> The docs claim an effect only on m68k, PowerPC, and SPARC. So it should 
>> be safe to replace this globally for all of our code.
> 
> Ok.  Particularly given that both libsemanage and libselinux now depend
> on libsepol.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
Committed the following:

Index: libsemanage/src/Makefile
===================================================================
--- libsemanage/src/Makefile	(revision 2100)
+++ libsemanage/src/Makefile	(working copy)
@@ -44,7 +44,7 @@
  pywrap: all $(SWIGLOBJ) $(SWIGSO)

  $(SWIGLOBJ): $(SWIGCOUT)
-	$(CC) $(CFLAGS) -I$(PYINC) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<

  $(SWIGSO): $(SWIGLOBJ)
  	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -l$(PYLIBVER) 
-L$(LIBDIR) -Wl,-soname,$@,-z,defs
@@ -69,7 +69,7 @@
  	$(CC) $(CFLAGS) -c -o $@ $<

  %.lo:  %.c
-	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<

  $(SWIGCOUT): $(SWIGIF)
  	$(SWIG) $^
Index: libsemanage/ChangeLog
===================================================================
--- libsemanage/ChangeLog	(revision 2100)
+++ libsemanage/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+1.8.1 2006-11-27
+	* Merged patch to compile wit -fPIC instead of -fpic from
+	  Manoj Srivastava to prevent hitting the global offest table
+	  limit. Patch changed to include libselinux and libsemanage in
+	  addition to libselinux.
  1.8 2006-10-17
  	* Updated version for release.

Index: libsemanage/VERSION
===================================================================
--- libsemanage/VERSION	(revision 2100)
+++ libsemanage/VERSION	(working copy)
@@ -1 +1 @@
-1.8
+1.8.1
Index: libsepol/src/Makefile
===================================================================
--- libsepol/src/Makefile	(revision 2100)
+++ libsepol/src/Makefile	(working copy)
@@ -24,10 +24,10 @@
  	ln -sf $@ $(TARGET)

  %.o:  %.c
-	$(CC) $(CFLAGS) -fpic -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -c -o $@ $<

  %.lo:  %.c
-	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<

  install: all
  	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
Index: libsepol/ChangeLog
===================================================================
--- libsepol/ChangeLog	(revision 2100)
+++ libsepol/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+1.15.3 2006-11-27
+	* Merged patch to compile wit -fPIC instead of -fpic from
+	  Manoj Srivastava to prevent hitting the global offest table
+	  limit. Patch changed to include libselinux and libsemanage in
+	  addition to libselinux.
  1.15.2 2006-10-31
  	* Merged fix from Karl MacMillan for a segfault when linking
  	  non-MLS modules with users in them.
Index: libsepol/VERSION
===================================================================
--- libsepol/VERSION	(revision 2100)
+++ libsepol/VERSION	(working copy)
@@ -1 +1 @@
-1.15.2
+1.15.3
Index: libselinux/src/Makefile
===================================================================
--- libselinux/src/Makefile	(revision 2100)
+++ libselinux/src/Makefile	(working copy)
@@ -42,7 +42,7 @@
  	$(RANLIB) $@

  $(SWIGLOBJ): $(SWIGCOUT)
-	$(CC) $(CFLAGS) -I$(PYINC) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<

  $(SWIGSO): $(SWIGLOBJ)
  	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) 
-Wl,-soname,$@
@@ -55,7 +55,7 @@
  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<

  %.lo:  %.c policy.h
-	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<

  $(SWIGCOUT): $(SWIGIF)
  	$(SWIG) $^
Index: libselinux/ChangeLog
===================================================================
--- libselinux/ChangeLog	(revision 2100)
+++ libselinux/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+1.33.2 2006-11-27
+	* Merged patch to compile wit -fPIC instead of -fpic from
+	  Manoj Srivastava to prevent hitting the global offest table
+	  limit. Patch changed to include libselinux and libsemanage in
+	  addition to libselinux.
  1.33.1 2006-10-19
  	* Merged updated flask definitions from Darrel Goeddel.
   	  This adds the context security class, and also adds
Index: libselinux/VERSION
===================================================================
--- libselinux/VERSION	(revision 2100)
+++ libselinux/VERSION	(working copy)
@@ -1 +1 @@
-1.33.1
+1.33.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
