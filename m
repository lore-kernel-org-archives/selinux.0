Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DAC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F0B24691
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oMWrYggz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgB0Tpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:45:31 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46150 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgB0Tpa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 14:45:30 -0500
Received: by mail-ed1-f52.google.com with SMTP id p14so423561edy.13
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2OpxMNKjWkxfDXkHkyeMI5UWDwD8aZgaZyJX/NOSaZY=;
        b=oMWrYggzeLDQy8BXB4+rj5n2HAtutew0G1HYoM6CMbdhd2BaLvLmkkCN1t6dei7MzS
         apvO1z5JPg9PqcW04MMzfMIttj/v3Naz9mfqYgc2d6f+uN3YEhtgMx+iF3gR96IK8P0N
         PXQII4JQinHW8MpOqjvLhZ+NbW5adEglC/S5FrHFzbPQ6PY6zJiNqerg4u9sLf5TC6a6
         YMehFptvrIAzZL+toJ3DiixZXUVyxinZ5rIulreM+mQ32dbkxIEopx6SoE98Sv1H8SQC
         bePtIwgMdSkk8ScOdfsTrfPg/jQsXNp4pTG/F/D01HdVL4/7jh+UIpk1Q2/M0vyRI0qd
         76oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2OpxMNKjWkxfDXkHkyeMI5UWDwD8aZgaZyJX/NOSaZY=;
        b=aBoD+mc2je1dwOIYU6d1wMEW8sgE0l77WL5P4PEuFT9WB4+y4c1kILJIz7wptjD/GS
         flYtcnF2eg0XN1fbo1XpTlhRZxJDy0qsjmQfGkSUV3pO+mw02MQrYWLJ3pXwOQIjyxxh
         O0OLvxKf8IEtg6evrgnfobTreLDSgEkDyt3le7cw7MNWSOE5miHZQKN1gSYBXpORB58t
         J4btVXEUkb0/NGhSoppd8GIMsgATrNKi30cC6S5fJxG91SuEPcmFu9hF2mD+Pn/9zKQD
         wVlKby9ynbhtlof5vzkyWUCTFoy+mE3Hi6s/j/HFB59Dw38A/+hgY/EAGQZhA/6dEX1m
         5tqg==
X-Gm-Message-State: APjAAAXFBcYhr5sS0CZPksa5rCGpyOzyb3NNRZ0NeH0jplWVk9ix/baH
        zDADs/4VHbftE74d2DUQfvV1vEKzPF0eVMCaBch9CDwP0g==
X-Google-Smtp-Source: APXvYqzOB5sGE7Yvs2gueg2v01oaLx/QuyuupKWl9gYap6DeAy8/zyFX90tNCi3bGHMLz/Y9iQDdIFJFvq0ZAgGi+DE=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr145524edr.164.1582832728916;
 Thu, 27 Feb 2020 11:45:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DcSXAPM-Etzs8O=5sUqY=qnM+WTU7p3u22yvEu0VTZ7GQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DcSXAPM-Etzs8O=5sUqY=qnM+WTU7p3u22yvEu0VTZ7GQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 14:45:17 -0500
Message-ID: <CAHC9VhTNELAB5x9WWqxgM=_tG8nsWy6CMkNyhsy4moB-tUM8iA@mail.gmail.com>
Subject: Re: wrong secmark labels for ipsec packets from local service
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 10:56 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Hi,
>
> I am trying to confine network labeling via secmark and have an issue
> regarding ipsec vpn packets.
>
> Connections from clients are labeled correctly with
> 'ipsecnat_server_packet_t' and accessing external services (e.g.
> google.com) over the vpn is working for clients.
>
> What's causing problems is accessing local services, services running
> on the same host as the vpn server.
>
> When trying to access such, I am getting these packets and denials:
>
> Dec 31 11:54:50 server kernel: nft_est IN=3D OUT=3Deth0 SRC=3Dhost_ip
> DST=3Dvpnclient_ip LEN=3D1476 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D0 DF P=
ROTO=3DUDP
> SPT=3D4500 DPT=3D56602 LEN=3D1456
> Dec 31 11:54:51 server kernel: nft_est IN=3D OUT=3Deth0 SRC=3Dhost_ip
> DST=3Dvpnclient_ip LEN=3D1476 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D0 DF P=
ROTO=3DUDP
> SPT=3D4500 DPT=3D56602 LEN=3D1456
> Dec 31 11:54:52 server audit[0]: AVC avc:  denied  { send } for  pid=3D0
> comm=3D"swapper/0" saddr=3Dhost_ip src=3D4500 daddr=3Dvpnclient_ip dest=
=3D56602
> netif=3Deth0 scontext=3Dsystem_u:system_r:dovecot_t:s0
> tcontext=3Dsystem_u:object_r:ipsecnat_server_packet_t:s0 tclass=3Dpacket
> permissive=3D0
> Dec 31 11:54:54 server audit[9]: AVC avc:  denied  { send } for  pid=3D9
> comm=3D"ksoftirqd/0" saddr=3Dhost_ip src=3D4500 daddr=3Dvpnclient_ip
> dest=3D56602 netif=3Deth0 scontext=3Dsystem_u:system_r:dovecot_t:s0
> tcontext=3Dsystem_u:object_r:ipsecnat_server_packet_t:s0 tclass=3Dpacket
> permissive=3D0
>
> The kernel processes a established response packet originating at port
> 4500 towards the vpn-client (so the packet label of
> 'ipsecnat_server_packet_t' is sensible), but the source context is
> still the local service (dovecot with 'dovecot_t').
> From my point of view Dovecot should not be able to send packets
> originating at port 4500 and I'd like not to allow the dovecot domain
> (and other local service domain like webservers) to send packets
> labeled 'ipsecnat_server_packet_t'.
>
> Is there a possibility to change the source context of these packets
> to the domain context of the vpn-server cause I do not see a
> possibility to change the packet context to something permitted (like
> 'pop_server_packet_t')?

Hello.

First off, it would help to see your netfilter configuration,
especially the secmark matching rules.

As far as the source context for outbound packet:send traffic, for
locally generated traffic this will always be the context associated
with the sending socket.  If dovecot is sending networking traffic
using a socket it created, the source context for that traffic will be
that of dovecot (unless dovecot has been augmented to set a different
context on the socket).  I may be misunderstanding your configuration,
but dovecot is sending this traffic, yes?  If not, who is sending this
traffic?

--=20
paul moore
www.paul-moore.com
