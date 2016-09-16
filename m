Subject: Re: [PATCH v3] libselinux: correct error path to always try text
To: William Roberts <bill.c.roberts@gmail.com>
References: <1473981238-11051-1-git-send-email-william.c.roberts@intel.com>
 <da997806-a400-6fc8-b736-a7aca1b1dea9@tycho.nsa.gov>
 <8bdcbbeb-5497-c6ec-0d29-2be57cd57f2e@tycho.nsa.gov>
 <CAFftDdp9eoM5nR1MuUjdWJ1XXGonisd0eF8xT=FzTLufS_RFZg@mail.gmail.com>
 <CAFftDdqFa_Pps5bTWfQv_sPJg6SuFKZj63Je_SM42VYXfML53w@mail.gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <012f1855-bae3-c8ae-6426-6caf68447e6b@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 11:00:47 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqFa_Pps5bTWfQv_sPJg6SuFKZj63Je_SM42VYXfML53w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2016 10:44 AM, William Roberts wrote:
> On Fri, Sep 16, 2016 at 7:41 AM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Fri, Sep 16, 2016 at 7:38 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 09/16/2016 10:30 AM, Stephen Smalley wrote:
>>>> On 09/15/2016 07:13 PM, william.c.roberts@intel.com wrote:
>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>
>>>>> patch 5e15a52aaa cleans up the process_file() but introduced
>>>>> a bug. If the binary file cannot be opened, always attempt
>>>>> to fall back to the textual file, this was not occurring.
>>>>>
>>>>> The logic should be:
>>>>> 1. Open the newest file based on base path + suffix vs
>>>>>    base_path + suffix + ".bin".
>>>>> 2. If anything fails, attempt base_path + suffix.
>>>>>
>>>>> In the case that the file_contexts was the newest file and
>>>>> used for processing fails, it will attempt the same failure
>>>>> recovery, which will fail. It was decided to keep it this
>>>>> was for simplicity.
>>>>
>>>> I don't like the approach.  What we want is:
>>>> - if .bin file exists and is not older, try to load it,
>>>> - if any of the above fails (i.e. .bin file does not exist, is older, or
>>>> cannot be loaded for any reason), then load the text file.
>>>>
>>>> We shouldn't try loading the text file twice.
>>>>
>>>> Also, attached is checkpatch output for your patch.  Please fix.
>>>
>>> Also, there is a further wrinkle: Android passes in file_contexts.bin as
>>> the SELABEL_OPT_PATH, so that is the base path.  Under the old logic
>>> (before your original clean up patch), we would open that file, detect
>>> that it is binary, and then load it.  Under the current logic, we'll
>>> open file_contexts.bin, then try to open file_contexts.bin.bin (which
>>> will fail), and then use the first one.
>>
>> Not true, I don't try to open it, I try to stat it.
> 
> My code never assumes file suffix == type
> 
>>
>>>
>>> Wondering if we just need to revert.
>>
>> If you want to revert I have no problem with that, but I provided IMO
>> a valid fix.
>> Since I won't likely have a next version patch out till after you go
>> home today, I
>> would support reverting.

Unfortunately it is now entangled with Janis' patch.  Let's do this: fix
the coding style issues I sent to you from checkpatch, and we'll take
this one.  Then we'll look to avoid the extraneous load in a subsequent
patch.
