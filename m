Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2587C433E3
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03632075A
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3R2nv2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgG0NEi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgG0NEi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 09:04:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E0C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:04:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so8937109lfi.13
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlupxlkq0pqh1DfdbrrX4ZnUZKoXNMCoLuL11rEBHz4=;
        b=P3R2nv2IAIaLJ0UbxaOfT6VfwpZzCEpOVz2nc5f3eIjcoqFc3Gi6LtXiJdGqLfsB7q
         iLzU6ge3B/SOs6A5A/LhwfmEtqRH6Y+mkL8bfBC240Hgy8M6GAr4bjMxfU85RlCyNViu
         EnmZAYBctB0ntK3yq44fZfgaqsWwEafnLEBJ4osozrK4uZRcwAmt3uLGCJmHW/4TnDY3
         WvU+F6LLvHsSvkKuY9NItYh2rCbc6dpCu8KN7Vi0FrPTaf3ei0DDBFCf0hsLDo9nh86k
         m4yIhnE/1yYq8hOWOe+sbmSIGGRi93ouswVZZq18qnHeId6+E1/QHvTQcXFQRLFPTNzW
         aatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlupxlkq0pqh1DfdbrrX4ZnUZKoXNMCoLuL11rEBHz4=;
        b=YsWMg0Oc+56inqxs/xm9yWkJz3Z/pgptmr4Lh5pSk2Azl5eZ4TInxqdh/snM/cIa6j
         iaeYJLziW5L902nQK2YPUkJSqkSeQus5X/yXQvPgFlqyT5x6X6o/EOYMn873v/SO93sR
         A8oVEYBntqJ1DURLoSmiN2+3FPraH99sIK33+bKl85MNuqH43uK+rHwKYgwFaWZeQIPo
         mqkIzUkBAhwetunhstmeyLN4spoulNW0woXz3G6w+PkQqF7fV+xjKClt9DO1izf9MPsE
         sS3EHcZ5J8MCj2F+OcDgh1xBl6vFpSd13IP8/UHtPktmB4mV5inNccbpUqSbAHc8Petu
         ru/A==
X-Gm-Message-State: AOAM530Of+va4wmSFjHSxa/Hijd1zwaePZ3F3S/y0FW/a1ZQtdMhqC/z
        KjyKeG4hgpghYmEo2jsje2xtFCPo
X-Google-Smtp-Source: ABdhPJwvFHYVzXj0F7farJSQB3g8ep5dXMVSEucQ5GTIH+ySaGQxiH/pOc+6Gbbt8jBp2RLGRVbkmA==
X-Received: by 2002:a05:6512:1084:: with SMTP id j4mr1404121lfg.96.1595855075500;
        Mon, 27 Jul 2020 06:04:35 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z22sm3012763lfb.93.2020.07.27.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:04:34 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] Improve network_support.md
Date:   Mon, 27 Jul 2020 16:04:28 +0300
Message-Id: <20200727130428.8234-1-toiwoton@gmail.com>
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
v2: address comments from Richard Haines
---
 src/network_statements.md |   2 +-
 src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-----
 2 files changed, 150 insertions(+), 22 deletions(-)

diff --git a/src/network_statements.md b/src/network_statements.md
index ef1c873..357c3b1 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -102,7 +102,7 @@ the interface to a security context.
 <tr>
 <td><code>packet_context</code></td>
 <td><p>The security context allocated packets. Note that these are defined but unused.</p>
-<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
+<p>The iptables(8)/nftables(8) <a href="network_support.md#internal-labeling-secmark">SECMARK services</a> should be used to label packets.</p></td>
 </tr>
 </tbody>
 </table>
diff --git a/src/network_support.md b/src/network_support.md
index 309e863..6f9896b 100644
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
+the policy capabilities or by loading SECMARK rules.
 
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
+define the types. Then the rules can allow domains to receive data
+from objects of `peer` class:
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

