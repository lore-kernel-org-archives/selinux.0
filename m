Message-ID: <48D80358.9090207@manicmethod.com>
Date: Mon, 22 Sep 2008 16:43:04 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: BUGREPORT: A type alias of invisible primary one
References: <48C66197.7050102@ak.jp.nec.com> <48C6B3E1.5030900@manicmethod.com> <48C71A96.2030408@ak.jp.nec.com>
In-Reply-To: <48C71A96.2030408@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010405010509000303080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010405010509000303080208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>> KaiGai Kohei wrote:
>>> I found a strange type_datum_t object which has 0 for its s.value
>>> during development of new type hierarchy checks.
>>>
>>> The strange one is "xguest_javaplugin_default_xproperty_t" which
>>> is an alias type of "xguest_javaplugin_xproperty_t".
>>>
>>> I doubted my patch at first, but it can be reproduced on the normal
>>> libsepol. It seems to me an original matter which is not exposed yet,
>>> and I am innocence. :-)
>>>
>>> During tracing the matter, I noticed the primary type is invisible
>>> at expand_module(), but the aliased one is visible. It can make the
>>> strange type_datum_t object.
>>>
>>> * at the expand_module()
>>> 1. The expand_state_t which includes typemap is initialized.
>>>
>>> 2. The type_copy_callback is invoked for any types via hashtab_map.
>>>    It only copies primary and visible types into newer hashtab,
>>>    and set up typemap to translate between old and new s.value.
>>>    Thus, the given primary type is invisible, its slot of typemap
>>>    is kept to zero.
>>>    (*) is_id_enabled() for "xguest_javaplugin_xproperty_t" returned false.
>>>
>>> 3. The alias_copy_callback is invoked for any types via hashtab_map.
>>>    It only copies alias and visible types into newer hashtab.
>>>    Here is no check whether the primary side is visible, or not.
>>>    A copied type_datum_t object for the given alias has new s.value
>>>    which is picked up from state->typemap.
>>>
>>> 4. However, the target slot of state->typemap was zero, because
>>>    its primary one is invisible. The aliased type has a strange
>>>    s.value.
>>>
>>> 5. Type hierarchy checks got a segmentation fault, due to
>>>    "p->type_val_to_name[datum->s.value - 1]".
>>>                         ^^^^^^^^^^^^^^^^^^ == -1
>>> Yes, we can identify cause of the matter.
>> Do you have a policy that can be used to reproduce this?
> 
> Yes, the following policy can reproduce the matter.
> - - - - [ cut here ] - - - -
> policy_module(baz, 1.0)
> 
> optional_policy(`
>         gen_require(`
>                 type invisible_primary_t;
>         ')
>         typealias invisible_primary_t alias visible_alias_t;
> ')
> - - - - - - - - - - - - - - -
> 
> The attached patch can inject some of printf()'s.
> You can see that invisible_primary_t is skipped at type_copy_callback()
> and an incorrect s.value is assigned at alias_copy_callback().
> 
> Thanks,
> 

This should fix it. I tested with and without your patchset on a few policies. Let me know if it doesn't work for you:

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 14dc4fc..2e54177 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -478,6 +478,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	char *id, *new_id;
 	type_datum_t *alias, *new_alias;
 	expand_state_t *state;
+	uint32_t prival;
 
 	id = (char *)key;
 	alias = (type_datum_t *) datum;
@@ -491,6 +492,18 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	if (alias->flavor == TYPE_ATTRIB)
 		return 0;
 
+	if (alias->flavor == TYPE_ALIAS) 
+		prival = alias->primary;
+	else 
+		prival = alias->s.value;
+
+	if (!is_id_enabled(state->base->p_type_val_to_name[prival - 1],
+			state->base, SYM_TYPES)) {
+		/* The primary type for this alias is not enabled, the alias 
+ 		 * shouldn't be either */
+		return 0;
+	}
+		
 	if (state->verbose)
 		INFO(state->handle, "copying alias %s", id);
 

--------------010405010509000303080208
Content-Type: text/plain;
 name="alias-fix"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="alias-fix"

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9leHBhbmQuYyBiL2xpYnNlcG9sL3NyYy9leHBh
bmQuYwppbmRleCAxNGRjNGZjLi4yZTU0MTc3IDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMv
ZXhwYW5kLmMKKysrIGIvbGlic2Vwb2wvc3JjL2V4cGFuZC5jCkBAIC00NzgsNiArNDc4LDcg
QEAgc3RhdGljIGludCBhbGlhc19jb3B5X2NhbGxiYWNrKGhhc2h0YWJfa2V5X3Qga2V5LCBo
YXNodGFiX2RhdHVtX3QgZGF0dW0sCiAJY2hhciAqaWQsICpuZXdfaWQ7CiAJdHlwZV9kYXR1
bV90ICphbGlhcywgKm5ld19hbGlhczsKIAlleHBhbmRfc3RhdGVfdCAqc3RhdGU7CisJdWlu
dDMyX3QgcHJpdmFsOwogCiAJaWQgPSAoY2hhciAqKWtleTsKIAlhbGlhcyA9ICh0eXBlX2Rh
dHVtX3QgKikgZGF0dW07CkBAIC00OTEsNiArNDkyLDE4IEBAIHN0YXRpYyBpbnQgYWxpYXNf
Y29weV9jYWxsYmFjayhoYXNodGFiX2tleV90IGtleSwgaGFzaHRhYl9kYXR1bV90IGRhdHVt
LAogCWlmIChhbGlhcy0+Zmxhdm9yID09IFRZUEVfQVRUUklCKQogCQlyZXR1cm4gMDsKIAor
CWlmIChhbGlhcy0+Zmxhdm9yID09IFRZUEVfQUxJQVMpIAorCQlwcml2YWwgPSBhbGlhcy0+
cHJpbWFyeTsKKwllbHNlIAorCQlwcml2YWwgPSBhbGlhcy0+cy52YWx1ZTsKKworCWlmICgh
aXNfaWRfZW5hYmxlZChzdGF0ZS0+YmFzZS0+cF90eXBlX3ZhbF90b19uYW1lW3ByaXZhbCAt
IDFdLAorCQkJc3RhdGUtPmJhc2UsIFNZTV9UWVBFUykpIHsKKwkJLyogVGhlIHByaW1hcnkg
dHlwZSBmb3IgdGhpcyBhbGlhcyBpcyBub3QgZW5hYmxlZCwgdGhlIGFsaWFzIAorIAkJICog
c2hvdWxkbid0IGJlIGVpdGhlciAqLworCQlyZXR1cm4gMDsKKwl9CisJCQogCWlmIChzdGF0
ZS0+dmVyYm9zZSkKIAkJSU5GTyhzdGF0ZS0+aGFuZGxlLCAiY29weWluZyBhbGlhcyAlcyIs
IGlkKTsKIAo=
--------------010405010509000303080208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
