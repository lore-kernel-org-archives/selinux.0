MIME-Version: 1.0
In-Reply-To: <2ec61cf5-648a-9494-8d15-003bc46c41f3@tycho.nsa.gov>
References: <20180316031601.128736-1-trong@android.com>
 <CAFftDdoXv49GeUNCc+6gtviOtPfrGnr7JfZXTiqMzVSBWxLsFg@mail.gmail.com>
 <2ec61cf5-648a-9494-8d15-003bc46c41f3@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Mar 2018 09:52:33 -0700
Message-ID: <CAFftDdro8-j-wS-UXoHJdPc11S-LCGhTTpPL_SXjRD0M8=EZXg@mail.gmail.com>
To: jwcart2 <jwcart2@tycho.nsa.gov>
Cc: Tri Vo <trong@android.com>, Daniel Cashman <dcashman@google.com>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2] Resolve conflicts in expandattribute.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 16, 2018 at 9:06 AM, jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 03/16/2018 11:23 AM, William Roberts wrote:
>>
>> On Thu, Mar 15, 2018 at 8:16 PM, Tri Vo <trong@android.com> wrote:
>>>
>>> This commit resolves conflicts in values of expandattribute statements
>>> in policy language and expandtypeattribute in CIL.
>>>
>>> For example, these statements resolve to false in policy language:
>>>   expandattribute hal_audio true;
>>>   expandattribute hal_audio false;
>>>
>>> Similarly, in CIL these also resolve to false.
>>>   (expandtypeattribute (hal_audio) true)
>>>   (expandtypeattribute (hal_audio) false)
>>>
>>> Motivation
>>> When Android combines multiple .cil files from system.img and vendor.img
>>> it's possible to have conflicting expandattribute statements.
>>>
>>> This change deals with this scenario by resolving the value of the
>>> corresponding expandtypeattribute to false. The rationale behind this
>>> override is that true is used for reduce run-time lookups, while
>>> false is used for tests which must pass.
>>>
>>> Signed-off-by: Tri Vo <trong@android.com>
>>> ---
>>>   checkpolicy/policy_define.c        |  8 ++++----
>>>   libsepol/cil/src/cil_resolve_ast.c | 21 ++++++---------------
>>>   2 files changed, 10 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>>> index 2c5db55d..1e632ef7 100644
>>> --- a/checkpolicy/policy_define.c
>>> +++ b/checkpolicy/policy_define.c
>>> @@ -1182,10 +1182,6 @@ int expand_attrib(void)
>>>                          goto exit;
>>>                  }
>>>
>>> -               if (attr->flags & TYPE_FLAGS_EXPAND_ATTR) {
>>> -                       yyerror2("%s already has the expandattribute
>>> option specified", id);
>>> -                       goto exit;
>>> -               }
>>>                  if (ebitmap_set_bit(&attrs, attr->s.value - 1, TRUE)) {
>>>                          yyerror("Out of memory!");
>>>                          goto exit;
>>> @@ -1213,6 +1209,10 @@ int expand_attrib(void)
>>>                  attr = hashtab_search(policydbp->p_types.table,
>>>
>>> policydbp->sym_val_to_name[SYM_TYPES][i]);
>>>                  attr->flags |= flags;
>>
>>
>> I'd like to see a comment here. The CIL case is much easier to understand
>> because the error messages contain information about what's going on.
>>
>> Maybe something like:
>> /*
>>   * if an expandattr rule conflicts, set the expandattr to false. False
>> always
>>   * works, at the expense of performance for run-time attribute
>> resolution.
>>   */
>>
>
> I would actually prefer a warning.

Good point. That would make it consistent with the CIL code. I like this
suggestion much better than just a comment.

>
>
>>> +               if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
>>> +                               (attr->flags &
>>> TYPE_FLAGS_EXPAND_ATTR_FALSE)) {
>>> +                       attr->flags &= ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
>>> +               }
>>>          }
>>>
>>>          rc = 0;
>>> diff --git a/libsepol/cil/src/cil_resolve_ast.c
>>> b/libsepol/cil/src/cil_resolve_ast.c
>>> index d1a5ed87..02259241 100644
>>> --- a/libsepol/cil/src/cil_resolve_ast.c
>>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>>> @@ -269,9 +269,8 @@ exit:
>>>          return rc;
>>>   }
>>>
>>> -int cil_type_used(struct cil_symtab_datum *datum, int used)
>>> +void cil_type_used(struct cil_symtab_datum *datum, int used)
>>>   {
>>> -       int rc = SEPOL_ERR;
>>>          struct cil_typeattribute *attr = NULL;
>>>
>>>          if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
>>> @@ -279,16 +278,12 @@ int cil_type_used(struct cil_symtab_datum *datum,
>>> int used)
>>>                  attr->used |= used;
>>>                  if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
>>>                                  (attr->used & CIL_ATTR_EXPAND_FALSE)) {
>>> -                       cil_log(CIL_ERR, "Conflicting use of
>>> expandtypeattribute. "
>>> -                                       "Expandtypeattribute may be set
>>> to true or false "
>>> -                                       "but not both. \n");
>>> -                       goto exit;
>>> +                       cil_log(CIL_WARN, "Conflicting use of
>>> expandtypeattribute. "
>>> +                                       "Expandtypeattribute was set to
>>> both true or false for %s. "
>>> +                                       "Resolving to false. \n",
>>> attr->datum.name);
>>> +                       attr->used &= ~CIL_ATTR_EXPAND_TRUE;
>>>                  }
>>>          }
>>> -
>>> -       return SEPOL_OK;
>>> -exit:
>>> -       return rc;
>>>   }
>>>
>>>   int cil_resolve_permissionx(struct cil_tree_node *current, struct
>>> cil_permissionx *permx, void *extra_args)
>>> @@ -488,11 +483,7 @@ int cil_resolve_expandtypeattribute(struct
>>> cil_tree_node *current, void *extra_a
>>>                          goto exit;
>>>                  }
>>>                  used = expandattr->expand ? CIL_ATTR_EXPAND_TRUE :
>>> CIL_ATTR_EXPAND_FALSE;
>>> -               rc = cil_type_used(attr_datum, used);
>>> -               if (rc != SEPOL_OK) {
>>> -                       goto exit;
>>> -               }
>>> -
>>> +               cil_type_used(attr_datum, used);
>>>                  cil_list_append(expandattr->attr_datums, CIL_TYPE,
>>> attr_datum);
>>>          }
>>>
>>> --
>>> 2.16.2.804.g6dcf76e118-goog
>>>
>>
>> Overall this looks good, just add that comment.
>> Well see if anyone else has more feedback.
>>
>>
>
> The CIL part looks good.
>
> Jim
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
