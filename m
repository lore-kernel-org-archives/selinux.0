Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826430;
	b=dOeoVQz0rCX2hJyAjErldWcH13XYFgHviWioqqgU28lAEhgEEOftw/tRyYlT8MU7T3ad
	 VlsUbc1+xjr+JIraJpjehqCr9+tsWwYdEwA/VQGEq9EBJYYzxbG0SnPDy69HLgLWXPKm3
	 23+fnSKZhO7bcdKJo0nzmmfNdzI7RK7NWBxc8ADMs1AoBC5JEaRRYMVUgflYgvReiSjlA
	 MRgnH14RpEkeSiEFZ3RtO3NIcV//VGNRaUb4XatZsnKNCjpwJ3YZ9myEOniffKQsRK6el
	 XQPaYMUn89U9PfdCOXMpdPaSQ7egLvwQQVHhwgDtU2t4r6zDvt8QS0MUXm3UjqAl2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
	b=PCY3ki219mW7DXxGBjz9Mx6xdD+QXPRYBh8lXjFZFGvCCwvEe/M1dki/zAAqMlW1EY5Z
	 EzWg+HhCECYTyk8L7dRByxM0IBwUMRIYnI9sl2xlmjbyUxeX+O1hX92aEam0LodbiWLlW
	 3HJd9MFWxszk2frfstAI5yRa51VpwNAqzl/29mYMuIHlNyFYBwERYQTXAxp1hxTLGH7j6
	 AKZnOvT9xco/aZbApB7gwwMx5naUXA+/v/qSczJ1KukcVwiEIzJbYGAPPgabgBsV/fzwe
	 eTqFi6mIhSkHSdoZjXvNaj/6R85/TyQOZkG9uk3KZYMSfjnjVm9qOnycEb1GzgZ9jEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HoZT4au9;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A9606A33E
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 10:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71A9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HoZT4au9
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so3545201e87.1
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 02:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826428; x=1795431228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=HoZT4au9qzAEswBsmTugwBXmASMwENaAUHQKmqUeoMsFemp059HKPKC7CTPYIuem+W
         ywS7IszCjKJmb1QZiIrGMcBpZ0/ihMwadbUFK9WYyogd6g4NkdO2vqhE6sGns6rRU1JG
         aoNY+FPNufZ60sUVIJfw9RMHYgq6dWirwFO12PJCzJrB5iPFh4cgTEm6l8DQdkGklAjC
         9OJsIQStbdpdPVrKROBD0BvvvuCyeFyIuEQh+XwTeQIHBrqZT9zN7LpIcx/vpuMzn92r
         F0Njg62kQO0MquH/L5CzEi6vWJIi5IDBNeWgpQlKDeQG5auxH1TGBOGtrPKjybHRpLLA
         2x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826428; x=1795431228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=Aa5AWVfh4L/3Ml5qzw5PmMdy/Y+FgfuVEgWNg9TqSN9wUOdlrA+4+Y+RfuvH6mDJ1v
         D1LJnKTCrqTg55a9UoU2CvUH8ZatHNH/3n+4yHEbJ6fKe3oxeOJFOos7I6IhMndSLXNm
         wyOziw5oFbZqgxe5EAptOnjzurtQta2bHrmNOGI1bQIumo5/HfLT7L9PiIcljUE1o35O
         X65b0H04dciyUCOeBkMUvhqF1H0cO3vaW/fnB8Es/v77acBh5Q3ZBtwc7NvTntMOVKO0
         xwug8yPRFGU/Z9PjwCMFqHkOAIN5Nq9uFiNhQB6Ma+7GPKzLZDgWiHdtd4mSWG11g8C2
         7vlw==
X-Forwarded-Encrypted: i=1; AL+hErEvpL2pOljyNFJzNKkNA6OksvDBu5Tg+EB792xhKMKFxm6zD5t4MfdYaLm4qbQV3hXhs83K5B9M@vger.kernel.org
X-Gm-Message-State: APuU4Z/NV2GKmweaLsxIGRy/VRyyYrw0AmlUZ2fEnsnfsS08ibhDImEr
	ndgazlIj+zt6SOFhNNZnH30IFBwDZ4e3CnsltmuW/Pa+bO3Qk7TiOuD2
X-Gm-Gg: AYBFou3CQ0Byk64bJkJtxz/3sx7kLa9XFJUEHOTHA2dmmdZcBifyiD2l4Q8CUlmbJBT
	roplM+szXdED7YeoA1++lAecKUeihVNCQ1A79B13XVNJqM0JaQffYJLhaU049Tx8or/qnZIPEJE
	zp0fQ9b9rf679Qg+Kx+OkLqzm7GV7aTXxpnrEuH4l/EOgl4TzT1O0ubZO44mYY+XXtckX26lQpz
	JGjiKOSTwLaJ/lzfypnszi6DFqhcMFCgJZYIV8NMnIlgKkNc3YRtTsaqGkE4+R6KKCk39M3Cn60
	5dDTsKRjy3+sZYFwy2X/3mWcVtmxgbE3uu3N1SUVKwDocT3Per95HZPXBIJC38suqeRrgVGEJGu
	YuUrVUHIQd+oMmo4hDISSE1Gk5hZgoExUp0+UNKCxYsfSEW7iqdXqJ2Mmfo8LQEpWsPWtUYjx1D
	OeMwBirZ0W9z1yEywSUXpNeGoVaG+9LH5ItiQhLpmjmf1TGWPWV2sEAnx3g/1i7Fz48IEt376uu
	VVhWjEZQ656pZdsd4sQIk3rmlVIR2ZBjP38MdXmHkEkZdMx0axXxgLCncvngNUPzBWIs299AijZ
	OJcS1nAe7q2aVQuUAv9Q
X-Received: by 2002:ac2:51c9:0:b0:5c1:4cc6:718f with SMTP id 2adb3069b0e04-5c1709c9d8dmr3878682e87.41.1794826427819;
        Mon, 16 Nov 2026 02:53:47 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17135783bsm3089904e87.79.2026.11.16.02.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:46 -0800 (PST)
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
Subject: [PATCH 5.15] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 17:53:32 +0700
Message-ID: <20261116105333.89809-1-petrvaganoff@gmail.com>
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
