Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2ADSuRb018640
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 08:28:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2ADRE6Q006665
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 13:27:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2ADRE5t006662
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 13:27:14 GMT
Subject: Re: blocking security xattr changes when policy is not loaded
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200403101420.53766.arekm@pld-linux.org>
References: <200403092329.42958.arekm@pld-linux.org>
	 <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
	 <200403101420.53766.arekm@pld-linux.org>
Content-Type: text/plain
Message-Id: <1078925325.4029.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 08:28:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-10 at 08:20, Arkadiusz Miskiewicz wrote:
> Don't know the internals but why it can't blindly accept? No policy, so 
> nothing to do with selinux stuff. If any permission checks are allowed so no 
> need to check anything (no need to security_context_to_sid()) right?

You'd have to add tests within the hook functions themselves to see
whether policy has been loaded, and skip this kind of processing in that
case.  security_context_to_sid can't return a SID unless it can map the
context to an internal structure that can be interpreted by the security
server on subsequent permission checks.

> That's bad - I wrote why. I will lose security xattr on the file!
> When I load policy things will go really bad since /etc/shadow file won't have 
> proper security context.

You need to relabel your filesystem when you run without SELinux (and
without policy might as well be without SELinux at all).  Note that
/sbin/init will die if it cannot load a policy when SELinux is booted in
enforcing mode, so the fact that you can even operate in such a state is
only because you are booting in permissive mode.  If you don't want
SELinux, boot with selinux=0.  If you want SELinux, load a policy. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
