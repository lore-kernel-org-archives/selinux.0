Date: Wed, 21 Dec 2005 16:47:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
Subject: [patch] sereference: permit reiserfs
Message-ID: <20051221224720.GA6885@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oops, I forgot about this one...

Is there still a good reason to not support labeling reiserfs?  If not,
the following trivial patch was needed for me to 'make relabel' out of
the reference policy.

thanks,
-serge

Index: refpolicy/Rules.monolithic
===================================================================
--- refpolicy.orig/Rules.monolithic
+++ refpolicy/Rules.monolithic
@@ -190,10 +190,10 @@ $(FCPATH): $(FC) $(LOADPATH) $(USERPATH)
 #
 # Filesystem labeling
 #
-FILESYSTEMS := `mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs| jfs).*rw/{print $$3}';`
+FILESYSTEMS := `mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs| jfs| reiserfs).*rw/{print $$3}';`
 
 checklabels: $(FCPATH) $(SETFILES)
-	@echo "Checking labels on filesystem types: ext2 ext3 xfs jfs"
+	@echo "Checking labels on filesystem types: ext2 ext3 xfs jfs reiser"
 	@if test -z "$(FILESYSTEMS)"; then \
 		echo "No filesystems with extended attributes found!" ;\
 		false ;\
@@ -201,7 +201,7 @@ checklabels: $(FCPATH) $(SETFILES)
 	$(QUIET) $(SETFILES) -v -n $(FCPATH) $(FILESYSTEMS)
 
 restorelabels: $(FCPATH) $(SETFILES)
-	@echo "Restoring labels on filesystem types: ext2 ext3 xfs jfs"
+	@echo "Restoring labels on filesystem types: ext2 ext3 xfs jfs reiser"
 	@if test -z "$(FILESYSTEMS)"; then \
 		echo "No filesystems with extended attributes found!" ;\
 		false ;\
@@ -209,7 +209,7 @@ restorelabels: $(FCPATH) $(SETFILES)
 	$(QUIET) $(SETFILES) -v $(FCPATH) $(FILESYSTEMS)
 
 relabel:  $(FCPATH) $(SETFILES)
-	@echo "Relabeling filesystem types: ext2 ext3 xfs jfs"
+	@echo "Relabeling filesystem types: ext2 ext3 xfs jfs reiser"
 	@if test -z "$(FILESYSTEMS)"; then \
 		echo "No filesystems with extended attributes found!" ;\
 		false ;\

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
