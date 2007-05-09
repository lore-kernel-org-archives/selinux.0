Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49NR0k9021133
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 19:27:00 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49NQwE8010550
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 23:26:59 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "J. Tang" <jtang@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1178750819.5665.100.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <1178735753.5665.38.camel@localhost.localdomain>
	 <1178738540.2951.16.camel@localhost.localdomain>
	 <1178750819.5665.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 19:26:57 -0400
Message-Id: <1178753217.21282.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 18:46 -0400, J. Tang wrote:
> On Wed, 2007-05-09 at 15:22 -0400, Karl MacMillan wrote: 
> > > 1. What about aliases for categories and levels?
> > Not certain what you are asking.
> 
> Categories and levels can have aliases.  Is this addressed?
> 

Not yet.

> > Requires are going to be removed entirely - I thought that this had 
> 
> Current modules have requirements.  If it is true that policyrep must be
> able to accept all existing policies, then there must be some way to
> represent module requirements.
> 

I don't see why - the import function will just create the bare rules
and declarations and the normal resolution functions can work. The
requirements would just be thrown out.

> > No - permissions will just be strings. There must be some
> > misunderstanding as this question makes no sense to me.
> 
> Does this mean:
> 
>   allow A B : C d;
>   allow x y : z d;
> 
> will have two instances within memory of the string "d"?
> 

Perhaps - it depends on whether there is a string pool at the root of
the tree the object is in. If there is a string pool, however, there
will only be one instance.

> > > For each
> > > string lookup, is there a linear search through all sepol_objects to
> > > find a sepol_object whose sepol_typeid is SEPOL_TYPEID_ATTRIBUTE or
> > > SEPOL_TYPEID_TYPE, and whose sepol_objpool's name matches the
> > string?
> > At least for the initial search, yes.
> 
> This does not seem correct.  Given the following:
> 
> optional {
>   typealias a alias b;
> }
> 
> optional {
>   type a;
>   allow a x : y z;  # type x is never declared anywhere
> }
> 
> It appears that the proposed algorithm will incorrectly mark the first
> optional's requirements as being met.
> 

What makes you conclude that? The algorithm will still have to correctly
resolve dependencies - there is nothing about the tree structure
preventing that.

> > > Do SEPOL_TYPEID_TYPEALIAS objects represent the statement:
> > >  typealias lib_t alias shlib_t;
> > Yes.
> > > or just the symbol shlib_t?
> > It stores both.
> 
> In the statement:
> 
>   type A alias {B C D E F};
> 
> will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just one?
> 

The code I posted for comments would create 0 - you would just have a
type declaration. The goal is to represent the policy in the same
structure as the source - it helps for policy generation.

> > There is no way to easily track the level in the tree without seeing
> > both the opening and closing of a parent - hence the hybrid traversal
> > strategy. I think that information is generally useful.
> 
> Why does a public user of this API need to track levels?  If a user
> really wanted to know at what level a node is, he could always walk up
> the tree by way of the node's parent.
> 

If you want to print out the tree structure you need this. Is there some
reason to not export this?

> > > > +extern int sepol_module_create_tree(struct sepol_handle *h,
> > > > +				    struct sepol_module **module,
> > > > +				    struct sepol_parent *root);
> > > What does the second parameter represent?  A list of sepol_module
> > > pointers, an out parameter to a sepol_module, or something else?
> > Out parameter - just liked every other create function.
> 
> Function prototypes such as these may be difficult to wrap via SWIG.
> 

Why? What is going to be harder is to always convert sepol_object and
sepol_parent to the most specific type when returned I think. That and
mapping the iterators to python iterators.

I'm considering wrapping by hand if it will make the python code more
idiomatic.

> > +const char *sepol_typeid_tostring(int typeid)
> 
> Should not this take an enum sepol_typeid instead?
> 

Yes.

> > +uint32_t sepol_object_get_typeid(struct sepol_object *o)
> 
> Why does this return a uint32_t, sepol_typeid_tostring() take a signed
> integer, and type identifiers are declared as an enumeration?
> 

Because they will end up being serialized and sent over the wire. This
function will make certain that the ids can be represented as a uint32
if necessary.

> > +char sepol_object_isinstance(struct sepol_object *o, uint32_t typeid)
> 
> Ibid.
> 

Changed.

> > +int sepol_object_tostring(struct sepol_handle *h, struct sepol_object
> *o,
> > +			  int style, char **str)
> 
> Should not the third parameter be of type enum sepol_tostring_style?
> 

Changed.

> It would be convenient if the debugging style were to report line
> numbers and the name of the module from which the object originated.
> Where within the proposed design are line numbers and filenames stored?
> 

Nowhere yet - send patches.

> > + * Insert a child object into the list of children for the
> > + * sepol_parent. See sepol_list_insert for more information on the
> > + * semantics of this insert.
> > + *
> > + * @param h sepol_handle (may be NULL)
> > + * @param p sepol_parent to which to insert child object
> > + * @param iter iterator representing the position to insert the child
> object
> > + * @param o child object to insert
> 
> It is unclear by the given documentation if the given iterator should
> point to the parent or to a location within the parent node's children.
> 

Point within parents list of children.

> Where within the proposed design are order dependent statements
> recorded?  Given the string MLS level "a:b.c", how are the actual
> categories determined?
> 

I haven't finished the MLS portion - feel free to start on that if you
want.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
