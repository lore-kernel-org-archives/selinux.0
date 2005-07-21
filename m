Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LEl3gA026354
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:47:04 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LEgNrg010955
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:42:28 GMT
Subject: Re: [RFC][PATCH] polyinstantiation using process namespace
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov, Janak Desai <janak@us.ibm.com>
In-Reply-To: <42DFACFB.6050603@us.ibm.com>
References: <1121893384.6269.29.camel@localhost.localdomain>
	 <42DFACFB.6050603@us.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:40:48 -0400
Message-Id: <1121971248.4416.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Responses below.

Thanks,
Chad


> >         2) Current patch skips malformed or invalid lines in the 
> >            /etc/security/namespace.conf file. For example, missing
> >            arguments or lack of absolute pathnames or unknown
> >            polyinstantiation method. Is it better to exit with an
> >            error instead of not performing polyinstnation for that
> >            particular directory?
> >         
> > Probably should exit with error, as that's failing secure.  The only
> > catch here is that if you boot a machine, and there are no users listed
> > as exempt (I think you renamed this to override_user), then no one could
> > log in.  That's definitely failing secure, but it's not going to earn
> > you popularity points.  Assuming that most systems will have users not
> > subject to polyinstantiation, I'd say it's better to exit with an error.
> > 
> 
> Good point. I can easily change this to exit with error. However, since
> I have made exempt/override user specification per directory, an
> improperly configured namespce.conf will still result in no one being
> able to login from init state 3 or 5. If that happens, admins will have
> to boot in single user mode to fix it.
> 

I usually vote for preventing an admin from having to use single user
mode, but it's already a precedent when dealing with pam (at least every
time I screw up my pam config, I end up having to use single user mode).


> >         4) What should be the security context of the reset directory,
> >            where original contents are available to only authorized
> >            processes? Right now I am using mode of 000, but I know 
> >            that is not correct since polyinstantiated directory is 
> >            mounted on top of that directory. 
> >         
> > I'm not sure if you're referring to the context and mode of the created
> > reset directory (*-poly.orig), or the original directory that is mounted
> > on it.  The original directory should have a system context (in
> > file_contexts) and mode appropriate to keep the access limited to
> > authorized processes.  These will probably vary from directory to
> > directory.  The created reset directory is only a mount point, so it
> > needs a label that has almost no permissions on it (essentially only
> > mounton given to entrypoint programs).  This should be the same type
> > (something like poly_reset_t) for all mount points.  The mode doesn't
> > matter, but I made it 000 to make sure that no one accidentally put
> > something there while in permissive mode.
> > 
> 
> Yes, the problem is that once you bind mount original directory on
> the created reset directory, access checks are made against the
> bind mounted original directory mode/context. For example, /tmp is 777.
> The reset directory, /.poly-orig is 000. Now, after /tmp is bind mounted
> on /.poly-orig, /.poly-orig is also 777. Which means a user is
> still able to access the original directory.
> 

Yes, that's where they system policy must be changed.  /tmp (or any
other polyinstantiated directory) should no longer be accessible to
anyone.  So, we have to modify policy to only allow entrypoint programs
and trusted domains to access this parent directory for the polydirs.
Similarly, we need to change the DAC perms on it to something
appropriate for a directory that is inaccessible to most users (700
probably).  Current policy and DAC permissions are designed to make the
common /tmp work, which means they give a lot of permissions that we
want to get away from.  With polyinstantiation, we can solve this
problem.

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
