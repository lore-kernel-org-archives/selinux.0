Subject: Re: Process Transition
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA3115410@chaos.tcs.tcs-sec.com>
References: <791924EBDA572C4FA970D4A94AA95DA3115410@chaos.tcs.tcs-sec.com>
Content-Type: multipart/mixed; boundary="=-48nsYsLsKn+WypGqCJ3C"
Message-Id: <1079113956.8203.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 12:52:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-48nsYsLsKn+WypGqCJ3C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-03-11 at 15:49, Chad Hanson wrote:
> We found a piece of process transition code that should be updated to work
> as expected.
> 
> In ss/services.c context_struct_compute_av() the following should be
> changed:
> 
> 	if (tclass == SECCLASS_PROCESS &&
> bug >>	    avd->allowed && PROCESS__TRANSITION &&
> 	    scontext->role != tcontext->role) {
> 		for (ra = policydb.role_allow; ra; ra = ra->next) {
> 			if (scontext->role == ra->role &&
> 			    tcontext->role == ra->new_role)
> 				break;
> 		}
> 		if (!ra)
> 			avd->allowed = (avd->allowed) &
> ~(PROCESS__TRANSITION);
> 	}
> 
> it should be
> 
> 	if (tclass == SECCLASS_PROCESS &&
> 	    avd->allowed & PROCESS__TRANSITION &&
> 	    scontext->role != tcontext->role) {

Thanks; patch attached.  The existing buggy code will still produce the
right access computation; it just causes unnecessary processing to occur
when the transition permission wasn't granted in the first place by the
TE configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-48nsYsLsKn+WypGqCJ3C
Content-Disposition: attachment; filename=selinux-fixtrans.patch
Content-Type: text/x-patch; name=selinux-fixtrans.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.34
diff -u -r1.34 services.c
--- linux-2.6/security/selinux/ss/services.c	18 Feb 2004 14:26:06 -0000	1.34
+++ linux-2.6/security/selinux/ss/services.c	12 Mar 2004 13:37:44 -0000
@@ -262,7 +262,7 @@
 	 * pair.
 	 */
 	if (tclass == SECCLASS_PROCESS &&
-	    avd->allowed && PROCESS__TRANSITION &&
+	    (avd->allowed & PROCESS__TRANSITION) &&
 	    scontext->role != tcontext->role) {
 		for (ra = policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&

--=-48nsYsLsKn+WypGqCJ3C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
