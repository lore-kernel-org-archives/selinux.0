Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276EFC2D0A3
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E2722228
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="K0NWZ6kQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgKFPXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Nov 2020 10:23:00 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:51242 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgKFPXA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 6 Nov 2020 10:23:00 -0500
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 10:22:58 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 46518DA413D25;
        Fri,  6 Nov 2020 18:12:58 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zZZWS39NdJUO; Fri,  6 Nov 2020 18:12:57 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id CB77EDA4580C6;
        Fri,  6 Nov 2020 18:12:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru CB77EDA4580C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1604675577;
        bh=Ui8SloZuOqfppbuiT2A/TkSHVxDlEW+r7SCbL3jNjCE=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=K0NWZ6kQOOqaEYan4orujB3fPC6pRIFauqVX8kXTtZcOYKOrtNqN2ivZXMd1oV/ME
         eqeC4X41QsTRjlo8i6Pej5U6aaVB1C0aK59givGtdZ/N01on0woIbsd+//oKRSpyQX
         INZb47OSINiaKA8OuRDX8Nb8zvjmHw37NTazyCRGTLxiXe0TTtue7yNEMiT25ong5h
         O0cs2pY0riQ1g6bKkLEBtSV+/FuRxB7nYW+zalmdMeoqs8QqOuI2X9bvlVVCSNpIpi
         8xIIqjNOCEMTm4TngQn4a70q5JXFHBsr9iIh9B2BAvEBY4HmtBQ5cCb4yNZTqA/TQE
         3zg5P+PBgXr8g==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n9qkarrnGy5H; Fri,  6 Nov 2020 18:12:57 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-72.ip.moscow.rt.ru [90.154.71.72])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 6E77DD989FE20;
        Fri,  6 Nov 2020 18:12:57 +0300 (MSK)
Subject: Re: Selinux policy for x509_ima.der public certificate loaded by
 kernel during boot
To:     rishi gupta <gupt21@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org, selinux@vger.kernel.org
References: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru>
Date:   Fri, 6 Nov 2020 18:12:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

06.11.2020 15:22, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> I am getting below error as selinux is denying access to the .ima
> keyring. Looking for guidance for asymmetric public key selinux
> policy.
>
> [  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -13
I am getting the same error without selinux.
>
> [  172.015035] audit: type=3D1800 audit(1604596570.579:240): pid=3D825
> uid=3D1021 auid=3D4294967295 ses=3D4294967295
> subj=3Dsystem_u:system_r:mydaemon_t:s0-s15:c0.c1023 op=3D"appraise_data=
"
> cause=3D"invalid-signature" comm=3D"mydaemon"
> name=3D"/usr/lib/libstdc++.so.6.0.25" dev=3D"ubifs" ino=3D14353 res=3D0
Selinux context is just logged here. It has nothing to do with reasons of=
 ivalid signature. Public key seems to be not loaded.
>
> (a) Do I need to set the selinux context of file
> /etc/keys/x509_ima.der. If yes what it should be.
> (b) Do I need to set some selinux rule for .ima keyring. If yes how. I
> tried a lot but could not find any resource.
Usually IMA policy is loaded before SELinux policy I think
>
> Regards,
> Rishi
