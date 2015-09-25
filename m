Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PCmlFj021268
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 08:48:47 -0400
Received: by ioiz6 with SMTP id z6so108799134ioi.2
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 05:48:46 -0700 (PDT)
Date: Fri, 25 Sep 2015 07:48:33 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 3/7] fs: Verify access of user towards block device
 file when mounting
Message-ID: <20150925124833.GA104990@ubuntu-hedt>
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-4-git-send-email-seth.forshee@canonical.com>
 <87si63o56g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87si63o56g.fsf@x220.int.ebiederm.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 24, 2015 at 04:53:11PM -0500, Eric W. Biederman wrote:
> Seth Forshee <seth.forshee@canonical.com> writes:
> 
> > When mounting a filesystem on a block device there is currently
> > no verification that the user has appropriate access to the
> > device file passed to mount. This has not been an issue so far
> > since the user in question has always been root, but this must
> > be changed before allowing unprivileged users to mount in user
> > namespaces.
> >
> > To do this, a new version of lookup_bdev() is added named
> > lookup_bdev_perm(). Both of these functions become wrappers
> > around a common inner fucntion. The behavior of lookup_bdev() is
> > unchanged, but calling lookup_bdev_perm() will fail if the user
> > does not have the specified access rights to the supplied path.
> > The permission check is skipped if the user has CAP_SYS_ADMIN to
> > avoid any possible regressions in behavior.
> >
> > blkdev_get_by_path() is updated to use lookup_bdev_perm(). This
> > is used by mount_bdev() and mount_mtd(), so this will cause
> > mounts on block devices to fail when the user lacks the required
> > permissions. Other calls to blkdev_get_by_path() will all happen
> > with root privileges, so these calls will be unaffected.
> 
> Good but buggy patch.
> 
> In the mtd bits the flags are super flags, not file mode bits,
> which makes testing them against FMODE_READ and FMODE_WRITE is
> incorrect.

Bah, yes. Fixed.

> Further it looks like quite a few more possibly all of the lookup_bdev
> instances could use inode level permission checking.
> 
> Certainly code such as quotactl makes me wonder.

I opted to stick to places related to mounting, but let's take a look at
the other callers.

bcache calls it in the context of sysfs writes, and those attributes are
writable only by root. In that case the inode permission check will be
skipped anyway, so it makes no difference either way.

Device mapper calls it in dm_get_device, which is called from a bunch of
places. I had started trying to walk back through all the callers of
dm_get_device, but that rabbit hole got really deep really quickly so I
didn't feel confident that changing it wouldn't break anyone.

quotactl gave me pause, as it seems to have done for you too. I was
surprised that inode permissions aren't checked, but
check_quotactl_permission does get called before actually doing
anything. I fear that adding a check of inode permissions could end up
breaking someone.

> Ugh.  Your code needs to be using __inode_permission and not
> inode_permission.
> 
> The readability or writability of a device node has little or nothing to
> do with the readability/writability of the superblock.   So I don't see
> any reason we should be checking that.

Makes sense, fixed.

Thanks,
Seth
