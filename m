Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l33KixFo012411
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 16:44:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l33KiwPe015316
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 20:44:58 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] refpolicy: include LOCAL_ROOT modules in make conf
Date: Tue, 3 Apr 2007 16:44:58 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158805269C@exchange.columbia.tresys.com>
From: "James Athey" <jathey@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes two problems:

1. When a LOCAL_ROOT is specified, make conf includes layers found in both the main tree and the LOCAL_ROOT twice in modules.conf.

2. make conf did not actually include generated XML from modules in the LOCAL_ROOT in the layer XMLs, and therefore they would not appear in modules.conf.

Index: Makefile
===================================================================
--- Makefile	(revision 2253)
+++ Makefile	(working copy)
@@ -113,17 +113,16 @@
 docfiles = $(docs)/Makefile.example $(addprefix $(docs)/,example.te example.if example.fc)
 
 ifndef LOCAL_ROOT
-polxml = $(docs)/policy.xml
-tunxml = $(docs)/global_tunables.xml
-boolxml = $(docs)/global_booleans.xml
-htmldir = $(docs)/html
+xmls = $(docs)
 else
-polxml = $(LOCAL_ROOT)/doc/policy.xml
-tunxml = $(LOCAL_ROOT)/doc/global_tunables.xml
-boolxml = $(LOCAL_ROOT)/doc/global_booleans.xml
-htmldir = $(LOCAL_ROOT)/doc/html
+xmls = $(LOCAL_ROOT)/doc
 endif
 
+polxml = $(xmls)/policy.xml
+tunxml = $(xmls)/global_tunables.xml
+boolxml = $(xmls)/global_booleans.xml
+htmldir = $(xmls)/html
+
 # config file paths
 globaltun = $(poldir)/global_tunables
 globalbool = $(poldir)/global_booleans
@@ -255,7 +254,7 @@
 detected_mods := $(sort $(foreach dir,$(all_layers),$(wildcard $(dir)/*.te)) $(generated_te))
 
 modxml := $(detected_mods:.te=.xml)
-layerxml := $(addprefix $(tmpdir)/, $(notdir $(addsuffix .xml,$(all_layers))))
+layerxml := $(sort $(addprefix $(tmpdir)/, $(notdir $(addsuffix .xml,$(all_layers)))))
 all_metaxml := $(addsuffix /$(metaxml), $(all_layers))
 
 # modules.conf setting for base module
@@ -419,7 +418,11 @@
 	@test -d $(tmpdir) || mkdir -p $(tmpdir)
 	$(verbose) echo '<layer name="$(*F)">' > $@
 	$(verbose) cat $(addprefix $(moddir)/, $(notdir $*))/$(metaxml) >> $@
+ifndef LOCAL_ROOT
 	$(verbose) cat $(filter-out $(addprefix $(moddir)/, $(notdir $*))/$(metaxml), $(filter $(addprefix $(moddir)/, $(notdir $*))/%, $(modxml))) >> $@
+else
+	$(verbose) cat $(filter-out $(addprefix $(moddir)/, $(notdir $*))/$(metaxml), $(filter $(addprefix $(moddir)/, $(notdir $*))/%, $(modxml))) $(filter-out $(addprefix $(local_moddir)/, $(notdir $*))/$(metaxml), $(filter $(addprefix $(local_moddir)/, $(notdir $*))/%, $(modxml))) >> $@
+endif
 	$(verbose) echo '</layer>' >> $@
 
 $(tunxml): $(globaltun)
@@ -548,6 +551,9 @@
 			$(moddir)/$$i/*.xml \
 			$(headerdir)/$$i ;\
 	done
+
+	$(verbose) install -m 644 $(moddir)/kernel/corenetwork.te.in $(headerdir)/kernel
+
 	$(verbose) echo "TYPE ?= $(TYPE)" > $(headerdir)/build.conf
 	$(verbose) echo "NAME ?= $(NAME)" >> $(headerdir)/build.conf
 ifneq "$(DISTRO)" ""


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
