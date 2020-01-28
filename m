Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C5C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC124683
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 13:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HAhasMi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgA1Noc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:44:32 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:42853 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgA1Noc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 08:44:32 -0500
X-EEMSG-check-017: 74207058|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="74207058"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2020 13:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580219068; x=1611755068;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vB6IilCRAF6GntAWS1GUu2QfsgfVGmXIapM/6fK3Y/E=;
  b=HAhasMi1XQazsU9OgNyNcKvLq9G5IJmsFcRBhP+rYjV9dJK+zvx1kmtq
   ABXBshKQ5P+bollNV51X9tI93y/rNGSEBWxupmjMB7ZB3jAA7vF/qjtkS
   XhaFKtvrfsLkrPaaNc0CtFdEDwze4qN0eHvziWJck6BWEsV8OmvVCcKId
   enXn8ydHZMWBaJUi6Y2MTBNCiyCADAGdAWIm4i+24UFJ5aPqldjgtnJkh
   uzGjlmWld1lVBz41te/SZk6Q7TsxW86JzsAXeU9wS0rJBt/2mOCfQNGBB
   lXTWdvE4QNsyJ5UUHWh0vTIee4nZ9q/FX/HIw2Qpfzwgd3uq/MqnhMk+5
   A==;
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="38329237"
IronPort-PHdr: =?us-ascii?q?9a23=3AlA9ofRSYkO8IsljnImRmOfNaQNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YhWBt8tkgFKBZ4jH8fUM07OQ7/m8Hzdcqsvd+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrHZFdOtayGNnKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks93O?=
 =?us-ascii?q?o8DAHGxxQgEMwSv3TIotv1M6ISXvq0zKnO0D7Pa/xb1DP45IXOfB8hu/WMVq?=
 =?us-ascii?q?9uf8TXx0ckCgfJgkyepIHhOj+Y0PkGvWqG4Op6Te+hlnApqw9xrDasyMkjhI?=
 =?us-ascii?q?bGiYAJxV7L7ih53IQ4KMekREJnb9OpEp1dvDyaOYtsRcMiRnlltjsmyrIYoZ?=
 =?us-ascii?q?67fDYFyJI6zBDCbvyIaYyI4hb9W+eRPDx1g2lld6+khxup7UihyvHzVsmz0F?=
 =?us-ascii?q?pQqCpFicPDumoC1xzU9MiKU/1w9Vqv1zaI0gDc8OBEIUYsmKXBM54h2qUwlo?=
 =?us-ascii?q?IUsUTfBCP5hEL2jKqQe045+eao8/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCUm6G8uqmzrLj51f2QLBSg/0zlanWrY7VKNwApq68Hw9VyoEj6wujDzu+0N?=
 =?us-ascii?q?QXg30HLFVddRKblYfpIVDOIO3jDfulglSsljlrx/fdPrL/HprBNGTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzwsxE551IEL0BJfPzWkvpuNzZCB82LRC0zv76BNhy2Y4SQ2KCDr?=
 =?us-ascii?q?KDPK/MvlKE+PgjL/SUaI8Qojn9Kvwl5/D0jX8+nF8QZbKp0oYMaH2jAvRnI1?=
 =?us-ascii?q?mWYXrrgtsbF2cKpRAxQPbliF2FTz5ff2yyUL4k5jEnFIKmCp/ORpi3j7yc2C?=
 =?us-ascii?q?e2BYVWaXpbClCICHvocoKEW/AWaC2MOMNujjsEVb25QY87yR6urBP6y6ZgLu?=
 =?us-ascii?q?fM+C0Xq5zj1NZr5+DImhEy8jt0D8uZ026TVW17gmQIRzou1qBlvUN90kuD0b?=
 =?us-ascii?q?R/g/FAEtxT4vRJUhw8NZHG0+N1Fcv/WhjfcdiUSFapWMmmDSstQdI2xt8Ee1?=
 =?us-ascii?q?x9FMm6jhDfwyqqBKcYmKKTBJMu6KLc3mPxKt1ly3nczqkhjkImQtNLNWK8mq?=
 =?us-ascii?q?Fw6RLfB4nTk0WWj6yqb7gT3DbR9GefymqDpENYXxR2UaXDXXASfUTWrdP+5k?=
 =?us-ascii?q?PNS7+hF64rPRdGyc6HMqFKcMHmjU1aRPf/P9TTe2GxlHmuChaT2ryMa43qe2?=
 =?us-ascii?q?YG0SrBCEgEiQcT/XOHNQgjAyetuWXeDCZhFVj3eUPj7fF+qG+nTk8z1wyKa0?=
 =?us-ascii?q?xh17yo+h8anPCcSO0c3qgCuCg/rzV5B0i9393IBNqavQZhf7tTYck74FhZ0W?=
 =?us-ascii?q?LVrQt9PoavL6p6nF4Rbxx3v1/y1xVwEohAidIlrG4uzAp3Na2Y00hMdzCG0p?=
 =?us-ascii?q?DqPL3YNG3y8Aqoa67M1VHUyMyW9bsX6PQkt1XjuxmkFlE8/HVj0tlV1Wac55?=
 =?us-ascii?q?rRAQoMXpL+TFw3+wJ5p77EeCk94Z3b1Xl2PamzqD/C1MojBPE5xRa4Y9dfLK?=
 =?us-ascii?q?SEGRfpE8waBsmuK/Ylm1ytbh0aJuBe7bU7P96pd/udw6OrM+FgnDWpjWRD/o?=
 =?us-ascii?q?993ViM9y1hSu7QxJYJ2e2X3gyCVz3klleurtj3mZxYZTEVBme/0ijlBY9Kaa?=
 =?us-ascii?q?11YYYHDmajL9CrydplnZHgW2JU+VCtClwYxsOlZRifY0Lg0gBRyEgaomCrlC?=
 =?us-ascii?q?qjwjxvkzAor6mf0zbKw+TmahUHIHRHS3N6jVf0Ooi0l9caXFStbwczlRul4V?=
 =?us-ascii?q?z2yLRcpKR6fCHvRhJwdjXyZ0RlVbG9/u6aatNLwIshrCESVeO7e13cQbn49V?=
 =?us-ascii?q?9S0S7tEXV2yzc8eDWn/J7+mlgyj2eaN3B6p3fxY8x8xR7DotfbQK1/xD0DER?=
 =?us-ascii?q?JkhCHXC170BNyg+dGZht+Xqeylf36wXZ1UNy/wxMWPszXttj4iOgG2g/3mwo?=
 =?us-ascii?q?6vKgM9yyKukogyWA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D6AwAKOTBe/wHyM5BlEwEBCAEBAQkBEQUFAYF7gX2BG?=
 =?us-ascii?q?FQhEiqEFIkDhnoDBoE3iW+KJYckCQEBAQEBAQEBASsMAQGEQAKCSjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KYJ7AQUjBBE0CgMQCxgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/AYJWJQ+tD38zhUqDPoE4BoEOKow4eYEHgREnD4JdPoJkBBqBR4MQgl4Ej?=
 =?us-ascii?q?VyJWEaXXoJDgkyEdoVEiSsGG4JIiAoFkCUtjjOIZIMOkSwigVgrCAIYCCEPg?=
 =?us-ascii?q?ydQGA2SEIpxIwMwAo4uAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2020 13:44:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00SDhZXR092356;
        Tue, 28 Jan 2020 08:43:36 -0500
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Paul Moore <paul@paul-moore.com>, jeffv@google.com,
        omosnace@redhat.com
Cc:     Eric Paris <eparis@parisplace.org>, jannh@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, selinux@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
References: <000000000000143de7059d2ba3e5@google.com>
 <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov>
Date:   Tue, 28 Jan 2020 08:45:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/28/20 8:39 AM, Paul Moore wrote:
> On Tue, Jan 28, 2020 at 7:50 AM syzbot
> <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1432aebee00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
>> dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
>>
>> =====================================================
>> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
>> 5.5.0-syzkaller #0 Not tainted
>> -----------------------------------------------------
>> syz-executor305/10624 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
>> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
>> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
>>
>> and this task is already holding:
>> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
>> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
>> which would create a new lock dependency:
>>   (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
>>
>> but this new dependency connects a SOFTIRQ-irq-safe lock:
>>   (&(&nf_conntrack_locks[i])->rlock){+.-.}
>>
>> ... which became SOFTIRQ-irq-safe at:
>>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
>>    spin_lock include/linux/spinlock.h:338 [inline]
>>    nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> 
> ...
> 
>> to a SOFTIRQ-irq-unsafe lock:
>>   (&(&s->cache_lock)->rlock){+.+.}
>>
>> ... which became SOFTIRQ-irq-unsafe at:
>> ...
>>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
>>    spin_lock include/linux/spinlock.h:338 [inline]
>>    sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
>>    sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
>>    sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
>>    sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
>>    security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
>>    security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
>>    avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
>>    common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
>>    slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
>>    avc_audit security/selinux/include/avc.h:140 [inline]
>>    avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
>>    inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
>>    selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
>>    security_mmap_file+0xa4/0x1e0 security/security.c:1482
>>    vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
> 
> ...
> 
>> other info that might help us debug this:
>>
>>   Possible interrupt unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&(&s->cache_lock)->rlock);
>>                                 local_irq_disable();
>>                                 lock(&(&nf_conntrack_locks[i])->rlock);
>>                                 lock(&(&s->cache_lock)->rlock);
>>    <Interrupt>
>>      lock(&(&nf_conntrack_locks[i])->rlock);
>>
>>   *** DEADLOCK ***
>>
>> 4 locks held by syz-executor305/10624:
>>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
>>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
>>   #1: ffff8880836415d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
>>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
>>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
>>   #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344
> 
> I think this is going to be tricky to fix due to the differing
> contexts from which sidtab_sid2str_put() may be called.  We already
> have a check for !in_task() in sidtab_sid2str_put(), do we want to add
> a check for !in_serving_softirq() too?

No, we should just use spin_lock_irqsave/unlock_irqrestore() IMHO, but 
that then means we need to re-evaluate the performance gain of this change.


