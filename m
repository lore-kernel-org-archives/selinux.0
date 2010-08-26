From: Thomas <tom@electric-sheep.org>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Enable selinux in SLES 11
Date: Thu, 26 Aug 2010 09:37:13 +0200
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch> <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch> <1282661330.23429.50.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1282661330.23429.50.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201008260937.13318.tom@electric-sheep.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Am Dienstag 24 August 2010 16:48:50 schrieb Stephen Smalley:
> On Tue, 2010-08-24 at 16:09 +0200, imsand@puzzle.ch wrote:
> > Unfortunately it doesn't work. I've done all steps described in here:
> > http://thetoms-random-thoughts.blogspot.com/2008/12/selinux-on-opensuse-1
> >11.html but this doesn't seems to work for sles 11.
> > Anybody out there, who was able to run selinux on sles 11?
> > I've got some other questions?
> >   * what happens if the policy is not found? what would sestatus report?
> >   * are there some good debug options for selinux? logs? any other hints?
> > (dmesg shows nothing related to selinux)
> 
> I've only seen successful reports of getting SELinux to run with
> OpenSUSE 11.2 and later, and even that hasn't been trivial.  I haven't
> seen any reports of getting it to work with SLES 11.  But you should ask
> Novell about it.

Since openSUSE 11.3 is is much easier. You can use yast2 (bootloader menu)
to enable SELinux.

Bye
Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
