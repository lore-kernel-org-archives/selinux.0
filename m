Subject: Re: I am concerned about putting genhomedircon changes in
	libsemanage into Fedora 8.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46FA7107.2000003@manicmethod.com>
References: <46CED283.8060804@redhat.com> <46FA661F.1080703@redhat.com>
	 <46FA7107.2000003@manicmethod.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 11:03:06 -0400
Message-Id: <1190818986.2895.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 10:47 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Daniel J Walsh wrote:
> >   
> >> I may hold off on this so we can get a full Rawhide cycle on it.
> >> genhomedircon has many corner cases and do not want to risk blowing F-8
> >> now that we are at Feature Freeze.
> >> All the rest of the patches have been integrated.
> >
> >
> >
> > The genhomedircon replacement is broken in libsemanage.  It is
> > generating invalid file context.  The python version verified the
> > file context it was creating were valid before assiging them.  This is
> > resulting in Fedora Core 8 not being able to autorelabel
> >
> >   
> 
> The python version did the wrong thing entirely. It validated the 
> contexts against the running policy in the kernel, which breaks when you 
> try to do an operation on another store. Also since we moved 
> genhomedircon inside of libsemanage the new policy isn't even loaded yet 
> so we can't validate against the kernel (or the new types added by the 
> module being added would be 'invalid'). The only real way to validate 
> the contexts now would be to load the newly generated policy into the 
> libsepol security server and to the context validations on it.
> 
> This would work, it would just take extra time at module load time. It 
> seems like the real problem is that the invalid contexts are being 
> generated in the first place, relying on genhomedircon to sanity check 
> your file contexts seems like you are punting the problem.
> 

Perhaps - but it is a significant change in behavior and reworking all
of the policies is going to be difficult or impossible.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
