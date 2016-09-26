MIME-Version: 1.0
In-Reply-To: <c9974ee5-670b-8573-7778-9fd1770ef4d4@tycho.nsa.gov>
References: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
 <c9974ee5-670b-8573-7778-9fd1770ef4d4@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 26 Sep 2016 09:44:37 -0700
Message-ID: <CAFftDdp9c8HBVFWXCo5CU_TJcGMV-fxX6MwgnywGCCCEpBdjcw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop unused stdio_ext.h header file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 26, 2016 at 8:05 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/24/2016 01:10 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> Nothing was being used from the stdio_ext.h header file, so
>> remove it. Additionally, Mac builds, required for the
>> Android build, do not have this header.
>>
>> Change-Id: Ic61c87fcda79ffebeef93a20a2b3802f048bb0b0
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Thanks, applied. However, technically this was because an earlier change
> from you dropped the use of __fsetlocking(), so we may need to restore
> this at some point if that becomes an issue.

Doubtful, unless its heavily threaded you wont see much of
a change between the locking and unlocked variants. If do
need to restore this, I think the approach would be create
an selinux_fileio.c and .h file and hide all the platform deltas
in there.

>
>> ---
>>  libselinux/src/label_file.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 7156825..8ff1170 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -10,7 +10,6 @@
>>  #include <stdarg.h>
>>  #include <string.h>
>>  #include <stdio.h>
>> -#include <stdio_ext.h>
>>  #include <ctype.h>
>>  #include <errno.h>
>>  #include <limits.h>
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
