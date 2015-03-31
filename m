Message-ID: <551AF49B.7050903@tycho.nsa.gov>
Date: Tue, 31 Mar 2015 15:25:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/3 v3] libsepol, policycoreutils, and checkpolicy: Add
 support for generating CIL to libsepol and checkpolicy
References: <1427822281-14769-1-git-send-email-jwcart2@tycho.nsa.gov>
 <90C2B82E7E29DB4ABBA49A53BDC611C001413966@Exchange10.columbia.tresys.com>
In-Reply-To: <90C2B82E7E29DB4ABBA49A53BDC611C001413966@Exchange10.columbia.tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/31/2015 03:15 PM, Yuli Khodorkovskiy wrote:
>
>
>> -----Original Message-----
>> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of James
>> Carter
>> Sent: Tuesday, March 31, 2015 1:18 PM
>> To: selinux@tycho.nsa.gov
>> Subject: [PATCH 0/3 v3] libsepol, policycoreutils, and checkpolicy: Add
>> support for generating CIL to libsepol and checkpolicy
>>
>> V3 fixes another whitespace issue.
>> V2 fixes some whitespace issues and make the new libsepol file LGPL
>> instead of GPL.
>>
>> This patch set moves the code to generate CIL from pp.c in
>> policycoreutils/hll/pp to libsepol, adds a new function to generate CIL from
>> a module policydb, and modifies checkpolicy and checkmodule to support
>> generating CIL as their output.
>>
>> The primary motivation of this work is to allow SE for Android to use the
>> CIl compiler. Converting the policy.conf to CIL and then compiling to the
>> kernel binary policy results in a policy that is about 20% smaller. The
>> smaller size is because type expressions with negations are converted to
>> type attribute sets in CIL instead of being expanded.
>>
>> James Carter (3):
>>   libsepol, policycoreutils: Move functions to convert a module package
>>     to CIL
>>   libsepol: add function to generate CIL from a module policydb
>>   checkpolicy: Add support for generating CIL
>>
>> checkpolicy/checkmodule.c              |   59 +-
>> checkpolicy/checkpolicy.c              |   79 +-
>> libsepol/include/sepol/module_to_cil.h |    8 +
>> libsepol/src/module_to_cil.c           | 4010
>> ++++++++++++++++++++++++++++++++
>> policycoreutils/hll/pp/pp.c            | 3830 +-----------------------------
>> 5 files changed, 4107 insertions(+), 3879 deletions(-)  create mode 100644
>> libsepol/include/sepol/module_to_cil.h
>> create mode 100644 libsepol/src/module_to_cil.c
>>
>> --
>> 1.9.3
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-
>> request@tycho.nsa.gov.
>
> Jim,
>
> Can you modify the usage and man pages for checkpolicy and checkmodule to include the new CIL options?
>

Yes. I should have done that.

> Does it make sense to add sepol_ppfile_to_module_package and sepol_module_package_to_cil to the libsepol map file and make pp link dynamically with libsepol?
>
Makes sense to me.

Thanks for the feedback.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
