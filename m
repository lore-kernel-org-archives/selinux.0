Message-ID: <48C71A96.2030408@ak.jp.nec.com>
Date: Wed, 10 Sep 2008 09:53:42 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: BUGREPORT: A type alias of invisible primary one
References: <48C66197.7050102@ak.jp.nec.com> <48C6B3E1.5030900@manicmethod.com>
In-Reply-To: <48C6B3E1.5030900@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------030609080007000404040106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030609080007000404040106
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> I found a strange type_datum_t object which has 0 for its s.value
>> during development of new type hierarchy checks.
>>
>> The strange one is "xguest_javaplugin_default_xproperty_t" which
>> is an alias type of "xguest_javaplugin_xproperty_t".
>>
>> I doubted my patch at first, but it can be reproduced on the normal
>> libsepol. It seems to me an original matter which is not exposed yet,
>> and I am innocence. :-)
>>
>> During tracing the matter, I noticed the primary type is invisible
>> at expand_module(), but the aliased one is visible. It can make the
>> strange type_datum_t object.
>>
>> * at the expand_module()
>> 1. The expand_state_t which includes typemap is initialized.
>>
>> 2. The type_copy_callback is invoked for any types via hashtab_map.
>>    It only copies primary and visible types into newer hashtab,
>>    and set up typemap to translate between old and new s.value.
>>    Thus, the given primary type is invisible, its slot of typemap
>>    is kept to zero.
>>    (*) is_id_enabled() for "xguest_javaplugin_xproperty_t" returned false.
>>
>> 3. The alias_copy_callback is invoked for any types via hashtab_map.
>>    It only copies alias and visible types into newer hashtab.
>>    Here is no check whether the primary side is visible, or not.
>>    A copied type_datum_t object for the given alias has new s.value
>>    which is picked up from state->typemap.
>>
>> 4. However, the target slot of state->typemap was zero, because
>>    its primary one is invisible. The aliased type has a strange
>>    s.value.
>>
>> 5. Type hierarchy checks got a segmentation fault, due to
>>    "p->type_val_to_name[datum->s.value - 1]".
>>                         ^^^^^^^^^^^^^^^^^^ == -1
>> Yes, we can identify cause of the matter.
> 
> Do you have a policy that can be used to reproduce this?

Yes, the following policy can reproduce the matter.
- - - - [ cut here ] - - - -
policy_module(baz, 1.0)

optional_policy(`
        gen_require(`
                type invisible_primary_t;
        ')
        typealias invisible_primary_t alias visible_alias_t;
')
- - - - - - - - - - - - - - -

The attached patch can inject some of printf()'s.
You can see that invisible_primary_t is skipped at type_copy_callback()
and an incorrect s.value is assigned at alias_copy_callback().

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------030609080007000404040106
Content-Type: text/x-patch;
 name="libsepol-debugging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-debugging.patch"

Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c	(revision 2950)
+++ libsepol/src/expand.c	(working copy)
@@ -90,6 +90,8 @@
 	}
 	if (!is_id_enabled(id, state->base, SYM_TYPES)) {
 		/* identifier's scope is not enabled */
+		INFO(state->handle, "type %s is skipped (s.value=%u primary=%u)",
+		     (char *)key, type->s.value, type->primary);
 		return 0;
 	}
 
@@ -516,6 +518,14 @@
 
 	new_alias->flags = alias->flags;
 
+	if (!new_alias->s.value) {
+		INFO(state->handle, "strange alias type : "
+		     "%s (a.value=%u, primary=%u, flavor=%u)"
+		     " => (a.value=%u, primary=%u, flavor=%u)",
+		     (char *) key, alias->s.value, alias->primary, alias->flavor,
+		     new_alias->s.value, new_alias->primary, new_alias->flavor);
+	}
+
 	ret = hashtab_insert(state->out->p_types.table,
 			     (hashtab_key_t) new_id,
 			     (hashtab_datum_t) new_alias);
Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2950)
+++ libsepol/src/write.c	(working copy)
@@ -952,6 +952,12 @@
 
 	typdatum = (type_datum_t *) datum;
 
+	if (!typdatum->s.value) {
+		printf("%s: strange type %s (s.value=%u, primary=%u, flavor=%u)\n",
+		       __FUNCTION__, (char *)key, typdatum->s.value,
+		       typdatum->primary, typdatum->flavor);
+	}
+
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);

--------------030609080007000404040106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
