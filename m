Date: Fri, 22 Aug 2008 21:38:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: lkml <linux-kernel@vger.kernel.org>, SELinux <selinux@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] selinux: add support for installing a dummy policy
Message-ID: <20080823023812.GA30915@us.ibm.com>
References: <20080822193413.GA8401@us.ibm.com> <alpine.LRH.1.10.0808230852320.24779@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.1.10.0808230852320.24779@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@namei.org):
> On Fri, 22 Aug 2008, Serge E. Hallyn wrote:
> 
> > In August 2006 I posted a patch to the selinux list generating a minimal
> > SELinux policy.  This week, David P. Quigley posted an updated version
> > of that as a patch against the kernel.  In addition to some fixes, also
> > had nice logic for auto-installing the policy.
> > 
> > I've gone ahead and hooked it into the kernel Makefile logic.  The way I
> > have it here, doing 'make scripts' ends up compiling 'mdp', after which
> > you must
> > 	cd scripts/selinux
> > 	sh install_policy.sh
> > 
> > That isn't as nice as being able to do
> > 	make selinux_install
> > the way David had it, but it avoids mucking with the top-level
> > Makefile.  Which is preferred?
> 
> I think leaving out of the top level makefile is preferred, as there are 
> no other subsystem targets there.
> 
> Please make sure 'make distclean' cleans up properly.  These are 
> currently left behind:

Oops, thanks.  Updated patched appended.

> #       scripts/selinux/mdp/file_contexts
> #       scripts/selinux/mdp/policy.23
> #       scripts/selinux/mdp/policy.conf
> 
> Please also provide documentation on how to boot the system up with this 
> policy.

Good point.  Where would people who'd want to use this be most
likely to look, in a scripts/selinux/README, or in
Documentation/selinux or Documentation/security/selinux or
somesuch?

> > +	echo "no file contests file.  Please run"
> 
> ITYM contexts :-)

Oops again - that whole block should be removed as it was there
because the contexts file was created in a different step, which
it isn't any more.

thanks,
-serge
