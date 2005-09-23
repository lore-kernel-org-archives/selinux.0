Subject: Re: State of Debian SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: sswami@eden.rutgers.edu
Cc: Russell Coker <russell@coker.com.au>,
   Manoj Srivastava <manoj.srivastava@stdc.com>, Dale Amon <amon@vnl.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <2511.172.18.148.164.1127501625.squirrel@webmail.eden.rutgers.edu>
References: <20050917233111.GA17916@vnl.com>
	 <20050918001512.GR9092@lkcl.net> <20050918095806.GC25649@vnl.com>
	 <20050918104219.GW9092@lkcl.net> <20050918215841.GA7480@vnl.com>
	 <2511.172.18.148.164.1127501625.squirrel@webmail.eden.rutgers.edu>
Content-Type: multipart/mixed; boundary="=-zpZ3yP7Ese7jpEKBDEtC"
Date: Fri, 23 Sep 2005 16:02:32 -0400
Message-Id: <1127505752.27851.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zpZ3yP7Ese7jpEKBDEtC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-09-23 at 14:53 -0400, sswami@eden.rutgers.edu wrote:
> I was trying to install SELinux using the 2.6 kernel. I have been using
> relevant packages from the coker site. When I do "make policy", I get the
> following error message:
> 
> 
>  	/usr/bin/checkpolicy: loading policy configuration from policy.conf
>  	libsepol.expand_avtab_insert: Type conflict!
>  	Out of memory - unable to check assertions.
>  	Check assertions failed.
> 
> Can anyone please let me know what I should do to get rid of this?

There are a couple of issues here, as discussed previously in this
thread:
1) There is a bug in libsepol, fixed in libsepol 1.9.1 upstream.  Patch
attached for your convenience.  Requires rebuilding checkpolicy against
the updated libsepol as checkpolicy uses the static libsepol.
2) There is a bug in policy, fixed in policy 1.27.1 upstream.  I'll
attach the specific diff that went into the upstream policy, but Dale
reported that he had to manually apply the change because it didn't
apply cleanly against the Debian policy.  It is simply a matter of
adding the etc_writer attribute to the kernel_t type declaration
unconditionally (i.e. without the surrounding ifdef).

I think that Debian libsepol is being maintained by Manoj, and Debian
policy is being maintained by Russell.  cc'd.  

However, note that Dale has reported other issues with Debian policy as
well; see his postings for his workarounds so far.

-- 
Stephen Smalley
National Security Agency

--=-zpZ3yP7Ese7jpEKBDEtC
Content-Disposition: attachment; filename=libsepol-1.9.1.diff
Content-Type: text/x-patch; name=libsepol-1.9.1.diff; charset=UTF-8
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

--=-zpZ3yP7Ese7jpEKBDEtC
Content-Disposition: attachment; filename=policy-kernel.diff
Content-Type: text/x-patch; name=policy-kernel.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/domains/misc/kernel.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/misc/kernel.te,v
retrieving revision 1.13
retrieving revision 1.14
diff -u -r1.13 -r1.14
--- policy/domains/misc/kernel.te	5 Jul 2005 19:30:10 -0000	1.13
+++ policy/domains/misc/kernel.te	15 Sep 2005 08:14:12 -0000	1.14
@@ -11,7 +11,7 @@
 # kernel_t is the domain of kernel threads.
 # It is also the target type when checking permissions in the system class.
 # 
-type kernel_t, domain, privmodule, privlog, sysctl_kernel_writer, mlsprocread, mlsprocwrite, privsysmod ifdef(`nfs_export_all_rw',`,etc_writer'), privrangetrans ;
+type kernel_t, domain, privmodule, privlog, sysctl_kernel_writer, mlsprocread, mlsprocwrite, privsysmod, etc_writer, privrangetrans ;
 role system_r types kernel_t;
 general_domain_access(kernel_t)
 general_proc_read_access(kernel_t)

--=-zpZ3yP7Ese7jpEKBDEtC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
