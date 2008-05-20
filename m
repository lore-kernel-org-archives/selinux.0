From: Jim Meyering <jim@meyering.net>
To: "Eric Paris" <eparis@parisplace.org>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>,
        bug-coreutils@gnu.org
Subject: Re: should GNU install call matchpathcon by default?
In-Reply-To: <7e0fb38c0805201444i3c8eacdi5507888442143c6b@mail.gmail.com>
	(Eric Paris's message of "Tue, 20 May 2008 17:44:12 -0400")
References: <87k5ou9trs.fsf@rho.meyering.net>
	<87fxzh7kww.fsf@rho.meyering.net> <87mytjy51a.fsf@rho.meyering.net>
	<1211294250.7486.134.camel@moss-spartans.epoch.ncsc.mil>
	<87mymlosx7.fsf@rho.meyering.net>
	<7e0fb38c0805201444i3c8eacdi5507888442143c6b@mail.gmail.com>
Date: Wed, 21 May 2008 00:06:09 +0200
Message-ID: <877idoocku.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Eric Paris" <eparis@parisplace.org> wrote:
> On Tue, May 20, 2008 at 12:13 PM, Jim Meyering <jim@meyering.net> wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> ...
>>> This issue came up recently again, see:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=447410
>>>
>>> It appears that the patch that was merged into coreutils ends up calling
>>> matchpathcon_init_prefix() for each file being installed rather than
>>> once upon startup, and without calling matchpathcon_fini() to free the
>>> memory allocated by each matchpathcon_init_prefix() call.
>>>
>>> That makes it slower than necessary and leaks memory.
>>>
>>> See the bug report for the discussion.
>>>
>>> Can we get this corrected in the upstream coreutils?  Thanks.
>>
>> Thanks for letting me know.  The patch below should do the job.
>> I didn't bother calling matchpathcon_fini, since its 6MB buffer
>> is still reachable.
>>
>> For now, I'm leaving that code ifdef'd out, because the performance
>> penalty is still too high even on rawhide, when performing a few hundred
>> to a thousand separate install commands (about a 20x hit, when
>> installing to /usr).  For reference, I did this:
>>
>>  # matchpathcon code all ifdef'd out:
>>  $ touch k; time ( for i in $(seq 200); do; install k /usr/tmp/k ;done )
>>   0.08s user 0.30s system 97% cpu 0.391 total
>>  # matchpathcon code in use:
>>  $ touch k; time ( for i in $(seq 200); do; ./ginstall k /usr/tmp/k ;done )
>>   7.19s user 1.62s system 99% cpu 8.840 total
>
> Just wondering, how much was the perf penalty before this patch?

For the single-file case, the patch I pushed makes no performance
difference (assuming the if-0'd code is enabled), since matchpathcon
is called only once.

In the multi-file case, the pre-patch performance penalty for enabling
the ifdef'd-out code would range from probably-immeasurable (for just
2 or 3 files) to infinite, with enough files to make install exhaust
virtual memory.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
