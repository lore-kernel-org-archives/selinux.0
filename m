Subject: Re: I am concerned about putting genhomedircon changes in
	libsemanage into Fedora 8.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46FA7680.50908@manicmethod.com>
References: <46CED283.8060804@redhat.com> <46FA661F.1080703@redhat.com>
	 <46FA7107.2000003@manicmethod.com> <46FA7572.4020809@redhat.com>
	 <46FA7680.50908@manicmethod.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 11:19:36 -0400
Message-Id: <1190819976.15779.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 11:10 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Joshua Brindle wrote:
> >   
> >> Daniel J Walsh wrote:
> >>     
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> Daniel J Walsh wrote:
> >>>  
> >>>       
> >>>> I may hold off on this so we can get a full Rawhide cycle on it.
> >>>> genhomedircon has many corner cases and do not want to risk blowing F-8
> >>>> now that we are at Feature Freeze.
> >>>> All the rest of the patches have been integrated.
> >>>>         
> >>>
> >>> The genhomedircon replacement is broken in libsemanage.  It is
> >>> generating invalid file context.  The python version verified the
> >>> file context it was creating were valid before assiging them.  This is
> >>> resulting in Fedora Core 8 not being able to autorelabel
> >>>
> >>>   
> >>>       
> >> The python version did the wrong thing entirely. It validated the
> >> contexts against the running policy in the kernel, which breaks when you
> >> try to do an operation on another store. Also since we moved
> >> genhomedircon inside of libsemanage the new policy isn't even loaded yet
> >> so we can't validate against the kernel (or the new types added by the
> >> module being added would be 'invalid'). The only real way to validate
> >> the contexts now would be to load the newly generated policy into the
> >> libsepol security server and to the context validations on it.
> >>
> >>     
> >
> >   
> >> This would work, it would just take extra time at module load time. It
> >> seems like the real problem is that the invalid contexts are being
> >> generated in the first place, relying on genhomedircon to sanity check
> >> your file contexts seems like you are punting the problem.
> >>
> >>     
> > Whether it did the wrong thing or not, the current functionality is more
> > broken.  You can not relabel with the current policy.  If SEManage could
> > automatically generate the homedir context based off the available
> > homedirectory context great.  Otherwise the only way we can do it is to
> > generate all the homedir context and then figure out which ones are
> > valid for this user.
> >
> > Lets fix the short time problem, by putting in the simple check the
> > currently running kernel.   If semanage loads the policy before
> > generating the homedir context, it should work fine. It is the best we
> > can do in the short run. And it works in the real world for now.
> >
> > If we want to invalidate this on -s TYPE not matching fine.  Once we
> > have patches that will validate on the installed context versus the one
> > loaded into the kernel.  We have other problems that I want to bring up
> > in other email chains.  About handling the installation of modules and
> > running of semanage when selinux is disabled.
> >
> > For now we are in the Deep Freeze of Fedora 8 and I can't relabel
> > because of libsemanage/genhomedircon
> >   
> 
> We can add the checking back asap, the best way to do it is by loading 
> the policy we just generated and validating against it in userspace (we 
> can't validate against the kernel since genhomedircon now runs within 
> the transaction and the new policy won't be loaded).

Looks like semanage_direct_commit() can just pass the in-memory expanded
policydb (out) to semanage_install_sandbox() and have it pass it down to
semanage_genhomedircon(), at which point it can be put in the
genhomedir_settings structure for further propagation to wherever we
need to do the sepol_context_check().

But the current genhomedircon.c code doesn't appear to parse the record
anywhere, just does string replacement on the entire line and then
writes it out.

fcontext_parse over in fcontexts_file.c does the parsing of
file_contexts.local, called by dbase_file_cache as the ->parse method.
semanage_fcontext_validate_local in fcontexts_local.c does validation of
those entries.  Not sure how much of that we can re-use for this
purpose.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
