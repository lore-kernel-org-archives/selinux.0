Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4C0Jvgx003895
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 20:19:57 -0400
Received: by mail-vk0-f44.google.com with SMTP id g23so10238206vke.3
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 17:19:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrQMV_HbFLaUTjtDwO4UXgWCcKF8QWe8BytX_iPUUWZtQ@mail.gmail.com>
References: <20170511235002.26468-1-tomcherry@google.com>
 <CAFftDdrQMV_HbFLaUTjtDwO4UXgWCcKF8QWe8BytX_iPUUWZtQ@mail.gmail.com>
From: enh <enh@google.com>
Date: Thu, 11 May 2017 17:19:30 -0700
Message-ID: <CAJgzZoqwzmzUd7m_Z5U7aaLgp2eBEL0g_3Uvf9+wcUZhs3_3MA@mail.gmail.com>
Subject: Re: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Tom Cherry <tomcherry@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

don't feel bad: the Android tree has the same problem --- even bionic
itself didn't always get this right :-)

we're spotting these now because we're actually trying to use bionic
on non-Android Linux too.

On Thu, May 11, 2017 at 5:18 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thursday, May 11, 2017, Tom Cherry via Selinux <selinux@tycho.nsa.gov>
> wrote:
>>
>> This check is not specific to Android devices. If libselinux were used
>> with Bionic on a normal Linux system this check would still be needed.
>>
>> Signed-off-by: Tom Cherry <tomcherry@google.com>
>> ---
>>  libselinux/src/procattr.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>> index ebc0adec..48dd8aff 100644
>> --- a/libselinux/src/procattr.c
>> +++ b/libselinux/src/procattr.c
>> @@ -22,8 +22,8 @@ static pthread_key_t destructor_key;
>>  static int destructor_key_initialized = 0;
>>  static __thread char destructor_initialized;
>>
>> -#ifndef __ANDROID__
>> -/* Android declares this in unistd.h and has a definition for it */
>> +#ifndef __BIONIC__
>> +/* Bionic declares this in unistd.h and has a definition for it */
>>  static pid_t gettid(void)
>>  {
>>         return syscall(__NR_gettid);
>> --
>> 2.13.0.rc2.291.g57267f2277-goog
>
>
>
> Ack.. thanks for this. There might be other places I used Android when I
> should have used bionic
>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>



-- 
Elliott Hughes - http://who/enh - http://jessies.org/~enh/
Android native code/tools questions? Mail me/drop by/add me as a reviewer.
