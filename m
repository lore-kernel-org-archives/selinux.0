Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
	 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
Content-Type: text/plain
Date: Thu, 01 May 2008 08:31:39 -0400
Message-Id: <1209645099.25678.434.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-01 at 22:11 +1000, James Morris wrote:
> On Thu, 1 May 2008, Stephen Smalley wrote:
> 
> > It isn't a perfectly general solution, of course.
> > 
> > An alternative approach would be for rpm to load policy at least
> > defining the types first before setting down the files, which was our
> > original preference, but that wasn't viewed as workable by the distro
> > folks.  It might be easier if we had a specific SELinux kernel interface
> > (i.e. another selinuxfs node) that permitted adding types w/o performing
> > a complete policy reload.
> 
> I gather the problem is build hosts where you don't want to give that much 
> privilege to users.

No, it isn't about privilege.  It is about:
1) Being able to handle new labels not known to the build host policy
w/o otherwise changing the build host policy (i.e. we do not want to
wholesale replace the build host policy with the policy for the
distribution image we are building, and they may be quite different in
nature - in terms of applications covered, strict vs. targeted, mcs vs.
mls, etc), and
2) Avoiding the performance overhead of a complete policy reload on each
package install.

So our options are either to provide a way to set unknown labels on disk
(the current patch) or to provide a lightweight mechanism for adding new
labels to an existing policy (difficult for the reasons already
described, plus it is even more of an issue for e.g. building a mcs or
mls enabled distro on a non-mcs/mls build host, e.g. building RHEL5 on
RHEL4, as then you have another label component completely foreign to
the build host with no way to define it).  Or a mechanism for a
hierarchy of policies (complex, and not clear how to handle objects as
they may be visible to processes operating under more than one policy,
e.g. both inside and outside of the chroot).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
