Subject: Re: More Debian bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1127506232.27851.100.camel@moss-spartans.epoch.ncsc.mil>
References: <20050923195227.GA21546@vnl.com>
	 <1127506232.27851.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-l1r+XMUOTFOi67N6mI+w"
Date: Fri, 23 Sep 2005 16:24:42 -0400
Message-Id: <1127507082.27851.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-l1r+XMUOTFOi67N6mI+w
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-09-23 at 16:10 -0400, Stephen Smalley wrote:
> You can change it to build policy.19 by adding the -c 19 option to
> checkpolicy.  Attached policy Makefile diff from upstream CVS causes it
> to build both versions and load the right one.

Might help if I actually attached that diff.  But note that you can just
modify your Makefile manually if you like to insert the -c 19 option to
checkpolicy when it is invoked.  This diff includes some other unrelated
changes.

-- 
Stephen Smalley
National Security Agency

--=-l1r+XMUOTFOi67N6mI+w
Content-Disposition: attachment; filename=policy-Makefile.diff
Content-Type: text/x-patch; name=policy-Makefile.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policy/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/Makefile,v
retrieving revision 1.81
retrieving revision 1.82
diff -u -p -r1.81 -r1.82
--- policy/Makefile	5 Jul 2005 19:30:10 -0000	1.81
+++ policy/Makefile	15 Sep 2005 08:14:12 -0000	1.82
@@ -15,6 +15,9 @@
 # Set to y if MLS is enabled in the policy.
 MLS=n
 
+# Set to y if MCS is enabled in the policy
+MCS=n
+
 FLASKDIR = flask/
 PREFIX = /usr
 BINDIR = $(PREFIX)/bin
@@ -24,14 +27,18 @@ CHECKPOLICY = $(BINDIR)/checkpolicy
 GENHOMEDIRCON = $(SBINDIR)/genhomedircon
 SETFILES = $(SBINDIR)/setfiles
 VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
+PREVERS := 19
 KERNVERS := $(shell cat /selinux/policyvers)
 POLICYVER := policy.$(VERS)
 TOPDIR = $(DESTDIR)/etc/selinux
+TYPE=strict
 ifeq ($(MLS),y)
 TYPE=mls
-else
-TYPE=strict
 endif
+ifeq ($(MCS),y)
+TYPE=mcs
+endif
+
 INSTALLDIR = $(TOPDIR)/$(TYPE)
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
@@ -54,6 +61,10 @@ ifeq ($(MLS),y)
 POLICYFILES += mls
 CHECKPOLMLS += -M
 endif
+ifeq ($(MCS), y)
+POLICYFILES += mcs
+CHECKPOLMLS += -M
+endif
 DEFCONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
@@ -148,8 +159,10 @@ $(LOADPATH): policy.conf $(CHECKPOLICY) 
 	@echo "Compiling policy ..."
 	@mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
-ifneq ($(MLS),y)
+ifneq ($(VERS),$(PREVERS))
+	$(CHECKPOLICY) -c $(PREVERS) -o $(POLICYPATH)/policy.$(PREVERS) policy.conf
 endif
+
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
 
@@ -162,7 +175,11 @@ $(POLICYVER):  policy.conf $(FC) $(CHECK
 
 reload tmp/load: $(LOADPATH) 
 	@echo "Loading Policy ..."
+ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
+else
+	$(LOADPOLICY) $(POLICYPATH)/policy.$(PREVERS)
+endif
 	touch tmp/load
 
 load: tmp/load $(FCPATH) 
@@ -328,3 +345,22 @@ mlsconvert: 
 	@sed "s/MLS=n/MLS=y/" Makefile > Makefile.new
 	@mv Makefile.new Makefile
 	@echo "Done"
+
+mcsconvert: 
+	@for file in $(CONTEXTFILES); do \
+		echo "Converting $$file"; \
+		sed -e 's/_t\b/_t:s0/g' $$file > $$file.new && \
+		mv $$file.new $$file; \
+	done
+	@for file in $(USER_FILES); do \
+		echo "Converting $$file"; \
+		sed -r -e 's/\;/ level s0 range s0;/' $$file | \
+		sed -r -e 's/(user (root|system_u).*);/\1 - s0:c0.c127;/' > $$file.new; \
+		mv $$file.new $$file; \
+	done
+	@sed -e '/sid kernel/s/s0/s0 - s0:c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@echo "Enabling MCS in the Makefile"
+	@sed "s/MCS=y/MCS=y/" Makefile > Makefile.new
+	@mv Makefile.new Makefile
+	@echo "Done"
+

--=-l1r+XMUOTFOi67N6mI+w--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
