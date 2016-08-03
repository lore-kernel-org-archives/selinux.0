From: "Roberts, William C" <william.c.roberts@intel.com>
To: Steve Lawrence <slawrence@tresys.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: RE: [PATCH v2] module_to_cil: fix use of uninitialized variables
Date: Wed, 3 Aug 2016 21:59:37 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560127D5BB@ORSMSX103.amr.corp.intel.com>
References: <1470260523-2511-1-git-send-email-william.c.roberts@intel.com>
 <f51e6ed5-3a8a-9d82-49a8-2e88158444b5@tresys.com>
In-Reply-To: <f51e6ed5-3a8a-9d82-49a8-2e88158444b5@tresys.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Steve Lawrence [mailto:slawrence@tresys.com]
> Sent: Wednesday, August 3, 2016 2:51 PM
> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov;
> seandroid-list@tycho.nsa.gov; sds@tycho.nsa.gov
> Subject: Re: [PATCH v2] module_to_cil: fix use of uninitialized variables
> 
> On 08/03/2016 05:42 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Correct errors like these reported by gcc:
> >
> > module_to_cil.c: In function ‘block_to_cil’:
> > module_to_cil.c:229:20: error: ‘attr_list’ may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
> >   struct list_node *curr = (*attr_list)->head;
> >
> > Usages of attr_list_destroy() were called when list_init() fails. Just
> > bail early on failure.
> >
> > stack_init() and stack_destroy() also suffered from the aforementioned
> > issue.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsepol/src/module_to_cil.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c
> > b/libsepol/src/module_to_cil.c index b9a4af7..9d0d064 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1307,7 +1307,7 @@ static int cond_list_to_cil(int indent, struct
> > policydb *pdb, struct cond_node *
> >
> >  	rc = list_init(&attr_list);
> >  	if (rc != 0) {
> > -		goto exit;
> > +		return rc;
> >  	}
> >
> >  	for (cond = cond_list; cond != NULL; cond = cond->next) { @@ -3488,7
> > +3488,7 @@ static int block_to_cil(struct policydb *pdb, struct
> > avrule_block *block, struct
> >
> >  	rc = list_init(&attr_list);
> >  	if (rc != 0) {
> > -		goto exit;
> > +		return rc;
> >  	}
> >
> >  	rc = typealiases_to_cil(indent, pdb, block, stack); @@ -3635,7
> > +3635,7 @@ static int blocks_to_cil(struct policydb *pdb)
> >
> >  	rc = stack_init(&stack);
> >  	if (rc != 0) {
> > -		goto exit;
> > +		return rc;
> >  	}
> >
> >  	block = pdb->global;
> > @@ -3703,7 +3703,7 @@ static int linked_blocks_to_cil(struct policydb
> > *pdb)
> >
> >  	rc = stack_init(&stack);
> >  	if (rc != 0) {
> > -		goto exit;
> > +		return rc;
> >  	}
> >
> >  	block = pdb->global;
> >
> 
> I would recommend just initializing the variables to NULL and keeping the "goto
> exit"'s. That would maintain the single return point, allows for extra cleanup code
> to be run in the future if necessary, and is consistent with the rest of the
> module_to_cil code.

That's fine, but requiring only one exit point isn't consistent with the rest of libsepol,
some do it this way, some don’t. There will be slightly more overhead In the approach
of initializing it first and then jumping on failure, then checking if its NULL in the
destruction routine, then finally returning versus just checking the init routine
and returning.

> 
> - Steve
> 
