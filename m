Return-Path: <SRS0=BB3M=CZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58314C2BB84
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F992220E
	for <selinux@archiver.kernel.org>; Wed, 16 Sep 2020 10:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="LrGlB5KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgIPKEI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Sep 2020 06:04:08 -0400
Received: from mailomta12-sa.btinternet.com ([213.120.69.18]:34379 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726669AbgIPKEI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Sep 2020 06:04:08 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200902131746.ILLU4609.sa-prd-fep-047.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052666; 
        bh=jTK0IktSsmSWiH2+1y47k1mW/rTfNf57qprk2TR0Z/w=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=LrGlB5KPERpQSDoDIf2wFdoPXDGyDH95egcCR0AR1+4iCjhSZVQVEE3ktcLtrsLVJghhaATy8QSwTJNeW0Cz32Sb7d35naRn4LLHGzqne7mr/8B1bIgiZGIb9mRHK43M7J6X3XHkjylmBNMAqdN3FSmSENMRAIFAqkVJqh61pCOD6EG2yDd/21jeA1VJi8zLeAC1H0qu4YbQ2aRT461lyFPOjfqyB0koP3IXH76G0xlrZU+NXk3GoZsg693e7gletf5EaAAYN6Oow/y+GniRjKASj5OSFl/ljTSGU4Otza+iOBi41teP8CCMfvjr5ZDJ08MvSGE35CNDzZ0AZC1MYw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=49/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfegteevgeevueekvdejtdegkeevhfdvuddvueduudetffevtdekteefleeuvdenucffohhmrghinheplhhivhgvjhhouhhrnhgrlhdrtghomhdpihgvthhfrdhorhhgpdhrvgguhhgrthdrtghomhenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggp
        tggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 49
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36BA7; Wed, 2 Sep 2020 14:17:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 05/13] network_support: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:30 +0100
Message-Id: <20200902131738.18425-6-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Moved some text, but no text changes.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/network_support.md | 270 +++++++++++++++++++++--------------------
 1 file changed, 141 insertions(+), 129 deletions(-)

diff --git a/src/network_support.md b/src/network_support.md
index 5faa578..36af1f4 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -1,24 +1,33 @@
 # SELinux Networking Support
 
+- [Packet controls: SECMARK](#packet-controls-secmark)
+- [Packet controls: NetLabel - Fallback Peer Labeling](#packet-controls-netlabel---fallback-peer-labeling)
+- [Packet controls: NetLabel - CIPSO/CALIPSO](#packet-controls-netlabel-cipsocalipso)
+- [Packet controls: Labeled IPSec](#packet-controls-labeled-ipsec)
+- [Packet controls: Access Control for Network Interfaces](#packet-controls-access-control-for-network-interfaces)
+- [Packet controls: Access Control for Network Nodes](#packet-controls-access-control-for-network-nodes)
+- [Socket controls: Access Control for Network Ports](#socket-controls-access-control-for-network-ports)
+- [Labeled Network FileSystem (NFS)](#labeled-network-filesystem-nfs)
+
 SELinux controls network access in the kernel at two locations: at the
 socket interface, and when packets are processed by the protocol
 stacks. Controls at the socket interface are invoked when a task makes
 network related system calls and thus the access permission checks
 mimic the sockets programming interface (e.g. ***bind**(2)*
-vs. `node_bind`). Packet controls are more distant from applications
+vs. *node_bind*). Packet controls are more distant from applications
 and they are invoked whenever any packets are received, forwarded or
 sent.
 
 Packet level controls include:
 
-* Packet labeling with SECMARK: class `packet`
-* Peer labeling with Labeled IPSec or NetLabel: class `peer`
-* Interface control: class `netif`
-* Network node control: class `node`
+- Packet labeling with SECMARK: class *packet*
+- Peer labeling with Labeled IPSec or NetLabel: class *peer*
+- Interface control: class *netif*
+- Network node control: class *node*
 
 Controls at socket interface include:
 
-* TCP/UDP/SCTP/DCCP ports: class `port`
+- TCP/UDP/SCTP/DCCP ports: class *port*
 
 SECMARK is a security extension in Linux network packet processing,
 which allows packets or sessions to be marked with security labels.
@@ -26,7 +35,7 @@ which allows packets or sessions to be marked with security labels.
 NetLabel is a framework for explicit network labeling that abstracts
 away the underlying labeling protocol from the LSMs. Labeled IPsec and
 the NetLabel framework are the current access controls for class
-`peer`, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
+*peer*, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
 a fallback/static labeling for unlabeled IPv4 and IPv6 networks.
 
 Packet controls can be organized further according to the source of
@@ -37,8 +46,8 @@ managed internally within a single machine (i.e. their labels are not
 transmitted as part of the session with remote systems). There are two
 types supported: SECMARK and NetLabel with the static/fallback
 "protocol". As an example, SECMARK access controls could restrict
-`firefox_t` to talking only to network services on TCP port 80 while
-NetLabel fallback/static rules could restrict `firefox_t` to only
+*firefox_t* to talking only to network services on TCP port 80 while
+NetLabel fallback/static rules could restrict *firefox_t* to only
 receive data from specific IP addresses on a specific network
 interface.
 
@@ -49,10 +58,10 @@ NetLabel/CIPSO (Commercial IP Security Option) and NetLabel/CALIPSO
 (Common Architecture Label IPv6 Security Option). With labeled
 networking, it's possible to compare the security attributes (SELinux
 label) of the sending peer with the security context of the receiving
-peer. A simple example with Labeled IPSec is restricting `firefox_t`
-to talking only to `httpd_t`, while NetLabel/CIPSO & CALIPSO could
-restrict domains with MLS security level `s32` not to talk with
-domains with level `s31`.
+peer. A simple example with Labeled IPSec is restricting *firefox_t*
+to talking only to *httpd_t*, while NetLabel/CIPSO & CALIPSO could
+restrict domains with MLS security level *s32* not to talk with
+domains with level *s31*.
 
 SELinux network access controls are not enabled by default. They can
 be enabled by configuring SECMARK, NetLabel or Labeled IPsec rules, or
@@ -102,11 +111,11 @@ dnf install libreswan
 ```
 
 It is important to note that the kernel must be configured to support
-these services (`CONFIG_NETLABEL`, `CONFIG_NETWORK_SECMARK`,
-`CONFIG_NF_CONNTRACK_SECMARK`,
-`CONFIG_NETFILTER_XT_TARGET_CONNSECMARK`,
-`CONFIG_NETFILTER_XT_TARGET_SECMARK`, `CONFIG_IP_NF_SECURITY`,
-`CONFIG_IP6_NF_SECURITY`). At least Fedora and Debian kernels are
+these services (*CONFIG_NETLABEL*, *CONFIG_NETWORK_SECMARK*,
+*CONFIG_NF_CONNTRACK_SECMARK*,
+*CONFIG_NETFILTER_XT_TARGET_CONNSECMARK*,
+*CONFIG_NETFILTER_XT_TARGET_SECMARK*, *CONFIG_IP_NF_SECURITY*,
+*CONFIG_IP6_NF_SECURITY*). At least Fedora and Debian kernels are
 configured to handle all the above services.
 
 The Linux networking package *iproute* has an SELinux aware socket
@@ -125,7 +134,7 @@ automatically inspects all incoming and outgoing packets and can place
 controls on interfaces, IP addresses (nodes) and ports with the added
 advantage of connection tracking. The SECMARK security extensions allow
 security contexts to be added to packets (SECMARK) or sessions
-(CONNSECMARK), belonging to object class of `packet`.
+(CONNSECMARK), belonging to object class of *packet*.
 
 The NetFilter framework inspects and tag packets with labels as defined
 within ***iptables**(8)* (also 'nftables' ***nft**(8)* from version 9.3 with
@@ -142,16 +151,16 @@ this Notebook, there are tutorials available. The
 **Figure 13: SECMARK Processing** shows the basic structure with the process
 working as follows:
 
--   A table called the *security table* is used to define the parameters
-    that identify and 'mark' packets that can then be tracked as the
-    packet travels through the networking sub-system. These 'marks' are
-    called SECMARK and CONNSECMARK.
--   A SECMARK is placed against a packet if it matches an entry in the
-    security table applying a label that can then be used to enforce
-    policy on the packet.
--   The CONNSECMARK 'marks' all packets within a
-    session<a href="#fnn1" class="footnote-ref" id="fnnet1"><strong><sup>1</sup></strong></a>
-    with the appropriate label that can then be used to enforce policy.
+- A table called the *security table* is used to define the parameters
+  that identify and 'mark' packets that can then be tracked as the
+  packet travels through the networking sub-system. These 'marks' are
+  called SECMARK and CONNSECMARK.
+- A SECMARK is placed against a packet if it matches an entry in the
+  security table applying a label that can then be used to enforce
+  policy on the packet.
+- The CONNSECMARK 'marks' all packets within a
+  session[^fn_ns_1] with the appropriate label that can then be used to
+  enforce policy.
 
 ![](./images/13-secmark.png)
 
@@ -226,7 +235,7 @@ table ip6 security {
 
 Before the SECMARK rules can be loaded, TE rules must be added to
 define the types, and also allow domains to send and/or receive
-objects of `packet` class:
+objects of *packet* class:
 
 ```
 type test_server_packet_t, packet_type;
@@ -235,8 +244,9 @@ allow my_server_t test_server_packet_t:packet { send recv };
 ```
 
 The following articles explain the SECMARK service:
--   [*Transitioning to Secmark*](http://paulmoore.livejournal.com/4281.html)
--   [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
+
+- [*Transitioning to Secmark*](http://paulmoore.livejournal.com/4281.html)
+- [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
 
 ## Packet controls: NetLabel - Fallback Peer Labeling
 
@@ -277,20 +287,19 @@ commands will fail.
 
 Before the NetLabel rules can be loaded, TE rules must be added to
 define the types. Then the rules can allow domains to receive data
-from objects of `peer` class:
+from objects of *peer* class:
 
 ```
 type netlabel_sctp_peer_t;
 
 allow my_server_t netlabel_sctp_peer_t:peer recv;
 ```
-Note that sending can't be controlled with `peer` class.
+Note that sending can't be controlled with *peer* class.
 
 ## Packet controls: NetLabel – CIPSO/CALIPSO
 
 To allow MLS or MCS [**security levels**](mls_mcs.md#security-levels)
-to be passed over a network between MLS or MCS systems<a href="#fnn2"
-class="footnote-ref" id="fnnet2"><strong><sup>2</sup></strong></a>,
+to be passed over a network between MLS or MCS systems[^fn_ns_2],
 the Commercial IP Security Option (CIPSO) protocol is used. This is defined in the
 [**CIPSO Internet Draft**](http://tools.ietf.org/html/draft-ietf-cipso-ipsecurity-01)
 document (this is an obsolete document, however the protocol is still in
@@ -311,11 +320,12 @@ The protocol is configured by the NetLabel service
 ***netlabelctl**(8)* and can be used by other security modules that use
 the LSM infrastructure. The implementation supports:
 
-1.  A non-translation option (Tag Type 1 '**bit mapped**') where labels are
-    passed to / from systems unchanged (for host to host communications as
-    show in **Figure 15**).
--   Note that CALIPSO only supports this option, and an example
-    ***netlabelctl**(8)* command setting a DOI of 16 is:
+1. A non-translation option (Tag Type 1 '**bit mapped**') where labels are
+   passed to / from systems unchanged (for host to host communications as
+   show in **Figure 15**).
+   - Note that CALIPSO only supports this option, and an example
+     ***netlabelctl**(8)* command setting a DOI of 16 is:
+
 ```
 netlabelctl calipso add pass doi:16
 ```
@@ -324,15 +334,15 @@ netlabelctl calipso add pass doi:16
 
 **Figure 15:** - *MLS Systems on the same network*
 
-2.  Allow a maximum of 256 sensitivity levels and 240 categories to be mapped
-    (Tag Type 2 '**enumerated**').
+2. Allow a maximum of 256 sensitivity levels and 240 categories to be mapped
+   (Tag Type 2 '**enumerated**').
 
-3.  A translation option (Tag Type 5 '**range**') where both the sensitivity
-    and category components can be mapped for systems that have either different
-    definitions for labels or information can be exchanged over different
-    networks (for example using an SELinux enabled gateway as a guard as
-    shown in **Figure 16**. An example ***netlabelctl**(8)* command setting
-    a DOI of 8 is: *netlabelctl cipsov4 add pass doi:8 tags:5*
+3. A translation option (Tag Type 5 '**range**') where both the sensitivity
+   and category components can be mapped for systems that have either different
+   definitions for labels or information can be exchanged over different
+   networks (for example using an SELinux enabled gateway as a guard as
+   shown in **Figure 16**. An example ***netlabelctl**(8)* command setting
+   a DOI of 8 is: *netlabelctl cipsov4 add pass doi:8 tags:5*
 
 ![](./images/16-mls2.png)
 
@@ -377,20 +387,18 @@ two systems as part of the channel set-up.*
 
 Basically what happens is as follows:
 
-1.  The security policy database (SPD) defines the security
-    communications characteristics to be used between the two systems.
-    This is populated using the **setkey**(8) or ***ip-xfrm**(8)* commands.
-2.  The SAs have their configuration parameters such as protocols used
-    for securing packets, encryption algorithms and how long the keys
-    are valid held in the Security Association database (SAD). For
-    Labeled IPSec the security context (or labels) is also defined
-    within the SAD. SAs can be negotiated between the two systems using
-    either racoon or
-    pluto<a href="#fnn3" class="footnote-ref" id="fnnet3"><strong><sup>3</sup></strong></a>
-    that will automatically populate the SAD or manually by the setkey utility
-    (see the example below).
-3.  Once the SAs have been negotiated and agreed, the link should be
-    active.
+1. The security policy database (SPD) defines the security
+   communications characteristics to be used between the two systems.
+   This is populated using the **setkey**(8) or ***ip-xfrm**(8)* commands.
+2. The SAs have their configuration parameters such as protocols used
+   for securing packets, encryption algorithms and how long the keys
+   are valid held in the Security Association database (SAD). For
+   Labeled IPSec the security context (or labels) is also defined
+   within the SAD. SAs can be negotiated between the two systems using
+   either racoon or pluto[^fn_ns_3] that will automatically populate the
+   SAD or manually by the setkey utility (see the example below).
+3. Once the SAs have been negotiated and agreed, the link should be
+   active.
 
 A point to note is that SAs are one way only, therefore when two systems
 are communicating (using the above example), one system will have an SA,
@@ -405,26 +413,25 @@ protocol (e.g. ESP (encapsulated security payload) and AH
 The object class used for the association of an SA is association and
 the permissions available are as follows:
 
-<table>
-<tbody>
-<tr>
-<td><code>polmatch</code></td>
-<td>Match the SPD context (-ctx) entry to an SELinux domain (that is contained in the SAD -ctx entry)</td>
-</tr>
-<tr>
-<td><code>recvfrom</code></td>
-<td>Receive from an IPSec association.</td>
-</tr>
-<tr>
-<td><code>sendto</code></td>
-<td>Send to an IPSec association.</td>
-</tr>
-<tr>
-<td><code>setcontext</code></td>
-<td>Set the context of an IPSec association on creation (e.g. when running setkey the process will require this permission to set the context in the SAD and SPD, also racoon / <em>pluto</em> will need this permission to build the SAD).</td>
-</tr>
-</tbody>
-</table>
+*polmatch*
+
+- Match the SPD context (-ctx) entry to an SELinux domain (that is contained
+  in the SAD -ctx entry)
+
+*recvfrom*
+
+- Receive from an IPSec association.
+
+*sendto*
+
+- Send to an IPSec association.
+
+*setcontext*
+
+- Set the context of an IPSec association on creation (e.g. when running
+  ***setkey**(8)* the process will require this permission to set the context
+  in the SAD and SPD, also *racoon* / *pluto* will need this permission to
+  build the SAD).
 
 When running Labeled IPSec it is recommended that the systems use the
 same type/version of policy to avoid any problems with them having
@@ -432,12 +439,11 @@ different meanings.
 
 There are two possible labeled IPSec solutions available on Fedora:
 
--   IPSec Tools - This uses the ***setkey**(8)* tools and ***racoon**(8)*
-Internet Key Exchange (IKE) daemon.
-
--   LibreSwan - This uses ***ipsec**(8)* tools and ***pluto**(8)* Internet
-Key Exchange (IKE) daemon. Note that the Fedora build uses the kernel
-**netkey** services as Libreswan can be built to support other types.
+1. IPSec Tools - This uses the ***setkey**(8)* tools and ***racoon**(8)*
+   Internet Key Exchange (IKE) daemon.
+2. LibreSwan - This uses ***ipsec**(8)* tools and ***pluto**(8)* Internet
+   Key Exchange (IKE) daemon. Note that the Fedora build uses the kernel
+   *netkey* services as Libreswan can be built to support other types.
 
 Both work in much the same way but use different configuration files.
 
@@ -472,7 +478,7 @@ firewall-cmd --add-service ipsec
 
 There are two simple examples in the
 [***notebook-examples/network/ipsec***](notebook-examples/network/README.md)
-section. These use ***setkey**(8)* and  commands directly
+section. These use ***setkey**(8)* and commands directly
 and therefore do not require the IKE daemons.
 
 The ***ip-xfrm**(8)* example:
@@ -500,31 +506,11 @@ article and a good reference covering **Basic Labeled IPsec Configuration**
 available at:
 <http://www.redhat.com/archives/redhat-lspp/2006-November/msg00051.html>
 
-## Labeled Network FileSystem (NFS)
-
-Version 4.2 of NFS supports labeling between client/server and requires
-the ***exports**(5)* / ***exportfs**(8)* '*security_label*' option to
-be set:
-
-```
-exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
-```
-
-Labeled NFS requires kernel 3.14 and the following package installed:
-
-```
-dnf install nfs-utils
-```
-
-Labeled NFS clients must use a consistent security policy.
-
-The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
-
 ## Packet controls: Access Control for Network Interfaces
 
 SELinux domains can be restricted to use only specific network
 interfaces. TE rules must define the interface types and then allow a
-domain to `egress` in class `netif` for the defined interface types:
+domain to *egress* in class *netif* for the defined interface types:
 
 ```
 require {
@@ -540,13 +526,14 @@ allow my_server_t loopback_if_t:netif egress;
 ```
 
 The interfaces must also be labeled with ***semanage**(8)* (or by
-using `netifcon` statements in the policy):
+using *netifcon* statements in the policy):
+
 ```
 semanage interface -a -t loopback_if_t -r s0 lo
 semanage interface -a -t external_if_t -r s0 eth0
 ```
 
-The checks for `ingress` in class `netif` however use the peer label
+The checks for *ingress* in class *netif* however use the peer label
 of the remote peer (not the receiving task on the local system) as
 subject:
 
@@ -569,9 +556,9 @@ Domains can be restricted by SELinux to access and bind sockets to
 only dedicated network nodes (in practice, IP addresses).
 
 The node types must be defined and then the node types can be used for
-TE rules as target context. TE rules to allow a domain to `sendto` for
-class `node` and to `node_bind` (for incoming connections) for class
-`tcp_socket`:
+TE rules as target context. TE rules to allow a domain to *sendto* for
+class *node* and to *node_bind* (for incoming connections) for class
+*tcp_socket*:
 
 ```
 require {
@@ -591,7 +578,8 @@ allow my_server_t internet_node_t:node sendto;
 ```
 
 After the types have been defined, corresponding node rules can be
-added with `semanage` (or `nodecon` statements):
+added with *semanage* (or *nodecon* statements):
+
 ```
 semanage node -a -M /128 -p ipv6 -t loopback_node_t -r s0 ::1
 semanage node -a -M /3 -p ipv6 -t internet_node_t -r s0 2000::
@@ -599,7 +587,7 @@ semanage node -a -M /8 -p ipv6 -t link_local_node_t -r s0 fe00::
 semanage node -a -M /8 -p ipv6 -t multicast_node_t -r s0 ff00::
 ```
 
-The checks for `recvfrom` in class `node` however use the peer label
+The checks for *recvfrom* in class *node* however use the peer label
 as subject:
 
 ```
@@ -614,12 +602,12 @@ packet level controls, port controls are close to how networked
 applications use the socket system calls. Thus the controls typically
 involve checking if a task can perform an operation on a network
 socket, e.g. ***bind**(2)* would cause an access check for
-`node_bind`. These are usually easy to understand and don't require
+*node_bind*. These are usually easy to understand and don't require
 any special network configuration.
 
 TE rules must define the port types and then allow a domain to
-`name_connect` (outgoing) or `name_bind` (incoming) in class
-`tcp_socket` (or `udp_socket` etc) for the defined port types:
+*name_connect* (outgoing) or *name_bind* (incoming) in class
+*tcp_socket* (or *udp_socket* etc) for the defined port types:
 
 ```
 require {
@@ -633,19 +621,43 @@ allow my_server_t my_server_port_t:tcp_socket name_connect;
 allow my_server_t my_server_port_t:tcp_socket name_bind;
 ```
 
-The ports must also be labeled with `semanage` (or `portcon`
+The ports must also be labeled with *semanage* (or *portcon*
 statements):
 ```
 semanage port -a -t my_server_port_t -p tcp -r s0 12345
 ```
 
-<section class="footnotes">
-<ol>
-<li id="fnn1"><p>For example, an ftp session where the server is listening on a specific port (the destination port) but the client will be assigned a random source port. The CONNSECMARK will ensure that all packets for the ftp session are marked with the same label.<a href="#fnnet1" class="footnote-back">↩</a></p></li>
-<li id="fnn2"><p>Note only the security levels are passed over the network as the other components of the security context are not part of standard MLS systems (as it may be that the remote end is a Trusted Solaris system).<a href="#fnnet2" class="footnote-back">↩</a></p></li>
-<li id="fnn3"><p>These are the Internet Key Exchange (IKE) daemons that exchange encryption keys securely and also supports Labeled IPSec parameter exchanges.<a href="#fnnet3" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+## Labeled Network FileSystem (NFS)
+
+Version 4.2 of NFS supports labeling between client/server and requires
+the ***exports**(5)* / ***exportfs**(8)* '*security_label*' option to
+be set:
+
+```
+exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
+```
+
+Labeled NFS requires kernel 3.14 and the following package installed:
+
+```
+dnf install nfs-utils
+```
+
+Labeled NFS clients must use a consistent security policy.
+
+The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
+
+[^fn_ns_1]: For example, an ftp session where the server is listening on a
+specific port (the destination port) but the client will be assigned a random
+source port. The *CONNSECMARK* will ensure that all packets for the ftp session
+are marked with the same label.
+
+[^fn_ns_2]: Note only the security levels are passed over the network as the
+other components of the security context are not part of standard MLS systems
+(as it may be that the remote end is a Trusted Solaris system)
+
+[^fn_ns_3]: These are the Internet Key Exchange (IKE) daemons that exchange
+encryption keys securely and also supports Labeled IPSec parameter exchanges.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

