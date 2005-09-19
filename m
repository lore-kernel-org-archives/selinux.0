Subject: Re: State of Debian SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <20050917233111.GA17916@vnl.com>
References: <20050917233111.GA17916@vnl.com>
Content-Type: multipart/mixed; boundary="=-aR8L+qTyTSY1nzyAEExv"
Date: Mon, 19 Sep 2005 08:27:50 -0400
Message-Id: <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aR8L+qTyTSY1nzyAEExv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-09-18 at 00:31 +0100, Dale Amon wrote:
> I've set aside the next week to come back to SELinux
> and evaluate if it's reached the point where I could
> recommmend it for customer sites.
> 
> So far Debian SELinux is looking pretty grim, and I'd
> like feedback on whether there really is a straight
> forward path to install it. By that I mean one with
> out a lot of kludges and pain as in the long 
> (and already obsolete) description of the Debian 
> install in McCarty's O'Reilly book.
> 
> I'm starting from a freshly burned Debian stable 
> install iso. I do a bog standard install up to
> the point where the reboot brings you into aptitude.
> I've tried both forks at that point; updating first
> in sarge or cancelling. 
> 
> I change the sources.list to sid and add Russell's
> newselinux package line; then I update and
> after selecting all the appropriate packages (and
> the 2.6.12 kernel) I upgrade.
> 
> Problems: One, I have to deselect cups in the 
> policy default because it has an error that causes
> the install to fail.
> 
> But even without it no go. I assumed I had to
> reboot to get the selinuxfs, so I did that. But
> the boot complains about it and a manual mount /selinuxfs
> claims the kernel doesn't know what it is.
> 
> I checked the config; looks like everything associated
> with selinux (and with xattr's on various file systems)
> is selected.

First, I'm not sure why you need to reboot to finish compiling the
policy, as the kernel has nothing to do with the policy build.

If selinuxfs isn't listed in /proc/filesystems, then SELinux is disabled
in your kernel, either via the compile-time options or via the boot time
parameter (which in Debian and SuSE defaults to selinux=0; you have to
explicitly use selinux=1 to enable it).  Fedora defaults to enabled.

> The package will still not finish installing. The
> error is:
> 
>  /usr/bin/checkpolicy: loading policy configuration from policy.conf
>  libsepol.expand_abtab_insert: Type conflict!
>  Out of memory - unable to check assertions.
>  Check assertions failed.

Hmmm...can you send me (just me, not the entire list) that policy.conf?
Or apply the attached patch to your libsepol, rebuild it, rebuild
checkpolicy against it (it uses the static lib), and try again?

> I could fiddle a lot more, but that would be counter
> productive: this time around I'm looking for a
> reliable and straightforward install, not just
> a bit of play time hacking.
> 
> Is there an up to date description of the Debian 
> install? McCarty's book is *way* out of date; I
> could not find a current install procedure on
> Russell's site, although such might be buried in
> one of his many find tutorials.
> 
> Is there a current canonical 1-2-3 procedure for
> going from the current debian iso to a fully
> installed SELinux system? I don't mind if I have
> to fiddle with policy afterwards, but I do want
> the comfort of knowing I've got a reliable means
> of installing and updating (or talking a customer
> through it) if I am to consider using it for real.
> 
> Of course the fact that sid seems to be required
> is a *huge* negative to start with...

I think that most of your questions can only be answered by Russell
and/or Manoj, as they seem to be maintaining SELinux for Debian.

-- 
Stephen Smalley
National Security Agency

--=-aR8L+qTyTSY1nzyAEExv
Content-Disposition: attachment; filename=libsepol-1.9.1.patch
Content-Type: text/x-patch; name=libsepol-1.9.1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsepol/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/ChangeLog,v
retrieving revision 1.59
retrieving revision 1.60
diff -u -p -r1.59 -r1.60
--- libsepol/ChangeLog	6 Sep 2005 17:52:49 -0000	1.59
+++ libsepol/ChangeLog	9 Sep 2005 14:32:32 -0000	1.60
@@ -1,3 +1,7 @@
+1.9.1 2005-09-09
+	* Fixed expand_avtab and expand_cond_av_list to keep separate
+	entries with identical keys but different enabled flags.
+
 1.8 2005-09-06
 	* Updated version for release.
 
Index: libsepol/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/VERSION,v
retrieving revision 1.54
retrieving revision 1.55
diff -u -p -r1.54 -r1.55
--- libsepol/VERSION	6 Sep 2005 17:52:49 -0000	1.54
+++ libsepol/VERSION	9 Sep 2005 14:32:32 -0000	1.55
@@ -1 +1 @@
-1.8
+1.9.1
Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.10
retrieving revision 1.11
diff -u -p -r1.10 -r1.11
--- libsepol/src/expand.c	23 Aug 2005 13:05:18 -0000	1.10
+++ libsepol/src/expand.c	9 Sep 2005 14:32:35 -0000	1.11
@@ -1916,17 +1916,29 @@ int expand_module(policydb_t *base, poli
 
 static int expand_avtab_insert(avtab_t *a, avtab_key_t *k, avtab_datum_t *d)
 {
+	avtab_ptr_t node;
 	avtab_datum_t *avd;
 	int rc;
-
-	avd = avtab_search(a, k);
-	if (!avd) {
+	
+	node = avtab_search_node(a, k);
+	if (!node) {
 		rc = avtab_insert(a, k, d);
 		if (rc)
 			DEBUG(__FUNCTION__, "Out of memory!\n");
 		return rc;
 	}
-	
+
+	if ((k->specified & AVTAB_ENABLED) != 
+	    (node->key.specified & AVTAB_ENABLED)) {
+		node = avtab_insert_nonunique(a, k, d);
+		if (!node) {
+			DEBUG(__FUNCTION__, "Out of memory!\n");
+			return -1;
+		}
+		return 0;
+	}
+
+	avd = &node->datum;
 	switch (k->specified & ~AVTAB_ENABLED) {
 	case AVTAB_ALLOWED:
 	case AVTAB_AUDITALLOW:
@@ -2035,7 +2047,8 @@ static int expand_cond_insert(cond_av_li
 	cond_av_list_t *nl;
 
 	node = avtab_search_node(expa, k);
-	if (!node) {
+	if (!node ||
+	    (k->specified & AVTAB_ENABLED) != (node->key.specified & AVTAB_ENABLED)) {
 		node = avtab_insert_nonunique(expa, k, d);
 		if (!node) {
 			DEBUG(__FUNCTION__, "Out of memory!\n");

--=-aR8L+qTyTSY1nzyAEExv--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
