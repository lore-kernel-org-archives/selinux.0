Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2947DC3F2D3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17ED246AC
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F9+TKqyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgB1OhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:37:06 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:44391 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB1OhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 09:37:06 -0500
Received: by mail-ua1-f47.google.com with SMTP id a33so1023698uad.11
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k92GsDrFcrjd7krM3lf+/12Q/MX5pdmFe34NJPQ2ZP4=;
        b=F9+TKqyfZVM87fev/PXOdJM3LfPcY1HRNjMbISLC2w3ITk81+Wa05bCcqG0IkKBqXL
         0WOe/0ps4uQ1/rxx7axh/lnZPXf8a1O94/3wHJD6EgfZo6EZ2lsE/kIlwYCXev5hnI1O
         bYWXXd0Vhv6BmKmMAmbzWBtEkVIAoGLa52xL3ChjTCEeYRcFyHecFijlgwS8/YiqM9o6
         t8kpRltjcLW0judBeGnNw15fjXB2mpsFxSLGsdOBeVK83M/hNAqAIQavyW0SIkOanMzU
         Qsp/RL/qBrkXCpQUm08JDnNYlEK4RT5mlieD/97XPvcz5OVuh+GnhRHWKw6hjp74gns+
         Jpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k92GsDrFcrjd7krM3lf+/12Q/MX5pdmFe34NJPQ2ZP4=;
        b=av2PIy/BDLfZyH3yw4uzTaE/zF4NfO5EePX2SttUViR/XGO+fapIA5WE3pXQQM6TOu
         wTpzoH3ntDyzdCLkLebDatST6dHRyCFl5IPs/JYZ4a8I8GxwSj0bKpw6XxoDa1pzAWcp
         Hp4PiGPKWvN7g2NGW5jpUy7PnY2Exx6PX4Kmkio2vcgZYh6IsNqP0QRW/IM+J1A7T3UH
         yWRlBp8wKveg8mGAnZ8KVJoXsHepR7xRP6e1gLw5BhkAW72sfe8ru/rv1z5E7cVNHe1d
         FzXBnmKapyTBVqbdX0eUAJSFoOohqAE0Yx+PAfEWdgf79re/+UHPr5OK1iMrjGu8O6TI
         SCKA==
X-Gm-Message-State: ANhLgQ2b2RyYVUfeP8oQC8o7QJSc8kk4Ynyf/Ac8SzH6Et6AN/mTESUT
        oG+4Pyoi3wBNplGTJjXXfqS1Bfkbxhm2MXmVGdiDA/Ss
X-Google-Smtp-Source: ADFU+vu8WWYU1lYkZNdGcEjHXHbzlwh0yeKZuqmcAv8QaTuQUlWVAzy+YLDGTQt50WoSV1BTekdw4dj9WUfcGrHftMw=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr1211215uap.94.1582900623665;
 Fri, 28 Feb 2020 06:37:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DcSXAPM-Etzs8O=5sUqY=qnM+WTU7p3u22yvEu0VTZ7GQ@mail.gmail.com>
 <CAHC9VhTNELAB5x9WWqxgM=_tG8nsWy6CMkNyhsy4moB-tUM8iA@mail.gmail.com>
In-Reply-To: <CAHC9VhTNELAB5x9WWqxgM=_tG8nsWy6CMkNyhsy4moB-tUM8iA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 28 Feb 2020 15:36:52 +0100
Message-ID: <CAJ2a_Df1emdgfijS6dT-oHrz4-r1oAU=2a+rMbh4yszaNPbFAA@mail.gmail.com>
Subject: Re: wrong secmark labels for ipsec packets from local service
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Do., 27. Feb. 2020 um 20:45 Uhr schrieb Paul Moore <paul@paul-moore.com>:
>
> First off, it would help to see your netfilter configuration,
> especially the secmark matching rules.

table inet mysecmark {
secmark pop_client {
"system_u:object_r:pop_client_packet_t:s0"
}
secmark isakmp_server {
"system_u:object_r:isakmp_server_packet_t:s0"
}
secmark isakmp_client {
"system_u:object_r:isakmp_client_packet_t:s0"
}
secmark ipsecnat_server {
"system_u:object_r:ipsecnat_server_packet_t:s0"
}
secmark ipsecnat_client {
"system_u:object_r:ipsecnat_client_packet_t:s0"
}
secmark pop_server {
"system_u:object_r:pop_server_packet_t:s0"
}
map secmapping_in {
type inet_service : secmark
elements = {
isakmp : "isakmp_server",
ipsec-nat-t : "ipsecnat_server",
imaps : "pop_server",
}
}
map secmapping_out {
type inet_service : secmark
elements = {
imaps : "pop_client",
isakmp : "isakmp_client",
ipsec-nat-t : "ipsecnat_client",
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
iif lo meta secmark set tcp sport map @secmapping_out
iif lo meta secmark set udp sport map @secmapping_out
# save label onto connection
ct state new ct secmark set meta secmark
}
chain output {
type filter hook output priority 255;
# get label for est/rel packets from connection
ct state established,related meta secmark set ct secmark
# label new outgoing packets
ct state new meta secmark set tcp dport map @secmapping_out
ct state new meta secmark set udp dport map @secmapping_out
# fix loopback labels
oif lo meta secmark set tcp dport map @secmapping_out
oif lo meta secmark set udp dport map @secmapping_out
oif lo meta secmark set tcp sport map @secmapping_in
oif lo meta secmark set udp sport map @secmapping_in
# save label onto connection
ct state new ct secmark set meta secmark
}
}

The complete configuration is available at:
https://salsa.debian.org/cgzones-guest/misc-config/-/blob/master/nftables/nftables.conf


> As far as the source context for outbound packet:send traffic, for
> locally generated traffic this will always be the context associated
> with the sending socket.  If dovecot is sending networking traffic
> using a socket it created, the source context for that traffic will be
> that of dovecot (unless dovecot has been augmented to set a different
> context on the socket).  I may be misunderstanding your configuration,
> but dovecot is sending this traffic, yes?  If not, who is sending this
> traffic?

Dovecot is initiating the traffic, but dovecot sends on port
993/imaps, and the packets I see are converted/translated/routed to
come from port 4500/ipsec-nat.

Belonging to the packets are these logs:

type=AVC msg=audit(1582898362.267:14845): avc:  granted  { forward_out
} for  pid=0 comm="swapper/0" saddr=host_ip src=4500
daddr=vpnclient_ip dest=53391 netif=eth0
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:ipsecnat_server_packet_t:s0 tclass=packet
