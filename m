Return-Path: <SRS0=OFWW=BF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DFC433E3
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309032065F
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="bbL+I/yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGZPQq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:16:46 -0400
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:12427 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgGZPQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Jul 2020 11:16:45 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200726151641.TQFL4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sun, 26 Jul 2020 16:16:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1595776601; 
        bh=6hOmeD+fA/g8IBCdV+uDyzFIqZBYcJaKcg2x388jusM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=bbL+I/yK6vTwUkSPQq96Ykaacp9KVuca0TXmFmoDR2ZWmPmQ7HK2G1hNWR2Uyl8VXShZpkxqBilTfdBTRTW2Vyzn0HvYdwReO3EclqOM/IgFYtU6Jiw5xfgTTaiH20+XyXHp73gvx0+ThUPIdIucQohL9C3BGmd2QrKNAOgRHjo4J1vJQ4zffF9jtR7YO0M7fLQFNzJAJJAdbmOT1Iwozkw8fctHyWJidxdEGMcxu5wITLUIjwQshDwyg/6N75DTsHmaobh0A2tH27n7F5t9eAI8pUoEEnkqwIegG5Qo6N55LVDwwZB5KB2W/3gJHQ2u1EzYCog7ruC8oO026I/tDg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.183.37.251]
X-OWM-Source-IP: 86.183.37.251 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=49/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrheejgdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucgoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepfeevffevjeetteeivdekudetjeduvdektedufffhhefffeeggeekfffgleejueetnecuffhomhgrihhnpehlihhvvghjohhurhhnrghlrdgtohhmnecukfhppeekiedrudekfedrfeejrddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekfedrfeejrddvhedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehtohhifihothhonhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 49
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.37.251) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A708B4A74A; Sun, 26 Jul 2020 16:16:41 +0100
Message-ID: <15866217b60aecd2fb1f3c2102cda9e1d743f300.camel@btinternet.com>
Subject: Re: [PATCH] Improve network_support.md
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Date:   Sun, 26 Jul 2020 16:16:34 +0100
In-Reply-To: <20200725165721.4964-1-toiwoton@gmail.com>
References: <20200725165721.4964-1-toiwoton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 2020-07-25 at 19:57 +0300, Topi Miettinen wrote:
> List all access control methods available for networking and provide
> examples for each.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

LGTM - Just a few minor comments below.

> ---
>  src/network_support.md | 170 ++++++++++++++++++++++++++++++++++++---
> --
>  1 file changed, 149 insertions(+), 21 deletions(-)
> 
> diff --git a/src/network_support.md b/src/network_support.md
> index 309e863..a01ca3d 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -1,20 +1,17 @@
>  # SELinux Networking Support
>  
> -SELinux supports the following types of network labeling:
> +SELinux supports several methods for access control of networks.
> These are
>  
> -**Internal labeling** - This is where network objects are labeled
> and
> -managed internally within a single machine (i.e. their labels are
> not
> -transmitted as part of the session with remote systems). There are
> two
> -types supported: SECMARK and NetLabel. There was a service known as
> -'compat_net' controls, however that was removed in kernel 2.6.30.
> +* Packet labeling: class `packet`
> +* Peer labeling: class `peer`
> +* Interface control: class `netif`
> +* Network node control: class `node`
> +* TCP/UDP/SCTP/DCCP ports: class `port`
>  
> -**Labeled Networking** - This is where labels are passed to/from
> remote
> -systems where they can be interpreted and a MAC policy enforced on
> each
> -system. There are three types supported: Labeled IPSec, CIPSO
> -(Commercial IP Security Option) and CALIPSO (Common Architecture
> Label
> -IPv6 Security Option)
> +Networking support is not enabled by default. It can be enabled
> either
> +the policy capabilites or by loading SECMARK rules.

'capabilites' sb: 'capabilities'

>  
> -There are two policy capability options that can be set within
> policy
> +There are three policy capability options that can be set within
> policy
>  using the `policycap` statement that affect networking
> configuration:
>  
>  **`network_peer_controls`** - This is always enabled in the latest
> @@ -37,8 +34,22 @@ The policy capability settings are available in
> userspace via the
>  SELinux filesystem as shown in the
>  [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>  
> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need
> to
> -be installed:
> +SELinux supports the following types of network labeling:
> +
> +**Internal labeling** - This is where network objects are labeled
> and
> +managed internally within a single machine (i.e. their labels are
> not
> +transmitted as part of the session with remote systems). There are
> two
> +types supported: SECMARK and NetLabel. There was a service known as
> +'compat_net' controls, however that was removed in kernel 2.6.30.
> +
> +**Labeled Networking** - This is where labels are passed to/from
> remote
> +systems where they can be interpreted and a MAC policy enforced on
> each
> +system. There are three types supported: Labeled IPSec, CIPSO
> +(Commercial IP Security Option) and CALIPSO (Common Architecture
> Label
> +IPv6 Security Option).
> +
> +To support peer labeling with CIPSO and CALIPSO or fallback
> labeling,
> +the NetLabel tools need to be installed:
>  
>  `dnf install netlabel_tools`
>  
> @@ -52,8 +63,12 @@ OpenSwan but is now distributed as LibreSwan:
>  `dnf install libreswan`
>  
>  It is important to note that the kernel must be configured to
> support
> -these services. The Fedora kernels are configured to handle all the
> above
> -services.
> +these services (`CONFIG_NETLABEL`, `CONFIG_NETWORK_SECMARK`,
> +`CONFIG_NF_CONNTRACK_SECMARK`,
> +`CONFIG_NETFILTER_XT_TARGET_CONNSECMARK`,
> +`CONFIG_NETFILTER_XT_TARGET_SECMARK`, `CONFIG_IP_NF_SECURITY`,
> +`CONFIG_IP6_NF_SECURITY`). At least Fedora and Debian kernels are
> +configured to handle all the above services.
>  
>  The Linux networking package *iproute* has an SELinux aware socket
>  statistics command ***ss**(8)* that will show the SELinux context of
> @@ -65,7 +80,7 @@ to achieve this).
>  
>  <br>
>  
> -## SECMARK
> +## Internal labeling: SECMARK

When building PDF document with 'make pdf' there is an error:
ERROR: No anchor #secmark for internal URI reference

This is because the heading has been changed from '# SECMARK' to '#
Internal labeling: SECMARK'. This can be corrected by:

--- a/src/network_statements.md	2020-07-08 08:18:35.341502000 +0100
+++ b/src/network_statements.md	2020-07-26 13:05:19.977339000 +0100
@@ -102,7 +102,7 @@
 <tr>
 <td><code>packet_context</code></td>
 <td><p>The security context allocated packets. Note that these are
defined but unused.</p>
-<p>The iptables(8)/nftables(8) <a
href="network_support.md#secmark">SECMARK services</a> should be used
to label packets.</p></td>
+<p>The iptables(8)/nftables(8) <a href="network_support.md#internal-
labeling-secmark">SECMARK services</a> should be used to label
packets.</p></td>
 </tr>
 </tbody>
 </table>

>  
>  SECMARK makes use of the standard kernel NetFilter framework that
>  underpins the GNU / Linux IP networking sub-system. NetFilter
> services
> @@ -73,7 +88,7 @@ automatically inspects all incoming and outgoing
> packets and can place
>  controls on interfaces, IP addresses (nodes) and ports with the
> added
>  advantage of connection tracking. The SECMARK security extensions
> allow
>  security contexts to be added to packets (SECMARK) or sessions
> -(CONNSECMARK).
> +(CONNSECMARK), belonging to object class of `packet`.
>  
>  The NetFilter framework inspects and tag packets with labels as
> defined
>  within ***iptables**(8)* (also 'nftables' ***nft**(8)* from version
> 9.3 with
> @@ -172,6 +187,16 @@ table ip6 security {
>  }
>  ```
>  
> +Before the SECMARK rules can be loaded, TE rules must be added to
> +define the types, and also allow domains to send and/or receive
> +objects of `packet` class:
> +
> +```
> +type test_server_packet_t, packet_type;
> +
> +allow my_server_t test_server_packet_t:packet { send recv };
> +```
> +
>  The following articles explain the SECMARK service:
>  -   [*Transitioning to Secmark*](
> http://paulmoore.livejournal.com/4281.html)
>  -   [New secmark-based network controls for SELinux](
> http://james-morris.livejournal.com/11010.html)
> @@ -179,7 +204,7 @@ The following articles explain the SECMARK
> service:
>  
>  <br>
>  
> -## NetLabel - Fallback Peer Labeling
> +## Internal labeling: NetLabel - Fallback Peer Labeling
>  
>  Fallback labeling can optionally be implemented on a system if the
>  Labeled IPSec or CIPSO/CALIPSO is not being used (hence 'fallback
> @@ -217,9 +242,20 @@ netlabelctl -p map list
>  Note that the security contexts must be valid in the policy
> otherwise the
>  commands will fail.
>  
> +Before the NetLabel rules can be loaded, TE rules must be added to
> +define the types. The the rules can allow domains to receive data 
'The the' sb: 'The'

> from
> +objects of `peer` class:
> +
> +```
> +type netlabel_sctp_peer_t;
> +
> +allow my_server_t netlabel_sctp_peer_t:peer recv;
> +```
> +Note that sending can't be controlled with `peer` class.
> +
>  <br>
>  
> -## NetLabel – CIPSO/CALIPSO
> +## Labeled Networking: NetLabel – CIPSO/CALIPSO
>  
>  To allow MLS [**security levels**](mls_mcs.md#security-levels) to be
> passed
>  over a network between MLS
> @@ -288,7 +324,7 @@ section, plus the standard Fedora 'targeted'
> policy for the tests.
>  
>  <br>
>  
> -## Labeled IPSec
> +## Labeled Networking: Labeled IPSec
>  
>  Labeled IPSec has been built into the standard GNU / Linux IPSec
>  services as described in the
> @@ -451,6 +487,98 @@ The *selinux-testsuite tools/nfs.sh* tests
> labeled NFS using various labels.
>  
>  <br>
>  
> +## Access Control for Network Interfaces
> +
> +SELinux domains can be restricted to use only specific network
> +interfaces. TE rules must define the interface types and then allow
> a
> +domain to `egress` in class `netif` for the defined interface types:
> +
> +```
> +require {
> +        attribute netif_type;
> +}
> +
> +type external_if_t, netif_type;
> +type loopback_if_t, netif_type;
> +
> +allow my_server_t external_if_t:netif egress;
> +allow my_server_t loopback_if_t:netif egress;
> +```
> +
> +The interfaces must also be labeled with ***semanage**(8)* (or by
> +using `netifcon` statements in the policy):
> +```
> +semanage interface -a -t loopback_if_t -r s0 lo
> +semanage interface -a -t external_if_t -r s0 eth0
> +```
> +
> +Note that reception can't be controlled with `netif` class.
> +
> +<br>
> +
> +## Access Control for Network Nodes
> +
> +Domains can be restricted by SELinux to access and bind sockets to
> +only dedicated network nodes (in practice, IP addresses).
> +
> +The node types must be defined and then the node types can be used
> for
> +TE rules as target context. TE rules to allow a domain to `sendto`
> for
> +class `node` and to `node_bind` (for incoming connections) for class
> +`tcp_socket`:
> +
> +```
> +require {
> +        attribute node_type;
> +}
> +
> +type loopback_node_t, node_type;
> +type internet_node_t, node_type;
> +type link_local_node_t, node_type;
> +type multicast_node_t, node_type;
> +
> +allow my_server_t loopback_node_t:node sendto;
> +allow my_server_t loopback_node_t:tcp_socket node_bind;
> +allow my_server_t internet_node_t:node sendto;
> +```
> +
> +After the types have been defined, corresponding node rules can be
> +added with `semanage` (or `nodecon` statements):
> +```
> +semanage node -a -M /128 -p ipv6 -t loopback_node_t -r s0 ::1
> +semanage node -a -M /3 -p ipv6 -t internet_node_t -r s0 2000::
> +semanage node -a -M /8 -p ipv6 -t link_local_node_t -r s0 fe00::
> +semanage node -a -M /8 -p ipv6 -t multicast_node_t -r s0 ff00::
> +```
> +
> +<br>
> +
> +## Access Control for Network Ports
> +
> +SELinux policy can also control access to ports used by various
> +networking protocols such as TCP, UDP, SCTP and DCCP. TE rules must
> +define the port types and then allow a domain to `name_connect`
> +(outgoing) or `name_bind` (incoming) in class `tcp_socket` (or
> +`udp_socket` etc) for the defined port types:
> +
> +```
> +require {
> +        attribute port_type;
> +}
> +
> +type my_server_port_t, port_type;
> +
> +allow my_server_t my_server_port_t:tcp_socket name_connect;
> +allow my_server_t my_server_port_t:tcp_socket name_bind;
> +```
> +
> +The ports must also be labeled with `semanage` (or `portcon`
> +statements):
> +```
> +semanage port -a -t my_server_port_t -p tcp -r s0 12345
> +```
> +
> +<br>
> +
>  <section class="footnotes">
>  <ol>
>  <li id="fnn1"><p>For example, an ftp session where the server is
> listening on a specific port (the destination port) but the client
> will be assigned a random source port. The CONNSECMARK will ensure
> that all packets for the ftp session are marked with the same
> label.<a href="#fnnet1" class="footnote-back">↩</a></p></li>

