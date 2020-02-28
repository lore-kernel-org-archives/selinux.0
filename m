Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6ECC3F2D3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC10246A2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="frPZmXjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgB1RSj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:18:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37769 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RSi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 12:18:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id t7so4227558edr.4
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9NEa8ph3hTaPu4eUCrv/V0Hu5l878hTReVvs1ef8lM=;
        b=frPZmXjG/+bG1nJPH4jtlFYr4cjzEs0822bLrX9ABBrzzcf3+7T0UxQ3CEwxqX7iqo
         neHcyjxbg7jZD6vTYqifqLqvzCMTGyz3bg3w1elKVqcAM4OCxNlhIyqjVStvYID0+FA8
         b9QMVPp3i23Fc/2nvjvBAtatREtUj8xpKGleWOU1+1gTlaPYfcvABhQTMFfO6InXvN9S
         0i1/hje0q6otzQorNZa0UtR1bFGzccsXb9sT7UES2K5xDlkX8pFKGBWAkzfkmXIFikqT
         lpLvitj3+7LuGFSAdsQcvl26uTjCPsBKKw9rLxcb4aq1XS6AAZdLE1TUEH4kgypCHih1
         Kjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9NEa8ph3hTaPu4eUCrv/V0Hu5l878hTReVvs1ef8lM=;
        b=Qf1BFM/izH0j4QJX5Ec601yPIEKPMOoJaK5fop7ZLGhwpNuYR94c6V27A7YkSO2WuP
         dXmyk5sYbNAstTJoFcI3wrthTd8lsbo2cUNbzqLck+CIhRINiZB7kv0bzu4kd/3GrWDW
         /gaOb5ptM1YLYaQyoR5mW6ovtl+hyaEKO82R02QlNWUT6pGiFBWysVNuk+W5ihGLlZFT
         Q5oWs0VivNgFLLOrN/UbyvnK7sVqU0aDBUq9VUM4Ix3ZnBgrtKM+9aRSrKFqG7/0Ber6
         zhf+HIQ/HZmu2kZ6KIm0eduMHh46mFvaKWLCHi66tD6ZaEVjHKD3DR8gTeuZxnDBb4CU
         RCWw==
X-Gm-Message-State: APjAAAWQLutWQjPDwQaJEBeRTDiC2CDe9/B1I0yVQASjKgh3C9PXT0QX
        NhB5jO+m6pPAmzIeWLXQb+F8nGhFLNtD7Gw3OEIwjVDF4A==
X-Google-Smtp-Source: APXvYqzC8VZDAyTl6ksPEBp4hGlPEngKjysLuy4o+KcS49Iz9f+Tx9c3n+7LNskAANFvRcJsott+t/ZgYQ8YSe2jrKM=
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr5242468ejd.70.1582910314633;
 Fri, 28 Feb 2020 09:18:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DcSXAPM-Etzs8O=5sUqY=qnM+WTU7p3u22yvEu0VTZ7GQ@mail.gmail.com>
 <CAHC9VhTNELAB5x9WWqxgM=_tG8nsWy6CMkNyhsy4moB-tUM8iA@mail.gmail.com> <CAJ2a_Df1emdgfijS6dT-oHrz4-r1oAU=2a+rMbh4yszaNPbFAA@mail.gmail.com>
In-Reply-To: <CAJ2a_Df1emdgfijS6dT-oHrz4-r1oAU=2a+rMbh4yszaNPbFAA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Feb 2020 12:18:23 -0500
Message-ID: <CAHC9VhRn2p8Lf1D1j7aVFf2b0AK_bUyKn16e0o71B8xCHsUOFQ@mail.gmail.com>
Subject: Re: wrong secmark labels for ipsec packets from local service
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 9:37 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Am Do., 27. Feb. 2020 um 20:45 Uhr schrieb Paul Moore <paul@paul-moore.co=
m>:
> >
> > First off, it would help to see your netfilter configuration,
> > especially the secmark matching rules.

...

> The complete configuration is available at:
> https://salsa.debian.org/cgzones-guest/misc-config/-/blob/master/nftables=
/nftables.conf

Ah, nftables.  Unfortunately I'm not very familiar with that syntax
yet, so bear with me as I try to understand what is going on.

> > As far as the source context for outbound packet:send traffic, for
> > locally generated traffic this will always be the context associated
> > with the sending socket.  If dovecot is sending networking traffic
> > using a socket it created, the source context for that traffic will be
> > that of dovecot (unless dovecot has been augmented to set a different
> > context on the socket).  I may be misunderstanding your configuration,
> > but dovecot is sending this traffic, yes?  If not, who is sending this
> > traffic?
>
> Dovecot is initiating the traffic, but dovecot sends on port
> 993/imaps, and the packets I see are converted/translated/routed to
> come from port 4500/ipsec-nat.
>
> Belonging to the packets are these logs:
>
> type=3DAVC msg=3Daudit(1582898362.267:14845): avc:  granted  { forward_ou=
t
> } for  pid=3D0 comm=3D"swapper/0" saddr=3Dhost_ip src=3D4500
> daddr=3Dvpnclient_ip dest=3D53391 netif=3Deth0
> scontext=3Dsystem_u:object_r:unlabeled_t:s0
> tcontext=3Dsystem_u:object_r:ipsecnat_server_packet_t:s0 tclass=3Dpacket

Let's look at that AVC for a moment:

* scontext is unlabeled_t, which is correct since you aren't using any
type of labeled networking

* tcontext is ipsecnat_server_packet_t which seems to be due to these
sections of your
nftables config (portions trimmed for clarity):

  secmark ipsecnat_server {
    "system_u:object_r:ipsecnat_server_packet_t:s0"
  }

  map secmapping_in {
    type inet_service : secmark
    elements =3D {
      ipsec-nat-t : "ipsecnat_server",
    }
  }

  chain input {
    type filter hook input priority -225;
    # get label for est/rel packets from connection
    ct state established,related meta secmark set ct secmark
    # label new incoming packets
    ct state new meta secmark set tcp dport map @secmapping_in
    ct state new meta secmark set udp dport map @secmapping_in
    # fix loopback labels
    iif lo meta secmark set tcp dport map @secmapping_in
    iif lo meta secmark set udp dport map @secmapping_in
    # save label onto connection
    ct state new ct secmark set meta secmark
  }
  chain output {
    type filter hook output priority 255;
    # get label for est/rel packets from connection
    ct state established,related meta secmark set ct secmark
    # fix loopback labels
    oif lo meta secmark set tcp sport map @secmapping_in
    oif lo meta secmark set udp sport map @secmapping_in
    # save label onto connection
    ct state new ct secmark set meta secmark
  }

... am I correct in that the config above is the only portion which is
relevant to the secmark labeling we are talking about here?  From what
I can tell, the secmark is being set to ipsecnat_server_packet_t by
this rule:

  oif lo meta secmark set udp sport map @secmapping_in

... as the source port is 4500 according to the AVC (I'm assuming UDP
since it is NAT-T, but it doesn't really matter as TCP and UDP share
the same mapping in your config).  The only gotcha is that the AVC
shows the netif as eth0 when the nft rule is for lo/loopback; the
SELinux AVC we are seeing logs the outbound netif in the POSTROUTE
hook *after* any IPsec processing, which might explain the "eth0".
The only way I can explain the lo/loopback is if nftables is seeing
that while the packet is undergoing the IPsec transforms; it has been
too long since I've looked at that code (and it may have changed
anyway, the network guys make changes like that often-ish).

I'm also concerned about the packet:forward_out permission. In this
case dovecot is a local process communicating with a remote IMAP
server over the IPsec tunnel, correct?

--=20
paul moore
www.paul-moore.com
