Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4KLiFAK022210
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 17:44:15 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4KLiDSZ004097
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 21:44:15 GMT
Received: by wf-out-1314.google.com with SMTP id 23so2112608wfg.30
        for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 14:44:13 -0700 (PDT)
Message-ID: <7e0fb38c0805201444i3c8eacdi5507888442143c6b@mail.gmail.com>
Date: Tue, 20 May 2008 17:44:12 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Jim Meyering" <jim@meyering.net>
Subject: Re: should GNU install call matchpathcon by default?
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>,
        bug-coreutils@gnu.org
In-Reply-To: <87mymlosx7.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87k5ou9trs.fsf@rho.meyering.net> <87fxzh7kww.fsf@rho.meyering.net>
	 <87mytjy51a.fsf@rho.meyering.net>
	 <1211294250.7486.134.camel@moss-spartans.epoch.ncsc.mil>
	 <87mymlosx7.fsf@rho.meyering.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 20, 2008 at 12:13 PM, Jim Meyering <jim@meyering.net> wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> ...
>> This issue came up recently again, see:
>> https://bugzilla.redhat.com/show_bug.cgi?id=447410
>>
>> It appears that the patch that was merged into coreutils ends up calling
>> matchpathcon_init_prefix() for each file being installed rather than
>> once upon startup, and without calling matchpathcon_fini() to free the
>> memory allocated by each matchpathcon_init_prefix() call.
>>
>> That makes it slower than necessary and leaks memory.
>>
>> See the bug report for the discussion.
>>
>> Can we get this corrected in the upstream coreutils?  Thanks.
>
> Thanks for letting me know.  The patch below should do the job.
> I didn't bother calling matchpathcon_fini, since its 6MB buffer
> is still reachable.
>
> For now, I'm leaving that code ifdef'd out, because the performance
> penalty is still too high even on rawhide, when performing a few hundred
> to a thousand separate install commands (about a 20x hit, when
> installing to /usr).  For reference, I did this:
>
>  # matchpathcon code all ifdef'd out:
>  $ touch k; time ( for i in $(seq 200); do; install k /usr/tmp/k ;done )
>   0.08s user 0.30s system 97% cpu 0.391 total
>  # matchpathcon code in use:
>  $ touch k; time ( for i in $(seq 200); do; ./ginstall k /usr/tmp/k ;done )
>   7.19s user 1.62s system 99% cpu 8.840 total

Just wondering, how much was the perf penalty before this patch?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
