Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38407CD6E72
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 14:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJKOFC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjJKOFA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 10:05:00 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA9B7
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 07:04:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so1547770276.2
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697033094; x=1697637894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onL9d3d7dl4Bu91unuN/0efPNRFRtaLFe4aDSmoBdaY=;
        b=B+9V3fDOdV4IBr2mABH1+4Y2Z7Pi3QuTcLMRTUHzI4eNb4nm0ApfQdqq1NW78ExVNL
         X1BiRdcjYT6+BjEKwCSouOakNptvvpYfNwhzhCsJyZn3xkPt6TyhWbYzHYyEVf05/+Jb
         ZgHFtAtF/iz9yDPFuHRletRpmRlmLBdvyGDOE9p+aggijH8+RbToQAL69I9f43OrReoX
         zzDKctMxdzQdffqc/HVH+lVw5EL7Q/rxnQHPi5orRNX7EXVygHoVsg4KwD6DfXRaGy31
         EG2al/Klr3/3JZGSK/ta04Lu4lejw6uIgAZ1Wn/f1gHTmZ9USuPg9h5uxmhM4V7vhW4s
         N3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033094; x=1697637894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onL9d3d7dl4Bu91unuN/0efPNRFRtaLFe4aDSmoBdaY=;
        b=V04+MSmOmFP/xAyXuvF/tq6bcfqMrsFPBvtMGZb2H/THBD/LOdMwKnSzVTNRpk7tXg
         +eLixGgWfkeH3N73FrS5VQEMoy4qqOf2X6Et95EbF3CsnyjodlQXohlyIc45WazQVjhZ
         evntzBcx0qVyO+vFYrRl12FxcxavYAjnm4Pyzq1XNfFoFemRleuTGX3UpHNhTdmgLnGL
         KBdstbVNqA1QRBW+BjY6eFp+x5R2Llq1gyTr/xc7M0Tqr1zrpMOQFogydzIExWaM4Lrc
         q4O4l3NylAA/sfT1ZAeDYFjPb+ngvtE17BxeW1C7uBZY6wIbhMpE9JuhmjKUNiOcYQYC
         N7kg==
X-Gm-Message-State: AOJu0YyYOrpAc6E0SdeItIlziAy2tEindVooY9uhg8xa94ywbSPbT/4u
        w9FwvqXTnKnOAIPDkCKNaDjnc4+oUoH6LVlf1cnZ4eepq31oFx8=
X-Google-Smtp-Source: AGHT+IH3bi8hKmmr81SmfAoT/XYqtXY431jBMlnbkwZKG8PylWa7cZtLh33SBJdkT44i4wg4E1uRiw4mq9XsbusOwsY=
X-Received: by 2002:a25:9012:0:b0:d9a:5f25:d0df with SMTP id
 s18-20020a259012000000b00d9a5f25d0dfmr4537864ybl.57.1697033094701; Wed, 11
 Oct 2023 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZSZMGtFFycCLmjNb@dhcp-0-146.brq.redhat.com>
In-Reply-To: <ZSZMGtFFycCLmjNb@dhcp-0-146.brq.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Oct 2023 10:04:43 -0400
Message-ID: <CAHC9VhSC9BeD+mCPSoDp1fphV4BMAxmBVp2pL+wVoFsmYC121w@mail.gmail.com>
Subject: Re: An X.509 certificate for selinuxproject.org web server has expired
To:     Petr Pisar <ppisar@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 3:18=E2=80=AFAM Petr Pisar <ppisar@redhat.com> wrot=
e:
>
> A TLS certificate for <https://selinuxproject.org/> has expired:
>
> $ gnutls-cli --port https selinuxproject.org
> Processed 367 CA certificate(s).
> Resolving 'selinuxproject.org:https'...
> Connecting to '207.210.245.134:443'...
> - Certificate type: X.509
> - Got a certificate list of 3 certificates.
> - Certificate[0] info:
>  - subject `CN=3Dselinuxproject.org', issuer `CN=3DR3,O=3DLet's Encrypt,C=
=3DUS', serial 0x04ef96d84dee2bf82c3fd430379377422cc5, RSA key 2048 bits, s=
igned using RSA-SHA256, activated `2023-07-12 19:10:38 UTC', expires `2023-=
10-10 19:10:37 UTC', pin-sha256=3D"MrgWqS/CGL+3idYpvJbFP3KfXfWmDboEKJTsCXFm=
c28=3D"

Thanks for the heads-up, I'll contact the sysadmin and let them know.

--=20
paul-moore.com
