Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11GOR53016376
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 11:24:27 -0500 (EST)
Subject: Re: [patch] enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1106330657.28551.146.camel@moss-spartans.epoch.ncsc.mil>
References: <41EC4682.8050807@trustedcs.com>
	 <41EC4743.1040803@trustedcs.com>
	 <1106329347.28551.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1106330657.28551.146.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-vslr0Sm/t20E7Q8h4Z0r"
Message-Id: <1107274677.26936.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 11:17:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vslr0Sm/t20E7Q8h4Z0r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-01-21 at 13:04, Stephen Smalley wrote:
> This patch relative to your userland patch makes the additional changes
> needed to at least compile a MLS policy (based on the strict policy), as
> described in my prior email.

As you may have noticed, my policy patch for MLS was almost immediately
broken by the next merge of contributed policy patches, as any change to
the file contexts will naturally conflict with the addition of the MLS
level fields.  Hence, to allow easy generation of an initial MLS-enabled
policy from the latest policy tree, I've created a mlsconvert target in
the policy Makefile as shown in the below patch.  Hence, a 'make
mlsconvert' will perform substitutions on the policy context
configuration files, the file context configuration files, and the users
files to initially set them up to include MLS fields.  Naturally,
further work is required for a useful MLS system, e.g. assigning MLS
attributes to domains that require privilege.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-vslr0Sm/t20E7Q8h4Z0r
Content-Disposition: attachment; filename=policy-Makefile-mls.diff
Content-Type: text/x-patch; name=policy-Makefile-mls.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/Makefile,v
retrieving revision 1.66
diff -u -r1.66 Makefile
--- policy/Makefile	27 Jan 2005 19:42:05 -0000	1.66
+++ policy/Makefile	1 Feb 2005 16:04:50 -0000
@@ -13,7 +13,7 @@
 #
 
 # Set to y if MLS is enabled in the policy.
-MLS=n
+MLS=y
 
 FLASKDIR = flask/
 PREFIX = /usr
@@ -25,7 +25,11 @@
 VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
 KERNVERS := $(shell cat /selinux/policyvers)
 POLICYVER := policy.$(VERS)
+ifeq ($(MLS),y)
+INSTALLDIR = $(DESTDIR)/etc/selinux/mls
+else
 INSTALLDIR = $(DESTDIR)/etc/selinux/strict
+endif
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
 USERPATH = $(INSTALLDIR)/users
@@ -48,15 +52,19 @@
 endif
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
-POLICYFILES += constraints initial_sid_contexts fs_use genfs_contexts net_contexts
+POLICYFILES += constraints
+POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
+CONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
-FCFILES=tmp/program_used_flags.te file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) file_contexts/distros.fc $(wildcard file_contexts/misc/*.fc)
+FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) file_contexts/distros.fc $(wildcard file_contexts/misc/*.fc)
+CONTEXTFILES += $(FCFILES)
 
 APPDIR=$(CONTEXTPATH)
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context dbus_contexts customizable_types) $(CONTEXTPATH)/files/media
+CONTEXTFILES += $(wildcard appconfig/*_context*) appconfig/media
 
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
@@ -129,8 +137,10 @@
 $(LOADPATH):  policy.conf $(CHECKPOLICY)
 	mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
+ifneq ($(MLS),y)
 ifneq ($(VERS),18)
-	$(CHECKPOLICY) $(CHECKPOLMLS) -c 18 -o $(POLICYPATH)/policy.18 policy.conf
+	$(CHECKPOLICY) -c 18 -o $(POLICYPATH)/policy.18 policy.conf
+endif
 endif
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
@@ -139,8 +149,10 @@
 
 $(POLICYVER):  policy.conf $(FC) $(CHECKPOLICY)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
+ifneq ($(MLS),y)
 ifneq ($(VERS),18)
-	$(CHECKPOLICY) $(CHECKPOLMLS) -c 18 -o policy.18 policy.conf
+	$(CHECKPOLICY) -c 18 -o policy.18 policy.conf
+endif
 endif
 	@echo "Validating file_contexts ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
@@ -194,9 +206,9 @@
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
 
-$(FC): $(FCFILES) $(ALL_TUNABLES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
+$(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
-	@m4 $(M4PARAM) $(ALL_TUNABLES) $(FCFILES) > $@.tmp
+	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
 	@grep -v "^/root" $@.tmp > $@.root
 	@/usr/sbin/genhomedircon . $@.root  > $@
 	@grep "^/root" $@.tmp >> $@
@@ -296,3 +308,17 @@
 	done
 
 .PHONY: clean $(PHONIES)
+
+mlsconvert: 
+	@for file in $(CONTEXTFILES); do \
+		echo "Converting $$file"; \
+		sed -e 's/_t\b/_t:s0/g' $$file > $$file.new && \
+		mv $$file.new $$file; \
+	done
+	@for file in $(USER_FILES); do \
+		echo "Converting $$file"; \
+		sed -e 's/;/ level s0 range s0 - s9 : c0 . c127;/' $$file > $$file.new && \
+		mv $$file.new $$file; \
+	done
+	@sed -e '/sid kernel/s/s0/s0 - s9 : c0 . c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@echo "Done"

--=-vslr0Sm/t20E7Q8h4Z0r--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
