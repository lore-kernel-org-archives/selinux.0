Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PHOq6n012646
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 13:24:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-4-git-send-email-seth.forshee@canonical.com>
 <87si63o56g.fsf@x220.int.ebiederm.org>
 <20150925124833.GA104990@ubuntu-hedt>
Date: Fri, 25 Sep 2015 12:16:59 -0500
In-Reply-To: <20150925124833.GA104990@ubuntu-hedt> (Seth Forshee's message of
 "Fri, 25 Sep 2015 07:48:33 -0500")
Message-ID: <87si62ju5w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 3/7] fs: Verify access of user towards block device
 file when mounting
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Argh.  This looks like morning person meets night owl.

Seth Forshee <seth.forshee@canonical.com> writes:

> On Thu, Sep 24, 2015 at 04:53:11PM -0500, Eric W. Biederman wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>> 
>> > When mounting a filesystem on a block device there is currently
>> > no verification that the user has appropriate access to the
>> > device file passed to mount. This has not been an issue so far
>> > since the user in question has always been root, but this must
>> > be changed before allowing unprivileged users to mount in user
>> > namespaces.
>> >
>> > To do this, a new version of lookup_bdev() is added named
>> > lookup_bdev_perm(). Both of these functions become wrappers
>> > around a common inner fucntion. The behavior of lookup_bdev() is
>> > unchanged, but calling lookup_bdev_perm() will fail if the user
>> > does not have the specified access rights to the supplied path.
>> > The permission check is skipped if the user has CAP_SYS_ADMIN to
>> > avoid any possible regressions in behavior.
>> >
>> > blkdev_get_by_path() is updated to use lookup_bdev_perm(). This
>> > is used by mount_bdev() and mount_mtd(), so this will cause
>> > mounts on block devices to fail when the user lacks the required
>> > permissions. Other calls to blkdev_get_by_path() will all happen
>> > with root privileges, so these calls will be unaffected.
>> 
>> Good but buggy patch.
>> 
>> In the mtd bits the flags are super flags, not file mode bits,
>> which makes testing them against FMODE_READ and FMODE_WRITE is
>> incorrect.
>
> Bah, yes. Fixed.
>
>> Further it looks like quite a few more possibly all of the lookup_bdev
>> instances could use inode level permission checking.
>> 
>> Certainly code such as quotactl makes me wonder.
>
> I opted to stick to places related to mounting, but let's take a look at
> the other callers.
>
> bcache calls it in the context of sysfs writes, and those attributes are
> writable only by root. In that case the inode permission check will be
> skipped anyway, so it makes no difference either way.
>
> Device mapper calls it in dm_get_device, which is called from a bunch of
> places. I had started trying to walk back through all the callers of
> dm_get_device, but that rabbit hole got really deep really quickly so I
> didn't feel confident that changing it wouldn't break anyone.
>
> quotactl gave me pause, as it seems to have done for you too. I was
> surprised that inode permissions aren't checked, but
> check_quotactl_permission does get called before actually doing
> anything. I fear that adding a check of inode permissions could end up
> breaking someone.

My gut feel on all of this is that we should act like may_open and have
have a flag of 0 for access mode mean don't check permissions.

That way we can change all of the callers of lookup_bdev to pass an
additional argument and make it explicit what is going on but we don't
actually have to change the callers to actually perform an additional
check.

Leaving stones unturned is a good way to introduce a security hole by
accident so I don't want to leave dm_get_device unreviewed, but any
changes can be in later patches.

Eric
