Subject: Re: [patch] enhanced MLS support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <41EC4743.1040803@trustedcs.com>
References: <41EC4682.8050807@trustedcs.com>
	 <41EC4743.1040803@trustedcs.com>
Content-Type: text/plain
Message-Id: <1106329347.28551.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 12:42:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-17 at 18:16, Darrel Goeddel wrote:
> Darrel Goeddel wrote:
> > Hello,
> >     I have attached patches which provide many enhancements to the MLS...
> 
> Here is the userland patch.

Thanks for contributing this enhanced MLS support.  I've looked over the
code and sent a few comments privately.  I also have (finally) gotten a
FC3-based system up and running with the modified kernel and policy, but
this required several steps and additional modifications to the policy,
which I've included below for anyone else who may want to experiment
with the MLS support.  Note that this wouldn't be necessary for a direct
install of a MLS system, which would be the standard case for real users
of MLS.

Steps for converting an existing SELinux system to one with the enhanced
MLS support (Note: reversing this conversion is likewise difficult, so
I'd only do this on a spare machine unless you plan to stay with MLS):

1) Obviously, apply the patches that Darrel provided for the kernel and
userland, and build and install the modified kernel, libsepol, and
checkpolicy.

2) The userland patch doesn't actually enable MLS in the policy
Makefile, and it doesn't include the full set of changes required to
build a MLS policy.  I'll send separately a policy patch relative to the
userland patch that makes the necessary changes to at least compile a
MLS policy.  This includes adding MLS levels to all security contexts,
updating the policy Makefile to enable MLS support and to install the
policy under /etc/selinux/mls, and adding example level and range
authorizations for each user entry.  Apply the patch or make similar
changes to your policy source tree, build and install the new policy,
and change /etc/selinux/config to set SELINUXTYPE=mls.

3) Boot the new kernel into single user mode with selinux=0.  I
originally just tried booting with enforcing=0, but this was not
sufficient, as the current SELinux module will not allow you to mount a
filesystem if the security context on the root inode is invalid (and it
will be with the MLS policy, as it will lack a MLS level).  We may want
to change this behavior of the SELinux module, as it would also pose a
problem if the context were invalid for any other reason (e.g. if the
type of the root inode is no longer defined or the security context was
corrupted in some manner).

4) Relabel all filesystems, e.g. fixfiles relabel.

5) Unmount each mounted filesystem and manually relabel the mount point
directories.   Otherwise, they will also have an invalid security
context and attempts to mount on them are likely to fail.  Note that you
may need to manually use chcon rather than setfiles or restorecon on
these mount point directories, particularly for /selinux, /proc, and
/sys, as file_contexts specifies <<none>> for these directories to avoid
trying to label the pseudo filesystems mounted on the directories, and
restorecon will immediately bail anyway if it can't detect whether
SELinux is enabled (which requires /proc to be mounted).

6) Reboot and come up with the new kernel in enforcing mode.

7) At this point, you should be able to login and work as usual at the
low level (s0).  Actually doing anything interesting with multiple
levels is a bit more problematic, as there is not a newlevel program yet
and runcon will only work for level changes in permissive mode.  You
would likely need to tweak the authorized range for system_u and change
the default level for a given user in order to directly login with
another level.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
