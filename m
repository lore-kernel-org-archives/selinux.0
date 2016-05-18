Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4IFunhT003781
 for <selinux@tycho.nsa.gov>; Wed, 18 May 2016 11:56:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <mszeredi@redhat.com>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 cgroups@vger.kernel.org
References: <1461699046-30485-1-git-send-email-seth.forshee@canonical.com>
 <1461699046-30485-4-git-send-email-seth.forshee@canonical.com>
 <87shxgxqai.fsf@x220.int.ebiederm.org>
 <20160517235834.GA104031@ubuntu-hedt>
Date: Wed, 18 May 2016 10:45:31 -0500
In-Reply-To: <20160517235834.GA104031@ubuntu-hedt> (Seth Forshee's message of
 "Tue, 17 May 2016 18:58:34 -0500")
Message-ID: <8760ubs738.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 03/21] fs: Allow sysfs and cgroupfs to share super
 blocks between user namespaces
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Seth Forshee <seth.forshee@canonical.com> writes:

> On Tue, May 17, 2016 at 05:39:33PM -0500, Eric W. Biederman wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>> 
>> > Both of these filesystems already have use cases for mounting the
>> > same super block from multiple user namespaces. For sysfs this
>> > happens when using criu for snapshotting a container, where sysfs
>> > is mnounted in the containers network ns but the hosts user ns.
>> > The cgroup filesystem shares the same super block for all mounts
>> > of the same hierarchy regardless of the namespace.
>> >
>> > As a result, the restriction on mounting a super block from a
>> > single user namespace creates regressions for existing uses of
>> > these filesystems. For these specific filesystems this
>> > restriction isn't really necessary since the backing store is
>> > objects in kernel memory and thus the ids assigned from inodes
>> > is not subject to translation relative to s_user_ns.
>> >
>> > Add a new filesystem flag, FS_USERNS_SHARE_SB, which when set
>> > causes sget_userns() to skip the check of s_user_ns. Set this
>> > flag for the sysfs and cgroup filesystems to fix the
>> > regressions.
>> 
>> So this one needs to be sget_userns(..., &init_user_ns, ...).
>> And not a new special case.
>
> This is actually what I wanted to do, but based on a previous discussion
> where I had suggested doing this (for a different reason) I came away
> thinking you did not want it that way. So I'm happy with that change.

Yeah.  Somedays it seems like there are a lot of pieces in play here.
The security labels on sysfs seems to be a very compelling case.

> But if we do that it violates some of the assumptions of the patch to
> rework MNT_NODEV on your testing branch (and also those behind patch 2
> in this series). Something will need to be changed there to prevent a
> regression in mount behavior when a user ns tries to mount without
> MNT_NODEV when the mount inherited from its parent has it set.

Thank you for pointing that out.  I will look into that.

I believe I know exactly what you are talking about.  Of the choices I
think it is better to a minor localized change in the fs_fully_visible
logic than it is to cause problems elsewhere.

>> Apologies for not catching this earlier.
>
> Actually this is a more recent patch, so you possibly hadn't seen it
> before.
>
>> I am looking at folding all of this into the patch that introduces
>> sget_userns so that even bisects won't have regresssions.
>
> That's fine with me.

And thank you for keeping everything as separate patches.  That is at
least helping me catch up.  Even if I don't agree that these things
should be separate come merge time.

Eric
