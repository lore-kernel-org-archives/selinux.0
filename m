Subject: Re: latest diff
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20050323110957.GI12610@rom.cip.ifi.lmu.de>
References: <423BCC68.3090003@redhat.com>
	 <1111248890.5582.20.camel@chris.pebenito.net> <423C54F5.5060205@redhat.com>
	 <20050323110957.GI12610@rom.cip.ifi.lmu.de>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 08:51:29 -0500
Message-Id: <1111585889.21107.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-23 at 12:10 +0100, Thomas Bleher wrote:
> Would it be possible to decompose sys_admin into a set of selinux
> permissions? I think this would be the best solution. 
> Probably difficult with the current design, but maybe capable() could
> get a second parameter specifying what type of access is to be granted,
> or the code could call an lsm function in addition to the capable()
> call.
> Is this doable?

Yes, feel free to suggest/submit patches (to the lsm mailing list and
lkml) to add new LSM hooks to code where the existing capable call
provides insufficient granularity, and then move the capable call into
the hook function implementation for the dummy and capability modules.
The goal should be to replace capable() calls with more flexible LSM
hooks wherever it makes sense to do so, but doing that completely in the
first round of LSM was viewed as impractical (e.g. >500 calls to capable
in the kernel tree).  Then for SELinux, you can define new permissions
in the system class or create new classes as appropriate to provide
finer-grained controls.

Another item that ultimately needs to be addressed is the mapping of
device and filesystem ioctls to more general permission check calls to
the security module, so that interpretation can remain in the device and
filesystem code but reasonable controls can be applied by security
policies.  This would be similar to what James Morris did for the
netlink message types, although that presently relies on maintaining a
separate netlink message type table for SELinux (which may be a
maintenance problem in the long term, and certainly won't scale for
ioctls).

Another fun task would be to provide _real_ labeling and control of
devices, not just device nodes in the filesystem, so that the ability to
create device nodes doesn't allow one to sidestep access controls based
on the device type.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
