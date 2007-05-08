Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l48GCMRH026194
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 12:12:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l48GCEvl009807
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 16:12:14 GMT
Subject: Re: [PATCH] Basic policy representation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46409BB6.7040500@manicmethod.com>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <46408CF6.1050409@manicmethod.com>
	 <1178636917.25354.28.camel@localhost.localdomain>
	 <46409BB6.7040500@manicmethod.com>
Content-Type: text/plain
Date: Tue, 08 May 2007 12:11:11 -0400
Message-Id: <1178640671.25354.49.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 11:48 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-05-08 at 10:45 -0400, Joshua Brindle wrote:
> >   
> >> Karl MacMillan wrote:
> >>     
> >
> > <snip>
> >
> >   
> >>> +enum sepol_typeid {
> >>> +	SEPOL_TYPEID_NONE, /** special typeid representing no type */
> >>> +	SEPOL_TYPEID_OBJECT, /** typeid for base class of all objects */
> >>> +	SEPOL_TYPEID_PARENT, /** typeid for base class of objects that contain other objects */
> >>> +	SEPOL_TYPEID_POLICY, /** typeid for policy object */
> >>> +	SEPOL_TYPEID_MODULE, /** typeid for the module object */
> >>> +	SEPOL_TYPEID_BLOCK, /** tyepid for the block object */
> >>> +	SEPOL_TYPEID_COND, /** typeid for the cond object */
> >>> +	SEPOL_TYPEID_OPTIONAL, /** typeid for the optional object */
> >>> +	SEPOL_TYPEID_TYPE, /** typed for the type object */
> >>> +	SEPOL_TYPEID_CLASS, /** typeid for the class object */
> >>> +	SEPOL_TYPEID_ATTRIBUTE, /** typeid for the attribute object */
> >>> +	SEPOL_TYPEID_TYPEALIAS, /** typeid for the typealias object */
> >>> +	SEPOL_TYPEID_BOOL, /** typeid for the bool object */
> >>> +	SEPOL_TYPEID_AVRULE, /** typeid for the avrule object */
> >>> +	SEPOL_TYPEID_TYPERULE, /** typeid for the typerule object */
> >>> +	SEPOL_TYPEID_SECURITY_CONTEXT, /** typeid for the securit context object */
> >>> +	SEPOL_TYPEID_ISID, /** typeid for the isid object */
> >>> +	SEPOL_TYPEID_TYPEATTRIBUTE, /** typeid for the typeattribute object */
> >>> +	SEPOL_TYPEID_COND_EXPR, /** typeid for the cond expr object */
> >>> +	SEPOL_TYPEID_SENS, /** typeid for the sends object */
> >>> +	SEPOL_TYPEID_DOMINANCE, /** typeid for the dominance object */
> >>> +	SEPOL_TYPEID_CATEGORY, /** typeid for the category object */
> >>> +	SEPOL_TYPEID_ROLE_DOMINANCE, /** typeid for the role dominance object */
> >>> +	SEPOL_TYPEID_ROLE /** typeid for the role object */
> >>> +};
> >>>   
> >>>       
> >> Do you think typeid is really a good word to use here? This is possibly 
> >> very confusing (others have already mentioned to me that it was confusing)
> >>
> >>     
> >
> > I'm fine with something else. Why is it confusing though? And what would
> > you suggest as a less confusing alternative?
> >
> >   
> 
> ILK? :P
> 

NOOOOOOO - not again!

> how about objid? Its confusing because of the use of type and id, both 
> of which are heavily used in the current compiler (and type being used 
> in selinux)
> 

The problem with objid is that it - to me - implies that it is a
per-instance identifier rather than a per-type identifier. I could
change it to classid :) Actually classid might be more consistent
overall.

Any other alternatives?

> > <snip>
> >
> >   
> >>> +char sepol_parent_isvisited(struct sepol_iter *iter);
> >>> +
> >>>   
> >>>       
> >> is it really necessary to use a char here? granted its smaller but it 
> >> also doesn't really convey to someone new to the code what is going on. 
> >> Perhaps a bool typemap? or short int?
> >>
> >>     
> >
> > Char isn't necessary, though I think it is a common idiom to use char as
> > boolean in C programs. What do you mean by typemap (typedef?). I don't
> > really think that short int is any better.
> >
> >   
> 
> oops, I meant typedef.
> 

I've worked on codebases with and without boolean typedefs and
personally prefer to not have a typedef. Any other opinions?


> >>> +int sepol_policy_create(struct sepol_handle *h, struct sepol_policy **policy)
> >>> +{
> >>> +	int ret;
> >>> +	struct sepol_policy *x;
> >>> +
> >>> +	*policy = NULL;
> >>> +	x = calloc(1, sizeof(struct sepol_policy));
> >>>   
> >>>       
> >> I am adverse to calloc used on structs, this implicitly initializes the 
> >> struct and makes it harder to update the initial state. Why not have an 
> >> explicit initializer?
> >>
> >>     
> >
> > I like calloc because you don't have to explicitly set all of the
> > members and the code tends (in my experience) to be more reliable in the
> > face of change because of this. I don't have a strong opinion though -
> > what do others think?
> >
> >   
> 
> an initializer that does memset would be just as reliable in the face of 
> change and have the additional advantage of being maintainable when 
> initial state changes.
> 

I think I'm missing something - what is the difference between malloc +
memset and calloc? And what do you mean by initializer?

> > <snip>
> >
> >   
> >>> +
> >>> +static int sepol_module_tostring(struct sepol_handle *h, struct sepol_object *object,
> >>> +				 int style, char **str)
> >>> +{
> >>> +	struct sepol_module *module = (struct sepol_module *)object;
> >>> +						
> >>> +	if (module->name == NULL || module->version == NULL)
> >>> +		return -1;
> >>> +
> >>> +	if (style == SEPOL_TOSTRING_REFPOL)
> >>> +		return asprintf(str, "policy_module(%s %s)", module->name,
> >>>   
> >>>       
> >> So we now have 2 syntaxes for policy modules? One here and one in the 
> >> lexer/parser?
> >>
> >>     
> >
> > You mean that we will have to maintain information about the syntax in 2
> > places? Sure - is there an alternative?
> >
> > <snip>
> >
> >   
> 
> It would be nice if there was a way to keep a consistent syntax between 
> these components, it may not be possible though.

I agree it would be better, but don't know of a way to do this.

>  There is a small 
> difference in this syntax and the policy source syntax, what is the 
> benefit of making them different?

What difference?

>  Won't it be more confusing when 
> looking at the serialized version from here vs. the source? I thought 
> you wanted to be able to generate source from the library for generation 
> tools like sepolgen?
> 

I'm intending that be used for policy generation - what difference are
you talking about?

> >   
> >>> +struct sepol_object
> >>> +{
> >>> +	struct sepol_object_methods *methods;
> >>> +	struct sepol_parent *parent;
> >>> +	struct sepol_objpool *strpool;
> >>> +	uint32_t sclass_typeid;
> >>>   
> >>>       
> >> What is this field? Please make it less ambiguous/confusing.
> >>
> >>     
> >
> > sclass = super class typeid. Would you prefer super_class_typeid?
> >
> >   
> 
> Still not sure what it means.

Super class means the class that this class inherits from. So
sepol_policy is inherited from sepol_parent while sepol_bool is
inherited from sepol_object. The field stores this information for
sepol_object_isinstance.

Sometimes super class is called parent class, but I wanted to avoid that
since I'm using sepol_parent to mean an object that can contain other
objects (not that I really like that term, but it works).

So - that is why I think that changing typeid to classid might be better
because this would become sclass_classid, which doesn't mix terms.

Does that clear things up? What name seems clearer?

> >
> >   
> >>> +
> >>> +hidden_proto(sepol_parent_free_tree)
> >>> +hidden_proto(sepol_parent_append)
> >>> +hidden_proto(sepol_parent_extend)
> >>> +hidden_proto(sepol_parent_extend_list)
> >>> +hidden_proto(sepol_parent_del)
> >>> +hidden_proto(sepol_parent_insert)
> >>> +hidden_proto(sepol_parent_children)
> >>> +hidden_proto(sepol_parent_get_children)
> >>> +hidden_proto(sepol_parent_traverse)
> >>> +hidden_proto(sepol_parent_isvisited)
> >>> +
> >>>   
> >>>       
> >> Hrm. IIRC hidden_proto is only needed if the function is going to be 
> >> exported from the shared library and also used internally, are these 
> >> really exported? I didn't see any map updates with this patch.
> >>
> >>     
> >
> > They should have been exported - I thought there was a glob in the map
> > general enough to catch them. I've updated the map.
> >
> >   
> 
> So this is the new exported API?

Yes.

>  I'd like to see what the intentions for 
> the shared API are going to be since its going to have to be stable for 
> the foreseeable future.
> 

My plan is to export things that look very much like sepol_policy and
sepol_module. If you look at sepol_bool and the changes I have made in
this patch set you can see how I'm making those APIs match. The next
patch will be for sepol_bool, so you can see how I reconcile those APIs
(though there is still a need to break compatibility slightly).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
