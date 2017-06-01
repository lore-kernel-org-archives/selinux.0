MIME-Version: 1.0
In-Reply-To: <b113a7d2-7a4e-8747-5047-8aad7dc6ffbf@tycho.nsa.gov>
References: <20170601132324.15217-1-slawrence@tresys.com>
 <b113a7d2-7a4e-8747-5047-8aad7dc6ffbf@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 1 Jun 2017 23:37:11 +0200
Message-ID: <CAJfZ7=kWujx==KFGg8fYxqo11TGBf76DUasc2pmjmVJ-QLXftA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: better error message with duplicate aliases
 + support aliases to aliases
To: jwcart2 <jwcart2@tycho.nsa.gov>, Steve Lawrence <slawrence@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 1, 2017 at 7:05 PM, jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 06/01/2017 09:23 AM, Steve Lawrence wrote:
>>
>> - If two typealiasactual statements exist for the same typealias, we get
>>    a confusing error message mentioning that the actual arguement is not
>>    an alias, which is clearly allowed. This poor error occurs because the
>>    first typealiasactual statement resolves correctly, but when we
>>    resolve the alias in the second typealiasactual statement,
>>    cil_resolve_name tries to return what the alias points to, which is a
>>    type and not the required typealias. This patch creates a new function
>>    that does not perform the alias to actual conversion, used when we
>>    want an alias and not what the alias points to. This allows the
>>    cil_resolve_aliasactual to continue and reach the check for duplicate
>>    typealiasactual statements, resulting in a more meaningful error
>>    message.
>>
>> - Add back support for aliases to aliases (broken in 5c9fcb02e),
>>    while still ensuring that aliases point to either the correct actual
>>    flavor or alias flavor, and not something else like a typeattribute.
>>
>> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
>
>
> I didn't even think of the case of an alias of an alias. Applied.
>
> Thanks,
> Jim

Hello,
This patch broke secilc's test case. From secilc/ directory:

    $ ./secilc test/policy.cil
    cat0 is not a category. Only categories are allowed in
categoryorder statements
    Failed to compile cildb: -1

cat0 is defined as a categoryalias in secilc/test/policy.cil and is
used in "(categoryorder (cat0 c1 c2 c3))". I do not have time right
now to investigate further what is causing the issue, but reverting
this commit (e501d3b6e8d2) fixes "make test".

Nicolas
PS: if anyone is interested in the Travis-CI output of this bug, it is
available on https://travis-ci.org/fishilico/selinux/builds/238505788
.

>
>
>> ---
>>   libsepol/cil/src/cil_resolve_ast.c | 48
>> ++++++++++++++++++++++++--------------
>>   libsepol/cil/src/cil_resolve_ast.h |  1 +
>>   2 files changed, 32 insertions(+), 17 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c
>> b/libsepol/cil/src/cil_resolve_ast.c
>> index 5c26530..fc44a5e 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -515,7 +515,7 @@ int cil_resolve_aliasactual(struct cil_tree_node
>> *current, void *extra_args, enu
>>                 goto exit;
>>         }
>>   -     rc = cil_resolve_name(current, aliasactual->alias_str, sym_index,
>> extra_args, &alias_datum);
>> +       rc = cil_resolve_name_keep_aliases(current,
>> aliasactual->alias_str, sym_index, extra_args, &alias_datum);
>>         if (rc != SEPOL_OK) {
>>                 goto exit;
>>         }
>> @@ -530,7 +530,7 @@ int cil_resolve_aliasactual(struct cil_tree_node
>> *current, void *extra_args, enu
>>                 goto exit;
>>         }
>>   -     if (NODE(actual_datum)->flavor != flavor) {
>> +       if (NODE(actual_datum)->flavor != flavor &&
>> NODE(actual_datum)->flavor != alias_flavor) {
>>                 cil_log(CIL_ERR, "%s is a %s, but aliases a %s\n",
>> alias_datum->name, cil_node_to_string(NODE(alias_datum)),
>> cil_node_to_string(NODE(actual_datum)));
>>                 rc = SEPOL_ERR;
>>                 goto exit;
>> @@ -539,7 +539,7 @@ int cil_resolve_aliasactual(struct cil_tree_node
>> *current, void *extra_args, enu
>>         alias = (struct cil_alias *)alias_datum;
>>         if (alias->actual != NULL) {
>> -               cil_log(CIL_ERR, "Alias cannot bind more than one
>> value\n");
>> +               cil_log(CIL_ERR, "%s %s cannot bind more than one
>> value\n", cil_node_to_string(NODE(alias_datum)), alias_datum->name);
>>                 rc = SEPOL_ERR;
>>                 goto exit;
>>         }
>> @@ -4122,6 +4122,34 @@ static int __cil_resolve_name_helper(struct cil_db
>> *db, struct cil_tree_node *no
>>   int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum
>> cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum)
>>   {
>>         int rc = SEPOL_ERR;
>> +       struct cil_tree_node *node = NULL;
>> +
>> +       rc = cil_resolve_name_keep_aliases(ast_node, name, sym_index,
>> extra_args, datum);
>> +       if (rc != SEPOL_ERR) {
>> +               goto exit;
>> +       }
>> +
>> +       /* If this datum is an alias, then return the actual node
>> +        * This depends on aliases already being processed
>> +        */
>> +       node = NODE(*datum);
>> +       if (node->flavor == CIL_TYPEALIAS || node->flavor == CIL_SENSALIAS
>> +               || node->flavor == CIL_CATALIAS) {
>> +               struct cil_alias *alias = (struct cil_alias *)(*datum);
>> +               if (alias->actual) {
>> +                       *datum = alias->actual;
>> +               }
>> +       }
>> +
>> +       rc = SEPOL_OK;
>> +
>> +exit:
>> +       return rc;
>> +}
>> +
>> +int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char
>> *name, enum cil_sym_index sym_index, void *extra_args, struct
>> cil_symtab_datum **datum)
>> +{
>> +       int rc = SEPOL_ERR;
>>         struct cil_args_resolve *args = extra_args;
>>         struct cil_db *db = args->db;
>>         struct cil_tree_node *node = NULL;
>> @@ -4208,20 +4236,6 @@ exit:
>>                 *datum = NULL;
>>         }
>>   -     if (*datum != NULL) {
>> -               /* If this datum is an alias, then return the actual node
>> -                * This depends on aliases already being processed
>> -                */
>> -               node = NODE(*datum);
>> -               if (node->flavor == CIL_TYPEALIAS || node->flavor ==
>> CIL_SENSALIAS
>> -                       || node->flavor == CIL_CATALIAS) {
>> -                       struct cil_alias *alias = (struct cil_alias
>> *)(*datum);
>> -                       if (alias->actual) {
>> -                               *datum = alias->actual;
>> -                       }
>> -               }
>> -       }
>> -
>>         args->last_resolved_name = name;
>>         return rc;
>> diff --git a/libsepol/cil/src/cil_resolve_ast.h
>> b/libsepol/cil/src/cil_resolve_ast.h
>> index 82c8ea3..1d971fd 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.h
>> +++ b/libsepol/cil/src/cil_resolve_ast.h
>> @@ -99,5 +99,6 @@ int cil_resolve_tunif(struct cil_tree_node *current,
>> void *extra_args);
>>     int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current);
>>   int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum
>> cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum);
>> +int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char
>> *name, enum cil_sym_index sym_index, void *extra_args, struct
>> cil_symtab_datum **datum);
>>     #endif /* CIL_RESOLVE_AST_H_ */
>>
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
