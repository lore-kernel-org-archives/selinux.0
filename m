Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D9C433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7176461101
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhKEQDe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhKEQDd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 12:03:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DDC061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 09:00:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u191so15164870oie.13
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tp6E22W0FEHIQ5jiCf8ry/T8zUkmK79QhV9enEdd5Do=;
        b=TeCi16uFdVJPl/rOB+W76SGtJyfMhxv64lRmXglorVIg1ojWA29RAcfBJKspMs0BC/
         qaX7mPLK8oW6m1+DRCl8Um6pWAq8hnWHya5IyszppbHn6hj9F78q7MnG2ShiQMVmnKbL
         gfwzEI8hDKyDXkCMTwowEVL2o6TGXujLSPmFalfI5uwha0M9+q5w8JQecS93GGJ+dYiq
         gihKGPu2TNtSvltAn3zf7hBIcIyPndOYtrGKmz9xtpb6kGcbIHMEruTUp9T67GmSF50v
         lrBYM40ZmMBwctM9wWs5P/SuXsDEb4PJtN8WVorBPAs9zKQ/jAlfCIz+4JedlddlkweA
         YDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tp6E22W0FEHIQ5jiCf8ry/T8zUkmK79QhV9enEdd5Do=;
        b=MJw4eOt7wQH0OFZRN1WJOHcrn3W6rFSOSnSxRUOiW1D9Fmpv/qOFMEyafkSb0saJxW
         eI6FQquVUF09C83DZvLzSLL42KA+yRog9gX5POM1p11f/NxrBC42efJZba3H/ilisHBm
         ng1+bC6SVrvpuulYtzuR80yA1GrDMq0sHrJ8cJuuRSl+zWkXD9pYEAWgXd6AD/ZPLjxe
         /TKKzph3MGKpUWckHJxubIPonzVGlJl8hreTxkmiWF5McU0QoU4cFonEBzMk623E8Ox6
         W5OlYIGAk3zzYWOj0j/aaOYhZjSj6etxaAx8++55DAhJGVNiKPYLguaeCYsx1cJg6/ht
         02pA==
X-Gm-Message-State: AOAM533zjlqOyLg4PF6+xTlJPrcTRRrfXoyIwb4aW34G4sv+yqs0sKSr
        VVDeLp0MBETgOkOnVXi/W9nx2B7k9Mafq7YcLQZJNyhPX6C8Og==
X-Google-Smtp-Source: ABdhPJyfV9Gi1yuPuBeLWUN0E6mareU1Rpzlz8/Zmtef0opjtWZuCmeral2y+ocq+l7V3zR1OAku05HjXRLQN2IRgHA=
X-Received: by 2002:a05:6808:1a14:: with SMTP id bk20mr23427203oib.52.1636128053262;
 Fri, 05 Nov 2021 09:00:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 5 Nov 2021 17:00:42 +0100
Message-ID: <CAJ2a_DdJXdGyp7Kn_FYgafgN5sO8u5Sp5840hA92qJVOojPeXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/36] libsepol: add fuzzer for reading binary policies
To:     cgzones@googlemail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Please ignore the erroneously appended extra patches 37-40/40.
