MIME-Version: 1.0
In-Reply-To: <CAFftDdrUEUTPZUgScaeXwGn0-ikLd3m3fO=j-PoxUp0Z56MFYw@mail.gmail.com>
References: <1475172145-16428-1-git-send-email-william.c.roberts@intel.com>
 <365d1e37-3803-7435-647f-3d1d782bcc9f@tycho.nsa.gov>
 <CAFftDdoVFBjOQFzbptB+874-rtRQ5wTQpKOi_hvAoPP+ft4UeA@mail.gmail.com>
 <488e5658-e442-c727-4bf6-0282a1fd4baf@tycho.nsa.gov>
 <CAFftDdqEnCKPT6Jk7TTh0q11tMp2D=GCF0s+sNtYw2wP-3ZdbQ@mail.gmail.com>
 <1b47a228-103d-e673-d10f-4a152243f04c@tycho.nsa.gov>
 <CAFftDdrUEUTPZUgScaeXwGn0-ikLd3m3fO=j-PoxUp0Z56MFYw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 29 Sep 2016 15:27:09 -0400
Message-ID: <CAFftDdrBUqMZuZRPL_GjRSZM4_nvEcV=2Bk1ZA=NcPe_yBofXA@mail.gmail.com>
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

On Thu, Sep 29, 2016 at 3:15 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Sep 29, 2016 at 2:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/29/2016 02:46 PM, William Roberts wrote:
>>> On Thu, Sep 29, 2016 at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 09/29/2016 02:15 PM, William Roberts wrote:
>>>>> On Thu, Sep 29, 2016 at 2:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> On 09/29/2016 02:02 PM, william.c.roberts@intel.com wrote:
>>>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>>>
>>>>>>> Provide stubs to the public boolean API that always returns -1.
>>>>>>>
>>>>>>> On Android, boolean symbols are needed for:
>>>>>>> external/ltrace/sysdeps/linux-gnu/trace.c
>>>>>>
>>>>>> Is this really worth doing?
>>>>>
>>>>> It's this or disabling that selinux via #define, which that source has
>>>>> HAVE_LIBSELINUX.
>>>>>
>>>>> But it would seem confusing IMHO to have a libselinux.so, so one would
>>>>> set HAVE_LIBSELINUX=1,
>>>>> and you're getting link errors.
>>>>
>>>> Maybe I don't understand.  Obviously it builds today with
>>>> external/libselinux without requiring this change.  Why do we need this now?
>>>>
>>>
>>> Richard Haines was doing further testing, and was building a different
>>> lunch target for the
>>> arm emulator and hit this issue. I have only tested x86_64 emulator.
>>
>> No, I mean that this is not required in external/libselinux (the Android
>> fork) today.  So why is it needed here?  The Android fork builds
>> src/booleans.c for the target.  It doesn't hurt anything to leave the
>> code there.  The underlying kernel interface via selinuxfs still exists.
>>  There just won't be any booleans in the policy.
>>
>
> The target builds a modified booleans, if use booleans as is, we start
> down the config c file
> rabbit hole...
>
> external/selinux/libselinux/src/booleans.c:100: error: undefined
> reference to 'selinux_booleans_subs_path'
> external/selinux/libselinux/src/booleans.c:388: error: undefined
> reference to 'selinux_booleans_path'
> external/selinux/libselinux/src/booleans.c:529: error: undefined
> reference to 'selinux_booleans_path'
> external/selinux/libselinux/src/booleans.c:545: error: undefined
> reference to 'selinux_booleans_path'
> clang++.real: error: linker command failed with exit code 1 (use -v to
> see invocation)
>
> I can take a look at that and see how much of a PITA it would be to
> pull that in.

external/selinux/libselinux/src/selinux_config.c:100: error: undefined
reference to 'fgets_unlocked'
external/selinux/libselinux/src/selinux_config.c:100: error: undefined
reference to 'fgets_unlocked'
external/selinux/libselinux/src/selinux_config.c:231: error: undefined
reference to 'require_seusers'
external/selinux/libselinux/src/selinux_config.c:231: error: undefined
reference to 'load_setlocaldefs'

fgets should be easy enough
load_setlocaldefs is an exported integer value used in init_selinux_config()
require_seusers is another exported int form seusers.c

I was figuring since we don't use any bools, to keep the size down,
just stubbing dummies is the
easiest route.

We could do something like STATIC_CONFIG and just stub in what things
need and return the explicit paths.

-- 
Respectfully,

William C Roberts
