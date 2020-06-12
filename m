Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1D4C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 20:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D273206D7
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 20:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="MkUPRzN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLUF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:05:28 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:52448 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgFLUF1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 12 Jun 2020 16:05:27 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 16:05:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id A5FCDDB2764E2
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 22:59:05 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RHimT4F3HEub for <selinux@vger.kernel.org>;
        Fri, 12 Jun 2020 22:58:50 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 4D1C2DB2764DE
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 22:58:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 4D1C2DB2764DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1591991930;
        bh=ten02w9uek6iHMuimS2ETTIYDv1xYbMAkAftVADjTDg=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=MkUPRzN3Ncn9Wwka3UUDCO6aob9zls4ndHQZVq3jwGB46wsyUmBlz+uqYjpFffpSN
         HDsyvDs4vG75Ahjw7aL0vLMEMWILrInJOW9Tgs1d7SQlyT8mpbf9NONV++VbFWmLT6
         cgJsojsE9KkZ8MK+GFBzN2Kp67Vz2lD3v4dk9/FDE4ckFSSfMYVUnnCUCW3MuCpFh6
         O91j1GIOYTzW/ShpbtgcGA1DU5L5WlFo7GDuyNXwQYNNSh9dSeC+aO7U1UnBAtktQG
         K3TXJURESAdZyAJg8C9LfCnWQ/EhJRkHSHEryKUBwTy1uHqhqooM09Dw+xXZZFnezZ
         Xh7nrAuJPGcUw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5p2Z52iepORI for <selinux@vger.kernel.org>;
        Fri, 12 Jun 2020 22:58:50 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-64.ip.moscow.rt.ru [90.154.71.64])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id DDE1EDB2764DD
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 22:58:49 +0300 (MSK)
To:     selinux@vger.kernel.org
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: How to off RBAC in SELinux?
Message-ID: <237d104b-3cb4-8527-386a-dce96c85ecec@rosalinux.ru>
Date:   Fri, 12 Jun 2020 22:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Is it possible to remove any checks for RBAC (role-based access control) violations and check only against MLS/MCS rules?

What I have:
1) a system with most files labelled correctly according to a Fedora-based SELinux policy, which in turn is based on the refpolicy;
they will probably have to be kept to make what I want work
2) RBAC-based control from SELinux is not needed, e.g. it is not needed to prevent httpd from executing 3rd party binaries
3) MLS is needed, e.g. it is needed to verify that httpd cannot access "secret" documents

If I understood correctly, main calculations are done in context_struct_compute_av() (security/selinux/ss/services.c), but it does not query MLS separately.
Also, all actions are prohibited by default, the problem is that the policy specifies what to allow, but I would like to wise-a-versa specify what to deny, but keep MLS parts working as is.

The question is: is it possible to make selinux ignore (2), either in the kernel or in policy?

In other words, how to make SELinux make allow-or-deny decisions based on MLS/MCS only, without RBAC?
The only question that must be answered is: does this action violate rules of accessing objects of different level of secrecy (sN:cM) or not.

Please give a clue where to start looking for a solution. Thanks!

