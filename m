Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SIhmLa021256
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 14:43:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7SIgJpQ011957
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 18:42:20 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h7SIgJQX011954
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 18:42:19 GMT
Subject: Re: Package install probs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <20030828171242.GC6898@vnl.com>
References: <20030828144825.GA6898@vnl.com>
	 <200308290149.15229.russell@coker.com.au>  <20030828171242.GC6898@vnl.com>
Content-Type: text/plain
Message-Id: <1062096221.2517.259.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 28 Aug 2003 14:43:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-28 at 13:12, Dale Amon wrote:
> Security scaffold v1.1.0 initialized
> SELinux: initializing
> SELinux starting in permissive mode
> There is already a security framework initialized, register_security
> failed.
> Failure registering capabilities with the kernel.
> selinux_register_security: Registering secondary module capability
> Capability LSM initialized.
> 
> Is this because I enabled Linux default capabilities and
> that LSM is also providing that feature?

This isn't an error.  It just shows that the capability module wasn't
able to register itself as the primary security module (since SELinux
was already registered) and falls back to registering as a secondary
module under SELinux.  

You should have also seen further messages from SELinux later in
the initialization when it performs the initial policy load and sets up
the existing superblocks and inodes.  You did set up an initrd to
perform the initial policy load, as per the selinux-doc README, yes?

> Next, what is a good test to see if everything is working
> right? I've got one message in the log:
> 
>  (system_usetiathome) GETFILCON failed /etc/cron.d/setiathome
> 
> which seems to indicate selinux is at least doing something.
>
> I've also not yet acquired a patch to handle xattr on
> reiserfs and I haven't got a single system available that
> is non-reiserfs.

The above message appears to be a warning from crond about not being
able to get the security context of a cron script, which would make
sense if you have no xattr handler.  You need xattr support to use the
new SELinux.  As before, I'd suggest looking at the SuSE patches; it
should be straightforward to add a handler for the security namespace if
they've implemented general support for xattrs in reiser.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
