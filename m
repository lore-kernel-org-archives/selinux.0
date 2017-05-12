Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CI1322032359
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 14:01:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id h4so74529952oib.3
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 11:01:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494595373.9454.2.camel@tycho.nsa.gov>
References: <20170511235002.26468-1-tomcherry@google.com>
 <1494595373.9454.2.camel@tycho.nsa.gov>
From: Tom Cherry <tomcherry@google.com>
Date: Fri, 12 May 2017 11:01:00 -0700
Message-ID: <CAPc65ayVwUbbiqYJY3BJJAaq03d=iVB0q=Jy7A4j3KkNKgz7pw@mail.gmail.com>
Subject: Re: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Elliott Hughes <enh@google.com>,
 William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 12, 2017 at 6:22 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2017-05-11 at 16:50 -0700, Tom Cherry via Selinux wrote:
>> This check is not specific to Android devices. If libselinux were
>> used
>> with Bionic on a normal Linux system this check would still be
>> needed.
>>
>> Signed-off-by: Tom Cherry <tomcherry@google.com>
>
> Thanks, applied.  This was actually switched from ANDROID to _ANDROID__
>  by nnk in 044f6ef104c8a9d8f42faa8756e71a0525198f5b.  We don't appear
> to have any other uses of __ANDROID__, but we do have a number of uses
> of ANDROID.  Offhand though these other uses of ANDROID don't appear to
> be related to bionic but instead reflect differences in SELinux
> userspace integration in Android vs GNU/Linux.  If however your
> bionic/Linux system integrates SELinux support in an Android-like
> manner (e.g. kernel policy file is /sepolicy, no /etc/selinux/config,
> ...), then you might need to generalize those as well.

Thanks!  I took a look at the other ANDROID ifdefs in the code and I'm not sure
how or if they would need to be changed.  This change is needed to get
libselinux building with bionic on the host which is just the first step.

>
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
>>       return syscall(__NR_gettid);
