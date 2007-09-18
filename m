Subject: [patch] libselinux, setfiles:  fix selabel option flag setting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 18 Sep 2007 14:20:48 -0400
Message-Id: <1190139648.14037.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix selabel option flag setting to eliminate a build error on 64-bit.

---

 libselinux/src/matchpathcon.c       |    4 ++--
 policycoreutils/setfiles/setfiles.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: trunk/libselinux/src/matchpathcon.c
===================================================================
--- trunk/libselinux/src/matchpathcon.c	(revision 2562)
+++ trunk/libselinux/src/matchpathcon.c	(working copy)
@@ -119,10 +119,10 @@
 	memset(options, 0, sizeof(options));
 	i = SELABEL_OPT_BASEONLY;
 	options[i].type = i;
-	options[i].value = (char *)(flags & MATCHPATHCON_BASEONLY);
+	options[i].value = (flags & MATCHPATHCON_BASEONLY) ? (char*)1 : NULL;
 	i = SELABEL_OPT_VALIDATE;
 	options[i].type = i;
-	options[i].value = (char *)(flags & MATCHPATHCON_VALIDATE);
+	options[i].value = (flags & MATCHPATHCON_VALIDATE) ? (char*)1 : NULL;
 	notrans = flags & MATCHPATHCON_NOTRANS;
 }
 
Index: trunk/policycoreutils/setfiles/setfiles.c
===================================================================
--- trunk/policycoreutils/setfiles/setfiles.c	(revision 2562)
+++ trunk/policycoreutils/setfiles/setfiles.c	(working copy)
@@ -967,8 +967,8 @@
 	}
 
 	/* Load the file contexts configuration and check it. */
-	opts[0].value = (char *)ctx_validate;
-	opts[1].value = (char *)base_only;
+	opts[0].value = (ctx_validate ? (char*)1 : NULL);
+	opts[1].value = (base_only ? (char *)1 : NULL);
 	opts[2].value = altpath;
 
 	hnd = selabel_open(SELABEL_CTX_FILE, opts, 3);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
