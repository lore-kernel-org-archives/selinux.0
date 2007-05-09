Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49IZNsW006605
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 14:35:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l49IZM4U025024
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 18:35:22 GMT
Subject: Re: [PATCH] Basic policy representation
From: "J. Tang" <jtang@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 14:35:53 -0400
Message-Id: <1178735753.5665.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-07 at 18:06 -0400, Karl MacMillan wrote:
> +/**
> + * \ingroup sepol_policy
> + *
> + * Every type in the policy object system is identified
> + * by a numberic typeid.
> + */

There seems to be some things missing from this enumeration.  What about
common object classes, users, (role) allow, constraints, validate
transitions, and range transitions?

>From the code you posted, I was unable to determine a few things.  How
do you plan on handling these situations?

1. What about aliases for categories and levels?
2. How does this differentiate between symbols declared versus symbols
required within modules?  Recall that modules can have require
statements currently.
3. How does this differentiate between symbols declared versus symbols
required within optional blocks?
4. What are the steps to determine if all of a module's dependencies
have been met?
5. If all strings are being stored in the object pool, does that also
mean permissions are instances of sepol_objpool as well?  
6. Where is the definition of struct sepol_objpool?

It is unclear how semantic analysis and code generation will operate.
For example, how does one determine if the strings within the source of
an AV allow rule are valid attributes, types, or aliases?  For each
string lookup, is there a linear search through all sepol_objects to
find a sepol_object whose sepol_typeid is SEPOL_TYPEID_ATTRIBUTE or
SEPOL_TYPEID_TYPE, and whose sepol_objpool's name matches the string?
Or is there a way to ask the object pool for a matching sepol_objpool
and from there dereference back to its sepol_object?

Do SEPOL_TYPEID_TYPEALIAS objects represent the statement:

 typealias lib_t alias shlib_t;

or just the symbol shlib_t?

> + * The hybrid strategy combines both preorder and postorder
> + * traversal. This means that each parent node will be visited twice:
> + * once before its children are traversed and once afterward. The
> + * second traversal can be detected by checking the flag indicating
> + * that the parent has been visited (see sepol_parent_isvisited).
> + */

It is unclear why a hybrid traversal is needed, from the public API's
point of view.

> + * Traverse a policy tree using parent as the root node of the tree. The traversal
> + * strategy is controlled by sepol_parent_traverse_strategy.
> + *
> + * @param h sepol_handle (may be null)
> + * @param parent sepol_parent
> + * @param iter iterator to represent traversal state

Perhaps this should be appended with, "Iterator will be updated to point
to the next node"?

> + * @param strategy traversal strategy - see sepol_parent_traverse_strategy
> + *
> + * \retval SEPOL_OK success
> + * \retval SEPOL_ENOMEM out of memory
> + */
> +extern int sepol_parent_traverse(struct sepol_handle *h, struct sepol_parent *parent,
> +				 struct sepol_iter *iter, int strategy);

Should not this last parameter be an enum
sepol_policy_traverse_strategy?

> +char sepol_parent_isvisited(struct sepol_iter *iter);

How do you envision this function being used, from a public API's point
of view?

> +extern int sepol_policy_free(struct sepol_handle *h, struct sepol_policy *o);

What happens if a NULL is passed as the second parameter?  Users of the
library do not necessarily have the library's source code to consult.

> +extern int sepol_module_create_tree(struct sepol_handle *h,
> +				    struct sepol_module **module,
> +				    struct sepol_parent *root);

What does the second parameter represent?  A list of sepol_module
pointers, an out parameter to a sepol_module, or something else?  Users
of the library do not necessarily have the library's source code to
consult.

-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
