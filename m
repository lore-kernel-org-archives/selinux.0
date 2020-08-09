Return-Path: <SRS0=Syrn=BT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB95C433E0
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 07:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385B72070B
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 07:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar+w7Qt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHIHis (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHIHis (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Aug 2020 03:38:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE5C061756
        for <selinux@vger.kernel.org>; Sun,  9 Aug 2020 00:38:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so6392119ljc.3
        for <selinux@vger.kernel.org>; Sun, 09 Aug 2020 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9w7uvsd2EVQMUxWayHv9rddhLcM8ACSE04/g2UiK3xQ=;
        b=Ar+w7Qt1vJAPwALhExM6ERe7qt+7PHANZmIAkQ4dRxHKu8FURM16zg2cu8iVUx73Re
         H0rmuCtITM2wMQfDFkrhujcpx4RIpIowSJ6b24QwcEkxtRQ53O4XbQArEQruJ2nM2hv+
         KGzKOoUHTMjoAfpyp4ommSFIsxSLXfca4cmf0TD8ENCMUq52imR0X9dDxP9NSJ3aod10
         bvJPT33TOmyUfRU/8e8jP/+iVQBcCDHLFygwc+2ESeR/FZxxzBa3XsPyRnr26z51SdTD
         lv8a/G4CD5vzL2r6IjOMxMt8Vct32bF2ZREOauiu/2c1A7kmAHcItFvE/bz92wNhoHhZ
         +12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9w7uvsd2EVQMUxWayHv9rddhLcM8ACSE04/g2UiK3xQ=;
        b=NmHzRqlDCJ9M8Q/WI4mnxyrIFnAtvWU+N4n0FDTtz1GnFfyp1R24qSyqQBHuM6lKUo
         +8tn0/u36fckt8QLRvVbqFS/6H5wm35iBvQ859pZ3eta0S0wfJ/XtDVrDEhvPnv8Kgxa
         zfRiqJhHXcAhVx6IBgq6VUeDQAJKbxjoLHtjnN8gJkBuq/l2KZqL0QloXhltI33TEkmP
         w+vP+xhp78WExiVE5tPyBIuJjV49ug3wrj4aKG+TgUpIv9atna6Nk6PDpdQwexZFbeM1
         Ts79AJIRmErU8FLKGyMH6W21dRWkkkdMR+KoJE3E/822zywzUqvD/tt1+Eh52TRzuZE8
         dCQQ==
X-Gm-Message-State: AOAM530PYfcmYcmQxGQ973bZTgJAFkv8r4DuAq1r9r6ewdnOSH8z2QQf
        zWk082inuk9ge59h9VjLtvqlA2NX
X-Google-Smtp-Source: ABdhPJyoCO9cu5MSGrPrF6ipOfQFuFAKqY4MzajPNeqRVjkGkWbYJPG8ceXDKqUl5p8IKvUvCK8/Kw==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr10570492ljg.395.1596958724028;
        Sun, 09 Aug 2020 00:38:44 -0700 (PDT)
Received: from [192.168.1.45] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id v1sm2041023ljg.60.2020.08.09.00.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 00:38:43 -0700 (PDT)
Subject: Re: [PATCH v3] Improve network_support.md
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20200801092608.8057-1-toiwoton@gmail.com>
 <CAHC9VhRACosseuAM9f17EkcFJ=RzvZ3A6f3vpjkEBfo8RN8GpQ@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <7db33d9d-f0eb-40f9-2f2a-19db07d71963@gmail.com>
Date:   Sun, 9 Aug 2020 10:38:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRACosseuAM9f17EkcFJ=RzvZ3A6f3vpjkEBfo8RN8GpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6.8.2020 6.32, Paul Moore wrote:
> On Sat, Aug 1, 2020 at 5:26 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> List all access control methods available for networking and provide
>> examples for each.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>
>> ---
>> v2: address comments from Richard Haines
>> v3: address comments from Paul Moore
>> ---
>>   src/network_statements.md |   2 +-
>>   src/network_support.md    | 225 ++++++++++++++++++++++++++++++++++----
>>   2 files changed, 207 insertions(+), 20 deletions(-)
>>
>> diff --git a/src/network_statements.md b/src/network_statements.md
>> index ef1c873..a2213d4 100644
>> --- a/src/network_statements.md
>> +++ b/src/network_statements.md
>> @@ -102,7 +102,7 @@ the interface to a security context.
>>   <tr>
>>   <td><code>packet_context</code></td>
>>   <td><p>The security context allocated packets. Note that these are defined but unused.</p>
>> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
>> +<p>The iptables(8)/nftables(8) <a href="network_support.md#packet-controls-secmark">SECMARK services</a> should be used to label packets.</p></td>
>>   </tr>
>>   </tbody>
>>   </table>
>> diff --git a/src/network_support.md b/src/network_support.md
>> index 309e863..e3101ee 100644
>> --- a/src/network_support.md
>> +++ b/src/network_support.md
>> @@ -1,20 +1,51 @@
>>   # SELinux Networking Support
>>
>> -SELinux supports the following types of network labeling:
>> +SELinux controls network access in kernel at two locations: at the
> 
> "in the kernel"
> 
>> +socket interface, and when packets are processed by the protocol
>> +stacks. Controls at socket interface are invoked when a task makes
> 
> "at the socket interface"
> 
>> +network related system calls and thus the access permission checks
>> +mimic the sockets programming interface (e.g. ***bind**(2)*
>> +vs. `node_bind`). Packet controls are more distant from applications
>> +and they are invoked whenever any packets are received, forwarded or
>> +sent.
>> +
>> +Packet level controls include:
>> +* Packet labeling with SECMARK: class `packet`
>> +* Peer labeling with Labeled IPSec or NetLabel: class `peer`
>> +* Interface control: class `netif`
>> +* Network node control: class `node`
>> +
>> +Controls at socket interface include:
>> +* TCP/UDP/SCTP/DCCP ports: class `port`
>> +
>> +Packet controls can be organized further according to the source of
>> +the label for the packets, which can be internal or external:
>>
>>   **Internal labeling** - This is where network objects are labeled and
>>   managed internally within a single machine (i.e. their labels are not
>>   transmitted as part of the session with remote systems). There are two
>> -types supported: SECMARK and NetLabel. There was a service known as
>> +types supported: SECMARK and NetLabel. As an example, SECMARK access
> 
> Instead of just "NetLabel" here we should probably give some
> indication that this is NetLabel with the static/fallback "protocol".
> 
>> +controls could restrict `firefox_t` to talking only to network
>> +services on TCP port 80 while NetLabel fallback/static rules could
>> +restrict `firefox_t` to only receive data from specific IP addresses
>> +on a specific network interface.  There was a service known as
>>   'compat_net' controls, however that was removed in kernel 2.6.30.
> 
> I wonder if it is even worth mentioning compat_net here, without any
> explanation of the controls it just seems confusing.
> 
> 2.6.30 was released over 11 years ago.
> 
>>   **Labeled Networking** - This is where labels are passed to/from remote
>>   systems where they can be interpreted and a MAC policy enforced on each
>>   system. There are three types supported: Labeled IPSec, CIPSO
>>   (Commercial IP Security Option) and CALIPSO (Common Architecture Label
>> -IPv6 Security Option)
>> +IPv6 Security Option). With labeled networking, it's possible to
> 
> Similar to my comments above, there should be some indication of
> NetLabel here, e.g. "NetLabel/CIPSO"; I fear this will be confusing
> otherwise.
> 
>> +compare the security attributes (SELinux label) of the sending peer
>> +with the security context of the receiving peer. A simple example with
>> +Labeled IPSec is restricting `firefox_t` to talking only to `httpd_t`,
>> +while CIPSO/CALIPSO could restrict domains with MLS security level
>> +`s32` not to talk with domains with level `s31`.
>>
>> -There are two policy capability options that can be set within policy
>> +Networking support is not enabled by default. It can be enabled either
>> +the policy capabilities or by loading SECMARK rules.
> 
> It may be more accurate to say that the SELinux network access
> controls are not enforced by default; they must first be configured or
> forced on by the "always_check_network" policy capability.
> 
>> +There are three policy capability options that can be set within policy
>>   using the `policycap` statement that affect networking configuration:
>>
>>   **`network_peer_controls`** - This is always enabled in the latest
>> @@ -37,8 +68,14 @@ The policy capability settings are available in userspace via the
>>   SELinux filesystem as shown in the
>>   [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>>
>> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
>> -be installed:
>> +NetLabel is a framework for explicit network labeling that abstracts
>> +away the underlying labeling protocol from the LSMs. Labeled IPsec and
>> +the NetLabel framework are the current access controls for class
>> +`peer`, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
>> +a fallback/static labeling for unlabeled IPv4 and IPv6 networks.
> 
> It seems like it might be better to move this explanation closer to
> the top of this section.
> 
>> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
>> +the NetLabel tools need to be installed:
>>
>>   `dnf install netlabel_tools`
>>
> 

Thanks for the comments. Perhaps there should be your Signed-off-by line 
too since the patch has a lot of text which was actually written by you, 
so I don't take credit from your work?

-Topi
