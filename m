Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NLMWqF001734
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 16:22:36 -0500
Received: by mail-vk0-f42.google.com with SMTP id e185so174167203vkb.1
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 13:22:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56CCC13F.3060709@android.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
 <56CCC13F.3060709@android.com>
Date: Tue, 23 Feb 2016 13:22:34 -0800
Message-ID: <CAFJ0LnH=zQuJ6mSBSQu4XBjQ-jHnOpKveh7TwE55WLxfj5KGXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: procattr: return einval for <= 0 pid args.
From: Nick Kralevich <nnk@google.com>
To: Daniel Cashman <dcashman@android.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Jeffrey Vander Stoep <jeffv@google.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for proposing this patch Dan.

As you said, the current API feels error prone, as it has two entirely
different behaviors depending on whether the pid is zero or non-zero.
Your patch corrects this error prone API and clearly separates out a
query by PID vs a query of the process itself.

This patch helps provide robustness against bugs similar to:

  https://code.google.com/p/google-security-research/issues/detail?id=727
  https://code.google.com/p/android/issues/detail?id=200617

(note that the Android code in question was reviewed by Stephen,
myself, and others within Google, and we all missed this particular
bug)

I would recommend the upstream SELinux community accept the patch,
even at the potential expense of breaking compatibility with other
apps.

-- Nick

On Tue, Feb 23, 2016 at 12:29 PM, Daniel Cashman <dcashman@android.com> wrote:
> On 02/23/2016 12:24 PM, Daniel Cashman wrote:
>> From: dcashman <dcashman@android.com>
>>
>> getpidcon documentation does not specify that a pid of 0 refers to the
>> current process, and getcon exists specifically to provide this
>> functionality, and getpidcon(getpid()) would provide it as well.
>> Disallow pid values <= 0 that may lead to unintended behavior in
>> userspace object managers.
>>
>> Signed-off-by: Daniel Cashman <dcashman@android.com>

Acked-by: Nick Kralevich <nnk@google.com>

>> ---
>>  libselinux/src/procattr.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>> index c20f003..eee4612 100644
>> --- a/libselinux/src/procattr.c
>> +++ b/libselinux/src/procattr.c
>> @@ -306,11 +306,21 @@ static int setprocattrcon(const char * context,
>>  #define getpidattr_def(fn, attr) \
>>       int get##fn##_raw(pid_t pid, char **c)  \
>>       { \
>> -             return getprocattrcon_raw(c, pid, #attr); \
>> +             if (pid <= 0) { \
>> +                     errno = EINVAL; \
>> +                     return -1; \
>> +             } else { \
>> +                     return getprocattrcon_raw(c, pid, #attr); \
>> +             } \
>>       } \
>>       int get##fn(pid_t pid, char **c)        \
>>       { \
>> -             return getprocattrcon(c, pid, #attr); \
>> +             if (pid <= 0) { \
>> +                     errno = EINVAL; \
>> +                     return -1; \
>> +             } else { \
>> +                     return getprocattrcon(c, pid, #attr); \
>> +             } \
>>       }
>>
>>  all_selfattr_def(con, current)
>>
>
> I need to point out explicitly that this change would, of course, break
> the existing ABI and result in a change in behavior for applications
> relying on getpidcon(0,) calls to be the same as getcon().
>
> Thanks,
> Dan



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
