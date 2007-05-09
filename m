Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49JUxKE009005
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 15:30:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49JUvoo027612
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 19:30:58 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "J. Tang" <jtang@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1178735753.5665.38.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <1178735753.5665.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 15:22:20 -0400
Message-Id: <1178738540.2951.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 14:35 -0400, J. Tang wrote:
> On Mon, 2007-05-07 at 18:06 -0400, Karl MacMillan wrote:
> > +/**
> > + * \ingroup sepol_policy
> > + *
> > + * Every type in the policy object system is identified
> > + * by a numberic typeid.
> > + */
> 
> There seems to be some things missing from this enumeration.  What about
> common object classes, users, (role) allow, constraints, validate
> transitions, and range transitions?
> 

The only things included are those that I had gotten to in my previous
patch set. We can add the remaining types as we go.

> >From the code you posted, I was unable to determine a few things.  How
> do you plan on handling these situations?
> 
> 1. What about aliases for categories and levels?

Not certain what you are asking.

> 2. How does this differentiate between symbols declared versus symbols
> required within modules?  Recall that modules can have require
> statements currently.

Requires are going to be removed entirely - I thought that this had been
discussed on-list, but perhaps not. So far they are only a source of
bugs - no reason to keep them.

> 3. How does this differentiate between symbols declared versus symbols
> required within optional blocks?

Same as above - no requires. To determine whether an optional block can
be activated you will have to check the scope for that block for
declarations (by walking the tree - but I assume that the code that does
this will cache declarations to make this simpler). See policy_check.c
in the other patches I have posted for RFC.

> 4. What are the steps to determine if all of a module's dependencies
> have been met?

Walk the tree looking at declarations. Again, see policy_check.c.

> 5. If all strings are being stored in the object pool, does that also
> mean permissions are instances of sepol_objpool as well?  

No - permissions will just be strings. There must be some
misunderstanding as this question makes no sense to me.

> 6. Where is the definition of struct sepol_objpool?
> 

In objpool.c - see the previously merged patches.

> It is unclear how semantic analysis and code generation will operate.
> For example, how does one determine if the strings within the source of
> an AV allow rule are valid attributes, types, or aliases?

Walking the tree that represents the scope for the block looking for
declarations. As I mentioned in a previous discussion - an explicit goal
of this work is to remove duplicate storage of information. That means
that scoping information is represented _only_ by the tree structure,
valid symbols _only_ by declarations, etc., etc.

I'm fine with some code caching parts of this information, but I don't
want it pushed into the basic representation. The current code base has
suffered greatly because making changes to the policy is difficult. This
is both because of the use of ids and because of the duplicate storage
of information.

>   For each
> string lookup, is there a linear search through all sepol_objects to
> find a sepol_object whose sepol_typeid is SEPOL_TYPEID_ATTRIBUTE or
> SEPOL_TYPEID_TYPE, and whose sepol_objpool's name matches the string?

At least for the initial search, yes.

> Or is there a way to ask the object pool for a matching sepol_objpool
> and from there dereference back to its sepol_object?
> 

You probably need to look at objpool.[c,h] - I think you misunderstand
their purpose. Also look at policy_check.c in the old patch set.

> Do SEPOL_TYPEID_TYPEALIAS objects represent the statement:
> 
>  typealias lib_t alias shlib_t;
> 

Yes.

> or just the symbol shlib_t?
> 

It stores both.

> > + * The hybrid strategy combines both preorder and postorder
> > + * traversal. This means that each parent node will be visited twice:
> > + * once before its children are traversed and once afterward. The
> > + * second traversal can be detected by checking the flag indicating
> > + * that the parent has been visited (see sepol_parent_isvisited).
> > + */
> 
> It is unclear why a hybrid traversal is needed, from the public API's
> point of view.
> 

There is no way to easily track the level in the tree without seeing
both the opening and closing of a parent - hence the hybrid traversal
strategy. I think that information is generally useful.

> > + * Traverse a policy tree using parent as the root node of the tree. The traversal
> > + * strategy is controlled by sepol_parent_traverse_strategy.
> > + *
> > + * @param h sepol_handle (may be null)
> > + * @param parent sepol_parent
> > + * @param iter iterator to represent traversal state
> 
> Perhaps this should be appended with, "Iterator will be updated to point
> to the next node"?
> 

What do you mean? The iterator will be set to point to the initial node.
That is how all of the iterators work.

> > + * @param strategy traversal strategy - see sepol_parent_traverse_strategy
> > + *
> > + * \retval SEPOL_OK success
> > + * \retval SEPOL_ENOMEM out of memory
> > + */
> > +extern int sepol_parent_traverse(struct sepol_handle *h, struct sepol_parent *parent,
> > +				 struct sepol_iter *iter, int strategy);
> 
> Should not this last parameter be an enum
> sepol_policy_traverse_strategy?
> 

Sure.

> > +char sepol_parent_isvisited(struct sepol_iter *iter);
> 
> How do you envision this function being used, from a public API's point
> of view?
> 

It is needed for the hybrid traversal to make sense - otherwise you
can't tell whether this is the opening or closing of a parent object.

> > +extern int sepol_policy_free(struct sepol_handle *h, struct sepol_policy *o);
> 
> What happens if a NULL is passed as the second parameter?

Should be a no-op. I could document it everywhere I guess, but it won't
be a priority any time soon. Feel free to send a patch.

>   Users of the
> library do not necessarily have the library's source code to consult.
> 

Of course they do - this is open source. Documentation is just a
bonus :)

> > +extern int sepol_module_create_tree(struct sepol_handle *h,
> > +				    struct sepol_module **module,
> > +				    struct sepol_parent *root);
> 
> What does the second parameter represent?  A list of sepol_module
> pointers, an out parameter to a sepol_module, or something else?

Out parameter - just liked every other create function.

>   Users
> of the library do not necessarily have the library's source code to
> consult.
> 

Again - of course they do.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
