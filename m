Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FNgTL9012505
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 18:42:29 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FNcxw0006191
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 23:39:00 GMT
Date: Tue, 15 Feb 2005 23:51:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: [patch] dynamic auto trans
Message-ID: <20050215235120.GC30341@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <20050215231707.GC29523@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

updated "dynamic auto trans" patch.

corrected some of my misunderstandings from the cut/paste i
did, earlier.

removes some of the stuff that was accidentally file-based, derived
from domain_auto_trans which of course needs an executable and
therefore a sid from a file (which is inapplicable in this case).

the dynamic-auto-trans is based on the context (sid) you were,
and the context (sid) you want to be - no executables are involved.

unfortunately.


anyway.

maybe that additional avc checks should be PROCESS__SETCURRENT?
such that the second avc check in selinux_check_dyn_autotrans
should be this?

	/* Check permissions for the transition. */
	rc = avc_has_perm(fromsid, newsid, SECCLASS_PROCESS,
			PROCESS__DYNTRANSITION, NULL);
	if (rc)
		return rc;

        rc = avc_has_perm(newsid, sid, SECCLASS_PROCESS,
	                          PROCESS__SETCURRENT, NULL);

anyone got a clue, 'cos i haven't!

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

? .hooks.c.swp
? f
? ss/.services.c.swp
Index: hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.32
diff -u -r1.32 hooks.c
--- hooks.c	4 Feb 2005 18:09:20 -0000	1.32
+++ hooks.c	15 Feb 2005 22:41:27 -0000
@@ -4080,6 +4080,52 @@
 	return len;
 }
 
+/*
+ * purpose of this function is to determine if a dynamic auto-transition
+ * should occur.  if you were in context "fromsid", and are attempting
+ * to set the context as "sid", then instead, it gets set to "newsid".
+ *
+ * just like in selinux_bprm_set_security(), from which this function
+ * is derived (and is near-identical).
+ *
+ */
+static int selinux_check_dyn_autotrans( u32 fromsid, u32 sid, u32 *newsid)
+{
+	int rc;
+
+	/* Check for a default transition on this
+	 * dynamic context transition.  */
+	rc = security_transition_sid(fromsid, sid,
+			     SECCLASS_PROCESS, newsid);
+
+	if (rc)
+	{
+		/* we do _not_ have permission to do an auto-dyn-trans.
+		 * therefore, the sid to change to is the one that
+		 * the setcon() actually asked for.
+		 */
+		*newsid = sid;
+		return 0;
+	}
+
+        if (fromsid == *newsid) {
+		rc = avc_has_perm(fromsid, sid,
+				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, NULL);
+		return rc;
+	}
+
+	/* Check permissions for the transition. */
+	rc = avc_has_perm(fromsid, newsid, SECCLASS_PROCESS,
+			  PROCESS__TRANSITION, NULL);
+	if (rc)
+		return rc;
+
+	rc = avc_has_perm(newsid, sid, SECCLASS_FILE,
+			  FILE__ENTRYPOINT, NULL);
+
+	return rc;
+}
+
 static int selinux_setprocattr(struct task_struct *p,
 			       char *name, void *value, size_t size)
 {
@@ -4169,7 +4215,16 @@
 			if (error)
 				return error;
 		} else {
-			tsec->sid = sid;
+			u32 newsid;
+			int rc;
+
+			rc = selinux_check_dyn_autotrans( tsec->sid, sid,
+					                  &newsid);
+			if (rc)
+				tsec->sid = sid; /* nope - no auto-trans */
+			else
+				tsec->sid = newsid;
+
 			task_unlock(p);
 		}
 	}

--nFreZHaLTZJo0R7j--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
