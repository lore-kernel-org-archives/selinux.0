Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF21C433DB
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83D6207BC
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbhADK4T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbhADK4S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 05:56:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77951C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 02:55:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d26so31656742wrb.12
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=az6LIG5dUTg04JVTx64+Hffown7l6cAOXHLZ85rpdHQ=;
        b=Ksb04rbc06BNlN+fRTTH1gsS+iHbQ7N5BIANYmTCpCF5YCtnsFtlGOYotCNyvr5Iqx
         o3Fcu2h/oBYBXEWf6d6ngkBKcymugEVKw4CuSqpx01M7j/Z3d/83bnLZASQ2ZwCLmbm4
         +HHW2Ivef9Bg0+n6+iPDKNjBkV8FN6HYToLI0D0lglC4rYreGt+PhdsPft7hvmYEFY8R
         hfx6GEGJND2y7PgMqU62vuPC5ykJYPKKaEQ0nennSCguDDueOUIABT1CvMFe9NMfgdtU
         2EB/vR/oPVFkdl++2sviDeJc1GOWOx+nF3HR6OZ2tuBdGlbGUagIQZiWG5GJ9/C2FEYx
         Uqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=az6LIG5dUTg04JVTx64+Hffown7l6cAOXHLZ85rpdHQ=;
        b=LwogzdSONZUjqKbZ7fa4ekc0ANU9GXb4GE3vGWofalCrHuw9cijjUMF3cVBJUhpobV
         KU9IRzW3rfHkExuA+p4C1H+riPQ11Y+gJH0u+JsXLY58zBwxgvDsek0WI5SwklJN1FJO
         kZr4A2k7w7JQVUSE22cChGjcu/GY5FPm08vdeJWO3WX8peV3Qr/Lo34g0+f1j4GLraDs
         gzsS92y5WEYUbCfXi/8RZ3klsKVFZR04p6WuhE11J712hB91GObBZVa35GXxpaQKU2W1
         S8StuJkRt0NLpl2QWRHmaFMFLUoahw1VcoxCt0PkRXYhF3GVj1sVceaXxgqlSy+tSVp0
         wtrA==
X-Gm-Message-State: AOAM531OOutqLD1XkPJIFpFGL0CvwPOYmpGh+9svULaAHYLMOBMBc2VN
        fn8/uaoRqqHLlLt7Z99C0CWRiQ3YTlqeXcUUYWjQ8m0mEtKRLaaZ
X-Google-Smtp-Source: ABdhPJxiWai1Fb0AiA1GhioaORJ718JbGfDI82ZYKIabUfTuiTGEjdoOl7ICHi4hshYGOnWOwOiMHh6GJ2TMw8oaFOk=
X-Received: by 2002:a5d:4e86:: with SMTP id e6mr81052460wru.33.1609757734809;
 Mon, 04 Jan 2021 02:55:34 -0800 (PST)
MIME-Version: 1.0
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Mon, 4 Jan 2021 16:25:23 +0530
Message-ID: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
Subject: Selinux context type is same for root & normal user both
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Group members ,

I am trying to get SELINUX being added in our custom BSP .

I am able to reach till i have selinux-refpolicy installed on target &
the getenforce / setenforce commands are working.
I can verify them using log messages in /var/log/audit.log

Below is the observation ( problem ) which i am observing w.r.t context type of
selinux .
a) File created as root has "system_u:object_r:root_t"
b) File created as testuser also has "system_u:object_r:root_t"
    but i was expecting something  "unconfined_u:object_r:user_home_t"

Can members please provide any input as to what might be the cause of this
or any pointers to debug the same.

I am using TEMPFS as a file system .

Thanks ,
Ashish
