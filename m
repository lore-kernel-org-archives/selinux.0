Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:06:32 -0400
Message-Id: <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 09:34 -0400, Stephen Smalley wrote:
> An obvious concern about the new msg_write function is that it requires
> memory allocation itself.  Thus, on a memory allocation failure in the
> caller, we might easily end up dropping the out of memory error message
> due to lack of available memory at this point.

More generally, I'm not sure why msg_write writes the formatted string
to a private buffer and passes the new msg type to the callback,
requiring the callback to call *_get methods, versus just having the
callback be a stdarg function that takes all of the arguments (plus
auxiliary data) directly.

Other comments:

diff -Naur --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libselinux --exclude policy_components.c old/libsemanage/src/direct_api.c exp/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-07 18:37:59.000000000 -0400
+++ exp/libsemanage/src/direct_api.c	2005-10-11 02:34:29.000000000 -0400
@@ -268,11 +268,23 @@
 		goto cleanup;
 	}
 
-	/* expand and verify the resulting policy */
-	if (semanage_expand_sandbox(sh, base) < 0 ||
-	    semanage_verify_kernel(sh) != 0) {
+	/* Expand the resulting policy */
+	if (semanage_expand_sandbox(sh, base) < 0)
+		goto cleanup;
+
+#if 0
+	/* Link components into base policy */
+	if (semanage_base_merge_components(sh, NULL /* FIXME */) < 0)
+		goto cleanup;
+
+	/* Commit changes to components */
+	if (semanage_commit_components(sh) < 0)
+		goto cleanup;
+#endif
+
+	/* Verify policy */
+	if (semanage_verify_kernel(sh) != 0)
 		goto cleanup;
-	}

Why wouldn't the above steps occur as part of semanage_expand_sandbox()?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
