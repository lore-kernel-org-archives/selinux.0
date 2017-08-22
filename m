MIME-Version: 1.0
In-Reply-To: <1503406104.5873.5.camel@tycho.nsa.gov>
References: <31471503404136@web31o.yandex.ru>
 <1503406104.5873.5.camel@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 22 Aug 2017 12:34:04 -0700
Message-ID: <CAFftDdpZbbv6KrNV-Zfj+i2iggxrALqr2oo8gGqY94AL9Cxtaw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Sky Autumn <autumnsky00@yandex.ru>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: file_contexts non-ascii error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 22, 2017 at 5:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-08-22 at 15:15 +0300, Sky Autumn wrote:
>> Hello, everyone.
>> There's my problem. When I try to set label on directory with russian
>> letters in name with policy module, the following error occur:
>>  /etc/selinux/final/targeted/contexts/files/file_contexts:  line 5206
>> error due to: Non-ASCII characters found
>>
>> On other machine it works fine. libselinux version on first machine
>> 2.5-6, on second 2.2.2-6. Can I somehow install such policy on first
>> machine without renaming directory? Thank you.
>
> The check for non-ASCII characters was introduced by the following
> commit:
>
> commit 2981e0ba3a869d12ed6f376581277847421db2e7
> Author: William Roberts <william.c.roberts@intel.com>
> Date:   Tue Feb 9 13:59:46 2016 -0800
>
>     read_spec_entry: fail on non-ascii
>
>     Inserting non-ascii characters into the following files:
>      * file_contexts
>      * property_contexts
>      * service_contexts
>     can cause a failure on labeling but still result in a successful
>     build.
>
>     Hard error on non-ascii characters with:
>     <path>:  line 229 error due to: Non-ASCII characters found
>
>     Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Even before that change, the code did not truly support unicode
> strings, so you could have inserted the module but restorecon or other
> commands could easily have mislabeled the directory.  I guess the
> question is what exactly would need to change to truly support unicode
> strings in the libselinux label code; at the least, we'd need to pass
> additional flags to pcre_compile().

We actually had weird behavior with things not working when unicode
characters were accidentally slipped into the files and since it was
unsupported, I wanted it to fail loudly. Since I don't do anything out of
the ASCII set, I felt I was a poor candidate to properly add UTF support.

I would assume all folks would want is UTF8, and that should be fairly
straightforward to add (I'm not doing it).


>
> As a workaround, I would think you could use regex meta characters e.g.
> .* or .+ to match the portion of the pathname that contains unicode
> characters, as long as that doesn't cause other directories/files to
> become mislabeled.
>



-- 
Respectfully,

William C Roberts
