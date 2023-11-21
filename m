Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD72C5ACB3
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKUGQr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 01:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjKUGQq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 01:16:46 -0500
Received: from mx08.samokat.ru (mx08.samokat.ru [45.90.244.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91BAA
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 22:16:40 -0800 (PST)
Received: from os-081902002.samokat.io (localhost.localdomain [127.0.0.1])
        by mx08.samokat.ru (Proxmox) with ESMTP id D7F24EE3B3
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 05:23:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samokat.ru; h=cc
        :content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:mime-version:reply-to:reply-to
        :subject:subject:to:to; s=mx08; bh=Y6pD9fRLODwrM9h1xLnuG9W/s5Zzx
        soItNuqaC1FKq0=; b=ZV460V2O9XjLkPnkIeGZB9efM3lcOuPFKgiQ9VhMyhhQG
        Euavr9caWWOO/5yvd9snXJ8gx8RBi5QOSvumcyt6h5PEY9tJfRIt/NR1Ieu68K0a
        p7taGEs2p2g7rclzn542N1vmZEI5H5TjNsZLv1ITskJoBBCcJk6kBs1GpZYW7UOV
        WeeExv0PXDQmc32g9WP1PZVnflp5l4NFba98fhGu9jEi6TDEJ5XsTnve8zp/62E3
        HimEeLIgJhYLcWBL5MmIqr/BKagooRf3R9tiLKehhXDUeOUpSDDfOZrTqmpNqih1
        F/QIuQ08bAMZQuulA4D8DdRSsSSqYGWpvZPZH+AFA==
Received: from ksmg-08.samokat.ru (os-081902003.samokat.io [10.18.145.3])
        by mx08.samokat.ru (Proxmox) with ESMTPS id 3845117F907
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 05:08:39 +0300 (MSK)
Received: from os-081902003.samokat.io (localhost [127.0.0.1])
        by ksmg-08.samokat.ru (Postfix) with ESMTP id 1FBFA1A000C
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 05:08:39 +0300 (MSK)
Received: from [85.195.105.114] (os-081144001.samokat.io [10.18.144.1])
        by ksmg-08.samokat.ru (Postfix) with ESMTP
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 05:08:38 +0300 (MSK)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Heartfelt 
To:     selinux@vger.kernel.org
From:   "Anna Pechorin" <ap@samokat.ru>
Date:   Mon, 20 Nov 2023 18:08:38 -0800
Reply-To: dealings100@hotmail.com
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181488 [Nov 20 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ap@samokat.ru
X-KSMG-AntiSpam-Rate: 60
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Prob_reply_not_match_from}, {Prob_msgid_missed_1b}, {Tracking_cluster_exceptions, from}, {Tracking_free_reply_not_from}, {Tracking_cnf_strong}, {Tracking_dating_nourl, reply1}, {Tracking_dating_reply, mail_free}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;samokat.ru:7.1.1;127.0.0.199:7.1.2;hotmail.com:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/21 00:12:00 #22490067
X-KSMG-AntiVirus-Status: Clean, skipped
Message-Id: <20231121022349.D7F24EE3B3@mx08.samokat.ru>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello

How are you, I hope this email finds you in good health and spirit? Before =
I continue let me humbly apologize for coming into your space unsolicited. =
Nonetheless, I take solace in the fact that it is with the best intention a=
nd for our mutual benefit.

I chose you among other contacts I came across in my search for someone who=
 can be of help.  It took a great deal of brain storming to arrive at my de=
cision I must say, with the hope that my contact with you will be private a=
nd confidential.

The business idea that I have is to partner with you by investing in your c=
ountry and you becoming my fund manager. This whole idea is borne out of th=
e fact that presently I am totally indisposed to carry out any financial tr=
ansaction owing to restrictions relating to the Russia /Ukraine war and the=
 suspicious death of my husband, Ivan Pechorin in the hand of our President=
 Vladimir Putin. =


It will be an absolute pleasure, if you would have the wherewithal to handl=
e this project to my satisfaction. Every detail concerning this project wou=
ld be laid bare to you upon indication of your interest. =


Strictly respond to: dealings100@hotmail.com

Best regards

Anna Pechorin.

