Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49MkTAt019493
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 18:46:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l49MkRTv020664
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 22:46:27 GMT
Subject: Re: [PATCH] Basic policy representation
From: "J. Tang" <jtang@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1178738540.2951.16.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <1178735753.5665.38.camel@localhost.localdomain>
	 <1178738540.2951.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 18:46:58 -0400
Message-Id: <1178750819.5665.100.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 15:22 -0400, Karl MacMillan wrote: 
> > 1. What about aliases for categories and levels?
> Not certain what you are asking.

Categories and levels can have aliases.  Is this addressed?

> Requires are going to be removed entirely - I thought that this had 

Current modules have requirements.  If it is true that policyrep must be
able to accept all existing policies, then there must be some way to
represent module requirements.

> No - permissions will just be strings. There must be some
> misunderstanding as this question makes no sense to me.

Does this mean:

  allow A B : C d;
  allow x y : z d;

will have two instances within memory of the string "d"?

> > For each
> > string lookup, is there a linear search through all sepol_objects to
> > find a sepol_object whose sepol_typeid is SEPOL_TYPEID_ATTRIBUTE or
> > SEPOL_TYPEID_TYPE, and whose sepol_objpool's name matches the
> string?
> At least for the initial search, yes.

This does not seem correct.  Given the following:

optional {
  typealias a alias b;
}

optional {
  type a;
  allow a x : y z;  # type x is never declared anywhere
}

It appears that the proposed algorithm will incorrectly mark the first
optional's requirements as being met.

> > Do SEPOL_TYPEID_TYPEALIAS objects represent the statement:
> >  typealias lib_t alias shlib_t;
> Yes.
> > or just the symbol shlib_t?
> It stores both.

In the statement:

  type A alias {B C D E F};

will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just one?

> There is no way to easily track the level in the tree without seeing
> both the opening and closing of a parent - hence the hybrid traversal
> strategy. I think that information is generally useful.

Why does a public user of this API need to track levels?  If a user
really wanted to know at what level a node is, he could always walk up
the tree by way of the node's parent.

> > > +extern int sepol_module_create_tree(struct sepol_handle *h,
> > > +				    struct sepol_module **module,
> > > +				    struct sepol_parent *root);
> > What does the second parameter represent?  A list of sepol_module
> > pointers, an out parameter to a sepol_module, or something else?
> Out parameter - just liked every other create function.

Function prototypes such as these may be difficult to wrap via SWIG.

> +const char *sepol_typeid_tostring(int typeid)

Should not this take an enum sepol_typeid instead?

> +uint32_t sepol_object_get_typeid(struct sepol_object *o)

Why does this return a uint32_t, sepol_typeid_tostring() take a signed
integer, and type identifiers are declared as an enumeration?

> +char sepol_object_isinstance(struct sepol_object *o, uint32_t typeid)

Ibid.

> +int sepol_object_tostring(struct sepol_handle *h, struct sepol_object
*o,
> +			  int style, char **str)

Should not the third parameter be of type enum sepol_tostring_style?

It would be convenient if the debugging style were to report line
numbers and the name of the module from which the object originated.
Where within the proposed design are line numbers and filenames stored?

> + * Insert a child object into the list of children for the
> + * sepol_parent. See sepol_list_insert for more information on the
> + * semantics of this insert.
> + *
> + * @param h sepol_handle (may be NULL)
> + * @param p sepol_parent to which to insert child object
> + * @param iter iterator representing the position to insert the child
object
> + * @param o child object to insert

It is unclear by the given documentation if the given iterator should
point to the parent or to a location within the parent node's children.

Where within the proposed design are order dependent statements
recorded?  Given the string MLS level "a:b.c", how are the actual
categories determined?

-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
