Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C4C433E1
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403CA2070B
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="j0Uc4jc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgG0Ug0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgG0UgZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 16:36:25 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C57BEC061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 13:36:24 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 55D1A2A1007;
        Mon, 27 Jul 2020 22:36:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 55D1A2A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595882182;
        bh=kkz2UjwoEbwe61zaFEA19/4LQqyV+QYUe3s7JjaGnl0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=j0Uc4jc5M+K7HnJ7oz0hmF/BSIy3hDQsomHuvHI6jrysw5SyoJhGXeaDB83OUPKzS
         g2BJFz1V0f2o0jUPo2IcNzgnDU8M6Yz8WqBcBZ5PE6av5QUwTdeEJvWiRlhpnXhzj+
         cBI26H3AMeqzuCea+1yQvKsamx1AmmJ/BKne7CIo=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] Improve network_support.md
References: <20200727130428.8234-1-toiwoton@gmail.com>
        <ypjlwo2pm56q.fsf@defensec.nl>
        <100b1c8c-a756-c6e5-5514-a8a9dc6fc117@gmail.com>
        <ypjlsgddm0gv.fsf@defensec.nl>
        <5ec03092-decb-d861-aeb3-800bc4ff0574@gmail.com>
Date:   Mon, 27 Jul 2020 22:36:18 +0200
In-Reply-To: <5ec03092-decb-d861-aeb3-800bc4ff0574@gmail.com> (Topi
        Miettinen's message of "Mon, 27 Jul 2020 23:20:50 +0300")
Message-ID: <ypjlo8o0n1a5.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> On 27.7.2020 18.39, Dominick Grift wrote:
>> Topi Miettinen <toiwoton@gmail.com> writes:
>>
>>> On 27.7.2020 16.57, Dominick Grift wrote:
>>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>>
>>>>> List all access control methods available for networking and provide
>>>>> examples for each.
>>>>>
>>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>>>
>>>>> ---
>>>>> v2: address comments from Richard Haines
>>>>> ---
>>>>>    src/network_statements.md |   2 +-
>>>>>    src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-=
----
>>>>>    2 files changed, 150 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/src/network_statements.md b/src/network_statements.md
>>>>> index ef1c873..357c3b1 100644
>>>>> --- a/src/network_statements.md
>>>>> +++ b/src/network_statements.md
>>>>> @@ -102,7 +102,7 @@ the interface to a security context.
>>>>>    <tr>
>>>>>    <td><code>packet_context</code></td>
>>>>>    <td><p>The security context allocated packets. Note that these are=
 defined but unused.</p>
>>>>> -<p>The iptables(8)/nftables(8) <a href=3D"network_support.md#secmark=
">SECMARK services</a> should be used to label packets.</p></td>
>>>>> +<p>The iptables(8)/nftables(8) <a
>>>>> href=3D"network_support.md#internal-labeling-secmark">SECMARK
>>>>> services</a> should be used to label packets.</p></td>
>>>>>    </tr>
>>>>>    </tbody>
>>>>>    </table>
>>>>> diff --git a/src/network_support.md b/src/network_support.md
>>>>> index 309e863..6f9896b 100644
>>>>> --- a/src/network_support.md
>>>>> +++ b/src/network_support.md
>>>>> @@ -1,20 +1,17 @@
>>>>>    # SELinux Networking Support
>>>>>    -SELinux supports the following types of network labeling:
>>>>> +SELinux supports several methods for access control of networks. The=
se are
>>>>>    -**Internal labeling** - This is where network objects are
>>>>> labeled and
>>>>> -managed internally within a single machine (i.e. their labels are not
>>>>> -transmitted as part of the session with remote systems). There are t=
wo
>>>>> -types supported: SECMARK and NetLabel. There was a service known as
>>>>> -'compat_net' controls, however that was removed in kernel 2.6.30.
>>>>> +* Packet labeling: class `packet`
>>>>> +* Peer labeling: class `peer`
>>>>> +* Interface control: class `netif`
>>>>> +* Network node control: class `node`
>>>>> +* TCP/UDP/SCTP/DCCP ports: class `port`
>>>>>    -**Labeled Networking** - This is where labels are passed to/from
>>>>> remote
>>>>> -systems where they can be interpreted and a MAC policy enforced on e=
ach
>>>>> -system. There are three types supported: Labeled IPSec, CIPSO
>>>>> -(Commercial IP Security Option) and CALIPSO (Common Architecture Lab=
el
>>>>> -IPv6 Security Option)
>>>>> +Networking support is not enabled by default. It can be enabled eith=
er
>>>>> +the policy capabilities or by loading SECMARK rules.
>>>>>    -There are two policy capability options that can be set within
>>>>> policy
>>>>> +There are three policy capability options that can be set within pol=
icy
>>>>>    using the `policycap` statement that affect networking configurati=
on:
>>>>>      **`network_peer_controls`** - This is always enabled in the
>>>>> latest
>>>>> @@ -37,8 +34,22 @@ The policy capability settings are available in us=
erspace via the
>>>>>    SELinux filesystem as shown in the
>>>>>    [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) sectio=
n.
>>>>>    -To support peer labeling, CIPSO and CALIPSO the NetLabel tools
>>>>> need to
>>>>> -be installed:
>>>>> +SELinux supports the following types of network labeling:
>>>>> +
>>>>> +**Internal labeling** - This is where network objects are labeled and
>>>>> +managed internally within a single machine (i.e. their labels are not
>>>>> +transmitted as part of the session with remote systems). There are t=
wo
>>>>> +types supported: SECMARK and NetLabel. There was a service known as
>>>>> +'compat_net' controls, however that was removed in kernel 2.6.30.
>>>>> +
>>>>> +**Labeled Networking** - This is where labels are passed to/from rem=
ote
>>>>> +systems where they can be interpreted and a MAC policy enforced on e=
ach
>>>>> +system. There are three types supported: Labeled IPSec, CIPSO
>>>>> +(Commercial IP Security Option) and CALIPSO (Common Architecture Lab=
el
>>>>> +IPv6 Security Option).
>>>>> +
>>>>> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
>>>>> +the NetLabel tools need to be installed:
>>>>>      `dnf install netlabel_tools`
>>>>>    @@ -52,8 +63,12 @@ OpenSwan but is now distributed as LibreSwan:
>>>>>    `dnf install libreswan`
>>>>>      It is important to note that the kernel must be configured to
>>>>> support
>>>>> -these services. The Fedora kernels are configured to handle all the =
above
>>>>> -services.
>>>>> +these services (`CONFIG_NETLABEL`, `CONFIG_NETWORK_SECMARK`,
>>>>> +`CONFIG_NF_CONNTRACK_SECMARK`,
>>>>> +`CONFIG_NETFILTER_XT_TARGET_CONNSECMARK`,
>>>>> +`CONFIG_NETFILTER_XT_TARGET_SECMARK`, `CONFIG_IP_NF_SECURITY`,
>>>>> +`CONFIG_IP6_NF_SECURITY`). At least Fedora and Debian kernels are
>>>>> +configured to handle all the above services.
>>>>>      The Linux networking package *iproute* has an SELinux aware
>>>>> socket
>>>>>    statistics command ***ss**(8)* that will show the SELinux context =
of
>>>>> @@ -65,7 +80,7 @@ to achieve this).
>>>>>      <br>
>>>>>    -## SECMARK
>>>>> +## Internal labeling: SECMARK
>>>>>      SECMARK makes use of the standard kernel NetFilter framework
>>>>> that
>>>>>    underpins the GNU / Linux IP networking sub-system. NetFilter serv=
ices
>>>>> @@ -73,7 +88,7 @@ automatically inspects all incoming and outgoing pa=
ckets and can place
>>>>>    controls on interfaces, IP addresses (nodes) and ports with the ad=
ded
>>>>>    advantage of connection tracking. The SECMARK security extensions =
allow
>>>>>    security contexts to be added to packets (SECMARK) or sessions
>>>>> -(CONNSECMARK).
>>>>> +(CONNSECMARK), belonging to object class of `packet`.
>>>>>      The NetFilter framework inspects and tag packets with labels as
>>>>> defined
>>>>>    within ***iptables**(8)* (also 'nftables' ***nft**(8)* from versio=
n 9.3 with
>>>>> @@ -172,6 +187,16 @@ table ip6 security {
>>>>>    }
>>>>>    ```
>>>>>    +Before the SECMARK rules can be loaded, TE rules must be added
>>>>> to
>>>>> +define the types, and also allow domains to send and/or receive
>>>>> +objects of `packet` class:
>>>>> +
>>>>> +```
>>>>> +type test_server_packet_t, packet_type;
>>>>> +
>>>>> +allow my_server_t test_server_packet_t:packet { send recv };
>>>>> +```
>>>>> +
>>>>>    The following articles explain the SECMARK service:
>>>>>    -   [*Transitioning to Secmark*](http://paulmoore.livejournal.com/=
4281.html)
>>>>>    -   [New secmark-based network controls for SELinux](http://james-=
morris.livejournal.com/11010.html)
>>>>> @@ -179,7 +204,7 @@ The following articles explain the SECMARK servic=
e:
>>>>>      <br>
>>>>>    -## NetLabel - Fallback Peer Labeling
>>>>> +## Internal labeling: NetLabel - Fallback Peer Labeling
>>>>>      Fallback labeling can optionally be implemented on a system if
>>>>> the
>>>>>    Labeled IPSec or CIPSO/CALIPSO is not being used (hence 'fallback
>>>>> @@ -217,9 +242,20 @@ netlabelctl -p map list
>>>>>    Note that the security contexts must be valid in the policy otherw=
ise the
>>>>>    commands will fail.
>>>>>    +Before the NetLabel rules can be loaded, TE rules must be added
>>>>> to
>>>>> +define the types. Then the rules can allow domains to receive data
>>>>> +from objects of `peer` class:
>>>>> +
>>>>> +```
>>>>> +type netlabel_sctp_peer_t;
>>>>> +
>>>>> +allow my_server_t netlabel_sctp_peer_t:peer recv;
>>>>> +```
>>>>> +Note that sending can't be controlled with `peer` class.
>>>>> +
>>>>>    <br>
>>>>>    -## NetLabel =E2=80=93 CIPSO/CALIPSO
>>>>> +## Labeled Networking: NetLabel =E2=80=93 CIPSO/CALIPSO
>>>>>      To allow MLS [**security levels**](mls_mcs.md#security-levels)
>>>>> to be passed
>>>>>    over a network between MLS
>>>>> @@ -288,7 +324,7 @@ section, plus the standard Fedora 'targeted' poli=
cy for the tests.
>>>>>      <br>
>>>>>    -## Labeled IPSec
>>>>> +## Labeled Networking: Labeled IPSec
>>>>>      Labeled IPSec has been built into the standard GNU / Linux
>>>>> IPSec
>>>>>    services as described in the
>>>>> @@ -451,6 +487,98 @@ The *selinux-testsuite tools/nfs.sh* tests label=
ed NFS using various labels.
>>>>>      <br>
>>>>>    +## Access Control for Network Interfaces
>>>>> +
>>>>> +SELinux domains can be restricted to use only specific network
>>>>> +interfaces. TE rules must define the interface types and then allow a
>>>>> +domain to `egress` in class `netif` for the defined interface types:
>>>>> +
>>>>> +```
>>>>> +require {
>>>>> +        attribute netif_type;
>>>>> +}
>>>>> +
>>>>> +type external_if_t, netif_type;
>>>>> +type loopback_if_t, netif_type;
>>>>> +
>>>>> +allow my_server_t external_if_t:netif egress;
>>>>> +allow my_server_t loopback_if_t:netif egress;
>>>>> +```
>>>>> +
>>>>> +The interfaces must also be labeled with ***semanage**(8)* (or by
>>>>> +using `netifcon` statements in the policy):
>>>>> +```
>>>>> +semanage interface -a -t loopback_if_t -r s0 lo
>>>>> +semanage interface -a -t external_if_t -r s0 eth0
>>>>> +```
>>>>> +
>>>>> +Note that reception can't be controlled with `netif` class.
>>>>
>>>> Probably nothing but I did not understand this: Is reception not
>>>> controlled with the netif ingress permission?
>>>
>>> I'm no expert, but the only netif ingress rules which I have are
>>> rather generic:
>>>
>>> allow internet_peer_t external_if_t:netif ingress;
>>> allow link_local_peer_t external_if_t:netif ingress;
>>> allow localnet_peer_t external_if_t:netif ingress;
>>> allow multicast_peer_t external_if_t:netif ingress;
>>> allow loopback_peer_t loopback_if_t:netif ingress;
>>>
>>> `peer` types above have been added with NetLabel rules like:
>>>
>>> netlabelctl unlbl add default address:2000::/3
>>> label:system_u:object_r:internet_peer_t:s0
>>>
>>> Perhaps this would be better:
>>>
>>> Note that reception for application domains can't be controlled with
>>> `netif` class.
>>>
>>
>> I look at it this way: peers *are* processes, You seem to
>> essentually use peers as nodes above.
>
> I think both are true. When labeled IPSec is used, it's probably (I
> haven't tried it yet) possible to identify peers at process
> level. Without IPSec it's only possible to get peer labeling with
> NetLabel rules, which only allow IP address (host or even networks of
> hosts) level accuracy.
>

The thing, i think, is that netlabel is limited and really geared
towards MLS, it will only send levels over the wire i believe (except for l=
oopback)

By AFAIK the point of netlabel is to be able enforce mult-level security
on secure networks. For example you could have a ssh server running on a
particular level. In other words netlabel AFAIK should be able to send a
process/peer level over the network AFAIK.

>> It would become more clear if you would try this out with labeled ipsec.
>> A peer, in my experience is kind of the same as an association in the
>> labeled ipsec scenario (the classes actually overlap). That is also why
>> you should probably disable the netlabel_peer_controls polcap if you use
>> labeled ipsec.
>
> Right, but I think my setup could be useful for cases where labeled
> IPSec is not used.
>
> Do you see AVC denials etc. for netif *ingress* for process level
> domains with labeled IPSec?

I use to have extensive recordings and blogs about this matter but i
erased it all, and i currently dont have a ipsec tunnel, or avc denials,
but I do vaguely recall that the ingress with labeled ipsec was on a per pr=
ocess
level. I might be wrong though.

I would probably just omit the line about the reception to be on the
safe side. (can always add that later if needed)

>
> -Topi
>
>>>>
>>>>> +
>>>>> +<br>
>>>>> +
>>>>> +## Access Control for Network Nodes
>>>>> +
>>>>> +Domains can be restricted by SELinux to access and bind sockets to
>>>>> +only dedicated network nodes (in practice, IP addresses).
>>>>> +
>>>>> +The node types must be defined and then the node types can be used f=
or
>>>>> +TE rules as target context. TE rules to allow a domain to `sendto` f=
or
>>>>> +class `node` and to `node_bind` (for incoming connections) for class
>>>>> +`tcp_socket`:
>>>>> +
>>>>> +```
>>>>> +require {
>>>>> +        attribute node_type;
>>>>> +}
>>>>> +
>>>>> +type loopback_node_t, node_type;
>>>>> +type internet_node_t, node_type;
>>>>> +type link_local_node_t, node_type;
>>>>> +type multicast_node_t, node_type;
>>>>> +
>>>>> +allow my_server_t loopback_node_t:node sendto;
>>>>> +allow my_server_t loopback_node_t:tcp_socket node_bind;
>>>>> +allow my_server_t internet_node_t:node sendto;
>>>>> +```
>>>>> +
>>>>> +After the types have been defined, corresponding node rules can be
>>>>> +added with `semanage` (or `nodecon` statements):
>>>>> +```
>>>>> +semanage node -a -M /128 -p ipv6 -t loopback_node_t -r s0 ::1
>>>>> +semanage node -a -M /3 -p ipv6 -t internet_node_t -r s0 2000::
>>>>> +semanage node -a -M /8 -p ipv6 -t link_local_node_t -r s0 fe00::
>>>>> +semanage node -a -M /8 -p ipv6 -t multicast_node_t -r s0 ff00::
>>>>> +```
>>>>> +
>>>>> +<br>
>>>>> +
>>>>> +## Access Control for Network Ports
>>>>> +
>>>>> +SELinux policy can also control access to ports used by various
>>>>> +networking protocols such as TCP, UDP, SCTP and DCCP. TE rules must
>>>>> +define the port types and then allow a domain to `name_connect`
>>>>> +(outgoing) or `name_bind` (incoming) in class `tcp_socket` (or
>>>>> +`udp_socket` etc) for the defined port types:
>>>>> +
>>>>> +```
>>>>> +require {
>>>>> +        attribute port_type;
>>>>> +}
>>>>> +
>>>>> +type my_server_port_t, port_type;
>>>>> +
>>>>> +allow my_server_t my_server_port_t:tcp_socket name_connect;
>>>>> +allow my_server_t my_server_port_t:tcp_socket name_bind;
>>>>> +```
>>>>> +
>>>>> +The ports must also be labeled with `semanage` (or `portcon`
>>>>> +statements):
>>>>> +```
>>>>> +semanage port -a -t my_server_port_t -p tcp -r s0 12345
>>>>> +```
>>>>> +
>>>>> +<br>
>>>>> +
>>>>>    <section class=3D"footnotes">
>>>>>    <ol>
>>>>>    <li id=3D"fnn1"><p>For example, an ftp session where the server is
>>>>> listening on a specific port (the destination port) but the client
>>>>> will be assigned a random source port. The CONNSECMARK will ensure
>>>>> that all packets for the ftp session are marked with the same label.<a
>>>>> href=3D"#fnnet1" class=3D"footnote-back">=E2=86=A9</a></p></li>
>>>>
>>>
>>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
