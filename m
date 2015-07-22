Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6M7ulx6029073
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 03:56:47 -0400
Date: Wed, 22 Jul 2015 17:56:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150722075640.GE7943@dastard>
References: <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
 <87fv4owvxv.fsf@x220.int.ebiederm.org>
 <20150717000914.GO7943@dastard>
 <87380nobs4.fsf@x220.int.ebiederm.org>
 <20150717024735.GW3902@dastard>
 <20150721173721.GE11050@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721173721.GE11050@fieldses.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 21, 2015 at 01:37:21PM -0400, J. Bruce Fields wrote:
> On Fri, Jul 17, 2015 at 12:47:35PM +1000, Dave Chinner wrote:
> > On Thu, Jul 16, 2015 at 07:42:03PM -0500, Eric W. Biederman wrote:
> > > Dave Chinner <david@fromorbit.com> writes:
> > > > The key difference is that desktops only do this when you physically
> > > > plug in a device. With unprivileged mounts, a hostile attacker
> > > > doesn't need physical access to the machine to exploit lurking
> > > > kernel filesystem bugs. i.e. they can just use loopback mounts, and
> > > > they can keep mounting corrupted images until they find something
> > > > that works.
> > > 
> > > Yep.  That magnifies the problem quite a bit.
> > > 
> > > > User namespaces are supposed to provide trust separation.  The
> > > > kernel filesystems simply aren't hardened against unprivileged
> > > > attacks from below - there is a trust relationship between root and
> > > > the filesystem in that they are the only things that can write to
> > > > the disk. Mounts from within a userns destroys this relationship as
> > > > the userns root, by definition, is not a trusted actor.
> > > 
> > > I talked to Ted Tso a while back and ext4 is at least in principle
> > > already hardened against that kind of attack.  I am not certain I
> > > believe it, but if it is true I think it is fantastic.
> > 
> > No, it's not. No filesystem is, because to harden against such
> > attacks requires complete verification of all metadata when it is
> > read from disk, before it is used, or some method or ensuring the
> > block was not tampered with. CRCs are not sufficient, because they
> > can be tampered with, too.
> > 
> > The only way a filesystem would be able to trust what it reads from
> > disk has not been tampered with in a system with untrusted mounts is
> > if it has some kind of cryptographically secure signature in the
> > metadata and the attacker is unable to access the key for that
> > signature.
> 
> Preventing tampering is a little different from protecting the kernel
> from attack, isn't it?  I thought the latter was what people were asking
> about.

People might be asking for the latter, but the only attack vector
that can be made against filesystems from below is via tampering
with the on-disk structure.

An untrusted user in an untrusted container can construct arbitrary
untrusted filesystem structures and get them parsed by a context
running as $DIETY that assumes the structure is from a trusted
source.  What can possibly go wrong?

IOWs, To protect the kernel against attack from untrusted filesystem
images, we either have to be able to guarantee the image can not be
modified by untrusted parties (i.e.  needs to be created with
signed tools, contain only signed filesystem metadata and
signed/encrypted data), or we have to sandbox the filesystem parsing
code completely (i.e. fuse).

> So, for example, a screwed up on-disk directory structure shouldn't
> result in creating a cycle in the dcache and then deadlocking.

Therein lies the problem: how do you detect such structural defects
without doing a full structure validation? e.g. cyclic links may
only manifest when completely unrelated pieces of metadata are linked
together in a specific way.

Further, the problem is not restricted to validation at mount time -
if the user can write to the filesystem image file, then they can
modify it after it has been mounted, too. That means the attacker
may be someone who has broken into a container, not necessarily the
user you trusted with unprivileged mounts. That means every cold
metadata read needs to be treated with suspicion, not just at mount
time.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
