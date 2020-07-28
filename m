Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42FC433DF
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDC220775
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj/jb3lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgG1KaO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgG1KaO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 06:30:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A70C061794
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 03:30:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so20560424ljp.6
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yIWb4TiccSsH2C5jwyQX1gEcQavcITiwfCoTbRPAH88=;
        b=oj/jb3lXnEzA3K0tEc4Uy66szkUQxppNaXx6M04fwRejhAmTDbxNWLi1EiwtJRnGyJ
         /wnwtsZ0tDzmWx2pBJYCmFjBw24xiEjQhPWhmrIo+mNHljw443XDcAWS7kX4SKX9jQtI
         SjdrPygh6KFg6U5CFXd+pcP2Z4y/Gu68Rxvuqr5zHuRfWDdAF8raOFUxEffssSByWKwy
         poPzhTLTfqUvOgHRI5LboSHmjyMAhnAITxxJL521kqzedssTGHNzo4ik7gfuoWiKMy2P
         isSJK7tcMYUyFQqWQV2cwj/9OcPnWvhifJrUKUS5gZo1QMR+CUhgwqPnRhMylqMZzmIE
         fO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIWb4TiccSsH2C5jwyQX1gEcQavcITiwfCoTbRPAH88=;
        b=OuF/UwGLvvOe3K5ZNnq4ixOr/HYOSHr+oFSbXvcEdV+U3YUqcUHYht8yJUbViUukoZ
         3Pyabk1iNr92dfl4jHIbyt7VnZTUTqJ9Y2t9n+LUV3uCgKeJHpDCrUeh3sWxbrVK8UbX
         64lfByVgchyYRY30OCDVbNjF2K/5cd6rkhHpso85BaR992Uyvs27W6FrQMAJcn+mnul0
         dokWSCEukL91lJUZ/BNuNVIRI8uSBTsDg8SPF/bGhu6cP/Q3QkFX2K7dddG4FMvXD5iz
         2S0IZ5C2wkdyOfUPR1c0/epDsQ4cADhDUtnGUSLYrVWJNElEFk5nU6s7/ZNhDZIsXjgK
         g0UQ==
X-Gm-Message-State: AOAM533pf2H3e3gn9swKKaxWgWucFwm4e/QnhbVY5bvmRqNw/y1Tvu+C
        GuchZdwbQq1zuMAV/OHvU47B5XYI
X-Google-Smtp-Source: ABdhPJwA1d+BIL13GduQW3unkbqpuRmwvzY2w8vcfdjr8aHW72hVuXP6YQo35qWEyg/a+FUGiT1Pnw==
X-Received: by 2002:a2e:6e0d:: with SMTP id j13mr383128ljc.367.1595932211458;
        Tue, 28 Jul 2020 03:30:11 -0700 (PDT)
Received: from [192.168.1.88] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id k29sm1025220ljc.127.2020.07.28.03.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:30:10 -0700 (PDT)
Subject: Re: [PATCH v2] Improve network_support.md
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20200727130428.8234-1-toiwoton@gmail.com>
 <CAHC9VhR=Sa-P=jbpLJ7L91hJgbTgD5Pgq-PxQigetGrPDfChRA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <62d3c8f0-38a4-a71b-5f09-36e5287d3d08@gmail.com>
Date:   Tue, 28 Jul 2020 13:30:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR=Sa-P=jbpLJ7L91hJgbTgD5Pgq-PxQigetGrPDfChRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 28.7.2020 5.44, Paul Moore wrote:
> On Mon, Jul 27, 2020 at 9:04 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> List all access control methods available for networking and provide
>> examples for each.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>
>> ---
>> v2: address comments from Richard Haines
>> ---
>>   src/network_statements.md |   2 +-
>>   src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-----
>>   2 files changed, 150 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/network_statements.md b/src/network_statements.md
>> index ef1c873..357c3b1 100644
>> --- a/src/network_statements.md
>> +++ b/src/network_statements.md
>> @@ -102,7 +102,7 @@ the interface to a security context.
>>   <tr>
>>   <td><code>packet_context</code></td>
>>   <td><p>The security context allocated packets. Note that these are defined but unused.</p>
>> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
>> +<p>The iptables(8)/nftables(8) <a href="network_support.md#internal-labeling-secmark">SECMARK services</a> should be used to label packets.</p></td>
>>   </tr>
>>   </tbody>
>>   </table>
>> diff --git a/src/network_support.md b/src/network_support.md
>> index 309e863..6f9896b 100644
>> --- a/src/network_support.md
>> +++ b/src/network_support.md
>> @@ -1,20 +1,17 @@
>>   # SELinux Networking Support
>>
>> -SELinux supports the following types of network labeling:
>> +SELinux supports several methods for access control of networks. These are
>>
>> -**Internal labeling** - This is where network objects are labeled and
>> -managed internally within a single machine (i.e. their labels are not
>> -transmitted as part of the session with remote systems). There are two
>> -types supported: SECMARK and NetLabel. There was a service known as
>> -'compat_net' controls, however that was removed in kernel 2.6.30.
>> +* Packet labeling: class `packet`
>> +* Peer labeling: class `peer`
>> +* Interface control: class `netif`
>> +* Network node control: class `node`
>> +* TCP/UDP/SCTP/DCCP ports: class `port`
> 
> For whatever it is worth, I've always thought of the SELinux network
> access controls as being composed of two parts: socket layer controls
> and packet layer controls (or per-packet controls).  The packet layer
> controls are further divided into the "peer" and "secmark" controls.

This could be a more easily understandable way to describe the access 
controls, at least `port` would fall to socket layer controls nicely. 
Would this division work with netifs and nodes?

> The socket layer controls are the access controls which closely mimic
> the socket syscalls and typically involve checking if a running task
> can perform an operation on a network socket, e.g. bind().  These are
> usually easy to understand and don't require any special network
> configuration.
> 
> The packet layer controls are where things start to get interesting as
> this is where we apply SELinux security policy to individual packets
> as they flow into, out of, and through the system.  As mentioned
> above, the packet layer controls are comprised of both "peer" and
> "secmark" controls.  The "peer" controls are those access controls
> which compare the security attributes (SELinux label) of the sending
> peer with the security context of the receiving peer.  The "secmark"
> controls compare the network attributes (e.g. IP header values) with
> the sending or receiving task's security attributes.  It get's very
> complicated very quickly, but a simple example is to think of the
> "peer" access controls as restricting firefox_t to talking only to
> httpd_t, while the "secmark" access controls restrict firefox_t to
> talking only to network services on TCP port 80.
> 
> Secmark is (obviously) the "secmark" access controls.
> 
> Labeled IPsec and the NetLabel framework are the current "peer" access
> controls, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6,
> and a fallback/static labeling for unlabeled IPv4 and IPv6 networks.
> 
>> -**Labeled Networking** - This is where labels are passed to/from remote
>> -systems where they can be interpreted and a MAC policy enforced on each
>> -system. There are three types supported: Labeled IPSec, CIPSO
>> -(Commercial IP Security Option) and CALIPSO (Common Architecture Label
>> -IPv6 Security Option)
>> +Networking support is not enabled by default. It can be enabled either
>> +the policy capabilities or by loading SECMARK rules.
>>
>> -There are two policy capability options that can be set within policy
>> +There are three policy capability options that can be set within policy
>>   using the `policycap` statement that affect networking configuration:
>>
>>   **`network_peer_controls`** - This is always enabled in the latest
>> @@ -37,8 +34,22 @@ The policy capability settings are available in userspace via the
>>   SELinux filesystem as shown in the
>>   [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>>
>> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
>> -be installed:
>> +SELinux supports the following types of network labeling:
>> +
>> +**Internal labeling** - This is where network objects are labeled and
>> +managed internally within a single machine (i.e. their labels are not
>> +transmitted as part of the session with remote systems). There are two
>> +types supported: SECMARK and NetLabel. There was a service known as
>> +'compat_net' controls, however that was removed in kernel 2.6.30.
> 
> Using your terminology, NetLabel is external or "labeled networking".

It's not my terminology, the text is just moved down. I think 
fallback/static labeling part of NetLabel is not external, the labeling 
happens internally and the labels are not transmitted.

-Topi

> NetLabel is a framework for explicit network labeling that abstracts
> away the underlying labeling protocol from the LSMs.  It provides
> CIPSO, CALIPSO, and fallback/static protocol support to SELinux (and
> Smack).
> 
>> +**Labeled Networking** - This is where labels are passed to/from remote
>> +systems where they can be interpreted and a MAC policy enforced on each
>> +system. There are three types supported: Labeled IPSec, CIPSO
>> +(Commercial IP Security Option) and CALIPSO (Common Architecture Label
>> +IPv6 Security Option).
>> +
>> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
>> +the NetLabel tools need to be installed:
> 

