MIME-Version: 1.0
In-Reply-To: <b092c650-20da-f76f-9af1-0f30bbc76458@tycho.nsa.gov>
References: <1478031804-13993-1-git-send-email-william.c.roberts@intel.com>
 <b092c650-20da-f76f-9af1-0f30bbc76458@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 1 Nov 2016 13:32:29 -0700
Message-ID: <CAFftDdoD-YY1fimeuHZ=O41VVoDD=S4s=71_7WckMTsA7x901A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix compiler flags for linux + clang
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Nicolas Iooss <nicolas.iooss@m4x.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 1, 2016 at 1:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/01/2016 04:23 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> As reported by Nicolas Iooss, the clang + linux build seems
>> broken:
>>
>>  clang-3.9: warning: argument unused during compilation: '-undefined
>> dynamic_lookup'
>>   /usr/bin/ld: unrecognised option: -install_name
>>   clang-3.9: error: linker command failed with exit code 1 (use -v to
>> see invocation)
>>
>> We already have those options set for Darwin, just drop them from the
>> clang side.
>
> Thanks, applied.

Did you check this with clang-3.9 locally and reproduce the error?

>
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libselinux/src/Makefile | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index ae40f80..b92fe1c 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -73,13 +73,12 @@ override CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync
>>       -Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE=2
>>  else
>>  override CFLAGS += -Wunused-command-line-argument
>> -override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
>> -LD_SONAME_FLAGS=-install_name,$(LIBSO)
>>  endif
>>
>>  ifeq ($(OS), Darwin)
>>  override CFLAGS += -I/opt/local/include
>>  override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
>> +LD_SONAME_FLAGS=-install_name,$(LIBSO)
>>  endif
>>
>>  PCRE_LDFLAGS ?= -lpcre
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
