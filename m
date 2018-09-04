From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dmitry Vyukov <dvyukov@google.com>, Paul Moore <paul@paul-moore.com>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 SELinux <selinux@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>
Date: Tue, 04 Sep 2018 23:16:11 +1000
Message-ID: <5806108.mdyebWjNCB@liv>
In-Reply-To: <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, 4 September 2018 10:57:15 PM AEST Stephen Smalley wrote:
> > I installed the tools, and we started loading policy.
> > But then it turned out that wheezy policy does not allows mounting
> > cgroup2 fs and maybe some others even in non-enforcing mode. As far as
> > I understand that's because the policy does not have definition for
> > the fs, and so loading bails out with an error.

The aim has always been with SE Linux in Debian that the policy will support 
the kernel from the next release and from the previous release.  Much of this 
comes from upstream, but sometimes we have to go out of our way to get it.  
Sometimes if you want to run unusual combinations of kernel and OS Debian 
doesn't get a backport of the policy to support it in which case I often have 
a special policy on my site to do it.

It seems strange that you wouldn't be able to mount a filesystem in permissive 
mode.  Which program was trying to mount it?  Was it systemd?  It might be a 
systemd bug.

> > We need cgroup2 both for testing and for better sandboxing (no other
> > way to restrict e.g. memory consumption). Moreover, we did not test
> > any actual interesting interactions with selinux (there must be some?
> > but I don't know what are they).
> > So I had to uninstall the tool and policy is not loaded again.
> > I investigated building a newer debian image with debootstrap (which
> > should have newer policy I guess). But they don't work, some cryptic
> > errors in init. Other people reported the same.
> > So that's we are. I don't have any ideas left...

It would be nice to know what the errors are.  Although we aren't really 
interested in bug reports from Wheezy, Stretch is the current stable release.
 
> So why not ask for help from the SELinux community?  I've cc'd the
> selinux list and a couple of folks involved in Debian selinux.  I see a
> couple of options but I don't know your constraints for syzbot:
> 
> 1) Run an instance of syzbot on a distro that supports SELinux enabled
> out of the box like Fedora. Then you don't have to fight with SELinux
> and can just focus on syzbot, while still testing SELinux enabled and
> enforcing.
> 
> 2) Report the problems you are having with enabling SELinux on newer
> Debian to the selinux list and/or the Debian selinux package maintainers
> so that someone can help you resolve them.
> 
> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
> rebuild it, and install that.  We could help provide guidance on that.
> I think you'll need to rebuild the base policy on wheezy; in
> distributions with modern SELinux userspace, one could do it just by
> adding a CIL module locally.

I could backport that myself and put the package on my apt repository.  Tell 
me what version of the kernel you are using and I'll have a look at it.

> As for exercising SELinux, you'll exercise SELinux just by enabling it
> and loading a policy, since it will perform permission checking on all
> object accesses.   But you can get more extensive coverage by running
> the selinux-testsuite.  We only test that on Fedora and RHEL however, so
> getting it to work on Debian might take some effort.


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
