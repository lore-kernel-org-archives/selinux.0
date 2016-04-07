Subject: Re: [PATCH 2/3] policycoreutils/hll/pp: Warn if module name different
 from filenames
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1458929095-25819-3-git-send-email-jwcart2@tycho.nsa.gov>
 <56F58767.9050707@tycho.nsa.gov> <56F589FD.5000308@tycho.nsa.gov>
 <56F6EC06.2010706@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <57067888.3000305@tycho.nsa.gov>
Date: Thu, 7 Apr 2016 11:11:04 -0400
MIME-Version: 1.0
In-Reply-To: <56F6EC06.2010706@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/26/2016 04:07 PM, Daniel J Walsh wrote:
>
>
> On 03/25/2016 02:57 PM, James Carter wrote:
>> On 03/25/2016 02:45 PM, Stephen Smalley wrote:
>>> On 03/25/2016 02:04 PM, James Carter wrote:
>>>> Since CIL treats files as modules and does not have a separate
>>>> module statement it can cause confusion when a Refpolicy module
>>>> has a name that is not the same as its base filename because
>>>> older SELinux userspaces will refer to the module by its module
>>>> name, but CIL will refer to the module by its filename.
>>>>
>>>> When converting a policy package to CIL warn if the module name is
>>>> different from the pp filename or the CIL filename.
>>>>
>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>> ---
>>>>   policycoreutils/hll/pp/pp.c | 29 +++++++++++++++++++++++++----
>>>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
>>>> index 866734f..22cef0d 100644
>>>> --- a/policycoreutils/hll/pp/pp.c
>>>> +++ b/policycoreutils/hll/pp/pp.c
>>>> @@ -28,6 +28,7 @@
>>>>
>>>>   #include <sepol/module.h>
>>>>   #include <sepol/module_to_cil.h>
>>>> +#include <sepol/policydb/module.h>
>>>>
>>>>   char *progname;
>>>>
>>>> @@ -68,6 +69,8 @@ int main(int argc, char **argv)
>>>>           { NULL, 0, NULL, 0 }
>>>>       };
>>>>       struct sepol_module_package *mod_pkg = NULL;
>>>> +    char *ifile = NULL;
>>>> +    char *ofile = NULL;
>>>>       FILE *in = NULL;
>>>>       FILE *out = NULL;
>>>>       int outfd = -1;
>>>> @@ -89,9 +92,10 @@ int main(int argc, char **argv)
>>>>       }
>>>>
>>>>       if (argc >= optind + 1 && strcmp(argv[1], "-") != 0) {
>>>> -        in = fopen(argv[1], "rb");
>>>> +        ifile = argv[1];
>>>> +        in = fopen(ifile, "rb");
>>>>           if (in == NULL) {
>>>> -            log_err("Failed to open %s: %s", argv[1], strerror(errno));
>>>> +            log_err("Failed to open %s: %s", ifile, strerror(errno));
>>>>               rc = -1;
>>>>               goto exit;
>>>>           }
>>>> @@ -100,9 +104,10 @@ int main(int argc, char **argv)
>>>>       }
>>>>
>>>>       if (argc >= optind + 2 && strcmp(argv[2], "-") != 0) {
>>>> -        out = fopen(argv[2], "w");
>>>> +        ofile = argv[2];
>>>> +        out = fopen(ofile, "w");
>>>>           if (out == NULL) {
>>>> -            log_err("Failed to open %s: %s", argv[2], strerror(errno));
>>>> +            log_err("Failed to open %s: %s", ofile, strerror(errno));
>>>>               rc = -1;
>>>>               goto exit;
>>>>           }
>>>> @@ -122,6 +127,22 @@ int main(int argc, char **argv)
>>>>       fclose(in);
>>>>       in = NULL;
>>>>
>>>> +    if (ifile) {
>>>> +        rc = sepol_module_check_name_matches_filename(mod_pkg->policy, ifile);
>>>> +        if (rc != 0) {
>>>> +            fprintf(stderr,    "Module name %s does not match pp file %s\n",
>>>> +                sepol_module_get_name(mod_pkg->policy), ifile);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (ofile) {
>>>> +        rc = sepol_module_check_name_matches_filename(mod_pkg->policy, ofile);
>>>> +        if (rc != 0) {
>>>> +            fprintf(stderr,    "Module name %s does not match cil file %s\n",
>>>> +                sepol_module_get_name(mod_pkg->policy), ofile);
>>>> +        }
>>>> +    }
>>>
>>> So what, if anything, should the user take away from such warnings?  We
>>> likely ought to prefix them with "Warning:" or similar to indicate that
>>> it is non-fatal.  And perhaps tell them which name will need to be used
>>> for subsequent commands.
>>>
>>
>> What they need to take away is that the module is going to be referred to by
>> its filename from now on, so telling them that would be helpful. I originally
>> had prefixed the message with "Warning:", but I thought that might be too
>> strong and scary.
>>
>> Jim
>>
> Why not make it fatal. Is there any reason a user would ever want to do this, I
> would think this is almost always a mistake.

I think that it is almost always a mistake, but there were, at least in the 
past, modules that did this and I didn't want to cause problems if they are 
still in use.

Jim

>>>> +
>>>>       rc = sepol_module_package_to_cil(out, mod_pkg);
>>>>       if (rc != 0) {
>>>>           goto exit;
>>>>
>>
>>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
