Date: Fri, 25 Jan 2002 12:47:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: Paul Krumviede <pwk@acm.org>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <1011976523.2215.4.camel@phobos>
Message-ID: <Pine.GSO.4.33.0201251146080.7127-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 25 Jan 2002, Timothy Wood wrote:

> never raise.  What I still don't see is how the lo interface never loads
> because as far as I know the lo interface doesn't have a module.  I'm
> sifting through dmesg once again, a little more closely this time, and
> I"m seeing a lot of wierd things.  Someone tell me if all this looks
> right.

I've seen the error that you are seeing before, but it was due to not
enabling the Netlink and Routing message options in the kernel config for
RH7.2 systems.  It didn't have anything to do with SELinux.  If you are
running in permissive mode, then SELinux won't deny anything, so the avc
denied messages are irrelevant, although you will need to customize the
policy for your VMware setup before switching into enforcing mode.

> (right after journalled loads)
> kernel: There is already a security framework initialized,
> register_security failed.
> kernel: Failure registering capabilities with the kernel
> kernel: selinux_register_security:  Registering secondary module
> capability
> localhost kernel: Capability LSM initialized

These messages are normal.  The capabilities security module tries to
register itself as the primary security module and fails (because SELinux
has already registered itself), and then falls back to registering itself
as a secondary security module (under the SELinux module).

> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 1 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 1 exe=none

These messages are normal.  They occur when SELinux encounters a process
that was created before SELinux loaded the policy configuration, and
simply show that SELinux is assigning a security context to the
pre-existing process based on the policy.

> kernel: avc:  denied  { read } for  pid=74 exe=/sbin/insmod
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:insmod_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

The avc denied messages reflect aspects of your VMWare setup.
You'll need to grant these permissions before switching into enforcing
mode, but they are irrelevant while in permissive mode.

> network: Setting network parameters:  succeeded
> ifup: Cannot send dump request: Connection refused

As I said, I've only see this occur when Netlink and Routing message
support is not enabled in the kernel config.

> I'm going to download this new version, but should I just get the patch
> and apply it to the current version I have or what?

There have been a number of bug fixes (patches posted to the mailing list)
since the old release, as well as some minor enhancements and upgrades to
the base kernel versions (available in the new release).

If you want to more easily track new versions, you might want to checkout
the CVS tree at the sourceforge site.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
