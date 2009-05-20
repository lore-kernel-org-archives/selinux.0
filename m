Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <200905202257.08555.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <200905202242.37606.linuxweb@gmx.net>
	 <1242830433.20082.402.camel@localhost.localdomain>
	 <200905202257.08555.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 11:10:14 -0400
Message-Id: <1242832214.20082.410.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:57 +0800, Dennis Wronka wrote:
> Okay, here we go:
> 
> I unmounted /selinux and then got this:
> load_policy: Can't load policy: Invalid argument
> 
> I attached my kernel-config and the two traces (trace1 for the "Device or 
> resource busy"-error, trace2 for the "Invalid argument"-error).

Possible patch for libselinux to a) gracefully handle the situation
where selinuxfs is already mounted, b) report errors when switching to
permissive, and c) proceed with the policy load even if we cannot switch
to permissive mode as requested, as proceeding without a policy when the
kernel only supports enforcing mode is not desirable.

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a3a28a0..a7800da 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -369,7 +369,7 @@ int selinux_init_load_policy(int *enforce)
 	 * Check for the existence of SELinux via selinuxfs, and 
 	 * mount it if present for use in the calls below.  
 	 */
-	if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
+	if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0 && errno != EBUSY) {
 		if (errno == ENODEV) {
 			/*
 			 * SELinux was disabled in the kernel, either
@@ -416,8 +416,11 @@ int selinux_init_load_policy(int *enforce)
 		goto noload;
 	if (orig_enforce != *enforce) {
 		rc = security_setenforce(*enforce);
-		if (rc < 0)
-			goto noload;
+		if (rc < 0) {
+			fprintf(stderr, "SELinux:  Unable to switch to %s mode:  %s\n", (*enforce ? "enforcing" : "permissive"), strerror(errno));
+			if (*enforce)
+				goto noload;
+		}
 	}
 
 	/* Load the policy. */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
