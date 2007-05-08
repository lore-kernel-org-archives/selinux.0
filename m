Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l48Fm7m1024561
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 11:48:09 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l48Fm7Lm005775
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 15:48:07 GMT
Message-ID: <46409BB6.7040500@manicmethod.com>
Date: Tue, 08 May 2007 11:48:06 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Basic policy representation
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>	 <46408CF6.1050409@manicmethod.com> <1178636917.25354.28.camel@localhost.localdomain>
In-Reply-To: <1178636917.25354.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-05-08 at 10:45 -0400, Joshua Brindle wrote:
>   
>> Karl MacMillan wrote:
>>     
>
> <snip>
>
>   
>>> +enum sepol_typeid {
>>> +	SEPOL_TYPEID_NONE, /** special typeid representing no type */
>>> +	SEPOL_TYPEID_OBJECT, /** typeid for base class of all objects */
>>> +	SEPOL_TYPEID_PARENT, /** typeid for base class of objects that contain other objects */
>>> +	SEPOL_TYPEID_POLICY, /** typeid for policy object */
>>> +	SEPOL_TYPEID_MODULE, /** typeid for the module object */
>>> +	SEPOL_TYPEID_BLOCK, /** tyepid for the block object */
>>> +	SEPOL_TYPEID_COND, /** typeid for the cond object */
>>> +	SEPOL_TYPEID_OPTIONAL, /** typeid for the optional object */
>>> +	SEPOL_TYPEID_TYPE, /** typed for the type object */
>>> +	SEPOL_TYPEID_CLASS, /** typeid for the class object */
>>> +	SEPOL_TYPEID_ATTRIBUTE, /** typeid for the attribute object */
>>> +	SEPOL_TYPEID_TYPEALIAS, /** typeid for the typealias object */
>>> +	SEPOL_TYPEID_BOOL, /** typeid for the bool object */
>>> +	SEPOL_TYPEID_AVRULE, /** typeid for the avrule object */
>>> +	SEPOL_TYPEID_TYPERULE, /** typeid for the typerule object */
>>> +	SEPOL_TYPEID_SECURITY_CONTEXT, /** typeid for the securit context object */
>>> +	SEPOL_TYPEID_ISID, /** typeid for the isid object */
>>> +	SEPOL_TYPEID_TYPEATTRIBUTE, /** typeid for the typeattribute object */
>>> +	SEPOL_TYPEID_COND_EXPR, /** typeid for the cond expr object */
>>> +	SEPOL_TYPEID_SENS, /** typeid for the sends object */
>>> +	SEPOL_TYPEID_DOMINANCE, /** typeid for the dominance object */
>>> +	SEPOL_TYPEID_CATEGORY, /** typeid for the category object */
>>> +	SEPOL_TYPEID_ROLE_DOMINANCE, /** typeid for the role dominance object */
>>> +	SEPOL_TYPEID_ROLE /** typeid for the role object */
>>> +};
>>>   
>>>       
>> Do you think typeid is really a good word to use here? This is possibly 
>> very confusing (others have already mentioned to me that it was confusing)
>>
>>     
>
> I'm fine with something else. Why is it confusing though? And what would
> you suggest as a less confusing alternative?
>
>   

ILK? :P

how about objid? Its confusing because of the use of type and id, both 
of which are heavily used in the current compiler (and type being used 
in selinux)

> <snip>
>
>   
>>> +char sepol_parent_isvisited(struct sepol_iter *iter);
>>> +
>>>   
>>>       
>> is it really necessary to use a char here? granted its smaller but it 
>> also doesn't really convey to someone new to the code what is going on. 
>> Perhaps a bool typemap? or short int?
>>
>>     
>
> Char isn't necessary, though I think it is a common idiom to use char as
> boolean in C programs. What do you mean by typemap (typedef?). I don't
> really think that short int is any better.
>
>   

oops, I meant typedef.

> I try to use "is" in the name to indicate a boolean (and I will change
> sepol_policy_mls to sepol_policy_ismls to be consistent).
>
> <snip>
>
>   

Ok.

>>> +
>>> +static char *typeid_strings[] = {
>>> +	"none",
>>> +	"object",
>>> +	"parent",
>>> +	"policy",
>>> +	"module",
>>> +	"block",
>>> +	"cond",
>>> +	"optional",
>>> +	"type",
>>> +	"class",
>>> +	"attribute",
>>> +	"typealias",
>>> +	"boolean",
>>> +	"avrule",
>>> +	"typerule",
>>> +	"security context",
>>> +	"initial sid",
>>> +	"typeattribute",
>>> +	"conditional expression",
>>> +	"sensitivity",
>>> +	"dominance",
>>> +	"category",
>>> +	"role dominance",
>>> +	"role"
>>> +};
>>> +
>>>   
>>>       
>> It would be nice if these were in the same place as the enum so they 
>> could be updated easier, but I understand that the strings are private 
>> and the enum is exported :\
>>
>>     
>
> Yeah - and I've already screwed this up once. Unless you feel strongly,
> though, I'd prefer to leave this in the C file.
>
>   

I don't feel strongly.

> <snip>
>
>   
>>> +static int sepol_policy_tostring(struct sepol_handle *h, 
>>> +				 struct sepol_object * object __attribute__ ((unused)),
>>> +				 int style, char **str)
>>> +{
>>> +	if (style == SEPOL_TOSTRING_DEBUG) {
>>> +		return asprintf(str, "POLICY {");
>>>   
>>>       
>> Why are these strings hard coded?
>>
>>     
>
> What is the alternative? I could use defines, but I don't think it would
> help readability. Is that what you mean?
>
>   

I suppose not it wouldn't help readability much..

>>> +	} else {
>>> +		*str = strdup("");
>>> +		if (*str)
>>> +			return 0;
>>> +		else
>>> +			return -1;
>>> +	}
>>> +}
>>> +
>>> +static int sepol_policy_tostring_close(struct sepol_handle *h __attribute__ ((unused)),
>>> +				       struct sepol_object *object __attribute__ ((unused)),
>>> +				       int style, char **str)
>>> +{
>>> +	if (style == SEPOL_TOSTRING_DEBUG) {
>>> +		return asprintf(str, "POLICY {");
>>> +	} else {
>>> +		*str = strdup("");
>>> +		if (*str)
>>> +			return 0;
>>> +		else
>>> +			return -1;
>>> +	}
>>> +}
>>> +
>>> +static struct sepol_object_methods sepol_policy_methods = {
>>> +	.free = (sepol_object_free_t)sepol_policy_free,
>>> +	.tostring = sepol_policy_tostring,
>>> +	.tostring_close = sepol_policy_tostring_close
>>> +};
>>> +
>>> +int sepol_policy_create(struct sepol_handle *h, struct sepol_policy **policy)
>>> +{
>>> +	int ret;
>>> +	struct sepol_policy *x;
>>> +
>>> +	*policy = NULL;
>>> +	x = calloc(1, sizeof(struct sepol_policy));
>>>   
>>>       
>> I am adverse to calloc used on structs, this implicitly initializes the 
>> struct and makes it harder to update the initial state. Why not have an 
>> explicit initializer?
>>
>>     
>
> I like calloc because you don't have to explicitly set all of the
> members and the code tends (in my experience) to be more reliable in the
> face of change because of this. I don't have a strong opinion though -
> what do others think?
>
>   

an initializer that does memset would be just as reliable in the face of 
change and have the additional advantage of being maintainable when 
initial state changes.

> <snip>
>
>   
>>> +
>>> +static int sepol_module_tostring(struct sepol_handle *h, struct sepol_object *object,
>>> +				 int style, char **str)
>>> +{
>>> +	struct sepol_module *module = (struct sepol_module *)object;
>>> +						
>>> +	if (module->name == NULL || module->version == NULL)
>>> +		return -1;
>>> +
>>> +	if (style == SEPOL_TOSTRING_REFPOL)
>>> +		return asprintf(str, "policy_module(%s %s)", module->name,
>>>   
>>>       
>> So we now have 2 syntaxes for policy modules? One here and one in the 
>> lexer/parser?
>>
>>     
>
> You mean that we will have to maintain information about the syntax in 2
> places? Sure - is there an alternative?
>
> <snip>
>
>   

It would be nice if there was a way to keep a consistent syntax between 
these components, it may not be possible though. There is a small 
difference in this syntax and the policy source syntax, what is the 
benefit of making them different? Won't it be more confusing when 
looking at the serialized version from here vs. the source? I thought 
you wanted to be able to generate source from the library for generation 
tools like sepolgen?

>>> +#include "policy_internal.h"
>>> +
>>> +int intern_sepol_object_init(struct sepol_handle *h, struct sepol_object *o, uint32_t typeid,
>>> +			     struct sepol_object_methods *methods, struct sepol_parent *root)
>>> +{
>>> +	memset(o, 0, sizeof(struct sepol_object));
>>> +	o->sclass_typeid = SEPOL_TYPEID_OBJECT;
>>> +	o->typeid = typeid;
>>> +	o->methods = methods;
>>> +	if (root && sepol_object_get_strpool(SEPOL_OBJECT(root)))
>>> +		o->strpool = sepol_object_get_strpool(SEPOL_OBJECT(root));
>>> +	
>>> +	
>>> +	return 0;
>>> +}
>>> +
>>> +void intern_sepol_object_free(struct sepol_object *o)
>>> +{
>>> +	if (o == NULL)
>>> +		return;
>>> +
>>> +	if (o->flags & SEPOL_OBJECT_STRPOOL_OWNER)
>>> +		sepol_objpool_free(NULL, o->strpool);
>>> +}
>>> +
>>> +int _intern_sepol_object_addstr(struct sepol_handle *h, struct sepol_object *o, char **str)
>>> +{
>>> +	char *tmp;
>>> +
>>> +	tmp = strdup(*str);
>>> +	if (!tmp)
>>> +		return SEPOL_ENOMEM;
>>> +
>>> +	*str = tmp;
>>> +
>>> +	if (o->strpool) {
>>> +		*str = sepol_objpool_add(h, o->strpool, *str);
>>> +		if (!*str)
>>> +			return SEPOL_ENOMEM;
>>> +	}
>>> +
>>> +	return SEPOL_OK;
>>> +}
>>> +
>>> +int _intern_sepol_object_delstr(struct sepol_handle *h, struct sepol_object *o, char *str)
>>>   
>>>       
>> Why do some of these start with _ and others don't?
>>
>>     
>
> The two prefixed with _ have a macro in policy_internal to wrap them. It
> just does an automatic cast to SEPOL_OBJECT to make them easier to call
> from the generation macros.
>
>   

ok.

> <snip>
>
>   
>>> +
>>> +struct sepol_object_methods
>>> +{
>>> +        sepol_object_free_t free;
>>> +        sepol_object_tostring_t tostring;
>>> +        sepol_object_tostring_t tostring_close;
>>> +};
>>> +
>>> +#define SEPOL_OBJECT_STRPOOL_OWNER   1
>>> +#define SEPOL_OBJECT_VISITED         2
>>>   
>>>       
>> Why aren't these in an enum?
>>
>>     
>
> Mainly because I didn't document them so didn't think to make the
> change. The other issue is that they are bit flags - so the defines
> might be clearer. I've changed it to an enum though.
>
>   
>>> +struct sepol_object
>>> +{
>>> +	struct sepol_object_methods *methods;
>>> +	struct sepol_parent *parent;
>>> +	struct sepol_objpool *strpool;
>>> +	uint32_t sclass_typeid;
>>>   
>>>       
>> What is this field? Please make it less ambiguous/confusing.
>>
>>     
>
> sclass = super class typeid. Would you prefer super_class_typeid?
>
>   

Still not sure what it means.

> <snip>
>
>   
>>> +
>>> +hidden_proto(sepol_parent_free_tree)
>>> +hidden_proto(sepol_parent_append)
>>> +hidden_proto(sepol_parent_extend)
>>> +hidden_proto(sepol_parent_extend_list)
>>> +hidden_proto(sepol_parent_del)
>>> +hidden_proto(sepol_parent_insert)
>>> +hidden_proto(sepol_parent_children)
>>> +hidden_proto(sepol_parent_get_children)
>>> +hidden_proto(sepol_parent_traverse)
>>> +hidden_proto(sepol_parent_isvisited)
>>> +
>>>   
>>>       
>> Hrm. IIRC hidden_proto is only needed if the function is going to be 
>> exported from the shared library and also used internally, are these 
>> really exported? I didn't see any map updates with this patch.
>>
>>     
>
> They should have been exported - I thought there was a glob in the map
> general enough to catch them. I've updated the map.
>
>   

So this is the new exported API? I'd like to see what the intentions for 
the shared API are going to be since its going to have to be stable for 
the foreseeable future.

> <snip>
>
>   
>>> +
>>> +/*
>>> + * PROPERTY GENERATION MACROS
>>> + *
>>> + * Many of the objects are similar and will have almost identical
>>> + * functions for getting and setting properties. These macros generate
>>> + * those functions for brevity and correctness.
>>> + */
>>> +
>>> +/* Initialize an object set for holding strings. This should be used
>>> + * in an object creation function to initialize a string set. This
>>> + * handles object pooling.
>>>   
>>>       
>> I understand the argument for using these but its my experience that 
>> they make everything harder to understand like the libselinux macros..
>>
>>     
>
> I'd really prefer to keep them - they have already made development much
> easier. They generate a _lot_ of code that really is exactly the same.
> Also, I've already fixed bugs in the macros several times that would
> have resulted in painful changes otherwise.
>
> I understand that CPP is not particularly readable, but I think the
> alternative is worse.
>
>   
fair enough.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
