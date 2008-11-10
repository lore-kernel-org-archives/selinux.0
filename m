From: Paul Moore <paul.moore@hp.com>
To: Joe Nall <joe@nall.com>, Xavier Toth <txtoth@gmail.com>
Subject: Re: Label Translation on Fedora 9
Date: Mon, 10 Nov 2008 11:53:30 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Warner <warner@rubix.com>, SE Linux <selinux@tycho.nsa.gov>
References: <490EE548.60400@rubix.com> <cadfc0e40811100810y539d09cege4fd2c2fa064d3c2@mail.gmail.com> <97946D1C-80A3-448E-9CC2-1F020D479D40@nall.com>
In-Reply-To: <97946D1C-80A3-448E-9CC2-1F020D479D40@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811101153.30563.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 10 November 2008 11:16:43 am Joe Nall wrote:
> On Nov 10, 2008, at 10:10 AM, Xavier Toth wrote:
> > On Mon, Nov 10, 2008 at 9:56 AM, Paul Moore <paul.moore@hp.com> 
wrote:
> >> ...
> >> Cool.  Do the current X/metacity patches support label coloring?
> >>
> >> --
> >> paul moore
> >> linux @ hp
> >
> > No.
> >
> > Ted
>
> Ted has unreleased patches to metacity and openbox support the
> coloring the window banner based on classification. We want to move
> the code from a shared library to mcstransd before releasing them
> into the wild.
>
> He also wrote a simple banner program to show the current session
> level. It needs to run in a protected type and better defend its
> screen real estate or be integrated into X or the window manager.

Okay, sounds good.  Thanks for the update.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
