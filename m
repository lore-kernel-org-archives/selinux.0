Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49Lj2Yt023358
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 17:45:03 -0400
Received: by mail-lf0-f47.google.com with SMTP id 99so9800875lfu.1
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 14:45:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494362396.2184.2.camel@tycho.nsa.gov>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
 <CAHC9VhSD_Ydp9JCHUZmW7zW05mgMkwHV1m_LSc8KT2EvqTk_VQ@mail.gmail.com>
 <1494362396.2184.2.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 May 2017 17:44:58 -0400
Message-ID: <CAHC9VhTV_+04pMhNO+CsgiFDA0yuPDuW1oZSZis+VBxhutOr5A@mail.gmail.com>
Subject: Re: Policy capabilities: when to use and complications with using
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Carter <jwcart2@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 9, 2017 at 4:39 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-05-09 at 13:49 -0400, Paul Moore wrote:
>> > On 05/03/2017 12:14 PM, Stephen Smalley wrote:
>> > >
>> > > 1) Should we investigate lighter weight support for policy
>> > > capabilities, and if so, how?
>>
>> I agree that not having to update userspace for each new policy
>> capability is a desirable goal, but I'm hopeful that changes
>> requiring
>> a new policy capability are kept to a minimum.
>>
>> > > 2) Should the kernel log information about enabled/disabled
>> > > policy
>> > > capabilities in much the same manner as it does for undefined
>> > > classes/permissions?
>>
>> This seems like a very good idea to me.
>>
>> * https://github.com/SELinuxProject/selinux-kernel/issues/32
>>
>> > > 3) Should the policy compiler toolchain warn the user if a policy
>> > > capability is not declared and classes/permissions are used in
>> > > rules
>> > > that will only be used if that policy capability is
>> > > declared?  And
>> > > similarly if a policy capability is declared but the
>> > > corresponding
>> > > classes/permissions are not used in any rules?
>>
>> This seems to go against lighter weight policy capabilities, would it
>> not?
>
> Not necessarily.  Let's say that we left policy capabilities as strings
> in the kernel policy.  Then when introducing a new policy capability,
> we would just need to patch the kernel to implement it, and patch the
> policy (or even just insert a CIL module) to define it for testing and
> enablement, similar to what we do for new classes/permissions.  We
> wouldn't need an updated libsepol for basic enablement (which likewise
> doesn't need to be patched for new classes/permissions).   We could
> update checkpolicy and/or libsepol to recognize particular capability
> names and provide these warnings, but those would be to help catch
> policy mistakes, not a prerequisite to using the new capability at all.

I was referring to the additional checking/warnings, not basic
enablement, as I thought that was the point of #3.

> The downside however is that we'd lose on build-time detection of e.g.
> a typo in a capability name.  Maybe there is a middle ground where we
> could warn if unrecognized but let them through.
>
> Even if we insist on libsepol validation of the policy capability names
> (to ensure build-time detection of a typo), it might be helpful to add
> the string form of the capability names to the kernel policy.
> Otherwise, the kernel can't log anything useful about unrecognized
> capabilities besides their bit number in the ebitmap.

My only thought on this is that we already have the capability bitmap,
and for compatibility reasons that needs to stay, at least for the
existing capabilities, and I have a strong desire to limit the amount
of legacy "stuff" we have to carry around in the kernel.

However, I understand your points about easier enablement in userspace
and I'm sympathetic (this problem isn't going to go away, arguably in
some way it could get worse if the number of address families grows
frequently).  If this is something you and the rest of the userspace
folks feel strongly about I can be persuaded, but you have to *really*
want this; it needs to be more than a "nice to have".

>> > > 4) Do we need/want a policy capability for map permission and
>> > > other
>> > > cases where we are only adding a new permission check? Or should
>> > > we
>> > > continue to reserve them for cases not addressed via
>> > > handle_unknown?
>>
>> See James' earlier comments.  I think sticking with the current usage
>> is the "best practice", but I think we should reserve the right to
>> treat each change individually.  I'm hopeful that changes where we
>> consider new policy capabilities remain infrequent enough that we can
>> along without a concrete policy on their use.
>
> So what about the two commits I cited?  Were we correct in not
> introducing new policy capabilities for them, or should we have done
> so?  Each of them switched from checking an existing class to a new
> one, so they wouldn't break existing userspace (i.e. cause any new
> denials) due to handle_unknown, but they could have caused a regression
> in policy enforcement (i.e. allow something that would have been denied
> previously under the old class).

Yes, in hindsight we should have introduced new policy capabilities
for both those changes.

Unfortunately, the netlink socket class update has been part of Linus'
releases since v4.2 and I fear that introducing that policy capability
now could introduce it's own problems.  What if someone has a policy
module that only uses the new object classes and doesn't set the
policy capability?  I worry that there is no good solution for this
problem.

The namespace checks are less bad in this sense since they have only
been shipping since v4.7, but I think a similar problem exists.

I imagine we might be able to do something clever in the kernel and
special cases these object classes in the handle_unknown/allow case,
but I would be curious to hear if anyone else has a better idea on how
to fix this.  Do you?

-- 
paul moore
www.paul-moore.com
