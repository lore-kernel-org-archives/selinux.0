Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2ACp2Rb018378
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 07:51:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2ACp10F008751
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 12:51:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i2ACp1gZ008748 for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 12:51:01 GMT
Subject: Re: blocking security xattr changes when policy is not loaded
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200403092329.42958.arekm@pld-linux.org>
References: <200403092329.42958.arekm@pld-linux.org>
Content-Type: text/plain
Message-Id: <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 07:50:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-09 at 17:29, Arkadiusz Miskiewicz wrote:
> Hi,
> 
> The case is that 2.6 selinux enabled kernel but _without_ policy loaded do not 
> allow to change security xattr for root user.
> 
> The question is why is that?

SELinux still performs its regular processing even without the policy
load; it is just that any permission checks are allowed until a policy
is loaded.  The setxattr() is not failing due to a permission check; it
is failing because selinux_inode_setxattr() attempts to convert the
context to a SID (via security_context_to_sid) in preparation for making
permission checks, and the context is unknown to the security server
(policy engine) because no policy has been loaded.  The security server
can't just blindly accept contexts and provide SIDs; it needs to have an
internal representation of the context that it can understand.

In any event, note is_selinux_enabled() should return 0 when no policy
is loaded, so if the pwdutils code was bracketing SELinux-related
processing with if (is_selinux_enabled() > 0), it wouldn't even try to
do this.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
