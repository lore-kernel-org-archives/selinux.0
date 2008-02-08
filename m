Subject: Re: [patch] libselinux: provide more error reporting on
	load	policy failures
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, "Todd C. Miller" <tmiller@tresys.com>,
        David Quigley <dpquigl@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <47AB824A.3080309@manicmethod.com>
References: <1202412666.27371.294.camel@moss-spartans.epoch.ncsc.mil>
	 <47AB6733.9060002@manicmethod.com>
	 <1202418570.27371.296.camel@moss-spartans.epoch.ncsc.mil>
	 <47AB824A.3080309@manicmethod.com>
Content-Type: text/plain
Date: Fri, 08 Feb 2008 11:26:37 -0500
Message-Id: <1202487997.27371.393.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 17:12 -0500, Joshua Brindle wrote:
> Understood. I only asked because of the setools thread where there are 
> apparently 2 cases to cover, make it just work for most people and to be 
> very specific for analysts. If an analyst (or Dan) can't easily get 
> policy load information from a target machine (where it was loaded from, 
> if it was downgraded) it may be more error prone to analyze the policy 
> or troubleshoot an error
> 
> The handle_unknown thing was probably startling because it isn't very 
> obvious what it means. Policy loaded from <path> [downgraded to version 
> <ver>]. hopefully wouldn't raise alarms (though the downgraded part may).
> 
> It was just a thought...

Patch below, relative to the prior one.
# /usr/sbin/load_policy 
SELinux:  Loaded policy from /etc/selinux/targeted/policy/policy.22 (downgraded to version 21).
# rm /etc/selinux/targeted/policy/policy.22
# /usr/sbin/load_policy 
SELinux:  Loaded policy from /etc/selinux/targeted/policy/policy.21.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2796)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -275,6 +275,11 @@
 		fprintf(stderr,
 			"SELinux:  Could not load policy file %s:  %s\n",
 			path, strerror(errno));
+	else if (vers > kernvers)
+		printf("SELinux:  Loaded policy from %s (downgraded to version %d).\n",
+		       path, kernvers);
+	else
+		printf("SELinux:  Loaded policy from %s.\n", path);
 
       unmap:
 	if (data != map)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
