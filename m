Subject: Re: [ SEMANAGE ] Install seusers, rename some files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4366C114.9080708@cornell.edu>
References: <4366C114.9080708@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:10:37 -0500
Message-Id: <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 20:12 -0500, Ivan Gyurdiev wrote:
> Changes:
> - adds seuser install code
> - renames for consistency:
>    port_contexts -> ports.local
>    (empty)         -> interfaces.local
>    local.users     -> users.local
>    (and we have booleans.local)

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-31 19:45:08.000000000 -0500
@@ -894,6 +899,12 @@ static int semanage_install_active(seman
 		goto cleanup;
 	}
 
+	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
+	if (semanage_copy_file(active_seusers, store_seusers) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_seusers, store_seusers);
+		goto cleanup;
+	}
+
 	if (!sh->do_reload)
 		goto skip_reload;
 

I'm not sure about this; at present, it has the side effect that a
semodule -b base.pp will fail upon the attempt to copy seusers (because
there isn't one in the sandbox presently, not even an empty stub).  We
also have to be careful about not clobbering any existing seusers file
during the migration, although I suppose that will be handled by moving
it into the sandbox upon policy upgrade, as with booleans.local.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
