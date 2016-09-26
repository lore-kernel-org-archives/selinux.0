MIME-Version: 1.0
In-Reply-To: <60891df7-2932-7d9a-d2d7-5252a0ccc946@tycho.nsa.gov>
References: <1474899756-93610-1-git-send-email-jdanis@android.com>
 <1474899756-93610-3-git-send-email-jdanis@android.com>
 <60891df7-2932-7d9a-d2d7-5252a0ccc946@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 26 Sep 2016 10:47:28 -0700
Message-ID: <CAFftDdrc5SbfJDOoASae005J860p4eViN5LWOTvCw8oV2-r2fA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libselinux: sefcontext_compile invert semantics of
 "-r" flag
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Janis Danisevskis <jdanis@android.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>, Janis Danisevskis <jdanis@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 26, 2016 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/26/2016 10:22 AM, Janis Danisevskis wrote:
>> The "-r" flag of sefcontext_compile now causes it to omit the
>> precompiled regular expressions from the output.
>
> The code itself looks ok, aside from William's suggestion. Experimenting
> with this a bit, I noticed the following difference in sizes among the
> various options:
>
> 383165  file_contexts (text)
> 1507941 file_contexts.bin (binary with pcre1 regexes)
> 8304105 file_contexts.bin (binary with pcre2 regexes)
> 540540  file_contexts.bin (binary omitting pcre2 regexes, via -r)
>
> The increase in file_contexts.bin size from pcre1 to pcre2 (unless using
> -r) is quite substantial.  Wondering how that affects the cost/benefit
> tradeoff...

I think a lot of it might be with how complex your regex's are. Android is
pretty simple, which shows, as textual and binary load times are
pretty close. I think judicious use of -r and knowing what works best for
your arch/build/fc entries,  at the moment, is likely required.

<snip>
