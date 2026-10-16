Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD74E36D6
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161475; cv=none; b=H6+Vc3IrsmMrSre7nrUy3gY0X0Sk62r3/enyo0C36sJnrzlSNuTKMuHuJxHLpRO94c3b/FcmchTZdYUsC0W1Cfk34Zt3Hk7XuNTWMWekC6ldb+vVS+Nif9bamAQcMHXoya6MtTUSW9iATxH8Edh5ohO4wOLHjUsPIj9ndMozXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161475; c=relaxed/simple;
	bh=wAp7afOfTC8HUwyazn0LOftlGcbyrbQpAQhvKDn+ea4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mn3x3Y1ByZoP0/kO7UMxT7eLSKHc2YaINE8l+1G+vttf6U1Y0OTWvfZozI/qYE5v7CfnncYNeRavFNokX6O3yaeBlpdr8qz7SFzwbuFDu+e1mc3YFlFUUtIKqGHkMpCuQpq8lqZOH0ajwVa3igvvmDCXIs6nrfkP6+UY+caQ8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL3b9nrb; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL3b9nrb"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9851592ada1so11605241.0
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161469; x=1792766269; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvFMfxSzYVJ2lOTMgtJEulD+6aZKmETG2qDahrWDVzI=;
        b=UL3b9nrbT8FhDYiBNNTYMQ0g2P11ovzC/D+iI3qA4y96nANAG1iq0ojqMX+/39b0y/
         9yPzrDqw4LCorPMdnBZ9IQyzBRf37IGvuAMPhixVqu2Cf6AIYaM6N6yi4mLyNHM+9VMI
         JlQ+rI+YpN66ADhcxVN2SK+ONvAoPnuE0mHLJ76SUoSfQm0k4m4zpOwb0C6uNhN9RzQF
         K7CINHUyZFay7mfeADRsrvzs6YwLdwPYcdN5/dc+C9jet4vXdYSPXG3w91NqCgmUXFFV
         lnnwxThvbmRG12eP9WCBod6Xn1fTqDS4F2wmXoJ25pvJMvj0PmO3kyXsdJMVzaTTOvOm
         a4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161469; x=1792766269;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvFMfxSzYVJ2lOTMgtJEulD+6aZKmETG2qDahrWDVzI=;
        b=TRfcwxaQiywprGWktD7zCPCW/mSRdcQXBsEhS/V5Yjus9AGcDUEs/FC+79jBqFX9un
         5coDtS1TnssofWY39bj0VMRw/lwDwTdAt1/ZE+CqA13+0MV86Jq4EBzv8BXDR5SP9alC
         6H0gRHq8WRyV4vUtVovNGFACM7XdSt38mBUF/cwf3RgCBNoRE2VDOVRHWqSo3dPkNLpc
         i5l6hDUJVCigMiSL+FaLn2yMrhUirYU49ofnK5NS86+SblBdlKj8+x0F7tGq/DwvysR3
         loVKWd1FIVPxQSX13QSS/znDqbCC+x/NPoPWw7drkGcttgsWqLZXvGIG1wJMnA7r46mf
         uYpA==
X-Forwarded-Encrypted: i=1; AKwUvBxtiuswLSikQMcO/hyeq9N9ipqYJ4NfOy0XtL8dg3iCeZtx2Z8gknNbIj6PebOAQ3Qoqn549NA2@vger.kernel.org
X-Gm-Message-State: AFq9FYLk3xinhRV1e8GydzI0j0gjuYgHJTc3CWQe9AmMm4/H6h94NUh1
	cKMlFD9yaUVWNOxovf9W3nztAb8mAS9XJfyosfeVVro+KF+9PdIpi51Z
X-Gm-Gg: AYBFou2wyxKx0ie/pgL9jI3BqmrZBZshVmZs42oaazGbIu6zIql/AMUT8PenepJZ6wf
	1JPycnFW8x+dpor4kJpfPG09rYOLN8fp6WwYMquNA3Hqd9iu5tQc2b93HqEKoQJyM5uAXgzArT8
	gIT6OsYNf/uT5Vw2sTaTZLde0N/Fy12IP7Yp5XaBiOmoNIW9hNP/YQkdEmhti6IcvR9kmdMoE+2
	E+OfDVetj7bm4fw9TRmzDEL4Z6LzVKUtBYaVxHxf2Gn1WUFZ3sle0HB+MWkuEC2TdIxirmcgAb/
	9bIV2MlIMDltWwbZjVMWu2PEQc7vDvkbJ9hP3nWGuT0CPr23dG72uTcq/Rv1Pb1vajQ+U948SC7
	8grQuHUOqtC5gNAfhEtgbfyRRnkz3aPstlzgjbKSJE67jJfNxgZT4M5aRx1vsdTJg5SGhhfwepc
	UnazLP7MVUNno2E4G0zOI2qU0e/kKC1ZcbGVmYQy0qJpgGEgAyin7TEeM2huxpnTGTuGFUkWHC0
	Rxp5qoydrTj1Sc0EIrZMBl3K+p6Bvq6lFecrJczj7qL3tU2N7F95S3Lt1sODXod6nsicsoSlGdy
	X3r9m/Z5KxX0kb68jX2Q+WpKcJmqTP6weBO+eAejMGZtmZPKWLo9cjao
X-Received: by 2002:a05:6102:c48:b0:7c8:3b8c:82ba with SMTP id ada2fe7eead31-7cb373de301mr5673762137.32.1792161468460;
        Fri, 16 Oct 2026 07:37:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:ece0:b5:bb23:a54:ce61])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc1983af93sm2248453137.8.2026.10.16.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:37:47 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: don't label bridged packets in selinux_ip_forward()
Date: Fri, 16 Oct 2026 11:37:41 -0300
Message-ID: <179216146138.25460.7866279004288174372@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
header and reset the network header, but the Ethernet header stays
where it was; when the bridge pushes it back in front of the packet it
picks up stale bytes and the frame goes out with a garbage destination
MAC and EtherType.

Labeling a bridged packet based on its IP addresses is not what we want
here anyway, so leave bridged packets alone.  Add a stub of
nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=n.

Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
per case:

  case                                        before        after
  CALIPSO packet, unlabeled destination       MAC garbage   5/5
  unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
  unlabeled IPv4, CIPSO destination           MAC garbage   5/5

Routed packets are still labeled (an unlabeled packet forwarded towards
a CALIPSO destination gets the option, 5/5).

Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security attributes of a packet")
Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com/
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
 include/linux/netfilter_bridge.h |  5 +++++
 security/selinux/hooks.c         | 13 ++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index 743475ca7..c1f7c3cb2 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -79,6 +79,11 @@ static inline bool nf_bridge_in_prerouting(const struct sk_buff *skb)
 }
 #else
 #define br_drop_fake_rtable(skb)	        do { } while (0)
+static inline bool nf_bridge_info_exists(const struct sk_buff *skb)
+{
+	return false;
+}
+
 static inline bool nf_bridge_in_prerouting(const struct sk_buff *skb)
 {
 	return false;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 30776b010..1e4f02f99 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -49,6 +49,7 @@
 #include <linux/fs_parser.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter_bridge.h>
 #include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
@@ -6145,11 +6146,13 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_enabled())
-		/* we do this in the FORWARD path and not the POST_ROUTING
-		 * path because we want to make sure we apply the necessary
-		 * labeling before IPsec is applied so we can leverage AH
-		 * protection */
+	/* we do this in the FORWARD path and not the POST_ROUTING path
+	 * because we want to make sure we apply the necessary labeling
+	 * before IPsec is applied so we can leverage AH protection; bridged
+	 * packets are skipped as changing their IP options would leave the
+	 * Ethernet header behind
+	 */
+	if (netlbl_enabled() && !nf_bridge_info_exists(skb))
 		if (selinux_netlbl_skbuff_setsid(skb, family, peer_sid) != 0)
 			return NF_DROP;
 
-- 
2.43.0

