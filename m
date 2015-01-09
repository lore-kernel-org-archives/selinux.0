Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09L19V2004575
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 16:01:09 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so4812161wiw.3
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 13:01:06 -0800 (PST)
Message-ID: <1420837263.31986.0.camel@gmail.com>
Subject: Re: noisy selinux messages on tmpfs mount.
From: Dominick Grift <dac.override@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Date: Fri, 09 Jan 2015 22:01:03 +0100
In-Reply-To: <6645675.NppomaThWx@sifl>
References: <20150108190822.GB4365@codemonkey.org.uk>
 <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
 <20150109191329.GA19400@codemonkey.org.uk> <6645675.NppomaThWx@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Dave Jones <davej@codemonkey.org.uk>, selinux <selinux@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
 Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2015-01-09 at 15:55 -0500, Paul Moore wrote:
> On Friday, January 09, 2015 02:13:29 PM Dave Jones wrote:
> > On Fri, Jan 09, 2015 at 08:06:49AM -0500, Stephen Smalley wrote:
> >  > We already reduced that message to KERN_DEBUG.  Is that not sufficient?
> > 
> > That doesn't really help with the flooding of dmesg, so no.
> > I should also note that it's not just logging in that creates a new
> > session, it also seems to be getting triggered by cron jobs, or
> > whatever the systemd replacement is.
> 
> I wonder if this is cron/systemd/whatever creating a new namespace and 
> mounting a new tmpfs in the namespace?  If yes, I wonder if we could limit the 
> messages to the initial namespace ... ?
> 

It is systemd logind creating sessions (e.g. creating /run/user/$UID and
mounting a tmpfs on it)
