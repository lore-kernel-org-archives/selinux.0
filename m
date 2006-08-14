Subject: Re: [PATCH 3/3] Separate local file contexts
	into	file_contexts.local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1155566313.28766.68.camel@moss-spartans.epoch.ncsc.mil>
References: <1155303269.8722.64.camel@sgc.columbia.tresys.com>
	 <1155329531.30078.121.camel@moss-spartans.epoch.ncsc.mil>
	 <44DDD5BE.6020402@tresys.com>
	 <1155566313.28766.68.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 15:06:23 -0400
Message-Id: <1155582383.28766.229.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-14 at 10:38 -0400, Stephen Smalley wrote:
> On Sat, 2006-08-12 at 09:21 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Fri, 2006-08-11 at 09:34 -0400, Christopher J. PeBenito wrote:
> > >> Semanage was looking at the main file contexts in some cases, since the
> > >> local file contexts were merged into the main file contexts.  This patch
> > >> fixes the code to look at the appropriate file context databases.
> > > 
> > > Thanks, merged, although I did make the libsemanage copy file error
> > > non-fatal (another patch has made several others non-fatal too).
> > > 
> > 
> > I never saw the other patch, did it not get sent to the list? I have 
> > some concerns about making those non-fatal, as I already told Karl. 
> > Leaving labeling files in an inconsistent state on policy update is an 
> > easy to way to break your system and with no automated reconciliation 
> > (eg., install the new policy, let it fix the permissions problems then 
> > reinstall it again automatically to make the labeling files consistent) 
> > I have serious doubts that the consistency will get fixed. Bailing on a 
> > policy update is probably better than killing the users network 
> > connection (for example) where they won't even be able to use the 
> > internet to find the solution.
> > 
> > Not to mention, anything being installed after the policy (in an rpm 
> > transaction) will be using the wrong file_contexts file for some amount 
> > of time before a user even could intervene and reinstall the policy to 
> > update the context files.
> > 
> > If these issues are fine with others (Karl indicated they were better 
> > than the alternative in his opinion) thats fine but I want them noted.
> > 
> > I honestly believe they'll create more problems than they will solve. It 
> > wasn't arbitrary that we made all those errors fatal, we had a system in 
> > place to be able to back out of a policy install when something that 
> > would leave the system in an inconsistent state happened.
> 
> Possibly, although both the netfilter_contexts and now the
> file_contexts.local changes have run into such errors in rawhide.  In
> fact, you need to get the kernel policy update into place to address the
> netfilter_contexts problem, so if the inability to install
> netfilter_contexts prevents you from completing the transaction, how do
> you make forward progress w/o going permissive?
> 
> I do agree that a partial write of any of the files should abort the
> transaction, so we should distinguish that case in the error handling.
> But if the source file is not present, that shouldn't be fatal.

Patch below restores the errors to being fatal, with exceptions being
granted for an ENOENT for file_contexts.local (optional), seusers (was
already non-fatal and optional), and netfilter_contexts (may not exist
in all policies, e.g. legacy ones and ones that are using compat_net=1).
Acceptable to all parties?

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.56
diff -u -p -r1.56 semanage_store.c
--- libsemanage/src/semanage_store.c	11 Aug 2006 20:03:44 -0000	1.56
+++ libsemanage/src/semanage_store.c	14 Aug 2006 18:40:53 -0000
@@ -1057,37 +1057,33 @@ static int semanage_install_active(seman
 
 	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);
 	if (semanage_copy_file(active_hd, store_hd, sh->conf->file_mode) == -1) {
-		INFO(sh, "Non-fatal error:  Could not copy %s to %s.",
-		     active_hd, store_hd);
-		/* Non-fatal; fall through */
+		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
+		goto cleanup;
 	}
 
 	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
 	if (semanage_copy_file(active_fc, store_fc, sh->conf->file_mode) == -1) {
-		INFO(sh, "Non-fatal error:  Could not copy %s to %s.",
-		     active_fc, store_fc);
-		/* Non-fatal; fall through */
+		ERR(sh, "Could not copy %s to %s.", active_fc, store_fc);
+		goto cleanup;
 	}
 
 	snprintf(store_fc_loc, PATH_MAX, "%s%s", storepath, running_fc_loc);
-	if (semanage_copy_file(active_fc_loc, store_fc_loc, sh->conf->file_mode) == -1) {
-		INFO(sh, "Non-fatal error:  Could not copy %s to %s.",
-		     active_fc_loc, store_fc_loc);
-		/* Non-fatal; fall through */
+	if (semanage_copy_file(active_fc_loc, store_fc_loc, sh->conf->file_mode) == -1 && errno != ENOENT) {
+		ERR(sh, "Could not copy %s to %s.", active_fc_loc, store_fc_loc);
+		goto cleanup;
 	}
 
 	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
 	if (semanage_copy_file
-	    (active_seusers, store_seusers, sh->conf->file_mode) == -1) {
-		INFO(sh, "Non-fatal error:  Could not copy %s to %s.",
-		     active_seusers, store_seusers);
-		/* Non-fatal; fall through */
+	    (active_seusers, store_seusers, sh->conf->file_mode) == -1 && errno != ENOENT) {
+		ERR(sh, "Could not copy %s to %s.", active_seusers, store_seusers);
+		goto cleanup;
 	}
 
 	snprintf(store_nc, PATH_MAX, "%s%s", storepath, running_nc);
-	if (semanage_copy_file(active_nc, store_nc, sh->conf->file_mode) == -1) {
-		INFO(sh, "Non-fatal error:  Could not copy %s to %s.", active_nc, store_nc);
-		/* Non-fatal; fall through */
+	if (semanage_copy_file(active_nc, store_nc, sh->conf->file_mode) == -1 && errno != ENOENT) {
+		ERR(sh, "Could not copy %s to %s.", active_nc, store_nc);
+		goto cleanup;
 	}
 
 	if (!sh->do_reload)


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
