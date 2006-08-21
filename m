From: Jim Meyering <jim@meyering.net>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1156183087.8126.27.camel@localhost.localdomain> (Karl
	MacMillan's message of "Mon, 21 Aug 2006 13:58:07 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155308294.8018.59.camel@localhost.localdomain>
	<87irkzfcgr.fsf@rho.meyering.net>
	<1155567404.23601.10.camel@localhost.localdomain>
	<87ac67iaao.fsf@rho.meyering.net>
	<1155571378.23601.32.camel@localhost.localdomain>
	<873bbzi6c1.fsf@rho.meyering.net>
	<1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	<87wt929j25.fsf@rho.meyering.net>
	<1156183087.8126.27.camel@localhost.localdomain>
Date: Mon, 21 Aug 2006 23:15:12 +0200
Message-ID: <87wt9194f3.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> Response so far has not exactly been overwhelming.

I noticed :)
Thanks for taking the time to read and reply.

> I still think that the current flags are better. Here are some reasons
> (I can come up with more if you like):

Yes, please.

> 1) The proposed fscon only works in some circumstances. I think that

I think we agree.  Let me rephrase it:

  In some circumstances, fscon, by itself, is insufficient.
  In those cases, you'd have to use both runcon and fscon.
  This boils down to an argument involving perceived user convenience.

> most users will have trouble knowing when they can just use fscon and
> when they have to resort to runcon + fscon. You suggest that this is a
> corner case only, but I am not convinced that it won't pop up in normal
> usage.

Even if it does come up in normal usage, I don't see it as a big
enough hurdle to warrant adding the -Z option to mkdir, mknod, mkfifo,
and install.  (Remember, those are the only four tools in question
here.  The other -Z options, that don't take an argument, have
different semantics.)  Using a separate tool seems like the proper,
Unix, approach.  If results in some process being too complicated,
people can always add wrappers to encapsulate it.

> 2) Fscon is in my opinion much less friendly than the direct flags.
> Using runcon + fscon is not just unfriendly it is downright user
> hostile. Imaging using this if you have MCS/MLS involved.

Can you give an example or two showing how/why it would be so
problematic, e.g., how using mkdir -Z CTX ... would be so
much better than this:
  fscon FS_CTX mkdir ...
or this:
  runcon X_CTX fscon FS_CTX mkdir ...

> I have taught probably hundreds of users how to use SELinux (both in
> formal class settings and informally). I have seen many of these
> students have trouble understanding the relationship between file
> contexts and process contexts - introducing a dependency between the two
> with runcon and fscon will just make things that much worse.

Do we really want to limit the design of core O/S tools so as to keep
within the bounds of what the median student can understand?  Where would
Unix be today, if it adhered to such a philosophy?  Combining conceptually
simple tools is at the core of the Unix ethic.  Is SELinux so different
that we need to change now?

> 3) This will be kernel dependent, resulting in maintenance problems. Not
> only that, this kernel change will miss many major distro releases
> including RHEL 5 meaning that the problem will be around for a long
> time.

I don't expect any maintenance-related problems in the coreutils
per se.  I have a lot of experience working around just such system-
and kernel-specific differences.  coreutils' configure process tests
for many libc- and kernel-specific features and bugs.  There are even
a few run-time tests.

Since no one would be in a hurry to phase out the -Z CTX options,
I don't see why RHEL 5 would be relevant.

> 4) The current flags have been around for several years and are
> documented everywhere. Your argument that RHEL/Fedora will likely
> preserve these for years doesn't help - the whole point of upstreaming
> this is to get long-term, consistent usage across distros. Switching now
> doesn't help it hurts that goal.

I have one additional requirement: to "do the right thing" by coreutils.
>From my perspective as an SELinux newbie, that would seem to require
a tool like fscon.  Regarding history, I see it more like: if there's
a better way and we don't switch now, it won't ever happen.

> 5) It is not clear that the change in kernel semantics is desirable.

I agree, so far.  That's why I've been working to DTRT here.
I'm trying to convince you that it is desirable, or to get a clear
indication that it's not possible.  The latter hasn't happened,
so I remain optimistic.

> 6) It makes the handling of SELinux contexts divergent from handle ACLs,
> standard unix permissions, and extended attributes. It is more natural,
> in my opinion, to treat the SELinux permissions as peers of these
> concepts.

Currently, even with distro-specific patches, I know of no coreutils
tool or option by which to _set_ ACLs or XATTRs.  So in a sense, it's
the addition of the -Z CTX option that causes divergence.  If there
were already a "-Z CTX"-analog for ACLs or XATTRs, it'd be different.
The problem is that once we (upstream) open the door with an option for
setting SELinux context, we're in no position to argue against adding a
new option to set each of ACLs and XATTRs, and whatever other MAC-based
system people are using.  That is what I'm trying to avoid.

I have no problem *preserving* any and all attributes, and the upstream
mv, cp, and install will do that, before long.  It's only the *setting*
(via -Z CTX) that is problematic, because the semantics seem too basic
and easily factored out to require embedding in each of those programs --
and many others.

> 7) How will fscon interact with the proposed xattr flags? Won't
> applications that handle xattrs have to have logic to ignore or set the
> SELinux xattrs, destroying the stated advantage of removing this support
> with fscon?

If I understand the question, they're entirely independent, since the
only explicitly XATTR-related code is that which *preserves* XATTRs
in copy.c (used by mv, cp, install).  And the --preserve=xattr option
I suggested would apply only to cp.  Of those three, only install has
-Z CTX (since we've agreed that cp's -Z CTX option can be removed).
Let's say someone uses fscon to set cp's fscreate context anyhow, e.g.,

  fscon CTX cp --preserve=xattr SRC DEST

Then, I think the default fscreate context would be largely irrelevant,
since the request to preserve xattrs means to perform the copy, and to
make the XATTRs of DEST be identical (or as close as possible) to those
of SRC.  However, CTX would determine the SELinux context of DEST in the
window between when it's created and when its XATTRs are set, so this
could be viewed as a way of improving security by closing that window.

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
