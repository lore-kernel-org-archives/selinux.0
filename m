Message-ID: <44D37216.8090902@trustedcs.com>
Date: Fri, 04 Aug 2006 11:13:10 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition statements
References: <6FE441CD9F0C0C479F2D88F959B0158832ACA7@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832ACA7@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
>>
>>Joshua Brindle wrote:
>>
>>>On Fri, 2006-07-28 at 11:13 -0400, Darrel Goeddel wrote:
>>>
>>>
>>>>Index: libsepol/include/sepol/policydb/policydb.h
>>>>===================================================================
>>>>--- libsepol/include/sepol/policydb/policydb.h  (revision 38)
>>>>+++ libsepol/include/sepol/policydb/policydb.h  (working copy)
>>>
>>>
>>>>+typedef struct range_trans_rule {
>>>>+       type_set_t stypes;
>>>>+       type_set_t ttypes;
>>>>+       class_perm_node_t *classes;     /* only class is used */
>>>>+       mls_range_t trange;
>>>>+       struct range_trans_rule *next; } range_trans_rule_t;
>>>>+
>>>
>>>
>>>Are we sure that mls_range_t is semantic enough to store 
>>
>>the rule, even
>>
>>>in a module situation where all the symbols are not present?
>>
>>Hmmm...  I assume that you have MLS requirements in mind when 
>>you say that,
>>especially the '.' notation.  The problem is that if we 
>>specify "s4:c0.c12" as
>>the range, how do we know what will be between c0 and c12 
>>(they are arbitrary
>>names).  Are you suggesting possibly storing the string and 
>>figuring the whole
>>thing out at expand time?
>>
>>We could also make sensitivity and category names 
>>non-arbitrary and force the 
>>naming convention of s# and c# ;)  Translations take care of 
>>human-readable for
>>us now...
>>
> 
> 
> I understand the desire to do this and chances are the sensitivies and
> categories in the policy will never change but I'd also like to stay
> away from hard coded policy logic (I'm sure others feel the same way). I
> think we are going to have to just store the levels as strings in the
> modular format and do sanity checks at expand time (eg., if s12-s0 is in
> a policy it will compile fine but the expander will bail). 
> 
> I'm not really sure where the best place to do this is, one option is to
> use the entire range "s0-s12.c1.c12" as the symbol key in the level
> symtab (very strange and awkward, I don't really like it). Otherwise we
> can add a string to range_trans_rule_t and store it there, also
> non-standard. When doing this we should go ahead and fix user as well
> since users aren't allowed in mls modules now.

I think the string may be easiest.  Otherwise a list of structs like:

struct mls_cat_component {
	int start;
	int stop;
	struct mls_cat_component *next;
} mls_cat_component_t

could be used.  Where something like c0,c4,c10.c20,c25 would be represented as:

   start=1
   stop=1
   next=......start=4
              stop=4
              next=......start=c10
                         stop=c20
                         next=......start=25
                                    stop=25
                                    next=NULL

I can play with working something up based on storing the string rather than
the mls_range_t just to see what it would look like.  I'm not sure going with
a more complicated structure based method really buys us much.  If there are
other structure ideas - I'd sure like to investigate them.

BTW, sorry for the delay, I was unavailable yesterday...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
