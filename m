Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATLShIi014038
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 16:28:43 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATLRAYd023982
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 21:27:10 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <41AB383B.3020006@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41AB383B.3020006@trustedcs.com>
Content-Type: text/plain
Message-Id: <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 16:24:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-29 at 09:54, Darrel Goeddel wrote:
> The new patch is attached.  I also made a change to the general_domain_access 
> macro to not grant setcurrent to self - a separate can_setcon macro has been 
> added to grant this.  Dynamic transitions are denied for a multi-threaded 
> process (with more than one "kernel thread").  A process can switch its context 
> before spawning other threads and after all other threads have exited, but not 
> while any other threads exist.

Thanks.  What about the case of a CLONE_VM w/o CLONE_THREAD (native
Linux threads rather than POSIX threads)?  Possibly a check on
atomic_read(&current->mm->mm_users)?

Also, I know that we talked earlier about this issue, but even though
ptracing should typically be covered by the ptrace check upon the exec
that entered the domain that was allowed to perform the dynamic
transition in the first place, I think we likely want to recheck ptrace
status upon the dynamic transition as well for greater safety.  The diff
below relative to your patch should do it.  See any problems with it for
your intended usage?

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.136
diff -u -p -r1.136 hooks.c
--- linux-2.6/security/selinux/hooks.c	29 Nov 2004 19:45:59 -0000	1.136
+++ linux-2.6/security/selinux/hooks.c	29 Nov 2004 20:22:00 -0000
@@ -4149,6 +4149,8 @@ static int selinux_setprocattr(struct ta
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
 	else if (!strcmp(name, "current")) {
+		struct av_decision avd;
+
 		if (sid == 0)
 			return -EINVAL;
 
@@ -4162,7 +4164,24 @@ static int selinux_setprocattr(struct ta
 		if (error)
 			return error;
 
-		tsec->sid = sid;
+		/* Check for ptracing, and update the task SID if ok.
+		   Otherwise, leave SID unchanged and fail. */
+		task_lock(current);
+		if (current->ptrace & PT_PTRACED) {
+			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
+						     SECCLASS_PROCESS,
+						     PROCESS__PTRACE, &avd);
+			if (!error)
+				tsec->sid = sid;
+			task_unlock(current);
+			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
+				  PROCESS__PTRACE, &avd, error, NULL);
+			if (error)
+				return error;
+		} else {
+			tsec->sid = sid;
+			task_unlock(current);
+		}
 	}
 	else
 		return -EINVAL;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
