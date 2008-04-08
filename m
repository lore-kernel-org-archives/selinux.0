Subject: Re: upstart/SELinux problem loading the wrong policy with kernel
	version change
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <47FACB0F.5050208@redhat.com>
References: <47FACB0F.5050208@redhat.com>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 08:54:21 -0400
Message-Id: <1207659261.21223.261.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 21:31 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> If you have a kernel that supports policy.21 and a tool chain that
> supports policy.22 newer versions of policy and semanage changes will
> update policy.22.  However if there is a policy.21 around upstart will
> load this on a reboot.  (I guess init would have done the same.)

No, init wouldn't have done the same, because init (in Fedora and RHEL)
is dynamically linked and thus picks up the latest libsepol each time.

> If the policy.21 does not exist libselinux will grab the highest policy
> version and try to load it.

No, libselinux presently always starts from the latest version supported
by libsepol and works its way downwards.  But it will not look for any
newer version than the one supported by libsepol, which is why you are
having a problem.  And that is because it historically needed libsepol
support to do any of the following:
- patch in the current boolean values,
- patch in local user definitions,
- downgrade the policy to a version supported by the kernel.

The first two are obsolete but not the last.

> This is causing unlabeled_t files to be showing up.  Basically if I
> install a new policy with a new type, and then assign the context to a
> file, the next reboot will cause the file to be labeled unlabeled_t.
> 
> I suggest that we either remove policy versioning all together, or
> change libselinux to default to loading the highest policy version.
> Either way the current loading of policy is broken.

Per Chad, they don't have this problem in Ubuntu because they just have
a shell script in the initrd that chroot's to the real root and runs
load_policy from there, thereby picking up the latest libsepol from the
real root filesystem.  So Fedora only has a problem because it patches
nash directly and thus brings in a libsepol dependency into the initrd.

We have to consider the implications of any change in the current
behavior on existing systems too.  Suppose that libselinux was changed
to start with the max(kernelversion,libsepolversion) and then probe
downward from there.  That would find the newer policy files when they
are supported by the kernel.  However, it would then be unable to patch
in boolean or user values into those policies since libsepol wouldn't
understand them.  Which could potentially break RHEL 4 systems.
Although one should never have more than one policy file there, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
