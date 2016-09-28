Subject: Re: [PATCH] libselinux: android: fix lax service context lookup
To: William Roberts <bill.c.roberts@gmail.com>
References: <1475078690-42486-1-git-send-email-jdanis@android.com>
 <1a53409d-1773-187b-e0cb-d49c8ac2d1a2@tycho.nsa.gov>
 <CAFftDdriwJu2_2H-+8m7gJLZSH9Uy8E7fn--VwFWV9piL209dw@mail.gmail.com>
 <8a6a3400-7e97-0633-9a64-3a8c3ce1c84d@tycho.nsa.gov>
 <CAFftDdrNhCLCPaUmhq8x7YEiSoDo1nwY79t+OAdeN4yC1YTgRw@mail.gmail.com>
Cc: Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <57215cf7-d61f-5e7c-5473-725cfd405679@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 12:50:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdrNhCLCPaUmhq8x7YEiSoDo1nwY79t+OAdeN4yC1YTgRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 12:43 PM, William Roberts wrote:
> On Wed, Sep 28, 2016 at 12:42 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/28/2016 12:25 PM, William Roberts wrote:
>>> On Wed, Sep 28, 2016 at 12:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 09/28/2016 12:04 PM, Janis Danisevskis wrote:
>>>>> We use the same lookup function for service contexts
>>>>> that we use for property contexts. However, property
>>>>> contexts are namespace based and only compare the
>>>>> prefix. This may lead to service associations with
>>>>> a wrong label.
>>>>>
>>>>> This patch introduces a stricter lookup function for
>>>>> services contexts. Now the service name must match
>>>>> the key of the service label exactly.
>>>>>
>>>>> Signed-off-by: Janis Danisevskis <jdanis@android.com>
>>>>> ---
>>>>>  libselinux/include/selinux/label.h      |  2 ++
>>>>>  libselinux/src/label.c                  |  1 +
>>>>>  libselinux/src/label_android_property.c | 50 +++++++++++++++++++++++++++++++++
>>>>>  libselinux/src/label_internal.h         |  3 ++
>>>>>  4 files changed, 56 insertions(+)
>>>>
>>>> Normally each backend would go into its own file, so service would get
>>>> its own.  Alternatively, since we are unlikely to ever support one
>>>> without the other, perhaps label_android_property.c should be renamed to
>>>> label_android.c and contain all of the Android-unique backends.
>>>>
>>>>>
>>>>> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
>>>>> index f0b1e10..277287e 100644
>>>>> --- a/libselinux/include/selinux/label.h
>>>>> +++ b/libselinux/include/selinux/label.h
>>>>> @@ -34,6 +34,8 @@ struct selabel_handle;
>>>>>  #define SELABEL_CTX_DB               3
>>>>>  /* Android property service contexts */
>>>>>  #define SELABEL_CTX_ANDROID_PROP 4
>>>>> +/* Android service contexts */
>>>>> +#define SELABEL_CTX_ANDROID_SERVICE 5
>>>>>
>>>>>  /*
>>>>>   * Available options
>>>>> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
>>>>> index 96a4ff1..eb0e766 100644
>>>>> --- a/libselinux/src/label.c
>>>>> +++ b/libselinux/src/label.c
>>>>> @@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] = {
>>>>>       CONFIG_X_BACKEND(selabel_x_init),
>>>>>       CONFIG_DB_BACKEND(selabel_db_init),
>>>>>       &selabel_property_init,
>>>>> +     &selabel_service_init,
>>>>
>>>> Wondering if we should support selective enablement of the property and
>>>> service backends too, similar to what William introduced for media, x,
>>>> and db so that he could disable them on Android (in our case, so we can
>>>> disable property and service backends on Linux distributions).
>>>
>>> I was wondering that too, im for it. If ANDROID_HOST patch is applied, we
>>> should just set the defaults to strip them out and only on ANDROID_HOST=y
>>> add them in.
>>>
>>> We'd also need to coordinate with the AOSP patches, but I can
>>> routinely update those
>>> based on whats going on.
>>
>> I could be wrong, but I think we only need the property and service
>> backends on the target, not on the build host.  The file backend is
>> needed on the build host to label the filesystem images when they are
>> created.  We are likely only building the property backend on the host
>> because we don't allow conditionally excluding it presently.
> 
> checkfc I thought uses them for checking property and service backends?

Ah, you're right.  Never mind...
