Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3584C76196
	for <selinux@archiver.kernel.org>; Tue, 28 Mar 2023 23:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjC1XIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjC1XIs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Mar 2023 19:08:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD20212C
        for <selinux@vger.kernel.org>; Tue, 28 Mar 2023 16:08:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54601d90118so105060847b3.12
        for <selinux@vger.kernel.org>; Tue, 28 Mar 2023 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680044925;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSQMHyUAqVGVS2BQigz/A6ja8dJSfiSf613vf2Qfabc=;
        b=cVQt9bu7I3EGZHXeNHx3U4o57jcXzPIJjBZMjpKHD/FUnKowQFmQs2AQ4+hk0TZMLe
         9ooVdivzmNZBQPN6C6EW8Zzx/Jh7uVO7Gb+BuedaxYeBCliIHiFPN4eAL10XC92aj7vH
         +e9wUppKga8bQydQE3lwD6FMYb/oQoPDMBPXAOypC+IHg8WnBgQiShkQTltg/fpzFEy2
         BGTYNjh9fqOjAGqkDlBQ8UBUiyYGELN85aHNIBkI/vOhS8mmlYPf6ympIB+hRvNaHq8T
         QbWO1ipKw76wtjrPGos+97NgT9jJ7EW3fweMyFv3HyIGs0YvJncejNxkp0FgeymH/0Ze
         AaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680044925;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSQMHyUAqVGVS2BQigz/A6ja8dJSfiSf613vf2Qfabc=;
        b=qZztX/74B5xGdgJm76sf2Y90qbblT4fmzovmrxIfUq/rzr/Ub4E2ULkUf+xK0lScMT
         N6Mrcw+yndcEa/309aua7A4IF0fWYOTmYe+sIFPmoP1AO5Jm0/+9DQHZKznBihDVAZuB
         6SNNeomUuAhkNiz7N2i9vyMp7m/ccg5KUYHap1Pmgz7B7xzShnVuRbQoBCIRUtqCl3sN
         djPCtR2by7dIkNKGFQaTMrBLdeWo6oZ0uq7g7gfPGhCfVKn3paJR0Uw7rxEFTyGVJe4C
         HXwPt61XFAMJI9KsWhUEHXb554DjL75JcDARcCdKUJ7O6l40mD87nuGrHuPRj0rxvzjz
         QxeA==
X-Gm-Message-State: AAQBX9dRC6qsHOhP8OV43crx+1xx+3IolSAZerTywTSkfWlGLgh59q1X
        OvETeFwSlfbwBkfbyE5cy5pZ05J2oY9E0oxlsNu9q72QRdlacJwkHg==
X-Google-Smtp-Source: AKy350abK8FdRjqum0rkpK7dFO74Ka6qWR1lzCgORAvXYVmNk4vPUiF0YnEYgjzDVu8XJA0CXmwa6+vQTcGj4938tKo=
X-Received: by 2002:a81:af18:0:b0:541:7f7b:a2ff with SMTP id
 n24-20020a81af18000000b005417f7ba2ffmr8217177ywh.8.1680044925502; Tue, 28 Mar
 2023 16:08:45 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Mar 2023 19:08:34 -0400
Message-ID: <CAHC9VhQ7A4+msL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com>
Subject: Potential regression/bug in net/mlx5 driver
To:     Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Cc:     netdev@vger.kernel.org, regressions@lists.linux.dev,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

Starting with the v6.3-rcX kernel releases I noticed that my
InfiniBand devices were no longer present under /sys/class/infiniband,
causing some of my automated testing to fail.  It took me a while to
find the time to bisect the issue, but I eventually identified the
problematic commit:

  commit fe998a3c77b9f989a30a2a01fb00d3729a6d53a4
  Author: Shay Drory <shayd@nvidia.com>
  Date:   Wed Jun 29 11:38:21 2022 +0300

   net/mlx5: Enable management PF initialization

   Enable initialization of DPU Management PF, which is a new loopback PF
   designed for communication with BMC.
   For now Management PF doesn't support nor require most upper layer
   protocols so avoid them.

   Signed-off-by: Shay Drory <shayd@nvidia.com>
   Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
   Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
   Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

I'm not a mlx5 driver expert so I can't really offer much in the way
of a fix, but as a quick test I did remove the
'mlx5_core_is_management_pf(...)' calls in mlx5/core/dev.c and
everything seemed to work okay on my test system (or rather the tests
ran without problem).

If you need any additional information, or would like me to test a
patch, please let me know.

-- 
paul-moore.com
