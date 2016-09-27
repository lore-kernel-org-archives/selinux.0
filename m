MIME-Version: 1.0
In-Reply-To: <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 08:08:00 -0700
Message-ID: <CAFftDdqUs82JM2JCxbFFxre62hc-PNM7rYoKAMrxMfcUiuheQA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add ANDROID_HOST=y build option
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 27, 2016 at 7:11 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/26/2016 04:53 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> To build the selinux host configuration, specify
>> ANDROID_HOST=y on the Make command line.
>>
>> eg)
>> make ANDROID_HOST=y
>
> Seems oddly named, neither corresponding to the #define it enables
> (BUILD_HOST) nor to the target platform.

We could change this to BUILD_HOST=y to enable all of it, but considering
that this build is specific for Android, I thought the naming to be more
appropriate.

Additionally, EMBEDDED doesn't flip anything called EMBEDDED as well.

>
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libselinux/Makefile     |  8 +++++++-
>>  libselinux/src/Makefile | 50 +++++++++++++++++++++++++++++++++----------------
>>  2 files changed, 41 insertions(+), 17 deletions(-)
>>
>> diff --git a/libselinux/Makefile b/libselinux/Makefile
>> index 5a8d42c..50ae009 100644
>> --- a/libselinux/Makefile
>> +++ b/libselinux/Makefile
>> @@ -10,6 +10,12 @@ ifeq ($(EMBEDDED),y)
>>       override DISABLE_RPM=y
>>       override DISABLE_BOOL=y
>>  endif
>> +ifeq ($(ANDROID_HOST),y)
>> +     override DISABLE_SETRANS=y
>> +     EMFLAGS+= -DDISABLE_RPM -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
>> +             -DBUILD_HOST
>> +     SUBDIRS = src
>> +endif
>
> Don't you actually want to also pick up utils/sefcontext_compile?
> That is built and used on the build host.  And I'm not sure why we'd
> drop the other SUBDIRS.

You'll start running into linking issues if things that use
libselinux, use something not
in the build host IIRC. Perhaps, if that is the issue, we just limit
it to sefcontext_compile.

>
>>  ifeq ($(DISABLE_AVC),y)
>>       EMFLAGS+= -DDISABLE_AVC
>>  endif
>> @@ -22,7 +28,7 @@ endif
>>  ifeq ($(DISABLE_SETRANS),y)
>>       EMFLAGS+= -DDISABLE_SETRANS
>>  endif
>> -export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
>> +export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS ANDROID_HOST
>>
>>  USE_PCRE2 ?= n
>>  ifeq ($(USE_PCRE2),y)
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index 36e42b8..d841ef7 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -47,9 +47,17 @@ endif
>>  ifeq ($(DISABLE_BOOL),y)
>>       UNUSED_SRCS+=booleans.c
>>  endif
>> +ifeq ($(ANDROID_HOST),y)
>> +     SRCS=callbacks.c freecon.c label.c label_file.c \
>> +                     label_android_property.c regex.c label_support.c \
>> +                     matchpathcon.c setrans_client.c sha1.c
>> +     override CFLAGS += -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
>> +                     -DBUILD_HOST
>> +else
>> +     SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>> +endif
>>
>>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
>> -SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>>
>>  MAX_STACK_SIZE=32768
>>
>> @@ -92,6 +100,28 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(EMFLAGS)
>>
>>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(EMFLAGS)
>>
>> +$(LIBA): $(OBJS)
>> +     $(AR) rcs $@ $^
>> +     $(RANLIB) $@
>> +
>> +$(LIBSO): $(LOBJS)
>> +     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
>> +     ln -sf $@ $(TARGET)
>> +
>> +%.o:  %.c policy.h
>> +     $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>> +
>> +%.lo:  %.c policy.h
>> +     $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
> Did these truly need to move?  I don't see why.

this prevents us from having multiple definitions of the recipes or
multiple if's on ANDROID_HOST=y.
Both flavors need these wildcard targets.

>
>> +
>> +# ANDROID_HOST Build option only builds the shared and static versions of
>> +# libselinux.
>> +ifeq ($(ANDROID_HOST),y)
>> +
>> +all: $(LIBA) $(LIBSO)
>> +
>> +else
>> +
>>  all: $(LIBA) $(LIBSO) $(LIBPC)
>
> Is this worthwhile/necessary?  The point of the build option IIUC is
> just to allow upstream testing that the Android build host version will
> still build, it shouldn't matter if there are extras.

Those things die on linking... so I didn't want to submit something
where Make returns not 0.

>
>>
>>  pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
>> @@ -110,14 +140,6 @@ $(SWIGSO): $(SWIGLOBJ)
>>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>>       $(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
>>
>> -$(LIBA): $(OBJS)
>> -     $(AR) rcs $@ $^
>> -     $(RANLIB) $@
>> -
>> -$(LIBSO): $(LOBJS)
>> -     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
>> -     ln -sf $@ $(TARGET)
>> -
>>  $(LIBPC): $(LIBPC).in ../VERSION
>>       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
>>
>> @@ -130,12 +152,6 @@ $(AUDIT2WHYLOBJ): audit2why.c
>>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
>>       $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
>>
>> -%.o:  %.c policy.h
>> -     $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>> -
>> -%.lo:  %.c policy.h
>> -     $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>> -
>>  $(SWIGCOUT): $(SWIGIF)
>>       $(SWIG) $<
>>
>> @@ -178,4 +194,6 @@ distclean: clean
>>  indent:
>>       ../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>>
>> -.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
>> +.PHONY: clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
>> +endif
>> +.PHONY: all
>
> Why is this needed?

The targets for %.o and %.lo are used on all build targets, the rest
is committed on ANDROID_HOST=y.
So for the stuff that is separated out, we have a .PHONY for it. For
the things the define in common,
notably ALL, we have a shared .PHONY for them.

>
> BTW, this option can be dangerous.  Don't build with it and then do a
> make install later without doing a make clean - you'll brick your Linux
> system ;(

That is true, but isn't that the point of SE Linux :-P. Kidding aside,
perhaps we
could create a guard file that's checked on install, if its there, you need to
run make clean first.
