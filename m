Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49GOa4l032326
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 12:24:36 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49GOX4U029493
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 16:24:33 GMT
Subject: Re: [PATCH] Basic policy representation
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d6ClzFXfAU9WCUfX/FOI"
Date: Wed, 09 May 2007 12:24:30 -0400
Message-Id: <1178727870.12294.58.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-d6ClzFXfAU9WCUfX/FOI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-07 at 18:06 -0400, Karl MacMillan wrote:
> Add support for the basic policy object model and the sepol_policy
> and sepol_module objects to libsepol. This version has significant
> changes from the last posted version:
>=20
> 1) sepol_handle is passed everywhere
> 2) public and private interfaces to the object system are correctly
>    split (into policy.[c,h] and policy_internal.[c,h].
> 3) object ouput has been converted from writing to a FILE to returning
>    allocated strings. This will help integrate better with scripting
>    languages.
> 4) Basic documentation is included for the base objects.
> 5) Enums are used instead of defines - this is a change from the style
>    for libsepol, but it makes documenting the enums much easier.

 One idiom that is often used is:

enum {
 FOO =3D 0,
#define FOO FOO
[...]
};


> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> ---
>=20
> 7 files changed, 1667 insertions(+), 4 deletions(-)
> libsepol/include/sepol/policy.h |  522 +++++++++++++++++++++++++++++++
> libsepol/src/policy.c           |  638 ++++++++++++++++++++++++++++++++++=
+++++
> libsepol/src/policy_internal.c  |  102 ++++++
> libsepol/src/policy_internal.h  |  269 ++++++++++++++++
> libsepol/tests/libsepol-tests.c |   10=20
> libsepol/tests/test-policy.c    |  118 +++++++
> libsepol/tests/test-policy.h    |   12=20

[...]

> diff -r cacdf4377ebf -r bd4ee6e00a63 libsepol/src/policy.c
> --- a/libsepol/src/policy.c	Mon May 07 15:50:27 2007 -0400
> +++ b/libsepol/src/policy.c	Mon May 07 18:03:03 2007 -0400
> +/*
> + * SEPOL_OBJECT
> + */
> +
> +static char *typeid_strings[] =3D {
> +	"none",
[...]
> +	"role"
> +};
> +
> +const char *sepol_typeid_tostring(int typeid)
> +{
> +	assert(typeid < sizeof(typeid_strings));

 This assert is wrong.

> +	return typeid_strings[typeid];
> +}
> +hidden_def(sepol_typeid_tostring)
> +
> +int sepol_object_free(struct sepol_handle *h, struct sepol_object *o)
> +{
> +	assert(o->methods->free);
> +
> +	return o->methods->free(h, o);
> +}
> +hidden_def(sepol_object_free)

 Personally I find it's almost always a good idea to retain the
semantics of free(NULL) in free'ing functions (as it often cleans up the
deallocation paths).

> +#define SEPOL_STRPOOL_SIZE 64
> +int sepol_object_create_strpool(struct sepol_handle *h, struct sepol_obj=
ect *o)
> +{
> +	int ret;
> +
> +	ret =3D sepol_objpool_create(h, &o->strpool, (sepol_objpool_hash_t)sepo=
l_symhash,
> +				   (sepol_objpool_cmp_t)sepol_symcmp, free,
> +				   SEPOL_STRPOOL_SIZE);
> +	ret_check(ret);
> +	o->flags |=3D SEPOL_OBJECT_STRPOOL_OWNER;
> +=09
> +	return ret;
> +}
> +hidden_def(sepol_object_create_strpool)
> +
> +struct sepol_objpool *sepol_object_get_strpool(struct sepol_object *o)
> +{
> +	return o->strpool;
> +}
> +hidden_def(sepol_object_get_strpool)
> +
> +char sepol_object_is_strpool_owner(struct sepol_object *o)
> +{
> +	return (o->flags & SEPOL_OBJECT_STRPOOL_OWNER) !=3D 0;
> +}
> +hidden_def(sepol_object_is_strpool_owner)

 This confused me, why would the base call for all objects need a
strpool?

> +
> +uint32_t sepol_object_get_typeid(struct sepol_object *o)
> +{
> +	return o->typeid;
> +}
> +hidden_def(sepol_object_get_typeid)
> +
> +char sepol_object_isinstance(struct sepol_object *o, uint32_t typeid)
> +{
> +	if (o->typeid =3D=3D typeid || o->sclass_typeid =3D=3D typeid)
> +		return 1;
> +	else return 0;
> +}
> +hidden_def(sepol_object_isinstance)

 You can only have one layer of inheritance?

> +struct sepol_parent *sepol_object_get_parent(struct sepol_object *o)
> +{
> +	return o->parent;
> +}
> +hidden_def(sepol_object_get_parent)
> +
> +int sepol_object_tostring(struct sepol_handle *h, struct sepol_object *o=
,
> +			  int style, char **str)
> +{

 Why don't you just return the string?

> +	if (o->methods->tostring) {
> +		return o->methods->tostring(h, o, style, str);
> +	} else {
> +		if (style =3D=3D SEPOL_TOSTRING_DEBUG) {
> +			return asprintf(str, "[sepol_object(%s) at %p]",
> +					sepol_typeid_tostring(o->typeid), o);
> +		}

 Given that sepol_typeid_tostring() can/is being called as above, it
seems like a bad idea to just return allocaed memory here.
 The obvious fix is to save the result into o->store_tostring ...
free()'ing that when the object is destroyed, or _tostring is called
again (although possibly just re-using it, for a speed benefit, might be
worthwhile).

> +	=09
> +		/* Even though we are returning an empty string, we still
> +		 * need to allocated an empty string to return. This
> +		 * matches the behavior of asprintf.
> +		 */
> +		*str =3D strdup("");
> +		if (*str =3D=3D NULL)
> +			return -1;
> +		return 0;
> +	}
> +}
> +hidden_def(sepol_object_tostring)
> +
> +int sepol_object_tostring_close(struct sepol_handle *h, struct sepol_obj=
ect *o,
> +				int style, char **str)
> +{
> +	if (o->methods->tostring_close) {
> +		return o->methods->tostring_close(h, o, style, str);
> +	} else {
> +		if (style =3D=3D SEPOL_TOSTRING_DEBUG) {
> +			return asprintf(str, "[close: sepol_object(%s) at %p]",
> +					sepol_typeid_tostring(o->typeid), o);
> +		}
> +
> +		/* Even though we are returning an empty string, we still
> +		 * need to allocated an empty string to return. This
> +		 * matches the behavior of asprintf.
> +		 */
> +		*str =3D strdup("");
> +		if (*str =3D=3D NULL)
> +			return -1;
> +		return 0;
> +	}=09
> +}
> +hidden_def(sepol_object_tostring_close)
> +
> +/*
> + * SEPOL_PARENT
> + */
> +
> +int sepol_parent_free_tree(struct sepol_handle *h, struct sepol_parent *=
p)
> +{
> +	int ret;
> +	struct sepol_iter *iter;
> +	struct sepol_object *cur;
> +
> +	ret =3D sepol_iter_create(h, &iter);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D sepol_parent_traverse(h, p, iter, SEPOL_TRAVERSE_POSTORDER);
> +	if (ret < 0)
> +		goto out;
> +
> +	sepol_foreach(h, ret, cur, iter) {
> +		int ret2;
> +		char *str;
> +		ret2 =3D sepol_object_tostring(h, cur, SEPOL_TOSTRING_DEBUG, &str);
> +		assert(ret2 >=3D 0);

 ret2 is malloc()'d data.

> +		printf("freeing %s", str);

 printf??

> +		sepol_object_free(h, cur);
> +		free(str);
> +	}
> +	if (ret !=3D SEPOL_ITERSTOP)
> +		goto out;
> +
> +	ret =3D SEPOL_OK;
> +out:
> +	sepol_iter_free(h, iter);
> +	return ret;
> +}
> +hidden_def(sepol_parent_free_tree)
> +
> +int sepol_parent_append(struct sepol_handle *h, struct sepol_parent *p, =
struct sepol_object *o)
> +{
> +	if (o->parent)
> +		return SEPOL_EEXIST;
> +	o->parent =3D p;
> +	return sepol_list_append(h, p->children, o);
> +}

 This seems like a bad name, the task you are really doing is "attaching
a parent to an object" not "appending a child to a parent". Also what
happens if list_append() fails ... ->parent is set, how can you recover?

> +hidden_def(sepol_parent_append)
> +
> +int sepol_parent_extend(struct sepol_handle *h, struct sepol_parent *p, =
struct sepol_iter *iter)
> +{
> +	int ret =3D SEPOL_OK;
> +	struct sepol_object *cur;
> +
> +	sepol_foreach(h, ret, cur, iter) {
> +		ret =3D sepol_parent_append(h, p, cur);

 Even if you leave it with the parent POV, I think you really want
"append one object", "append iter of objects" and "append list of
objects" to all have a prefix.

> +		if (ret < 0) {
> +			return ret;
> +		}
> +	}
> +	if (ret !=3D SEPOL_ITERSTOP) {
> +		return ret;
> +	}
> +
> +	return SEPOL_OK;
> +}
> +hidden_def(sepol_parent_extend)
> +
> +int sepol_parent_extend_list(struct sepol_handle *h, struct sepol_parent=
 *p, struct sepol_list *list)
> +{
> +	int ret;
> +	struct sepol_iter *iter;
> +
> +	ret =3D sepol_iter_create(h, &iter);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D sepol_list_begin(h, list, iter);
> +	if (ret < 0) {
> +		if (ret =3D=3D SEPOL_ITERSTOP)
> +			return SEPOL_OK;
> +		else
> +			return ret;
> +	}
> +	ret =3D sepol_parent_extend(h, p, iter);
> +	sepol_iter_free(h, iter);
> +
> +	return ret;
> +}
> +hidden_def(sepol_parent_extend_list)
> +
> +int sepol_parent_del(struct sepol_handle *h, struct sepol_parent *p, str=
uct sepol_iter *iter)
> +{
> +	struct sepol_object *o;
> +	o =3D (struct sepol_object*)sepol_iter_get_data(h, iter);
> +	if (!o) {
> +		ERR(h, "error getting object from iterator");
> +		return SEPOL_ERR;
> +	}
> +	o->parent =3D NULL;
> +	return sepol_list_del(h, p->children, iter);
> +}

 sepoll_list_del can't fail here, right?

> +hidden_def(sepol_parent_del)
> +
> +int sepol_parent_insert(struct sepol_handle *h, struct sepol_parent *p,
> +			struct sepol_iter *iter, struct sepol_object *o)
> +{
> +	if (o->parent)
> +		return SEPOL_EEXIST;
> +	o->parent =3D p;
> +	=09
> +	return sepol_list_insert(h, p->children, iter, o);
> +}
> +hidden_def(sepol_parent_insert)

 Why do you have insert and append? Dito problem if list_insert fails.

> +
> +int sepol_parent_children(struct sepol_handle *h, struct sepol_parent *p=
, struct sepol_iter *iter)
> +{
> +	return sepol_list_begin(h, p->children, iter);
> +}
> +hidden_def(sepol_parent_children)

 Putting something to do with "iter" in the name would probably be a
good idea.

> +struct sepol_list *sepol_parent_get_children(struct sepol_parent *parent=
)
> +{
> +	return parent->children;
> +}
> +hidden_def(sepol_parent_get_children)
> +
> +
> +struct sepol_parent_traverse_state
> +{
> +	int strategy;
> +	char cur_flags;
> +	struct sepol_list *stack;
> +	void *object;
> +};
> +
> +static void *sepol_parent_iter_get_data(struct sepol_handle *h, struct s=
epol_iter *iter)
> +{
> +	struct sepol_parent_traverse_state *state;
> +=09
> +	assert(iter);

 Is it possible to use the GCC nonnull attributes? It also seems really
bizarre how much sepol_handle is passed around but never used.

> +	state =3D (struct sepol_parent_traverse_state*)
> +		sepol_iter_get_state(iter);
> +	assert(state);
> +
> +	return state->object;
> +}
> +
> +static int sepol_parent_iter_free(struct sepol_handle *h, void *data)
> +{
> +	struct sepol_parent_traverse_state *state =3D=20
> +		(struct sepol_parent_traverse_state*)data;

 You don't need the cast in C, only in C++.

> +static int sepol_policy_tostring(struct sepol_handle *h,=20
> +				 struct sepol_object * object __attribute__ ((unused)),
> +				 int style, char **str)
> +{
> +	if (style =3D=3D SEPOL_TOSTRING_DEBUG) {
> +		return asprintf(str, "POLICY {");
> +	} else {
> +		*str =3D strdup("");
> +		if (*str)
> +			return 0;
> +		else
> +			return -1;
> +	}
> +}
> +
> +static int sepol_policy_tostring_close(struct sepol_handle *h __attribut=
e__ ((unused)),
> +				       struct sepol_object *object __attribute__ ((unused)),
> +				       int style, char **str)
> +{
> +	if (style =3D=3D SEPOL_TOSTRING_DEBUG) {
> +		return asprintf(str, "POLICY {");

 =3D=3D strdup

> +	} else {
> +		*str =3D strdup("");
> +		if (*str)
> +			return 0;
> +		else
> +			return -1;
> +	}
> +}

[...]
> +/* Internal structs and functions for the policy object system. In
> + * general, policy objects cannot be created outside of the libsepol
> + * tree. It is possible, but not currently implemented, so there is
> + * quite a lot of internals in this header.
> + *
> + * One of the goals of this object system is to allow polymorphic
> + * methods. That will allow calling , for example, sepol_object_free
> + * on _any_ subclass of sepol_object and have the correct function
> + * called for the specific subclass. This polymorphism is implemented
> + * using an sepol_object_method struct for each class and a pointer to
> + * that struct held in each object instance.
> + *
> + * A subclass is expected to create an sepol_object_methods struct
> + * containing function pointers for the methods that it implements (it
> + * is valid for some of the function pointers to be NULL). Every
> + * instance of an sepol_object object holds a pointer to a single
> + * methods struct - i.e., there is only one struct per class and every
> + * instance holds a pointer to that struct.
> + *
> + * See sepol_object_init for how this pointer is set and sepol_object_fr=
ee
> + * for how subclass methods are called.
> + */
> +
> +/* sepol_object_free_t is the type for the free method used in the polic=
y
> + * object system. Implementations of this method should free all of the
> + * memory associated with the object including the struct.
> + */
> +typedef int (*sepol_object_free_t)(struct sepol_handle *h, struct sepol_=
object *o);
> +typedef int (*sepol_object_tostring_t)(struct sepol_handle *h, struct se=
pol_object *o,
> +				       int style, char **str);
> +
> +struct sepol_object_methods
> +{
> +        sepol_object_free_t free;
> +        sepol_object_tostring_t tostring;
> +        sepol_object_tostring_t tostring_close;
> +};
> +
> +#define SEPOL_OBJECT_STRPOOL_OWNER   1
> +#define SEPOL_OBJECT_VISITED         2
> +struct sepol_object
> +{
> +	struct sepol_object_methods *methods;
> +	struct sepol_parent *parent;
> +	struct sepol_objpool *strpool;
> +	uint32_t sclass_typeid;
> +	uint32_t typeid;
> +	uint32_t lineno;
> +	char flags;

 using char here seems iffy, the compiler is almost certainly going to
expand to uint size anyway due to padding.

> +};
> +
> +/* Private initialization function for all objects. This function only
> + * initializes the generic object properties - the type specific creatio=
n
> + * function is responsible for initializing any type specific properties=
.
> + * If this function fails it will clean up any memory that it allocated.=
 The
> + * calling function is responsible for any type specific memory and for =
freeing
> + * the object struct.
> + *
> + * params:
> + *  o - object to initialize
> + *  typeid - typeid of o
> + *  methods - pointer to sepol_object_methods struct for this type. Shou=
ld
> + *   be a pointer to a single static struct for all instances of this ty=
pe.
> + *  root - root of the policy tree of which o is a member (may be NULL).=
 If
> + *    the root is non-NULL and has a string pool then that string pool i=
s
> + *    used for this object.
> + */
> +int intern_sepol_object_init(struct sepol_handle *h, struct sepol_object=
 *o, uint32_t typeid,
> +			     struct sepol_object_methods *methods, struct sepol_parent *root)=
;
> +
> +/* Free any memory associated with the super class. This should be calle=
d
> + * from a type specific free function.
> + */
> +void intern_sepol_object_free(struct sepol_object *o);
> +
> +/* Add a string to the string pool of the object. After a call to this
> + * function the str pointer will point to the correct (and possibly
> + * shared) version of the string to use.
> + */
> +#define intern_sepol_object_addstr(h, o, str) _intern_sepol_object_addst=
r(h, SEPOL_OBJECT(o), str)
> +int _intern_sepol_object_addstr(struct sepol_handle *h, struct sepol_obj=
ect *o, char **str);
> +
> +/* Delete a string. If the object has a string pool the memory
> + * associated with the string may not be released
> + * immediately. Regardless, the caller should assume that the pointer
> + * is invalid after a call to this function.
> + */
> +#define intern_sepol_object_delstr(h, o, str) _intern_sepol_object_delst=
r(h, SEPOL_OBJECT(o), str)
> +int _intern_sepol_object_delstr(struct sepol_handle *h, struct sepol_obj=
ect *o, char *str);
> +
> +hidden_proto(sepol_typeid_tostring)
> +hidden_proto(sepol_object_free)
> +hidden_proto(sepol_object_create_strpool)
> +hidden_proto(sepol_object_get_strpool)
> +hidden_proto(sepol_object_is_strpool_owner)
> +hidden_proto(sepol_object_get_typeid)
> +hidden_proto(sepol_object_isinstance)
> +hidden_proto(sepol_object_get_parent)
> +hidden_proto(sepol_object_tostring)
> +hidden_proto(sepol_object_tostring_close)
> +
> +struct sepol_parent
> +{
> +	struct sepol_object sclass;
> +	struct sepol_list *children;
> +};
> +
> +/* Initialize an sepol_parent object. Same function and general
> + * properties as intern_sepol_object_init but for parent
> + * objects. Objects should only call the init function for their
> + * immediate parent - the parent is responsible for any further
> + * chaining up the type hierarchy.
> + */
> +int intern_sepol_parent_init(struct sepol_handle *h, struct sepol_parent=
 *p, uint32_t typeid,
> +			     struct sepol_object_methods *methods, struct sepol_parent *root)=
;
> +
> +/* Internal free function for sepol_paren objects. Like the init functio=
ns
> + * this chains up the type hierarchy by call inter_sepol_object_free.
> + */
> +void intern_sepol_parent_free(struct sepol_parent *p);
> +
> +hidden_proto(sepol_parent_free_tree)
> +hidden_proto(sepol_parent_append)
> +hidden_proto(sepol_parent_extend)
> +hidden_proto(sepol_parent_extend_list)
> +hidden_proto(sepol_parent_del)
> +hidden_proto(sepol_parent_insert)
> +hidden_proto(sepol_parent_children)
> +hidden_proto(sepol_parent_get_children)
> +hidden_proto(sepol_parent_traverse)
> +hidden_proto(sepol_parent_isvisited)
> +
> +/* sepol_policy */
> +hidden_proto(sepol_policy_free)
> +hidden_proto(sepol_policy_get_mls)
> +hidden_proto(sepol_policy_set_mls)
> +
> +/* sepol_module */
> +hidden_proto(sepol_module_free)
> +hidden_proto(sepol_module_create)
> +hidden_proto(sepol_module_create_tree)
> +hidden_proto(sepol_module_set_name)
> +hidden_proto(sepol_module_get_name)
> +hidden_proto(sepol_module_set_version)
> +hidden_proto(sepol_module_get_version)
> +hidden_proto(sepol_module_set_isbase)
> +hidden_proto(sepol_module_get_isbase)
> +
> +
> +/* some convenience macros to check return values */
> +#define ret_check(ret) { if (ret < 0) return ret; }
> +#define ret_goto(ret, tag) { if (ret < 0) goto tag; }

 These are just evil, and I don't mind invisible returns in macros when
it's kind of obvious that's what they do.
 They should be in CAPS, have the "do {} while" idiom, the name isn't
great as check =3D=3D return is not obvious and you should use (ret) instea=
d
of ret. Maybe:

#define RC_FAIL_RETURN(ret)    do { if ((ret) < 0) return (ret); } while (F=
ALSE)
#define RC_FAIL_GOTO(ret, tag) do { if ((ret) < 0) goto tag; } while (FALSE=
)

...but I'm also unconvinced they help, for instance you have:

ret =3D foo();
RC_FAIL_RETURN(ret);

...instead of:

if ((ret =3D foo()) < 0)
  return (ret);

...even if you split the assignment out of the condition, it's only one
extra line ... so it doesn't seem like they are doing enough.

> +/*
> + * PROPERTY GENERATION MACROS
> + *
> + * Many of the objects are similar and will have almost identical
> + * functions for getting and setting properties. These macros generate
> + * those functions for brevity and correctness.
> + */
> +
> +/* Initialize an object set for holding strings. This should be used
> + * in an object creation function to initialize a string set. This
> + * handles object pooling.
> + */
> +#define INIT_STRSET(obj, set, ret, target) {				\
> +		if (SEPOL_OBJECT(obj)->strpool) {				\
> +			ret =3D sepol_objset_create(&obj->set, sepol_policy_ptrcmp); \
> +			ret_goto(ret, target);				\
> +		} else {						\
> +			ret =3D sepol_objset_create(&obj->set,		\
> +						  (sepol_objset_cmp_t)sepol_policy_strcmp); \
> +			ret_goto(ret, target);				\
> +		} }

 do/while idiom, plus you should combine the error handling.

> +#define DESTROY_STRSET(obj, set, iter, ret) {				\
> +		if (obj->set !=3D NULL) {					\
> +			ret =3D sepol_iter_create(&iter);			\
> +			ret_check(ret);					\
> +			ret =3D sepol_objset_iter(obj->set, iter);	\
> +			if (ret < 0 && ret !=3D SEPOL_ITERSTOP) return ret; \
> +			while (ret =3D=3D SEPOL_OK) {			\
> +				ret =3D intern_sepol_object_delstr(obj, sepol_iter_get_data(iter)); =
\
> +				ret_check(ret);				\

 Leaked the iter.

> +				ret =3D sepol_iter_next(iter);		\
> +			}						\
> +			sepol_iter_destroy(iter);			\
> +			if (ret !=3D SEPOL_ITERSTOP) return ret;		\
> +		} \
> +		sepol_objset_destroy(obj->set); }
> +		=09
[...]
> +#define DEFINE_BOOL_PROP(obj, prop)				       \
> +#define DEFINE_UINT_PROP(obj, prop)				       \

 These two are identical apart from char/uint.

> +#define DEFINE_STRSET_PROP(obj, prop, set)				\
> +	int sepol_##obj##_add_##prop(struct sepol_##obj *x, char *prop) \
> +	{								\
> +		int ret;						\
> +		char *tmp =3D strdup(prop);				\
> +		ret =3D intern_sepol_object_addstr(x, &tmp);			\
> +		ret_check(ret);						\

 Leaked tmp, no?

> +		ret =3D sepol_objset_add(x->set, tmp);			\
> +		ret_check(ret);						\
> +		return SEPOL_OK;					\
> +	}								\
> +	hidden_def(sepol_##obj##_set_##prop)			       \
> +	struct sepol_objset *sepol_##obj##_get_##set(struct sepol_##obj *x) \
> +	{								\
> +		return x->set;						\
> +	}								\
> +	hidden_def(sepol_##obj##_get_##prop)			      =20
> +

--=20
James Antill <jantill@redhat.com>

--=-d6ClzFXfAU9WCUfX/FOI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGQfW+11eXTEMrxtQRAtUnAJ0X6puHRfm0fvAteit5RdJmlKKNaACgtHHi
Imcgam4RF2+4hcRonRgZCRk=
=yoH1
-----END PGP SIGNATURE-----

--=-d6ClzFXfAU9WCUfX/FOI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
