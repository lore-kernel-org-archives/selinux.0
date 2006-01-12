Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CJMcXf013511
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:22:38 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CJMaDu004120
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 19:22:36 GMT
From: Spencer Shimko <sshimko@tresys.com>
To: "SELinux" <selinux@tycho.nsa.gov>
Subject: [PATCH] sereference: Makefile changes
Date: Thu, 12 Jan 2006 14:23:31 -0500
Cc: "PeBenito, Christopher" <cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zyqxD+UP/Wns1YI"
Message-Id: <200601121423.31372.sshimko@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_zyqxD+UP/Wns1YI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes it possible to change the on-off-module state of 
policy from the command line at build time.  Rather then maintaining 
separate modules.conf for various similar builds, one can maintain a 
common modules.conf and tweak it when running make.

For example:
$make clean
$APPS_OFF="gpg" make

This will generate a policy without the gpg module.  The options are 
APPS_OFF, APPS_ON, and APPS_MODS.

Thanks,
Spencer
-- 
Spencer Shimko
Tresys Technology, LLC
(410) 290 - 1411 ext. 125
sshimko@tresys.com

--Boundary-00=_zyqxD+UP/Wns1YI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="refpol-make.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="refpol-make.diff"

diff -urN refpolicy-old/Makefile refpolicy-new/Makefile
--- refpolicy-old/Makefile	2006-01-12 11:07:59.000000000 -0500
+++ refpolicy-new/Makefile	2006-01-12 14:10:03.000000000 -0500
@@ -165,9 +165,17 @@
 # modules.conf setting for unused module
 MODUNUSED := off
 
+# test for additional module configuration information from command line and check for confusing input
+MOD_TEST = $(foreach var, $(APPS_OFF), $(findstring $(var), $(APPS_ON) $(APPS_MODS)))
+MOD_TEST += $(foreach var, $(APPS_MODS), $(findstring $(var), $(APPS_ON)))
+ifneq ($(strip $(MOD_TEST)),)
+        $(error Applications must be on, module, or off, and not in more than one list! $(strip $(MOD_TEST)) found in multiple lists!)
+endif
+
 # extract settings from modules.conf
-BASE_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null))
-MOD_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null))
+# strip out all additional module configuration information from command line, then add back in to avoid dupes
+BASE_MODS := $(strip $(filter-out $(strip $(APPS_OFF) $(APPS_MODS) $(APPS_ON)), $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null)))) $(addsuffix .te,$(APPS_ON))
+MOD_MODS := $(strip $(addsuffix .te, $(filter-out $(strip $(APPS_OFF) $(APPS_MODS) $(APPS_ON)), $(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null)))) $(addsuffix .te,$(APPS_MODS))
 OFF_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODUNUSED)") print $$1 }' $(MOD_CONF) 2> /dev/null))
 
 ########################################

--Boundary-00=_zyqxD+UP/Wns1YI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
