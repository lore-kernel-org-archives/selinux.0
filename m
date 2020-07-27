Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE81C433E4
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6156720729
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq6xpN6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG0Voo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Von (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 17:44:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A3C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 14:44:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s16so3678303ljc.8
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2v35xk4v97tvaKiwaYluBtLZ4rKghUmWpVoxyf/YGcM=;
        b=hq6xpN6ysCJork87aBAx76K7l8+DaME1g9Bh7ALwpQNyO5vvW34cMbDUoYUxJrWc/c
         2B4Olim8wWnDNalyvDVC/HvM27cc0nbbaB1kiosLBhGmNaYLzJEpcW77/aqhlhVoNqEG
         vyco7Jyw6mKjS79ATiE4m58aeDh+pvA7X7EXu7uwgQ4vhd17tbZUZ5apyz1mylHbXgG0
         Ai+SRttRldv3Mq0xrzsejjCXa0xLaiJVeVlIk0F1nh+5OMJu+lyESp05GFPqOSrM2GwN
         c4O85NRuZauI5xXH1p8s2NVyboQUxsaZ683xLJ65Et8k3mvFu93uhTvfHpTdb7/sx4ob
         0E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2v35xk4v97tvaKiwaYluBtLZ4rKghUmWpVoxyf/YGcM=;
        b=WM4cBBl/Bw719LfN8wUI5NJMKCQoBRUDuWXc5ShFrn6Dqqfl0j5jEr8ufy+kc/ZHcz
         xQftOZOUJo+rp6UZygqJUX1S/uqaaCidnzRopD02EPJRcTIZ9AtPEO4/q7TOhAJP3q5/
         70wgzl+nprgmzLgF3rsCWdhEon/bEZjAvcEyfqlnOyWBRUnxQSkRGZnp/BSvsVIrjCO2
         +mAKZpk4y3jsTXf5lQQ544SfecJkSny2RfIoZcvIpnt3OLr2JVJy4fcbwpb2BDrdQPEo
         +taab/LSkc41jwY5XXoQ2xP1jhsh6WRhGy03OQQmxX1/B1t9ESasfeCGcYx1RQrr50iz
         UD7Q==
X-Gm-Message-State: AOAM533EfcUmwGdyR5XaoSlCkb5FNbc7Mzbko7n/uEmTtQuHFPL3/weq
        80ohGF/SebINxcmgaJvZOd+TbUbg
X-Google-Smtp-Source: ABdhPJw7SQ5tH2fIXghXVjp4Gqk4qqdP2F4Vy6M6k4HUgdFqfUN2vIepVIfcmwtiCKup6NO8HLSShQ==
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr2604398ljg.10.1595886281169;
        Mon, 27 Jul 2020 14:44:41 -0700 (PDT)
Received: from [192.168.1.86] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id g2sm2961360ljj.90.2020.07.27.14.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:44:40 -0700 (PDT)
Subject: Re: [PATCH v2] Improve network_support.md
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
References: <20200727130428.8234-1-toiwoton@gmail.com>
 <ypjlwo2pm56q.fsf@defensec.nl>
 <100b1c8c-a756-c6e5-5514-a8a9dc6fc117@gmail.com>
 <ypjlsgddm0gv.fsf@defensec.nl>
 <5ec03092-decb-d861-aeb3-800bc4ff0574@gmail.com>
 <ypjlo8o0n1a5.fsf@defensec.nl>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <b1719aa3-1d5b-4f62-67f5-c7a207f11c0a@gmail.com>
Date:   Tue, 28 Jul 2020 00:44:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ypjlo8o0n1a5.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 27.7.2020 23.36, Dominick Grift wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> On 27.7.2020 18.39, Dominick Grift wrote:
>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>
>>>> On 27.7.2020 16.57, Dominick Grift wrote:
>>>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>>>
>>>>>> List all access control methods available for networking and provide
>>>>>> examples for each.
>>>>>>
>>>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>>>>
>>>>>> ---
>>>>>> v2: address comments from Richard Haines
>>>>>> ---
>>>>>>     src/network_statements.md |   2 +-
>>>>>>     src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-----
>>>>>>     2 files changed, 150 insertions(+), 22 deletions(-)
>>>>>>
>>>>>> diff --git a/src/network_statements.md b/src/network_statements.md
>>>>>> index ef1c873..357c3b1 100644
>>>>>> --- a/src/network_statements.md
>>>>>> +++ b/src/network_statements.md
>>>>>> @@ -102,7 +102,7 @@ the interface to a security context.
>>>>>>     <tr>
>>>>>>     <td><code>packet_context</code></td>
>>>>>>     <td><p>The security context allocated packets. Note that these are defined but unused.</p>
>>>>>> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
>>>>>> +<p>The iptables(8)/nftables(8) <a
>>>>>> href="network_support.md#internal-labeling-secmark">SECMARK
>>>>>> services</a> should be used to label packets.</p></td>
>>>>>>     </tr>
>>>>>>     </tbody>
>>>>>>     </table>
>>>>>> diff --git a/src/network_support.md b/src/network_support.md
>>>>>> index 309e863..6f9896b 100644
>>>>>> --- a/src/network_support.md
>>>>>> +++ b/src/network_support.md
>>>>>> @@ -1,20 +1,17 @@
>>>>>>     # SELinux Networking Support
>>>>>>     -SELinux supports the following types of network labeling:
>>>>>> +SELinux supports several methods for access control of networks. These are
>>>>>>     -**Internal labeling** - This is where network objects are
>>>>>> labeled and
>>>>>> -managed internally within a single machine (i.e. their labels are not
>>>>>> -transmitted as part of the session with remote systems). There are two
>>>>>> -types supported: SECMARK and NetLabel. There was a service known as
>>>>>> -'compat_net' controls, however that was removed in kernel 2.6.30.
>>>>>> +* Packet labeling: class `packet`
>>>>>> +* Peer labeling: class `peer`
>>>>>> +* Interface control: class `netif`
>>>>>> +* Network node control: class `node`
>>>>>> +* TCP/UDP/SCTP/DCCP ports: class `port`
>>>>>>     -**Labeled Networking** - This is where labels are passed to/from
>>>>>> remote
>>>>>> -systems where they can be interpreted and a MAC policy enforced on each
>>>>>> -system. There are three types supported: Labeled IPSec, CIPSO
>>>>>> -(Commercial IP Security Option) and CALIPSO (Common Architecture Label
>>>>>> -IPv6 Security Option)
>>>>>> +Networking support is not enabled by default. It can be enabled either
>>>>>> +the policy capabilities or by loading SECMARK rules.
>>>>>>     -There are two policy capability options that can be set within
>>>>>> policy
>>>>>> +There are three policy capability options that can be set within policy
>>>>>>     using the `policycap` statement that affect networking configuration:
>>>>>>       **`network_peer_controls`** - This is always enabled in the
>>>>>> latest
>>>>>> @@ -37,8 +34,22 @@ The policy capability settings are available in userspace via the
>>>>>>     SELinux filesystem as shown in the
>>>>>>     [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>>>>>>     -To support peer labeling, CIPSO and CALIPSO the NetLabel tools
>>>>>> need to
>>>>>> -be installed:
>>>>>> +SELinux supports the following types of network labeling:
>>>>>> +
>>>>>> +**Internal labeling** - This is where network objects are labeled and
>>>>>> +managed internally within a single machine (i.e. their labels are not
>>>>>> +transmitted as part of the session with remote systems). There are two
>>>>>> +types supported: SECMARK and NetLabel. There was a service known as
>>>>>> +'compat_net' controls, however that was removed in kernel 2.6.30.
>>>>>> +
>>>>>> +**Labeled Networking** - This is where labels are passed to/from remote
>>>>>> +systems where they can be interpreted and a MAC policy enforced on each
>>>>>> +system. There are three types supported: Labeled IPSec, CIPSO
>>>>>> +(Commercial IP Security Option) and CALIPSO (Common Architecture Label
>>>>>> +IPv6 Security Option).
>>>>>> +
>>>>>> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
>>>>>> +the NetLabel tools need to be installed:
>>>>>>       `dnf install netlabel_tools`
>>>>>>     @@ -52,8 +63,12 @@ OpenSwan but is now distributed as LibreSwan:
>>>>>>     `dnf install libreswan`
>>>>>>       It is important to note that the kernel must be configured to
>>>>>> support
>>>>>> -these services. The Fedora kernels are configured to handle all the above
>>>>>> -services.
>>>>>> +these services (`CONFIG_NETLABEL`, `CONFIG_NETWORK_SECMARK`,
>>>>>> +`CONFIG_NF_CONNTRACK_SECMARK`,
>>>>>> +`CONFIG_NETFILTER_XT_TARGET_CONNSECMARK`,
>>>>>> +`CONFIG_NETFILTER_XT_TARGET_SECMARK`, `CONFIG_IP_NF_SECURITY`,
>>>>>> +`CONFIG_IP6_NF_SECURITY`). At least Fedora and Debian kernels are
>>>>>> +configured to handle all the above services.
>>>>>>       The Linux networking package *iproute* has an SELinux aware
>>>>>> socket
>>>>>>     statistics command ***ss**(8)* that will show the SELinux context of
>>>>>> @@ -65,7 +80,7 @@ to achieve this).
>>>>>>       <br>
>>>>>>     -## SECMARK
>>>>>> +## Internal labeling: SECMARK
>>>>>>       SECMARK makes use of the standard kernel NetFilter framework
>>>>>> that
>>>>>>     underpins the GNU / Linux IP networking sub-system. NetFilter services
>>>>>> @@ -73,7 +88,7 @@ automatically inspects all incoming and outgoing packets and can place
>>>>>>     controls on interfaces, IP addresses (nodes) and ports with the added
>>>>>>     advantage of connection tracking. The SECMARK security extensions allow
>>>>>>     security contexts to be added to packets (SECMARK) or sessions
>>>>>> -(CONNSECMARK).
>>>>>> +(CONNSECMARK), belonging to object class of `packet`.
>>>>>>       The NetFilter framework inspects and tag packets with labels as
>>>>>> defined
>>>>>>     within ***iptables**(8)* (also 'nftables' ***nft**(8)* from version 9.3 with
>>>>>> @@ -172,6 +187,16 @@ table ip6 security {
>>>>>>     }
>>>>>>     ```
>>>>>>     +Before the SECMARK rules can be loaded, TE rules must be added
>>>>>> to
>>>>>> +define the types, and also allow domains to send and/or receive
>>>>>> +objects of `packet` class:
>>>>>> +
>>>>>> +```
>>>>>> +type test_server_packet_t, packet_type;
>>>>>> +
>>>>>> +allow my_server_t test_server_packet_t:packet { send recv };
>>>>>> +```
>>>>>> +
>>>>>>     The following articles explain the SECMARK service:
>>>>>>     -   [*Transitioning to Secmark*](http://paulmoore.livejournal.com/4281.html)
>>>>>>     -   [New secmark-based network controls for SELinux](http://james-morris.livejournal.com/11010.html)
>>>>>> @@ -179,7 +204,7 @@ The following articles explain the SECMARK service:
>>>>>>       <br>
>>>>>>     -## NetLabel - Fallback Peer Labeling
>>>>>> +## Internal labeling: NetLabel - Fallback Peer Labeling
>>>>>>       Fallback labeling can optionally be implemented on a system if
>>>>>> the
>>>>>>     Labeled IPSec or CIPSO/CALIPSO is not being used (hence 'fallback
>>>>>> @@ -217,9 +242,20 @@ netlabelctl -p map list
>>>>>>     Note that the security contexts must be valid in the policy otherwise the
>>>>>>     commands will fail.
>>>>>>     +Before the NetLabel rules can be loaded, TE rules must be added
>>>>>> to
>>>>>> +define the types. Then the rules can allow domains to receive data
>>>>>> +from objects of `peer` class:
>>>>>> +
>>>>>> +```
>>>>>> +type netlabel_sctp_peer_t;
>>>>>> +
>>>>>> +allow my_server_t netlabel_sctp_peer_t:peer recv;
>>>>>> +```
>>>>>> +Note that sending can't be controlled with `peer` class.
>>>>>> +
>>>>>>     <br>
>>>>>>     -## NetLabel – CIPSO/CALIPSO
>>>>>> +## Labeled Networking: NetLabel – CIPSO/CALIPSO
>>>>>>       To allow MLS [**security levels**](mls_mcs.md#security-levels)
>>>>>> to be passed
>>>>>>     over a network between MLS
>>>>>> @@ -288,7 +324,7 @@ section, plus the standard Fedora 'targeted' policy for the tests.
>>>>>>       <br>
>>>>>>     -## Labeled IPSec
>>>>>> +## Labeled Networking: Labeled IPSec
>>>>>>       Labeled IPSec has been built into the standard GNU / Linux
>>>>>> IPSec
>>>>>>     services as described in the
>>>>>> @@ -451,6 +487,98 @@ The *selinux-testsuite tools/nfs.sh* tests labeled NFS using various labels.
>>>>>>       <br>
>>>>>>     +## Access Control for Network Interfaces
>>>>>> +
>>>>>> +SELinux domains can be restricted to use only specific network
>>>>>> +interfaces. TE rules must define the interface types and then allow a
>>>>>> +domain to `egress` in class `netif` for the defined interface types:
>>>>>> +
>>>>>> +```
>>>>>> +require {
>>>>>> +        attribute netif_type;
>>>>>> +}
>>>>>> +
>>>>>> +type external_if_t, netif_type;
>>>>>> +type loopback_if_t, netif_type;
>>>>>> +
>>>>>> +allow my_server_t external_if_t:netif egress;
>>>>>> +allow my_server_t loopback_if_t:netif egress;
>>>>>> +```
>>>>>> +
>>>>>> +The interfaces must also be labeled with ***semanage**(8)* (or by
>>>>>> +using `netifcon` statements in the policy):
>>>>>> +```
>>>>>> +semanage interface -a -t loopback_if_t -r s0 lo
>>>>>> +semanage interface -a -t external_if_t -r s0 eth0
>>>>>> +```
>>>>>> +
>>>>>> +Note that reception can't be controlled with `netif` class.
>>>>>
>>>>> Probably nothing but I did not understand this: Is reception not
>>>>> controlled with the netif ingress permission?
>>>>
>>>> I'm no expert, but the only netif ingress rules which I have are
>>>> rather generic:
>>>>
>>>> allow internet_peer_t external_if_t:netif ingress;
>>>> allow link_local_peer_t external_if_t:netif ingress;
>>>> allow localnet_peer_t external_if_t:netif ingress;
>>>> allow multicast_peer_t external_if_t:netif ingress;
>>>> allow loopback_peer_t loopback_if_t:netif ingress;
>>>>
>>>> `peer` types above have been added with NetLabel rules like:
>>>>
>>>> netlabelctl unlbl add default address:2000::/3
>>>> label:system_u:object_r:internet_peer_t:s0
>>>>
>>>> Perhaps this would be better:
>>>>
>>>> Note that reception for application domains can't be controlled with
>>>> `netif` class.
>>>>
>>>
>>> I look at it this way: peers *are* processes, You seem to
>>> essentually use peers as nodes above.
>>
>> I think both are true. When labeled IPSec is used, it's probably (I
>> haven't tried it yet) possible to identify peers at process
>> level. Without IPSec it's only possible to get peer labeling with
>> NetLabel rules, which only allow IP address (host or even networks of
>> hosts) level accuracy.
>>
> 
> The thing, i think, is that netlabel is limited and really geared
> towards MLS, it will only send levels over the wire i believe (except for loopback)
> 
> By AFAIK the point of netlabel is to be able enforce mult-level security
> on secure networks. For example you could have a ssh server running on a
> particular level. In other words netlabel AFAIK should be able to send a
> process/peer level over the network AFAIK.

I think this applies to CIPSO/CALIPSO but not `unlabeled` mode which is 
used in my example.

MLS is not very interesting for users in general and so neither will be 
CIPSO/CALIPSO. Maybe labeled IPSec could be useful in some controlled 
corporate environments where all parties are relatively trusted.

But I think `unlabeled` mode, together with other networking controls, 
could be very useful for all users. For some reason, it's bit hard in 
Linux to give each application an individual firewall while this has 
been easy in Windows for a long time. With SELinux network controls it's 
possible to enforce application level access control but the knobs seem 
to be weird.

>>> It would become more clear if you would try this out with labeled ipsec.
>>> A peer, in my experience is kind of the same as an association in the
>>> labeled ipsec scenario (the classes actually overlap). That is also why
>>> you should probably disable the netlabel_peer_controls polcap if you use
>>> labeled ipsec.
>>
>> Right, but I think my setup could be useful for cases where labeled
>> IPSec is not used.
>>
>> Do you see AVC denials etc. for netif *ingress* for process level
>> domains with labeled IPSec?
> 
> I use to have extensive recordings and blogs about this matter but i
> erased it all, and i currently dont have a ipsec tunnel, or avc denials,
> but I do vaguely recall that the ingress with labeled ipsec was on a per process
> level. I might be wrong though.
> 
> I would probably just omit the line about the reception to be on the
> safe side. (can always add that later if needed)

Yes, that's probably safer.

-Topi

> 
>>
>> -Topi
>>
>>>>>
>>>>>> +
>>>>>> +<br>
>>>>>> +
>>>>>> +## Access Control for Network Nodes
>>>>>> +
>>>>>> +Domains can be restricted by SELinux to access and bind sockets to
>>>>>> +only dedicated network nodes (in practice, IP addresses).
>>>>>> +
>>>>>> +The node types must be defined and then the node types can be used for
>>>>>> +TE rules as target context. TE rules to allow a domain to `sendto` for
>>>>>> +class `node` and to `node_bind` (for incoming connections) for class
>>>>>> +`tcp_socket`:
>>>>>> +
>>>>>> +```
>>>>>> +require {
>>>>>> +        attribute node_type;
>>>>>> +}
>>>>>> +
>>>>>> +type loopback_node_t, node_type;
>>>>>> +type internet_node_t, node_type;
>>>>>> +type link_local_node_t, node_type;
>>>>>> +type multicast_node_t, node_type;
>>>>>> +
>>>>>> +allow my_server_t loopback_node_t:node sendto;
>>>>>> +allow my_server_t loopback_node_t:tcp_socket node_bind;
>>>>>> +allow my_server_t internet_node_t:node sendto;
>>>>>> +```
>>>>>> +
>>>>>> +After the types have been defined, corresponding node rules can be
>>>>>> +added with `semanage` (or `nodecon` statements):
>>>>>> +```
>>>>>> +semanage node -a -M /128 -p ipv6 -t loopback_node_t -r s0 ::1
>>>>>> +semanage node -a -M /3 -p ipv6 -t internet_node_t -r s0 2000::
>>>>>> +semanage node -a -M /8 -p ipv6 -t link_local_node_t -r s0 fe00::
>>>>>> +semanage node -a -M /8 -p ipv6 -t multicast_node_t -r s0 ff00::
>>>>>> +```
>>>>>> +
>>>>>> +<br>
>>>>>> +
>>>>>> +## Access Control for Network Ports
>>>>>> +
>>>>>> +SELinux policy can also control access to ports used by various
>>>>>> +networking protocols such as TCP, UDP, SCTP and DCCP. TE rules must
>>>>>> +define the port types and then allow a domain to `name_connect`
>>>>>> +(outgoing) or `name_bind` (incoming) in class `tcp_socket` (or
>>>>>> +`udp_socket` etc) for the defined port types:
>>>>>> +
>>>>>> +```
>>>>>> +require {
>>>>>> +        attribute port_type;
>>>>>> +}
>>>>>> +
>>>>>> +type my_server_port_t, port_type;
>>>>>> +
>>>>>> +allow my_server_t my_server_port_t:tcp_socket name_connect;
>>>>>> +allow my_server_t my_server_port_t:tcp_socket name_bind;
>>>>>> +```
>>>>>> +
>>>>>> +The ports must also be labeled with `semanage` (or `portcon`
>>>>>> +statements):
>>>>>> +```
>>>>>> +semanage port -a -t my_server_port_t -p tcp -r s0 12345
>>>>>> +```
>>>>>> +
>>>>>> +<br>
>>>>>> +
>>>>>>     <section class="footnotes">
>>>>>>     <ol>
>>>>>>     <li id="fnn1"><p>For example, an ftp session where the server is
>>>>>> listening on a specific port (the destination port) but the client
>>>>>> will be assigned a random source port. The CONNSECMARK will ensure
>>>>>> that all packets for the ftp session are marked with the same label.<a
>>>>>> href="#fnnet1" class="footnote-back">↩</a></p></li>
>>>>>
>>>>
>>>
>>
> 

