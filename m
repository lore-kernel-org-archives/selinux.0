Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86388CA9EC1
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C67D214E0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ddLxUV4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJ1RqN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:46:13 -0400
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:23438 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbfJ1RqM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 13:46:12 -0400
X-EEMSG-check-017: 42407220|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="42407220"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2019 17:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572284764; x=1603820764;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6nK36RWsYS80B3AkuPfyRSJg/73fGdzYaOGZzmj+tPE=;
  b=ddLxUV4qWT41Ss8n2MtGubKWsNMOfVjn7tloB09eCc71KZyXtm1sstDd
   F2ORTFp5lm4RxwqwjfEiH3USp///UnjJeZdlDIBX1IEFoiUtySJQpg9Mq
   VaKXp+Kf4WD2Kk7bkJ+QIblZK7ye8rSwVUjRoo2FgArxgX2vaHlY1w2jc
   XyraUmvyxbBmvETJc1HW83F8fLbc26ymL8djP4ZQy6Za3tVWIlB0N+wdV
   aETcbkO+DRpIkKUtbQYNzjNKef4PAcvhd18NLwwZU730WJLZgV+zn6AzB
   7qsjPbNPe7TBLk2KaeI8OqUFuiY2s5bJ+Gnp5kv8UN1MM5N5+6XytxElq
   w==;
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="34769689"
IronPort-PHdr: =?us-ascii?q?9a23=3A7kb+rBRZePeqQs2eeTnVgrKv09psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBKOt8tkgFKBZ4jH8fUM07OQ7/m7Hz1Rqs/Z7DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrM0bjI9tJqos1h?=
 =?us-ascii?q?fErWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg0zb0GvI?=
 =?us-ascii?q?S0fCkMyJk/3R7QdeGIc4iS7RL/TuqePTB4hHdjdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0hsy+Afg3Mg?=
 =?us-ascii?q?gJX2SB/+SzyKbj8lHjTLVPj/02lrHVsJHcJcsFuq60GxJZ34ks5hqlDzqqzc?=
 =?us-ascii?q?4UkWcIIV5bYh6LkpDlO1TUL/D5Cfe/jU6skDBux/3eJb3uH47NI2PfkLbhYb?=
 =?us-ascii?q?l960lcxBA1zdBE/Z1YEL4BIPXtWkPprtzXEgc5MxCow+bgENh90YYeWWWUAq?=
 =?us-ascii?q?+fKqzdrUGH6/k1I+aSeYAVuCzyK+Q/6/Hyin85nEcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2CYXXyhtcBEGEKvhcxTeHxll2CXiBcZ2yoU6I/+D47EoSmApnHRoy3h7yBxi?=
 =?us-ascii?q?i7FIVMZm9aElCMDWvod4KcVvcUci2SP8thnyccVbe7Vo8h0QiitAr9y7pgNO?=
 =?us-ascii?q?rb5DcUuo7k1Nhw/+fTjw099SRoD8SB1GGAV2R0nngWSD812KBwv1B9xU2Y3K?=
 =?us-ascii?q?hinfNXCNxT6OlVUgsgKZHcyOl6WJjOXVfmeNuTRVTuZ9K9Bzg6Q9F5l9gLZF?=
 =?us-ascii?q?17Et6vpgrO0yqjH/kekLndQNQv/6bd2WXhD9hyxmyA16Q7iVQiBMxVOinuvq?=
 =?us-ascii?q?di80D2AInTng3Nj6+3cYwE1TPJsWKEynCD+kpfVVgjf7/CWCUkekbOrdn/rn?=
 =?us-ascii?q?jHRruqBKVvZhBN0uaeO6BKbZvvllwAS/D9boeNK1mtknu9UE7bjoiHa5DnLi?=
 =?us-ascii?q?BEh3TQ?=
X-IPAS-Result: =?us-ascii?q?A2BhAABwKLdd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgXuBbwUsbFUyKoQoj1oGgRElf4hkj0qBZwkBAQEBAQEBA?=
 =?us-ascii?q?QErCQECAQGEQAKDSiQ4EwIMAQEBBAEBAQEBBQMBAWyFNwyCOykBgmwBAQEBA?=
 =?us-ascii?q?gEaAQgEEUEQCw4KAgImAgJXBgEMBgIBAYJTDB4XCgGCUgUgD7ALdX8zhU6DN?=
 =?us-ascii?q?oFCBoEOKIgcg3MYeIEHgREnDIIqNT6CYgQYgS8YgxCCXgSMehWIRmGBNJV+g?=
 =?us-ascii?q?i6CM4RdjhgGG4I8jAeLF44/iCqTLyKBWCsIAhgIIQ87gmxQEBRXgjsXg1CKb?=
 =?us-ascii?q?yUDMAGBBAEBjRArghIBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Oct 2019 17:45:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9SHjvkW018197;
        Mon, 28 Oct 2019 13:45:57 -0400
Subject: Re: [PATCH] selinux: cache the SID -> context string translation
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Michal Sekletar <msekleta@redhat.com>
References: <20191025145535.18474-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <28a70500-5154-3fc7-b4f5-fa4feac7245b@tycho.nsa.gov>
Date:   Mon, 28 Oct 2019 13:45:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025145535.18474-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/25/19 10:55 AM, Ondrej Mosnacek wrote:
> Translating a context struct to string can be quite slow, especially if
> the context has a lot of category bits set. This can cause quite
> noticeable performance impact in situations where the translation needs
> to be done repeatedly. A common example is a UNIX datagram socket with
> the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> when receiving log messages via datagram socket. This scenario can be
> reproduced with:
> 
>      cat /dev/urandom | base64 | logger &
>      timeout 30s perf record -p $(pidof systemd-journald) -a -g
>      kill %1
>      perf report -g none --pretty raw | grep security_secid_to_secctx
> 
> Before the caching introduced by this patch, computing the context
> string (security_secid_to_secctx() function) takes up ~65% of
> systemd-journald's CPU time (assuming a context with 1024 categories
> set and Fedora x86_64 release kernel configs). After this patch
> (assuming near-perfect cache hit ratio) this overhead is reduced to just
> ~2%.
> 
> This patch addresses the issue by caching a certain number (compile-time
> configurable) of recently used context strings to speed up repeated
> translations of the same context, while using only a small amount of
> memory.
> 
> The cache is integrated into the existing sidtab table by adding a field
> to each entry, which when not NULL contains an RCU-protected pointer to
> a cache entry containing the cached string. The cache entries are kept
> in a linked list sorted according to how recently they were used. On a
> cache miss when the cache is full, the least recently used entry is
> removed to make space for the new entry.
> 
> The patch migrates security_sid_to_context_core() to use the cache (also
> a few other functions where it was possible without too much fuss, but
> these mostly use the translation for logging in case of error, which is
> rare).

Running selinux-testsuite with lock debugging enabled,

<4>[  237.722577]
<4>[  237.722581] ================================
<4>[  237.722582] WARNING: inconsistent lock state
<4>[  237.722585] 5.4.0-rc1+ #45 Not tainted
<4>[  237.722586] --------------------------------
<4>[  237.722588] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
<4>[  237.722590] client/4460 [HC0[0]:SC1[1]:HE1:SE0] takes:
<4>[  237.722592] ffff888703331198 (&(&s->cache_lock)->rlock){+.?.}, at: 
sidtab_sid2str_put.part.0+0x35/0x2f0
<4>[  237.722599] {SOFTIRQ-ON-W} state was registered at:
<4>[  237.722603]   lock_acquire+0xe5/0x210
<4>[  237.722606]   _raw_spin_lock+0x2c/0x40
<4>[  237.722608]   sidtab_sid2str_put.part.0+0x35/0x2f0
<4>[  237.722611]   sidtab_entry_to_string+0x86/0xa0
<4>[  237.722613]   security_sid_to_context_core.isra.0+0x147/0x190
<4>[  237.722615]   security_sid_to_context+0x23/0x30
<4>[  237.722618]   selinux_getprocattr+0x1f5/0x3f0
<4>[  237.722621]   proc_pid_attr_read+0xdf/0x170
<4>[  237.722623]   vfs_read+0xf3/0x1e0
<4>[  237.722625]   ksys_read+0xc3/0x160
<4>[  237.722628]   do_syscall_64+0x74/0xd0
<4>[  237.722630]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
<4>[  237.722632] irq event stamp: 10362
<4>[  237.722635] hardirqs last  enabled at (10362): 
[<ffffffff9f10badb>] _raw_write_unlock_irqrestore+0x4b/0x60
<4>[  237.722638] hardirqs last disabled at (10361): 
[<ffffffff9f10bd41>] _raw_write_lock_irqsave+0x21/0x54
<4>[  237.722641] softirqs last  enabled at (10310): 
[<ffffffff9eee6ea9>] ip_finish_output2+0x3f9/0x1070
<4>[  237.722644] softirqs last disabled at (10311): 
[<ffffffff9f20107a>] do_softirq_own_stack+0x2a/0x40
<4>[  237.722645]
<4>[  237.722645] other info that might help us debug this:
<4>[  237.722647]  Possible unsafe locking scenario:
<4>[  237.722647]
<4>[  237.722648]        CPU0
<4>[  237.722650]        ----
<4>[  237.722651]   lock(&(&s->cache_lock)->rlock);
<4>[  237.722654]   <Interrupt>
<4>[  237.722657]     lock(&(&s->cache_lock)->rlock);
<4>[  237.722660]
<4>[  237.722660]  *** DEADLOCK ***
<4>[  237.722660]
<4>[  237.722662] 5 locks held by client/4460:
<4>[  237.722664]  #0: ffff88870a0a6650 (sk_lock-AF_INET){+.+.}, at: 
inet_stream_connect+0x30/0x70
<4>[  237.722686]  #1: ffffffffa011e8e0 (rcu_read_lock){....}, at: 
__ip_queue_xmit+0x5/0x9e0
<4>[  237.722690]  #2: ffffffffa011e8e0 (rcu_read_lock){....}, at: 
process_backlog+0x8d/0x320
<4>[  237.722695]  #3: ffffffffa011e8e0 (rcu_read_lock){....}, at: 
ip_local_deliver_finish+0x65/0x190
<4>[  237.722699]  #4: ffffffffa2023128 
(&selinux_ss.policy_rwlock){.+.?}, at: 
security_sid_to_context_core.isra.0+0xde/0x190
<4>[  237.722703]
<4>[  237.722703] stack backtrace:
<4>[  237.722707] CPU: 1 PID: 4460 Comm: client Not tainted 5.4.0-rc1+ #45
<4>[  237.722708] Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS 
1.8.3 03/23/2018
<4>[  237.722710] Call Trace:
<4>[  237.722712]  <IRQ>
<4>[  237.722716]  dump_stack+0x9a/0xf0
<4>[  237.722719]  mark_lock+0x7d9/0x9c0
<4>[  237.722722]  ? check_usage_backwards+0x230/0x230
<4>[  237.722725]  __lock_acquire+0xb5b/0x2600
<4>[  237.722730]  ? create_object+0x387/0x560
<4>[  237.722733]  ? lockdep_hardirqs_on+0x260/0x260
<4>[  237.722736]  ? mark_lock+0xac/0x9c0
<4>[  237.722738]  ? match_held_lock+0x2e/0x240
<4>[  237.722741]  ? match_held_lock+0x1b/0x240
<4>[  237.722744]  lock_acquire+0xe5/0x210
<4>[  237.722747]  ? sidtab_sid2str_put.part.0+0x35/0x2f0
<4>[  237.722751]  _raw_spin_lock+0x2c/0x40
<4>[  237.722753]  ? sidtab_sid2str_put.part.0+0x35/0x2f0
<4>[  237.722756]  sidtab_sid2str_put.part.0+0x35/0x2f0
<4>[  237.722760]  sidtab_sid2str_get+0x161/0x237
<4>[  237.722763]  sidtab_entry_to_string+0x31/0xa0
<4>[  237.722766]  security_sid_to_context_core.isra.0+0x147/0x190
<4>[  237.722770]  ? avc_audit_pre_callback+0x120/0x120
<4>[  237.722772]  security_sid_to_context+0x23/0x30
<4>[  237.722774]  avc_audit_post_callback+0xb5/0x360
<4>[  237.722777]  ? avc_audit_pre_callback+0x120/0x120
<4>[  237.722782]  ? avc_audit_pre_callback+0x120/0x120
<4>[  237.722784]  common_lsm_audit+0x22d/0xd10
<4>[  237.722787]  ? mark_lock+0xac/0x9c0
<4>[  237.722790]  ? ipv6_skb_to_auditdata+0x380/0x380
<4>[  237.722793]  ? __lock_acquire+0x5e0/0x2600
<4>[  237.722797]  ? match_held_lock+0x1b/0x240
<4>[  237.722800]  slow_avc_audit+0x14a/0x1c0
<4>[  237.722803]  ? avc_get_hash_stats+0x1b0/0x1b0
<4>[  237.722806]  ? find_held_lock+0x85/0xa0
<4>[  237.722808]  ? avc_has_perm+0x1ae/0x370
<4>[  237.722812]  ? lockdep_hardirqs_on+0x182/0x260
<4>[  237.722815]  ? avc_denied+0xd4/0xf0
<4>[  237.722818]  avc_has_perm+0x316/0x370
<4>[  237.722821]  ? avc_has_perm_noaudit+0x300/0x300
<4>[  237.722824]  ? sel_netnode_sid+0xbc/0x500
<4>[  237.722829]  selinux_socket_sock_rcv_skb+0x301/0x370
<4>[  237.722832]  ? selinux_sock_rcv_skb_compat+0x1f0/0x1f0
<4>[  237.722836]  ? mark_lock+0xac/0x9c0
<4>[  237.722839]  ? inet_ehashfn+0x80/0x170
<4>[  237.722842]  ? inet_ehash_locks_alloc+0x120/0x120
<4>[  237.722846]  security_sock_rcv_skb+0x45/0x60
<4>[  237.722849]  sk_filter_trim_cap+0x9b/0x500
<4>[  237.722852]  ? tcp_parse_md5sig_option+0x65/0x90
<4>[  237.722855]  ? bpf_get_listener_sock+0x70/0x70
<4>[  237.722858]  ? tcp_v4_reqsk_send_ack+0x1a0/0x1a0
<4>[  237.722862]  tcp_v4_rcv+0x1313/0x15f0
<4>[  237.722867]  ? tcp_v4_early_demux+0x2e0/0x2e0
<4>[  237.722886]  ? rcu_read_lock_held+0xa1/0xb0
<4>[  237.722889]  ? rcu_read_lock_sched_held+0xd0/0xd0
<4>[  237.722892]  ? lock_acquire+0xe5/0x210
<4>[  237.722895]  ip_protocol_deliver_rcu+0x3e/0x360
<4>[  237.722899]  ip_local_deliver_finish+0xec/0x190
<4>[  237.722902]  ip_local_deliver+0x252/0x300
<4>[  237.722905]  ? ip_local_deliver_finish+0x190/0x190
<4>[  237.722908]  ? ip_protocol_deliver_rcu+0x360/0x360
<4>[  237.722912]  ip_rcv+0x1fe/0x2a0
<4>[  237.722915]  ? ip_local_deliver+0x300/0x300
<4>[  237.722919]  ? ip_rcv_finish_core.isra.0+0x870/0x870
<4>[  237.722922]  ? lockdep_hardirqs_on+0x260/0x260
<4>[  237.722925]  ? ip_local_deliver+0x300/0x300
<4>[  237.722928]  __netif_receive_skb_one_core+0x109/0x120
<4>[  237.722931]  ? __netif_receive_skb_core+0x16f0/0x16f0
<4>[  237.722933]  ? lock_acquire+0xe5/0x210
<4>[  237.722936]  ? process_backlog+0x8d/0x320
<4>[  237.722940]  process_backlog+0x126/0x320
<4>[  237.722943]  net_rx_action+0x220/0x670
<4>[  237.722947]  ? napi_busy_loop+0x520/0x520
<4>[  237.722950]  ? rcu_read_lock_bh_held+0xb0/0xb0
<4>[  237.722953]  ? mark_held_locks+0x44/0x90
<4>[  237.722956]  __do_softirq+0x130/0x5c1
<4>[  237.722961]  do_softirq_own_stack+0x2a/0x40
<4>[  237.722963]  </IRQ>
<4>[  237.722965]  ? ip_finish_output2+0x3f9/0x1070
<4>[  237.722968]  do_softirq.part.0+0x60/0x70
<4>[  237.722971]  __local_bh_enable_ip+0x101/0x110
<4>[  237.722974]  ip_finish_output2+0x422/0x1070
<4>[  237.722978]  ? ip_frag_next+0x330/0x330
<4>[  237.722981]  ? ipv4_mtu+0xcf/0x150
<4>[  237.722985]  ? ip_output+0x119/0x340
<4>[  237.722987]  ip_output+0x119/0x340
<4>[  237.722991]  ? ip_mc_output+0x7f0/0x7f0
<4>[  237.722994]  ? __ip_finish_output+0x480/0x480
<4>[  237.722998]  __ip_queue_xmit+0x349/0x9e0
<4>[  237.723002]  ? tcp_options_write+0xce/0x360
<4>[  237.723005]  __tcp_transmit_skb+0xaca/0x1470
<4>[  237.723010]  ? __tcp_select_window+0x350/0x350
<4>[  237.723013]  ? rcu_read_lock_sched_held+0xd0/0xd0
<4>[  237.723016]  ? rb_insert_color+0x26b/0x3e0
<4>[  237.723020]  tcp_connect+0x1473/0x1a00
<4>[  237.723025]  ? __tcp_transmit_skb+0x1470/0x1470
<4>[  237.723027]  ? siphash_1u64+0x7/0x210
<4>[  237.723031]  ? secure_tcpv6_seq+0x1a0/0x1a0
<4>[  237.723034]  tcp_v4_connect+0x88c/0xac0
<4>[  237.723039]  ? tcp_v4_parse_md5_keys+0x180/0x180
<4>[  237.723043]  __inet_stream_connect+0x1ba/0x620
<4>[  237.723047]  ? ipv4_mib_init_net+0x2b0/0x2b0
<4>[  237.723050]  ? lock_acquire+0xe5/0x210
<4>[  237.723053]  ? __inet_stream_connect+0x620/0x620
<4>[  237.723055]  ? mark_held_locks+0x65/0x90
<4>[  237.723058]  ? __local_bh_enable_ip+0x9d/0x110
<4>[  237.723061]  ? __inet_stream_connect+0x620/0x620
<4>[  237.723064]  inet_stream_connect+0x44/0x70
<4>[  237.723067]  __sys_connect+0x16f/0x1b0
<4>[  237.723070]  ? __ia32_sys_accept+0x50/0x50
<4>[  237.723074]  ? ktime_get_coarse_real_ts64+0xb1/0xf0
<4>[  237.723077]  ? syscall_trace_enter+0x235/0x5f0
<4>[  237.723081]  ? audit_filter_syscall.part.0.constprop.0+0x2c0/0x2c0
<4>[  237.723084]  ? rcu_read_lock_sched_held+0xd0/0xd0
<4>[  237.723087]  ? exit_to_usermode_loop+0x120/0x120
<4>[  237.723089]  ? unroll_tree_refs+0x166/0x1c0
<4>[  237.723112]  ? kfree+0x2e6/0x350
<4>[  237.723114]  ? mark_held_locks+0x24/0x90
<4>[  237.723117]  ? trace_hardirqs_on_thunk+0x1a/0x20
<4>[  237.723121]  __x64_sys_connect+0x3e/0x50
<4>[  237.723124]  do_syscall_64+0x74/0xd0
<4>[  237.723127]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
<4>[  237.723130] RIP: 0033:0x7f82c00a55b8
<4>[  237.723133] Code: 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 
00 90 f3 0f 1e fa 48 8d 05 65 80 0c 00 8b 00 85 c0 75 17 b8 2a 00 00 00 
0f 05 <48> 3d 00 f0 ff ff 77 50 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
<4>[  237.723135] RSP: 002b:00007ffefad9fcb8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002a
<4>[  237.723138] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f82c00a55b8
<4>[  237.723139] RDX: 0000000000000010 RSI: 000000000216a2b0 RDI: 
0000000000000003
<4>[  237.723141] RBP: 00007ffefad9fe50 R08: 0000000000000010 R09: 
0000000000000000
<4>[  237.723143] R10: 00000000004005a0 R11: 0000000000000246 R12: 
0000000000401130
<4>[  237.723145] R13: 00007ffefad9ff30 R14: 0000000000000000 R15: 
0000000000000000


> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> Cc: Michal Sekletar <msekleta@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/Kconfig       |  11 +++
>   security/selinux/ss/services.c | 138 +++++++++++++++-----------
>   security/selinux/ss/sidtab.c   | 170 +++++++++++++++++++++++++++------
>   security/selinux/ss/sidtab.h   |  58 +++++++++--
>   4 files changed, 285 insertions(+), 92 deletions(-)
> 
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 5711689deb6a..35fe8878cf1c 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -85,3 +85,14 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>   	  via /selinux/checkreqprot if authorized by policy.
>   
>   	  If you are unsure how to answer this question, answer 0.
> +
> +config SECURITY_SELINUX_SID2STR_CACHE_SIZE
> +	int "NSA SELinux SID to context string translation cache size"
> +	depends on SECURITY_SELINUX
> +	default 256
> +	help
> +	  This option defines the size of the internal SID -> context string
> +	  cache, which improves the performance of context to string
> +	  conversion.  Setting this option to 0 disables the cache completely.
> +
> +	  If unsure, keep the default value.
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3a29e7c24ba9..b6dda5261166 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -91,6 +91,12 @@ static int context_struct_to_string(struct policydb *policydb,
>   				    char **scontext,
>   				    u32 *scontext_len);
>   
> +static int sidtab_entry_to_string(struct policydb *policydb,
> +				  struct sidtab *sidtab,
> +				  struct sidtab_entry *entry,
> +				  char **scontext,
> +				  u32 *scontext_len);
> +
>   static void context_struct_compute_av(struct policydb *policydb,
>   				      struct context *scontext,
>   				      struct context *tcontext,
> @@ -716,20 +722,21 @@ static void context_struct_compute_av(struct policydb *policydb,
>   }
>   
>   static int security_validtrans_handle_fail(struct selinux_state *state,
> -					   struct context *ocontext,
> -					   struct context *ncontext,
> -					   struct context *tcontext,
> +					   struct sidtab_entry *oentry,
> +					   struct sidtab_entry *nentry,
> +					   struct sidtab_entry *tentry,
>   					   u16 tclass)
>   {
>   	struct policydb *p = &state->ss->policydb;
> +	struct sidtab *sidtab = state->ss->sidtab;
>   	char *o = NULL, *n = NULL, *t = NULL;
>   	u32 olen, nlen, tlen;
>   
> -	if (context_struct_to_string(p, ocontext, &o, &olen))
> +	if (sidtab_entry_to_string(p, sidtab, oentry, &o, &olen))
>   		goto out;
> -	if (context_struct_to_string(p, ncontext, &n, &nlen))
> +	if (sidtab_entry_to_string(p, sidtab, nentry, &n, &nlen))
>   		goto out;
> -	if (context_struct_to_string(p, tcontext, &t, &tlen))
> +	if (sidtab_entry_to_string(p, sidtab, tentry, &t, &tlen))
>   		goto out;
>   	audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
>   		  "op=security_validate_transition seresult=denied"
> @@ -751,9 +758,9 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *ocontext;
> -	struct context *ncontext;
> -	struct context *tcontext;
> +	struct sidtab_entry *oentry;
> +	struct sidtab_entry *nentry;
> +	struct sidtab_entry *tentry;
>   	struct class_datum *tclass_datum;
>   	struct constraint_node *constraint;
>   	u16 tclass;
> @@ -779,24 +786,24 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   	}
>   	tclass_datum = policydb->class_val_to_struct[tclass - 1];
>   
> -	ocontext = sidtab_search(sidtab, oldsid);
> -	if (!ocontext) {
> +	oentry = sidtab_search_entry(sidtab, oldsid);
> +	if (!oentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, oldsid);
>   		rc = -EINVAL;
>   		goto out;
>   	}
>   
> -	ncontext = sidtab_search(sidtab, newsid);
> -	if (!ncontext) {
> +	nentry = sidtab_search_entry(sidtab, newsid);
> +	if (!nentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, newsid);
>   		rc = -EINVAL;
>   		goto out;
>   	}
>   
> -	tcontext = sidtab_search(sidtab, tasksid);
> -	if (!tcontext) {
> +	tentry = sidtab_search_entry(sidtab, tasksid);
> +	if (!tentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, tasksid);
>   		rc = -EINVAL;
> @@ -805,15 +812,16 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   
>   	constraint = tclass_datum->validatetrans;
>   	while (constraint) {
> -		if (!constraint_expr_eval(policydb, ocontext, ncontext,
> -					  tcontext, constraint->expr)) {
> +		if (!constraint_expr_eval(policydb, &oentry->context,
> +					  &nentry->context, &tentry->context,
> +					  constraint->expr)) {
>   			if (user)
>   				rc = -EPERM;
>   			else
>   				rc = security_validtrans_handle_fail(state,
> -								     ocontext,
> -								     ncontext,
> -								     tcontext,
> +								     oentry,
> +								     nentry,
> +								     tentry,
>   								     tclass);
>   			goto out;
>   		}
> @@ -855,7 +863,7 @@ int security_bounded_transition(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *old_context, *new_context;
> +	struct sidtab_entry *old_entry, *new_entry;
>   	struct type_datum *type;
>   	int index;
>   	int rc;
> @@ -869,16 +877,16 @@ int security_bounded_transition(struct selinux_state *state,
>   	sidtab = state->ss->sidtab;
>   
>   	rc = -EINVAL;
> -	old_context = sidtab_search(sidtab, old_sid);
> -	if (!old_context) {
> +	old_entry = sidtab_search_entry(sidtab, old_sid);
> +	if (!old_entry) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, old_sid);
>   		goto out;
>   	}
>   
>   	rc = -EINVAL;
> -	new_context = sidtab_search(sidtab, new_sid);
> -	if (!new_context) {
> +	new_entry = sidtab_search_entry(sidtab, new_sid);
> +	if (!new_entry) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, new_sid);
>   		goto out;
> @@ -886,10 +894,10 @@ int security_bounded_transition(struct selinux_state *state,
>   
>   	rc = 0;
>   	/* type/domain unchanged */
> -	if (old_context->type == new_context->type)
> +	if (old_entry->context.type == new_entry->context.type)
>   		goto out;
>   
> -	index = new_context->type;
> +	index = new_entry->context.type;
>   	while (true) {
>   		type = policydb->type_val_to_struct[index - 1];
>   		BUG_ON(!type);
> @@ -901,7 +909,7 @@ int security_bounded_transition(struct selinux_state *state,
>   
>   		/* @newsid is bounded by @oldsid */
>   		rc = 0;
> -		if (type->bounds == old_context->type)
> +		if (type->bounds == old_entry->context.type)
>   			break;
>   
>   		index = type->bounds;
> @@ -912,10 +920,10 @@ int security_bounded_transition(struct selinux_state *state,
>   		char *new_name = NULL;
>   		u32 length;
>   
> -		if (!context_struct_to_string(policydb, old_context,
> -					      &old_name, &length) &&
> -		    !context_struct_to_string(policydb, new_context,
> -					      &new_name, &length)) {
> +		if (!sidtab_entry_to_string(policydb, sidtab, old_entry,
> +					    &old_name, &length) &&
> +		    !sidtab_entry_to_string(policydb, sidtab, new_entry,
> +					    &new_name, &length)) {
>   			audit_log(audit_context(),
>   				  GFP_ATOMIC, AUDIT_SELINUX_ERR,
>   				  "op=security_bounded_transition "
> @@ -1255,6 +1263,23 @@ static int context_struct_to_string(struct policydb *p,
>   	return 0;
>   }
>   
> +static int sidtab_entry_to_string(struct policydb *p,
> +				  struct sidtab *sidtab,
> +				  struct sidtab_entry *entry,
> +				  char **scontext, u32 *scontext_len)
> +{
> +	int rc = sidtab_sid2str_get(sidtab, entry, scontext, scontext_len);
> +
> +	if (rc != -ENOENT)
> +		return rc;
> +
> +	rc = context_struct_to_string(p, &entry->context, scontext,
> +				      scontext_len);
> +	if (!rc && scontext)
> +		sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_len);
> +	return rc;
> +}
> +
>   #include "initial_sid_to_string.h"
>   
>   const char *security_get_initial_sid_context(u32 sid)
> @@ -1271,7 +1296,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *context;
> +	struct sidtab_entry *entry;
>   	int rc = 0;
>   
>   	if (scontext)
> @@ -1302,21 +1327,23 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   	policydb = &state->ss->policydb;
>   	sidtab = state->ss->sidtab;
> +
>   	if (force)
> -		context = sidtab_search_force(sidtab, sid);
> +		entry = sidtab_search_entry_force(sidtab, sid);
>   	else
> -		context = sidtab_search(sidtab, sid);
> -	if (!context) {
> +		entry = sidtab_search_entry(sidtab, sid);
> +	if (!entry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, sid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	if (only_invalid && !context->len)
> -		rc = 0;
> -	else
> -		rc = context_struct_to_string(policydb, context, scontext,
> -					      scontext_len);
> +	if (only_invalid && !entry->context.len)
> +		goto out_unlock;
> +
> +	rc = sidtab_entry_to_string(policydb, sidtab, entry, scontext,
> +				    scontext_len);
> +
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   out:
> @@ -1574,19 +1601,20 @@ int security_context_to_sid_force(struct selinux_state *state,
>   
>   static int compute_sid_handle_invalid_context(
>   	struct selinux_state *state,
> -	struct context *scontext,
> -	struct context *tcontext,
> +	struct sidtab_entry *sentry,
> +	struct sidtab_entry *tentry,
>   	u16 tclass,
>   	struct context *newcontext)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> +	struct sidtab *sidtab = state->ss->sidtab;
>   	char *s = NULL, *t = NULL, *n = NULL;
>   	u32 slen, tlen, nlen;
>   	struct audit_buffer *ab;
>   
> -	if (context_struct_to_string(policydb, scontext, &s, &slen))
> +	if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
>   		goto out;
> -	if (context_struct_to_string(policydb, tcontext, &t, &tlen))
> +	if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
>   		goto out;
>   	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
>   		goto out;
> @@ -1645,7 +1673,8 @@ static int security_compute_sid(struct selinux_state *state,
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
>   	struct class_datum *cladatum = NULL;
> -	struct context *scontext = NULL, *tcontext = NULL, newcontext;
> +	struct context *scontext, *tcontext, newcontext;
> +	struct sidtab_entry *sentry, *tentry;
>   	struct role_trans *roletr = NULL;
>   	struct avtab_key avkey;
>   	struct avtab_datum *avdatum;
> @@ -1682,21 +1711,24 @@ static int security_compute_sid(struct selinux_state *state,
>   	policydb = &state->ss->policydb;
>   	sidtab = state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> -	if (!scontext) {
> +	sentry = sidtab_search_entry(sidtab, ssid);
> +	if (!sentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	tcontext = sidtab_search(sidtab, tsid);
> -	if (!tcontext) {
> +	tentry = sidtab_search_entry(sidtab, tsid);
> +	if (!tentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
>   
> +	scontext = &sentry->context;
> +	tcontext = &tentry->context;
> +
>   	if (tclass && tclass <= policydb->p_classes.nprim)
>   		cladatum = policydb->class_val_to_struct[tclass - 1];
>   
> @@ -1797,10 +1829,8 @@ static int security_compute_sid(struct selinux_state *state,
>   
>   	/* Check the validity of the context. */
>   	if (!policydb_context_isvalid(policydb, &newcontext)) {
> -		rc = compute_sid_handle_invalid_context(state, scontext,
> -							tcontext,
> -							tclass,
> -							&newcontext);
> +		rc = compute_sid_handle_invalid_context(state, sentry, tentry,
> +							tclass, &newcontext);
>   		if (rc)
>   			goto out_unlock;
>   	}
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..5271a9b9881f 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -9,6 +9,8 @@
>    */
>   #include <linux/errno.h>
>   #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/rcupdate.h>
>   #include <linux/slab.h>
>   #include <linux/sched.h>
>   #include <linux/spinlock.h>
> @@ -17,6 +19,14 @@
>   #include "security.h"
>   #include "sidtab.h"
>   
> +struct sidtab_str_cache {
> +	struct rcu_head rcu_member;
> +	struct list_head lru_member;
> +	struct sidtab_entry *parent;
> +	u32 len;
> +	char str[];
> +};
> +
>   int sidtab_init(struct sidtab *s)
>   {
>   	u32 i;
> @@ -34,24 +44,33 @@ int sidtab_init(struct sidtab *s)
>   	s->convert = NULL;
>   
>   	spin_lock_init(&s->lock);
> +
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	s->cache_free_slots = CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE;
> +	INIT_LIST_HEAD(&s->cache_lru_list);
> +	spin_lock_init(&s->cache_lock);
> +#endif
>   	return 0;
>   }
>   
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   {
> -	struct sidtab_isid_entry *entry;
> +	struct sidtab_isid_entry *isid;
>   	int rc;
>   
>   	if (sid == 0 || sid > SECINITSID_NUM)
>   		return -EINVAL;
>   
> -	entry = &s->isids[sid - 1];
> +	isid = &s->isids[sid - 1];
>   
> -	rc = context_cpy(&entry->context, context);
> +	rc = context_cpy(&isid->entry.context, context);
>   	if (rc)
>   		return rc;
>   
> -	entry->set = 1;
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	isid->entry.cache = NULL;
> +#endif
> +	isid->set = 1;
>   	return 0;
>   }
>   
> @@ -88,7 +107,8 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 level)
>   	return 0;
>   }
>   
> -static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
> +static struct sidtab_entry *sidtab_do_lookup(struct sidtab *s, u32 index,
> +					     int alloc)
>   {
>   	union sidtab_entry_inner *entry;
>   	u32 level, capacity_shift, leaf_index = index / SIDTAB_LEAF_ENTRIES;
> @@ -125,10 +145,16 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
>   		if (!entry->ptr_leaf)
>   			return NULL;
>   	}
> -	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
> +	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
> +}
> +
> +/* use when you know that there is enough entries */
> +static struct context *sidtab_lookup_unsafe(struct sidtab *s, u32 index)
> +{
> +	return &sidtab_do_lookup(s, index, 0)->context;
>   }
>   
> -static struct context *sidtab_lookup(struct sidtab *s, u32 index)
> +static struct sidtab_entry *sidtab_lookup(struct sidtab *s, u32 index)
>   {
>   	/* read entries only after reading count */
>   	u32 count = smp_load_acquire(&s->count);
> @@ -139,33 +165,34 @@ static struct context *sidtab_lookup(struct sidtab *s, u32 index)
>   	return sidtab_do_lookup(s, index, 0);
>   }
>   
> -static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
> +static struct sidtab_entry *sidtab_lookup_initial(struct sidtab *s, u32 sid)
>   {
> -	return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
> +	return s->isids[sid - 1].set ? &s->isids[sid - 1].entry : NULL;
>   }
>   
> -static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> +static struct sidtab_entry *sidtab_search_core(struct sidtab *s, u32 sid,
> +					       int force)
>   {
> -	struct context *context;
> -
>   	if (sid != 0) {
> +		struct sidtab_entry *entry;
> +
>   		if (sid > SECINITSID_NUM)
> -			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> +			entry = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
>   		else
> -			context = sidtab_lookup_initial(s, sid);
> -		if (context && (!context->len || force))
> -			return context;
> +			entry = sidtab_lookup_initial(s, sid);
> +		if (entry && (!entry->context.len || force))
> +			return entry;
>   	}
>   
>   	return sidtab_lookup_initial(s, SECINITSID_UNLABELED);
>   }
>   
> -struct context *sidtab_search(struct sidtab *s, u32 sid)
> +struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid)
>   {
>   	return sidtab_search_core(s, sid, 0);
>   }
>   
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid)
> +struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
>   {
>   	return sidtab_search_core(s, sid, 1);
>   }
> @@ -230,7 +257,7 @@ static int sidtab_rcache_search(struct sidtab *s, struct context *context,
>   		if (v >= SIDTAB_MAX)
>   			continue;
>   
> -		if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
> +		if (context_cmp(sidtab_lookup_unsafe(s, v), context)) {
>   			sidtab_rcache_update(s, v, i);
>   			*index = v;
>   			return 0;
> @@ -245,7 +272,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   	unsigned long flags;
>   	u32 count, count_locked, level, pos;
>   	struct sidtab_convert_params *convert;
> -	struct context *dst, *dst_convert;
> +	struct sidtab_entry *dst, *dst_convert;
>   	int rc;
>   
>   	rc = sidtab_rcache_search(s, context, index);
> @@ -273,7 +300,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   
>   	/* if count has changed before we acquired the lock, then catch up */
>   	while (count < count_locked) {
> -		if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
> +		if (context_cmp(sidtab_lookup_unsafe(s, count), context)) {
>   			sidtab_rcache_push(s, count);
>   			*index = count;
>   			rc = 0;
> @@ -293,7 +320,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   	if (!dst)
>   		goto out_unlock;
>   
> -	rc = context_cpy(dst, context);
> +	rc = context_cpy(&dst->context, context);
>   	if (rc)
>   		goto out_unlock;
>   
> @@ -305,13 +332,14 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   		rc = -ENOMEM;
>   		dst_convert = sidtab_do_lookup(convert->target, count, 1);
>   		if (!dst_convert) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> -		rc = convert->func(context, dst_convert, convert->args);
> +		rc = convert->func(context, &dst_convert->context,
> +				   convert->args);
>   		if (rc) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> @@ -341,9 +369,9 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
>   	u32 i;
>   
>   	for (i = 0; i < SECINITSID_NUM; i++) {
> -		struct sidtab_isid_entry *entry = &s->isids[i];
> +		struct sidtab_isid_entry *isid = &s->isids[i];
>   
> -		if (entry->set && context_cmp(context, &entry->context)) {
> +		if (isid->set && context_cmp(context, &isid->entry.context)) {
>   			*sid = i + 1;
>   			return 0;
>   		}
> @@ -453,6 +481,14 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>   	return rc;
>   }
>   
> +static void sidtab_destroy_entry(struct sidtab_entry *entry)
> +{
> +	context_destroy(&entry->context);
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	kfree(entry->cache);
> +#endif
> +}
> +
>   static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
>   {
>   	u32 i;
> @@ -473,7 +509,7 @@ static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
>   			return;
>   
>   		for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
> -			context_destroy(&node->entries[i].context);
> +			sidtab_destroy_entry(&node->entries[i]);
>   		kfree(node);
>   	}
>   }
> @@ -484,7 +520,7 @@ void sidtab_destroy(struct sidtab *s)
>   
>   	for (i = 0; i < SECINITSID_NUM; i++)
>   		if (s->isids[i].set)
> -			context_destroy(&s->isids[i].context);
> +			sidtab_destroy_entry(&s->isids[i].entry);
>   
>   	level = SIDTAB_MAX_LEVEL;
>   	while (level && !s->roots[level].ptr_inner)
> @@ -492,3 +528,79 @@ void sidtab_destroy(struct sidtab *s)
>   
>   	sidtab_destroy_tree(s->roots[level], level);
>   }
> +
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +
> +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> +			const char *str, u32 str_len)
> +{
> +	struct sidtab_str_cache *cache, *victim;
> +
> +	if (entry->context.len)
> +		return; /* do not cache invalid contexts */
> +
> +	spin_lock(&s->cache_lock);
> +
> +	if (entry->cache) {
> +		/* entry in cache - just bump to he head of LRU list */
> +		list_move(&entry->cache->lru_member, &s->cache_lru_list);
> +		goto out_unlock;
> +	}
> +
> +	cache = kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC);
> +	if (!cache)
> +		goto out_unlock;
> +
> +	if (s->cache_free_slots == 0) {
> +		/* pop a cache entry from the tail and free it */
> +		victim = container_of(s->cache_lru_list.prev,
> +				      struct sidtab_str_cache, lru_member);
> +		list_del(&victim->lru_member);
> +		kfree_rcu(victim, rcu_member);
> +		rcu_assign_pointer(victim->parent->cache, NULL);
> +	} else {
> +		s->cache_free_slots--;
> +	}
> +	cache->parent = entry;
> +	cache->len = str_len;
> +	memcpy(cache->str, str, str_len);
> +	rcu_head_init(&cache->rcu_member);
> +	list_add(&cache->lru_member, &s->cache_lru_list);
> +
> +	rcu_assign_pointer(entry->cache, cache);
> +
> +out_unlock:
> +	spin_unlock(&s->cache_lock);
> +}
> +
> +int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
> +		       char **out, u32 *out_len)
> +{
> +	struct sidtab_str_cache *cache;
> +	int rc = 0;
> +
> +	if (entry->context.len)
> +		return -ENOENT; /* do not cache invalid contexts */
> +
> +	rcu_read_lock();
> +
> +	cache = rcu_dereference(entry->cache);
> +	if (!cache) {
> +		rc = -ENOENT;
> +	} else {
> +		*out_len = cache->len;
> +		if (out) {
> +			*out = kmemdup(cache->str, cache->len, GFP_ATOMIC);
> +			if (!*out)
> +				rc = -ENOMEM;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (!rc && out)
> +		sidtab_sid2str_put(s, entry, *out, *out_len);
> +	return rc;
> +}
> +
> +#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index 1f4763141aa1..9159a300bde3 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -16,13 +16,13 @@
>   
>   #include "context.h"
>   
> -struct sidtab_entry_leaf {
> +struct sidtab_entry {
>   	struct context context;
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	struct sidtab_str_cache *cache;
> +#endif
>   };
>   
> -struct sidtab_node_inner;
> -struct sidtab_node_leaf;
> -
>   union sidtab_entry_inner {
>   	struct sidtab_node_inner *ptr_inner;
>   	struct sidtab_node_leaf  *ptr_leaf;
> @@ -38,7 +38,7 @@ union sidtab_entry_inner {
>   	(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inner)))
>   #define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
>   #define SIDTAB_LEAF_ENTRIES \
> -	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
> +	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry))
>   
>   #define SIDTAB_MAX_BITS 32
>   #define SIDTAB_MAX U32_MAX
> @@ -48,7 +48,7 @@ union sidtab_entry_inner {
>   		     SIDTAB_INNER_SHIFT)
>   
>   struct sidtab_node_leaf {
> -	struct sidtab_entry_leaf entries[SIDTAB_LEAF_ENTRIES];
> +	struct sidtab_entry entries[SIDTAB_LEAF_ENTRIES];
>   };
>   
>   struct sidtab_node_inner {
> @@ -57,7 +57,7 @@ struct sidtab_node_inner {
>   
>   struct sidtab_isid_entry {
>   	int set;
> -	struct context context;
> +	struct sidtab_entry entry;
>   };
>   
>   struct sidtab_convert_params {
> @@ -83,6 +83,13 @@ struct sidtab {
>   	struct sidtab_convert_params *convert;
>   	spinlock_t lock;
>   
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	/* SID -> context string cache */
> +	u32 cache_free_slots;
> +	struct list_head cache_lru_list;
> +	spinlock_t cache_lock;
> +#endif
> +
>   	/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
>   	u32 rcache[SIDTAB_RCACHE_SIZE];
>   
> @@ -92,8 +99,22 @@ struct sidtab {
>   
>   int sidtab_init(struct sidtab *s);
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context);
> -struct context *sidtab_search(struct sidtab *s, u32 sid);
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid);
> +struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid);
> +struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid);
> +
> +static inline struct context *sidtab_search(struct sidtab *s, u32 sid)
> +{
> +	struct sidtab_entry *entry = sidtab_search_entry(s, sid);
> +
> +	return entry ? &entry->context : NULL;
> +}
> +
> +static inline struct context *sidtab_search_force(struct sidtab *s, u32 sid)
> +{
> +	struct sidtab_entry *entry = sidtab_search_entry_force(s, sid);
> +
> +	return entry ? &entry->context : NULL;
> +}
>   
>   int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
>   
> @@ -101,6 +122,25 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
>   
>   void sidtab_destroy(struct sidtab *s);
>   
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> +			const char *str, u32 str_len);
> +int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
> +		       char **out, u32 *out_len);
> +#else
> +static inline void sidtab_sid2str_put(struct sidtab *s,
> +				      struct sidtab_entry *entry,
> +				      const char *str, u32 str_len)
> +{
> +}
> +static inline int sidtab_sid2str_get(struct sidtab *s,
> +				     struct sidtab_entry *entry,
> +				     char **out, u32 *out_len)
> +{
> +	return -ENOENT;
> +}
> +#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> +
>   #endif	/* _SS_SIDTAB_H_ */
>   
>   
> 

