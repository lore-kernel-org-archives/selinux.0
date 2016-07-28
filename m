Subject: Re: [PATCH] libsepol/cil: Warn instead of fail if permission is not
 resolve
To: Steve Lawrence <slawrence@tresys.com>,
 James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1469716754-11698-1-git-send-email-jwcart2@tycho.nsa.gov>
 <6c6ecfa8-982a-fc82-8836-fb09eb0d89e7@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e0d1e7d3-f903-0b49-b449-3f1a3297fed1@tycho.nsa.gov>
Date: Thu, 28 Jul 2016 13:12:41 -0400
MIME-Version: 1.0
In-Reply-To: <6c6ecfa8-982a-fc82-8836-fb09eb0d89e7@tresys.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/28/2016 11:56 AM, Steve Lawrence wrote:
> On 07/28/2016 10:39 AM, James Carter wrote:
>> If a policy module package has been created with a policy that contains
>> a permission and then is used on a system without that permission CIL
>> will fail with an error when it cannot resolve the permission.
> 
> An error seems like the correct behavior to me. Similarly, if a module
> that references a type/macro/block/etc. is installed on a system without
> that type/macro/block/etc., then I would expect an error and the policy
> needs to be modified to work on that system.
> 
> One potential way to fix this is to wrap the rule using the permission
> in an optional or tunable if it is possible that some other system will
> not have that permission defined, similar to how this issue is solved
> with types/etc.

The specific motivation for the change is that Fedora is trying to
expunge permissions from its policy that were never upstream (e.g.
ptrace_child in class process, compromise_kernel in class capability2,
etc).  This presently breaks policy updates when there is a third party
or local policy module already installed that was built against the
older selinux-policy-devel that had those permissions.  What is worse is
that rpm thinks that the policy was updated, since only semodule fails
during %post, so you could easily brick a system this way on an upgrade
because you'll end up running the old policy but rpm will think it has
succeeded and proceed to install any other updated packages, which may
depend on the new policy.

> 
> - Steve
> 
>> This will prevent the installation on policy and the user will not
>> know that the policy has not been installed.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>  libsepol/cil/src/cil_resolve_ast.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index 70e4462..8348d57 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -131,10 +131,10 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>>  				}
>>  			}
>>  			if (rc != SEPOL_OK) {
>> -				cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
>> -				goto exit;
>> +				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
>> +			} else {
>> +				cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
>>  			}
>> -			cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
>>  		} else {
>>  			cil_list_append(*perm_datums, curr->flavor, curr->data);
>>  		}
>> @@ -3660,7 +3660,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>>  			rc = SEPOL_OK;
>>  		}
>>  
>> -		cil_tree_log(node, lvl, "Failed to resolve '%s' in %s statement", args->last_resolved_name, cil_node_to_string(node));
>> +		cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
>>  		goto exit;
>>  	}
>>  
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
