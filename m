Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SF3DRb005251
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 10:03:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0SF1uxr020711
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:01:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0SF1tYc020708
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:01:56 GMT
Subject: Re: login roles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Timothy Wood <timothy@diyab.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <4015F1FB.4000902@diyab.net>
References: <4015F1FB.4000902@diyab.net>
Content-Type: multipart/mixed; boundary="=-qFHZ9UpOcoRl62IA34Bj"
Message-Id: <1075302172.19427.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 10:02:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qFHZ9UpOcoRl62IA34Bj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-01-27 at 00:07, Timothy Wood wrote:
> I set the pam_selinux module to multiple and now I'm seeing three roles 
> instead of the two defined in policy/users.  The third context is 
> <username>:staff_r:system_chkpwd_t, is this normal? I diffed my current 
> policy against the 1.4 tarball from the NSA site and the only 
> differences are a couple of changes I've made for slackware.  Of those 
> few changes none of them have anything to do with system_chkpwd_t.

This is due to the fact that system_chkpwd_t is authorized for
<username>:staff_r and is also reachable from the login domains to
perform authentication, so that context is reachable (but not enterable
via the user shell, so it won't actually work when in enforcing mode). 
I've tightened the constraints to reduce this problem, but we may need
to change the getconlist logic to check entrypoint access to the shell
as well to fully address it.  My patch to the policy/constraints file is
attached, and this change is in the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-qFHZ9UpOcoRl62IA34Bj
Content-Disposition: attachment; filename=constraints.diff
Content-Type: text/x-patch; name=constraints.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/constraints
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/constraints,v
retrieving revision 1.2
retrieving revision 1.4
diff -u -r1.2 -r1.4
--- policy/constraints	1 Jul 2003 13:35:42 -0000	1.2
+++ policy/constraints	21 Jan 2004 15:25:29 -0000	1.4
@@ -34,14 +34,18 @@
 #
 
 constrain process transition
-	( u1 == u2 or t1 == privuser
+	( u1 == u2 or ( t1 == privuser and t2 == userdomain )
 ifdef(`crond.te', `
          or (t1 == crond_t and t2 == user_crond_domain)
 ')
         );
 
 constrain process transition 
-	( r1 == r2 or t1 == privrole) ;
+	( r1 == r2 or ( t1 == privrole and t2 == userdomain )
+ifdef(`crond.te', `
+         or (t1 == crond_t and t2 == user_crond_domain)
+')
+        );
 
 #
 # Restrict the ability to label objects with other

--=-qFHZ9UpOcoRl62IA34Bj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
