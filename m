Subject: Re: Moving target -- kernel version.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050524173846.41350.qmail@web60413.mail.yahoo.com>
References: <20050524173846.41350.qmail@web60413.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 13:52:27 -0400
Message-Id: <1116957147.27904.163.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-24 at 10:38 -0700, Roger Brunell wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Did you read the nsa/README file?  The vendor branch of that tree tracks
> > the official nsa.gov SELinux releases, and interim updates between
>                                               ?? to selinux ??

Yes.

> > releases are committed on the head.  Hence, it is presently 2.6.11 with
>                                                               ^^^^^^??
>                                                     with what patches?

None, other than what I mentioned below.

> > the 2.6.11-selinux1.patch applied plus some subsequent updates to
>                                          ------------------????
> > reflect changes made since the release.  I don't believe that it has
>                                  ^^ of 2.6.11 or NewSelinux

Updates made to SELinux since 2.6.11-selinux1 was released.

>   I think this means that the sourceforge CVS is less than p10? I haven't
> tracked back to what level it is.

Linux 2.6.11, no other patches.  Patch level 0 if you prefer.

> > Debian kernel, since nsa/linux-2.6 is just vanilla 2.6.11 plus SELinux
> > changes.  Either just use the Debian kernel as is (boot with selinux=1)
> > or try applying the 2.6.11-selinux1.patch to it if you truly need those
> > changes.
>   ^^^^^^^                                                           ^^^^^
>      I have no idea what "those changes" are, you are speaking of. Do you mean
> those found in the SElinux patch on the NSA site may already be in 2.6.11.10
> kernel as delivered?
>     Nope, I just looked at the security.h file included with the distro
> (/usr/src/kernel-headers-2.6.11) and the selinux-patch changes are not yet
> present. 
>     So I still have to apply that patch a do a kernel build.

You don't need to build a kernel at all, unless you truly need the
latest bleeding edge development for SELinux.  You can just enable
SELinux support in the Debian-provided kernel.  The mainline kernel
includes a working version of SELinux; you only need the patch from the
NSA site or the cvs tree from sourceforge if you are doing SELinux
development yourself and need to work against the latest code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
