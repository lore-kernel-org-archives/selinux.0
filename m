Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2ADL4Rb018605
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 08:21:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2ADL20H010901
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 13:21:03 GMT
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: blocking security xattr changes when policy is not loaded
Date: Wed, 10 Mar 2004 14:20:53 +0100
References: <200403092329.42958.arekm@pld-linux.org> <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403101420.53766.arekm@pld-linux.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dnia Wednesday 10 of March 2004 13:50, Stephen Smalley napisa³:

> SELinux still performs its regular processing even without the policy
> load; it is just that any permission checks are allowed until a policy
> is loaded.  The setxattr() is not failing due to a permission check; it
> is failing because selinux_inode_setxattr() attempts to convert the
> context to a SID (via security_context_to_sid) in preparation for making
> permission checks, and the context is unknown to the security server
> (policy engine) because no policy has been loaded.  The security server
> can't just blindly accept contexts and provide SIDs; it needs to have an
> internal representation of the context that it can understand.
Don't know the internals but why it can't blindly accept? No policy, so 
nothing to do with selinux stuff. If any permission checks are allowed so no 
need to check anything (no need to security_context_to_sid()) right?

> In any event, note is_selinux_enabled() should return 0 when no policy
> is loaded, so if the pwdutils code was bracketing SELinux-related
> processing with if (is_selinux_enabled() > 0), it wouldn't even try to
> do this.
That's bad - I wrote why. I will lose security xattr on the file!
When I load policy things will go really bad since /etc/shadow file won't have 
proper security context.

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
