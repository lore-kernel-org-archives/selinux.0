Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118281858.9481.4.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 14:26:54 -0400
Message-Id: <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 02:50 +0100, antoine wrote:
> Which could be allowed by this:
> allow ping_t crond_t:fifo_file { read write };
> allow ping_t tmpfs_t:file { append getattr ioctl };
> But why would I need to change the definition for crond_t? If anything
> it should be for mycron_t? Also, why does ping_t need to use /tmp if it
> is not in the default policy file?

I'd guess that the pipe (fifo_file) is originally created by crond (thus
labeled with its type) to capture output of the cron job, then inherited
by your mycron script, and then inherited by ping as its stdout.  The
domain_auto_trans() macro allows for such inheritance and use by the
child domain from the parent domain, but in this case since you are
going through multiple such transitions, you have to explicitly allow
the channel (or interpose on it in your own script so that it is no
longer a direct channel between ping and crond).

I'm not sure what is happening with respect to the /tmp file.  The
example policy defines a crond_tmp_t for /tmp files created by crond
itself and a system_crond_tmp_t for tmp files created by system cron
jobs.  They certainly shouldn't be tmpfs_t.

In Fedora, using tmpfs for /tmp has been addressed by putting a
restorecon /tmp into rc.sysinit and adding an allow tmpfile
tmpfs_t:filesystem associate; rule to the policy.  

> 2) Is there any online documentation on what all the macros do?
> It would be a lot easier to be able to take the output from audit2allow
> and know which parts map to which macro (can_network, uses_shlib, etc)
> I'd prefer using google to look it up than vi ./macros/*
> The closest pointer I found is on this page:
> http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0053.html
> but it is still largely a manual process. I understand that being
> macros, a full text search cannot guarantee accuracy, but for most cases
> it would do the (painful) work for me. Can't we generate documentation
> with typical examples automatically? Or write a command line tools (or
> scripts) for performing these operations?

Some resources are linked from 
http://selinux.sourceforge.net/resources.php3
polgen may be helpful, but seeks to generate policy from strace output
rather than audit messages, see http://www.mitre.org/tech/selinux/.
There is also ongoing work on a policy development framework with some
higher level abstractions and on a reference policy with a more well-
defined interface.

> 3) A lot of my current services are chrooted, labelling files in the
> chroot seems to be a little bit difficult: I would like to re-use the
> same label used outside the chroot (ie: etc_t for chroot/(.*)/etc(/.*)*)
> but when I do, setfiles complains: "Operation not permitted". (-d tells
> you what you would have expected it to do, but not what went wrong) - I
> want to find which rule makes this illegal.

I'm not sure what you mean.  setfiles -r will let you specify an
alternate root path if you just want to apply the same types under the
chroot, but it may be smarter to use different types so that you can
completely prohibit access to the base system types by the daemon's
domain in your policy.  What is the actual output of setfiles?
Operation not permitted usually means that the kernel returned an errno
of EPERM on some system call, e.g. setfiles' domain lacked fowner
capability and you tried relabeling a file with another uid.

> 4) If I run ssh on a non-standard port, I need to tweak net_contexts,
> what is the preferred place for keeping these settings? Generally
> speaking, how do you maintain local customisations of the core policies?

No good answer yet.  There is presently support for local customization
of boolean settings, file contexts, and users (at least in Fedora)
without needing to touch policy sources.  For tweaks to .te rules, a
common convention is to create domains/misc/local.te or
domains/misc/custom.te.  The loadable module support that is in the
process of being upstreamed will allow for well-defined policy modules
with explicitly declared dependencies so you can define your own module
without disturbing the base one provided by your distributor, but I
think that support still only addresses the RBAC and TE rules, not
things like network contexts.  The MLS work will require the ability to
do site customization of netif contexts, so we'll likely have to add
similar support to libsepol for local customizations there as we have
already done for booleans and users.  That works by loading in the
binary policy file into memory, loading in the local customization
config files, mutating the in-memory policy image accordingly, and then
loading the resulting policy image into the kernel.

> 5) If one of my script needs to restart a service (like apache) what do
> I need to do to make it run without authentication. (run_init requires
> authentication - do I just allow a transition to initrc_t? I haven't
> tested this yet)

Fedora has a direct_sysadm_daemon tunable that enables automatic domain
transitions from sysadm_t to the daemon domains and automatic role
transitions from sysadm_r to system_r and authorizes root for system_r
(since there is no way to automatically transition user identities to
system_u; we originally expected all user identity transitions to be
explicit upon some action like authentication).

> 6) Can someone explain in layman's terms what needs to be fixed to get
> rid of warnings like:
> "security:  context system_u:system_r:[domain_t] is invalid"
> What is missing from my policy for [domain_t]? Assuming [domain_t] can
> be entered from initrc_t or sysadm_t for example, and that I have
> domain_auto_trans(initrc_t, [domain_bin_t], [domain_t]) +same for sysadm

The role has to be authorized for the domain, e.g.
	role system_r types domain_t;
Likewise, the user has to be authorized for the role, but that likely
isn't your issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
