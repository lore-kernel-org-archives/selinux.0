Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1768BC001DF
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 03:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHADQ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHADQ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 23:16:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18581BC6
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 20:16:53 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bb7e083783so3936465fac.2
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690859812; x=1691464612;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4QTR06lU+Z2QQhT9il1AIc+T6GWoIGhdb3a1mvLXgE=;
        b=E3aa8E6EKI9WhAp0eXl9J+bxjyJ2VaUgw1NknRY5WyzS+bryB5m9+zaX6VILCYiSKw
         cEcyMN+2K9gcbyYc6fwa6tHYksgeQOS0Z+XxN2eK0qLMj6HdV9plHovo24YAZCPAGxos
         GhMKcReyw+YLJLUOaz9GhY6VYHL4RHhIiZlkE23T5PJOnaQkfZi33rAFw9ngNZL5GC5W
         py9E3nKwS73u57daQw4RfcfURdvWgA44iltbegkKYUzwtPWJZ0znalI1ZVCYzPZ7tikJ
         vTIsteYsbttkRtpmHLdwTeyPQPahrBlryIuQWQ8OnaGKlySYHfCYnp2JudYRKtoVO9qH
         QLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690859812; x=1691464612;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J4QTR06lU+Z2QQhT9il1AIc+T6GWoIGhdb3a1mvLXgE=;
        b=kzPVyRcYLyxcHcF3cncAX3VEvrcheDxnxFle0YjFNEDUO2bYKZw1A33GU8bQZWzNNn
         TJw4LI5HW8SM6Enr5MpYDDsF9JBWfg/tjP/GN0uwLd5QeWDEGr3PNvkjv8CeDLpdIXyq
         ZtGJ3UQ0TA2iWMJWJVl1AGwpw174PPWbJeVgCziE4ECxUuI21DE7GLWBo9wCF4l50bca
         Cr63RpMUHJ2jLPZGyqNIYcl4OuYMr1fAefm9ypZaTsBXm+JXowYGVJRBVm0Iuoxlxd2V
         EusoTtyPBrQjfmCAemRxITLEwdEuDA/CVnAd/JP0C+nWHzwGv3FLUSBAS9W8OemEd+wx
         L4+Q==
X-Gm-Message-State: ABy/qLZALBXuNqHMov9fcJadzORywOEErwE2Y3y2BQ2364E2Hoo0q6k0
        x1CpHXSJYkcf21GUKR6I1U848g5AXwWDXw==
X-Google-Smtp-Source: APBJJlEiD9k4Bu2hKnaRE1v6wu2Ff/8a05e6/XMRphlI0/Nf9YbKD1MIZb29gQbIzf8Ysf4umBVsmA==
X-Received: by 2002:a05:6870:8990:b0:1bb:5480:4bc with SMTP id f16-20020a056870899000b001bb548004bcmr12388079oaq.37.1690859812226;
        Mon, 31 Jul 2023 20:16:52 -0700 (PDT)
Received: from smtpclient.apple ([118.136.20.175])
        by smtp.gmail.com with ESMTPSA id o29-20020a63731d000000b0054fe6bae952sm8844246pgc.4.2023.07.31.20.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 20:16:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   NAOKO kutroda <kutrodan@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 1 Aug 2023 10:16:49 +0700
Subject: =?utf-8?B?44GK44Gv44KI44GG44GU44GW44GE44G+44GZ44CC8J+Ygw==?=
Message-Id: <6366F642-1F73-434F-BB27-B2E87E290329@gmail.com>
To:     selinux@vger.kernel.org
X-Mailer: iPhone Mail (19E258)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

5a6c44GX44GP44GK6aGY44GE44GX44G+44GZ44CC8J+YgQ0KDQppUGhvbmXjgYvjgonpgIHkv6Hj
gIDjgIDlsJrlrZANCg0K
