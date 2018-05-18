To: Jason Zaman <jason@perfinion.com>, Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180517051117.48454-1-jason@perfinion.com>
 <CAJfZ7==n4+U6U2TGZDDSO8C6GQp5-8fMAV3C26eoqJfP6Z51OA@mail.gmail.com>
 <20180518050318.GA6239@baraddur.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <acddd718-3b1f-9745-00fc-d3115964178a@tycho.nsa.gov>
Date: Fri, 18 May 2018 08:58:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180518050318.GA6239@baraddur.perfinion.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: SELinux musl support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/18/2018 01:03 AM, Jason Zaman wrote:
> On Thu, May 17, 2018 at 09:22:01PM +0200, Nicolas Iooss wrote:
>> On Thu, May 17, 2018 at 7:11 AM, Jason Zaman <jason@perfinion.com> wrote:
>>> This series fixes compiling and running on musl libc.
>>>
>>> patches 1-2 are fairly trivial.
>>>
>>> patches 3-4 are a feature change on that platform since it does not
>>> support GLOB_TILDE and GLOB_BRACE. tilde is coming in musl 1.1.21
>>> according to [1]. brace support is not documented anywhere or in the
>>> example configs so that is probably not a big problem.
>>>
>>> patch 5 fixes a bug and it just happens that glibc returns a value for
>>> sysconf and the error handling was wrong but never noticed.
>>>
>>> [1]: https://wiki.musl-libc.org/roadmap.html
>>>
>>> [PATCH 1/5] sestatus: include limits.h for PATH_MAX
>>> [PATCH 2/5] libselinux: enable linking to musl-fts
>>> [PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and
>>> [PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE and
>>> [PATCH 5/5] genhomedircon: sysconf can return -1 without failure
>>
>> Thanks! These patches look good to me and I would also appreciate if
>> they are merged in 2.8.
> 
> Awesome, I'll push them on monday then unless there are any issues
> before then :)

FWIW, the patches look fine to me as well and I did a test PR to trigger travis CI testing
and they passed,
https://github.com/SELinuxProject/selinux/pull/96

One possible area for improvement (but not necessary to merge this) would be to fix the
genhomedircon code to also then handle the case where getpwnam_r/getgrnam_r returns ERANGE,
in which case we are supposed to realloc a larger buffer and try again per the man page.
