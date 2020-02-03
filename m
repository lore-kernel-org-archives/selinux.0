Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5588C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379321582
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EFsnpG7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBCNkn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:40:43 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:15490 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCNkn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 08:40:43 -0500
X-EEMSG-check-017: 53309517|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="53309517"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 13:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580737240; x=1612273240;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pxDeWNDvCoNIs9YrssjPx5yT7kQ9EvRnSxpaQ02PO+M=;
  b=EFsnpG7JLWGBGCzB375zEBmbIteUjTqIXDxktVpzbR8u3YzoQKJ0/gtE
   s0OzeR5jVmd1zG6uH3pFo0JDbmxZedQs5WgNRL7fGs5Ux8cVK2R/uEpdE
   BgIM5uDtAqVQXRi/PTRzHDLNEZLCw5ESoZ5/6AVfENAaCpC+GInHXjhy0
   heesjza7q4PkLzUywr7NCZdf26cyZRGXhcEiXWxqNRax+Mkl3QnaxTJAl
   CAMMjM86EQ1mEsQlPO9tC8pPYP5lCJZV47koC8HjiIDxY+rWgzxEIP9l0
   NsxUTG/95oWMrRUt9IarplJvAOqIQiTV9aV2mYHc8nAZRKcIx5Kzi71MA
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="38577035"
IronPort-PHdr: =?us-ascii?q?9a23=3AdOc3DxToHGXQC9bTeBYqNeQTVdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRyBt8tkgFKBZ4jH8fUM07OQ7/m8HzBfqsvZ+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrXZFeetayGN0KVmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVtOq31?=
 =?us-ascii?q?lXripKiMXMumoR2BzU78iKTOZ28ES52TuXygze5e5JLVo0mKbGMZIt3LE9mo?=
 =?us-ascii?q?QJvUjeGCL9hV/4g7WMdko+/+il8+HnYrL7qZCCL4J0kQT+Mrg2msy4HOQ4Lh?=
 =?us-ascii?q?ACX2iF9uS4073u5VH5T69Qjv03j6nZq4rWJcUdpq63BA9VyZgs5AqlAze60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBk4fpIE3BLOr9Dfe+h1SgiDZrx/bYMb39GpjBM3fOnbj7cb?=
 =?us-ascii?q?t99kJQ0hQ/wN9B655OF70NOPfzVVXwtNzcAB85KQu0w+P/BdVmy4weQnmCAr?=
 =?us-ascii?q?OZMazOsV+I4fgjI++XZIAPojr9JP8l5+D2gX8jhVAdZbWp3YcQaH2gGfRmJk?=
 =?us-ascii?q?KZYWHqgtgbDWgFoBEzTPb0h1KfUT5cfWqyU7gg6TE8DYKsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZntYBVCIEHfocZiEWvgXZSKMLc9ujCYEWaKiS4A/zxGushH1y759Iu?=
 =?us-ascii?q?rT4C0Yuorp1MJp6O3LiREy6Tt0AtyF026XUmF0mngFRycs06BipUxx01KD0a?=
 =?us-ascii?q?9/g/xCC9Nf/e9GUgA/NZTE1ex1F8jyWh7dfteOUFumWdWnADAqQdI2398CZE?=
 =?us-ascii?q?dwF8i+gR/YxSWnA6MZmrKFCZMq7K7Qw3r8K9hgxHvHyaUsjEUqT8pUOG29hq?=
 =?us-ascii?q?9+9gvTCJTNk0Wdiamqb74Q0zTV9Geb1mqOpEZYUBJ1UarfXHAfYlHaosj+5k?=
 =?us-ascii?q?PHHPeSDuEANAdbxMzKD6xRbNTigFYOEPDmP8/Yamm8s329CRaB2vWHa4+8Py?=
 =?us-ascii?q?0G0SHcDlUUux4c8GzANgUkACql5WXEA3gmLVvyZwvJ9u5kpTvvVkYpyymSZl?=
 =?us-ascii?q?Blkr+y/QQYw/ebTqVA8KgDvXIatzhsHFu7l+nTAt6EqhspKL5Qevsh8VxH0i?=
 =?us-ascii?q?TfrAU7MZu+efMxzmUCehh66hu9ny58DZ9NxI1z9yIn?=
X-IPAS-Result: =?us-ascii?q?A2C2AADwIThe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhVIBIqhBSJA4ZcAQEGgTeJb5FJCQEBAQEBAQEBASsMAQGEQAKCW?=
 =?us-ascii?q?DcGDgIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwIBBSMEEUEQCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjPwGCViUPq1Z/M4VKg0GBOAaBDioBjDl5gQeBOA+CXT6CZAQag?=
 =?us-ascii?q?UmDEIJeBI1eiVpGl2SCRYJOhHiFR4ktBhubCI5hiGeUQyOBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?1AYDY4pF4NQinEjAzACjwcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Feb 2020 13:40:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013DdmUB154846;
        Mon, 3 Feb 2020 08:39:49 -0500
Subject: Re: [PATCH] selinux: fix sidtab string cache locking
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
References: <20200203085023.360612-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8dbc1ed9-7c6a-a745-0d6f-8975d32f591d@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 08:41:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203085023.360612-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 3:50 AM, Ondrej Mosnacek wrote:
> Avoiding taking a lock in an IRQ context is not enough to prevent
> deadlocks, as discovered by syzbot:
> 
> ===
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 5.5.0-syzkaller #0 Not tainted
> -----------------------------------------------------
> syz-executor.0/8927 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> 
> and this task is already holding:
> ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> which would create a new lock dependency:
>   (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
> 
> but this new dependency connects a SOFTIRQ-irq-safe lock:
>   (&(&nf_conntrack_locks[i])->rlock){+.-.}
> 
> [...]
> 
> other info that might help us debug this:
> 
>   Possible interrupt unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&(&s->cache_lock)->rlock);
>                                 local_irq_disable();
>                                 lock(&(&nf_conntrack_locks[i])->rlock);
>                                 lock(&(&s->cache_lock)->rlock);
>    <Interrupt>
>      lock(&(&nf_conntrack_locks[i])->rlock);
> 
>   *** DEADLOCK ***
> [...]
> ===
> 
> Fix this by simply locking with irqsave/irqrestore and stop giving up on
> !in_task(). It makes the locking a bit slower, but it shouldn't make a
> big difference in real workloads. Under the scenario from [1] (only
> cache hits) it only increased the runtime overhead from the
> security_secid_to_secctx() function from ~2% to ~3% (it was ~5-65%
> before introducing the cache).
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> 
> Fixes: d97bd23c2d7d ("selinux: cache the SID -> context string translation")
> Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

[...]
