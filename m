Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t08Jdp1F001292
 for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2015 14:39:51 -0500
From: Paul Moore <pmoore@redhat.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: noisy selinux messages on tmpfs mount.
Date: Thu, 08 Jan 2015 14:39:42 -0500
Message-ID: <2354586.80TRdrKbtf@sifl>
In-Reply-To: <3227891.DhTeT4XeAv@sifl>
References: <20150108190822.GB4365@codemonkey.org.uk> <3227891.DhTeT4XeAv@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov, James Morris <james.l.morris@oracle.com>,
 Stephen Smalley <sds@epoch.ncsc.mil>,
 Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, January 08, 2015 02:34:57 PM Paul Moore wrote:
> On Thursday, January 08, 2015 02:08:22 PM Dave Jones wrote:
> > systemd has started mounting a tmpfs in /run/user/<uid> every time a
> > session begins.  So after ssh'ing into a box a number of times, dmesg
> > looks like this..
> > 
> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> 
> {snip}
> 
> > What's a good solution to stopping this spew ? printk_once doesn't seem
> > like a good fit, in case someone is doing different labelling behaviours
> > between mounts.
> > 
> > Could we only print it if the mount is being done with non-default
> > behaviour perhaps?
> 
> I'm very curious to hear Stephen's opinion on the issue, but I wonder how
> much this would honestly impact us if we removed this message in the case
> where we mount the filesystem with a known labeling behavior.

[NOTE: adding the SELinux list to the CC line.]

-- 
paul moore
security @ redhat
