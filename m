Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJGT3Ii021560
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 11:29:03 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJGRX3H014326
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 16:27:35 GMT
Message-ID: <419E1F76.9080803@trustedcs.com>
Date: Fri, 19 Nov 2004 10:29:42 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>,
   Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com>	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>	 <20041112184232.GK15243@golconda.mitre.org>	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>	 <nhau0rm54ra.fsf@malabar.mitre.org> <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Regardless of what path is chosen, some change is required to the patch
> that was proposed.   Either the kernel code needs to explicitly prohibit
> usage by multi-threaded applications or the libselinux code needs to use
> /proc/self/task/<tid>/attr/current to allow usage by multi-threaded
> applications.
> 

We are wanting to maintain the same security context for all threads of a 
process.  I was doing some investigation last night and came up with something 
like this for the setcurrent code (idea only - not compiled, will get more 
investigation):

     else if (!strcmp(name, "current")) {
         if (sid == 0)
             return -EINVAL;

+        /* Only allow the leader thread to change the context */
+        if (!thread_group_leader(p))
+            return -EPERM; /* what should we return ??? */

         /* Check permissions for the transition. */
         error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
                              PROCESS__DYNTRANSITION, NULL);
         if (error)
             return error;

         tsec->sid = sid;
+        if (!thread_group_empty(p)) {
+            /* Update the other threads in this group */
+            struct task_struct *thread = next_thread(p);
+            read_lock(&tasklist_lock);
+            while (thread != p) {
+                tsec = thread->security;
+                tsec->sid = sid;
+                thread = next_thread(thread);
+            }
+            read_unlock(&tasklist_lock);
+        }

Does this seem to be on the right track?  I will be looking more at this today. 
  I am looking to still allow multi-threaded apps to use the facility, but only 
the leader thread will have that ability.  All threads should be updated with 
the new context.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
