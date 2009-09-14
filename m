Subject: Re: [PATCH] libsepol/checkpolicy: Add support for multiple target
 OSes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: pjnuzzi <pjnuzzi@tycho.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4AAE945B.2020009@manicmethod.com>
References: <1252934558.2379.14.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AAE945B.2020009@manicmethod.com>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 15:33:55 -0400
Message-Id: <1252956835.13634.1048.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-14 at 15:07 -0400, Joshua Brindle wrote:
> On 09/14/2009 09:22 AM, pjnuzzi wrote:
> > Add support for multiple target OSes to libsepol and checkpolicy, where
> >    
> 
> what about checkmodule?

At present, the patch only deals with monolithic policy. To update for
modular policy, we'd need to introduce multiple string identifiers in
the modular format as well.  Which could be done, but I'm not sure it is
worthwhile given plans for replacing the module format.  The other
option is to select the output target platform in libsemanage via
semanage.conf configuration rather than embedding the target in the
modules.

> > the particular target OS is selected using a new -t target option to
> > checkpolicy.  The default target remains SELinux.  A new target and
> > support is introduced for Xen.  The target OS is identified in the
> > policy image by using different policy string identifiers in the header.
> > At present, policy string identifiers are required to have the same
> > length for ease of parsing the header and to preserve file(1) parsing of
> >    
> 
> That is not the case today. Does file really not have the ability to 
> read a length and then a string of that length?

I'm not sure what you mean by "not the case today".  The current
libsepol code does require a specific length and won't even try to read
the string if the length does not match the expected value, and the
existing /usr/share/magic definition for file(1) parsing expects fixed
offsets for the fields after the string identifier.  We could certainly
relax that requirement, but then we'd have to update /usr/share/magic
everywhere.  That seemed unnecessary - a string of 8 characters is
sufficient to identify the full range of possible target OSes.

> > subsequent fields after the string identifier.  For SELinux, the string
> > identifier remains "SE Linux".  For Xen, the string identifier is
> > "XenFlask".  The latent support for just "Flask" in the policy reading
> > code that was introduced for FMAC is dropped; a separate identifier for
> >    
> 
> Was it already in use? I don't think arbitrarily dropping identifiers is 
> a good idea.

Only in the FMAC checkpolicy program.  Not precisely production code,
and if we want to customize the policy format for OpenSolaris, we'll
want a distinctive string identifier anyway, not just a generic "Flask".
Easy to fix on the OpenSolaris FMAC side if it resumes development.

> > Solaris (e.g. "SolFlask") will be introduced later using this new target
> > mechanism if needed.  The same support can easily be extended for other
> > OSes.

> This is a fairly large patch, it might take a while to get through it. 
> Splitting it up would have been helpful.

Sorry - based on Chad's earlier comment in response to another patch
that a complete single patch against the selinux tree was fine, and
given that this does form a single logical change against a single
repository, I recommended keeping it as a single patch.

FWIW, I have reviewed this patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
