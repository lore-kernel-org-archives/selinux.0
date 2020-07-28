Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C84C433E0
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8552E2070A
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d8cz5ssF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgG1Cod (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG1Coc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 22:44:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F006C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:44:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so10405678edv.13
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjEVAMlYzVJqzQf9IJ8hkDOGbT8ntkrv5yzRuefb+Ug=;
        b=d8cz5ssFSGpApZ9QX08Dq07SF0iftnqsyu6cVcA/sZwOo8hUcIWn9/tXeaO0fTJQ3z
         mgzENL7moDCf59OWuuoexw6eXowvp/6lfs4SYx7m1RpnJbMum+mgwHP6EwFTXoMwW9Zh
         6i7GS5yIyWQtC4YvgsJ3COD9BB9LJ7y6gtYE2K1rDNq6/4xMcU7EdHirmFsl+XjLNiAK
         +OUzosZtQzLtdQStvgfY+XIJ05KaODEkTPJSj5kD2v0/LBozJCd3ctWwsDOiPVAENvf/
         czAoVnEItDPxqGADU9aYwe5BmdA9Emf6XtM59VpoPU2Ok53QpvJysoD9pwUFyl4GPc0t
         gFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjEVAMlYzVJqzQf9IJ8hkDOGbT8ntkrv5yzRuefb+Ug=;
        b=n22vo3im2sOdkrI2H7RnNQw/hGb9ZLDIDiFAFvbVxaOht4q3PpexTu0QxllDeuZiw2
         m3rw8lsLhTKxHBcMeYbrYB5no7ChJUhpKXnlwWVQiI+Gncy1zP03jjoiA1QS6WkUprzY
         4S8WguAKYin6EfvbSFGvCOsoe4r+8tZtu4WP8OciKjG1QBm8oLRIXkZQSH3RQR7sYmm2
         IDdJYvcflgs9nNRLjJ4uBMjn4YLEYeAgqxR21d6c4i48MNZRNsl7EqvIwJArRkvfqwb+
         yWembvOMd66r4/RHyTrvo0DL8rT3HRXVkAhyOmBEbjzFAbYAVZrsizEX1zjFT3BCTiyT
         /k6w==
X-Gm-Message-State: AOAM5322vRniZq94WK7UdlxCKjrXGhXDaz4vov2e+N82ovXbgZ/i9bXK
        ybFceGK3jhk6pgqmF8o4zHpiOloNPChIGzYmtKe7
X-Google-Smtp-Source: ABdhPJxAs0VewcevZrA540NrZu69zRxj46dxp07laOY+t0IK2jIxJxkIjUviYF0CJyjHkPxm9ooZPvPhmNH30NSvsFc=
X-Received: by 2002:a05:6402:13d0:: with SMTP id a16mr23873859edx.269.1595904270968;
 Mon, 27 Jul 2020 19:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com>
In-Reply-To: <20200727130428.8234-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 22:44:19 -0400
Message-ID: <CAHC9VhR=Sa-P=jbpLJ7L91hJgbTgD5Pgq-PxQigetGrPDfChRA@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 9:04 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> List all access control methods available for networking and provide
> examples for each.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> ---
> v2: address comments from Richard Haines
> ---
>  src/network_statements.md |   2 +-
>  src/network_support.md    | 170 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 150 insertions(+), 22 deletions(-)
>
> diff --git a/src/network_statements.md b/src/network_statements.md
> index ef1c873..357c3b1 100644
> --- a/src/network_statements.md
> +++ b/src/network_statements.md
> @@ -102,7 +102,7 @@ the interface to a security context.
>  <tr>
>  <td><code>packet_context</code></td>
>  <td><p>The security context allocated packets. Note that these are defined but unused.</p>
> -<p>The iptables(8)/nftables(8) <a href="network_support.md#secmark">SECMARK services</a> should be used to label packets.</p></td>
> +<p>The iptables(8)/nftables(8) <a href="network_support.md#internal-labeling-secmark">SECMARK services</a> should be used to label packets.</p></td>
>  </tr>
>  </tbody>
>  </table>
> diff --git a/src/network_support.md b/src/network_support.md
> index 309e863..6f9896b 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -1,20 +1,17 @@
>  # SELinux Networking Support
>
> -SELinux supports the following types of network labeling:
> +SELinux supports several methods for access control of networks. These are
>
> -**Internal labeling** - This is where network objects are labeled and
> -managed internally within a single machine (i.e. their labels are not
> -transmitted as part of the session with remote systems). There are two
> -types supported: SECMARK and NetLabel. There was a service known as
> -'compat_net' controls, however that was removed in kernel 2.6.30.
> +* Packet labeling: class `packet`
> +* Peer labeling: class `peer`
> +* Interface control: class `netif`
> +* Network node control: class `node`
> +* TCP/UDP/SCTP/DCCP ports: class `port`

For whatever it is worth, I've always thought of the SELinux network
access controls as being composed of two parts: socket layer controls
and packet layer controls (or per-packet controls).  The packet layer
controls are further divided into the "peer" and "secmark" controls.

The socket layer controls are the access controls which closely mimic
the socket syscalls and typically involve checking if a running task
can perform an operation on a network socket, e.g. bind().  These are
usually easy to understand and don't require any special network
configuration.

The packet layer controls are where things start to get interesting as
this is where we apply SELinux security policy to individual packets
as they flow into, out of, and through the system.  As mentioned
above, the packet layer controls are comprised of both "peer" and
"secmark" controls.  The "peer" controls are those access controls
which compare the security attributes (SELinux label) of the sending
peer with the security context of the receiving peer.  The "secmark"
controls compare the network attributes (e.g. IP header values) with
the sending or receiving task's security attributes.  It get's very
complicated very quickly, but a simple example is to think of the
"peer" access controls as restricting firefox_t to talking only to
httpd_t, while the "secmark" access controls restrict firefox_t to
talking only to network services on TCP port 80.

Secmark is (obviously) the "secmark" access controls.

Labeled IPsec and the NetLabel framework are the current "peer" access
controls, with NetLabel supporting CIPSO for IPv4, CALIPSO for IPv6,
and a fallback/static labeling for unlabeled IPv4 and IPv6 networks.

> -**Labeled Networking** - This is where labels are passed to/from remote
> -systems where they can be interpreted and a MAC policy enforced on each
> -system. There are three types supported: Labeled IPSec, CIPSO
> -(Commercial IP Security Option) and CALIPSO (Common Architecture Label
> -IPv6 Security Option)
> +Networking support is not enabled by default. It can be enabled either
> +the policy capabilities or by loading SECMARK rules.
>
> -There are two policy capability options that can be set within policy
> +There are three policy capability options that can be set within policy
>  using the `policycap` statement that affect networking configuration:
>
>  **`network_peer_controls`** - This is always enabled in the latest
> @@ -37,8 +34,22 @@ The policy capability settings are available in userspace via the
>  SELinux filesystem as shown in the
>  [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
>
> -To support peer labeling, CIPSO and CALIPSO the NetLabel tools need to
> -be installed:
> +SELinux supports the following types of network labeling:
> +
> +**Internal labeling** - This is where network objects are labeled and
> +managed internally within a single machine (i.e. their labels are not
> +transmitted as part of the session with remote systems). There are two
> +types supported: SECMARK and NetLabel. There was a service known as
> +'compat_net' controls, however that was removed in kernel 2.6.30.

Using your terminology, NetLabel is external or "labeled networking".

NetLabel is a framework for explicit network labeling that abstracts
away the underlying labeling protocol from the LSMs.  It provides
CIPSO, CALIPSO, and fallback/static protocol support to SELinux (and
Smack).

> +**Labeled Networking** - This is where labels are passed to/from remote
> +systems where they can be interpreted and a MAC policy enforced on each
> +system. There are three types supported: Labeled IPSec, CIPSO
> +(Commercial IP Security Option) and CALIPSO (Common Architecture Label
> +IPv6 Security Option).
> +
> +To support peer labeling with CIPSO and CALIPSO or fallback labeling,
> +the NetLabel tools need to be installed:

-- 
paul moore
www.paul-moore.com
