Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C26C433DB
	for <selinux@archiver.kernel.org>; Sun, 27 Dec 2020 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193F5217A0
	for <selinux@archiver.kernel.org>; Sun, 27 Dec 2020 08:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgL0Isc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Dec 2020 03:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0Isb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 27 Dec 2020 03:48:31 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3CC061794
        for <selinux@vger.kernel.org>; Sun, 27 Dec 2020 00:47:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 11so4702844pfu.4
        for <selinux@vger.kernel.org>; Sun, 27 Dec 2020 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Eh1dKZUiTbRK0TcKnO/1EzJe9vxy40xi15IjXqguKGY=;
        b=bHYIhp0YZghPFMaa/Bj7OD7TfjxzIoxfxKlgEqXhQRaosUa2SobFu+TzSw1ea8eAM3
         0yHZjbQf8GuN+RBwktO7i5ai0GbcCOyDkhWbb6AS+BLrJEDx9YP7IK/4+kX2UGItBpnM
         NN5Mpjd/+UK4ZESxsqLEroX5/VmKJc1mHvSMXLplLubSUkYxsjyYL1kP/LzwjRvU9P2/
         dbANOKLPZjyr0mQvErMeRc7DXksxqHPQOxG45exZE38DLRq5qcSonB2qCAXeTzEA5apT
         8c11eSwqNjBC1jl4KAvzkEp/eUQj9G7rl2nU1Ovqb46ME3MJ0zsqN6cz1jSG5L4nV1no
         QrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Eh1dKZUiTbRK0TcKnO/1EzJe9vxy40xi15IjXqguKGY=;
        b=QVNzXxRax3vspOR3REngg1NmUyziyaxXZdu8qEKvmGMBglA88kVMsQ1aVqCEBnHpH4
         SXo6FmZTjYetybzVgzfV6NDyEGZcubAgvFGuNX1hMUWykof6EhXd4i04jrIlseONj1F6
         bqyMYa/MqqpxHzzELIQWCxOreRb01plmroTqptD4QSPD0LSu24yLAqu+SD2HAjAlWU6K
         ekU0hAf1CZo2FeyqASV8Oef/cx3MolwatDjcSwHd8XXgaei3YNfHZCMQVgor0/CGJjXI
         jDplZnKOcawu7bSpTDlGBd63rfPudJ/4ilZZJ+w2g7dpoYKWeAIRLtR6tpg2JXxV/nEW
         pjyw==
X-Gm-Message-State: AOAM533XCNTpZ5Td0OAGKRO5tx0/H15HfNDYyKI1xrVhpnZ7kYzvZXgS
        xk8ENw7tTTRtggqMKvT7S3llpajZkNodOvqwfNEPFRJq2IsKeg==
X-Google-Smtp-Source: ABdhPJzkvNRsdi1oQzkzM7P688QL9FXFcOsAhthLT3jR62LUOnW5ey3V6V/NhwDb/1NrA30vNrN8Zy0pqmtgmISM8e0=
X-Received: by 2002:a65:5244:: with SMTP id q4mr7226127pgp.50.1609058870510;
 Sun, 27 Dec 2020 00:47:50 -0800 (PST)
MIME-Version: 1.0
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Sun, 27 Dec 2020 14:17:40 +0530
Message-ID: <CAP2OjchiEZH7sxKipY0Q89L6e4mG9By4JYDKXf1HUWp0nWPtRw@mail.gmail.com>
Subject: Inputs w.r.t understanding of selinux notification and systemcall
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi All ,

For one of our internal projects we wanted to evaluate the functionality below .
Can group member please share any input w.r.t below aspect can be
implemented or any pointers on same :

a) Is there any mechanism to generate an event / notification for
selinux denials
    ( like say we have an action which is denied , so instead of user
reading log
      file if there is any notification mechanism which can be used )

b) If there is any mechanism to block calling of certain system call's
/ library calls .
   ( idea is to discourage certain instances of container to avoid calling some
     predefined system call & library functions )

Any pointers or comments or feedback on these two points will be helpful .

Thanks ,
Ashish
