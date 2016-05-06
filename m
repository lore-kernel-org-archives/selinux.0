Subject: Re: [PATCH] libsepol: Change which attributes CIL keeps in the binary
 policy
To: "Roberts, William C" <william.c.roberts@intel.com>,
 William Roberts <bill.c.roberts@gmail.com>
References: <1462561003-2629-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAFftDdrdT1+=HHUFhVpQb6hmHbZswa=XEe=jXJysx87ixcOrwA@mail.gmail.com>
 <CAFftDdpeO4C7nH6coQ-ZXrab+eCWjkVo8bv=SHQ-5mMe_o_Rdg@mail.gmail.com>
 <CAFftDdra7ygQKTszajTpevP3+3tnsm7OedHpdG6SPCeYkTufDg@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC560122936D@ORSMSX103.amr.corp.intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5ecef796-7887-ca58-7ea9-9e9bd5bfec93@tycho.nsa.gov>
Date: Fri, 6 May 2016 15:44:19 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC560122936D@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2016 03:25 PM, Roberts, William C wrote:
>
>
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of William Roberts
> Sent: Friday, May 6, 2016 12:16 PM
> To: James Carter <jwcart2@tycho.nsa.gov>
> Cc: selinux@tycho.nsa.gov
> Subject: Re: [PATCH] libsepol: Change which attributes CIL keeps in the binary policy
>
>
> On May 6, 2016 11:58 AM, "James Carter" <jwcart2@tycho.nsa.gov> wrote:
>>
>> The removal of attributes that are only used in neverallow rules is
>> hindering AOSP adoption of the CIL compiler. This is because AOSP
>> extracts neverallow rules from its policy.conf for use in the Android
>> compatibility test suite. These neverallow rules are applied against
>> the binary policy being tested to check for a violation. Any neverallow
>> rules with an attribute that has been removed cannot be checked.
>>
>> Now attributes are kept unless they are not used in any allow rule and
>> they are auto-generated or named "cil_gen_require" or do not have any
>> types associated with them.
>
> I see now, you’re keeping them unless they are generated or marked.
>

CIL does not allow type sets to be used in av rules, so an attribute is created 
when these rules are converted to CIL. Most of these generated attributes occur 
in neverallow rules and we don't want them in the binary policy. Types are 
assigned to the cil_gen_require attribute if they are in a require block, but 
not used in any rule. This is needed to make sure optionals work the same way in 
CIL, but the attribute will never be used in a rule and doesn't need to be in 
the binary policy. Finally, if an attribute is not used by an allow rule and 
doesn't have any types associated with it, then it there doesn't seem to be any 
reason to keep it around. A bunch of mls specific attributes will be removed if 
you are not building an mls policy because of this.

>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>  libsepol/cil/src/cil_post.c  | 27 +++++++++++++++++++++++++++
>>  libsepol/src/module_to_cil.c |  8 +++++---
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
>> index a694b33..f8447c9 100644
>> --- a/libsepol/cil/src/cil_post.c
>> +++ b/libsepol/cil/src/cil_post.c
>> @@ -47,6 +47,9 @@
>>  #include "cil_verify.h"
>>  #include "cil_symtab.h"
>>
>> +#define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
>> +#define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
>> +
>>  static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
>>  static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
>>
>> @@ -1186,6 +1189,27 @@ exit:
>>         return SEPOL_ERR;
>>  }
>>
>> +static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)
>> +{
>> +       if (cil_attr->used) {
>> +               return CIL_TRUE;
>> +       }
>> +
>> +       if (strcmp(DATUM(cil_attr)->name, GEN_REQUIRE_ATTR) == 0) {
>> +               return CIL_FALSE;
> Just by reading this patch with 0 knowledge of cil, I would imagine this would be CIL_TRUE on a match with GEN_REQUIRED_ATTR. Especially since cardinality 0 below returns false.

This attribute could have a type associated with it, but we will never want to 
keep it around for the reasons that I mention above.

Jim

>> +       }
>> +
>> +       if (strstr(DATUM(cil_attr)->name,TYPEATTR_INFIX) != NULL) {
>> +               return CIL_FALSE;
>> +       }
>> +
>> +       if (ebitmap_cardinality(cil_attr->types) == 0) {
>> +               return CIL_FALSE;
>> +       }
>> +
>> +       return CIL_TRUE;
>> +}
>> +
>>  static int __cil_post_db_attr_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>>  {
>>         int rc = SEPOL_ERR;
>> @@ -1208,6 +1232,9 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, uint32_t *finis
>>                 if (attr->types == NULL) {
>>                         rc = __evaluate_type_expression(attr, db);
>>                         if (rc != SEPOL_OK) goto exit;
>> +                       if (cil_typeattribute_used(attr)) {
>> +                               attr->used = CIL_TRUE;
>> +                       }
>>                 }
>>                 break;
>>         }
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index b9a4af7..bcbb4de 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -58,7 +58,9 @@ FILE *out_file;
>>  #define STACK_SIZE 16
>>  #define DEFAULT_LEVEL "systemlow"
>>  #define DEFAULT_OBJECT "object_r"
>> -#define GEN_REQUIRE_ATTR "cil_gen_require"
>> +#define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/cil/src/cil_post.c */
>> +#define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/cil/src/cil_post.c */
>> +#define ROLEATTR_INFIX "_roleattr_"
>>
>>  __attribute__ ((format(printf, 1, 2)))
>>  static void log_err(const char *fmt, ...)
>> @@ -626,9 +628,9 @@ static int set_to_cil_attr(struct policydb *pdb, int is_type, char ***names, uin
>>         num_attrs++;
>>
>>         if (is_type) {
>> -               attr_infix = "_typeattr_";
>> +               attr_infix = TYPEATTR_INFIX;
>>         } else {
>> -               attr_infix = "_roleattr_";
>> +               attr_infix = ROLEATTR_INFIX;
>>         }
>>
>>         len = strlen(pdb->name) + strlen(attr_infix) + num_digits(num_attrs) + 1;
>> --
>> 2.5.5
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
