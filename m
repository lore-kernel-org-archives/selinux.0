Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FMjCL9012158
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 17:45:13 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FMfiw0001677
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 22:41:45 GMT
Date: Tue, 15 Feb 2005 22:53:29 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050215225329.GH26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
In-Reply-To: <20050215200355.GB26294@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

okay: am i being particularly thick today, or am i missing something?

we expect domain automatic transitions to occur on an execve().
it's how everything hangs together in selinux.

_should_ i expect automatic transitions to be possible on
a "dynamic" transition?

because, without them, things get a bit inconvenient.

i wrote a code-fragment earlier where i do a get_default_context(),
and then i do a setcon().

on the setcon(), because i happened to be in sshd_privsep_t, and because
i happened to be setting the context to user_t, and because it was
sshd_exec_t doing the setting, i expect an "automatic" transition
to occur to sshd_privsep_user_t.


otherwise, what i am going to have to do makes me feel slightly
queasy, and if i recall correctly, it's what made me think "how the 
heck am i gonna do that???" when i was considering this for samba tng.

if you recall, i mentioned something about munging security contexts
by digging into the text of a struct security_context - by MANUALLY
creating a string:

	char new_context[500];
	context = get_default_context(..., &scontext);
	sprintf(new_context, "samba_%s", (char*)scontext));
	setcon((struct security_context*)new_context);

EEEEEUUUUWWW, yukkk, i hear you say.

yeh, yuk.  a really awful hack, that leads to croo-joze nasties
and hard-coded context names and stuff .... in an application.

well, if there existed that dynamic_auto_trans() macro - and
support for it in hooks.c - then the problem of hard-coded
security contexts ... melts away and disappears.

why?  because it would be possible to do this:

	dynamic_auto_trans(sshd_privsep_t, user_t, sshd_exec_t,
			   sshd_privsep_user_t)


and in sshd, just do this:

	get_default_context(&scontext), /* gets user_t or other user context */
	setcon(&scontext).

ta-daa.

good idea?

like it?

good.  patch attached.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--qDbXVdCdHGoSgWSk
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

--qDbXVdCdHGoSgWSk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
