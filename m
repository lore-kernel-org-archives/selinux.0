Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QE7NfW032534
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 10:07:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id A14111A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:07:23 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPkcVYbCrEpu for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 16:07:22 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 3B1101A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:07:22 +0200 (CEST)
Date: Mon, 26 Mar 2012 16:07:20 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] libsemanage -- Allow to build for several ruby version
Message-ID: <20120326160720.560db3ed@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This allow to build the ruby module for both ruby 1.8 and 1.9.1 (the
way it's done for the python module)

Laurent

Description: Allow to build for several ruby version
Author: Laurent Bigonville <bigon@debian.org>
Date: Wed, 07 Mar 2012 13:41:39 +0100

--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -3,6 +3,8 @@
 # targets with "PYPREFIX":
 PYTHON ?= python
 PYPREFIX ?= $(notdir $(PYTHON))
+RUBY ?= ruby
+RUBYPREFIX ?= $(notdir $(RUBY))
 
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
@@ -13,8 +15,8 @@
 PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell pkg-config --libs $(PYPREFIX))
 PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
-RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
-RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
+RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
+RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 LIBBASE=$(shell basename $(LIBDIR))
@@ -42,10 +44,10 @@
 SWIGCOUT= semanageswig_wrap.c
 SWIGRUBYCOUT= semanageswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
-SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT)) 
 SWIGSO=$(PYPREFIX)_semanage.so
 SWIGFILES=$(SWIGSO) semanage.py 
-SWIGRUBYSO=_rubysemanage.so
+SWIGRUBYSO=$(RUBYPREFIX)_rubysemanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
 
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
