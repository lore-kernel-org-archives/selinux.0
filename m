Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727BC38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEFB21841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ee7qp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgEHPmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEHPmW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44881C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h26so1577431qtu.8
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqlUQ42EQuHL6hyerrfrKlD9To52zXfk2WGJ3servuU=;
        b=I0ee7qp12MtI2MJDo3o7H/4isBqPJVuC1SI6SEnqL2Xw4lQ+u6rrw2YfZD+NFylvFS
         EpqdoYxUsfArwwp7MWBmOepsvYfajuuzN/IUVeubQ+Ko4qDUOO+xMCF6Y1wPKQBxeadM
         1iKaK19qSbKV6cmfRC6P1PPIx2pxzx7LtcnEVqvKSDxryvgP99iK9ROM3NqEn9F1kV24
         7OZwdB59rlBUlN1ZrCP7/G91E/S01HmEC0h9MemeseRJJWSbG82Vt2TzltEzarcLOOoU
         zdDzBQ9hFt1F/xZBZb6sLBb8PJDxhdJvIgNY1CETZvKFFldoYxx6+QbCj/zRRU+daXhE
         j4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqlUQ42EQuHL6hyerrfrKlD9To52zXfk2WGJ3servuU=;
        b=kcqM0rrk+NEtxknPfVjiuCUkYMK9fVEl3AKcaAbbO551OrSZmbs3qTJZkUXNL6J/7/
         w+BaGiHD+8vaUZxO1t62k/DISpRFtZsJ9WDr0bJPQS9sXxaKUCpdA483YCxyH05rjUBa
         C4jLfzU7Yl+Gbnyx8d5ZQYT6s6FLb90b6cadrfcAIF1bctVuXuyC6praS7LzWwNJKebA
         CQd2O/yxOzvsLKKGYywGM7f6NqbhCYz00newE9TVNt1OaDK0BiPW7RaM7HYsY+tdaZyH
         efBlz5uLgQMzfymsLP5dx7iSKdpacWviYuyM0jYVYbVL9+rRsyHrNa7zU0YwMSDW/J3W
         j5uA==
X-Gm-Message-State: AGi0PubjOMHT/Hcuq0ioCT5PViARXfgnxcqmlb7IEgIFRaPdz7Kxr6V9
        F1fQgNm/GQvCrzpqKv2f23Lr7rwf
X-Google-Smtp-Source: APiQypIR+5TxQGOLk+qYCIt7M0Tke/0xkSjrbOJHkwAH7+ez7Qh6KC357SbRb963dXB2xRTgRFhqCg==
X-Received: by 2002:ac8:4f53:: with SMTP id i19mr3784269qtw.195.1588952541276;
        Fri, 08 May 2020 08:42:21 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:20 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 05/15] test_inet_socket.te: switch from generic_port to _all_unreserved_ports()
Date:   Fri,  8 May 2020 11:41:28 -0400
Message-Id: <20200508154138.24217-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

bind/connect_generic_port() in Fedora policy was allowing access to
ports in the unreserved port range.  In refpolicy and Debian, it only
allows access to ports without a more specific type and one must instead
use bind/connect_all_unreserved_ports().  Switch to the latter since it
works on both Fedora and Debian/refpolicy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_inet_socket.te | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index bf839df..0fff2da 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -26,8 +26,8 @@ typeattribute test_inet_server_t testdomain;
 typeattribute test_inet_server_t inetsocketdomain;
 allow test_inet_server_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_server_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_server_t)
-corenet_udp_bind_generic_port(test_inet_server_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_server_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_server_t)
 corenet_tcp_bind_all_nodes(test_inet_server_t)
 corenet_udp_bind_all_nodes(test_inet_server_t)
 corenet_inout_generic_if(test_inet_server_t)
@@ -54,7 +54,7 @@ typeattribute test_inet_client_t testdomain;
 typeattribute test_inet_client_t inetsocketdomain;
 allow test_inet_client_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_client_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_client_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_client_t)
 corenet_inout_generic_if(test_inet_client_t)
 corenet_inout_generic_node(test_inet_client_t)
 
@@ -71,7 +71,7 @@ typeattribute test_inet_bad_client_t testdomain;
 typeattribute test_inet_bad_client_t inetsocketdomain;
 allow test_inet_bad_client_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_bad_client_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_bad_client_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_bad_client_t)
 corenet_inout_generic_if(test_inet_bad_client_t)
 corenet_inout_generic_node(test_inet_bad_client_t)
 
@@ -87,8 +87,8 @@ typeattribute test_inet_bind_t testdomain;
 typeattribute test_inet_bind_t inetsocketdomain;
 allow test_inet_bind_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_bind_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_bind_t)
-corenet_udp_bind_generic_port(test_inet_bind_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_bind_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_bind_t)
 corenet_tcp_bind_all_nodes(test_inet_bind_t)
 corenet_udp_bind_all_nodes(test_inet_bind_t)
 
@@ -111,8 +111,8 @@ typeattribute test_inet_no_node_bind_t testdomain;
 typeattribute test_inet_no_node_bind_t inetsocketdomain;
 allow test_inet_no_node_bind_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_no_node_bind_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_no_node_bind_t)
-corenet_udp_bind_generic_port(test_inet_no_node_bind_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_no_node_bind_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_no_node_bind_t)
 
 # Domain for a process allowed to connect(2).
 type test_inet_connect_t;
@@ -122,8 +122,8 @@ typeattribute test_inet_connect_t testdomain;
 typeattribute test_inet_connect_t inetsocketdomain;
 allow test_inet_connect_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_connect_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_connect_t)
-corenet_tcp_bind_generic_port(test_inet_connect_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_connect_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_connect_t)
 corenet_inout_generic_if(test_inet_connect_t)
 corenet_inout_generic_node(test_inet_connect_t)
@@ -136,7 +136,7 @@ typeattribute test_inet_no_name_connect_t testdomain;
 typeattribute test_inet_no_name_connect_t inetsocketdomain;
 allow test_inet_no_name_connect_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_no_name_connect_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_no_name_connect_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_no_name_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_no_name_connect_t)
 corenet_inout_generic_if(test_inet_no_name_connect_t)
 corenet_inout_generic_node(test_inet_no_name_connect_t)
-- 
2.23.1

