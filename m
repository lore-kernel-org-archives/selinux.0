Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09KtmVH003737
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 15:55:48 -0500
From: Paul Moore <pmoore@redhat.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: noisy selinux messages on tmpfs mount.
Date: Fri, 09 Jan 2015 15:55:37 -0500
Message-ID: <6645675.NppomaThWx@sifl>
In-Reply-To: <20150109191329.GA19400@codemonkey.org.uk>
References: <20150108190822.GB4365@codemonkey.org.uk>
 <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
 <20150109191329.GA19400@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
 James Morris <james.l.morris@oracle.com>, selinux <selinux@tycho.nsa.gov>,
 Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 09, 2015 02:13:29 PM Dave Jones wrote:
> On Fri, Jan 09, 2015 at 08:06:49AM -0500, Stephen Smalley wrote:
>  > We already reduced that message to KERN_DEBUG.  Is that not sufficient?
> 
> That doesn't really help with the flooding of dmesg, so no.
> I should also note that it's not just logging in that creates a new
> session, it also seems to be getting triggered by cron jobs, or
> whatever the systemd replacement is.

I wonder if this is cron/systemd/whatever creating a new namespace and 
mounting a new tmpfs in the namespace?  If yes, I wonder if we could limit the 
messages to the initial namespace ... ?

-- 
paul moore
security @ redhat
