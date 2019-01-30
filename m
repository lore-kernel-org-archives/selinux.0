Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1028C282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705FC218A3
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KmZl7krA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfA3NSE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:18:04 -0500
Received: from forward500p.mail.yandex.net ([77.88.28.110]:39507 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfA3NSE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 08:18:04 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 08:18:01 EST
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 0E91C940348;
        Wed, 30 Jan 2019 16:11:44 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9t4zK3SqUQ-Bg2aYf1H;
        Wed, 30 Jan 2019 16:11:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548853903;
        bh=r12kxZYIgNz0gw+9Z+am4TOsNakBUCZ7+k/fvJ3GB/A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=KmZl7krA+mEZe8H5lNYtMqBlPWBVR82Ar/iPn8UlFzv9nbWpnYZdPm3pXNWf3tuVf
         gfRSo9cFitIyGbDrA6D4SxJzqNZ9vYVgvKW4J2Q9bg2WUJ6+ZfbmkyJ4YnOJa1W4MV
         wBxgRWgLe2Qy19DFVKODRWcR4qsXOOBUUuDqVErw=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-23299ba78d64.qloud-c.yandex.net with HTTP;
        Wed, 30 Jan 2019 16:11:42 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
         <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
         <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
        <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
         <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net> <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 30 Jan 2019 16:11:42 +0300
Message-Id: <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

30.01.2019, 01:42, "Paul Moore" <paul@paul-moore.com>:
> There are several cases where the stack ends up calling icmp_send()
> after the skb has been through ip_options_compile(), that should be
> okay.
>
> --
> paul moore
> www.paul-moore.com

In those cases precompiled ip_options struct used, without the need to reuse ip_options_compile.
I think, for error ICMP packet, we can discard all other options except CIPSO. It will be better, than
send packet, contains wrong option's data. Modified patch 2:
---
 net/ipv4/cipso_ipv4.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b..797826c 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1735,13 +1735,33 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+       struct ip_options opt;
+       unsigned char *optptr;
+
        if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
                return;
 
+       /* 
+        * We might be called above the IP layer,
+        * so we can not use icmp_send and IPCB here.
+        *
+        * For the generated ICMP packet, we create a
+        * temporary ip _options structure, contains
+        * the CIPSO option only, since the other options data
+        * could be modified when the original packet receiving.
+        */
+
+       memset(&opt, 0, sizeof(struct ip_options));
+       optptr = cipso_v4_optptr(skb);
+       if (optptr) {
+               opt.optlen = optptr[1];
+               opt.cipso = optptr - skb_network_header(skb);
+       }
+
        if (gateway)
-               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
+               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
        else
-               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
 }
 
 /**

