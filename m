Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FCCC433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 03:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CD322D01
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 03:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="injOcGed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgHFDct (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbgHFDcs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 23:32:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C56AC061574
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 20:32:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i26so30744173edv.4
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdhrDVs5mIz4CLFU04kYd24NFWnKiUeVBu+2n2po6Us=;
        b=injOcGedgc/njSDGoXtweEAYI9WWiJ/OTwmXUcYCMEM4mTt+PbkRo091Guo7wytLOO
         7GWeyMGdbkmwHoplUtIpvpa98Yuwx3lxAZU5noj8N/nMsHSagcs+PsVv22EjQofzj4yW
         uSgTztZn4VL11A0xZfGYyJkiKdI9x5mlTqk/0HCfGhV6xVdYVMHiMj4YJ3Aj7YKwYz43
         WXGpqX4+JJ489MnOMkFGkbRqU3INegF2+QweepDQxTP7VXo0dyiKGGrdQUcCJnEnp7Nn
         9g9eNldJX3gEwWBzj0X0C9e0v9vC2a54FCOrm0DDubTTAEU+sTqd0pyWhNfrdcSZ801f
         wSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdhrDVs5mIz4CLFU04kYd24NFWnKiUeVBu+2n2po6Us=;
        b=UxG7InHoAJppIArx5jdYW7BSHWuSCFqn3pH/Ar/K/iHk8dQvjFQxZyxglH8nXvkLlo
         n7ecItFeaoAy3Ji5yvnAiy7g/63Qz7FrOREX6z7Qk2oEJP9s4hp3APDkOiKj3q/mD02W
         RnzfC0lOHkwe2+qO+xqzxikvk4jSGl5jORCgDCo/vVIcfp2lWAGjSKrvFbIWHP78BcMi
         xA3xd8tE0fLuEh7B8NIHo135WNiruqirtjKzVOBM99ovYLHoJwZAcbdw+pcMwS/Rwseo
         TKjCZKKWRH2D6Lmsofz94HpRPWQ9ZlEC/4JuanBSU5zgWSbPmAh/oraYNqk0NAfAzMSg
         UizA==
X-Gm-Message-State: AOAM532U0pjHZ+x4BMsgiT3IVq9ZdPlZfCv1qxHQRu4KTF2GbXHwpuVf
        XMK8bqZb/KVPvcAgvPsjSx7aSZlwOjN0a/cNzQG1YSKl2g==
X-Google-Smtp-Source: ABdhPJxJafqOuw3Fk60jaYpV6rEMIZ9y89H8kU0x7q+F6tmm2NFzJGyqDfiZ9WeQUYpvogGKbgcp+xF2PueA2Yu2N40=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr2153919eds.196.1596684764684;
 Wed, 05 Aug 2020 20:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200801092608.8057-1-toiwoton@gmail.com>
In-Reply-To: <20200801092608.8057-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Aug 2020 23:32:33 -0400
Message-ID: <CAHC9VhRACosseuAM9f17EkcFJ=RzvZ3A6f3vpjkEBfo8RN8GpQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve network_support.md
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Aug 1, 2020 at 5:26 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> List all access control methods available for networking and provide
> examples for each.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> ---
> v2: address comments from Richard Haines
> v3: address comments from Paul Moore
> ---
>  src/network_statements.md |   2 +-
>  src/network_support.md    | 225 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 207 insertions(+), 20 deletions(-)
>
> diff --git a/src/network_statements.md b/src/network_statements.md
> index ef1c873..a2213d4 100644
> --- a/src/network_statements.md
> +++ b/src/network_statements.md
> @@ -102,7 +102,7 @@ the interface to a security context.
>  <tr>
>  <td><code>packet_context</code></td>
>  <td><p>The security context allocated packets. Note that these are defined but unused.</p>
> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
> +<p>The iptables(8)/nftables(8) <a href="network_support.md#packet-controls-secmark">SECMARK services</a> should be used to label packets.</p></td>
>  </tr>
>  </tbody>
>  </table>
> diff --git a/src/network_support.md b/src/network_support.md
> index 309e863..e3101ee 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -1,20 +1,51 @@
>  # SELinux Networking Support
>
> -SELinux supports the following types of network labeling:
> +SELinux controls network access in kernel at two locations: at the

"in the kernel"

> +socket interface, and when packets are processed by the protocol
> +stacks. Controls at socket interface are invoked when a task makes

"at the socket interface"

> +network related system calls and thus the access permission checks
> +mimic the sockets programming interface (e.g. ***bind**(2)*
> +vs. `node_bind`). Packet controls are more distant from applications
> +and they are invoked whenever any packets are received, forwarded or
> +sent.
> +
> +Packet level controls include:
> +* Packet labeling with SECMARK: class `packet`
> +* Peer labeling with Labeled IPSec or NetLabel: class `peer`
> +* Interface control: class `netif`
> +* Network node control: class `node`
> +
> +Controls at socket interface include:
> +* TCP/UDP/SCTP/DCCP ports: class `port`
> +
> +Packet controls can be organized further according to the source of
> +the label for the packets, which can be internal or external:
>
>  **Internal labeling** - This is where network objects are labeled and
>  managed internally within a single machine (i.e. their labels are not
>  transmitted as part of the session with remote systems). There are two
> -types supported: SECMARK and NetLabel. There was a service known as
> +types supported: SECMARK and NetLabel. As an example, SECMARK access

Instead of just "NetLabel" here we should probably give some
indication that this is NetLabel with the static/fallback "protocol".

> +controls could restrict `firefox_t` to talking only to network
> +services on TCP port 80 while NetLabel fallback/static rules could
> +restrict `firefox_t` to only receive data from specific IP addresses
> +on a specific network interface.  There was a service known as
>  'compat_net' controls, however that was removed in kernel 2.6.30.

I wonder if it is even worth mentioning compat_net here, without any
explanation of the controls it just seems confusing.

2.6.30 was released over 11 years ago.

>  **Labeled Networking** - This is where labels are passed to/from remote
>  systems where they can be interpreted and a MAC policy enforced on each
>  system. There are three types supported: Labeled IPSec, CIPSO
>  (Commercial IP Security Option) and CALIPSO (Common Architecture Label
> -IPv6 Security Option)
> +IPv6 Security Option). With labeled networking, it's possible to

Similar to my comments above, there should be some indication of
NetLabel here, e.g. "NetLabel/CIPSO"; I fear this will be confusing
otherwise.

> +compare the security attributes (SELinux label) of the sending peer
> +with the security context of the receiving peer. A simple example with
> +Labeled IPSec is restricting `firefox_t` to talking only to `httpd_t`,
> +while CIPSO/CALIPSO could restrict domains with MLS security level
> +`s32` not to talk with domains with level `s31`.
>
> -There are two policy capability options that can be set within policy
> +Networking support is not enabled by default. It can be enabled either
> +the policy capabilities or by loading SECMARK rules.

It may be more accurate to say that the SELinux network access
controls are not enforced by default; they must first be configured or
forced on by the "always_check_network" policy capability.

> +There are three policy capability options that can be set within policy
>  using the `policycap` statement that affect networking configuration:
>
>  **`network_peer_controls`** - This is always enabled in the latest
> @@ -37,8 +68,14 @@ The policy capability settings are available in userspace via the
>  SELinux filesystem as shown in the
>  [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>
> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
> -be installed:
> +NetLabel is a framework for explicit network labeling that abstracts
> +away the underlying labeling protocol from the LSMs. Labeled IPsec and
> +the NetLabel framework are the current access controls for class
> +`peer`, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6, and
> +a fallback/static labeling for unlabeled IPv4 and IPv6 networks.

It seems like it might be better to move this explanation closer to
the top of this section.

> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
> +the NetLabel tools need to be installed:
>
>  `dnf install netlabel_tools`
>

-- 
paul moore
www.paul-moore.com
