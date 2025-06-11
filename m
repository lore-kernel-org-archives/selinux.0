Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B837380
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666845; cv=none; b=EppBdaDdHLTzqhA7wZ5VIsA2JYb80OKnFwXK9OgCDokp5dTeb7qiC9BnQ2iLFIyOGEy9/gC/NWSkCWo7okkIauP8zPztVam1NkivTI0w1aFRM7EW7KMzq0LbcDO3itK4jxRlBnYVyrmpVYIHCLIpISAimLSp3EM0cS15tAJyTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666845; c=relaxed/simple;
	bh=0b0d0R611nmo7/DWaRruMpqhTeBrFyWvcwuZ04I14Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhS/Qe+4AzFXZ4z4LIzN+kOwyYDR8dDBJ6f0I8t1WflyjR8VobRVdCeI3BYvwSsg7KIOSSkzymlMO4vP0wYZHnYNdBmSrS/WL4rOdEuf0gu8OyIwl2UFNe7CiVGfvbuqbmTE4AfyZirPQO7Jk57QAyK2+BmWzrINs3/gaLV3B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loh8jKiE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loh8jKiE"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a585dc5f4aso2656391cf.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666843; x=1750271643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8F2qR5+g0Q9lnBGzxwNoRnkOjSPiR7WYmRBHYVm6og=;
        b=Loh8jKiEhYhJirVkhamVoGWvOl75sQMW5qfkuEmPUXVs/loOJph3w5pR0si5y9dlFd
         V7GLJXRiZKUGO9au7uDHCNFbl1B3NcMoeGRjttgi1Toi0LlqqDtDwjZxKzWeTN4gxRb3
         AbP/YkiR7Kwfr+M0CljamTY+ihgzCfQ4kEWU9sKLfZEDKKYfip1Ru9dYFhED4JuMOXhM
         94PDcT4jA4GKx6NehV+VA32/Sg4mUqRaIplQUzwrtW+fTLNpCi2Zr+OGRCDtWUlFHVef
         GwLBSpa/QfJGhgO+0fSaZWRdwKZsfCfSYs9CoXk/r80/XC4kFBw/3Qu//PeT8P++zG1j
         +Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666843; x=1750271643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8F2qR5+g0Q9lnBGzxwNoRnkOjSPiR7WYmRBHYVm6og=;
        b=c8BCYxnUyCMwpSMxmAFTGMQX387Hy+JwqkpcmTU0YovGhhb/M2T2wtKybMaJQxhctR
         hvXf0wycCqwrFimO7xN1WwNcMDfKJ+Vszc1BjQoliSPPWqtz0ekfcOvHrkO1LW023PJ+
         wtejweeN0ZwytVz5YRdZTlOFUXZUKaa1i6aobeizbMeckHBV6JR6cXPlirKL7sYpsIZd
         +1p6QcE2LVIL2IkgfL4HdTOCoGlvv5mNa7jPwDNHJ2/7dAde6CJnJQqmLH0PoCc0jR1r
         mu8x6Q5c0rJmo94rUBcehSgjjHGGo03ZRI4Xdvy3L0ErXRRjJCSyeIiuEzzGxmFH4AZ6
         v3Gg==
X-Gm-Message-State: AOJu0YyyRWmphs337nLn5Y/4C4TyDCzwGiay0i3Nval4AgFw3sjU7j8L
	kXWj+yIesmYbX4fIFhS1PtjjEAXEF/QFaGOVIxyNpYyd1ErzQDtnKRLG2alxdQ==
X-Gm-Gg: ASbGncvA+nt3w89MC35DIFifqaY3zEGZlwlz8hyoSUpHNMMSPPEG7UnziTAf9tp0q9H
	9RSCSoa7E2+zCDiU0PDPqdbRF8a/xqqWW8jO7IxdLvnwrR2xWjmp5L12Gxghvhm96udv5Jl5t05
	SsEKB1nkyqPr/Wb/906hYZNd4O1Xv5VUUqDXqYsoC544lgm10UT70O+hulIp/aAqNu9ivHOwo34
	gYR7IpvR5VoDYxkoWwmlB0lce20nahA3yYFy7mcjwhofVOdTo35zYCn90TQOx+9cgdYCWhjYvXs
	xIdbVjmDVy4EMY7bh6vZcC39NqFVVHO0hfHgtVGr0aoBRZyCQ2SPgXLcJsev3fmilPDUyJvIFlD
	pi/VkKhPpyW1LHLDh85x9fq5O9Ldyjw15+FEqZNWaQrZ3A01jIZbtcG1DIqcZQ00iW66P7HwA7k
	gc7+BrNTRJFmSv0xpEl3EX7T6WQQ==
X-Google-Smtp-Source: AGHT+IFu+FDiKkh1Iv+XJqlB2wKMJgqtCaNXea4gtm+HwnjWMib2m4jdkURLGm2frfwszVnTIvBzmA==
X-Received: by 2002:ad4:5f45:0:b0:6fa:bba5:c617 with SMTP id 6a1803df08f44-6fb2c3284cbmr78594706d6.10.1749666842512;
        Wed, 11 Jun 2025 11:34:02 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1cc03sm85260986d6.75.2025.06.11.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:34:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy when appropriate
Date: Wed, 11 Jun 2025 14:32:35 -0400
Message-ID: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On F42, iptables and ip6tables are no longer provided; check
to see if iptables-legacy and ip6tables-legacy exist and use
those instead if so.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/inet_socket/iptables-flush | 20 +++++++++---
 tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptables-flush
index c168d89..a8cbe04 100644
--- a/tests/inet_socket/iptables-flush
+++ b/tests/inet_socket/iptables-flush
@@ -1,6 +1,18 @@
 #!/bin/sh
 # Flush the security table.
-iptables -t security -F
-iptables -t security -X NEWCONN
-ip6tables -t security -F
-ip6tables -t security -X NEWCONN
+if [ -f /usr/sbin/iptables-legacy ]; then
+    IPTABLES=iptables-legacy
+else
+    IPTABLES=iptables
+fi
+
+if [ -f /usr/sbin/ip6tables-legacy ]; then
+    IP6TABLES=ip6tables-legacy
+else
+    IP6TABLES=ip6tables
+fi
+
+$IPTABLES -t security -F
+$IPTABLES -t security -X NEWCONN
+$IP6TABLES -t security -F
+$IP6TABLES -t security -X NEWCONN
diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables-load
index 5be94f4..83ca966 100644
--- a/tests/inet_socket/iptables-load
+++ b/tests/inet_socket/iptables-load
@@ -8,42 +8,54 @@
 # - Specified the interface since the tests are only performed over loopback.
 # - Set the port number and context to the values used by the test script and policy.
 
+if [ -f /usr/sbin/iptables-legacy ]; then
+    IPTABLES=iptables-legacy
+else
+    IPTABLES=iptables
+fi
+
+if [ -f /usr/sbin/ip6tables-legacy ]; then
+    IP6TABLES=ip6tables-legacy
+else
+    IP6TABLES=ip6tables
+fi
+
 # Flush the security table.
-iptables -t security -F
+$IPTABLES -t security -F
 
 # Create a chain for new connection marking.
-iptables -t security -N NEWCONN
+$IPTABLES -t security -N NEWCONN
 
 # Accept incoming connections, label SYN packets, and copy labels to connections.
-iptables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
-iptables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
-iptables -t security -A NEWCONN -j CONNSECMARK --save
-iptables -t security -A NEWCONN -j ACCEPT
+$IPTABLES -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
+$IPTABLES -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IPTABLES -t security -A NEWCONN -j CONNSECMARK --save
+$IPTABLES -t security -A NEWCONN -j ACCEPT
 
 # Common rules which copy connection labels to established and related packets.
-iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
-iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+$IPTABLES -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+$IPTABLES -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
 
 # Label UDP packets similarly.
-iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
-iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IPTABLES -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IPTABLES -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
 
 ##### IPv6 entries
-ip6tables -t security -F
+$IP6TABLES -t security -F
 
 # Create a chain for new connection marking.
-ip6tables -t security -N NEWCONN
+$IP6TABLES -t security -N NEWCONN
 
 # Accept incoming connections, label SYN packets, and copy labels to connections.
-ip6tables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
-ip6tables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
-ip6tables -t security -A NEWCONN -j CONNSECMARK --save
-ip6tables -t security -A NEWCONN -j ACCEPT
+$IP6TABLES -t security -A INPUT -i lo -p tcp --dport 65535 -m state --state NEW -j NEWCONN
+$IP6TABLES -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IP6TABLES -t security -A NEWCONN -j CONNSECMARK --save
+$IP6TABLES -t security -A NEWCONN -j ACCEPT
 
 # Common rules which copy connection labels to established and related packets.
-ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
-ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+$IP6TABLES -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
+$IP6TABLES -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --restore
 
 # Label UDP packets similarly.
-ip6tables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
-ip6tables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IP6TABLES -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+$IP6TABLES -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
-- 
2.49.0

