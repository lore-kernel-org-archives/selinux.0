MIME-Version: 1.0
In-Reply-To: <708124c7-9c17-0305-08a4-6d5ff0fab9dd@tycho.nsa.gov>
References: <1473177066-25068-1-git-send-email-william.c.roberts@intel.com>
 <be59b52a-0086-ee0c-e2e7-0037aa673759@tycho.nsa.gov>
 <CAFftDdqZH8OobTUtUdixwontnOE7qF3vgeeky6huRvb5-h-eeg@mail.gmail.com>
 <708124c7-9c17-0305-08a4-6d5ff0fab9dd@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 6 Sep 2016 13:41:12 -0700
Message-ID: <CAFftDdoL3Rp0+EV8e0XCcEsMCzQ9VpC_rKy8vZmW16ATey4Yag@mail.gmail.com>
Subject: Re: [PATCH] libselinux: clean up process file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 James Carter <jwcart2@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 6, 2016 at 1:22 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/06/2016 04:06 PM, William Roberts wrote:
>> On Sep 6, 2016 13:01, "Stephen Smalley" <sds@tycho.nsa.gov
>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>
>>> On 09/06/2016 11:51 AM, william.c.roberts@intel.com
>> <mailto:william.c.roberts@intel.com> wrote:
>>> > From: William Roberts <william.c.roberts@intel.com
>> <mailto:william.c.roberts@intel.com>>
>>> >
>>> > The current process_file() code will open the file
>>> > twice on the case of a binary file, correct this.
>>> >
>>> > The general flow through process_file() was a bit
>>> > difficult to read, streamline the routine to be
>>> > more readable.
>>> >
>>> > Detailed statistics of before and after:
>>> >
>>> > Source lines of code reported by cloc on modified files:
>>> > before: 1090
>>> > after: 1102
>>> >
>>> > Object size difference:
>>> > before: 195530 bytes
>>> > after:  195563 bytes
>>>
>>> Old logic would use the .bin file as long as it is not older than the
>>> base file; new logic will only use the .bin file if it is newer.  The
>>> end result on my system was that it was using the text file instead.
>>
>> I'm not following here. I spent a lot of time with strace comparing old
>> vs new behavior here. If x and x.bin exist, it should use x.bin if it's
>> newer or the same age as x? Is that correct?
>
> Yes.  strace before shows that it opens the text file and the bin file,
> and then proceeds to map the bin file and close the text file without
> processing it.  strace after shows that it stats them both and only
> opens the text file.  The st_mtime values are the same (possibly we
> ought to be comparing the full st_mtim with nanosecond precision
> instead, but regardless, if equal, we ought to use the bin file) because
> we now generate the bin file in the sandbox and then copy them both to
> /etc/selinux at the same time (commit
> a7334eb0de98af11ec38b6263536fa01bc2a606c).  You wouldn't see that if
> your policy was last built/updated with the older selinux userspace
> prior to that commit; if you run semodule -B after installing the
> current userspace, you will get that behavior.

Ok this should be simple enough the > should go to >= for the mtime comparison.
We can change the granularity in a separate patch, if you'd like.

>
>>
>>>
>>> Also, there are some memory leaks in there; run it under valgrind, e.g.
>>> valgrind --leak-check=full matchpathcon /etc
>>
>> OK I'll run that test.

I cant reproduce:


<snip>
