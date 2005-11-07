Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7IA3MA025961
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 13:10:03 -0500 (EST)
Subject: [Fwd: [patch 1/1] selinux:  MLS compatibility]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 07 Nov 2005 13:00:13 -0500
Message-Id: <1131386413.20591.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI, this patch has been submitted upstream to address a previously
raised concern about on-disk compatibility between MLS and non-MLS
SELinux systems (particularly for MCS).

-------- Forwarded Message --------
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris
<jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/1] selinux: MLS compatibility
Date: Mon, 07 Nov 2005 11:09:01 -0500

This patch enables files created on a MLS-enabled SELinux system to be
accessible on a non-MLS SELinux system, by skipping the MLS component of
the security context in the non-MLS case.  Please apply, for 2.6.15 if
possible.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@namei.org>

---

 security/selinux/ss/mls.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/ss/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/mls.c,v
retrieving revision 1.26
diff -u -p -r1.26 mls.c
--- linux-2.6/security/selinux/ss/mls.c	29 Aug 2005 14:13:22 -0000	1.26
+++ linux-2.6/security/selinux/ss/mls.c	4 Nov 2005 19:26:47 -0000
@@ -262,8 +262,11 @@ int mls_context_to_sid(char oldc,
 	struct cat_datum *catdatum, *rngdatum;
 	int l, rc = -EINVAL;
 
-	if (!selinux_mls_enabled)
+	if (!selinux_mls_enabled) {
+		if (def_sid != SECSID_NULL && oldc)
+			*scontext += strlen(*scontext);
 		return 0;
+	}
 
 	/*
 	 * No MLS component to the security context, try and map to

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
