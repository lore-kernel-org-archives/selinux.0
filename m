From: yangjihong <yangjihong1@huawei.com>
To: "paul@paul-moore.com" <paul@paul-moore.com>, "sds@tycho.nsa.gov"
 <sds@tycho.nsa.gov>, "eparis@parisplace.org" <eparis@parisplace.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 13 Dec 2017 09:25:07 +0000
Message-ID: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D1F3@DGGEMM506-MBS.china.huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [BUG]kernel softlockup due to sidtab_search_context run for
 long time because of too many sidtab context node
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello, 

I am doing stressing testing on 3.10 kernel(centos 7.4), to constantly starting numbers of docker ontainers with selinux enabled, and after about 2 days, the kernel softlockup panic:
 <IRQ>  [<ffffffff810bb778>] sched_show_task+0xb8/0x120
 [<ffffffff8116133f>] show_lock_info+0x20f/0x3a0
 [<ffffffff811226aa>] watchdog_timer_fn+0x1da/0x2f0
 [<ffffffff811224d0>] ? watchdog_enable_all_cpus.part.4+0x40/0x40
 [<ffffffff810abf82>] __hrtimer_run_queues+0xd2/0x260
 [<ffffffff810ac520>] hrtimer_interrupt+0xb0/0x1e0
 [<ffffffff8104a477>] local_apic_timer_interrupt+0x37/0x60
 [<ffffffff8166fd90>] smp_apic_timer_interrupt+0x50/0x140
 [<ffffffff8166e1dd>] apic_timer_interrupt+0x6d/0x80
 <EOI>  [<ffffffff812b4193>] ? sidtab_context_to_sid+0xb3/0x480
 [<ffffffff812b41f0>] ? sidtab_context_to_sid+0x110/0x480
 [<ffffffff812c0d15>] ? mls_setup_user_range+0x145/0x250
 [<ffffffff812bd477>] security_get_user_sids+0x3f7/0x550
 [<ffffffff812b1a8b>] sel_write_user+0x12b/0x210
 [<ffffffff812b1960>] ? sel_write_member+0x200/0x200
 [<ffffffff812b01d8>] selinux_transaction_write+0x48/0x80
 [<ffffffff811f444d>] vfs_write+0xbd/0x1e0
 [<ffffffff811f4eef>] SyS_write+0x7f/0xe0
 [<ffffffff8166d433>] system_call_fastpath+0x16/0x1b

My opinion:
when the docker container starts, it would mount overlay filesystem with different selinux context, mount point such as: 
overlay on /var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc326cb07495ca08fc9ddb66/merged type overlay (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c414,c873",lowerdir=/var/lib/docker/overlay2/l/Z4U7WY6ASNV5CFWLADPARHHWY7:/var/lib/docker/overlay2/l/V2S3HOKEFEOQLHBVAL5WLA3YLS:/var/lib/docker/overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdir=/var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc326cb07495ca08fc9ddb66/diff,workdir=/var/lib/docker/overlay2/be3ef517730d92fc4530e0e952eae4f6cb0f07b4bc326cb07495ca08fc9ddb66/work)
shm on /var/lib/docker/containers/9fd65e177d2132011d7b422755793449c91327ca577b8f5d9d6a4adf218d4876/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c414,c873",size=65536k)
overlay on /var/lib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cbca14ff6d165b94353eefab/merged type overlay (rw,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c431,c651",lowerdir=/var/lib/docker/overlay2/l/3MQQXB4UCLFB7ANVRHPAVRCRSS:/var/lib/docker/overlay2/l/46YGYO474KLOULZGDSZDW2JPRI,upperdir=/var/lib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cbca14ff6d165b94353eefab/diff,workdir=/var/lib/docker/overlay2/38d1544d080145c7d76150530d0255991dfb7258cbca14ff6d165b94353eefab/work)
shm on /var/lib/docker/containers/662e7f798fc08b09eae0f0f944537a4bcedc1dcf05a65866458523ffd4a71614/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,context="system_u:object_r:svirt_sandbox_file_t:s0:c431,c651",size=65536k)

sidtab_search_context check the context whether is in the sidtab list, If not found, a new node is generated and insert into the list, As the number of containers is increasing,  context nodes are also more and more, we tested the final number of nodes reached 300,000 +, sidtab_context_to_sid runtime needs 100-200ms, which will lead to the system softlockup.

Is this a selinux bug? When filesystem umount, why context node is not deleted?  I cannot find the relevant function to delete the node in sidtab.c

Thanks for reading and looking forward to your reply.
