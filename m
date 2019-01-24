Return-Path: <SRS0=cSl0=QA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC93C282C3
	for <selinux@archiver.kernel.org>; Thu, 24 Jan 2019 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B644218A2
	for <selinux@archiver.kernel.org>; Thu, 24 Jan 2019 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HAUO4T4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAXOqI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:46:08 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:50280 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbfAXOqI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jan 2019 09:46:08 -0500
Received: from mxback2g.mail.yandex.net (mxback2g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:163])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 3463A6030D;
        Thu, 24 Jan 2019 17:46:04 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mevHjtWUfI-k39KnQiB;
        Thu, 24 Jan 2019 17:46:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548341163;
        bh=n+9VbUolva67vVoc3RWHlRtYSx0t/rHf/LwF4KxSnyk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=HAUO4T4YbK8WSb8+MaI+5QuD8NUu0vtNsAFQHiJtNv2a+asKmnuOkJKvgWa5mDf2+
         T4zvkivhBGZj692TG6JdJ56O9I/g6t0cIi0VLbbYqiWVhxXIUXZbymQ6k+LvHUf6Qt
         /kBY4D4lH6cRBEKrVW8UHvLXQMf7RpZNf1iOlav8=
Authentication-Results: mxback2g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-7b909973f402.qloud-c.yandex.net with HTTP;
        Thu, 24 Jan 2019 17:46:03 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
         <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 24 Jan 2019 17:46:03 +0300
Message-Id: <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

22.01.2019, 20:48, "Paul Moore" <paul@paul-moore.com>:
>
> Yes, exactly. If you don't pass the skb it shouldn't attempt to call
> icmp_send() in case of error.
>
> --
> paul moore
> www.paul-moore.com

You are right, sorry. We can do that without ip_options_compile modification.
Simplified patch 2:
---
 net/ipv4/cipso_ipv4.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b..a4ed0a4 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1735,13 +1735,27 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+       unsigned char optbuf[sizeof(struct ip_options) + 40];
+       struct ip_options *opt = (struct ip_options *)optbuf;
+
        if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
                return;
 
+       /* 
+        * We might be called above the IP layer,
+        * so we can not use icmp_send and IPCB here.
+        */
+
+       memset(opt, 0, sizeof(struct ip_options));
+       opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+       memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
+       if (ip_options_compile(dev_net(skb->dev), opt, NULL))
+               return;
+
        if (gateway)
-               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
+               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
        else
-               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
 }
 
 /**

