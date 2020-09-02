Return-Path: <SRS0=BB3M=CZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC1BC43461
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 05:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C38B20708
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 05:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="l9Kar5KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIPFQI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:16:08 -0400
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:44954 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgIPFQH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Sep 2020 01:16:07 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200902131745.VNDB4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052665; 
        bh=7UovMaRWkhQ2n9+fT5lDImm1PPTEFwBvyFQOiVXNBxw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=l9Kar5KUK+ut1kPFWubuO2J5uMDC10tu6mxcOBc30vUqtpqJvZ7wJvonXjn2vw28N+Z4tpxG0/LSK4hwtPci/IRVI/E+xNPAmTAsZWX1Neb5ZF1rlxrhp+ElxpYwvhWC98JprryRQtLDz997cR8HE2V+dJJoz4W5ZMr+omx8xXrVnAu+yQdL6d+ojzVTofsGVDtJMXJa0ghk4synEUladEGYdelDUNEKg6V4BvQUbMP4M8XImP7WmyAldoKP1ECTzGNX2K7ZmldHV5h8GvoPJE8PEmWEu0Y0qgbR9zwWANk+zt8ebMsCb5sjNCLj4OMWsjEYPirA3BaXyDO6nZaivA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36B91; Wed, 2 Sep 2020 14:17:45 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 04/13] network_statements: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:29 +0100
Message-Id: <20200902131738.18425-5-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/network_statements.md | 261 ++++++++++++++++----------------------
 1 file changed, 108 insertions(+), 153 deletions(-)

diff --git a/src/network_statements.md b/src/network_statements.md
index a1e3b88..8ba411e 100644
--- a/src/network_statements.md
+++ b/src/network_statements.md
@@ -1,5 +1,13 @@
 # Network Labeling Statements
 
+- [Network Address Formats](#network-address-formats)
+  - [IPv4 Address Format](#ipv4-address-format)
+  - [IPv6 Address Formats](#ipv6-address-formats)
+- [*netifcon*](#netifcon)
+- [*nodecon*](#nodecon)
+- [*portcon*](#portcon)
+
+
 The network labeling statements are used to label the following objects:
 
 **Network interfaces** - This covers those interfaces managed by the
@@ -28,6 +36,8 @@ sid node system_u:object_r:node_t:s0 - s15:c0.c255
 sid port system_u:object_r:port_t:s0
 ```
 
+## Network Address Formats
+
 ### IPv4 Address Format
 
 IPv4 addresses are represented in dotted-decimal notation (four
@@ -49,34 +59,30 @@ where each group is separated by a colon ':' as follows:
 To shorten the writing and presentation of addresses, the following
 rules apply:
 
-1.  Any leading zeros in a group may be replaced with a single '0' as
-    shown:
+Any leading zeros in a group may be replaced with a single '0' as shown:
 
 ```
 2001:db8:85a3:0:0:8a2e:370:7334
 ```
 
-2.  Any leading zeros in a group may be omitted and be replaced with two
-    colons '::', however this is only allowed once in an address as
-    follows:
+Any leading zeros in a group may be omitted and be replaced with two
+colons '::', however this is only allowed once in an address as follows:
 
 ```
 2001:db8:85a3::8a2e:370:7334
 ```
 
-3.  The *localhost* (loopback) address can be written as:
+The *localhost* (loopback) address can be written as:
 
 ```
 0000:0000:0000:0000:0000:0000:0000:0001
-```
 
 Or
 
-```
 ::1
 ```
 
-4.  An undetermined IPv6 address i.e. all bits are zero is written as:
+An undetermined IPv6 address i.e. all bits are zero is written as:
 
 ```
 ::
@@ -88,8 +94,8 @@ The *netifcon* statement is used to label network interface objects (e.g.
 eth0) for peer labeling (see the
 [***netif* object class**](object_classes_permissions.md#network-object-classes)).
 
-It is also possible to use the ***semanage**(8)* interface command to associate
-the interface to a security context.
+It is also possible to use the ***semanage**(8)* *interface* command to
+associate the interface to a security context.
 
 **The statement definition is:**
 
@@ -99,54 +105,38 @@ netifcon netif_id netif_context packet_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>netifcon</code></td>
-<td>The <code>netifcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>netif_id</code></td>
-<td>The network interface name (e.g. eth0).</td>
-</tr>
-<tr>
-<td><code>netif_context</code></td>
-<td>The security context allocated to the network interface.</td>
-</tr>
-<tr>
-<td><code>packet_context</code></td>
-<td><p>The security context allocated packets. Note that these are defined but unused.</p>
-<p>The iptables(8)/nftables(8) <a href="network_support.md#packet-controls-secmark">SECMARK services</a> should be used to label packets.</p></td>
-</tr>
-</tbody>
-</table>
+*netifcon*
+
+The *netifcon* keyword.
+
+*netif_id*
+
+The network interface name (e.g. eth0).
+
+*netif_context*
+
+The security context allocated to the network interface.
+
+*packet_context*
+
+The security context allocated packets. Note that these are defined but unused.
+The ***iptables**(8)* / ***nft**(8)*
+[**SECMARK services**](network_support.md#packet-controls-secmark) should be
+used to label packets.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Example:**
 
@@ -165,9 +155,9 @@ semanage interface -a -t netif_t eth2
 ```
 
 This command will produce the following file in the default
-&lt;SELINUXTYPE&gt; policy store and then activate the policy:
+\<SELINUXTYPE\> policy store and then activate the policy:
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/interfaces.local*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/interfaces.local*:
 
 ```
 # This file is auto-generated by libsemanage
@@ -185,7 +175,7 @@ labeling (see the
 that represent IPv4 or IPv6 IP addresses and network masks.
 
 It is also possible to add SELinux these outside the policy using the
-***semanage**(8)* 'node' command that will associate the node to a security
+***semanage**(8)* *node* command that will associate the node to a security
 context.
 
 **The statement definition is:**
@@ -196,54 +186,37 @@ nodecon subnet netmask node_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>nodecon</code></td>
-<td>The <code>nodecon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>subnet</code></td>
-<td><p>The subnet or specific IP address in IPv4 or IPv6 format.</p>
-<p>Note that the subnet and netmask values are used to ensure that the node_context is assigned to all IP addresses within the subnet range.</p></td>
-</tr>
-<tr>
-<td><code>netmask</code></td>
-<td>The subnet mask in IPv4 or IPv6 format.</td>
-</tr>
-<tr>
-<td><code>node_context<code></td>
-<td>The security context for the node.</td>
-</tr>
-</tbody>
-</table>
+*nodecon*
+
+The *nodecon* keyword.
+
+*subnet*
+
+The subnet or specific IP address in IPv4 or IPv6 format.
+Note that the subnet and netmask values are used to ensure that the
+*node_context* is assigned to all IP addresses within the subnet range.
+
+*netmask*
+
+The subnet mask in IPv4 or IPv6 format.
+
+*node_context*
+
+The security context for the node.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -267,9 +240,9 @@ semanage node -a -t node_t -p ipv4 -M 255.255.255.255 127.0.0.2
 ```
 
 This command will produce the following file in the default
-&lt;SELINUXTYPE&gt; policy store and then activate the policy:
+\<SELINUXTYPE\> policy store and then activate the policy:
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/nodes.local*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/nodes.local*:
 
 ```
 # This file is auto-generated by libsemanage
@@ -283,7 +256,7 @@ nodecon ipv4 127.0.0.2 255.255.255.255 system_u:object_r:node_t:s0
 The *portcon* statement is used to label udp, tcp, dccp or sctp ports.
 
 It is also possible to add a security context to ports outside the
-policy using the ***semanage**(8)* 'port' command that will associate the port
+policy using the ***semanage**(8)* *port* command that will associate the port
 (or range of ports) to a security context.
 
 **The statement definition is:**
@@ -294,53 +267,35 @@ portcon protocol port_number port_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>portcon</code></td>
-<td>The <code>portcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>protocol</code></td>
-<td>The protocol type. Valid entries are udp, tcp or <em>dccp</em>.</td>
-</tr>
-<tr>
-<td><code>port_number</code></td>
-<td>The port number or range of ports. The ranges are separated by a hyphen (-).</td>
-</tr>
-<tr>
-<td><code>port_context</code></td>
-<td>The security context for the port or range of ports.</td>
-</tr>
-</tbody>
-</table>
+*portcon*
+
+The *portcon* keyword.
+
+*protocol*
+
+The protocol type. Valid entries are udp, tcp or dccp.
+
+*port_number*
+
+The port number or range of ports. The ranges are separated by a hyphen '-'.
+
+*port_context*
+
+The security context for the port or range of ports.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* Statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -361,9 +316,9 @@ semanage port -a -t reserved_port_t -p udp 1234
 ```
 
 This command will produce the following file in the default
-&lt;SELINUXTYPE&gt; policy store and then activate the policy:
+\<SELINUXTYPE\> policy store and then activate the policy:
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/ports.local*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/ports.local*:
 
 ```
 # This file is auto-generated by libsemanage
-- 
2.26.2

