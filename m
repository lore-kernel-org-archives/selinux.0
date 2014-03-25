Message-ID: <5331B955.6010600@tycho.nsa.gov>
Date: Tue, 25 Mar 2014 13:13:57 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: SELinux policy updates in a post-%post world
References: <1395712688.13975.4@mail.messagingengine.com>
In-Reply-To: <1395712688.13975.4@mail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/24/2014 09:54 PM, Colin Walters wrote:
> Hi,
> 
> I mentioned OSTree earlier here.  An issue came up with the SELinux
> integration; to understand it, let me describe how OSTree upgrades work:
> 
> 1) We perform an rsync-like[1] process to a *new* chroot
> 2) A "basic" configuration merge is done - we take the new /etc
> defaults, and apply any modified files on top
> 
> Note that the policy.19 file is in /etc.
> 
> Crucially, there is at present no %post/postinst type functionality.
>  This is a dramatic increase in reliability over traditional packages.
>  No shell script run as root copy/pasted or just copied from elsewhere
> appended to everything.
> 
> For things like /usr/lib/ld.so.cache which is just a cache, this works
> fine because it's just referencing things in /usr/lib - it's all
> precomputed on the compose server.
> 
> Now, at least the Fedora selinux-policy has a %post that runs "semodule
> -B" which recompiles the policy (if the client machine has modified it
> locally).
> 
> Currently with OSTree, what will happen is it will notice the policy.19
> file is a modified file in /etc, and simply carry it forward.  In other
> words, updates to the base policy have no effect once the admin has
> modified it locally.
> 
> Administrators *can* rerun "semodule -B" manually after booting into the
> new root to recompile.
> 
> Why can't I just add a %post concept to OSTree?  Well, I could.  But I'd
> like to try as hard as conceivably possible to avoid it, and even then
> only do it where all other avenues are exhausted.  For one thing, it
> would break the ability to do completely offline updates (e.g. open up a
> VM guest disk from the host, and update it).  This ability is presently
> used to great effect in the testing system.
> 
> The primary alternative to %post is a "dynamic merge".  For example,
> systemd has a design where the default unit files are in
> /usr/lib/system, and then "dropins" can customize them in
> /etc/systemd/system.  On boot, it unions the two.
> 
> Similarly, I added /usr/lib/passwd in addition to /etc/passwd:
> https://sourceware.org/bugzilla/show_bug.cgi?id=16142
> 
> However...I'm uncertain about doing this for SELinux policy.  The policy
> load happens very early in userspace setup and it's a complex task.
> 
> One option is to recompile the policy if we can (we're doing an upgrade
> from inside a running system, just chroot to new deployment and rerun
> semodule), and throw an error if we can't do it (the offline upgrade
> case).  The latter would only occur when a machine has a modified
> policy, which doesn't happen for my testing system.
> 
> Any other ideas?

Can you explain when/why you cannot run semodule -B?  As long as you
also pass it -n and -s <store-name> and possibly -p <rootpath>, it
should work and should not affect the running system until reboot or
next policy load.

Effectively semodule -B is performing a merge, by merging any local
policy customizations into the updated policy.  You do want the merge
because the updated policy may include changes required for the updated
system components, while the local customizations may be required for
system operation (e.g. local file_contexts entries, boolean settings,
login mappings, added allow rules for third party software or
non-standard configurations), so using either just the modified policy
from before the upgrade or just the unmodified updated policy could
leave the system in a non-functional state.
