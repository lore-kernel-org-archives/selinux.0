Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDMVfIi008089
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 17:31:41 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDMTxUx027452
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 22:29:59 GMT
Received: (from smmsp@localhost)
	by tcsfw2.tcs-sec.com (8.12.2/8.12.2) id iBDMViuc022198
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 17:31:44 -0500 (EST)
Message-ID: <41BE1887.4010201@trustedcs.com>
Date: Mon, 13 Dec 2004 16:32:39 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [patch] selinux_capget()
Content-Type: multipart/mixed;
 boundary="------------010303070100030900080408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010303070100030900080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Currently, SELinux restricts the use of capabilities by a process based on the 
process domain's access to the capability security class.  This restriction is 
not reflected in the capabilities returned by the capget system call.  I have 
attached a small patch which would remove the "disallowed" capabilities from the 
effective set that is returned from the call.  This seems to be a good idea to 
me because it gives an accurate picture of the the capabilities that a process 
can use.  Does anyone else have an opinion on this?

-- 

Darrel

--------------010303070100030900080408
Content-Type: text/plain;
 name="selinux_capget.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux_capget.patch"

Index: hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.26
diff -u -r1.26 hooks.c
--- hooks.c	6 Dec 2004 20:04:06 -0000	1.26
+++ hooks.c	13 Dec 2004 21:14:15 -0000
@@ -1365,13 +1365,26 @@
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
                           kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
+	struct task_security_struct *tsec;
+	struct av_decision avd;
 	int error;
 
 	error = task_has_perm(current, target, PROCESS__GETCAP);
 	if (error)
 		return error;
 
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	error = secondary_ops->capget(target, effective, inheritable,
+	                              permitted);
+	if (error)
+		return error;
+
+	/* Remove the capabilites that are not allowed to be used by the domain
+	   from the effective set */
+	tsec = target->security;
+	(void)avc_has_perm_noaudit(tsec->sid, tsec->sid,
+	                           SECCLASS_CAPABILITY, ~0, &avd);
+	cap_mask(*effective, avd.allowed);
+	return 0;
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,

--------------010303070100030900080408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
