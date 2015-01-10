Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0A3Cken026730
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 22:12:46 -0500
Received: by mail-qg0-f50.google.com with SMTP id z60so11758528qgd.9
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 19:12:44 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Dominick Grift <dac.override@gmail.com>, Paul Moore <pmoore@redhat.com>
Date: Fri, 09 Jan 2015 22:12:39 -0500
Message-ID: <14ad1d43100.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1420837263.31986.0.camel@gmail.com>
References: <20150108190822.GB4365@codemonkey.org.uk>
 <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
 <20150109191329.GA19400@codemonkey.org.uk>
 <6645675.NppomaThWx@sifl> <1420837263.31986.0.camel@gmail.com>
Subject: Re: noisy selinux messages on tmpfs mount.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Cc: Dave Jones <davej@codemonkey.org.uk>, selinux <selinux@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
 Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

systemd has taken over cron too?  I suppose that is a logical extension, 
but still...

--
paul moore
www.paul-moore.com



On January 9, 2015 4:01:29 PM Dominick Grift <dac.override@gmail.com> wrote:

> On Fri, 2015-01-09 at 15:55 -0500, Paul Moore wrote:
> > On Friday, January 09, 2015 02:13:29 PM Dave Jones wrote:
> > > On Fri, Jan 09, 2015 at 08:06:49AM -0500, Stephen Smalley wrote:
> > >  > We already reduced that message to KERN_DEBUG.  Is that not sufficient?
> > >
> > > That doesn't really help with the flooding of dmesg, so no.
> > > I should also note that it's not just logging in that creates a new
> > > session, it also seems to be getting triggered by cron jobs, or
> > > whatever the systemd replacement is.
> >
> > I wonder if this is cron/systemd/whatever creating a new namespace and
> > mounting a new tmpfs in the namespace?  If yes, I wonder if we could 
> limit the
> > messages to the initial namespace ... ?
> >
>
> It is systemd logind creating sessions (e.g. creating /run/user/$UID and
> mounting a tmpfs on it)
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
