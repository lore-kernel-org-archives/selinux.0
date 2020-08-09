Return-Path: <SRS0=Syrn=BT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FFC433DF
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 07:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B42B206A2
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 07:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdOSu0f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIHe0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgHIHe0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Aug 2020 03:34:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21AC061756
        for <selinux@vger.kernel.org>; Sun,  9 Aug 2020 00:34:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so3116965lfj.8
        for <selinux@vger.kernel.org>; Sun, 09 Aug 2020 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75by+B/XSG5XRJqIlE+kK7uP1YWyBli1AkhXQ8NwXh8=;
        b=gdOSu0f1RlRXpXu0dArWO7fCcTu0N36MHg5gOFGDanKxvaTdSALq/h9uOa3mlwm8qc
         LI7Oel54sVwTUWxSGXdEGTwe0P/B5Hc9N4blyeO1xz1rUXMzNa5QsoqrAKqKWbzTS1is
         CpnCHrU3SFzbPrUn4Rolrri4EIN9Fw3fOMvKpqcgnJXvUA91tYHjkbxjyqbYVVs7nfrb
         cKVaJAcrXfe2WFCE7SVynDuFz2Mzt7q8qpbXwkOp4P6PY7EX7SGKPDvM5vYbVECvplJ5
         1nK8jsPuOOH8LJV7bKadM6o5MwNbW3/wNzs6KAz6heGyvJwshX8M2Zzyc8zHqlsfinvp
         vyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75by+B/XSG5XRJqIlE+kK7uP1YWyBli1AkhXQ8NwXh8=;
        b=ehMJABmPgKHKfVyLl4TNcIGM6wMde2hwGQebWJ0l9ESTpkDOqoBPxzVOd2Pgfgc+ZW
         R+PZAFiN1LL4JWyyKprnqetU+tO204NWrMyj8/XW9/i0UXx26gxUb4G/rjC8LCY6TC2Y
         lddk8RBRZwN6a5Hz4tBFuRc4MQkpAJt0BKiyngd1zevfSl02kv1okmKOaUErQjqLx6En
         gHo3pP1EFV7HW3TX6IURJ+X95LPVvC+QX0mxQMmtZPA000l6sej4Gv8PKV9E5Ohdhz4m
         QIxUcqD0WhsBKXflOVQp6VAXOuul5REQvKFWgA6EMRPzlJ0UUg/6AOhG2QOTJhVx1tvW
         cCUg==
X-Gm-Message-State: AOAM530vZQH8gFv5Ft4B87Ia8ltbtiPBAECn6NV9dxYHBTVhsdn456Ff
        wHa/wGJ4zug398nkPGo3skh3RTVv
X-Google-Smtp-Source: ABdhPJxVQNBFLxwR+AwQqmP2lDfmJnSFYH22nWzNSWFTpq756iYFYokep8MpB+08sFFwZD4/1irlvA==
X-Received: by 2002:a05:6512:1048:: with SMTP id c8mr10319624lfb.101.1596958463341;
        Sun, 09 Aug 2020 00:34:23 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a1sm2350271ljk.27.2020.08.09.00.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 00:34:22 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v4] Improve network_support.md
Date:   Sun,  9 Aug 2020 10:34:16 +0300
Message-Id: <20200809073416.7401-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.28.0
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
v3: address comments from Paul Moore
v4: address further comments from Paul Moore
---
 src/network_statements.md |   2 +-
 src/network_support.md    | 238 +++++++++++++++++++++++++++++++++-----
 2 files changed, 213 insertions(+), 27 deletions(-)

diff --git a/src/network_statements.md b/src/network_statements.md
index a625c26..a1e3b88 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -116,7 +116,7 @@ netifcon netif_id netif_context packet_context
 <tr>
 <td><code>packet_context</code></td>
 <td><p>The security context allocated packets. Note that these are defined but unused.</p>
-<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
+<p>The iptables(8)/nftables(8) <a href="network_support.md#packet-controls-secmark">SECMARK services</a> should be used to label packets.</p></td>
 </tr>
 </tbody>
 </table>
diff --git a/src/network_support.md b/src/network_support.md
index 62f87f2..23862ae 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -1,20 +1,62 @@
 # SELinux Networking Support
 
-SELinux supports the following types of network labeling:
+SELinux controls network access in the kernel at two locations: at the
+socket interface, and when packets are processed by the protocol
+stacks. Controls at the socket interface are invoked when a task makes
+network related system calls and thus the access permission checks
+mimic the sockets programming interface (e.g. ***bind**(2)*
+vs. `node_bind`). Packet controls are more distant from applications
+and they are invoked whenever any packets are received, forwarded or
+sent.
+
+Packet level controls include:
+* Packet labeling with SECMARK: class `packet`
+* Peer labeling with Labeled IPSec or NetLabel: class `peer`
+* Interface control: class `netif`
+* Network node control: class `node`
+
+Controls at socket interface include:
+* TCP/UDP/SCTP/DCCP ports: class `port`
+
+SECMARK is a security extension in Linux network packet processing,
+which allows packets or sessions to be marked with security labels.
+
+NetLabel is a framework for explicit network labeling that abstracts
+away the underlying labeling protocol from the LSMs. Labeled IPsec and
+the NetLabel framework are the current access controls for class
+`peer`, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
+a fallback/static labeling for unlabeled IPv4 and IPv6 networks.
+
+Packet controls can be organized further according to the source of
+the label for the packets, which can be internal or external:
 
 **Internal labeling** - This is where network objects are labeled and
 managed internally within a single machine (i.e. their labels are not
 transmitted as part of the session with remote systems). There are two
-types supported: SECMARK and NetLabel. There was a service known as
-'compat_net' controls, however that was removed in kernel 2.6.30.
-
-**Labeled Networking** - This is where labels are passed to/from remote
-systems where they can be interpreted and a MAC policy enforced on each
-system. There are three types supported: Labeled IPSec, CIPSO
-(Commercial IP Security Option) and CALIPSO (Common Architecture Label
-IPv6 Security Option)
-
-There are two policy capability options that can be set within policy
+types supported: SECMARK and NetLabel with the static/fallback
+"protocol". As an example, SECMARK access controls could restrict
+`firefox_t` to talking only to network services on TCP port 80 while
+NetLabel fallback/static rules could restrict `firefox_t` to only
+receive data from specific IP addresses on a specific network
+interface.
+
+**Labeled Networking** - This is where labels are passed to/from
+remote systems where they can be interpreted and a MAC policy enforced
+on each system. There are three types supported: Labeled IPSec,
+NetLabel/CIPSO (Commercial IP Security Option) and NetLabel/CALIPSO
+(Common Architecture Label IPv6 Security Option). With labeled
+networking, it's possible to compare the security attributes (SELinux
+label) of the sending peer with the security context of the receiving
+peer. A simple example with Labeled IPSec is restricting `firefox_t`
+to talking only to `httpd_t`, while NetLabel/CIPSO & CALIPSO could
+restrict domains with MLS security level `s32` not to talk with
+domains with level `s31`.
+
+SELinux network access controls are not enabled by default. They can
+be enabled by configuring SECMARK, NetLabel or Labeled IPsec rules, or
+forced on with the policy capability ***always_check_network***.
+
+There are three policy capability options that can be set within policy
 using the *policycap* statement that affect networking configuration:
 
 ***network_peer_controls*** - This is always enabled in the latest
@@ -37,8 +79,8 @@ The policy capability settings are available in userspace via the
 SELinux filesystem as shown in the
 [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
 
-To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
-be installed:
+The NetLabel tools need to be installed to support peer labeling with
+CIPSO and CALIPSO or fallback labeling:
 
 ```
 dnf install netlabel_tools
@@ -58,8 +100,12 @@ dnf install libreswan
 ```
 
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
@@ -69,7 +115,7 @@ the inode associated to the socket and not from the actual kernel socket
 structure (as currently there is no standard kernel/userspace interface
 to achieve this).
 
-## SECMARK
+## Packet controls: SECMARK
 
 SECMARK makes use of the standard kernel NetFilter framework that
 underpins the GNU / Linux IP networking sub-system. NetFilter services
@@ -77,7 +123,7 @@ automatically inspects all incoming and outgoing packets and can place
 controls on interfaces, IP addresses (nodes) and ports with the added
 advantage of connection tracking. The SECMARK security extensions allow
 security contexts to be added to packets (SECMARK) or sessions
-(CONNSECMARK).
+(CONNSECMARK), belonging to object class of `packet`.
 
 The NetFilter framework inspects and tag packets with labels as defined
 within ***iptables**(8)* (also 'nftables' ***nft**(8)* from version 9.3 with
@@ -176,11 +222,21 @@ table ip6 security {
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
 
-## NetLabel - Fallback Peer Labeling
+## Packet controls: NetLabel - Fallback Peer Labeling
 
 Fallback labeling can optionally be implemented on a system if the
 Labeled IPSec or CIPSO/CALIPSO is not being used (hence 'fallback
@@ -217,11 +273,22 @@ netlabelctl -p map list
 Note that the security contexts must be valid in the policy otherwise the
 commands will fail.
 
-## NetLabel – CIPSO/CALIPSO
+Before the NetLabel rules can be loaded, TE rules must be added to
+define the types. Then the rules can allow domains to receive data
+from objects of `peer` class:
 
-To allow MLS [**security levels**](mls_mcs.md#security-levels) to be passed
-over a network between MLS
-systems<a href="#fnn2" class="footnote-ref" id="fnnet2"><strong><sup>2</sup></strong></a>,
+```
+type netlabel_sctp_peer_t;
+
+allow my_server_t netlabel_sctp_peer_t:peer recv;
+```
+Note that sending can't be controlled with `peer` class.
+
+## Packet controls: NetLabel – CIPSO/CALIPSO
+
+To allow MLS or MCS [**security levels**](mls_mcs.md#security-levels)
+to be passed over a network between MLS or MCS systems<a href="#fnn2"
+class="footnote-ref" id="fnnet2"><strong><sup>2</sup></strong></a>,
 the Commercial IP Security Option (CIPSO) protocol is used. This is defined in the
 [**CIPSO Internet Draft**](http://tools.ietf.org/html/draft-ietf-cipso-ipsecurity-01)
 document (this is an obsolete document, however the protocol is still in
@@ -232,9 +299,9 @@ The Common Architecture Label IPv6 Security Option (CALIPSO) protocol
 described in [**rfc 5570**](http://ietf.org/rfc/rfc5570.txt) is supported in
 kernels from 4.8.
 
-CIPSO/CALIPSO will only pass the MLS component of the security context
-over the network, however in loopback mode CIPSO allows the full
-security context to be passed as explained in the
+CIPSO/CALIPSO will only pass the MLS or MCS component of the security
+context over the network, however in loopback mode CIPSO allows the
+full security context to be passed as explained in the
 "**Full SELinux Labels Over Loopback with NetLabel and CIPSO**" available at
 <http://paulmoore.livejournal.com/7234.html>.
 
@@ -286,7 +353,7 @@ netlabelctl -p map list
 The examples use the *nb_client*/*nb_server* from the Notebook examples
 section, plus the standard Fedora 'targeted' policy for the tests.
 
-## Labeled IPSec
+## Packet controls: Labeled IPSec
 
 Labeled IPSec has been built into the standard GNU / Linux IPSec
 services as described in the
@@ -451,6 +518,125 @@ Labeled NFS clients must use a consistent security policy.
 
 The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
 
+## Packet controls: Access Control for Network Interfaces
+
+SELinux domains can be restricted to use only specific network
+interfaces. TE rules must define the interface types and then allow a
+domain to `egress` in class `netif` for the defined interface types:
+
+```
+require {
+        attribute netif_type;
+		class netif { egress ingress };
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
+The checks for `ingress` in class `netif` however use the peer label
+of the remote peer (not the receiving task on the local system) as
+subject:
+
+```
+type internet_peer_t;
+
+allow internet_peer_t external_if_t:netif ingress;
+```
+
+The peers must also be labeled with various methods provided by
+***netlabelctl**(8)*. A simple example with fallback/static labeling is:
+
+```
+netlabelctl unlbl add default address:2000::/3 label:system_u:object_r:internet_peer_t:s0
+```
+
+## Packet controls: Access Control for Network Nodes
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
+		class node { sendto recvfrom };
+		class tcp_socket node_bind;
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
+The checks for `recvfrom` in class `node` however use the peer label
+as subject:
+
+```
+allow internet_peer_t internet_node_t:node { recvfrom sendto };
+```
+
+## Socket controls: Access Control for Network Ports
+
+SELinux policy can also control access to ports used by various
+networking protocols such as TCP, UDP, SCTP and DCCP. In contrast to
+packet level controls, port controls are close to how networked
+applications use the socket system calls. Thus the controls typically
+involve checking if a task can perform an operation on a network
+socket, e.g. ***bind**(2)* would cause an access check for
+`node_bind`. These are usually easy to understand and don't require
+any special network configuration.
+
+TE rules must define the port types and then allow a domain to
+`name_connect` (outgoing) or `name_bind` (incoming) in class
+`tcp_socket` (or `udp_socket` etc) for the defined port types:
+
+```
+require {
+        attribute port_type;
+		class tcp_socket { name_bind name_connect };
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
 <section class="footnotes">
 <ol>
 <li id="fnn1"><p>For example, an ftp session where the server is listening on a specific port (the destination port) but the client will be assigned a random source port. The CONNSECMARK will ensure that all packets for the ftp session are marked with the same label.<a href="#fnnet1" class="footnote-back">↩</a></p></li>
-- 
2.28.0

