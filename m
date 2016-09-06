MIME-Version: 1.0
In-Reply-To: <CAFftDdp88gu9GRKEwx0CaRYDzHFV0TUJEig_m7LMh_i-ecEaeA@mail.gmail.com>
References: <1473177066-25068-1-git-send-email-william.c.roberts@intel.com>
 <be59b52a-0086-ee0c-e2e7-0037aa673759@tycho.nsa.gov>
 <CAFftDdqZH8OobTUtUdixwontnOE7qF3vgeeky6huRvb5-h-eeg@mail.gmail.com>
 <708124c7-9c17-0305-08a4-6d5ff0fab9dd@tycho.nsa.gov>
 <CAFftDdoL3Rp0+EV8e0XCcEsMCzQ9VpC_rKy8vZmW16ATey4Yag@mail.gmail.com>
 <CAFftDdp88gu9GRKEwx0CaRYDzHFV0TUJEig_m7LMh_i-ecEaeA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 6 Sep 2016 16:37:13 -0700
Message-ID: <CAFftDdoTG2N33ZPrt0rKHHVZpm6AcWttBY8v+kht_cKZeQqN5g@mail.gmail.com>
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

On Tue, Sep 6, 2016 at 1:43 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> <snip>
>>>>>
>>>>> Also, there are some memory leaks in there; run it under valgrind, e.g.
>>>>> valgrind --leak-check=full matchpathcon /etc
>>>>
>>>> OK I'll run that test.
>>
>> I cant reproduce:
> bad send... Can you send your valgrind output? Are you sure its not there
> prior to my patch? The only heap alloc I add is the strdup, closef should
> always be called despite any flow changes in process_file() as the caller,
> init() always goes to label finish.

Ok I see the condition now, I had to statically link in libselinux to
matchpathcon to get it to not use the system one, even though I set
LD_LIBRARY_PATH.  Once I did that,
I got the leaks. The condition on which it occurs, is because
process_file() can be called N times and reseats the data->path
pointer. This should have been obvious since
mmap area is a linked list.


>
>
> --
> Respectfully,
>
> William C Roberts



-- 
Respectfully,

William C Roberts
