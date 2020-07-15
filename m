Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1351C433DF
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25E4205CB
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I46kH4RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGOOJ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgGOOJ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 10:09:57 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D74C061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 07:09:57 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c7so655012uap.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/DdlFwvOL5vN6XXM7ZVT6I/QjODNPRMe16zAQAtXsrg=;
        b=I46kH4RShytzlxC1kZctHEqMXps8pELswkncGfwwR8xSVOZ1re0Itc3FwTmSl6xQn4
         lJgGWacG0XLpQRm+5gm9vMVLomcVi7mZg1CSGPsBfygFFum0IC6ih6jvP5MmzXRFIJqb
         iUUncC+dgQ1G8YKWarNxcSoP6ym52WEfeykZF8Py9EItrKO2h5qTcCaLVc6nfyfWvt54
         QcjIko16Yq0QIpV2hPYnH5cMZXn9FxYAveUoP6qDLc4JWQ23kDlFguwjKcDwub+K3Euk
         /P+69tDErUk9lB+8tbMv4dL56Fw7H31KEK83XKnsIbngU89Ew2igEDzUPAP+R/zu96N9
         fLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/DdlFwvOL5vN6XXM7ZVT6I/QjODNPRMe16zAQAtXsrg=;
        b=ewmAGVR+upYSycwh7FAPt6vQ3+D2Q5noRLGV4Oukpd/tif3dTA57Z8Ne5XD5a8M83z
         a5Bn40A9uebms3NhY0w63uH3/mVunFRCqPV3AMa0z650/SQesYYf4I1WYywyIQXVo7lV
         egT+aSVearwaSgXTbbcRPPPtqkYU8woN9D9meFxtmDxDJzWGeTuoLxgwL+8qdmOR02JB
         a+RyUWtV0Qzqi6DJ86cnmRPjbAtx7JUUhqXGOMA8Bspz9OXAc8BLmsCdnOhTGf71L0+G
         HmzRDre9ML6ic3gidwE7cFLMWqDNSLWmIMoJ53HQ4A4QaABpAmj6unc1bnLcGfenBY/U
         KBQg==
X-Gm-Message-State: AOAM530Dehusl7kycoR5RQo/AjiaH5Nrxo9Z4tpRh09Ig6I8Z5O3SNvv
        Q0WUP9SuVBJo17YX2TaP+Yh9Sd5nPXQrYaDVS9Dj
X-Google-Smtp-Source: ABdhPJw5EsiMJhYZbMSiuHjDhvb1GKSTUdNWIa4TJsh6c6mXAFKq+V7epmRETkrtEP6RWSPJC/9loe+4mXk/tBxEjOI=
X-Received: by 2002:ab0:7504:: with SMTP id m4mr7550005uap.16.1594822195491;
 Wed, 15 Jul 2020 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_biAy5VRxJEqnTj8HkToQQb_9kVytRXeeCp2iR4hpnNUd71A@mail.gmail.com>
In-Reply-To: <CAD_biAy5VRxJEqnTj8HkToQQb_9kVytRXeeCp2iR4hpnNUd71A@mail.gmail.com>
From:   Jason Strauss <jpstrauss1201@gmail.com>
Date:   Wed, 15 Jul 2020 10:09:44 -0400
Message-ID: <CAD_biAwttUbrVP=VyVKCAuUHsBn2ZyT8vB76OWfvhC9+tyQuWQ@mail.gmail.com>
Subject: Fwd: RedHat 8 Default Context mismatch
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am starting this post to have any confusion I may have as to how a
context is applied, cleared up. I am currently trying to work off of
the RHEL 8 selinux source rpm to apply an MLS type policy. I have
noticed that upon compiling and installing the rpm on a new system
install there are files that do not get correct syntax. When I look at
the file_contexts file the context is correctly listed for example
/usr/bin/sudo, but never correctly applied during a touch
/.autorelabel on first system boot. However if i do a restorecon -RF
on /usr/bin/sudo it matches what is in the file_context folder but
appears to break sudo stating it can't find file libsudo_util.so.0. I
have noticed this happening with several other files during system
installation and would like to understand why the system isn't
properly labeled upon rpm installation and a relabel.
