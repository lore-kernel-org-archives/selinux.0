From: Paul Moore <pmoore@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: noisy selinux messages on tmpfs mount.
Date: Mon, 12 Jan 2015 10:06:43 -0500
Message-ID: <10532721.yu8lhX206e@sifl>
In-Reply-To: <54B3DF65.809@tresys.com>
References: <20150108190822.GB4365@codemonkey.org.uk>
 <54B03E45.8000106@tycho.nsa.gov> <54B3DF65.809@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Dave Jones <davej@codemonkey.org.uk>, selinux <selinux@tycho.nsa.gov>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, January 12, 2015 09:51:17 AM Christopher J. PeBenito wrote:
> On 1/9/2015 3:47 PM, Stephen Smalley wrote:
> > On 01/09/2015 02:13 PM, Dave Jones wrote:
> >> That doesn't really help with the flooding of dmesg, so no.
> >> I should also note that it's not just logging in that creates a new
> >> session, it also seems to be getting triggered by cron jobs, or
> >> whatever the systemd replacement is.
> > 
> > Fair enough.  I think we can likely get rid of it then.
> 
> Are you saying completely get rid of the message in all cases?  If so,
> how is a user supposed to debug situations where they mount a filesystem
> and labeling doesn't work (i.e. no security label support or policy
> hasn't been updated for that fs)?

I'm pretty sure Stephen just meant the normal case, not the "unknown behavior" 
case.

> Is there going to be another place to look see what the labeling behavior is
> for all mounted filesystems?

I imagine we could create something in securityfs for that, you want to write 
a patch Chris? :)

-- 
paul moore
security @ redhat
