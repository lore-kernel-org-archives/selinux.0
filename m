MIME-Version: 1.0
In-Reply-To: <365d1e37-3803-7435-647f-3d1d782bcc9f@tycho.nsa.gov>
References: <1475172145-16428-1-git-send-email-william.c.roberts@intel.com>
 <365d1e37-3803-7435-647f-3d1d782bcc9f@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 29 Sep 2016 14:15:28 -0400
Message-ID: <CAFftDdoVFBjOQFzbptB+874-rtRQ5wTQpKOi_hvAoPP+ft4UeA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: re-introduce DISABLE_BOOL=y
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 29, 2016 at 2:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/29/2016 02:02 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> Provide stubs to the public boolean API that always returns -1.
>>
>> On Android, boolean symbols are needed for:
>> external/ltrace/sysdeps/linux-gnu/trace.c
>
> Is this really worth doing?

It's this or disabling that selinux via #define, which that source has
HAVE_LIBSELINUX.

But it would seem confusing IMHO to have a libselinux.so, so one would
set HAVE_LIBSELINUX=1,
and you're getting link errors.

Seems to be yet-another red-hat contribution from a long time ago:

commit cec06ec8282c538a40bde968ae36fe8356daffaa
Author: Petr Machata <pmachata@redhat.com>
Date:   Tue Apr 10 13:31:55 2012 +0200

    Warn when we fail to trace and SELinux boolean deny_ptrace is in effect

diff --git a/ChangeLog b/ChangeLog
index c095263..6107a12 100644

>
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libselinux/Makefile       |  4 +++
>>  libselinux/src/booleans.c | 64 +++++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 58 insertions(+), 10 deletions(-)
>>
>> diff --git a/libselinux/Makefile b/libselinux/Makefile
>> index f607115..b5f32bb 100644
>> --- a/libselinux/Makefile
>> +++ b/libselinux/Makefile
>> @@ -5,6 +5,7 @@ DISABLE_RPM ?= y
>>  ANDROID_HOST ?= n
>>  ifeq ($(ANDROID_HOST),y)
>>       override DISABLE_SETRANS=y
>> +     override DISABLE_BOOL=y
>>  endif
>>  ifeq ($(DISABLE_RPM),y)
>>       DISABLE_FLAGS+= -DDISABLE_RPM
>> @@ -12,6 +13,9 @@ endif
>>  ifeq ($(DISABLE_SETRANS),y)
>>       DISABLE_FLAGS+= -DDISABLE_SETRANS
>>  endif
>> +ifeq ($(DISABLE_BOOL),y)
>> +     DISABLE_FLAGS+= -DDISABLE_BOOL
>> +endif
>>  export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
>>
>>  USE_PCRE2 ?= n
>> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
>> index c438af1..cbb0610 100644
>> --- a/libselinux/src/booleans.c
>> +++ b/libselinux/src/booleans.c
>> @@ -25,6 +25,8 @@
>>
>>  #define SELINUX_BOOL_DIR "/booleans/"
>>
>> +#ifndef DISABLE_BOOL
>> +
>>  static int filename_select(const struct dirent *d)
>>  {
>>       if (d->d_name[0] == '.'
>> @@ -85,8 +87,6 @@ int security_get_boolean_names(char ***names, int *len)
>>       goto out;
>>  }
>>
>> -hidden_def(security_get_boolean_names)
>> -
>>  char *selinux_boolean_sub(const char *name)
>>  {
>>       char *sub = NULL;
>> @@ -141,8 +141,6 @@ out:
>>       return sub;
>>  }
>>
>> -hidden_def(selinux_boolean_sub)
>> -
>>  static int bool_open(const char *name, int flag) {
>>       char *fname = NULL;
>>       char *alt_name = NULL;
>> @@ -262,8 +260,6 @@ int security_get_boolean_active(const char *name)
>>       return val;
>>  }
>>
>> -hidden_def(security_get_boolean_active)
>> -
>>  int security_set_boolean(const char *name, int value)
>>  {
>>       int fd, ret;
>> @@ -297,8 +293,6 @@ int security_set_boolean(const char *name, int value)
>>               return -1;
>>  }
>>
>> -hidden_def(security_set_boolean)
>> -
>>  int security_commit_booleans(void)
>>  {
>>       int fd, ret;
>> @@ -327,8 +321,6 @@ int security_commit_booleans(void)
>>               return -1;
>>  }
>>
>> -hidden_def(security_commit_booleans)
>> -
>>  static char *strtrim(char *dest, char *source, int size)
>>  {
>>       int i = 0;
>> @@ -567,3 +559,55 @@ int security_load_booleans(char *path)
>>               errno = EINVAL;
>>       return errors ? -1 : 0;
>>  }
>> +
>> +#else
>> +int security_set_boolean_list(size_t boolcnt __attribute__((unused)),
>> +     SELboolean * boollist __attribute__((unused)),
>> +     int permanent __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_load_booleans(char *path __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_get_boolean_names(char ***names __attribute__((unused)),
>> +     int *len __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_get_boolean_pending(const char *name __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_get_boolean_active(const char *name __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_set_boolean(const char *name __attribute__((unused)),
>> +     int value __attribute__((unused)))
>> +{
>> +     return -1;
>> +}
>> +
>> +int security_commit_booleans(void)
>> +{
>> +     return -1;
>> +}
>> +
>> +char *selinux_boolean_sub(const char *name __attribute__((unused)))
>> +{
>> +     return NULL;
>> +}
>> +#endif
>> +
>> +hidden_def(security_get_boolean_names)
>> +hidden_def(selinux_boolean_sub)
>> +hidden_def(security_get_boolean_active)
>> +hidden_def(security_set_boolean)
>> +hidden_def(security_commit_booleans)
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
