Date: Fri, 28 Sep 2001 14:41:17 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109281941.OAA50738@tomcat.admin.navo.hpc.mil>
To: russell@coker.com.au, SELinux@tycho.nsa.gov
Subject: Re: distribution of kernel patches
In-Reply-To: <20010928180800.00E31334E9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au>:
> 
> I believe that the current method of distributing the kernel code could be
> improved by supplying it as either a single patch, or a tar file with a tiny
> patch.
> 
> Most kernel code is distributed in the form of a unified diff.  This form is
> easy to separate from other related code (often we need kernel code and
> user-space code separate for compilation on different machines).  It is easy
> to manipulate in scripts (such as for the Debian packages I am preparing),
> and is easy to combine with other patches.
> 
> A tar file and a small patch would also be easy to deal with.
> 
> The current situation of having a Makefile which applies a patch, creates
> sym-links, etc makes it virtually impossible to automatically do anything
> with the code.  This means I can't use pure upstream source in my
> kernel-patch package which adds a risk of error, and makes it more difficult 
> for anyone who wants to audit my work.
> 
> Could the management of the kernel patch be changed in the next release?
> 
> 
> Also could the kernel patch please change the EXTRAVERSION variable in the 
> top-level makefile?  Currently the kernel-patch package I am playing with 
> changes it from "-lsm" to "-selinux", but it would be equally valid to change 
> it to "-lsm-selinux" instead.  I believe that a change to the EXTRAVERSION is 
> necessary for anyone who is attempting to manage kernel builds for 
> dis-similar machines.  The results of installing a non-SE kernel when you 
> want a SE kernel or of installing a SE kernel when you want a non-SE kernel 
> are both unpleasant!

Actually, I would prefer the "EXTRAVERSION" be left alone and/or add a new
form of EXTRAVERSION (I'll call it "LOCALVERSION") be made generally available.

That way patches could modify "EXTRAVERSION" and I can use "LOCALVERSION" to
hold whatever the local site chose.

Currently, I'm using EXTRAVERSION to have thinks like:
	-RSBAC
	-RSBAC.MAINT
	-RSBAC.SMP
	-SMP

I would also suggest that the name string have a defined format:
	Linux-MAJORVERSION.PATCHLEVEL.SUBLEVEL-EXTRAVERSION-LOCALVERSION
That way it would also be possible to see other items - something like:
	Linux-2.4.10-ac3-SMP

And any missing fields be null:
	Linux-2.4.10--

It is easy to get carried away with naming things:

	Linux-2.4.10-ac3-lsm.27-SMP

(calls for multiple layers of extraversion, one for the ac levels, one
for the lsm number, one for localversion..."When I name a thing it means
what I mean, and nothing more" (((or something like that))) :-)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
