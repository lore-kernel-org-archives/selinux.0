Return-Path: <SRS0=rnPm=BE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98107C433E1
	for <selinux@archiver.kernel.org>; Sat, 25 Jul 2020 16:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698C1206D7
	for <selinux@archiver.kernel.org>; Sat, 25 Jul 2020 16:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArR6Ibv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGYQ7Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Jul 2020 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYQ7Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Jul 2020 12:59:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BCC08C5C0
        for <selinux@vger.kernel.org>; Sat, 25 Jul 2020 09:59:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q6so13027534ljp.4
        for <selinux@vger.kernel.org>; Sat, 25 Jul 2020 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAA0JaeMfN91avIbAS4kWdrKVctkl5UeFLqKebT4m1E=;
        b=ArR6Ibv7PyObYxv4eFpb3wHz9FTlEM8+kqRYvvOGmGVeYIm3WVtRkaSJK05zOwJrqD
         eQi3HIPt3gWExvOzJsQ9DvOl30RYLcIAALA+DVU2H5RnMdaOG+eIAGp+KUOKB5sFBSQX
         BR5CyDjigweQt6onRaVXdEHKbAAZYuAbrdcBhRM4dz9QHd7LANdOREMf68ya3x2yZeac
         FJu3AOnJoi/0Zd2DaWy8pE616v/r94wEqiSBJDPJVXJpjkn2tJ3u7qvHbmsMDa9SoTzk
         5UdgvkqF/XgJqPw3pgzrzQpk+JSXoxXLh9ne7hnBwcs0ljezbNkkAyDXtFwvkVD2tsKL
         OLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAA0JaeMfN91avIbAS4kWdrKVctkl5UeFLqKebT4m1E=;
        b=CWfdTc95NP3N647xzUPqj4pFAT3n8LK/wWvL4PRUGYA7Bts146e+v3lB2IEObUPFtd
         PFvwOFH3BvzwTCZo1OTBs1vR5Fiqrg/+Zr181a+9dQFtzXSmsT6qCqa92U7TH4Q7EGTP
         6D2uenvF5wGt4yhtIrsSZodICvwLl11BrFkV1RgXW5LbmrRs/hw0L7IMA6kXAjgplBwd
         A5+FmJBxWolaT7NkYBFZmolVWDhjMuzGutDJTzNXRqqXi8H2q5Q95fd6cOBnLRJFbRVp
         olnhhsUWePi9p9suS0KcwHfwS2hw7LGWGlnwMJSJ/dl3cCI/c6Lw7LVvAkNLxGKnk3fW
         dlNw==
X-Gm-Message-State: AOAM532SnvG/mZ60ohA8/zelInFsU5LPVwEs/NPD076qUWD0rRGVgpOg
        vlWJzPCJpY06lBuy/d5jHSNmsQQT
X-Google-Smtp-Source: ABdhPJwRulFGojfXLYR/sLoZayMPJa+Ic3c/GTiBihkpd8AOTbcK5OFbFQXfhWANONFMojXxjVHaPA==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr6191847ljg.339.1595696361853;
        Sat, 25 Jul 2020 09:59:21 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 202sm1487573lfg.24.2020.07.25.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 09:59:21 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] Improve network_support.md
Date:   Sat, 25 Jul 2020 19:57:21 +0300
Message-Id: <20200725165721.4964-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

List all access control methods available for networking and provide
examples for each.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 src/network_support.md | 170 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 149 insertions(+), 21 deletions(-)

diff --git a/src/network_support.md b/src/network_support.md
index 309e863..a01ca3d 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -1,20 +1,17 @@
 # SELinux Networking Support
 
-SELinux supports the following types of network labeling:
+SELinux supports several methods for access control of networks. These are
 
-**Internal labeling** - This is where network objects are labeled and
-managed internally within a single machine (i.e. their labels are not
-transmitted as part of the session with remote systems). There are two
-types supported: SECMARK and NetLabel. There was a service known as
-'compat_net' controls, however that was removed in kernel 2.6.30.
+* Packet labeling: class `packet`
+* Peer labeling: class `peer`
+* Interface control: class `netif`
+* Network node control: class `node`
+* TCP/UDP/SCTP/DCCP ports: class `port`
 
-**Labeled Networking** - This is where labels are passed to/from remote
-systems where they can be interpreted and a MAC policy enforced on each
-system. There are three types supported: Labeled IPSec, CIPSO
-(Commercial IP Security Option) and CALIPSO (Common Architecture Label
-IPv6 Security Option)
+Networking support is not enabled by default. It can be enabled either
+the policy capabilites or by loading SECMARK rules.
 
-There are two policy capability options that can be set within policy
+There are three policy capability options that can be set within policy
 using the `policycap` statement that affect networking configuration:
 
 **`network_peer_controls`** - This is always enabled in the latest
@@ -37,8 +34,22 @@ The policy capability settings are available in userspace via the
 SELinux filesystem as shown in the
 [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
 
-To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
-be installed:
+SELinux supports the following types of network labeling:
+
+**Internal labeling** - This is where network objects are labeled and
+managed internally within a single machine (i.e. their labels are not
+transmitted as part of the session with remote systems). There are two
+types supported: SECMARK and NetLabel. There was a service known as
+'compat_net' controls, however that was removed in kernel 2.6.30.
+
+**Labeled Networking** - This is where labels are passed to/from remote
+systems where they can be interpreted and a MAC policy enforced on each
+system. There are three types supported: Labeled IPSec, CIPSO
+(Commercial IP Security Option) and CALIPSO (Common Architecture Label
+IPv6 Security Option).
+
+To support peer labeling with CIPSO and CALIPSO or fallback labeling,
+the NetLabel tools need to be installed:
 
 `dnf install netlabel_tools`
 
@@ -52,8 +63,12 @@ OpenSwan but is now distributed as LibreSwan:
 `dnf install libreswan`
 
 It is important to note that the kernel must be configured to support
-these services. The Fedora kernels are configured to handle all the above
-services.
+these services (`CONFIG_NETLABEL`, `CONFIG_NETWORK_SECMARK`,
+`CONFIG_NF_CONNTRACK_SECMARK`,
+`CONFIG_NETFILTER_XT_TARGET_CONNSECMARK`,
+`CONFIG_NETFILTER_XT_TARGET_SECMARK`, `CONFIG_IP_NF_SECURITY`,
+`CONFIG_IP6_NF_SECURITY`). At least Fedora and Debian kernels are
+configured to handle all the above services.
 
 The Linux networking package *iproute* has an SELinux aware socket
 statistics command ***ss**(8)* that will show the SELinux context of
@@ -65,7 +80,7 @@ to achieve this).
 
 <br>
 
-## SECMARK
+## Internal labeling: SECMARK
 
 SECMARK makes use of the standard kernel NetFilter framework that
 underpins the GNU / Linux IP networking sub-system. NetFilter services
@@ -73,7 +88,7 @@ automatically inspects all incoming and outgoing packets and can place
 controls on interfaces, IP addresses (nodes) and ports with the added
 advantage of connection tracking. The SECMARK security extensions allow
 security contexts to be added to packets (SECMARK) or sessions
-(CONNSECMARK).
+(CONNSECMARK), belonging to object class of `packet`.
 
 The NetFilter framework inspects and tag packets with labels as defined
 within ***iptables**(8)* (also 'nftables' ***nft**(8)* from version 9.3 with
@@ -172,6 +187,16 @@ table ip6 security {
 }
 ```
 
+Before the SECMARK rules can be loaded, TE rules must be added to
+define the types, and also allow domains to send and/or receive
+objects of `packet` class:
+
+```
+type test_server_packet_t, packet_type;
+
+allow my_server_t test_server_packet_t:packet { send recv };
+```
+
 The following articles explain the SECMARK service:
 -   [*Transitioning to Secmark*](http://paulmoore.livejournal.com/4281.html)
 -   [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
@@ -179,7 +204,7 @@ The following articles explain the SECMARK service:
 
 <br>
 
-## NetLabel - Fallback Peer Labeling
+## Internal labeling: NetLabel - Fallback Peer Labeling
 
 Fallback labeling can optionally be implemented on a system if the
 Labeled IPSec or CIPSO/CALIPSO is not being used (hence 'fallback
@@ -217,9 +242,20 @@ netlabelctl -p map list
 Note that the security contexts must be valid in the policy otherwise the
 commands will fail.
 
+Before the NetLabel rules can be loaded, TE rules must be added to
+define the types. The the rules can allow domains to receive data from
+objects of `peer` class:
+
+```
+type netlabel_sctp_peer_t;
+
+allow my_server_t netlabel_sctp_peer_t:peer recv;
+```
+Note that sending can't be controlled with `peer` class.
+
 <br>
 
-## NetLabel – CIPSO/CALIPSO
+## Labeled Networking: NetLabel – CIPSO/CALIPSO
 
 To allow MLS [**security levels**](mls_mcs.md#security-levels) to be passed
 over a network between MLS
@@ -288,7 +324,7 @@ section, plus the standard Fedora 'targeted' policy for the tests.
 
 <br>
 
-## Labeled IPSec
+## Labeled Networking: Labeled IPSec
 
 Labeled IPSec has been built into the standard GNU / Linux IPSec
 services as described in the
@@ -451,6 +487,98 @@ The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 
 <br>
 
+## Access Control for Network Interfaces
+
+SELinux domains can be restricted to use only specific network
+interfaces. TE rules must define the interface types and then allow a
+domain to `egress` in class `netif` for the defined interface types:
+
+```
+require {
+        attribute netif_type;
+}
+
+type external_if_t, netif_type;
+type loopback_if_t, netif_type;
+
+allow my_server_t external_if_t:netif egress;
+allow my_server_t loopback_if_t:netif egress;
+```
+
+The interfaces must also be labeled with ***semanage**(8)* (or by
+using `netifcon` statements in the policy):
+```
+semanage interface -a -t loopback_if_t -r s0 lo
+semanage interface -a -t external_if_t -r s0 eth0
+```
+
+Note that reception can't be controlled with `netif` class.
+
+<br>
+
+## Access Control for Network Nodes
+
+Domains can be restricted by SELinux to access and bind sockets to
+only dedicated network nodes (in practice, IP addresses).
+
+The node types must be defined and then the node types can be used for
+TE rules as target context. TE rules to allow a domain to `sendto` for
+class `node` and to `node_bind` (for incoming connections) for class
+`tcp_socket`:
+
+```
+require {
+        attribute node_type;
+}
+
+type loopback_node_t, node_type;
+type internet_node_t, node_type;
+type link_local_node_t, node_type;
+type multicast_node_t, node_type;
+
+allow my_server_t loopback_node_t:node sendto;
+allow my_server_t loopback_node_t:tcp_socket node_bind;
+allow my_server_t internet_node_t:node sendto;
+```
+
+After the types have been defined, corresponding node rules can be
+added with `semanage` (or `nodecon` statements):
+```
+semanage node -a -M /128 -p ipv6 -t loopback_node_t -r s0 ::1
+semanage node -a -M /3 -p ipv6 -t internet_node_t -r s0 2000::
+semanage node -a -M /8 -p ipv6 -t link_local_node_t -r s0 fe00::
+semanage node -a -M /8 -p ipv6 -t multicast_node_t -r s0 ff00::
+```
+
+<br>
+
+## Access Control for Network Ports
+
+SELinux policy can also control access to ports used by various
+networking protocols such as TCP, UDP, SCTP and DCCP. TE rules must
+define the port types and then allow a domain to `name_connect`
+(outgoing) or `name_bind` (incoming) in class `tcp_socket` (or
+`udp_socket` etc) for the defined port types:
+
+```
+require {
+        attribute port_type;
+}
+
+type my_server_port_t, port_type;
+
+allow my_server_t my_server_port_t:tcp_socket name_connect;
+allow my_server_t my_server_port_t:tcp_socket name_bind;
+```
+
+The ports must also be labeled with `semanage` (or `portcon`
+statements):
+```
+semanage port -a -t my_server_port_t -p tcp -r s0 12345
+```
+
+<br>
+
 <section class="footnotes">
 <ol>
 <li id="fnn1"><p>For example, an ftp session where the server is listening on a specific port (the destination port) but the client will be assigned a random source port. The CONNSECMARK will ensure that all packets for the ftp session are marked with the same label.<a href="#fnnet1" class="footnote-back">↩</a></p></li>
-- 
2.27.0

