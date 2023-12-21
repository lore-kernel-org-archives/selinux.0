Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2078E60
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QgZWKxVL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7810827e54eso77852185a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197570; x=1703802370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3jW3MoNnfjfkHjw95ZrPZI3q4R3FgMhO0U/voIpiS8=;
        b=QgZWKxVLqjDGXXPtHXN9u6V2r3pJc+zxrvy4fqRDQClQRNPaO5gBky6LO8q0SlLbt5
         wgsekQdJZ6Kikn0MQPxaBJiQu5+Sdp5vwBJHmT2J7ArQo8OUDrWRw7iRyoV4JW0W+kaY
         jvreFIrMF0QLs8mPcqR8TG17vfvYi7DiYR+oEZlJxg9vO5iZEwnSx3kHzD7K9DLmIXnl
         BR2kHgmhDGhmma6JUUZpKtOs90k7Zq7tGFwTU0ynj1HR+tITBpvtNjqnafqcIY3XTmo7
         ZTekoNE+U2/bnR0l0caswxv6DC8KDjSW79fF3v7OQu7iqdOzlT8alKNa2ZaL4xXTxo1V
         Jltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197570; x=1703802370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3jW3MoNnfjfkHjw95ZrPZI3q4R3FgMhO0U/voIpiS8=;
        b=s7kZun5UGaUKIRi/JkFYF68q1k7Lncu221m2Ck6ehYC6rnzn/1f4/3IW4YGiHww3v3
         ZcDPOzZM/nfIKeuMGoF7+E8sjhnZqrtATR4jwThbqhHr4aOPs1TAI5xMNFtN11k48p8r
         lwQRfCYcqOzYQmFruUeCJbnlcmac4oKjQ0mKy+iIIWrJfrreyojiAiFlB60+RULd3tpy
         qm2ssY920rOajBd0Srb6Q9PJkxIE8rb1dtYwyez84w8s6Fp89Ipf3tmnJ7ZNsVFRlVoI
         +T8AnhW4YZSLtgqr9GUCEBSuBJkRjgbPyuDEQdoSmk9Hpcv4t7eSGLA50hYUAxyYGFk4
         OPkQ==
X-Gm-Message-State: AOJu0YzvLxC+R7C9RweO9dzqs9AiMxP3PG0ba087xHmi+fkYpR0eIgHz
	mHOkOBqbMwOz9yJTQkMvl0Y5EF3om8Kn8qD1vI6bGw/egQ==
X-Google-Smtp-Source: AGHT+IEmgB5AZw/OKlxn6OLDcsFCncJlax+72eKyNu/KOoWeKg3XTQcEWtgsveBX0O207GiQSfwPxw==
X-Received: by 2002:a05:620a:400a:b0:77e:fba3:9d04 with SMTP id h10-20020a05620a400a00b0077efba39d04mr668605qko.104.1703197569748;
        Thu, 21 Dec 2023 14:26:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b0077f103c8ad6sm942982qkc.82.2023.12.21.14.26.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:09 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 09/15] selinux: fix style issues with security/selinux/include/netlabel.h
Date: Thu, 21 Dec 2023 17:18:52 -0500
Message-ID: <20231221222342.334026-26-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4741; i=paul@paul-moore.com; h=from:subject; bh=Fp4WwHqZ19wmjUkTCELEuDjk/zfZqa9XrsWcd4dEYio=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtHVhOlEE6EEnvkeVgbV+1nArccSj2e8DpX6 5uIBhs7U9GJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7RwAKCRDqIPLalzeJ c69VD/94hdWT5Bi5H021wKkZ7jkyy/bmj2HxfDWcxZ8OCW+8F/RbMOFzCMFcO7PdJpXthBD53ik qBKoZubnQWI7UfjOpBvl884ytpHszMWwe6Ba7F+671puAjxzQk5QuftpcKzSpZFRJzb8kC3TjHV HBVTnI4XIF1su7LzIb7SHKpzT4AhUHYPjoKDYXCYKcYkMH4WPGjwbUb5ebpK49Tr3/+pZrJSGux mXQTp7edJRUBZeYkGUtumcmBY5IkRtLrRHLeIQaWq5i8nnrIJ6/nQmQ0+RA5JVClAj+andET5GX bOT8Ensa0bcTobhKVy335FAvRfmoh1+nzW77E8CSV574wGuHn5Y/oHwW5f3TbcXWv1XIEIb0rMM bA+XBbwHJK+B9nwazClLld9FdOWelfgQ3haSJp6yqVAdl6YnlknBXVhqoeG4OSEZC65Q5zJlXzl fmoeH3f5ZxkVsh/MqPKp3Cd6gfscCY/zSEHIMNVfOBBC4Qgek/YcY76ZT9wVXCQiZTBY28gCFVb Fdel0hKzCdHcKPGy6Fm2ZqvMddOwQOR/yHFCKcla9eJ7s//CurxZROU1zMRcX2m2GcfQF8+ct0P 4RQYCxRURL5GxppQFYeAButUKFH0ITxPV3QVYNw9iW4y7G4QrnU+tmyiCQEWVjMaygjhmFrQZbf m5kHyIKO/pJcJ6A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/netlabel.h | 53 +++++++++++------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 4d0456d3d459..5731c0dcd3e8 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -32,25 +32,19 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error,
 void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec);
 void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec);
 
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
-				 u16 family,
-				 u32 *type,
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family, u32 *type,
 				 u32 *sid);
-int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
-				 u16 family,
-				 u32 sid);
+int selinux_netlbl_skbuff_setsid(struct sk_buff *skb, u16 family, u32 sid);
 int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
-				     struct sk_buff *skb);
+				      struct sk_buff *skb);
 int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family);
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family);
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk);
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family);
 int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
-				struct sk_buff *skb,
-				u16 family,
+				struct sk_buff *skb, u16 family,
 				struct common_audit_data *ad);
-int selinux_netlbl_socket_setsockopt(struct socket *sock,
-				     int level,
+int selinux_netlbl_socket_setsockopt(struct socket *sock, int level,
 				     int optname);
 int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr);
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
@@ -62,44 +56,40 @@ static inline void selinux_netlbl_cache_invalidate(void)
 	return;
 }
 
-static inline void selinux_netlbl_err(struct sk_buff *skb,
-				      u16 family,
-				      int error,
-				      int gateway)
+static inline void selinux_netlbl_err(struct sk_buff *skb, u16 family,
+				      int error, int gateway)
 {
 	return;
 }
 
-static inline void selinux_netlbl_sk_security_free(
-					       struct sk_security_struct *sksec)
+static inline void
+selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 {
 	return;
 }
 
-static inline void selinux_netlbl_sk_security_reset(
-					       struct sk_security_struct *sksec)
+static inline void
+selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
 {
 	return;
 }
 
-static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
-					       u16 family,
-					       u32 *type,
-					       u32 *sid)
+static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family,
+					       u32 *type, u32 *sid)
 {
 	*type = NETLBL_NLTYPE_NONE;
 	*sid = SECSID_NULL;
 	return 0;
 }
-static inline int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
-					       u16 family,
+static inline int selinux_netlbl_skbuff_setsid(struct sk_buff *skb, u16 family,
 					       u32 sid)
 {
 	return 0;
 }
 
-static inline int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
-						    struct sk_buff *skb)
+static inline int
+selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
+				  struct sk_buff *skb)
 {
 	return 0;
 }
@@ -117,21 +107,18 @@ static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
 {
 	return;
 }
-static inline int selinux_netlbl_socket_post_create(struct sock *sk,
-						    u16 family)
+static inline int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	return 0;
 }
 static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
-					      struct sk_buff *skb,
-					      u16 family,
+					      struct sk_buff *skb, u16 family,
 					      struct common_audit_data *ad)
 {
 	return 0;
 }
 static inline int selinux_netlbl_socket_setsockopt(struct socket *sock,
-						   int level,
-						   int optname)
+						   int level, int optname)
 {
 	return 0;
 }
-- 
2.43.0

