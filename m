Subject: Re: [PATCH] libselinux: re-introduce DISABLE_BOOL=y
To: William Roberts <bill.c.roberts@gmail.com>
References: <1475172145-16428-1-git-send-email-william.c.roberts@intel.com>
 <365d1e37-3803-7435-647f-3d1d782bcc9f@tycho.nsa.gov>
 <CAFftDdoVFBjOQFzbptB+874-rtRQ5wTQpKOi_hvAoPP+ft4UeA@mail.gmail.com>
 <488e5658-e442-c727-4bf6-0282a1fd4baf@tycho.nsa.gov>
 <CAFftDdqEnCKPT6Jk7TTh0q11tMp2D=GCF0s+sNtYw2wP-3ZdbQ@mail.gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1b47a228-103d-e673-d10f-4a152243f04c@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 14:54:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqEnCKPT6Jk7TTh0q11tMp2D=GCF0s+sNtYw2wP-3ZdbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2016 02:46 PM, William Roberts wrote:
> On Thu, Sep 29, 2016 at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/29/2016 02:15 PM, William Roberts wrote:
>>> On Thu, Sep 29, 2016 at 2:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 09/29/2016 02:02 PM, william.c.roberts@intel.com wrote:
>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>
>>>>> Provide stubs to the public boolean API that always returns -1.
>>>>>
>>>>> On Android, boolean symbols are needed for:
>>>>> external/ltrace/sysdeps/linux-gnu/trace.c
>>>>
>>>> Is this really worth doing?
>>>
>>> It's this or disabling that selinux via #define, which that source has
>>> HAVE_LIBSELINUX.
>>>
>>> But it would seem confusing IMHO to have a libselinux.so, so one would
>>> set HAVE_LIBSELINUX=1,
>>> and you're getting link errors.
>>
>> Maybe I don't understand.  Obviously it builds today with
>> external/libselinux without requiring this change.  Why do we need this now?
>>
> 
> Richard Haines was doing further testing, and was building a different
> lunch target for the
> arm emulator and hit this issue. I have only tested x86_64 emulator.

No, I mean that this is not required in external/libselinux (the Android
fork) today.  So why is it needed here?  The Android fork builds
src/booleans.c for the target.  It doesn't hurt anything to leave the
code there.  The underlying kernel interface via selinuxfs still exists.
 There just won't be any booleans in the policy.
