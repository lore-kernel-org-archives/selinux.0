Message-ID: <551AF895.1040100@tycho.nsa.gov>
Date: Tue, 31 Mar 2015 15:42:13 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3 v3] libsepol: add function to generate CIL from a
 module policydb
References: <1427822281-14769-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1427822281-14769-3-git-send-email-jwcart2@tycho.nsa.gov>
 <551AF4CA.5070206@tresys.com>
In-Reply-To: <551AF4CA.5070206@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/31/2015 03:26 PM, Steve Lawrence wrote:
> On 03/31/2015 01:18 PM, James Carter wrote:
>> Add a new function, sepol_module_policydb_to_cil, that generates
>> CIL from a module (not kernel) policydb. Refactor
>> sepol_module_package_to_cil() to use the new function.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/include/sepol/module_to_cil.h |   2 +
>>   libsepol/src/module_to_cil.c           | 367 ++++++++++++++++++++++-----------
>>   2 files changed, 254 insertions(+), 115 deletions(-)
>>
>> diff --git a/libsepol/include/sepol/module_to_cil.h b/libsepol/include/sepol/module_to_cil.h
>> index 1d0225c..18bb3bf 100644
>> --- a/libsepol/include/sepol/module_to_cil.h
>> +++ b/libsepol/include/sepol/module_to_cil.h
>> @@ -1,6 +1,8 @@
>>   #include <stdlib.h>
>>
>>   #include <sepol/module.h>
>> +#include <sepol/policydb/policydb.h>
>>
>> +int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked);
>>   int sepol_module_package_to_cil(FILE *fp, struct sepol_module_package *mod_pkg);
>>   int sepol_ppfile_to_module_package(FILE *fp, struct sepol_module_package **mod_pkg);
>
> One potential issue with these functions is that they aren't thread safe
> due to the use of globals with role_list and typealias_lists. When pp
> was a single binary this wasn't a big deal (and greatly simplified the
> code), but now that it's part of libsepol it could potentially cause
> issues. Not sure if it's worth the complexity to change it so either
> they aren't global variables, or make them thread local variables.
> Alternatively, we could just document the functions as not thread safe.

I was initially going to remove the globals but I wasn't sure if they were a 
problem and I wanted to minimize the changes to the code to make review easier.

I am willing to convert them. Should I do that as a part of this patch set?
Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
