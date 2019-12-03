Return-Path: <SRS0=8r5V=ZZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E8FC432C0
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 02:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3420659
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 02:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rrrOzSU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCCO7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:14:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43664 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCCO7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 21:14:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so1874411qkn.10
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2019 18:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=Bp3s9q0It5dOe56tVLXrGSlwN6WmH6wiB32+6ebs7zA=;
        b=rrrOzSU2onOM8RiZ/QT5IX/SzDt3FuiOMGfXjE3ap0BuvWtsf5FwnnI/5GY5LLRLm8
         FKek0zh8MUt7KZ3UXRb3reKiwyBZsz7sDFOueSmRH76dbvpXgcSbs9mgeTe9OKsNrC+3
         IpKfm6aDXwEvLkkw3npMdf2ffyq3ah9MQDH45pbBFJvO5zQ3NjW3KctlwaKJps3lVcS1
         +kmBms1lxZUTu6ym3J+ffrx5O00TOs33y8/UxzhnJTw9IkBNL2FAJmz9fF3VkA0RiAUm
         EM1gsXeEdhxgPRqAdUXgqrNN4eaKmy9D/RqFjQNXcK6p5ge1gchwWkB6r237nKrpI+Jc
         9+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=Bp3s9q0It5dOe56tVLXrGSlwN6WmH6wiB32+6ebs7zA=;
        b=m8tK/viOyaBXpW++SEYzCtfXOhQZxZITNffdcS+Ixef8hMIjlEXdMZVYdrYvRaxNLw
         gCCqpx/A3KVcraaY2jXyfdLc4OyG1+PWhY8l87pejqVRb1qMMRquzTDiVlTwx7qZ8nps
         3ybrPbsSruj1sxeYAZTgudMphFbQlx8QaHL7aG9kpm0PzQOy5SVpxkP2jn02EnxIv7Rb
         IkrDOS2Eoeu63oTytQUuCbnBQpPeIno1CLLQIDFrVbafhUudN3CwD1+P0kXMDvTBNIec
         vHiBBpp7H6dfWbtoxYQMIEfOhvWoLhdoCfrAsttwDBCVs5H9VpwyJg4oSnfghIDbbQQE
         ZkLw==
X-Gm-Message-State: APjAAAUcb5D6ZHFuUT5dpaBfHfv8Z/G+G6ZsRMEpV8YbVc3tKKr/K0ZI
        BN/IWYU3V+7JjYK5Lng6/hQn
X-Google-Smtp-Source: APXvYqzh8OmoijmwR7qSbkWH2C4ackPHyQi5fKdIbolel/XfrEfD3IS23qANZ95iVguuGPi+VmWZJA==
X-Received: by 2002:a37:aaca:: with SMTP id t193mr2625116qke.489.1575339297787;
        Mon, 02 Dec 2019 18:14:57 -0800 (PST)
Received: from [192.168.7.212] (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id l34sm881305qtd.71.2019.12.02.18.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 18:14:56 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     <selinux@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        initramfs <initramfs@vger.kernel.org>
Date:   Mon, 02 Dec 2019 21:14:53 -0500
Message-ID: <16ec989f948.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1575338427.4793.486.camel@linux.ibm.com>
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
 <1575302310.4793.379.camel@linux.ibm.com>
 <CAHC9VhRkosCVR+4qyf=GPKQuQoJzwjZZJ_z7rhE-qiL-TNbtPw@mail.gmail.com>
 <1575338427.4793.486.camel@linux.ibm.com>
User-Agent: AquaMail/1.21.0-1492 (build: 102100009)
Subject: Re: [GIT PULL] SELinux patches for v5.5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On December 2, 2019 9:00:35 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> On Mon, 2019-12-02 at 15:04 -0500, Paul Moore wrote:
>> On Mon, Dec 2, 2019 at 10:58 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> [Truncated Cc list, adding Roberto and the initramfs mailing list]
>>>
>>> Hi Paul,
>>>
>>> On Tue, 2019-11-26 at 16:24 -0500, Paul Moore wrote:
>>>
>>>> - Allow file labeling before the policy is loaded.  This should ease
>>>> some of the burden when the policy is initially loaded (no need to
>>>> relabel files), but it should also help enable some new system
>>>> concepts which dynamically create the root filesystem in the initrd.
>>>
>>> Any chance you're planning on using Roberto's patches for including
>>> security xattrs in the initramfs?[1]
>>> [1] https://www.spinics.net/lists/linux-initramfs/msg04771.html
>>
>> I'm assuming you're not asking about me personally? ;)
>
> No, of course not.  I was wondering if "help enable some new system
> concepts which dynamically create the root filesystem in the initrd"
> adds SELinux labels on the root filesystem.

Once again, that is more of a distro specific question.

--
paul moore
www.paul-moore.com



