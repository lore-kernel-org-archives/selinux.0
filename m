Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7EHIhh9027943
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 13:18:43 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7EHITmN014063
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 17:18:30 GMT
From: Jim Meyering <jim@meyering.net>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1155571378.23601.32.camel@localhost.localdomain> (Karl
	MacMillan's message of "Mon, 14 Aug 2006 12:02:58 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155308294.8018.59.camel@localhost.localdomain>
	<87irkzfcgr.fsf@rho.meyering.net>
	<1155567404.23601.10.camel@localhost.localdomain>
	<87ac67iaao.fsf@rho.meyering.net>
	<1155571378.23601.32.camel@localhost.localdomain>
Date: Mon, 14 Aug 2006 19:18:38 +0200
Message-ID: <873bbzi6c1.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> On Mon, 2006-08-14 at 17:53 +0200, Jim Meyering wrote:
>> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
>> ...
>> >> > Acls are a discretionary mechanism and it is, therefore, appropriate for
>> >> > them to be applied by users after file creation.
>> >> >
>> >> > SELinux is fundamentally different as a mandatory mechanism and a core
>> >> > property is that objects should be labeled correctly at creation time.
>> >>
>> >> If using chcon is sometimes not an option for a user who must be able
>> >> to create files in a non-default context, then we have to choose between:
>> >>
>> >>   1) adding the --context=CTX (-Z) option to many of the programs
>> >>       that create a named output file.
>> >>
>> >>   2) providing a tool to change the fscreate context for an exec'd program
>> >>
>> >> The latter seems much cleaner.
>> >> Is there any hope on that front?
>> >> The problem is that if I add an options upstream, it's
>> >> a big deal/hassle to remove it later, if a more appropriate
>> >> mechanism becomes available.  As long as there's a hint
>> >> of hope for a cleaner approach, I'm extremely reluctant
>> >> to impose on the coreutils something that looks like a kludge.
>>
>> Hi Karl,
>>
>> > So your thinking is that the user would have to run a tool - e.g.:
>> >
>> > fscon -t httpd_sys_content_t touch foo.html
>>
>> Exactly.
>> Your example brings up the question of whether touch needs -Z CTX.
>> The user-specified context would be relevant only when creating a file,
>> not when merely updating atime or mtime, and hence, it'd be used only
>> when creating an _empty_ file.  Can you think of a context in which the
>> context of a regular, zero-length file actually matters?  I couldn't.
>> I.e., there's no risk of a race: if the context matters, applying it
>> via chcon as a separate step, after invoking touch would be safe.
>> Maybe that's why touch (on an SELinux system) doesn't already have
>> this option.
>>
>
> Again, you are assuming that relabeling is always possible. It is
> possible for the policy to severely limit or completely prohibit
> relabeling. I don't know that the option is needed, though.

No.  I'm simply assuming that anyone who needs to create a file
with a non-default context will be working in an environment that
permits relabeling.  I've tried to make the point that it's not
feasible to change every named-file-writing program to accept a new
SELinux-context-specifying argument.  Sure, people can modify the most
commonly used ones, but I think they shouldn't have to.  Remember that
this is Unix, with it's pipes and the one-task-one-tool philosophy.

>> > Whether this is cleaner from an implementation perspective I think is
>> > questionable, particularly because the restrictions (must have same
>> > context as caller) will be confusing. This is especially with MLS.
>> > Additionally, how are we going to then handle cases where the contexts
>> > don't match (for example, running install in a different context to
>> > limit what contexts it can set)?
>>
>> Can't we use runcon to work around that limitation?
>>
>>   runcon -Z ... fscon -t httpd_sys_content_t touch foo.html
>>
>
> Well, maybe, but that is not exactly user friendly.

User friendly is nice, but there's a tension between keeping code
maintainable (e.g., small or even minimal) and providing features.
That's one of the reasons it's so hard to justify adding a new option
to ls :-)  When supporting a new "feature" requires adding an option to
nearly every program that writes a file, then isn't it time to look for
a less invasive approach?

>> > More importantly to me, though, is that this mechanism will be much
>> > harder to find for users and will break several years of documented
>> > behavior. I think that the explicit options are the correct model from a
>> > user perspective.
>>
>> I wouldn't expect anything in FCx or RHEL to change overnight.
>> The usual routine is to let the option in question continue to work
>> for some time, but with an added diagnostic saying that it is slated
>> to be removed, and suggesting the new/preferred approach.  Then, only
>> a couple of years later, would it actually be removed.
>>
>
> My point is less about backwards compatibility and more about usability.

We all know that security and usability are often (always?) at odds.
When you add software complexity into the mix, most agree that keeping
code/interfaces as simple as possible is one of the keys to keeping
is robust.  If the code to set the default fscreate context is in one
place (the hypothetical fscon program), then it's far easier to audit
and maintain than if the code is smeared across the tens or hundreds of
programs that accept a -Z CTX option.

> A separate utility is much more difficult to find and harder for the
> user to understand (for example, they would likely never find it looking
> in the man page for install).

If my hopes pan out, RHEL's install -Z option won't go away any time
soon, and there would be a long transition period, with diagnostics
to help affected users learn the new way.  Besides, won't most of
the affected users be ones who actually read (or know how to read)
documentation?  With a little luck, by the time install's -Z option goes
away, there would be plenty of documentation explaining how things work.

> Your runcon workaround above is a perfect example - that would be very
> difficult to explain to most users without quickly diving into
> implementation details that should not and probably do not care about.

I agree that it's not a trivial way to use programs, but isn't the
scenario that'd require such usage a little bit off the beaten track?
If it were something that Joe user would have to run before clicking on
the icon to start OpenOffice, then I'd agree completely.  Even if it
were something that an average command-line-savvy user would have to
do... maybe.  But that seems more like something a package maintainer
would do.  Or more likely, an SELinux guru would do it, in order to
help the package maintainer get his job done safely.  Then, if it needs
to be done for too many packages, it'd be documented -- then package
maintainers would learn.

But of course, my whole scenario depends on SELinux
making it possible to write a program like fscon.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
