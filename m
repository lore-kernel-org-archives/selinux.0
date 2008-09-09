Message-ID: <48C66197.7050102@ak.jp.nec.com>
Date: Tue, 09 Sep 2008 20:44:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: selinux@tycho.nsa.gov
Subject: BUGREPORT: A type alias of invisible primary one
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found a strange type_datum_t object which has 0 for its s.value
during development of new type hierarchy checks.

The strange one is "xguest_javaplugin_default_xproperty_t" which
is an alias type of "xguest_javaplugin_xproperty_t".

I doubted my patch at first, but it can be reproduced on the normal
libsepol. It seems to me an original matter which is not exposed yet,
and I am innocence. :-)

During tracing the matter, I noticed the primary type is invisible
at expand_module(), but the aliased one is visible. It can make the
strange type_datum_t object.

* at the expand_module()
1. The expand_state_t which includes typemap is initialized.

2. The type_copy_callback is invoked for any types via hashtab_map.
   It only copies primary and visible types into newer hashtab,
   and set up typemap to translate between old and new s.value.
   Thus, the given primary type is invisible, its slot of typemap
   is kept to zero.
   (*) is_id_enabled() for "xguest_javaplugin_xproperty_t" returned false.

3. The alias_copy_callback is invoked for any types via hashtab_map.
   It only copies alias and visible types into newer hashtab.
   Here is no check whether the primary side is visible, or not.
   A copied type_datum_t object for the given alias has new s.value
   which is picked up from state->typemap.

4. However, the target slot of state->typemap was zero, because
   its primary one is invisible. The aliased type has a strange
   s.value.

5. Type hierarchy checks got a segmentation fault, due to
   "p->type_val_to_name[datum->s.value - 1]".
                        ^^^^^^^^^^^^^^^^^^ == -1
Yes, we can identify cause of the matter.

How should it be fixed on the next?
Please give me a suggestion.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
