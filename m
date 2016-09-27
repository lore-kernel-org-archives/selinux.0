Subject: Re: [PATCH v2] libselinux: add ANDROID_HOST=y build option
To: William Roberts <bill.c.roberts@gmail.com>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
 <CAFftDdqUs82JM2JCxbFFxre62hc-PNM7rYoKAMrxMfcUiuheQA@mail.gmail.com>
 <f68e3901-7d0b-524b-51d8-2488e8ffa60b@tycho.nsa.gov>
 <CAFftDdoo+jvceEquA1xWp8g1-aDyZCm1FOA47h3chMbFH34UQA@mail.gmail.com>
 <af9ea369-000a-92d7-16ca-506b98f6ce7e@tycho.nsa.gov>
 <CAFftDdpBfcsM40is_Si4sRz35Qwi4ZvruxfzOx9+vNG=qYwDWw@mail.gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8a8905dc-913a-c1e9-bef0-78f97de7c331@tycho.nsa.gov>
Date: Tue, 27 Sep 2016 15:08:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdpBfcsM40is_Si4sRz35Qwi4ZvruxfzOx9+vNG=qYwDWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/27/2016 03:03 PM, William Roberts wrote:
> On Tue, Sep 27, 2016 at 11:51 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/27/2016 02:43 PM, William Roberts wrote:
>>> On Sep 27, 2016 10:00, "Stephen Smalley" <sds@tycho.nsa.gov
>>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>>
>>>> On 09/27/2016 11:08 AM, William Roberts wrote:
>>>>> On Tue, Sep 27, 2016 at 7:11 AM, Stephen Smalley <sds@tycho.nsa.gov
>>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>>>> On 09/26/2016 04:53 PM, william.c.roberts@intel.com
>>> <mailto:william.c.roberts@intel.com> wrote:
>>>>>>> From: William Roberts <william.c.roberts@intel.com
>>> <mailto:william.c.roberts@intel.com>>
>>>>>>>
>>>>>>> To build the selinux host configuration, specify
>>>>>>> ANDROID_HOST=y on the Make command line.
>>>>>>>
>>>>>>> eg)
>>>>>>> make ANDROID_HOST=y
>>>>>>
>>>>>> Seems oddly named, neither corresponding to the #define it enables
>>>>>> (BUILD_HOST) nor to the target platform.
>>>>>
>>>>> We could change this to BUILD_HOST=y to enable all of it, but
>>> considering
>>>>> that this build is specific for Android, I thought the naming to be more
>>>>> appropriate.
>>>>>
>>>>> Additionally, EMBEDDED doesn't flip anything called EMBEDDED as well.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: William Roberts <william.c.roberts@intel.com
>>> <mailto:william.c.roberts@intel.com>>
>>>>>>> ---
>>>>>>>  libselinux/Makefile     |  8 +++++++-
>>>>>>>  libselinux/src/Makefile | 50
>>> +++++++++++++++++++++++++++++++++----------------
>>>>>>>  2 files changed, 41 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/libselinux/Makefile b/libselinux/Makefile
>>>>>>> index 5a8d42c..50ae009 100644
>>>>>>> --- a/libselinux/Makefile
>>>>>>> +++ b/libselinux/Makefile
>>>>>>> @@ -10,6 +10,12 @@ ifeq ($(EMBEDDED),y)
>>>>>>>       override DISABLE_RPM=y
>>>>>>>       override DISABLE_BOOL=y
>>>>>>>  endif
>>>>>>> +ifeq ($(ANDROID_HOST),y)
>>>>>>> +     override DISABLE_SETRANS=y
>>>>>>> +     EMFLAGS+= -DDISABLE_RPM -DNO_MEDIA_BACKEND -DNO_DB_BACKEND
>>> -DNO_X_BACKEND \
>>>>>>> +             -DBUILD_HOST
>>>>>>> +     SUBDIRS = src
>>>>>>> +endif
>>>>
>>>> Also, this is redundant; you can handle it entirely within
>>>> libselinux/src/Makefile without anything here.
>>>
>>> You mean all the ANDROID _HOST stuff? I didn't want to depart from
>>> what's there, that seemed to be the spot for disabling things.
>>
>> You don't use the -DNO_*_BACKEND or -DBUILD_HOST flags anywhere except
>> in src/Makefile, so you don't need to set them here.
>>
> 
> The same could be said about DISABLE_SETRANS

It isn't set in both Makefiles.  Pick one.
