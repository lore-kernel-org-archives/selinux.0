To: Casey Schaufler <casey@schaufler-ca.com>,
 LSM <linux-security-module@vger.kernel.org>, SELinux
 <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
 <5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
 <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
Date: Tue, 15 May 2018 08:33:12 -0400
MIME-Version: 1.0
In-Reply-To: <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2018 05:31 PM, Casey Schaufler wrote:
> On 5/14/2018 1:07 PM, Stephen Smalley wrote:
>> On 05/14/2018 03:52 PM, Stephen Smalley wrote:
>>> On 05/10/2018 08:30 PM, Casey Schaufler wrote:
>>>> Subject: [PATCH 00/23] LSM: Full security module stacking
>>>>
>>>> Here it is, the whole nine yards, broken into mostly
>>>> review friendly pieces. I believe that it would make
>>>> a good deal of sense to take this in two bites, with
>>>> the infrastructure managed blobs going first and the
>>>> secid conversion coming later. I hope there will be some
>>>> debate around that.
>>>>
>>>> The blob management part is pretty clean by now. I
>>>> welcome serious review on that. The secid part is more
>>>> wobbly, but I am convinced that it's the right direction
>>>> if not perhaps always the best possible implementation.
>>>> AppArmor in in the process of a major overhaul, and that
>>>> slowed me down a bit as I had to do new work to convert
>>>> it to use the new mechanisms.
>>>>
>>>> I had experimented with secid "tokens" in the hope of
>>>> minimizing API changes. That doesn't work. Changing
>>>> the APIs to use a struct secids pointer in place of a
>>>> u32 is brutal to the diffstat, but reduces the amount
>>>> of active code that has to change, and really makes
>>>> data management easier.
>>>>
>>>> If there are two possible ways to do a thing you will
>>>> find them both in the networking code. AF_UNIX, netfilter,
>>>> SO_PEERSEC and netlabel each has its own clever ways
>>>> to manipulate security information. I think I nailed
>>>> them all, but I'm not betting more than a beer on it.
>>>>
>>>> There could be issues in the audit code, although nothing
>>>> jumped out immediately. The same goes for the integrity
>>>> subsystem. I haven't tried Infiniband or very many
>>>> filesystem types that don't com standard with Fedora or
>>>> Ubuntu.
>>>>
>>>> I have fixed everything I've found. If you find something
>>>> (please look!) let me know.
>>>>
>>>> Tested primarily on virtual machines.
>>>> 	Fedora 25-27 - SELinux, Smack and the two together
>>>> 	Ubuntu 17.04 - AppArmor and AppArmor + Smack
>>>>
>>>> The SELinux test suite completes successfully unless
>>>> you add in Smack, in which case it fails where you would
>>>> expect it to due to the different use models for netlabel.
>>>> Smack tests work as well. AppArmor was tested by booting
>>>> Ubuntu, but not beyond.
>>> Getting this during boot with CONFIG_KASAN=y and SELinux+Smack stacked:
>>>
>>> [   83.809008] ==================================================================
>>> [   83.809046] BUG: KASAN: use-after-free in string+0xab/0x180
>>> [   83.809051] Read of size 1 at addr ffff8803bb3ad508 by task systemd/1
>>>
>>> [   83.809062] CPU: 3 PID: 1 Comm: systemd Not tainted 4.17.0-rc3+ #41
>>> [   83.809066] Call Trace:
>>> [   83.809072]  dump_stack+0x9a/0xec
>>> [   83.809079]  print_address_description+0x65/0x22e
>>> [   83.809084]  ? string+0xab/0x180
>>> [   83.809087]  kasan_report.cold.6+0xac/0x2f4
>>> [   83.809095]  ? string+0xab/0x180
>>> [   83.809101]  ? widen_string+0x160/0x160
>>> [   83.809107]  ? __kasan_slab_free+0x125/0x170
>>> [   83.809110]  ? kfree+0xe5/0x2f0
>>> [   83.809114]  ? security_inode_getsecctx+0x20b/0x240
>>> [   83.809123]  ? vsnprintf+0x211/0x780
>>> [   83.809130]  ? pointer+0x560/0x560
>>> [   83.809137]  ? kasprintf+0x96/0xc0
>>> [   83.809141]  ? rcu_read_lock_sched_held+0x8f/0xa0
>>> [   83.809145]  ? __kmalloc_track_caller+0x2d7/0x330
>>> [   83.809152]  ? kvasprintf+0x8d/0x120
>>> [   83.809157]  ? bust_spinlocks+0x50/0x50
>>> [   83.809164]  ? mark_held_locks+0x8b/0xb0
>>> [   83.809173]  ? kasprintf+0x96/0xc0
>>> [   83.809177]  ? kvasprintf_const+0xb0/0xb0
>>> [   83.809184]  ? strlen+0x1f/0x40
>>> [   83.809194]  ? security_inode_getsecctx+0x101/0x240
>>> [   83.809200]  ? security_socket_getpeersec_dgram+0x90/0x90
>>> [   83.809204]  ? selinux_secctx_to_secid+0x20/0x20
>>> [   83.809209]  ? trace_hardirqs_on_caller+0x17f/0x260
>>> [   83.809215]  ? __lockdep_init_map+0x86/0x230
>>> [   83.809228]  ? kernfs_security_xattr_set+0x12f/0x1c0
>>> [   83.809233]  ? kernfs_iop_listxattr+0x90/0x90
>>> [   83.809244]  ? selinux_inode_setxattr+0x2e7/0x460
>>> [   83.809249]  ? xattr_resolve_name+0x107/0x180
>>> [   83.809256]  ? __vfs_setxattr+0xca/0x110
>>> [   83.809262]  ? xattr_resolve_name+0x180/0x180
>>> [   83.809270]  ? lock_acquire+0xca/0x1f0
>>> [   83.809277]  ? __vfs_setxattr_noperm+0x89/0x220
>>> [   83.809282]  ? security_inode_setxattr+0x79/0xc0
>>> [   83.809289]  ? vfs_setxattr+0x8d/0xb0
>>> [   83.809296]  ? setxattr+0x182/0x240
>>> [   83.809301]  ? vfs_setxattr+0xb0/0xb0
>>> [   83.809305]  ? kmem_cache_free+0x105/0x320
>>> [   83.809312]  ? filename_lookup.part.57+0x176/0x250
>>> [   83.809319]  ? filename_parentat.isra.55.part.56+0x250/0x250
>>> [   83.809323]  ? fs_reclaim_release.part.80+0x5/0x20
>>> [   83.809327]  ? match_held_lock+0x2e/0x240
>>> [   83.809334]  ? __lock_is_held+0x51/0xc0
>>> [   83.809346]  ? rcu_read_lock_sched_held+0x8f/0xa0
>>> [   83.809349]  ? rcu_sync_lockdep_assert+0x43/0x70
>>> [   83.809353]  ? __sb_start_write+0x171/0x1e0
>>> [   83.809356]  ? mnt_want_write+0x2d/0x70
>>> [   83.809360]  ? __mnt_want_write+0x98/0xd0
>>> [   83.809369]  ? path_setxattr+0x11b/0x130
>>> [   83.809376]  ? setxattr+0x240/0x240
>>> [   83.809381]  ? mark_held_locks+0x23/0xb0
>>> [   83.809386]  ? retint_user+0x18/0x18
>>> [   83.809389]  ? page_fault+0x8/0x30
>>> [   83.809397]  ? __x64_sys_lsetxattr+0x65/0x70
>>> [   83.809404]  ? do_syscall_64+0x78/0x270
>>> [   83.809409]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>
>>> [   83.809429] Allocated by task 1:
>>> [   83.809434]  kasan_kmalloc+0xbf/0xe0
>>> [   83.809437]  __kmalloc+0x155/0x350
>>> [   83.809441]  context_struct_to_string+0x240/0x360
>>> [   83.809444]  security_sid_to_context_core.isra.14+0x110/0x160
>>>
>>> [   83.809450] Freed by task 1:
>>> [   83.809455]  __kasan_slab_free+0x125/0x170
>>> [   83.809458]  kfree+0xe5/0x2f0
>>> [   83.809461]  security_inode_getsecctx+0x20b/0x240
>>>
>>> [   83.809467] The buggy address belongs to the object at ffff8803bb3ad508
>>>                 which belongs to the cache kmalloc-32 of size 32
>>> [   83.809473] The buggy address is located 0 bytes inside of
>>>                 32-byte region [ffff8803bb3ad508, ffff8803bb3ad528)
>>> [   83.809478] The buggy address belongs to the page:
>>> [   83.809483] page:ffffea000eeceb00 count:1 mapcount:0 mapping:0000000000000000 index:0xffff8803bb3acc08 compound_mapcount: 0
>>> [   83.809492] flags: 0x17ffe000008100(slab|head)
>>> [   83.809498] raw: 0017ffe000008100 0000000000000000 ffff8803bb3acc08 000000010015000e
>>> [   83.809504] raw: ffffea000e76f920 ffff8803be803b00 ffff8803be80c6c0 0000000000000000
>>> [   83.809508] page dumped because: kasan: bad access detected
>>>
>>> [   83.809515] Memory state around the buggy address:
>>> [   83.809585]  ffff8803bb3ad400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [   83.809589]  ffff8803bb3ad480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [   83.809594] >ffff8803bb3ad500: fc fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
>>> [   83.809598]                       ^
>>> [   83.809603]  ffff8803bb3ad580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [   83.809607]  ffff8803bb3ad600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [   83.809611] ==================================================================
> 
> I haven't seen that one. What distro/version/architecture are you using?

Fedora 28 / x86_64

>>>
>>> Also, networking seems to be dead:
>>> [   94.522829] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  125.507242] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  150.543984] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  156.194458] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  157.371219] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  175.536981] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  183.049992] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  183.185015] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  200.545209] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  225.555808] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  232.142729] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  233.085649] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  250.571034] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  275.592124] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  300.606852] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  325.616553] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  328.875799] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  350.645427] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  375.654276] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  400.668521] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  425.685705] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  450.709773] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  475.725636] Failed to initialize the IGMP autojoin socket (err -13)
>>> [  500.736369] Failed to initialize the IGMP autojoin socket (err -13)
>>>
>>> And I can't bring up the interface.
> 
> What you're seeing is SELinux and Smack being unable to agree on the
> labeling for IP sockets. The socket() call is failing because
> SELinux and Smack want different CIPSO on the packets from the sockets.
> Paul and I discussed this at length, and in the end agreed that this is
> safe, if "inconvenient", behavior. I believe that a netlabel configuration
> that is useful is possible, but I don't have one to suggest just yet.
> 
> On Fedora25 and 27 the services using IP sockets eventually time out,
> after which I can successfully log on. Without being able to create sockets,
> it's tough to start the interfaces.

Hmm...SELinux shouldn't be doing anything with CIPSO by default (i.e. without additional config),
so why is there a conflict just when booting without any SELinux NetLabel configuration at all?

> 
>> NB Disabling Smack was sufficient to resolve both errors.  But CONFIG_SECURITY_STACKING was enabled in both cases,
>> as was CONFIG_SECURITY_SELINUX_STACKED.
> 
> I'll look into the stack trace. Thanks for reporting it.
