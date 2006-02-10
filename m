Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1ALTeXf015866
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 16:29:41 -0500 (EST)
Received: from vms053pub.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1ALTZTR026590
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 21:29:35 GMT
Received: from vms134.mailsrvcs.net ([172.19.0.67])
 by vms053.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0IUH00EW7QDE5AM0@vms053.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Fri, 10 Feb 2006 15:29:38 -0600 (CST)
Received: from websphere.columbia.tresys.com ([209.60.7.66])
 by vms134.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTPSA id <0IUH000Z5QDAWPF0@vms134.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Fri, 10 Feb 2006 15:29:38 -0600 (CST)
Date: Fri, 10 Feb 2006 16:29:58 -0500
From: Spencer Shimko <sshimko@tresys.com>
Subject: [PATCH] refpolicy: external modules
To: SELinux <selinux@tycho.nsa.gov>
Cc: Christopher PeBenito <cpebenito@tresys.com>,
   Christopher Ashworth <cashworth@tresys.com>
Message-id: <200602101629.58281.sshimko@tresys.com>
MIME-version: 1.0
Content-type: Multipart/Mixed; boundary="Boundary-00=_WXQ7DkmZg+Adumq"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_WXQ7DkmZg+Adumq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All,

Attached is a patch to Makefile, Rules.monolithic, and Rules.modular in 
reference policy that does two things:

1. It contains an update version of the patch submitted to the list on 
1/12/2006 to change policy module state from the command line at build 
time.  The three variables used are APPS_OFF (disable a policy module 
off), APPS_ON (enable a policy module and include it in the base module), 
and APPS_MODS (enable a policy module and build it as a module).  Example 
usage:
$make clean
$make APPS_OFF="gpg" 

2. It includes a patch from Chris Ashworth that allows external policy 
trees to be used when building policy.  The idea for this is two fold: 
first it allows someone to build a module without having write access to 
the reference policy directory, second it allows someone to maintain an 
out-of-tree "third-party" module with little effort.  It expects a 
similar filesystem layout including layers in the policy/modules 
directory and support macros (if any) in the policy/support directory.  
Example usage:
$make LOCAL_ROOT="/home/spencer/mypolicy"

Thanks,
Spencer
-- 
Spencer Shimko
Tresys Technology, LLC
(410) 290 - 1411 ext. 125
sshimko@tresys.com

--Boundary-00=_WXQ7DkmZg+Adumq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="refpol-extmod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="refpol-extmod.patch"

diff -urN refpolicy-old/Makefile refpolicy-new/Makefile
--- refpolicy-old/Makefile	2006-02-10 13:41:53.000000000 -0500
+++ refpolicy-new/Makefile	2006-02-10 16:18:26.000000000 -0500
@@ -23,11 +23,33 @@
 # NO OPTIONS BELOW HERE
 #
 
-include build.conf
+# Top level directory - so make can be run from outside 
+# of the tree (if this is overridden on the command line)
+ROOT := .
+
+# Include the local build.conf if it exists, otherwise
+# include the configuration of the root directory.
+ifdef LOCAL_ROOT
+	include $(LOCAL_ROOT)/build.conf
+else
+	include $(ROOT)/build.conf
+endif
 
 # refpolicy version
 VERSION = $(shell cat VERSION)
 
+ifdef LOCAL_ROOT
+BUILDDIR := $(LOCAL_ROOT)
+TMP_ROOT := $(LOCAL_ROOT)
+TAGS := $(LOCAL_ROOT)/tags
+else
+BUILDDIR := $(ROOT)
+TMP_ROOT := $(ROOT)
+TAGS := $(ROOT)/tags
+endif
+
+TMPDIR := $(TMP_ROOT)/tmp
+
 # executable paths
 BINDIR := /usr/bin
 SBINDIR := /usr/sbin
@@ -43,16 +65,26 @@
 
 CFLAGS := -Wall
 
+# source directory names
+POL_ROOT := policy
+MOD_ROOT := modules
+
 # policy source layout
-POLDIR := policy
-MODDIR := $(POLDIR)/modules
+POLDIR := $(ROOT)/$(POL_ROOT)
+MODDIR := $(POLDIR)/$(MOD_ROOT)
 FLASKDIR := $(POLDIR)/flask
 SECCLASS := $(FLASKDIR)/security_classes
 ISIDS := $(FLASKDIR)/initial_sids
 AVS := $(FLASKDIR)/access_vectors
 
+# local source layout
+ifdef LOCAL_ROOT
+LOCAL_POLDIR := $(LOCAL_ROOT)/$(POL_ROOT)
+LOCAL_MODDIR := $(LOCAL_POLDIR)/$(MOD_ROOT)
+endif
+
 # policy building support tools
-SUPPORT := support
+SUPPORT := $(ROOT)/support
 GENXML := $(SUPPORT)/segenxml.py
 GENDOC := $(SUPPORT)/sedoctool.py
 GENPERM := $(SUPPORT)/genclassperms.py
@@ -60,7 +92,7 @@
 SETTUN := $(SUPPORT)/set_tunables
 
 # documentation paths
-DOCS = doc
+DOCS = $(ROOT)/doc
 POLXML = $(DOCS)/policy.xml
 XMLDTD = $(DOCS)/policy.dtd
 LAYERXML = metadata.xml
@@ -68,14 +100,30 @@
 DOCTEMPLATE = $(DOCS)/templates
 DOCFILES = $(DOCS)/Makefile.example $(addprefix $(DOCS)/,example.te example.if example.fc)
 
+# local doc paths
+ifdef LOCAL_ROOT
+POLXML = $(LOCAL_ROOT)/doc/policy.xml
+HTMLDIR = $(LOCAL_ROOT)/doc/html
+endif
+
+# config file names
+MOD_CONF_FILE := modules.conf
+BOOLEANS_FILE := booleans.conf
+
 # config file paths
 GLOBALTUN = $(POLDIR)/global_tunables
 GLOBALBOOL = $(POLDIR)/global_booleans
-MOD_CONF = $(POLDIR)/modules.conf
+MOD_CONF = $(POLDIR)/$(MOD_CONF_FILE)
 TUNABLES = $(POLDIR)/tunables.conf
-BOOLEANS = $(POLDIR)/booleans.conf
+BOOLEANS = $(POLDIR)/$(BOOLEANS_FILE)
 ROLEMAP = $(POLDIR)/rolemap
 
+# local config file paths
+ifdef LOCAL_ROOT
+MOD_CONF = $(LOCAL_POLDIR)/$(MOD_CONF_FILE)
+BOOLEANS = $(LOCAL_POLDIR)/$(BOOLEANS_FILE)
+endif
+
 # install paths
 PKGNAME ?= refpolicy-$(VERSION)
 PREFIX = $(DESTDIR)/usr
@@ -163,7 +211,7 @@
 	KV := $(PV)
 endif
 
-M4SUPPORT = $(wildcard $(POLDIR)/support/*.spt)
+M4SUPPORT = $(wildcard $(POLDIR)/support/*.spt $(LOCAL_POLDIR)/support/*.spt)
 
 APPCONF := config/appconfig-$(TYPE)
 APPDIR := $(CONTEXTPATH)
@@ -172,7 +220,9 @@
 USER_FILES := $(POLDIR)/users
 
 ALL_LAYERS := $(filter-out $(MODDIR)/CVS,$(shell find $(wildcard $(MODDIR)/*) -maxdepth 0 -type d))
-
+ifneq ($(LOCAL_ROOT),)
+	LOCAL_LAYERS := $(filter-out $(LOCAL_MODDIR)/CVS,$(shell find $(wildcard $(LOCAL_MODDIR)/*) -maxdepth 0 -type d))
+endif
 GENERATED_TE := $(basename $(foreach dir,$(ALL_LAYERS),$(wildcard $(dir)/*.te.in)))
 GENERATED_IF := $(basename $(foreach dir,$(ALL_LAYERS),$(wildcard $(dir)/*.if.in)))
 GENERATED_FC := $(basename $(foreach dir,$(ALL_LAYERS),$(wildcard $(dir)/*.fc.in)))
@@ -190,10 +240,17 @@
 # modules.conf setting for unused module
 MODUNUSED := off
 
+# test for module overrides from command line
+MOD_TEST = $(filter $(APPS_OFF), $(APPS_ON) $(APPS_MODS))
+MOD_TEST += $(filter $(APPS_MODS), $(APPS_ON))
+ifneq ($(strip $(MOD_TEST)),)
+        $(error Applications must be on, module, or off, and not in more than one list! $(strip $(MOD_TEST)) found in multiple lists!)
+endif
+
 # extract settings from modules.conf
-BASE_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null))
-MOD_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null))
-OFF_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODUNUSED)") print $$1 }' $(MOD_CONF) 2> /dev/null))
+BASE_MODS := $(addsuffix .te,$(sort $(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null) $(APPS_ON)))
+MOD_MODS := $(addsuffix .te,$(sort $(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null) $(APPS_MODS)))
+OFF_MODS := $(addsuffix .te,$(sort $(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODUNUSED)") print $$1 }' $(MOD_CONF) 2> /dev/null) $(APPS_OFF)))
 
 # filesystems to be labeled
 FILESYSTEMS = $(shell mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs| jfs).*rw/{print $$3}';)
@@ -222,15 +279,17 @@
 #
 
 ifeq ($(MONOLITHIC),y)
-	include Rules.monolithic
+	include $(ROOT)/Rules.monolithic
 else
-	include Rules.modular
+	include $(ROOT)/Rules.modular
 endif
 
 ########################################
 #
 # Generated files
 #
+# NOTE: There is no "local" version of these files.
+#
 $(MODDIR)/kernel/corenetwork.if: $(MODDIR)/kernel/corenetwork.if.m4 $(MODDIR)/kernel/corenetwork.if.in
 	@echo "#" > $@
 	@echo "# This is a generated file!  Instead of modifying this file, the" >> $@
@@ -257,12 +316,14 @@
 
 $(MOD_CONF) $(BOOLEANS): $(POLXML)
 	@echo "Updating $(MOD_CONF) and $(BOOLEANS)"
-	$(verbose) cd $(DOCS) && ../$(GENDOC) -t ../$(BOOLEANS) -m ../$(MOD_CONF) -x ../$(POLXML)
+	$(verbose) cd $(DOCS) && $(GENDOC) -t $(BOOLEANS) -m $(MOD_CONF) -x $(POLXML)
 
 ########################################
 #
 # Documentation generation
 #
+#
+
 
 # minimal dependencies here, because we don't want to rebuild 
 # this and its dependents every time the dependencies
@@ -270,36 +331,37 @@
 # enabled modules.
 $(POLXML): $(DETECTED_MODS:.te=.if) $(foreach dir,$(ALL_LAYERS),$(dir)/$(LAYERXML))
 	@echo "Creating $@"
-	@mkdir -p tmp
+	@test -d $(dir $(POLXML)) || mkdir -p $(dir $(POLXML))
 	$(verbose) echo '<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>' > $@
 	$(verbose) echo '<!DOCTYPE policy SYSTEM "$(notdir $(XMLDTD))">' >> $@
-	$(verbose) $(GENXML) -m $(LAYERXML) -t $(GLOBALTUN) -b $(GLOBALBOOL) -o tmp $(ALL_LAYERS) >> $@
+	$(verbose) $(GENXML) -m $(LAYERXML) -t $(GLOBALTUN) -b $(GLOBALBOOL) -o $(TMPDIR) $(ALL_LAYERS) $(LOCAL_LAYERS) >> $@
 	$(verbose) if test -x $(XMLLINT) && test -f $(XMLDTD); then \
-		$(XMLLINT) --noout --dtdvalid $(XMLDTD) $@ ;\
+		$(XMLLINT) --noout --path $(dir $(XMLDTD)) --dtdvalid $(XMLDTD) $@ ;\
 	fi
 
-html tmp/html: $(POLXML)
+html $(TMPDIR)/html: $(POLXML)
 	@echo "Building html interface reference documentation in $(HTMLDIR)"
-	@mkdir -p $(HTMLDIR)
-	$(verbose) cd $(DOCS) && ../$(GENDOC) -d ../$(HTMLDIR) -T ../$(DOCTEMPLATE) -x ../$(POLXML)
+	@test -d $(HTMLDIR) || @mkdir -p $(HTMLDIR)
+	$(verbose) cd $(DOCS) && $(GENDOC) -d $(HTMLDIR) -T $(DOCTEMPLATE) -x $(POLXML)
 	$(verbose) cp $(DOCTEMPLATE)/*.css $(HTMLDIR)
-	@touch tmp/html
+	@touch $(TMPDIR)/html
 
 ########################################
 #
 # Runtime binary policy patching of users
 #
-$(USERPATH)/system.users: $(M4SUPPORT) tmp/generated_definitions.conf $(USER_FILES)
+$(USERPATH)/system.users: $(M4SUPPORT) $(TMPDIR)/generated_definitions.conf $(USER_FILES)
+	@mkdir -p $(TMPDIR)
 	@mkdir -p $(USERPATH)
 	@echo "Installing system.users"
-	@echo "# " > tmp/system.users
-	@echo "# Do not edit this file. " >> tmp/system.users
-	@echo "# This file is replaced on reinstalls of this policy." >> tmp/system.users
-	@echo "# Please edit local.users to make local changes." >> tmp/system.users
-	@echo "#" >> tmp/system.users
+	@echo "# " > $(TMPDIR)/system.users
+	@echo "# Do not edit this file. " >> $(TMPDIR)/system.users
+	@echo "# This file is replaced on reinstalls of this policy." >> $(TMPDIR)/system.users
+	@echo "# Please edit local.users to make local changes." >> $(TMPDIR)/system.users
+	@echo "#" >> $(TMPDIR)/system.users
 	$(verbose) m4 -D self_contained_policy $(M4PARAM) $^ | sed -r -e 's/^[[:blank:]]+//' \
-		-e '/^[[:blank:]]*($$|#)/d' >> tmp/system.users
-	$(verbose) install -m 644 tmp/system.users $@
+		-e '/^[[:blank:]]*($$|#)/d' >> $(TMPDIR)/system.users
+	$(verbose) install -m 644 $(TMPDIR)/system.users $@
 
 $(USERPATH)/local.users: config/local.users
 	@mkdir -p $(USERPATH)
@@ -313,10 +375,11 @@
 install-appconfig: $(APPFILES)
 
 $(INSTALLDIR)/booleans: $(BOOLEANS)
+	@mkdir -p $(TMPDIR)
 	@mkdir -p $(INSTALLDIR)
 	$(verbose) sed -r -e 's/false/0/g' -e 's/true/1/g' \
-		-e '/^[[:blank:]]*($$|#)/d' $(BOOLEANS) | sort > tmp/booleans
-	$(verbose) install -m 644 tmp/booleans $@
+		-e '/^[[:blank:]]*($$|#)/d' $(BOOLEANS) | sort > $(TMPDIR)/booleans
+	$(verbose) install -m 644 $(TMPDIR)/booleans $@
 
 $(CONTEXTPATH)/files/media: $(APPCONF)/media
 	@mkdir -p $(CONTEXTPATH)/files/
@@ -358,10 +421,10 @@
 #
 # Install policy headers
 #
-install-headers: doc/policy.xml
+install-headers: $(POLXML)
 	@mkdir -p $(HEADERDIR)
 	@echo "Installing policy headers"
-	$(verbose) install -m 644 tmp/global_{tunables,booleans}.xml $(HEADERDIR)
+	$(verbose) install -m 644 $(TMPDIR)/global_{tunables,booleans}.xml $(HEADERDIR)
 	$(verbose) m4 $(M4PARAM) $(ROLEMAP) > $(HEADERDIR)/$(notdir $(ROLEMAP))
 	$(verbose) mkdir -p $(HEADERDIR)/support
 	$(verbose) install -m 644 $(M4SUPPORT) $(GENXML) $(XMLDTD) $(HEADERDIR)/support
@@ -386,10 +449,11 @@
 #
 # Install policy documentation
 #
-install-docs: tmp/html
+install-docs: $(TMPDIR)/html
 	@mkdir -p $(DOCSDIR)/html
 	@echo "Installing policy documentation"
 	$(verbose) install -m 644 $(DOCFILES) $(DOCSDIR)
+	$(verbose) install -m 644 build.conf $(DOCSDIR)/build.conf.example
 	$(verbose) install -m 644 $(wildcard $(HTMLDIR)/*) $(DOCSDIR)/html
 
 ########################################
@@ -406,9 +470,9 @@
 #
 # Generate tags file
 #
-tags:
+$(TAGS):
 	@($(CTAGS) --version | grep -q Exuberant) || (echo ERROR: Need exuberant-ctags to function!; exit 1)
-	@LC_ALL=C $(CTAGS) --langdef=te --langmap=te:..te.if.spt \
+	@LC_ALL=C $(CTAGS) -f $(TAGS) --langdef=te --langmap=te:..te.if.spt \
 	 --regex-te='/^type[ \t]+(\w+)(,|;)/\1/t,type/' \
 	 --regex-te='/^typealias[ \t]+\w+[ \t+]+alias[ \t]+(\w+);/\1/t,type/' \
 	 --regex-te='/^attribute[ \t]+(\w+);/\1/a,attribute/' \
@@ -458,12 +522,14 @@
 #
 bare: clean
 	rm -f $(POLXML)
-	rm -f $(SUPPORT)/*.pyc
-	rm -f $(FCSORT)
 	rm -f $(MOD_CONF)
 	rm -f $(BOOLEANS)
 	rm -fR $(HTMLDIR)
-	rm -f tags
+	rm -f $(TAGS)
+# don't remove these files if we're given a local root
+ifndef LOCAL_ROOT
+	rm -f $(SUPPORT)/*.pyc
+	rm -f $(FCSORT)
 ifneq ($(GENERATED_TE),)
 	rm -f $(GENERATED_TE)
 endif
@@ -473,6 +539,7 @@
 ifneq ($(GENERATED_FC),)
 	rm -f $(GENERATED_FC)
 endif
+endif
 
 .PHONY: install-src install-appconfig conf html bare tags
 .SUFFIXES:
diff -urN refpolicy-old/Rules.modular refpolicy-new/Rules.modular
--- refpolicy-old/Rules.modular	2006-01-26 15:35:55.000000000 -0500
+++ refpolicy-new/Rules.modular	2006-02-10 15:44:33.000000000 -0500
@@ -8,8 +8,10 @@
 
 BASE_PKG := base.pp
 BASE_FC := base.fc
+BASE_CONF := $(BUILDDIR)/base.conf
+BASE_MOD := base.mod
 
-BASE_SECTIONS := tmp/pre_te_files.conf tmp/generated_definitions.conf tmp/all_interfaces.conf tmp/all_attrs_types.conf $(GLOBALBOOL) $(GLOBALTUN) tmp/only_te_rules.conf tmp/all_post.conf
+BASE_SECTIONS := $(TMPDIR)/pre_te_files.conf $(TMPDIR)/generated_definitions.conf $(TMPDIR)/all_interfaces.conf $(TMPDIR)/all_attrs_types.conf $(GLOBALBOOL) $(GLOBALTUN) $(TMPDIR)/only_te_rules.conf $(TMPDIR)/all_post.conf
 
 BASE_PRE_TE_FILES := $(SECCLASS) $(ISIDS) $(AVS) $(M4SUPPORT) $(POLDIR)/mls $(POLDIR)/mcs
 BASE_TE_FILES := $(BASE_MODS)
@@ -17,15 +19,15 @@
 BASE_FC_FILES := $(BASE_MODS:.te=.fc)
 
 MOD_MODULES := $(MOD_MODS:.te=.mod)
-MOD_PKGS := $(MOD_MODS:.te=.pp)
+MOD_PKGS := $(addprefix $(BUILDDIR)/,$(notdir $(MOD_MODS:.te=.pp)))
 
 # policy packages to install
 INSTPKG := $(addprefix $(MODPKGDIR)/,$(BASE_PKG) $(MOD_PKGS))
 
 # search layer dirs for source files
-vpath %.te $(ALL_LAYERS)
-vpath %.if $(ALL_LAYERS)
-vpath %.fc $(ALL_LAYERS)
+vpath %.te $(ALL_LAYERS) $(LOCAL_LAYERS)
+vpath %.if $(ALL_LAYERS) $(LOCAL_LAYERS)
+vpath %.fc $(ALL_LAYERS) $(LOCAL_LAYERS)
 
 ########################################
 #
@@ -35,7 +37,7 @@
 
 all: base modules
 
-base: $(BASE_PKG)
+base: $(BUILDDIR)/$(BASE_PKG)
 
 modules: $(MOD_PKGS)
 
@@ -53,7 +55,7 @@
 #
 # Install policy packages
 #
-$(MODPKGDIR)/%.pp: %.pp
+$(MODPKGDIR)/%.pp: $(BUILDDIR)/%.pp
 	@mkdir -p $(MODPKGDIR)
 	@echo "Installing $(NAME) $(@F) policy package."
 	$(verbose) install -m 0644 $^ $(MODPKGDIR)
@@ -62,28 +64,32 @@
 #
 # Build module packages
 #
-tmp/%.mod: $(M4SUPPORT) tmp/generated_definitions.conf tmp/all_interfaces.conf %.te
+$(TMPDIR)/%.mod: $(M4SUPPORT) $(TMPDIR)/generated_definitions.conf $(TMPDIR)/all_interfaces.conf %.te
 	@echo "Compliling $(NAME) $(@F) module"
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(call peruser-expansion,$(basename $(@F)),$@.role)
 	$(verbose) m4 $(M4PARAM) -s $^ $@.role > $(@:.mod=.tmp)
 	$(verbose) $(CHECKMODULE) -m $(@:.mod=.tmp) -o $@
 
-tmp/%.mod.fc: $(M4SUPPORT) %.fc
+$(TMPDIR)/%.mod.fc: $(M4SUPPORT) %.fc
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) m4 $(M4PARAM) $(M4SUPPORT) $^ > $@
 
-%.pp: tmp/%.mod tmp/%.mod.fc
+$(BUILDDIR)/%.pp: $(TMPDIR)/%.mod $(TMPDIR)/%.mod.fc
 	@echo "Creating $(NAME) $(@F) policy package"
+	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
 	$(verbose) $(SEMOD_PKG) -o $@ -m $< -f $<.fc
 
 ########################################
 #
 # Create a base module package
 #
-$(BASE_PKG): tmp/base.mod $(BASE_FC)
+$(BUILDDIR)/$(BASE_PKG): $(TMPDIR)/base.mod $(BUILDDIR)/$(BASE_FC)
 	@echo "Creating $(NAME) base module package"
-	$(verbose) $(SEMOD_PKG) -o $@ -m tmp/base.mod -f $(BASE_FC)
+	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
+	$(verbose) $(SEMOD_PKG) -o $@ -m $(TMPDIR)/base.mod -f $(BUILDDIR)/$(BASE_FC)
 
-tmp/base.mod: base.conf
+$(TMPDIR)/base.mod: $(BASE_CONF)
 	@echo "Compiling $(NAME) base module"
 	$(verbose) $(CHECKMODULE) $^ -o $@
 
@@ -91,22 +97,24 @@
 #
 # Construct a base.conf
 #
-base.conf: $(BASE_SECTIONS)
-	@echo "Creating $(NAME) base module base.conf"
+$(BASE_CONF): $(BASE_SECTIONS)
+	@echo "Creating $(NAME) base module $(BASE_CONF)"
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
+	@test -d $(dir $(BASE_CONF)) || mkdir -p $(dir $(BASE_CONF))
 # checkpolicy can use the #line directives provided by -s for error reporting:
-	$(verbose) m4 -D self_contained_policy $(M4PARAM) -s $^ > tmp/$@.tmp
-	$(verbose) sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < tmp/$@.tmp > $@
+	$(verbose) m4 -D self_contained_policy $(M4PARAM) -s $^ > $(TMPDIR)/$(notdir $@).tmp
+	$(verbose) sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < $(TMPDIR)/$(notdir $@).tmp > $@
 # the ordering of these ocontexts matters:
-	$(verbose) grep ^portcon tmp/$@.tmp >> $@ || true
-	$(verbose) grep ^netifcon tmp/$@.tmp >> $@ || true
-	$(verbose) grep ^nodecon tmp/$@.tmp >> $@ || true
+	$(verbose) grep ^portcon $(TMPDIR)/$(notdir $@).tmp >> $@ || true
+	$(verbose) grep ^netifcon $(TMPDIR)/$(notdir $@).tmp >> $@ || true
+	$(verbose) grep ^nodecon $(TMPDIR)/$(notdir $@).tmp >> $@ || true
 
-tmp/pre_te_files.conf: $(BASE_PRE_TE_FILES)
-	@test -d tmp || mkdir -p tmp
+$(TMPDIR)/pre_te_files.conf: $(BASE_PRE_TE_FILES)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 
-tmp/generated_definitions.conf: $(BASE_TE_FILES)
-	@test -d tmp || mkdir -p tmp
+$(TMPDIR)/generated_definitions.conf: $(BASE_TE_FILES)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 # define all available object classes
 	$(verbose) $(GENPERM) $(AVS) $(SECCLASS) > $@
 # per-userdomain templates
@@ -122,81 +130,82 @@
 	done
 	$(verbose) $(SETTUN) $(BOOLEANS) >> $@
 
-tmp/all_interfaces.conf: $(M4SUPPORT) $(ALL_INTERFACES)
+$(TMPDIR)/all_interfaces.conf: $(M4SUPPORT) $(ALL_INTERFACES)
 ifeq ($(ALL_INTERFACES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) m4 $^ | sed -e s/dollarsstar/\$$\*/g > $@
 
-tmp/all_te_files.conf: $(BASE_TE_FILES)
+$(TMPDIR)/all_te_files.conf: $(BASE_TE_FILES)
 ifeq ($(BASE_TE_FILES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 	$(call parse-rolemap,base,$@)
 
-tmp/post_te_files.conf: $(BASE_POST_TE_FILES)
-	@test -d tmp || mkdir -p tmp
+$(TMPDIR)/post_te_files.conf: $(BASE_POST_TE_FILES)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 
 # extract attributes and put them first. extract post te stuff
 # like genfscon and put last.  portcon, nodecon, and netifcon
 # is delayed since they are generated by m4
-tmp/all_attrs_types.conf tmp/only_te_rules.conf tmp/all_post.conf: tmp/all_te_files.conf tmp/post_te_files.conf
-	$(verbose) grep ^attribute tmp/all_te_files.conf > tmp/all_attrs_types.conf || true
-	$(verbose) grep '^type ' tmp/all_te_files.conf >> tmp/all_attrs_types.conf
-	$(verbose) cat tmp/post_te_files.conf > tmp/all_post.conf
-	$(verbose) grep '^sid ' tmp/all_te_files.conf >> tmp/all_post.conf || true
-	$(verbose) egrep '^fs_use_(xattr|task|trans)' tmp/all_te_files.conf >> tmp/all_post.conf || true
-	$(verbose) grep ^genfscon tmp/all_te_files.conf >> tmp/all_post.conf || true
+$(TMPDIR)/all_attrs_types.conf $(TMPDIR)/only_te_rules.conf $(TMPDIR)/all_post.conf: $(TMPDIR)/all_te_files.conf $(TMPDIR)/post_te_files.conf
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
+	$(verbose) grep ^attribute $(TMPDIR)/all_te_files.conf > $(TMPDIR)/all_attrs_types.conf || true
+	$(verbose) grep '^type ' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_attrs_types.conf
+	$(verbose) cat $(TMPDIR)/post_te_files.conf > $(TMPDIR)/all_post.conf
+	$(verbose) grep '^sid ' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
+	$(verbose) egrep '^fs_use_(xattr|task|trans)' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
+	$(verbose) grep ^genfscon $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
 	$(verbose) sed -r -e /^attribute/d -e '/^type /d' -e /^genfscon/d \
 			-e '/^sid /d' -e '/^fs_use_(xattr|task|trans)/d' \
-			< tmp/all_te_files.conf > tmp/only_te_rules.conf
+			< $(TMPDIR)/all_te_files.conf > $(TMPDIR)/only_te_rules.conf
 
 ########################################
 #
 # Construct a base.fc
 #
-$(BASE_FC): tmp/$(BASE_FC).tmp $(FCSORT)
+$(BUILDDIR)/$(BASE_FC): $(TMPDIR)/$(BASE_FC).tmp $(FCSORT)
 	$(verbose) $(FCSORT) $< $@
 
-tmp/$(BASE_FC).tmp: $(M4SUPPORT) tmp/generated_definitions.conf $(BASE_FC_FILES)
+$(TMPDIR)/$(BASE_FC).tmp: $(M4SUPPORT) $(TMPDIR)/generated_definitions.conf $(BASE_FC_FILES)
 ifeq ($(BASE_FC_FILES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
 	@echo "Creating $(NAME) base module file contexts."
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) m4 $(M4PARAM) $^ > $@
 
 ########################################
 #
 # Remove the dontaudit rules from the base.conf
 #
-enableaudit: base.conf
-	@test -d tmp || mkdir -p tmp
-	@echo "Removing dontaudit rules from base.conf"
-	$(verbose) grep -v dontaudit base.conf > tmp/base.audit
-	$(verbose) mv tmp/base.audit base.conf
+enableaudit: $(BASE_CONF)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
+	@echo "Removing dontaudit rules from $(BASE_CONF)"
+	$(verbose) grep -v dontaudit $(BASE_CONF) > $(TMPDIR)/base.audit
+	$(verbose) mv $(TMPDIR)/base.audit $(BASE_CONF)
 
 ########################################
 #
 # Appconfig files
 #
-$(APPDIR)/customizable_types: base.conf
+$(APPDIR)/customizable_types: $(BASE_CONF)
 	@mkdir -p $(APPDIR)
-	$(verbose) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
-	$(verbose) install -m 644 tmp/customizable_types $@ 
+	$(verbose) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > $(TMPDIR)/customizable_types
+	$(verbose) install -m 644 $(TMPDIR)/customizable_types $@ 
 
 ########################################
 #
 # Clean the sources
 #
 clean:
-	rm -f base.conf
-	rm -f *.pp
-	rm -f $(BASE_FC)
-	rm -fR tmp
+	rm -f $(BASE_CONF)
+	rm -f $(BUILDDIR)/*.pp
+	rm -f $(BUILDDIR)/$(BASE_FC)
+	rm -fR $(TMPDIR)
 
 .PHONY: default all base modules install load clean
diff -urN refpolicy-old/Rules.monolithic refpolicy-new/Rules.monolithic
--- refpolicy-old/Rules.monolithic	2006-02-01 08:22:14.000000000 -0500
+++ refpolicy-new/Rules.monolithic	2006-02-10 15:44:35.000000000 -0500
@@ -8,6 +8,7 @@
 LOADPATH = $(POLICYPATH)/$(POLVER)
 HOMEDIRPATH = $(CONTEXTPATH)/files/homedir_template
 
+POLICY_CONF := policy.conf
 FC := file_contexts
 POLVER := policy.$(PV)
 
@@ -23,14 +24,14 @@
 PRE_TE_FILES := $(SECCLASS) $(ISIDS) $(AVS) $(M4SUPPORT) $(POLDIR)/mls $(POLDIR)/mcs
 POST_TE_FILES := $(USER_FILES) $(POLDIR)/constraints
 
-POLICY_SECTIONS := tmp/pre_te_files.conf tmp/generated_definitions.conf tmp/all_interfaces.conf tmp/all_attrs_types.conf $(GLOBALBOOL) $(GLOBALTUN) tmp/only_te_rules.conf tmp/all_post.conf
+POLICY_SECTIONS := $(TMPDIR)/pre_te_files.conf $(TMPDIR)/generated_definitions.conf $(TMPDIR)/all_interfaces.conf $(TMPDIR)/all_attrs_types.conf $(GLOBALBOOL) $(GLOBALTUN) $(TMPDIR)/only_te_rules.conf $(TMPDIR)/all_post.conf
 
 HOMEDIR_TEMPLATE = homedir_template
 
 # search layer dirs for source files
-vpath %.te $(ALL_LAYERS)
-vpath %.if $(ALL_LAYERS)
-vpath %.fc $(ALL_LAYERS)
+vpath %.te $(ALL_LAYERS) $(LOCAL_LAYERS)
+vpath %.if $(ALL_LAYERS) $(LOCAL_LAYERS)
+vpath %.fc $(ALL_LAYERS) $(LOCAL_LAYERS)
 
 ########################################
 #
@@ -42,7 +43,7 @@
 
 install: $(LOADPATH) $(FCPATH) $(APPFILES) $(USERPATH)/local.users
 
-load: tmp/load
+load: $(TMPDIR)/load
 
 checklabels: $(FCPATH)
 restorelabels: $(FCPATH)
@@ -53,20 +54,20 @@
 #
 # Build a binary policy locally
 #
-$(POLVER): policy.conf
+$(POLVER): $(POLICY_CONF)
 	@echo "Compiling $(NAME) $(POLVER)"
 ifneq ($(PV),$(KV))
 	@echo
 	@echo "WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?"
 	@echo
 endif
-	$(verbose) $(CHECKPOLICY) $^ -o $@
+	$(verbose) $(CHECKPOLICY) $(BUILDDIR)/$^ -o $(BUILDDIR)/$@
 
 ########################################
 #
 # Install a binary policy
 #
-$(LOADPATH): policy.conf
+$(LOADPATH): $(POLICY_CONF)
 	@mkdir -p $(POLICYPATH)
 	@echo "Compiling and installing $(NAME) $(LOADPATH)"
 ifneq ($(PV),$(KV))
@@ -74,38 +75,40 @@
 	@echo "WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?"
 	@echo
 endif
-	$(verbose) $(CHECKPOLICY) $^ -o $@
+	$(verbose) $(CHECKPOLICY) $(BUILDDIR)/$^ -o $(BUILDDIR)/$@
 
 ########################################
 #
 # Load the binary policy
 #
-reload tmp/load: $(LOADPATH) $(FCPATH) $(APPFILES)
+reload $(TMPDIR)/load: $(LOADPATH) $(FCPATH) $(APPFILES)
 	@echo "Loading $(NAME) $(LOADPATH)"
 	$(verbose) $(LOADPOLICY) -q $(LOADPATH)
-	@touch tmp/load
+	@touch $(TMPDIR)/load
 
 ########################################
 #
 # Construct a monolithic policy.conf
 #
-policy.conf: $(POLICY_SECTIONS)
-	@echo "Creating $(NAME) policy.conf"
+$(POLICY_CONF): $(POLICY_SECTIONS)
+	@echo "Creating $(NAME) $(POLICY_CONF)"
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
+	@test -d $(BUILDDIR) || mkdir -p $(BUILDDIR)
 # checkpolicy can use the #line directives provided by -s for error reporting:
-	$(verbose) m4 -D self_contained_policy $(M4PARAM) -s $^ > tmp/$@.tmp
-	$(verbose) sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < tmp/$@.tmp > $@
+	$(verbose) m4 -D self_contained_policy $(M4PARAM) -s $^ > $(TMPDIR)/$(POLICY_CONF).tmp
+	$(verbose) sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < $(TMPDIR)/$(POLICY_CONF).tmp > $(BUILDDIR)/$@
 # the ordering of these ocontexts matters:
-	$(verbose) grep ^portcon tmp/$@.tmp >> $@ || true
-	$(verbose) grep ^netifcon tmp/$@.tmp >> $@ || true
-	$(verbose) grep ^nodecon tmp/$@.tmp >> $@ || true
+	$(verbose) grep ^portcon $(TMPDIR)/$@.tmp >> $(BUILDDIR)/$@ || true
+	$(verbose) grep ^netifcon $(TMPDIR)/$@.tmp >> $(BUILDDIR)/$@ || true
+	$(verbose) grep ^nodecon $(TMPDIR)/$@.tmp >> $(BUILDDIR)/$@ || true
 
-tmp/pre_te_files.conf: $(PRE_TE_FILES)
-	@test -d tmp || mkdir -p tmp
+$(TMPDIR)/pre_te_files.conf: $(PRE_TE_FILES)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 
-tmp/generated_definitions.conf: $(ALL_TE_FILES)
+$(TMPDIR)/generated_definitions.conf: $(ALL_LAYERS) $(ALL_TE_FILES)
 # per-userdomain templates:
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) echo "define(\`base_per_userdomain_template',\`" > $@
 	$(verbose) for i in $(patsubst %.te,%,$(notdir $(ALL_MODULES))); do \
 		echo "ifdef(\`""$$i""_per_userdomain_template',\`""$$i""_per_userdomain_template("'$$*'")')" \
@@ -118,76 +121,76 @@
 	done
 	$(verbose) $(SETTUN) $(BOOLEANS) >> $@
 
-tmp/all_interfaces.conf: $(M4SUPPORT) $(ALL_INTERFACES)
+$(TMPDIR)/all_interfaces.conf: $(M4SUPPORT) $(ALL_INTERFACES)
 ifeq ($(ALL_INTERFACES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) m4 $^ | sed -e s/dollarsstar/\$$\*/g > $@
 
-tmp/all_te_files.conf: $(ALL_TE_FILES)
+$(TMPDIR)/all_te_files.conf: $(ALL_TE_FILES)
 ifeq ($(ALL_TE_FILES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 	$(call parse-rolemap,base,$@)
 
-tmp/post_te_files.conf: $(POST_TE_FILES)
-	@test -d tmp || mkdir -p tmp
+$(TMPDIR)/post_te_files.conf: $(POST_TE_FILES)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) cat $^ > $@
 
 # extract attributes and put them first. extract post te stuff
 # like genfscon and put last.  portcon, nodecon, and netifcon
 # is delayed since they are generated by m4
-tmp/all_attrs_types.conf tmp/only_te_rules.conf tmp/all_post.conf: tmp/all_te_files.conf tmp/post_te_files.conf
-	$(verbose) grep ^attribute tmp/all_te_files.conf > tmp/all_attrs_types.conf || true
-	$(verbose) grep '^type ' tmp/all_te_files.conf >> tmp/all_attrs_types.conf
-	$(verbose) cat tmp/post_te_files.conf > tmp/all_post.conf
-	$(verbose) grep '^sid ' tmp/all_te_files.conf >> tmp/all_post.conf || true
-	$(verbose) egrep '^fs_use_(xattr|task|trans)' tmp/all_te_files.conf >> tmp/all_post.conf || true
-	$(verbose) grep ^genfscon tmp/all_te_files.conf >> tmp/all_post.conf || true
+$(TMPDIR)/all_attrs_types.conf $(TMPDIR)/only_te_rules.conf $(TMPDIR)/all_post.conf: $(TMPDIR)/all_te_files.conf $(TMPDIR)/post_te_files.conf
+	$(verbose) grep ^attribute $(TMPDIR)/all_te_files.conf > $(TMPDIR)/all_attrs_types.conf || true
+	$(verbose) grep '^type ' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_attrs_types.conf
+	$(verbose) cat $(TMPDIR)/post_te_files.conf > $(TMPDIR)/all_post.conf
+	$(verbose) grep '^sid ' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
+	$(verbose) egrep '^fs_use_(xattr|task|trans)' $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
+	$(verbose) grep ^genfscon $(TMPDIR)/all_te_files.conf >> $(TMPDIR)/all_post.conf || true
 	$(verbose) sed -r -e /^attribute/d -e '/^type /d' -e /^genfscon/d \
 			-e '/^sid /d' -e '/^fs_use_(xattr|task|trans)/d' \
-			< tmp/all_te_files.conf > tmp/only_te_rules.conf
+			< $(TMPDIR)/all_te_files.conf > $(TMPDIR)/only_te_rules.conf
 
 ########################################
 #
 # Remove the dontaudit rules from the policy.conf
 #
-enableaudit: policy.conf
-	@test -d tmp || mkdir -p tmp
-	@echo "Removing dontaudit rules from policy.conf"
-	$(verbose) grep -v dontaudit policy.conf > tmp/policy.audit
-	$(verbose) mv tmp/policy.audit policy.conf
+enableaudit: $(BUILDDIR)/$(POLICY_CONF)
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
+	@echo "Removing dontaudit rules from $(POLICY_CONF)"
+	$(verbose) grep -v dontaudit @^ > $(TMPDIR)/policy.audit
+	$(verbose) mv $(TMPDIR)/policy.audit $^
 
 ########################################
 #
 # Construct file_contexts
 #
-$(FC): tmp/$(FC).tmp $(FCSORT)
+$(BUILDDIR)/$(FC): $(TMPDIR)/$(FC).tmp $(FCSORT)
 	$(verbose) $(FCSORT) $< $@
 	$(verbose) grep -e HOME -e ROLE $@ > $(HOMEDIR_TEMPLATE)
 	$(verbose) sed -i -e /HOME/d -e /ROLE/d $@
 
-tmp/$(FC).tmp: $(M4SUPPORT) tmp/generated_definitions.conf $(ALL_FC_FILES)
+$(TMPDIR)/$(FC).tmp: $(M4SUPPORT) $(TMPDIR)/generated_definitions.conf $(ALL_FC_FILES)
 ifeq ($(ALL_FC_FILES),)
 	$(error No enabled modules! $(notdir $(MOD_CONF)) may need to be generated by using "make conf")
 endif
 	@echo "Creating $(NAME) file_contexts."
-	@test -d tmp || mkdir -p tmp
+	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	$(verbose) m4 $(M4PARAM) $^ > $@
 
 ########################################
 #
 # Install file_contexts
 #
-$(FCPATH): $(FC) $(LOADPATH) $(USERPATH)/system.users
+$(FCPATH): $(BUILDDIR)/$(FC) $(LOADPATH) $(USERPATH)/system.users
 	@echo "Validating $(NAME) file_contexts."
-	$(verbose) $(SETFILES) -q -c $(LOADPATH) $(FC)
+	$(verbose) $(SETFILES) -q -c $(LOADPATH) $(BUILDDIR)/$(FC)
 	@echo "Installing file_contexts."
 	@mkdir -p $(CONTEXTPATH)/files
-	$(verbose) install -m 644 $(FC) $(FCPATH)
+	$(verbose) install -m 644 $(BUILDDIR)/$(FC) $(FCPATH)
 	$(verbose) install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
 	$(verbose) $(GENHOMEDIRCON) -d $(TOPDIR) -t $(NAME) $(USEPWD)
 
@@ -195,11 +198,11 @@
 #
 # Run policy source checks
 #
-check: policy.conf $(FC)
-	$(SECHECK) -s --profile=development --policy=policy.conf --fcfile=$(FC) > $@.res
+check: $(BUILDDIR)/$(POLICY_CONF) $(BUILDDIR)/$(FC)
+	$(SECHECK) -s --profile=development --policy=$(BUILDDIR)/$(POLICY_CONF) --fcfile=$(BUILDDIR)/$(FC) > $(BUILDDIR)/$@.res
 
-longcheck: policy.conf $(FC)
-	$(SECHECK) -s --profile=all --policy=policy.conf --fcfile=$(FC) > $@.res
+longcheck: $(BUILDDIR)/$(POLICY_CONF) $(BUILDDIR)/$(FC)
+	$(SECHECK) -s --profile=all --policy=$(BUILDDIR)/$(POLICY_CONF) --fcfile=$(BUILDDIR)/$(FC) > $(BUILDDIR)/$@.res
 
 ########################################
 #
@@ -215,11 +218,11 @@
 # Clean the sources
 #
 clean:
-	rm -f policy.conf
-	rm -f policy.$(PV)
-	rm -f $(FC)
+	rm -f $(BUILDDIR)/$(POLICY_CONF)
+	rm -f $(BUILDDIR)/policy.$(PV)
+	rm -f $(BUILDDIR)/$(FC)
 	rm -f $(HOMEDIR_TEMPLATE)
 	rm -f *.res
-	rm -fR tmp
+	rm -fR $(TMPDIR)
 
 .PHONY: default policy install load reload enableaudit checklabels restorelabels relabel check longcheck clean

--Boundary-00=_WXQ7DkmZg+Adumq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
