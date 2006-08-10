To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: does mv need a --context=CTX (-Z) option, too?
In-Reply-To: <44DB4585.3070500@redhat.com> (Daniel J. Walsh's message of "Thu,
	10 Aug 2006 10:41:09 -0400")
References: <87hd0kc308.fsf@rho.meyering.net>
	<1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil>
	<874pwkll7v.fsf@rho.meyering.net> <44DB4585.3070500@redhat.com>
From: Jim Meyering <meyering@redhat.com>
Date: Thu, 10 Aug 2006 19:35:33 +0200
Message-ID: <87y7twijdm.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh <dwalsh@redhat.com> wrote:
> Jim Meyering wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>>> On Thu, 2006-08-10 at 12:13 +0200, Jim Meyering wrote:
>>>
>>>> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
>>>> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
>>>> Most of the time, mv would have no need, since it simply calls rename.
>>>> But when that fails, it reverts to using the very same copying code
>>>> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
>>>> understanding that it'd take effect solely for e.g., cross-device moves.
>>>> I.e., if you want to simulate a cross device move, you'd have to use
>>>> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
>>>> (-Z) option, then it follows that mv must accept it as well.
>>>>
>>> mv should just preserve the context of the original in all cases,
>>> whether it is just doing a rename(2) or copying the file.
>>>
>>
>> What if it's not possible to preserve the original, yet it
>> would be possible to set some other desirable context?
>>
>> Stepping back a little, if mv doesn't need the option, then why
>> does cp need it?  After all, cp has no option to set classic
>> permissions.
>>
>>
> I agree cp should not need this qualifier.  It should either be preserve
> or get the new default context.
> mv should just try to preserve
> install should use the matchpathcon similar to rpm.

Thanks, for your replies Dan and Karl.
I'm glad I asked.  Barring objections (Russell?), cp's -Z/--context=CTX
option will not make it to "upstream".

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
