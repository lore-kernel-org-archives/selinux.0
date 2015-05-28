Message-ID: <55677751.4090405@tycho.nsa.gov>
Date: Thu, 28 May 2015 16:15:13 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libsepol: with pp to CIL, only associate declared
 roleattributes with in-scope types
References: <1432316069-24113-1-git-send-email-slawrence@tresys.com>
 <55676790.4010601@tycho.nsa.gov>
In-Reply-To: <55676790.4010601@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/28/2015 03:08 PM, James Carter wrote:
> On 05/22/2015 01:34 PM, Steve Lawrence wrote:
>> When a roleattribute is in a declared scope, CIL roletype statements are
>> generated for all types associated with it. This incorrectly includes
>> types that are associated with the roleattribute in optional blocks,
>> which can result in CIL resolution failures if the optional block is
>> turned off due to a missing type. So, change the roletype CIL statement
>> generation with roleattributes to mimic the behavior of roles, ensuring
>> declared roleattributes are only associated with in-scope types.
>>
>> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
>> Reported-by: Miroslav Grepl <mgrepl@redhat.com>
>> ---
>>   libsepol/src/module_to_cil.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index 8d16d3e..1ded21d 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -2091,7 +2091,9 @@ static int role_to_cil(int indent, struct policydb *pdb,
>> struct avrule_block *UN
>>
>>
>>           for (i = 0; i < num_types; i++) {
>> -            cil_println(indent, "(roletype %s %s)", key, types[i]);
>> +            if (is_id_in_scope(pdb, decl_stack, types[i], SYM_TYPES)) {
>> +                cil_println(indent, "(roletype %s %s)", key, types[i]);
>> +            }
>>           }
>>
>>           break;
>>
>
> This breaks generating CIL from a policy.conf, or, more likely, exposes a
> problem in what I did to make that work.
>
> A roletype rule will not appear in the generated CIL policy, if
> 1) It is in an optional block
> 2) It is for a role attribute that is in the required block of the optional.
>
> The policydb to CIL code is called after policy linking, so I would have thought
> that everything should work. I am still looking at this.
>

Actually, it doesn't matter whether or not the role attribute is in a require 
block. The determining factor is whether there is any role rule (CIL roletype 
rule) outside of an optional block. If there is, then all of the roletype rules 
for that role attribute will be in the CIL policy. If not, then none of them 
will be.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
