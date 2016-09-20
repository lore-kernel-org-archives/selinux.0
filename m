Subject: Re: [RFC] mmap file_contexts and property_contexts:
To: William Roberts <bill.c.roberts@gmail.com>,
 Jason Zaman <jason@perfinion.com>
References: <1474321526-26208-1-git-send-email-william.c.roberts@intel.com>
 <CAPuKSJb7wj7CrZKMh8snwHAr00Hr+8OKhFjoGGq-uEbHA=v9KQ@mail.gmail.com>
 <CAFftDdr4PAa1P=9AOZzDB23HX5bHuOmgjY-S+nzAv+BvXjnoGw@mail.gmail.com>
 <CAPuKSJbKOAO1eRRD-=f6Zx0XoQOT3xVNGD7qLvBPXSWZJef00g@mail.gmail.com>
 <CAFftDdoLn_DNz50+YfYXDDjKi9wex+wo78kcHpMrGmJparGBmw@mail.gmail.com>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f39c114f-08d0-61e4-bd80-bbbc31eec97c@tycho.nsa.gov>
Date: Tue, 20 Sep 2016 08:47:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdoLn_DNz50+YfYXDDjKi9wex+wo78kcHpMrGmJparGBmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/20/2016 02:27 AM, William Roberts wrote:
> On Sep 19, 2016 22:25, "Jason Zaman" <jason@perfinion.com> wrote:
>>
>> On 20 Sep 2016 12:50 pm, "William Roberts" <bill.c.roberts@gmail.com>
> wrote:
>>>
>>> On Sep 19, 2016 21:16, "Jason Zaman" <jason@perfinion.com> wrote:
>>>>
>>>> On 20 Sep 2016 5:47 am, <william.c.roberts@intel.com> wrote:
>>>>>
>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>
>>>>> THIS IS WIP...
>>>>>
>>>>> Rather than using stdio and making copies, just mmap the files
>>>>> and use the pointers in place. The affect of this change, is that
>>>>> text file load time is now faster than binary load time by 4.7%
>>>>> when testing with a file_contexts file from the Android tree. Note
>>>>> that the Android doesn't use monstrous regexs.
>>>>>
>>>>> Times are the average of 3 runs.
>>>>>
>>>>> BEFORE:
>>>>> Text file allocs: 114803
>>>>> Text file load time: 0.266101
>>>>> Bin file allocs: 93073
>>>>> Bin file load time: 0.248757667
>>>>>
>>>>> AFTER:
>>>>> Text file allocs: 103933
>>>>> Text file load time: 0.236192667
>>>>> Bin file allocs: 87645
>>>>> Bin file load time: .247607333
>>>>
>>>> Do you have the scripts that generated these stats so I can play with
> it too? These stats are from android right? Do you also have a comparison
> for refpolicy too?
>>>
>>> For generating these I used checkfc.c from the Android tree. I used
> valgrind to measure allocations and clock to measure the time in
> selabel_open().
>>
>> Okay cool I'll fetch that and give it a whirl when I get time.
>>
>>>>
>>>> I haven't looked that closely yet but just realised, will this need
> new perms because of the mmap? If it does, can you send a patch to
> refpolicy?
>>>
>>> I'm confused, mmap is not a permission, even if it was the binary path
> already was doing an mmap, so the permission would have been there. We're
> just making it so it always mmaps.
>>
>> Yeah but mmap needs execute perms sometimes (always?). I am out so just
> wanted to send an email before I forgot. If it was mmaping already then
> there is nothing to worry about :).
> 
> Mmap would only need execute if you attempted to set the prot bits to
> execute it use mprotect to change the mapping. Then things like execmod
> might come I to play if the mapping was ever writable.

The only case where mmap without PROT_EXEC would require execute would
be if the process has READ_IMPLIES_EXEC set in its personality.
Typically only for programs with the executable stack flag set.

Anyway, it is already mmap'ing file_contexts.bin so there shouldn't be
an issue here.
