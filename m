Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12356C31680
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A549420663
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="q2hAlmK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfAURLk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:11:40 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:33249 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfAURLk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jan 2019 12:11:40 -0500
Received: from mxback8g.mail.yandex.net (mxback8g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:169])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 53F7C60036;
        Mon, 21 Jan 2019 20:11:35 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback8g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fdsebIQP4l-BYDqm5w2;
        Mon, 21 Jan 2019 20:11:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548090694;
        bh=UYhGtozQFbxutrw+doH2PLUVGmWT+mQByCe6RAEcuPY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=q2hAlmK9i0L89jUbJWEdx5ygkpHX0JPrpFo6vr0dB7E4oOZQHSRQDkbCe6I0sw3fe
         9vBEbe1/Z8zg1idFdDuIKMGTuAZFKRXsxYaTASfFfblvT0BW4T4XGe9daIlWSm+ih4
         t1bmT0x+2iNYcPja0knp4eGs7Z+XbIRrEMxc3syk=
Authentication-Results: mxback8g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-adb97d30497b.qloud-c.yandex.net with HTTP;
        Mon, 21 Jan 2019 20:11:34 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com> <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 21 Jan 2019 20:11:34 +0300
Message-Id: <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

18.01.2019, 20:17, "Paul Moore" <paul@paul-moore.com>:
> Yes, this is extra overhead, but it is in an error path so I'm not
> overly concerned about the performance impact on the given connection.
>
> I will admit that it isn't an ideal solution from a LSM/NetLabel
> perspective, but historically the netdev folks have not been overly
> receptive to changes which negatively impact the core network stack
> regardless of how important it may be for the LSMs. If we could
> modify icmp_send() so that it works regardless of the caller's
> location in the stack, that would be great, I'm just not sure it would
> be deemed acceptable. I suggested the approach I did because I think
> that has the best chance of getting merged.
>
> Regardless, I would encourage you to put together a patch and post it
> for review, I think that's the best way to get a response. If you
> aren't able, or aren't comfortable, submitting a patch please let me
> know.
> --
> paul moore
> www.paul-moore.com

May be something like that?

[PATCH 1/2] Add IP options parameter to icmp_send
---
 include/net/icmp.h    |    9 ++++++++-
 net/ipv4/icmp.c       |    7 ++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/icmp.h b/include/net/icmp.h
index 6ac3a5b..e0f709d 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -22,6 +22,7 @@
 
 #include <net/inet_sock.h>
 #include <net/snmp.h>
+#include <net/ip.h>
 
 struct icmp_err {
   int		errno;
@@ -39,7 +40,13 @@ struct icmp_err {
 struct sk_buff;
 struct net;
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt);
+static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+{
+	__icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
+}
+
 int icmp_rcv(struct sk_buff *skb);
 int icmp_err(struct sk_buff *skb, u32 info);
 int icmp_init(void);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 065997f..3f24414 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -570,7 +570,8 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
  *			MUST reply to only the first fragment.
  */
 
-void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
+void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
+		 const struct ip_options *opt)
 {
 	struct iphdr *iph;
 	int room;
@@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 					  iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
+	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
 		goto out_unlock;
 
 
@@ -742,7 +743,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	local_bh_enable();
 out:;
 }
-EXPORT_SYMBOL(icmp_send);
+EXPORT_SYMBOL(__icmp_send);
 
 
 static void icmp_socket_deliver(struct sk_buff *skb, u32 info)

---
[PATCH 2/2] Extract IP options in cipso_v4_error
---
 include/net/ip.h      |    2 ++
 net/ipv4/cipso_ipv4.c |   11 +++++++++--
 net/ipv4/ip_options.c |   22 +++++++++++++++++-----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 8866bfc..f0e8d06 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -667,6 +667,8 @@ static inline int ip_options_echo(struct net *net, struct ip_options *dopt,
 }
 
 void ip_options_fragment(struct sk_buff *skb);
+int __ip_options_compile(struct net *net, struct ip_options *opt,
+			 struct sk_buff *skb, __be32 *info);
 int ip_options_compile(struct net *net, struct ip_options *opt,
 		       struct sk_buff *skb);
 int ip_options_get(struct net *net, struct ip_options_rcu **optp,
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b..86599e9 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1735,13 +1735,20 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+	unsigned char optbuf[sizeof(struct ip_options) + 40];
+	struct ip_options *opt = (struct ip_options *)optbuf;
+
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
 		return;
 
+	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
+		return;
+
 	if (gateway)
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
 	else
-		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
 }
 
 /**
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index ed194d4..32a3504 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -251,8 +251,9 @@ static void spec_dst_fill(__be32 *spec_dst, struct sk_buff *skb)
  * If opt == NULL, then skb->data should point to IP header.
  */
 
-int ip_options_compile(struct net *net,
-		       struct ip_options *opt, struct sk_buff *skb)
+int __ip_options_compile(struct net *net,
+			 struct ip_options *opt, struct sk_buff *skb,
+			 __be32 *info)
 {
 	__be32 spec_dst = htonl(INADDR_ANY);
 	unsigned char *pp_ptr = NULL;
@@ -468,11 +469,22 @@ int ip_options_compile(struct net *net,
 		return 0;
 
 error:
-	if (skb) {
-		icmp_send(skb, ICMP_PARAMETERPROB, 0, htonl((pp_ptr-iph)<<24));
-	}
+	if (info)
+		*info = htonl((pp_ptr-iph)<<24);
 	return -EINVAL;
 }
+
+int ip_options_compile(struct net *net,
+		       struct ip_options *opt, struct sk_buff *skb)
+{
+	int ret;
+	__be32 info;
+
+	ret = __ip_options_compile(net, opt, skb, &info);
+	if (ret != 0 && skb)
+		icmp_send(skb, ICMP_PARAMETERPROB, 0, info);
+	return ret;
+}
 EXPORT_SYMBOL(ip_options_compile);
 
 /*

---

