Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362CEEE49A0
	for <selinux@archiver.kernel.org>; Wed, 23 Aug 2023 04:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHWEcF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Aug 2023 00:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWEcE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Aug 2023 00:32:04 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C99E57
        for <selinux@vger.kernel.org>; Tue, 22 Aug 2023 21:31:58 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-cd-64e576d41470
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id B3.E8.10987.5D675E46; Wed, 23 Aug 2023 08:02:45 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=OgJ5NDzELxxnJHsewRCSwRqlI9hDtwunxMuT8Y9g62DWG5AKX73IZJEQJ2pGYx3yy
          l8pGIcpqMB8bOmRYe8Bj7J2Wz3/n2FvrgtosT2Lkhv1P8Qb6rtzTapvxvXYj/tM7v
          yRr0/a2yc70l8jFlGCqj91Nwwpb53M/9JLVf3S5kI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=d9AK8P7EiqfrPDXeMob+vtuzdz0BTPFSFXPYz8JeEsqjekottvuVfnTuPw5NecXuj
          k+Y5Z9Cx8utcW8tndKjoURWdgXEKS09XA2jBcUD5p8/OEQArfcbbYdUae1l7SbAXa
          rIB6pLnEIm/f+n94tiH43GubkvFcG2jtYSdkMnl90=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 07:01:39 +0500
Message-ID: <B3.E8.10987.5D675E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     selinux@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 19:01:53 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW/dq2dMUg987uC3OHz/G7sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAicWXGSdYuRi4OIYE9
        TBKb1uxgAXFYBFYzS6zt+c4E4Txkllg2ax8jRFkzo8T1F/2sIP28AtYSO69dYgGxmQX0JG5M
        ncIGEReUODnzCVRcW2LZwtfMXYwcQLaaxNeuEpCwsICYxKdpy9hBbBEBaYmnh1Yxg9hsAvoS
        K742M4LYLAKqErtfHgGLCwlISWy8sp5tAiP/LCTbZiHZNgvJtlkI2xYwsqxilCiuzE0EBluy
        iV5yfm5xYkmxXl5qiV5B9iZGYCCertGU28G49FLiIUYBDkYlHt6f656kCLEmlgF1HWKU4GBW
        EuGV/v4wRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivrdCzZCGB9MSS1OzU1ILUIpgsEwenVAOj
        n97xhIxtodPu7u3e28p14/U8gxjX7elvo8oTvGevWeh/XMwq6zqrRs2fhGqzKe9juu4m1+38
        k/n6Y1Zv1/Ifb/t9zx3Xml1yfNOpO8r9Gk+6hKLqOMsTd//zr7B6zP9w5YdNrWssnIqNT+5f
        G6d6iWd9Ydo0/T0Wmy60MRw90By2S9ruyBUTJZbijERDLeai4kQA2QYBL0ACAAA=
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

