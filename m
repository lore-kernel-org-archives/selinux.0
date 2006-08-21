Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <87wt929j25.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
	 <87irkzfcgr.fsf@rho.meyering.net>
	 <1155567404.23601.10.camel@localhost.localdomain>
	 <87ac67iaao.fsf@rho.meyering.net>
	 <1155571378.23601.32.camel@localhost.localdomain>
	 <873bbzi6c1.fsf@rho.meyering.net>
	 <1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	 <87wt929j25.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 13:58:07 -0400
Message-Id: <1156183087.8126.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-21 at 17:58 +0200, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2006-08-14 at 19:18 +0200, Jim Meyering wrote:
> >> I agree that it's not a trivial way to use programs, but isn't the
> >> scenario that'd require such usage a little bit off the beaten track?
> >
> > I'm not sure that this is a valid assumption.  It might be educational
> > (or perhaps not) to take your proposal to fedora-selinux-list, and seek
> > feedback there, as I think they have a much larger subscriber base and
> 
> As you've probably noticed, I posted to the lists, as you suggested:
>   https://www.redhat.com/archives/fedora-list/2006-August/msg02264.html (long)
> 
> I suppose it's still early, but so far, all I have is positive feedback:
> 
>   http://lists.gnu.org/archive/html/bug-coreutils/2006-08/msg00147.html
> 

Response so far has not exactly been overwhelming.

> Support (and even rebuttal) welcomed.
> Even silence is ok, as long as it implies consent :)
> 

I still think that the current flags are better. Here are some reasons
(I can come up with more if you like):

1) The proposed fscon only works in some circumstances. I think that
most users will have trouble knowing when they can just use fscon and
when they have to resort to runcon + fscon. You suggest that this is a
corner case only, but I am not convinced that it won't pop up in normal
usage.

2) Fscon is in my opinion much less friendly than the direct flags.
Using runcon + fscon is not just unfriendly it is downright user
hostile. Imaging using this if you have MCS/MLS involved.

I have taught probably hundreds of users how to use SELinux (both in
formal class settings and informally). I have seen many of these
students have trouble understanding the relationship between file
contexts and process contexts - introducing a dependency between the two
with runcon and fscon will just make things that much worse.

3) This will be kernel dependent, resulting in maintenance problems. Not
only that, this kernel change will miss many major distro releases
including RHEL 5 meaning that the problem will be around for a long
time.

4) The current flags have been around for several years and are
documented everywhere. Your argument that RHEL/Fedora will likely
preserve these for years doesn't help - the whole point of upstreaming
this is to get long-term, consistent usage across distros. Switching now
doesn't help it hurts that goal.

5) It is not clear that the change in kernel semantics is desirable.

6) It makes the handling of SELinux contexts divergent from handle ACLs,
standard unix permissions, and extended attributes. It is more natural,
in my opinion, to treat the SELinux permissions as peers of these
concepts. 

7) How will fscon interact with the proposed xattr flags? Won't
applications that handle xattrs have to have logic to ignore or set the
SELinux xattrs, destroying the stated advantage of removing this support
with fscon?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
