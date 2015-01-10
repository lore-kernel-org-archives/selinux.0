Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0A9BWbu014371
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 04:11:32 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so11785415wgg.11
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 01:11:27 -0800 (PST)
Message-ID: <1420881085.24061.13.camel@gmail.com>
Subject: Re: noisy selinux messages on tmpfs mount.
From: Dominick Grift <dac.override@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Date: Sat, 10 Jan 2015 10:11:25 +0100
In-Reply-To: <14ad1d43100.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20150108190822.GB4365@codemonkey.org.uk>
 <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
 <20150109191329.GA19400@codemonkey.org.uk> <6645675.NppomaThWx@sifl>
 <1420837263.31986.0.camel@gmail.com>
 <14ad1d43100.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Dave Jones <davej@codemonkey.org.uk>,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
 Linux Kernel <linux-kernel@vger.kernel.org>, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2015-01-09 at 22:12 -0500, Paul Moore wrote:
> systemd has taken over cron too?  I suppose that is a logical extension, 
> but still...

That is were i think davej is wrong. Here is what i think is the
scenario with cron.

Cron runs jobs on behalf root. Root is generally not logged in all the
time. So every time cron performs a job on behalf of root (hourly etc),
systemd logind creates /run/user/0 and mounts tmpfs on it, when the job
is done, tmpfs is unmounted and /run/user/= removed.

In that sense cron acts as kind of a login program.

Where i think davej might be wrong is that this would also happen with
systemd's replacement for cron: timers.

I suspect that systemd logind does not create 0 user runtime directory
everytime a timer is triggered, as opposed to cron.

with regard to normal user timers.Those really only work if you enable
lingering on the systemd --user daemon with logind. This means that in
practice the user is always logged in from a systemd logind user runtime
directory point of view (e.g. /run/user/$UID is always there for a user
that has a lingering systemd session daemon instance)

In practice , i suspect that this means that, although now with cron
were seeing logind mount tmpfs whenever some job of behalf of root is
run if root is not physically loged in (which is often), that this would
not be the case if we got rid of cron and if it would be replaced by
systemd timers

One might ask the question: why does logind create a root user runtime
directory every time cron runs a job on behalf of root. Is that really
required?

> 
> --
> paul moore
> www.paul-moore.com
> 
> 
> 
> On January 9, 2015 4:01:29 PM Dominick Grift <dac.override@gmail.com> wrote:
> 
> > On Fri, 2015-01-09 at 15:55 -0500, Paul Moore wrote:
> > > On Friday, January 09, 2015 02:13:29 PM Dave Jones wrote:
> > > > On Fri, Jan 09, 2015 at 08:06:49AM -0500, Stephen Smalley wrote:
> > > >  > We already reduced that message to KERN_DEBUG.  Is that not sufficient?
> > > >
> > > > That doesn't really help with the flooding of dmesg, so no.
> > > > I should also note that it's not just logging in that creates a new
> > > > session, it also seems to be getting triggered by cron jobs, or
> > > > whatever the systemd replacement is.
> > >
> > > I wonder if this is cron/systemd/whatever creating a new namespace and
> > > mounting a new tmpfs in the namespace?  If yes, I wonder if we could 
> > limit the
> > > messages to the initial namespace ... ?
> > >
> >
> > It is systemd logind creating sessions (e.g. creating /run/user/$UID and
> > mounting a tmpfs on it)
> >
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
