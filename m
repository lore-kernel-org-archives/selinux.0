Subject: Re: Another change we would like to make to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <4F3D16EF.6080904@redhat.com>
References: <4F3D16EF.6080904@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Feb 2012 15:43:44 -0500
Message-ID: <1329857024.12501.85.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-02-16 at 09:47 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Currently we have lots of apps trying to figure out which policy is
> installed on the system,  We have a function
> selinux_binary_policy_path which returns a path like
> '/etc/selinux/targeted/policy'
> 
> Then these apps do stuff like:
> 
> VER=`cat /sys/fs/selinux/policyver`
> while [ -e '/etc/selinux/targetd/policy. + $VER' ]; do
>       VER=$VER-1
> done
> 
> While we have had /sys/fs/selinux/policy for a while now.
> 
> I wanted to add an interface to return this path, but I was trying to
> figure out a name selinux_loaded_policy_path for example, but as Eric
> pointed out to me, selinux_binary_policy_path is what most users would
> expect to return this.  If you look at the man page it even suggest this.
> 
> man selinux_binary_policy_path
> ...
>        selinux_binary_policy_path() - binary policy file loaded into
> kernel
> 
> 
> Currently the users of this function are the libselinux package,
> setools and policycorutils (sepolgen-ifgen).
> 
> 
> I am torn between adding stealing this function to return the
> /sys/fs/selinux/policy and then adding selinux_installed_policy_path
> for the original function, then updating the effected packages.
> 
> The problem with this is we would have different behaviour between
> older versions of the library. The other options would be to come up
> with a better name for the new function and fix the man pages.
> 
> Suggestions welcomed.

Most applications should not be using /sys/fs/selinux/policy, as that
requires the kernel to generate the policy image from its in-core data
structures and is expensive.  So you certainly should not change
selinux_binary_policy_path() to return that pathname.  That also would
be an incompatible interface change due to the version suffix, as you
note.

So I think you need a new interface.  selinux_kernel_policy_path() or
selinux_active_policy_path() or selinux_loaded_policy_path() seem fine
to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
