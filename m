Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038FC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6065224688
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CCv0+b0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgB0P4n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:56:43 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:35537 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgB0P4m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 10:56:42 -0500
Received: by mail-vs1-f49.google.com with SMTP id u26so2176420vsg.2
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vFu1vtlEKPNBBhNbrFmWde86SVUizK5GShRgF2MPoYA=;
        b=CCv0+b0XeqeKZ0xSaSGYUvSSgtGLXToVdhHMLosP3SQAoFYY5OZNa2uiUsIRYFYSi5
         kczS1ER/Ai6E0TFxdVeuW9lmaLBHoFxPk2RJmSk5uEDmiPhL935ZjdthIX/DYHVdjmQO
         qhGBY+lpGYG4JN9kqdWp35sROSGK/x1gREW/X3rB2IbYTat7joJzHqAFr7fh9jfq6s6w
         9ozFAY0eCbMqUvbP+7ySRcXO/9jI+TOSCCeeNpknKoLD/T+5u+I16kPtizgRVDA47cPW
         /WCfG/gzQLPUHqeopaVBgAxjaJvjyS0G42ln3zbdf8Fw30i0kf6+3SnDaSEcv7oQZ2Vz
         OgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vFu1vtlEKPNBBhNbrFmWde86SVUizK5GShRgF2MPoYA=;
        b=NLukBuqFhvHL85G2BzcrgQahbW+bKt9BBGNIqkzXaUW/W8JcD8vUxRras7boxJG334
         1HMSu/Hb/1hB1tndcFG3mlmXCqpPQZ8D3JyGHYsHHZ+qbpaQgAT5A0tfmoIGgyycdQVO
         Eonf3o0mdBfpP0kBgH1vfteHgiGW0sGgo0Zm0Oj1B/zxJkRsF8uWd1cyVno/taADjZzU
         1g2Wpzc4Q2GRjEPPbowo8T+QxLVpO9WvtXaFOmSXWnzfQ5S/h/ek78wbXOLExofuFa5D
         xW8wD2RpiezSZ93FBJDEwnmGhRYZUhUdsQXjRS+/D0+UDG+yzhZdzt3oXKmi8SfKNFmb
         qWGA==
X-Gm-Message-State: APjAAAUzfPyHyFspin0S77fEyTbgIIe7Pvg4qamzvEHBgUl1exQZ07xE
        /v6U4QYrVeBOUdExV1sRVbakDjswKssJGAIBXwwoiBYH
X-Google-Smtp-Source: APXvYqyp3b5QMpzTR5z71aOTpeBz3pCdxat4VdD15Aqq5hJ5lymeThDQWUJJ/LSIKXaQmTBUxt1wnQKYkLB4xzI+aDQ=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr3029861vsb.200.1582818999662;
 Thu, 27 Feb 2020 07:56:39 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 27 Feb 2020 16:56:28 +0100
Message-ID: <CAJ2a_DcSXAPM-Etzs8O=5sUqY=qnM+WTU7p3u22yvEu0VTZ7GQ@mail.gmail.com>
Subject: wrong secmark labels for ipsec packets from local service
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I am trying to confine network labeling via secmark and have an issue
regarding ipsec vpn packets.

Connections from clients are labeled correctly with
'ipsecnat_server_packet_t' and accessing external services (e.g.
google.com) over the vpn is working for clients.

What's causing problems is accessing local services, services running
on the same host as the vpn server.

When trying to access such, I am getting these packets and denials:

Dec 31 11:54:50 server kernel: nft_est IN=3D OUT=3Deth0 SRC=3Dhost_ip
DST=3Dvpnclient_ip LEN=3D1476 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D0 DF PRO=
TO=3DUDP
SPT=3D4500 DPT=3D56602 LEN=3D1456
Dec 31 11:54:51 server kernel: nft_est IN=3D OUT=3Deth0 SRC=3Dhost_ip
DST=3Dvpnclient_ip LEN=3D1476 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D0 DF PRO=
TO=3DUDP
SPT=3D4500 DPT=3D56602 LEN=3D1456
Dec 31 11:54:52 server audit[0]: AVC avc:  denied  { send } for  pid=3D0
comm=3D"swapper/0" saddr=3Dhost_ip src=3D4500 daddr=3Dvpnclient_ip dest=3D5=
6602
netif=3Deth0 scontext=3Dsystem_u:system_r:dovecot_t:s0
tcontext=3Dsystem_u:object_r:ipsecnat_server_packet_t:s0 tclass=3Dpacket
permissive=3D0
Dec 31 11:54:54 server audit[9]: AVC avc:  denied  { send } for  pid=3D9
comm=3D"ksoftirqd/0" saddr=3Dhost_ip src=3D4500 daddr=3Dvpnclient_ip
dest=3D56602 netif=3Deth0 scontext=3Dsystem_u:system_r:dovecot_t:s0
tcontext=3Dsystem_u:object_r:ipsecnat_server_packet_t:s0 tclass=3Dpacket
permissive=3D0

The kernel processes a established response packet originating at port
4500 towards the vpn-client (so the packet label of
'ipsecnat_server_packet_t' is sensible), but the source context is
still the local service (dovecot with 'dovecot_t').
From my point of view Dovecot should not be able to send packets
originating at port 4500 and I'd like not to allow the dovecot domain
(and other local service domain like webservers) to send packets
labeled 'ipsecnat_server_packet_t'.

Is there a possibility to change the source context of these packets
to the domain context of the vpn-server cause I do not see a
possibility to change the packet context to something permitted (like
'pop_server_packet_t')?

Best regards,
     Christian G=C3=B6ttsche


system information:
Linux desktopdebian 5.4.0-4-amd64 #1 SMP Debian 5.4.19-1 (2020-02-13)
x86_64 GNU/Linux
nftables v0.9.3 (Topsy)
Linux strongSwan U5.8.2/K5.4.0-4-amd64
