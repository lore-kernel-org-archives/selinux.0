Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826449;
	b=V4U8uDAHib0qsylNA+ful4V2QRMxO6A/gyexi3CLkLhPGdjpXgLxWzFgWiZNUth7pHj+
	 WD1vz8mI7fRsKX07Vm3+anakeCegE5lqEwZwU08vako5WRRa7nc1CjZ8Hc96RdnceSlfj
	 J5o6BvC8U9DtdDelpSZqM25jlLlkzrBEsKsf0acByC7dhSrUkRqloYg99UqLTLALXltZY
	 qLWzyz98V/QOGSDFhqW8rGr5g9lMg09DM4Z8BNBdL/6D7kUj/S4+Et+0vfk8xNMO2pdVD
	 a4A9ADXQ+smnMFMuSGMXKn3uj655DgUlp7l1ukjg1JaMhHR8jsjtB7+w7nKsjmNFajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
	b=BdBK4UoZqfrgodQN17vCHHbN57jeVSkV3oRhm200N0ukjJc5+ue/T0CX5rTmjyhrujNS
	 tGstIcC5pYn1sO39rSar5SLbJ36FCxOepyStGxZ+N0/z2KkxkdhT/Ytu3ikFWMNozgED4
	 0kqe+xZ9RiR+GMW2iFAhuKDtnbCHwC3GPM0M7Ybou2AVOilo/4p5LZ2Ss+M8sb4YMnDxx
	 Qf9VCfreVI+iOGemF8Zj4PtlHkLufyd3r2eucMtDiv0pgDJS5hWAYt4CMa3oKsHGzI0pY
	 45342TGlS2W7ZE2/3qom+KckV6WR0EmgRrH4RRSyIpa2BCSvzctbnFB7DGR1e0+iPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6uqr42W;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F90606A32F
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F90606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6uqr42W
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be4fea434bso4024969e87.1
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 02:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826447; x=1795431247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=V6uqr42Wj5tCt2pj4NsxEWUA9ZPV2hJ8vbtfEJHqEWup61LERHaYBhxJtqUNRTqLwu
         xjS8Wcw1MkaEVKEW2FlvbzSlniIrC4yQncyGGWN7oyxOkcmIllBELJ3GHhZ1eM1mV5lk
         DtJy3osQM+taLpTs1LMUb0MlchzFAVsx54QVwlRbrGzDEGJzBoizYdOJWp0TP5ytlmXb
         ZS+NlW9pzXwzAy0GCVNgPoQfZt58VL4fpFeqUBnlW1PkKFGWF5lBPZcB22zzj37sQbBC
         aEV9U5r/FbgH2GaZXhpQgTBC8htE5gWHKQOlkUFAZMtEI5pCvGVxE1kfJ8ruW8PzjV1m
         EE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826447; x=1795431247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=QRamA+FhhVwNZUBHrxVOptOxLiSX1F3rSWGSyo4SFxauwUJeGGpy8N2qdTJdyV46fv
         /y8XNnF32eWs/32sb7K9Kp/nRUav8ei0fi49ZlnHpZ9EnufE4fplUhVTDXDa7znwp+70
         1yBu7ccCdmMN5wLkRtS3KGqzoOzNiSL663GsN9ye7TGWmDLBiFPj3H2VN/ebu+3VNOIO
         HWsxvAoUTcenELyaIe/+N88bacr35yAaTOcW63N0CL31LiVwAqyGM1+kzbUACgTIExQB
         wx2L+PmyaezWYs4E7Myz9SEGUN4Cz8OgX70Wl5ptqkNgssD26NL86RFhG34EWnYjTg+H
         Yy/Q==
X-Forwarded-Encrypted: i=1; AL+hErHsrWTxKGx4vVFIqpjlDNr1b9uZI9zzPYtzUr6Q7QbVb9JaQNxdcGOrbXm8pGWNZROD2UMpRWgC@vger.kernel.org
X-Gm-Message-State: APuU4Z/9KlAGOEjkT2BsPVhWv5iUz3hCMSIW7hRCQXArMRHxaOR4vZfg
	2CSH8ZZmAHVQxnZ8FkZcixnJ97HkKO0yV+DFz6q7mIBaCxflLF9pMGgA
X-Gm-Gg: AYBFou18yAzSC1BKPKAXTuF9kqBpArJWC8EEZXUqr72IcM7kM+WyuN8x4dInfREllAH
	qaG0UULWos18TuhDzEbny93iSi1TuL2g2UCCcPiZugEuUU/F1WTi8TTTn73toGVyBf1Qvrgi9ug
	EQYY4B2YC0u7t68Xm/Heg6ebS2uvirEbzeUxYWXHxo7f5uYikkNibAURSERkDb0snfgyzcdodem
	5P/67eYT25GkGr5IpU5C6dIYwLd/WsXnPI3Osu061Qsvk5Z5hUqX/EwQHSooaHTQFRKCA3MWJTr
	SjKCBzVJvbT/Tpi/W5YefqB1ll/EIzWclLon0LZ6XlA14axAqaxRKtdsRvUokQyy7LKcq7MiGq7
	XiKEYuvBr0pHmRqS57IbQxqDeu5YeOcRwYqWEY6/MvO/AWUSvbTLljoAHY+m8jVOnUaODubAW3D
	Muvqt3xImVbASNEN8wN1zceq6nVOXtZM1pbol++TndyuQFeDX1x5Lre8Yr1FjMm2K8tX8kCeX0O
	kF86mPoBrbUHcIwLbto5WbhMW4Ju5ypBvNOcPcTrT8U7Q2yBobUwL1iaUKFGbr4TBiFQN/SbXBr
	Xv3VUHUo+vMIKmqjWxTR
X-Received: by 2002:a05:6512:1322:b0:5c1:5b06:27c0 with SMTP id 2adb3069b0e04-5c170731f7dmr3105250e87.3.1794826447410;
        Mon, 16 Nov 2026 02:54:07 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133c663sm3069194e87.34.2026.11.16.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:54:06 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Kanner <andrew.kanner@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 17:53:54 +0700
Message-ID: <20261116105355.89902-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1df83cbf23a27174aee6ea5e52462f03f7e48a10 upstream.

KMSAN reports the following issue:
[   81.822503] =====================================================
[   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
[   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
[   81.824385]  security_inet_conn_request+0xc0/0x160
[   81.824886]  tcp_v4_route_req+0x30e/0x490
[   81.825343]  tcp_conn_request+0xdc8/0x3400
[   81.825813]  tcp_v4_conn_request+0x134/0x190
[   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
[   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
[   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
[   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
[   81.828174]  ip_local_deliver_finish+0x259/0x370
[   81.828667]  ip_local_deliver+0x1c0/0x450
[   81.829105]  ip_sublist_rcv+0xdc1/0xf50
[   81.829534]  ip_list_rcv+0x72e/0x790
[   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
[   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
[   81.831064]  napi_complete_done+0x2c4/0x8b0
[   81.831532]  e1000_clean+0x12bf/0x4d90
[   81.831983]  __napi_poll+0xa6/0x760
[   81.832391]  net_rx_action+0x84c/0x1550
[   81.832831]  __do_softirq+0x272/0xa6c
[   81.833239]  __irq_exit_rcu+0xb7/0x1a0
[   81.833654]  irq_exit_rcu+0x17/0x40
[   81.834044]  common_interrupt+0x8d/0xa0
[   81.834494]  asm_common_interrupt+0x2b/0x40
[   81.834949]  default_idle+0x17/0x20
[   81.835356]  arch_cpu_idle+0xd/0x20
[   81.835766]  default_idle_call+0x43/0x70
[   81.836210]  do_idle+0x258/0x800
[   81.836581]  cpu_startup_entry+0x26/0x30
[   81.837002]  __pfx_ap_starting+0x0/0x10
[   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
[   81.837979]
[   81.838166] Local variable nlbl_type.i created at:
[   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
[   81.839078]  security_inet_conn_request+0xc0/0x160

KMSAN warning is reproducible with:
* netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
* CONFIG_SECURITY_NETWORK_XFRM may be set or not
* CONFIG_KMSAN=y
* `ssh USER@HOSTNAME /bin/date`

selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
but it will be passed to:

    err = security_net_peersid_resolve(nlbl_sid,
                                       nlbl_type, xfrm_sid, sid);

and checked by KMSAN, although it will not be used inside
security_net_peersid_resolve() (at least now), since this function
will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
SECSID_NULL) first and return before using uninitialized nlbl_type.

Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
[PM: subject line tweak, removed 'fixes' tag as code is not broken]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 security/selinux/netlabel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 6a94b31b5472..e5af391023ba 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -195,6 +195,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	struct netlbl_lsm_secattr secattr;
 
 	if (!netlbl_enabled()) {
+		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
 	}
-- 
2.55.0
