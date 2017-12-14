Message-ID: <1513271755.18008.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>, yangjihong
 <yangjihong1@huawei.com>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>, Lukas Vrabec
 <lvrabec@redhat.com>, Petr Lautrbach <plautrba@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2017 12:15:55 -0500
In-Reply-To: <79e41bd9-2570-7386-d462-d242a18fb786@schaufler-ca.com>
References: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D1F3@DGGEMM506-MBS.china.huawei.com>
 <1513178296.19161.8.camel@tycho.nsa.gov>
 <23c51943-51a4-4478-760f-375d02caa39b@schaufler-ca.com>
 <1513269771.18008.6.camel@tycho.nsa.gov>
 <79e41bd9-2570-7386-d462-d242a18fb786@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [BUG]kernel softlockup due to sidtab_search_context run for
 long time because of too many sidtab context node
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-12-14 at 09:00 -0800, Casey Schaufler wrote:
> On 12/14/2017 8:42 AM, Stephen Smalley wrote:
> > On Thu, 2017-12-14 at 08:18 -0800, Casey Schaufler wrote:
> > > On 12/13/2017 7:18 AM, Stephen Smalley wrote:
> > > > On Wed, 2017-12-13 at 09:25 +0000, yangjihong wrote:
> > > > > Hello, 
> > > > > 
> > > > > I am doing stressing testing on 3.10 kernel(centos 7.4), to
> > > > > constantly starting numbers of docker ontainers with selinux
> > > > > enabled,
> > > > > and after about 2 days, the kernel softlockup panic:
> > > > >  <IRQ>  [<ffffffff810bb778>] sched_show_task+0xb8/0x120
> > > > >  [<ffffffff8116133f>] show_lock_info+0x20f/0x3a0
> > > > >  [<ffffffff811226aa>] watchdog_timer_fn+0x1da/0x2f0
> > > > >  [<ffffffff811224d0>] ?
> > > > > watchdog_enable_all_cpus.part.4+0x40/0x40
> > > > >  [<ffffffff810abf82>] __hrtimer_run_queues+0xd2/0x260
> > > > >  [<ffffffff810ac520>] hrtimer_interrupt+0xb0/0x1e0
> > > > >  [<ffffffff8104a477>] local_apic_timer_interrupt+0x37/0x60
> > > > >  [<ffffffff8166fd90>] smp_apic_timer_interrupt+0x50/0x140
> > > > >  [<ffffffff8166e1dd>] apic_timer_interrupt+0x6d/0x80
> > > > >  <EOI>  [<ffffffff812b4193>] ?
> > > > > sidtab_context_to_sid+0xb3/0x480
> > > > >  [<ffffffff812b41f0>] ? sidtab_context_to_sid+0x110/0x480
> > > > >  [<ffffffff812c0d15>] ? mls_setup_user_range+0x145/0x250
> > > > >  [<ffffffff812bd477>] security_get_user_sids+0x3f7/0x550
> > > > >  [<ffffffff812b1a8b>] sel_write_user+0x12b/0x210
> > > > >  [<ffffffff812b1960>] ? sel_write_member+0x200/0x200
> > > > >  [<ffffffff812b01d8>] selinux_transaction_write+0x48/0x80
> > > > >  [<ffffffff811f444d>] vfs_write+0xbd/0x1e0
> > > > >  [<ffffffff811f4eef>] SyS_write+0x7f/0xe0
> > > > >  [<ffffffff8166d433>] system_call_fastpath+0x16/0x1b
> > > > > 
> > > > > My opinion:
> > > > > when the docker container starts, it would mount overlay
> > > > > filesystem
> > > > > with different selinux context, mount point such as: 
> > > > > overlay on
> > > > > /var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f6cb0f
> > > > > 07b4
> > > > > bc32
> > > > > 6cb07495ca08fc9ddb66/merged type overlay
> > > > > (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:
> > > > > s0:c
> > > > > 414,
> > > > > c873",lowerdir=/var/lib/docker/overlay2/l/Z4U7WY6ASNV5CFWLADP
> > > > > ARHH
> > > > > WY7:
> > > > > /var/lib/docker/overlay2/l/V2S3HOKEFEOQLHBVAL5WLA3YLS:/var/li
> > > > > b/do
> > > > > cker
> > > > > /overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdir=/var/lib/dock
> > > > > er/o
> > > > > verl
> > > > > ay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc326cb07495ca08f
> > > > > c9dd
> > > > > b66/
> > > > > diff,workdir=/var/lib/docker/overlay2/be3ef517730d92fc4530e0e
> > > > > 952e
> > > > > ae4f
> > > > > 6cb0f07b4bc326cb07495ca08fc9ddb66/work)
> > > > > shm on
> > > > > /var/lib/docker/containers/9fd65e177d2132011d7b422755793449c9
> > > > > 1327
> > > > > ca57
> > > > > 7b8f5d9d6a4adf218d4876/shm type tmpfs
> > > > > (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:s
> > > > > virt
> > > > > _san
> > > > > dbox_file_t:s0:c414,c873",size=65536k)
> > > > > overlay on
> > > > > /var/lib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb
> > > > > 7258
> > > > > cbca
> > > > > 14ff6d165b94353eefab/merged type overlay
> > > > > (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:
> > > > > s0:c
> > > > > 431,
> > > > > c651",lowerdir=/var/lib/docker/overlay2/l/3MQQXB4UCLFB7ANVRHP
> > > > > AVRC
> > > > > RSS:
> > > > > /var/lib/docker/overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdi
> > > > > r=/v
> > > > > ar/l
> > > > > ib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cb
> > > > > ca14
> > > > > ff6d
> > > > > 165b94353eefab/diff,workdir=/var/lib/docker/overlay2/38d1544d
> > > > > 0801
> > > > > 45c7
> > > > > d76150530d0255991dfb7258cbca14ff6d165b94353eefab/work)
> > > > > shm on
> > > > > /var/lib/docker/containers/662e7f798fc08b09eae0f0f944537a4bce
> > > > > dc1d
> > > > > cf05
> > > > > a65866458523ffd4a71614/shm type tmpfs
> > > > > (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:s
> > > > > virt
> > > > > _san
> > > > > dbox_file_t:s0:c431,c651",size=65536k)
> > > > > 
> > > > > sidtab_search_context check the context whether is in the
> > > > > sidtab
> > > > > list, If not found, a new node is generated and insert into
> > > > > the
> > > > > list,
> > > > > As the number of containers is increasing,  context nodes are
> > > > > also
> > > > > more and more, we tested the final number of nodes reached
> > > > > 300,000 +,
> > > > > sidtab_context_to_sid runtime needs 100-200ms, which will
> > > > > lead to
> > > > > the
> > > > > system softlockup.
> > > > > 
> > > > > Is this a selinux bug? When filesystem umount, why context
> > > > > node
> > > > > is
> > > > > not deleted?  I cannot find the relevant function to delete
> > > > > the
> > > > > node
> > > > > in sidtab.c
> > > > > 
> > > > > Thanks for reading and looking forward to your reply.
> > > > 
> > > > So, does docker just keep allocating a unique category set for
> > > > every
> > > > new container, never reusing them even if the container is
> > > > destroyed? 
> > > > That would be a bug in docker IMHO.  Or are you creating an
> > > > unbounded
> > > > number of containers and never destroying the older ones?
> > > 
> > > You can't reuse the security context. A process in ContainerA
> > > sends
> > > a labeled packet to MachineB. ContainerA goes away and its
> > > context
> > > is recycled in ContainerC. MachineB responds some time later,
> > > again
> > > with a labeled packet. ContainerC gets information intended for
> > > ContainerA, and uses the information to take over the Elbonian
> > > government.
> > 
> > Docker isn't using labeled networking (nor is anything else by
> > default;
> > it is only enabled if explicitly configured).
> 
> If labeled networking weren't an issue we'd have full security
> module stacking by now. Yes, it's an edge case. If you want to
> use labeled NFS or a local filesystem that gets mounted in each
> container (don't tell me that nobody would do that) you've got
> the same problem.

Even if someone were to configure labeled networking, Docker is not
presently relying on that or SELinux network enforcement for any
security properties, so it really doesn't matter.  And if they wanted
to do that, they'd have to coordinate category assignments across all
systems involved, for which no facility exists AFAIK.  If you have two
docker instances running on different hosts, I'd wager that they can
hand out the same category sets today to different containers.

With respect to labeled NFS, that's also not the default for nfs
mounts, so again it is a custom configuration and Docker isn't relying
on it for any guarantees today.  For local filesystems, they would
normally be context-mounted or using genfscon rather than xattrs in
order to be accessible to the container, thus no persistent storage of
the category sets.

Certainly docker could provide an option to not reuse category sets,
but making that the default is not sane and just guarantees exhaustion
of the SID and context space (just create and tear down lots of
containers every day or more frequently).

> 
> > > > On the selinux userspace side, we'd also like to eliminate the
> > > > use
> > > > of
> > > > /sys/fs/selinux/user (sel_write_user -> security_get_user_sids)
> > > > entirely, which is what triggered this for you.
> > > > 
> > > > We cannot currently delete a sidtab node because we have no way
> > > > of
> > > > knowing if there are any lingering references to the
> > > > SID.  Fixing
> > > > that
> > > > would require reference-counted SIDs, which goes beyond just
> > > > SELinux
> > > > since SIDs/secids are returned by LSM hooks and cached in other
> > > > kernel
> > > > data structures.
> > > 
> > > You could delete a sidtab node. The code already deals with
> > > unfindable
> > > SIDs. The issue is that eventually you run out of SIDs. Then you
> > > are
> > > forced to recycle SIDs, which leads to the overthrow of the
> > > Elbonian
> > > government.
> > 
> > We don't know when we can safely delete a sidtab node since SIDs
> > aren't
> > reference counted and we can't know whether it is still in use
> > somewhere in the kernel.  Doing so prematurely would lead to the
> > SID
> > being remapped to the unlabeled context, and then likely to
> > undesired
> > denials.
> 
> I would suggest that if you delete a sidtab node and someone
> comes along later and tries to use it that denial is exactly
> what you would desire. I don't see any other rational action.

Yes, if we know that the SID wasn't in use at the time we tore it down.
 But if we're just randomly deleting sidtab entries based on age or
something (since we have no reference count), we'll almost certainly
encounter situations where a SID hasn't been accessed in a long time
but is still being legitimately cached somewhere.  Just a file that
hasn't been accessed in a while might have that SID still cached in its
inode security blob, or anywhere else.

> 
> > > > sidtab_search_context() could no doubt be optimized for the
> > > > negative
> > > > case; there was an earlier optimization for the positive case
> > > > by
> > > > adding
> > > > a cache to sidtab_context_to_sid() prior to calling it.  It's a
> > > > reverse
> > > > lookup in the sidtab.
> > > 
> > > This seems like a bad idea.
> > 
> > Not sure what you mean, but it can certainly be changed to at least
> > use
> > a hash table for these reverse lookups.
> > 
> > 
