Subject: Re: [PATCH 2/2 v2] checkpolicy: Warn if module name different than
 output filename
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
References: <1460041566-7173-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1460041566-7173-3-git-send-email-jwcart2@tycho.nsa.gov>
 <57067C93.3040000@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5706B65D.1000906@tycho.nsa.gov>
Date: Thu, 7 Apr 2016 15:34:53 -0400
MIME-Version: 1.0
In-Reply-To: <57067C93.3040000@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/07/2016 11:28 AM, Daniel J Walsh wrote:
>
>
> On 04/07/2016 11:06 AM, James Carter wrote:
>> Since CIL treats files as modules and does not have a separate
>> module statement it can cause confusion when a Refpolicy module
>> has a name that is different than its base filename because older
>> SELinux userspaces will refer to the module by its module name while
>> a CIL-based userspace will refer to it by its filename.
>>
>> Because of this, provide a warning message when compiling a module and
>> the output filename is different than the module name.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   checkpolicy/checkmodule.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
>> index 5957d29..d807620 100644
>> --- a/checkpolicy/checkmodule.c
>> +++ b/checkpolicy/checkmodule.c
>> @@ -19,6 +19,7 @@
>>   #include <stdio.h>
>>   #include <errno.h>
>>   #include <sys/mman.h>
>> +#include <libgen.h>
>>   #include <sepol/module_to_cil.h>
>>   #include <sepol/policydb/policydb.h>
>> @@ -258,6 +259,20 @@ int main(int argc, char **argv)
>>           }
>>       }
>> +    if (policy_type != POLICY_BASE && outfile) {
>> +        char *mod_name = modpolicydb.name;
>> +        char *out_path = strdup(outfile);
>> +        char *out_name = basename(out_path);
>> +        char *separator = strrchr(out_name, '.');
>> +        if (separator) {
>> +            *separator = '\0';
>> +        }
>> +        if (strcmp(mod_name, out_name) != 0) {
>> +            fprintf(stderr,    "Warning: SELinux userspace will refer to the
>> module from %s as %s rather than as %s\n", file, out_name, mod_name);
>> +        }
>> +        free(out_path);
>> +    }
>> +
>>       if (modpolicydb.policy_type == POLICY_BASE && !cil) {
>>           /* Verify that we can successfully expand the base module. */
>>           policydb_t kernpolicydb;
> Why not fail rather then warn.  Don't let me do stupid things...

I am willing to do that for checkmodule if that is what everyone wants. I 
wouldn't want to do it for pp since that could cause problems for current 
systems. Just as a note, Fedora's passenger module has "passanger" as the policy 
name in its policy_module statement.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
