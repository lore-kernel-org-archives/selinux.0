Message-ID: <54B03E45.8000106@tycho.nsa.gov>
Date: Fri, 09 Jan 2015 15:47:01 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>,
 Stephen Smalley <stephen.smalley@gmail.com>,
 Paul Moore <pmoore@redhat.com>, selinux <selinux@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy selinux messages on tmpfs mount.
References: <20150108190822.GB4365@codemonkey.org.uk>
 <3227891.DhTeT4XeAv@sifl> <2354586.80TRdrKbtf@sifl>
 <CAB9W1A2nTN2DJ699BXL_r_aXCk-O9-KrTLSi731isQWpPUmkwg@mail.gmail.com>
 <20150109191329.GA19400@codemonkey.org.uk>
In-Reply-To: <20150109191329.GA19400@codemonkey.org.uk>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2015 02:13 PM, Dave Jones wrote:
> On Fri, Jan 09, 2015 at 08:06:49AM -0500, Stephen Smalley wrote:
>  
>  > On Thu, Jan 8, 2015 at 2:39 PM, Paul Moore <pmoore@redhat.com> wrote:
>  > > On Thursday, January 08, 2015 02:34:57 PM Paul Moore wrote:
>  > >> On Thursday, January 08, 2015 02:08:22 PM Dave Jones wrote:
>  > >> > systemd has started mounting a tmpfs in /run/user/<uid> every time a
>  > >> > session begins.  So after ssh'ing into a box a number of times, dmesg
>  > >> > looks like this..
>  > >> >
>  > >> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>  > >> > [...] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>  > >>
>  > >> {snip}
>  > >>
>  > >> > What's a good solution to stopping this spew ? printk_once doesn't seem
>  > >> > like a good fit, in case someone is doing different labelling behaviours
>  > >> > between mounts.
>  > >> >
>  > >> > Could we only print it if the mount is being done with non-default
>  > >> > behaviour perhaps?
>  > >>
>  > >> I'm very curious to hear Stephen's opinion on the issue, but I wonder how
>  > >> much this would honestly impact us if we removed this message in the case
>  > >> where we mount the filesystem with a known labeling behavior.
>  >
>  > We already reduced that message to KERN_DEBUG.  Is that not sufficient?
> 
> That doesn't really help with the flooding of dmesg, so no.
> I should also note that it's not just logging in that creates a new
> session, it also seems to be getting triggered by cron jobs, or
> whatever the systemd replacement is.

Fair enough.  I think we can likely get rid of it then.
