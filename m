Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2AFxaRb019901
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 10:59:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2AFvt6Q020729
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 15:57:55 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id i2AFvs5t020668
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 15:57:54 GMT
Received: from hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 754A22CC31B
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 16:59:17 +0100 (CET)
Date: Wed, 10 Mar 2004 16:59:16 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: blocking security xattr changes when policy is not loaded
Message-ID: <20040310155916.GA11097@suse.de>
References: <200403092329.42958.arekm@pld-linux.org> <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 10, Stephen Smalley wrote:

> On Tue, 2004-03-09 at 17:29, Arkadiusz Miskiewicz wrote:
> > Hi,
> > 
> > The case is that 2.6 selinux enabled kernel but _without_ policy loaded do not 
> > allow to change security xattr for root user.
> > 
> > The question is why is that?
> 
> SELinux still performs its regular processing even without the policy
> load; it is just that any permission checks are allowed until a policy
> is loaded.  The setxattr() is not failing due to a permission check; it
> is failing because selinux_inode_setxattr() attempts to convert the
> context to a SID (via security_context_to_sid) in preparation for making
> permission checks, and the context is unknown to the security server
> (policy engine) because no policy has been loaded.  The security server
> can't just blindly accept contexts and provide SIDs; it needs to have an
> internal representation of the context that it can understand.
> 
> In any event, note is_selinux_enabled() should return 0 when no policy
> is loaded, so if the pwdutils code was bracketing SELinux-related
> processing with if (is_selinux_enabled() > 0), it wouldn't even try to
> do this.

But if you add this check, the security attributes will be missing
for the new file. I don't think that this is the expected behavior.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Maxfeldstr. 5                 D-90409 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
