Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o22NMabR003274
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 18:22:36 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o22NMvDA023163
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 23:22:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AABA1180C0
	for <selinux@tycho.nsa.gov>; Wed,  3 Mar 2010 10:18:39 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: strange policy loading problem
Date: Wed, 3 Mar 2010 10:18:37 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003031018.38030.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running a 2.6.32 system under KVM and it keeps OOMing when I try to run 
semodule.

# free
             total       used       free     shared    buffers     cached
Mem:        507532     475320      32212          0       4168      11148
-/+ buffers/cache:     460004      47528
Swap:       524280      19848     504432

The policy.24 file is just under 900K in size, the output of free is above, it 
doesn't seem particularly short of RAM.  The dmesg output is below.  Any 
suggestions for what I should investigate?

I could just give the VM a gig of RAM, but I run lots of real systems with 
less than 512M so I would like this to work.


[10750.523296] load_policy: page allocation failure. order:4, mode:0xc0d0
[10750.524503] Pid: 13383, comm: load_policy Not tainted 2.6.32-trunk-amd64 #1
[10750.525308] Call Trace:
[10750.525895]  [<ffffffff810b902e>] ? __alloc_pages_nodemask+0x55b/0x5cd
[10750.526681]  [<ffffffff8115b009>] ? hashtab_insert+0x6a/0xd8
[10750.527450]  [<ffffffff810b8037>] ? __get_free_pages+0x9/0x46
[10750.528250]  [<ffffffff810e5d99>] ? __kmalloc+0x3f/0x141
[10750.528974]  [<ffffffff8115beff>] ? avtab_alloc+0x4b/0x86
[10750.529701]  [<ffffffff8115c01a>] ? avtab_read+0x63/0xdd
[10750.530424]  [<ffffffff8115dd73>] ? policydb_read+0x542/0x11eb
[10750.531179]  [<ffffffff81047f86>] ? finish_task_switch+0x3a/0xa7
[10750.531949]  [<ffffffff81160c1d>] ? security_load_policy+0x108/0x3ae
[10750.539402]  [<ffffffff810c9147>] ? __do_fault+0x35d/0x398
[10750.540177]  [<ffffffff810cb0e6>] ? handle_mm_fault+0x368/0x74b
[10750.540933]  [<ffffffff8101148e>] ? common_interrupt+0xe/0x13
[10750.541679]  [<ffffffff81032845>] ? do_page_fault+0x266/0x282
[10750.542430]  [<ffffffff81189c09>] ? __up_read+0x13/0x8e
[10750.552058]  [<ffffffff812e6f25>] ? page_fault+0x25/0x30
[10750.552827]  [<ffffffff81158fb7>] ? sel_write_load+0xd1/0x62a
[10750.553585]  [<ffffffff811551cb>] ? selinux_file_permission+0x4e/0xa5
[10750.554370]  [<ffffffff810ec766>] ? vfs_write+0xa9/0x102
[10750.555089]  [<ffffffff810ec87b>] ? sys_write+0x45/0x6e
[10750.555824]  [<ffffffff81010b02>] ? system_call_fastpath+0x16/0x1b
[10750.556617] Mem-Info:
[10750.557197] Node 0 DMA per-cpu:
[10750.557943] CPU    0: hi:    0, btch:   1 usd:   0
[10750.558645] CPU    1: hi:    0, btch:   1 usd:   0
[10750.560047] Node 0 DMA32 per-cpu:
[10750.560862] CPU    0: hi:  186, btch:  31 usd:  15
[10750.561559] CPU    1: hi:  186, btch:  31 usd:   0
[10750.562270] active_anon:5278 inactive_anon:5362 isolated_anon:0
[10750.562272]  active_file:422 inactive_file:379 isolated_file:7
[10750.562273]  unevictable:0 dirty:0 writeback:0 unstable:0
[10750.562274]  free:1559 slab_reclaimable:1081 slab_unreclaimable:2356
[10750.562275]  mapped:630 shmem:0 pagetables:698 bounce:0
[10750.574884] Node 0 DMA free:2032kB min:84kB low:104kB high:124kB 
active_anon:580kB inactive_anon:636kB active_file:140kB inactive_file:88kB 
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15372kB 
mlocked:0kB dirty:0kB writeback:0kB mapped:152kB shmem:0kB 
slab_reclaimable:20kB slab_unreclaimable:32kB kernel_stack:0kB 
pagetables:20kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 
all_unreclaimable? no
[10750.579130] lowmem_reserve[]: 0 489 489 489
[10750.580510] Node 0 DMA32 free:4204kB min:2784kB low:3480kB high:4176kB 
active_anon:20532kB inactive_anon:20812kB active_file:1548kB 
inactive_file:1428kB unevictable:0kB isolated(anon):0kB isolated(file):28kB 
present:500896kB mlocked:0kB dirty:0kB writeback:0kB mapped:2368kB shmem:0kB 
slab_reclaimable:4304kB slab_unreclaimable:9448kB kernel_stack:744kB 
pagetables:2772kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 
all_unreclaimable? no
[10750.590720] lowmem_reserve[]: 0 0 0 0
[10750.592054] Node 0 DMA: 14*4kB 3*8kB 4*16kB 5*32kB 5*64kB 5*128kB 3*256kB 
0*512kB 0*1024kB 0*2048kB 0*4096kB = 2032kB
[10750.607390] Node 0 DMA32: 153*4kB 171*8kB 71*16kB 19*32kB 2*64kB 0*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3852kB
[10750.610527] 1234 total pagecache pages
[10750.611180] 351 pages in swap cache
[10750.611837] Swap cache stats: add 333408, delete 333057, find 104572/139359
[10750.612676] Free swap  = 494132kB
[10750.613309] Total swap = 524280kB
[10750.615973] 131056 pages RAM
[10750.623768] 4173 pages reserved
[10750.624423] 1279 pages shared
[10750.625045] 16433 pages non-shared
[10751.657380] load_policy: page allocation failure. order:4, mode:0xc0d0
[10751.658236] Pid: 13385, comm: load_policy Not tainted 2.6.32-trunk-amd64 #1
[10751.659078] Call Trace:
[10751.659700]  [<ffffffff810b902e>] ? __alloc_pages_nodemask+0x55b/0x5cd
[10751.660977]  [<ffffffff8115b009>] ? hashtab_insert+0x6a/0xd8
[10751.661216]  [<ffffffff810b8037>] ? __get_free_pages+0x9/0x46
[10751.661216]  [<ffffffff810e5d99>] ? __kmalloc+0x3f/0x141
[10751.661216]  [<ffffffff8115beff>] ? avtab_alloc+0x4b/0x86
[10751.661216]  [<ffffffff8115c01a>] ? avtab_read+0x63/0xdd
[10751.661216]  [<ffffffff8115dd73>] ? policydb_read+0x542/0x11eb
[10751.661216]  [<ffffffff8103ff44>] ? update_curr+0xa6/0x147
[10751.661216]  [<ffffffff81040685>] ? dequeue_entity+0xf/0x11f
[10751.661216]  [<ffffffff81047f86>] ? finish_task_switch+0x3a/0xa7
[10751.661216]  [<ffffffff81160c1d>] ? security_load_policy+0x108/0x3ae
[10751.661216]  [<ffffffff810c9147>] ? __do_fault+0x35d/0x398
[10751.681420]  [<ffffffff81041b52>] ? pick_next_task_fair+0xcd/0xd8
[10751.682395]  [<ffffffff810cb0e6>] ? handle_mm_fault+0x368/0x74b
[10751.683277]  [<ffffffff81032845>] ? do_page_fault+0x266/0x282
[10751.684052]  [<ffffffff81189c09>] ? __up_read+0x13/0x8e
[10751.684780]  [<ffffffff812e6f25>] ? page_fault+0x25/0x30
[10751.685404]  [<ffffffff81158fb7>] ? sel_write_load+0xd1/0x62a
[10751.685404]  [<ffffffff811551cb>] ? selinux_file_permission+0x4e/0xa5
[10751.685404]  [<ffffffff810ec766>] ? vfs_write+0xa9/0x102
[10751.685404]  [<ffffffff810ec87b>] ? sys_write+0x45/0x6e
[10751.685404]  [<ffffffff81010b02>] ? system_call_fastpath+0x16/0x1b
[10751.685404] Mem-Info:
[10751.685404] Node 0 DMA per-cpu:
[10751.685404] CPU    0: hi:    0, btch:   1 usd:   0
[10751.685404] CPU    1: hi:    0, btch:   1 usd:   0
[10751.685404] Node 0 DMA32 per-cpu:
[10751.685404] CPU    0: hi:  186, btch:  31 usd:   0
[10751.685404] CPU    1: hi:  186, btch:  31 usd:  54
[10751.685404] active_anon:5063 inactive_anon:5145 isolated_anon:0
[10751.685404]  active_file:469 inactive_file:349 isolated_file:32
[10751.685404]  unevictable:0 dirty:0 writeback:45 unstable:0
[10751.685404]  free:1947 slab_reclaimable:1082 slab_unreclaimable:2356
[10751.685404]  mapped:705 shmem:0 pagetables:702 bounce:0
[10751.712830] Node 0 DMA free:2072kB min:84kB low:104kB high:124kB 
active_anon:560kB inactive_anon:636kB active_file:140kB inactive_file:68kB 
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15372kB 
mlocked:0kB dirty:0kB writeback:28kB mapped:184kB shmem:0kB 
slab_reclaimable:20kB slab_unreclaimable:112kB kernel_stack:0kB 
pagetables:20kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 
all_unreclaimable? no
[10751.716817] lowmem_reserve[]: 0 489 489 489
[10751.716817] Node 0 DMA32 free:5660kB min:2784kB low:3480kB high:4176kB 
active_anon:19692kB inactive_anon:19944kB active_file:1736kB 
inactive_file:1328kB unevictable:0kB isolated(anon):0kB isolated(file):128kB 
present:500896kB mlocked:0kB dirty:0kB writeback:0kB mapped:2636kB shmem:0kB 
slab_reclaimable:4308kB slab_unreclaimable:9368kB kernel_stack:744kB 
pagetables:2788kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:151 
all_unreclaimable? no
[10751.716817] lowmem_reserve[]: 0 0 0 0
[10751.738813] Node 0 DMA: 21*4kB 6*8kB 3*16kB 5*32kB 5*64kB 5*128kB 3*256kB 
0*512kB 0*1024kB 0*2048kB 0*4096kB = 2068kB
[10751.742113] Node 0 DMA32: 515*4kB 165*8kB 79*16kB 24*32kB 3*64kB 0*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 5604kB
[10751.742286] 1203 total pagecache pages
[10751.742286] 361 pages in swap cache
[10751.742286] Swap cache stats: add 334087, delete 333726, find 104620/139446
[10751.742286] Free swap  = 492212kB
[10751.742286] Total swap = 524280kB
[10751.742286] 131056 pages RAM
[10751.742286] 4173 pages reserved
[10751.766383] 1486 pages shared
[10751.767026] 15857 pages non-shared


-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
