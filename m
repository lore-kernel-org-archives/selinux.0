From: yangjihong <yangjihong1@huawei.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "eparis@parisplace.org" <eparis@parisplace.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, Daniel J Walsh
 <dwalsh@redhat.com>, Lukas Vrabec <lvrabec@redhat.com>, Petr Lautrbach
 <plautrba@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2017 03:19:18 +0000
Message-ID: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D2AF@DGGEMM506-MBS.china.huawei.com>
References: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D1F3@DGGEMM506-MBS.china.huawei.com>
 <1513178296.19161.8.camel@tycho.nsa.gov>
In-Reply-To: <1513178296.19161.8.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: =?utf-8?b?W05vbi1Eb0QgU291cmNlXSDnrZTlpI06IFtCVUdda2VybmVsIHNvZnRsb2Nr?=
 =?utf-8?q?up_due_to_sidtab=5Fsearch=5Fcontext_run_for_long_time_because_o?=
 =?utf-8?q?f_too_many_sidtab_context_node?=
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

>  So, does docker just keep allocating a unique category set for every new container, never reusing them even if the container is destroyed? 
>  That would be a bug in docker IMHO.  Or are you creating an unbounded number of containers and never destroying the older ones?
I creat a containers, then destroy it,  and create second one, destroy it.......
When docker created, it will mount overlay fs, because every containers has different selinux context, so a new sidtab node is generated and insert into the sidtab list  
When docker destroyed, it will umount overlay fs, but umount operation does not seem relevant to "delete the node" hooks function, resulting in longer and longer sidtab list
I think when umount, its selinux context will never reuse, so sidtab node is useless, it is best to delete it


>  sidtab_search_context() could no doubt be optimized for the negative case; there was an earlier optimization for the positive case by adding a cache to sidtab_context_to_sid() prior to calling it.  It's a reverse lookup in the sidtab.
I think add cache may be not very userful, because every containers has different selinux context, so when one docker created, it will search the whole sidtab list, until compare the last node, When a new node arrives, it is always necessary to compare all the nodes first, and then insert. 
All as long as the list does not delete the node, list will always increase, and search time will longer and longer, eventually leading to softlockup


Is there any solution to this problem?
Thanks for reading and looking forward to your reply.

Best wishes!

-----邮件原件-----
发件人: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
发送时间: 2017年12月13日 23:18
收件人: yangjihong <yangjihong1@huawei.com>; paul@paul-moore.com; eparis@parisplace.org; selinux@tycho.nsa.gov; Daniel J Walsh <dwalsh@redhat.com>; Lukas Vrabec <lvrabec@redhat.com>; Petr Lautrbach <plautrba@redhat.com>
抄送: linux-kernel@vger.kernel.org
主题: Re: [BUG]kernel softlockup due to sidtab_search_context run for long time because of too many sidtab context node

On Wed, 2017-12-13 at 09:25 +0000, yangjihong wrote:
> Hello,
> 
> I am doing stressing testing on 3.10 kernel(centos 7.4), to constantly 
> starting numbers of docker ontainers with selinux enabled, and after 
> about 2 days, the kernel softlockup panic:
>  <IRQ>  [<ffffffff810bb778>] sched_show_task+0xb8/0x120
>  [<ffffffff8116133f>] show_lock_info+0x20f/0x3a0
>  [<ffffffff811226aa>] watchdog_timer_fn+0x1da/0x2f0
>  [<ffffffff811224d0>] ? watchdog_enable_all_cpus.part.4+0x40/0x40
>  [<ffffffff810abf82>] __hrtimer_run_queues+0xd2/0x260
>  [<ffffffff810ac520>] hrtimer_interrupt+0xb0/0x1e0
>  [<ffffffff8104a477>] local_apic_timer_interrupt+0x37/0x60
>  [<ffffffff8166fd90>] smp_apic_timer_interrupt+0x50/0x140
>  [<ffffffff8166e1dd>] apic_timer_interrupt+0x6d/0x80
>  <EOI>  [<ffffffff812b4193>] ? sidtab_context_to_sid+0xb3/0x480
>  [<ffffffff812b41f0>] ? sidtab_context_to_sid+0x110/0x480
>  [<ffffffff812c0d15>] ? mls_setup_user_range+0x145/0x250
>  [<ffffffff812bd477>] security_get_user_sids+0x3f7/0x550
>  [<ffffffff812b1a8b>] sel_write_user+0x12b/0x210
>  [<ffffffff812b1960>] ? sel_write_member+0x200/0x200
>  [<ffffffff812b01d8>] selinux_transaction_write+0x48/0x80
>  [<ffffffff811f444d>] vfs_write+0xbd/0x1e0
>  [<ffffffff811f4eef>] SyS_write+0x7f/0xe0
>  [<ffffffff8166d433>] system_call_fastpath+0x16/0x1b
> 
> My opinion:
> when the docker container starts, it would mount overlay filesystem 
> with different selinux context, mount point such as:
> overlay on
> /var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc32
> 6cb07495ca08fc9ddb66/merged type overlay 
> (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c414,
> c873",lowerdir=/var/lib/docker/overlay2/l/Z4U7WY6ASNV5CFWLADPARHHWY7:
> /var/lib/docker/overlay2/l/V2S3HOKEFEOQLHBVAL5WLA3YLS:/var/lib/docker
> /overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdir=/var/lib/docker/overl
> ay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc326cb07495ca08fc9ddb66/
> diff,workdir=/var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f
> 6cb0f07b4bc326cb07495ca08fc9ddb66/work)
> shm on
> /var/lib/docker/containers/9fd65e177d2132011d7b422755793449c91327ca57
> 7b8f5d9d6a4adf218d4876/shm type tmpfs
> (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:svirt_san
> dbox_file_t:s0:c414,c873",size=65536k)
> overlay on
> /var/lib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cbca
> 14ff6d165b94353eefab/merged type overlay 
> (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c431,
> c651",lowerdir=/var/lib/docker/overlay2/l/3MQQXB4UCLFB7ANVRHPAVRCRSS:
> /var/lib/docker/overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdir=/var/l
> ib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cbca14ff6d
> 165b94353eefab/diff,workdir=/var/lib/docker/overlay2/38d1544d080145c7
> d76150530d0255991dfb7258cbca14ff6d165b94353eefab/work)
> shm on
> /var/lib/docker/containers/662e7f798fc08b09eae0f0f944537a4bcedc1dcf05
> a65866458523ffd4a71614/shm type tmpfs
> (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:svirt_san
> dbox_file_t:s0:c431,c651",size=65536k)
> 
> sidtab_search_context check the context whether is in the sidtab list, 
> If not found, a new node is generated and insert into the list, As the 
> number of containers is increasing,  context nodes are also more and 
> more, we tested the final number of nodes reached 300,000 +, 
> sidtab_context_to_sid runtime needs 100-200ms, which will lead to the 
> system softlockup.
> 
> Is this a selinux bug? When filesystem umount, why context node is not 
> deleted?  I cannot find the relevant function to delete the node in 
> sidtab.c
> 
> Thanks for reading and looking forward to your reply.

So, does docker just keep allocating a unique category set for every new container, never reusing them even if the container is destroyed? 
That would be a bug in docker IMHO.  Or are you creating an unbounded number of containers and never destroying the older ones?

On the selinux userspace side, we'd also like to eliminate the use of /sys/fs/selinux/user (sel_write_user -> security_get_user_sids) entirely, which is what triggered this for you.

We cannot currently delete a sidtab node because we have no way of knowing if there are any lingering references to the SID.  Fixing that would require reference-counted SIDs, which goes beyond just SELinux since SIDs/secids are returned by LSM hooks and cached in other kernel data structures.

sidtab_search_context() could no doubt be optimized for the negative case; there was an earlier optimization for the positive case by adding a cache to sidtab_context_to_sid() prior to calling it.  It's a reverse lookup in the sidtab.
