Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF625C04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E84320868
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzEDYV8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E84320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeLACd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:33:29 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39430 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLACd2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 21:33:28 -0500
Received: by mail-ot1-f50.google.com with SMTP id n8so1549391otl.6
        for <selinux@vger.kernel.org>; Fri, 30 Nov 2018 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dDHWqZkkccnJe+G/DIyKREdd/snyXIh8V6jtI88vniM=;
        b=tzEDYV8hVaaYgxUln2AtUp8m7XRk9KCi6zMOJSu44vuhxsIcSGJj5G7mWEV3uWQ/vh
         ZK0edINjh2JhTkFceEPe90Zr9yNV6etMBRyI28zEAAyBJl9fsmXmIPRdzwJD2hsTgMqL
         NvkoxTi5kKOM8J9+26ySnYJT8nbAETzg6WG/b6nhD1CVE8nV5BeJ6knNEmcLHArAewXx
         qPlNZbXqfjtAi8q88w8ErIhdlyU62xXWVjSq/Cs0HgF450HxVy4y1k11mLqyQI0D23U5
         dh259+nOig1dadNttUGDDqHnM4vDdPC294loXpgDM0ZBCbOxCrTPfhv4l5YHzuC4SUt7
         I7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dDHWqZkkccnJe+G/DIyKREdd/snyXIh8V6jtI88vniM=;
        b=dQaQCfx9ODsg7wscmcWufR4qQNHj/gyYylGW8pK4huMDamQ+mrPDIzj8A+BSk4NUkE
         +wJ4StZl7uuh2+J8X0/J6aBko3lDTyplTPFWAfUGBNKj4+1EoTVLjnc/sx3jYFkNvKNS
         mKhghYhkN7HRgj5NCQWKDiKm7+l9FEPA3S2UqRqnnecDYyt/iYZpjKQkk686uXJeZJpp
         pmcgl+TXfgJxil7uJwGVHlLHO1FWK2OpwosgmFlVaAxJaDaSvzqUzDSXjV/1GPqUT5Ix
         DupDBkMDAKZuPBMQUYzmUXuE2GBAavsQYzkpL2XvHriJFysidyi85pm+TKqnJ0y/QCpr
         LQmw==
X-Gm-Message-State: AA+aEWbQT/VOHGm7yDyI6cpiZLV1VRm7nj3s36KCYXUxD4hc5oBNAmQd
        FrDlFo5knlpcA0+Rn437mS5bZvaYzpgY7k1rgOhOxw==
X-Google-Smtp-Source: AFSGD/VuTlKz7SzZ0JmM96D8Yhv1HUQO0PXBBARsRN+7bA8ZpUo7poNYGNaz59r1RgS2R/L12cF6uzLVHtwO8DpWAMo=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr4058552otg.74.1543591428009;
 Fri, 30 Nov 2018 07:23:48 -0800 (PST)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 30 Nov 2018 07:23:35 -0800
Message-ID: <CAFftDdrK7mWf6j8TAB2f9XgvJU7a+7ssV6K_prZQk2m12Gv6rA@mail.gmail.com>
Subject: Kernel Ueventd KConfig
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I long time ago we had a discussion about disabling a KConfig when you
see denials like:
