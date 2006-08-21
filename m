From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
	(Stephen Smalley's message of "Mon, 14 Aug 2006 14:44:50 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155308294.8018.59.camel@localhost.localdomain>
	<87irkzfcgr.fsf@rho.meyering.net>
	<1155567404.23601.10.camel@localhost.localdomain>
	<87ac67iaao.fsf@rho.meyering.net>
	<1155571378.23601.32.camel@localhost.localdomain>
	<873bbzi6c1.fsf@rho.meyering.net>
	<1155581090.28766.217.camel@moss-spartans.epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Date: Mon, 21 Aug 2006 17:58:58 +0200
Message-ID: <87wt929j25.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2006-08-14 at 19:18 +0200, Jim Meyering wrote:
>> I agree that it's not a trivial way to use programs, but isn't the
>> scenario that'd require such usage a little bit off the beaten track?
>
> I'm not sure that this is a valid assumption.  It might be educational
> (or perhaps not) to take your proposal to fedora-selinux-list, and seek
> feedback there, as I think they have a much larger subscriber base and

As you've probably noticed, I posted to the lists, as you suggested:
  https://www.redhat.com/archives/fedora-list/2006-August/msg02264.html (long)

I suppose it's still early, but so far, all I have is positive feedback:

  http://lists.gnu.org/archive/html/bug-coreutils/2006-08/msg00147.html

Support (and even rebuttal) welcomed.
Even silence is ok, as long as it implies consent :)

> have people who are more representative of ordinary users.  Or even
> fedora-list itself, as plenty of people are using Fedora w/SELinux
> without even subscribing to any of the SELinux-specific lists.
>
>> But of course, my whole scenario depends on SELinux
>> making it possible to write a program like fscon.
>
> I'm not convinced that even if SELinux supported such a program that it
> should replace the -Z options in coreutils.  I'd see that more as a way
> of applying SELinux to the much larger set of utils, particularly third
> party ones, that are truly not feasible for us to patch.

FYI, I learned of another tool, like the proposed fscon, that performs a
kernel state change just before exec'ing some other program: setarch(8):

  $ man setarch
  SETARCH(8)                 Linux Programmer's Manual                SETARCH(8)

  NAME
         setarch - change reported architecture in new program environment
         and set personality flags

  SYNOPSIS
         setarch <arch> [options] [program [arguments]]

         arch [options] [program [arguments]]

  DESCRIPTION
         setarch This utility currently only affects the output  of  uname
         -m.  For  example, on an AMD64 system, running 'setarch i386 pro-
         gram' will cause 'program' to see i686 (or other  relevant  arch)
         instead  of x86_64 as machine type. It also allows to set various
         personality options.
  ...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
