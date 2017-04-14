Message-ID: <1492184005.26072.3.camel@tycho.nsa.gov>
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 14 Apr 2017 11:33:25 -0400
In-Reply-To: <20170414145759.GA7980@markus>
References: <20170414145759.GA7980@markus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
> Bear with me please, because i might not fully grasp the issue (i
> received help with diagnosing this issue):
> 
> This commit causes issues (and is, i think, a lousy hack):
> e3cab998b48ab293a9962faf9779d70ca339c65d
> 
> The commit causes entities to "think" that SELinux is disabled after
> "mount -o remount,ro /sys/fs/selinux
> 
> It is "neat" to be able to make processes "think" that selinux is
> disabled on a selinux enabled system but not if it break anything
> 
> The above results in the following:
> 
> Systemd services that have ProtectKernelTunables=yes set in their
> respective service units, think that SELinux is disabled.
> 
> However we have found that some of these services actually rely on
> SELinux to ensure proper labeling.
> 
> So we have the option to make people aware that if you set
> ProtectKernelTunables=yes that then the process cannot be SELinux-
> aware properly, or we can just get rid of the commit above and just
> accept that process know that SELinux is enabled.
> 
> Actual bug that caused me to look into this: systemd-localed selinux
> awareness is broken due it having ProtectKernelTunables=yes in its
> service unit

If selinuxfs is mounted read-only, then they can't use most of the
selinuxfs interfaces, including even the ability to validate or
canonicalize security contexts.  That will break most SELinux-aware
services if we tell them that SELinux is enabled.  Are you sure
systemd-localed would actually work if you told it SELinux was enabled
when selinuxfs was mounted read-only?  What SELinux interfaces is it
using?

The other question is whether ProtectKernelTunables ought to be
mounting selinuxfs read-only.  SELinux already controls the ability to
use its interfaces, including limiting even root, so it is unclear what
benefit we derive from having systemd add a further restriction on top.
