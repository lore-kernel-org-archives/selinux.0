Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDFC433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiDFOFG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiDFOEr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 10:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96DD972E27
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jc1HSzOdZxSGmQHvjxqHcZQrXFV2qFct4K8WAjDuGdE=;
        b=UomOj3SYaws+SE49rbwehqFa9dzG4QBzD9G1ZD04PxiLFHNbfSmIzfdaNlH8s0qoTzkmwH
        pfvMZ7KhQ+bLH/LIwtj9rEhUZacy2qGsjHhreRPMv+1VgIPTvQZeGve5fYxuo+I3cYbSyv
        jpCBJsH01wAVtclIuKr1lQnqkYUsR4E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-pkF4ppPZNMuozL_nM_x_vQ-1; Wed, 06 Apr 2022 05:32:43 -0400
X-MC-Unique: pkF4ppPZNMuozL_nM_x_vQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F4F91C04B7B;
        Wed,  6 Apr 2022 09:32:42 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23161403173;
        Wed,  6 Apr 2022 09:32:37 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] Split po/ translation files into the relevant
 sub-directories
In-Reply-To: <CAP+JOzTL=K_d=0TXWCsDW7M-3PyB7B7AEnrJrOyYZCZ+tSLJGQ@mail.gmail.com>
References: <20220401095724.98956-1-plautrba@redhat.com>
 <20220401095724.98956-2-plautrba@redhat.com>
 <CAP+JOzTL=K_d=0TXWCsDW7M-3PyB7B7AEnrJrOyYZCZ+tSLJGQ@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:32:37 +0200
Message-ID: <87ee2apney.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Apr 1, 2022 at 11:45 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> When policycoreutils was split into policycoreutils/ python/ gui/ and sandbox/
>> sub-directories, po/ translation files stayed in policycoreutils/.
>>
>> This commit splits original policycoreutils translations to
>> policycoreutils, selinux-python, selinux-gui, and selinux-sandbox.
>>
>> See original Fedora issue https://github.com/fedora-selinux/selinux/issues/43
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> There is an extra space at the end of one of the lines as indicated
> below, but that can be fixed when merged.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>


Merged with fixed extra space, thanks!


>> ---
>>  gui/Makefile                                 |  4 +
>>  gui/booleansPage.py                          |  2 +-
>>  gui/domainsPage.py                           |  2 +-
>>  gui/fcontextPage.py                          |  2 +-
>>  gui/loginsPage.py                            |  2 +-
>>  gui/modulesPage.py                           |  2 +-
>>  gui/po/Makefile                              | 84 +++++++++++++++++++
>>  gui/po/POTFILES                              | 17 ++++
>>  gui/polgengui.py                             |  2 +-
>>  gui/portsPage.py                             |  2 +-
>>  gui/semanagePage.py                          |  2 +-
>>  gui/statusPage.py                            |  2 +-
>>  gui/system-config-selinux.py                 |  2 +-
>>  gui/usersPage.py                             |  2 +-
>>  policycoreutils/po/Makefile                  | 72 ++---------------
>>  policycoreutils/po/POTFILES                  |  9 +++
>>  python/Makefile                              |  2 +-
>>  python/chcat/chcat                           |  2 +-
>>  python/po/Makefile                           | 85 ++++++++++++++++++++
>>  python/po/POTFILES                           | 10 +++
>>  python/semanage/semanage                     |  2 +-
>>  python/semanage/seobject.py                  |  2 +-
>>  python/sepolgen/src/sepolgen/sepolgeni18n.py |  2 +-
>>  python/sepolicy/sepolicy.py                  |  2 +-
>>  python/sepolicy/sepolicy/__init__.py         |  2 +-
>>  python/sepolicy/sepolicy/generate.py         |  2 +-
>>  python/sepolicy/sepolicy/gui.py              |  2 +-
>>  python/sepolicy/sepolicy/interface.py        |  2 +-
>>  sandbox/Makefile                             |  3 +
>>  sandbox/po/Makefile                          | 84 +++++++++++++++++++
>>  sandbox/po/POTFILES                          |  1 +
>>  sandbox/sandbox                              |  2 +-
>>  32 files changed, 324 insertions(+), 89 deletions(-)
>>  create mode 100644 gui/po/Makefile
>>  create mode 100644 gui/po/POTFILES
>>  create mode 100644 policycoreutils/po/POTFILES
>>  create mode 100644 python/po/Makefile
>>  create mode 100644 python/po/POTFILES
>>  create mode 100644 sandbox/po/Makefile
>>  create mode 100644 sandbox/po/POTFILES
>>
>> diff --git a/gui/Makefile b/gui/Makefile
>> index ca965c942912..4035fb21b8c9 100644
>> --- a/gui/Makefile
>> +++ b/gui/Makefile
>> @@ -22,6 +22,7 @@ system-config-selinux.ui \
>>  usersPage.py
>>
>>  all: $(TARGETS) system-config-selinux.py polgengui.py
>> +       (cd po && $(MAKE) $@)
>>
>>  install: all
>>         -mkdir -p $(DESTDIR)$(MANDIR)/man8
>> @@ -54,7 +55,10 @@ install: all
>>                 install -m 644 sepolicy_$${i}.png $(DESTDIR)$(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
>>         done
>>         install -m 644 org.selinux.config.policy $(DESTDIR)$(DATADIR)/polkit-1/actions/
>> +       (cd po && $(MAKE) $@)
>> +
>>  clean:
>> +       (cd po && $(MAKE) $@)
>>
>>  indent:
>>
>> diff --git a/gui/booleansPage.py b/gui/booleansPage.py
>> index 7849bea26a06..dd12b6d6ab86 100644
>> --- a/gui/booleansPage.py
>> +++ b/gui/booleansPage.py
>> @@ -38,7 +38,7 @@ DISABLED = 2
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/domainsPage.py b/gui/domainsPage.py
>> index bad5140d8c59..6bbe4de5884f 100644
>> --- a/gui/domainsPage.py
>> +++ b/gui/domainsPage.py
>> @@ -30,7 +30,7 @@ from semanagePage import *
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
>> index d26aa1b405a9..52292cae01d2 100644
>> --- a/gui/fcontextPage.py
>> +++ b/gui/fcontextPage.py
>> @@ -47,7 +47,7 @@ class context:
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/loginsPage.py b/gui/loginsPage.py
>> index b67eb8bc42af..cbfb0cc23f65 100644
>> --- a/gui/loginsPage.py
>> +++ b/gui/loginsPage.py
>> @@ -29,7 +29,7 @@ from semanagePage import *
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
>> index 0584acf9b3a4..35a0129bab9c 100644
>> --- a/gui/modulesPage.py
>> +++ b/gui/modulesPage.py
>> @@ -30,7 +30,7 @@ from semanagePage import *
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/po/Makefile b/gui/po/Makefile
>> new file mode 100644
>> index 000000000000..7ccd48eb2422
>> --- /dev/null
>> +++ b/gui/po/Makefile
>> @@ -0,0 +1,84 @@
>> +#
>> +# Makefile for the PO files (translation) catalog
>> +#
>> +
>> +PREFIX ?= /usr
>> +
>> +# What is this package?
>> +NLSPACKAGE     = gui
>> +POTFILE                = $(NLSPACKAGE).pot
>> +INSTALL                = /usr/bin/install -c -p
>> +INSTALL_DATA   = $(INSTALL) -m 644
>> +INSTALL_DIR    = /usr/bin/install -d
>> +
>> +# destination directory
>> +INSTALL_NLS_DIR = $(PREFIX)/share/locale
>> +
>> +# PO catalog handling
>> +MSGMERGE       = msgmerge
>> +MSGMERGE_FLAGS = -q
>> +XGETTEXT       = xgettext --default-domain=$(NLSPACKAGE)
>> +MSGFMT         = msgfmt
>> +
>> +# All possible linguas
>> +PO_LINGUAS := $(sort $(patsubst %.po,%,$(wildcard *.po)))
>> +
>> +# Only the files matching what the user has set in LINGUAS
>> +USER_LINGUAS := $(filter $(patsubst %,%%,$(LINGUAS)),$(PO_LINGUAS))
>> +
>> +# if no valid LINGUAS, build all languages
>> +USE_LINGUAS := $(if $(USER_LINGUAS),$(USER_LINGUAS),$(PO_LINGUAS))
>> +
>> +POFILES                = $(patsubst %,%.po,$(USE_LINGUAS))
>> +MOFILES                = $(patsubst %.po,%.mo,$(POFILES))
>> +POTFILES  = $(shell cat POTFILES)
>> +
>> +#default:: clean
>> +
>> +all::  $(MOFILES)
>> +
>> +$(POTFILE): $(POTFILES)
>> +       $(XGETTEXT) --keyword=_ --keyword=N_ $(POTFILES)
>> +       @if cmp -s $(NLSPACKAGE).po $(POTFILE); then \
>> +           rm -f $(NLSPACKAGE).po; \
>> +       else \
>> +           mv -f $(NLSPACKAGE).po $(POTFILE); \
>> +       fi; \
>> +
>> +
>> +refresh-po: Makefile
>> +       for cat in $(POFILES); do \
>> +               lang=`basename $$cat .po`; \
>> +               if $(MSGMERGE) $(MSGMERGE_FLAGS) $$lang.po $(POTFILE) > $$lang.pot ; then \
>> +                       mv -f $$lang.pot $$lang.po ; \
>> +                       echo "$(MSGMERGE) of $$lang succeeded" ; \
>> +               else \
>> +                       echo "$(MSGMERGE) of $$lang failed" ; \
>> +                       rm -f $$lang.pot ; \
>> +               fi \
>> +       done
>> +
>> +clean:
>> +       @rm -fv *mo *~ .depend
>> +       @rm -rf tmp
>> +
>> +install: $(MOFILES)
>> +       @for n in $(MOFILES); do \
>> +           l=`basename $$n .mo`; \
>> +           $(INSTALL_DIR) $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES; \
>> +           $(INSTALL_DATA) --verbose $$n $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES/selinux-$(NLSPACKAGE).mo; \
>> +       done
>> +
>> +%.mo: %.po
>> +       $(MSGFMT) -o $@ $<
>> +report:
>> +       @for cat in $(wildcard *.po); do \
>> +                echo -n "$$cat: "; \
>> +                msgfmt -v --statistics -o /dev/null $$cat; \
>> +        done
>> +
>> +.PHONY: missing depend
>> +
>> +relabel:
>> +
>> +test:
>> diff --git a/gui/po/POTFILES b/gui/po/POTFILES
>> new file mode 100644
>> index 000000000000..1795c5c1951b
>> --- /dev/null
>> +++ b/gui/po/POTFILES
>> @@ -0,0 +1,17 @@
>> +../booleansPage.py
>> +../domainsPage.py
>> +../fcontextPage.py
>> +../loginsPage.py
>> +../modulesPage.py
>> +../org.selinux.config.policy
>> +../polgengui.py
>> +../polgen.ui
>> +../portsPage.py
>> +../selinux-polgengui.desktop
>> +../semanagePage.py
>> +../sepolicy.desktop
>> +../statusPage.py
>> +../system-config-selinux.desktop
>> +../system-config-selinux.py
>> +../system-config-selinux.ui
>> +../usersPage.py
>> diff --git a/gui/polgengui.py b/gui/polgengui.py
>> index d284ded65279..01f541bafae8 100644
>> --- a/gui/polgengui.py
>> +++ b/gui/polgengui.py
>> @@ -63,7 +63,7 @@ def get_all_modules():
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/portsPage.py b/gui/portsPage.py
>> index 30f58383bc1d..a537ecc8c0a1 100644
>> --- a/gui/portsPage.py
>> +++ b/gui/portsPage.py
>> @@ -35,7 +35,7 @@ from semanagePage import *
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/semanagePage.py b/gui/semanagePage.py
>> index 4127804fbbee..5361d69c1313 100644
>> --- a/gui/semanagePage.py
>> +++ b/gui/semanagePage.py
>> @@ -22,7 +22,7 @@ from gi.repository import Gdk, Gtk
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/statusPage.py b/gui/statusPage.py
>> index 766854b19cba..a8f079b9b163 100644
>> --- a/gui/statusPage.py
>> +++ b/gui/statusPage.py
>> @@ -35,7 +35,7 @@ RELABELFILE = "/.autorelabel"
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
>> index 3f70122b87e8..8c46c987b974 100644
>> --- a/gui/system-config-selinux.py
>> +++ b/gui/system-config-selinux.py
>> @@ -45,7 +45,7 @@ import selinux
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/gui/usersPage.py b/gui/usersPage.py
>> index 26794ed5c3f3..d15d4c5a71dd 100644
>> --- a/gui/usersPage.py
>> +++ b/gui/usersPage.py
>> @@ -29,7 +29,7 @@ from semanagePage import *
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-gui"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
>> index 575e143122e6..5ff92bff6fdc 100644
>> --- a/policycoreutils/po/Makefile
>> +++ b/policycoreutils/po/Makefile
>> @@ -3,7 +3,6 @@
>>  #
>>
>>  PREFIX ?= /usr
>> -TOP     = ../..
>>
>>  # What is this package?
>>  NLSPACKAGE     = policycoreutils
>> @@ -32,74 +31,13 @@ USE_LINGUAS := $(if $(USER_LINGUAS),$(USER_LINGUAS),$(PO_LINGUAS))
>>
>>  POFILES                = $(patsubst %,%.po,$(USE_LINGUAS))
>>  MOFILES                = $(patsubst %.po,%.mo,$(POFILES))
>> -POTFILES = \
>> -       ../run_init/open_init_pty.c \
>> -       ../run_init/run_init.c \
>> -       ../semodule_link/semodule_link.c \
>> -       ../audit2allow/audit2allow \
>> -       ../semanage/seobject.py \
>> -       ../setsebool/setsebool.c \
>> -       ../newrole/newrole.c \
>> -       ../load_policy/load_policy.c \
>> -       ../sestatus/sestatus.c \
>> -       ../semodule/semodule.c \
>> -       ../setfiles/setfiles.c \
>> -       ../semodule_package/semodule_package.c \
>> -       ../semodule_deps/semodule_deps.c \
>> -       ../semodule_expand/semodule_expand.c \
>> -       ../scripts/chcat \
>> -       ../scripts/fixfiles \
>> -       ../restorecond/stringslist.c \
>> -       ../restorecond/restorecond.h \
>> -       ../restorecond/utmpwatcher.h \
>> -       ../restorecond/stringslist.h \
>> -       ../restorecond/restorecond.c \
>> -       ../restorecond/utmpwatcher.c \
>> -       ../gui/booleansPage.py \
>> -       ../gui/fcontextPage.py \
>> -       ../gui/loginsPage.py \
>> -       ../gui/mappingsPage.py \
>> -       ../gui/modulesPage.py \
>> -       ../gui/polgen.glade \
>> -       ../gui/polgengui.py \
>> -       ../gui/portsPage.py \
>> -       ../gui/semanagePage.py \
>> -       ../gui/statusPage.py \
>> -       ../gui/system-config-selinux.glade \
>> -       ../gui/system-config-selinux.py \
>> -       ../gui/usersPage.py \
>> -       ../secon/secon.c \
>> -       booleans.py \
>> -       ../sepolicy/sepolicy.py \
>> -       ../sepolicy/sepolicy/communicate.py \
>> -       ../sepolicy/sepolicy/__init__.py \
>> -       ../sepolicy/sepolicy/network.py \
>> -       ../sepolicy/sepolicy/generate.py \
>> -       ../sepolicy/sepolicy/sepolicy.glade \
>> -       ../sepolicy/sepolicy/gui.py \
>> -       ../sepolicy/sepolicy/manpage.py \
>> -       ../sepolicy/sepolicy/transition.py \
>> -       ../sepolicy/sepolicy/templates/executable.py \
>> -       ../sepolicy/sepolicy/templates/__init__.py \
>> -       ../sepolicy/sepolicy/templates/network.py \
>> -       ../sepolicy/sepolicy/templates/rw.py \
>> -       ../sepolicy/sepolicy/templates/script.py \
>> -       ../sepolicy/sepolicy/templates/semodule.py \
>> -       ../sepolicy/sepolicy/templates/tmp.py \
>> -       ../sepolicy/sepolicy/templates/user.py \
>> -       ../sepolicy/sepolicy/templates/var_lib.py \
>> -       ../sepolicy/sepolicy/templates/var_log.py \
>> -       ../sepolicy/sepolicy/templates/var_run.py \
>> -       ../sepolicy/sepolicy/templates/var_spool.py
>> +POTFILES  = $(shell cat POTFILES)
>>
>>  #default:: clean
>>
>> -all::  $(MOFILES)
>> +all:: $(POTFILE) $(MOFILES)
>>
>> -booleans.py:
>> -       sepolicy booleans -a > booleans.py
>> -
>> -$(POTFILE): $(POTFILES) booleans.py
>> +$(POTFILE): $(POTFILES)
>>         $(XGETTEXT) --keyword=_ --keyword=N_ $(POTFILES)
>>         @if cmp -s $(NLSPACKAGE).po $(POTFILE); then \
>>             rm -f $(NLSPACKAGE).po; \
>> @@ -107,8 +45,6 @@ $(POTFILE): $(POTFILES) booleans.py
>>             mv -f $(NLSPACKAGE).po $(POTFILE); \
>>         fi; \
>>
>> -update-po: Makefile $(POTFILE) refresh-po
>> -       @rm -f booleans.py
>>
>>  refresh-po: Makefile
>>         for cat in $(POFILES); do \
>> @@ -144,3 +80,5 @@ report:
>>  .PHONY: missing depend
>>
>>  relabel:
>> +
>> +test:
>> diff --git a/policycoreutils/po/POTFILES b/policycoreutils/po/POTFILES
>> new file mode 100644
>> index 000000000000..12237dc61ee4
>> --- /dev/null
>> +++ b/policycoreutils/po/POTFILES
>> @@ -0,0 +1,9 @@
>> +../run_init/open_init_pty.c
>> +../run_init/run_init.c
>> +../setsebool/setsebool.c
>> +../newrole/newrole.c
>> +../load_policy/load_policy.c
>> +../sestatus/sestatus.c
>> +../semodule/semodule.c
>> +../setfiles/setfiles.c
>> +../secon/secon.c
>> diff --git a/python/Makefile b/python/Makefile
>> index 9b66d52fbd4d..00312dbdb5c6 100644
>> --- a/python/Makefile
>> +++ b/python/Makefile
>> @@ -1,4 +1,4 @@
>> -SUBDIRS = sepolicy audit2allow semanage sepolgen chcat
>> +SUBDIRS = sepolicy audit2allow semanage sepolgen chcat po
>>
>>  all install relabel clean indent test:
>>         @for subdir in $(SUBDIRS); do \
>> diff --git a/python/chcat/chcat b/python/chcat/chcat
>> index fdd2e46ee3f9..839ddd3b54b6 100755
>> --- a/python/chcat/chcat
>> +++ b/python/chcat/chcat
>> @@ -30,7 +30,7 @@ import getopt
>>  import selinux
>>  import seobject
>>
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/po/Makefile b/python/po/Makefile
>> new file mode 100644
>> index 000000000000..05e49f0cc274
>> --- /dev/null
>> +++ b/python/po/Makefile
>> @@ -0,0 +1,85 @@
>> +#
>> +# Makefile for the PO files (translation) catalog
>> +#
>> +
>> +PREFIX ?= /usr
>> +
>> +# What is this package?
>> +NLSPACKAGE     = python
>> +POTFILE                = $(NLSPACKAGE).pot
>> +INSTALL                = /usr/bin/install -c -p
>> +INSTALL_DATA   = $(INSTALL) -m 644
>> +INSTALL_DIR    = /usr/bin/install -d
>> +
>> +# destination directory
>> +INSTALL_NLS_DIR = $(PREFIX)/share/locale
>> +
>> +# PO catalog handling
>> +MSGMERGE       = msgmerge
>> +MSGMERGE_FLAGS = -q
>> +XGETTEXT       = xgettext --default-domain=$(NLSPACKAGE)
>> +MSGFMT         = msgfmt
>> +
>> +# All possible linguas
>> +PO_LINGUAS := $(sort $(patsubst %.po,%,$(wildcard *.po)))
>> +
>> +# Only the files matching what the user has set in LINGUAS
>> +USER_LINGUAS := $(filter $(patsubst %,%%,$(LINGUAS)),$(PO_LINGUAS))
>> +
>> +# if no valid LINGUAS, build all languages
>> +USE_LINGUAS := $(if $(USER_LINGUAS),$(USER_LINGUAS),$(PO_LINGUAS))
>> +
>> +POFILES                = $(patsubst %,%.po,$(USE_LINGUAS))
>> +MOFILES                = $(patsubst %.po,%.mo,$(POFILES))
>> +POTFILES  = $(shell cat POTFILES)
>> +
>> +#default:: clean
>> +
>> +all::  $(MOFILES)
>> +
>> +$(POTFILE): $(POTFILES)
>
> Extra space at the end of the line above.
>
>> +       $(XGETTEXT) -L Python --keyword=_ --keyword=N_ $(POTFILES)
>> +       $(XGETTEXT) -j --keyword=_ --keyword=N_ ../sepolicy/sepolicy/sepolicy.glade
>> +       @if cmp -s $(NLSPACKAGE).po $(POTFILE); then \
>> +           rm -f $(NLSPACKAGE).po; \
>> +       else \
>> +           mv -f $(NLSPACKAGE).po $(POTFILE); \
>> +       fi; \
>> +
>> +
>> +refresh-po: Makefile
>> +       for cat in $(POFILES); do \
>> +               lang=`basename $$cat .po`; \
>> +               if $(MSGMERGE) $(MSGMERGE_FLAGS) $$lang.po $(POTFILE) > $$lang.pot ; then \
>> +                       mv -f $$lang.pot $$lang.po ; \
>> +                       echo "$(MSGMERGE) of $$lang succeeded" ; \
>> +               else \
>> +                       echo "$(MSGMERGE) of $$lang failed" ; \
>> +                       rm -f $$lang.pot ; \
>> +               fi \
>> +       done
>> +
>> +clean:
>> +       @rm -fv *mo *~ .depend
>> +       @rm -rf tmp
>> +
>> +install: $(MOFILES)
>> +       @for n in $(MOFILES); do \
>> +           l=`basename $$n .mo`; \
>> +           $(INSTALL_DIR) $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES; \
>> +           $(INSTALL_DATA) --verbose $$n $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES/selinux-$(NLSPACKAGE).mo; \
>> +       done
>> +
>> +%.mo: %.po
>> +       $(MSGFMT) -o $@ $<
>> +report:
>> +       @for cat in $(wildcard *.po); do \
>> +                echo -n "$$cat: "; \
>> +                msgfmt -v --statistics -o /dev/null $$cat; \
>> +        done
>> +
>> +.PHONY: missing depend
>> +
>> +relabel:
>> +
>> +test:
>> diff --git a/python/po/POTFILES b/python/po/POTFILES
>> new file mode 100644
>> index 000000000000..128eb870a69e
>> --- /dev/null
>> +++ b/python/po/POTFILES
>> @@ -0,0 +1,10 @@
>> +../audit2allow/audit2allow
>> +../chcat/chcat
>> +../semanage/semanage
>> +../semanage/seobject.py
>> +../sepolgen/src/sepolgen/interfaces.py
>> +../sepolicy/sepolicy/generate.py
>> +../sepolicy/sepolicy/gui.py
>> +../sepolicy/sepolicy/__init__.py
>> +../sepolicy/sepolicy/interface.py
>> +../sepolicy/sepolicy.py
>> diff --git a/python/semanage/semanage b/python/semanage/semanage
>> index ff9fb66b1411..12bb159ef649 100644
>> --- a/python/semanage/semanage
>> +++ b/python/semanage/semanage
>> @@ -30,7 +30,7 @@ import seobject
>>  import sys
>>  import traceback
>>
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index 21adbf6eb74f..69e60db80060 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -29,7 +29,7 @@ import sys
>>  import stat
>>  import socket
>>  from semanage import *
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  import sepolicy
>>  from setools.policyrep import SELinuxPolicy
>>  from setools.typequery import TypeQuery
>> diff --git a/python/sepolgen/src/sepolgen/sepolgeni18n.py b/python/sepolgen/src/sepolgen/sepolgeni18n.py
>> index 998c4356415c..56ebd807c69c 100644
>> --- a/python/sepolgen/src/sepolgen/sepolgeni18n.py
>> +++ b/python/sepolgen/src/sepolgen/sepolgeni18n.py
>> @@ -19,7 +19,7 @@
>>
>>  try:
>>      import gettext
>> -    t = gettext.translation( 'yumex' )
>> +    t = gettext.translation( 'selinux-python' )
>>      _ = t.gettext
>>  except:
>>      def _(str):
>> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
>> index 7b2230651099..32956e58f52e 100755
>> --- a/python/sepolicy/sepolicy.py
>> +++ b/python/sepolicy/sepolicy.py
>> @@ -28,7 +28,7 @@ import sepolicy
>>  from multiprocessing import Pool
>>  from sepolicy import get_os_version, get_conditionals, get_conditionals_format_text
>>  import argparse
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index e8654abbceb3..203ca25f4210 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -23,7 +23,7 @@ from setools.typeattrquery import TypeAttributeQuery
>>  from setools.typequery import TypeQuery
>>  from setools.userquery import UserQuery
>>
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
>> index 4e1ed4e9dc31..43180ca6fda4 100644
>> --- a/python/sepolicy/sepolicy/generate.py
>> +++ b/python/sepolicy/sepolicy/generate.py
>> @@ -48,7 +48,7 @@ import sepolgen.defaults as defaults
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
>> index 1e86422b864a..c9ca158ddd09 100644
>> --- a/python/sepolicy/sepolicy/gui.py
>> +++ b/python/sepolicy/sepolicy/gui.py
>> @@ -41,7 +41,7 @@ import os
>>  import re
>>  import unicodedata
>>
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
>> index bdffb770f364..9d40aea1498d 100644
>> --- a/python/sepolicy/sepolicy/interface.py
>> +++ b/python/sepolicy/sepolicy/interface.py
>> @@ -30,7 +30,7 @@ __all__ = ['get_all_interfaces', 'get_interfaces_from_xml', 'get_admin', 'get_us
>>  ##
>>  ## I18N
>>  ##
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-python"
>>  try:
>>      import gettext
>>      kwargs = {}
>> diff --git a/sandbox/Makefile b/sandbox/Makefile
>> index 9da5e58db9e6..84cb5a39bf7e 100644
>> --- a/sandbox/Makefile
>> +++ b/sandbox/Makefile
>> @@ -13,6 +13,7 @@ override LDLIBS += -lselinux -lcap-ng
>>  SEUNSHARE_OBJS = seunshare.o
>>
>>  all: sandbox seunshare sandboxX.sh start
>> +       (cd po && $(MAKE) $@)
>>
>>  seunshare: $(SEUNSHARE_OBJS)
>>
>> @@ -39,12 +40,14 @@ install: all
>>         install -m 755 start $(DESTDIR)$(SHAREDIR)
>>         -mkdir -p $(DESTDIR)$(SYSCONFDIR)
>>         install -m 644 sandbox.conf $(DESTDIR)$(SYSCONFDIR)/sandbox
>> +       (cd po && $(MAKE) $@)
>>
>>  test:
>>         @$(PYTHON) test_sandbox.py -v
>>
>>  clean:
>>         -rm -f seunshare *.o *~
>> +       (cd po && $(MAKE) $@)
>>
>>  indent:
>>         ../../scripts/Lindent $(wildcard *.[ch])
>> diff --git a/sandbox/po/Makefile b/sandbox/po/Makefile
>> new file mode 100644
>> index 000000000000..e75343649b67
>> --- /dev/null
>> +++ b/sandbox/po/Makefile
>> @@ -0,0 +1,84 @@
>> +#
>> +# Makefile for the PO files (translation) catalog
>> +#
>> +
>> +PREFIX ?= /usr
>> +
>> +# What is this package?
>> +NLSPACKAGE     = sandbox
>> +POTFILE                = $(NLSPACKAGE).pot
>> +INSTALL                = /usr/bin/install -c -p
>> +INSTALL_DATA   = $(INSTALL) -m 644
>> +INSTALL_DIR    = /usr/bin/install -d
>> +
>> +# destination directory
>> +INSTALL_NLS_DIR = $(PREFIX)/share/locale
>> +
>> +# PO catalog handling
>> +MSGMERGE       = msgmerge
>> +MSGMERGE_FLAGS = -q
>> +XGETTEXT       = xgettext -L Python --default-domain=$(NLSPACKAGE)
>> +MSGFMT         = msgfmt
>> +
>> +# All possible linguas
>> +PO_LINGUAS := $(sort $(patsubst %.po,%,$(wildcard *.po)))
>> +
>> +# Only the files matching what the user has set in LINGUAS
>> +USER_LINGUAS := $(filter $(patsubst %,%%,$(LINGUAS)),$(PO_LINGUAS))
>> +
>> +# if no valid LINGUAS, build all languages
>> +USE_LINGUAS := $(if $(USER_LINGUAS),$(USER_LINGUAS),$(PO_LINGUAS))
>> +
>> +POFILES                = $(patsubst %,%.po,$(USE_LINGUAS))
>> +MOFILES                = $(patsubst %.po,%.mo,$(POFILES))
>> +POTFILES  = $(shell cat POTFILES)
>> +
>> +#default:: clean
>> +
>> +all:: $(POTFILE) $(MOFILES)
>> +
>> +$(POTFILE): $(POTFILES)
>> +       $(XGETTEXT) --keyword=_ --keyword=N_ $(POTFILES)
>> +       @if cmp -s $(NLSPACKAGE).po $(POTFILE); then \
>> +           rm -f $(NLSPACKAGE).po; \
>> +       else \
>> +           mv -f $(NLSPACKAGE).po $(POTFILE); \
>> +       fi; \
>> +
>> +
>> +refresh-po: Makefile
>> +       for cat in $(POFILES); do \
>> +               lang=`basename $$cat .po`; \
>> +               if $(MSGMERGE) $(MSGMERGE_FLAGS) $$lang.po $(POTFILE) > $$lang.pot ; then \
>> +                       mv -f $$lang.pot $$lang.po ; \
>> +                       echo "$(MSGMERGE) of $$lang succeeded" ; \
>> +               else \
>> +                       echo "$(MSGMERGE) of $$lang failed" ; \
>> +                       rm -f $$lang.pot ; \
>> +               fi \
>> +       done
>> +
>> +clean:
>> +       @rm -fv *mo *~ .depend
>> +       @rm -rf tmp
>> +
>> +install: $(MOFILES)
>> +       @for n in $(MOFILES); do \
>> +           l=`basename $$n .mo`; \
>> +           $(INSTALL_DIR) $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES; \
>> +           $(INSTALL_DATA) --verbose $$n $(DESTDIR)$(INSTALL_NLS_DIR)/$$l/LC_MESSAGES/selinux-$(NLSPACKAGE).mo; \
>> +       done
>> +
>> +%.mo: %.po
>> +       $(MSGFMT) -o $@ $<
>> +report:
>> +       @for cat in $(wildcard *.po); do \
>> +                echo -n "$$cat: "; \
>> +                msgfmt -v --statistics -o /dev/null $$cat; \
>> +        done
>> +
>> +.PHONY: missing depend
>> +
>> +relabel:
>> +
>> +test:
>> diff --git a/sandbox/po/POTFILES b/sandbox/po/POTFILES
>> new file mode 100644
>> index 000000000000..deff3f2f4656
>> --- /dev/null
>> +++ b/sandbox/po/POTFILES
>> @@ -0,0 +1 @@
>> +../sandbox
>> diff --git a/sandbox/sandbox b/sandbox/sandbox
>> index ca5f1e030a51..16c43b51eaaa 100644
>> --- a/sandbox/sandbox
>> +++ b/sandbox/sandbox
>> @@ -37,7 +37,7 @@ import sepolicy
>>
>>  SEUNSHARE = "/usr/sbin/seunshare"
>>  SANDBOXSH = "/usr/share/sandbox/sandboxX.sh"
>> -PROGNAME = "policycoreutils"
>> +PROGNAME = "selinux-sandbox"
>>  try:
>>      import gettext
>>      kwargs = {}
>> --
>> 2.35.1
>>

