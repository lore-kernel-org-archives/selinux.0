Return-Path: <SRS0=wjA6=BU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDCAC433DF
	for <selinux@archiver.kernel.org>; Mon, 10 Aug 2020 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05F120734
	for <selinux@archiver.kernel.org>; Mon, 10 Aug 2020 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vElHUsjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHJNsF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHJNsE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Aug 2020 09:48:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6625C061756
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2020 06:48:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p25so8333827qkp.2
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2020 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=AAoZIT3CcrQh8grFJu8DEB/ZbpcuQzSr8mRMKBpfkto=;
        b=vElHUsjc98EH0AlaVQ77XwSywb7ZPlbbqTakv4lFGQ4t+7Q6q+YKqKntINAuzsu1gw
         XriCfZqbHhr+HBdNsp/6ezn4DP2YnaeuIVFEkTAPsGL9RhS8WlTocjDX3MALNhxaUcZO
         QPduRoWIsRZKx7xBl20nb4f0Ywz+o2w90EaqGN2Ugii/JFacLyfXIWlVrzaoEbnnKVBK
         2P8A4dMmTRKjT3+q6Ryna32f2a4XK/2/eMs11aaVjPg6/Zhv2FFLRbXnsPP1GsQjnq63
         alIaYea4QeQK61n+fksgr9WZDzE9MQTMpJp8uHfpGtW1cawlqbFtkjwV0QPiLvnH24Pa
         /oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=AAoZIT3CcrQh8grFJu8DEB/ZbpcuQzSr8mRMKBpfkto=;
        b=fHvfqVU2gKN2XEFFvPN5sWXhq52Q6lQP/KjW7fmdEd0tU9b2YO42T8+04enjSKT7rP
         JTvCwZm+mh8QuPAbifEIiIDFYkn/8d/6FqBztsbVmUp/9Vn+8YqIGEh1adVkuu/lFh8f
         M9W28R8ZuIrcn/B+caR7GnWBrHOriKu/UN/KnWwlDB0IkBRvb5lo87cWGXEeNfUHiE1+
         a36JYUKmv2x2CMMbsGjI4L1HTiSCkL0CwsClgizclAQDcntbcgFLCDRWR3JcCGijQ3JX
         TkB0xZ/0yADDsf//0l0q5uiO2al5oy9KftnnmsYeGV7I+n/FnzGI7Tdef3EXOFNWVVGt
         JzyA==
X-Gm-Message-State: AOAM530BYVC/hS6h2+MTY4HqWg+Yo45dnvJLCryIXnFBKJ0vUkZ1kcjY
        7NOunPmfMH5aoLhLZy214osi
X-Google-Smtp-Source: ABdhPJxToHLf+PdR0hIqNEfAeC3IMGQVJXiebV3csoUPWe5AA0n0LETR37+1SdVrFyHZ7wDPc8bWJw==
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr25456109qke.323.1597067283734;
        Mon, 10 Aug 2020 06:48:03 -0700 (PDT)
Received: from [192.168.160.101] (c-24-91-201-67.hsd1.ma.comcast.net. [24.91.201.67])
        by smtp.gmail.com with ESMTPSA id g123sm640561qkd.127.2020.08.10.06.48.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 06:48:02 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Topi Miettinen <toiwoton@gmail.com>
CC:     <selinux@vger.kernel.org>
Date:   Mon, 10 Aug 2020 09:48:00 -0400
Message-ID: <173d8a0be80.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <7db33d9d-f0eb-40f9-2f2a-19db07d71963@gmail.com>
References: <20200801092608.8057-1-toiwoton@gmail.com>
 <CAHC9VhRACosseuAM9f17EkcFJ=RzvZ3A6f3vpjkEBfo8RN8GpQ@mail.gmail.com>
 <7db33d9d-f0eb-40f9-2f2a-19db07d71963@gmail.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: [PATCH v3] Improve network_support.md
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Apologies for top posting]

Hi,

Thanks for thinking of that, but it's not necessary; you have been the one =
doing the work and updating the text, I'm just providing some review and fe=
edback :)

I see you posted an updated draft - thanks. My time is limited this week, s=
o I may not be able to properly review it until next week, but Stephen, Pet=
r, and James have agreed to help maintain The Notebook in GitHub so they ma=
y be able to help provide some review and/or merge the patch.

--
paul moore
www.paul-moore.com
On August 9, 2020 3:38:44 AM Topi Miettinen <toiwoton@gmail.com> wrote:

> On 6.8.2020 6.32, Paul Moore wrote:
>> On Sat, Aug 1, 2020 at 5:26 AM Topi Miettinen <toiwoton@gmail.com> wrote=
:
>>>
>>> List all access control methods available for networking and provide
>>> examples for each.
>>>
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>
>>> ---
>>> v2: address comments from Richard Haines
>>> v3: address comments from Paul Moore
>>> ---
>>> src/network_statements.md |   2 +-
>>> src/network_support.md    | 225 ++++++++++++++++++++++++++++++++++----
>>> 2 files changed, 207 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/src/network_statements.md b/src/network_statements.md
>>> index ef1c873..a2213d4 100644
>>> --- a/src/network_statements.md
>>> +++ b/src/network_statements.md
>>> @@ -102,7 +102,7 @@ the interface to a security context.
>>> <tr>
>>> <td><code>packet_context</code></td>
>>> <td><p>The security context allocated packets. Note that these are defi=
ned but unused.</p>
>>> -<p>The iptables(8)/nftables(8) <a href=3D"network_support.md#secmark">=
SECMARK services</a> should be used to label packets.</p></td>
>>> +<p>The iptables(8)/nftables(8) <a href=3D"network_support.md#packet-co=
ntrols-secmark">SECMARK services</a> should be used to label packets.</p></=
td>
>>> </tr>
>>> </tbody>
>>> </table>
>>> diff --git a/src/network_support.md b/src/network_support.md
>>> index 309e863..e3101ee 100644
>>> --- a/src/network_support.md
>>> +++ b/src/network_support.md
>>> @@ -1,20 +1,51 @@
>>> # SELinux Networking Support
>>>
>>> -SELinux supports the following types of network labeling:
>>> +SELinux controls network access in kernel at two locations: at the
>>
>> "in the kernel"
>>
>>> +socket interface, and when packets are processed by the protocol
>>> +stacks. Controls at socket interface are invoked when a task makes
>>
>> "at the socket interface"
>>
>>> +network related system calls and thus the access permission checks
>>> +mimic the sockets programming interface (e.g. ***bind**(2)*
>>> +vs. `node_bind`). Packet controls are more distant from applications
>>> +and they are invoked whenever any packets are received, forwarded or
>>> +sent.
>>> +
>>> +Packet level controls include:
>>> +* Packet labeling with SECMARK: class `packet`
>>> +* Peer labeling with Labeled IPSec or NetLabel: class `peer`
>>> +* Interface control: class `netif`
>>> +* Network node control: class `node`
>>> +
>>> +Controls at socket interface include:
>>> +* TCP/UDP/SCTP/DCCP ports: class `port`
>>> +
>>> +Packet controls can be organized further according to the source of
>>> +the label for the packets, which can be internal or external:
>>>
>>> **Internal labeling** - This is where network objects are labeled and
>>> managed internally within a single machine (i.e. their labels are not
>>> transmitted as part of the session with remote systems). There are two
>>> -types supported: SECMARK and NetLabel. There was a service known as
>>> +types supported: SECMARK and NetLabel. As an example, SECMARK access
>>
>> Instead of just "NetLabel" here we should probably give some
>> indication that this is NetLabel with the static/fallback "protocol".
>>
>>> +controls could restrict `firefox_t` to talking only to network
>>> +services on TCP port 80 while NetLabel fallback/static rules could
>>> +restrict `firefox_t` to only receive data from specific IP addresses
>>> +on a specific network interface.  There was a service known as
>>> 'compat_net' controls, however that was removed in kernel 2.6.30.
>>
>> I wonder if it is even worth mentioning compat_net here, without any
>> explanation of the controls it just seems confusing.
>>
>> 2.6.30 was released over 11 years ago.
>>
>>> **Labeled Networking** - This is where labels are passed to/from remote
>>> systems where they can be interpreted and a MAC policy enforced on each
>>> system. There are three types supported: Labeled IPSec, CIPSO
>>> (Commercial IP Security Option) and CALIPSO (Common Architecture Label
>>> -IPv6 Security Option)
>>> +IPv6 Security Option). With labeled networking, it's possible to
>>
>> Similar to my comments above, there should be some indication of
>> NetLabel here, e.g. "NetLabel/CIPSO"; I fear this will be confusing
>> otherwise.
>>
>>> +compare the security attributes (SELinux label) of the sending peer
>>> +with the security context of the receiving peer. A simple example with
>>> +Labeled IPSec is restricting `firefox_t` to talking only to `httpd_t`,
>>> +while CIPSO/CALIPSO could restrict domains with MLS security level
>>> +`s32` not to talk with domains with level `s31`.
>>>
>>> -There are two policy capability options that can be set within policy
>>> +Networking support is not enabled by default. It can be enabled either
>>> +the policy capabilities or by loading SECMARK rules.
>>
>> It may be more accurate to say that the SELinux network access
>> controls are not enforced by default; they must first be configured or
>> forced on by the "always_check_network" policy capability.
>>
>>> +There are three policy capability options that can be set within polic=
y
>>> using the `policycap` statement that affect networking configuration:
>>>
>>> **`network_peer_controls`** - This is always enabled in the latest
>>> @@ -37,8 +68,14 @@ The policy capability settings are available in user=
space via the
>>> SELinux filesystem as shown in the
>>> [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>>>
>>> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
>>> -be installed:
>>> +NetLabel is a framework for explicit network labeling that abstracts
>>> +away the underlying labeling protocol from the LSMs. Labeled IPsec and
>>> +the NetLabel framework are the current access controls for class
>>> +`peer`, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
>>> +a fallback/static labeling for unlabeled IPv4 and IPv6 networks.
>>
>> It seems like it might be better to move this explanation closer to
>> the top of this section.
>>
>>> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
>>> +the NetLabel tools need to be installed:
>>>
>>> `dnf install netlabel_tools`
>
> Thanks for the comments. Perhaps there should be your Signed-off-by line
> too since the patch has a lot of text which was actually written by you,
> so I don't take credit from your work?
>
> -Topi



