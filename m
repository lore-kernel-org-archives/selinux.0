Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9AC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AFC208B3
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nspjRiFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFQLKF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQLKD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 07:10:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BEC061573
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 04:10:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so1460199wmh.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:autocrypt:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5a7J0MADRlMK6gn/+cJbAlWBZL3alW9OgjbCKRS3ots=;
        b=nspjRiFw+MnKTroEhwVA6nZUNCVlgq2oy6LN6IUB24CDW/RH5qVQGUAwHuE8LqNP+E
         ol+Xlb3MoDSkIqNvaeuO33kUEqi/EEKqwXV+IWxX0vrXDBGIsxatSAqUAqTStufHWX0V
         CWuWZf5kDE6HhsvgA4I9lNEyHlXWUSKLBccPOoFC6uouEyYHCjYgVtBqRIk/ccwDsiT+
         qnjqhaHIyzQg52YIxElsaEZ3dnx4jdPBQdZzw2P5p92rE+cz3K6NnOyihfsyQxcjgTyN
         S3INMCNQZTwyOBmsqUcFSrXwLf9qDFP5ALtQq5bxEZWxg1lFsEM8bFhm+D6Xd1bM7GpV
         n0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:autocrypt:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=5a7J0MADRlMK6gn/+cJbAlWBZL3alW9OgjbCKRS3ots=;
        b=Ch4p8SqYT3T5TAI38fqLqEX+oJ8zxfaU1sC9JWjoOgW/v88XBCqEwkjV1hydOgU9IW
         17CR8coWe3FnNkdH4R4Sz8/Adqey4qccLcSq9/kptVFopDXBOg1+UPJ5Wwd16zxqTSP9
         3nJVKj1ZwbxNeK+8KlA0K4bLfl830sNG/hb3fxdy5GnQ+bVykL7p/kwB4eM2yK8GE1Q8
         jpockUJpXU+Lg14DiKKt59HxmMjaGRt/xwR3TASurX37GXT72FCia75yeWDIbR15E1ra
         r1Cow+IlduujINl9189d4AvI9Q+pVunLo3iXVLwXXSSlP8brsNmAzf5gclCujvuxYfdX
         4E9w==
X-Gm-Message-State: AOAM532VdOuvbNPcPUXELYgEUZB/kYmvpdbLrBqpLlv2E9qXhkyTxQTI
        mSLidQu4g2NCHsaKXMAxerEPkC/D
X-Google-Smtp-Source: ABdhPJxr+3L29xicns0A3dVKoc/8z7Ot9888V430pIx4w+OSJ/2frdqnKzJLF4omOa2j8Btl2dXaSQ==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr8257483wmh.111.1592392201277;
        Wed, 17 Jun 2020 04:10:01 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a? ([2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a])
        by smtp.gmail.com with ESMTPSA id w1sm7705101wmi.13.2020.06.17.04.09.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 04:10:00 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     selinux <selinux@vger.kernel.org>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Subject: Minimal CIL policy requires process class with transition permission
Message-ID: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
Date:   Wed, 17 Jun 2020 13:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I've recently started playing with CIL and for various reasons I wanted
to start with the smallest possible policy.

After having some issues with a tiny CIL policy that compiles but does
not actually load, I tracked it down to a hard requirement (of the
kernel ?) on the permission `transition` of the `process` class.
Is there a reason for this or is this a bug ?

Kernel: Linux selinux-pr-test5 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1
(2020-05-23) x86_64 GNU/Linux
policycoreutils: 3.0-1

Thanks for your help, bauen1


; vim: syntax=3Dlisp :

;; initial sids these can be mostly removed after selinux 3.1 and linux 5=
=2E7
(sid kernel)
(sid any_socket)
(sid devnull)
(sid file)
(sid file_labels)
(sid fs)
(sid icmp_socket)
(sid igmp_packet)
(sid init)
(sid kmod)
(sid netif)
(sid netmsg)
(sid node)
(sid policy)
(sid port)
(sid scmp_packet)
(sid security)
(sid sysctl)
(sid sysctl_dev)
(sid sysctl_fs)
(sid sysctl_kernel)
(sid sysctl_modprobe)
(sid sysctl_net)
(sid sysctl_net_unix)
(sid sysctl_vm)
(sid tcp_socket)
(sid unlabeled)

(sidorder (kernel any_socket devnull file file_labels fs icmp_socket
igmp_packet init kmod netif netmsg node policy port scmp_packet security
sysctl sysctl_dev sysctl_fs sysctl_kernel sysctl_modprobe sysctl_net
sysctl_net_unix sysctl_vm tcp_socket unlabeled))

;; these are requirements for compiling the policy
(user kernel_u)
(role kernel_r)
(type kernel_t)
(sensitivity s0)
(sensitivityorder (s0))
(level low (s0))
(level high (s0))
(levelrange lowhigh (low high))
(userrange kernel_u lowhigh)
(userlevel kernel_u low)
(userrole kernel_u kernel_r)
(roletype kernel_r kernel_t)
(context kernel_context (kernel_u kernel_r kernel_t lowhigh))

;;
(sidcontext kernel kernel_context)
(sidcontext any_socket kernel_context)
(sidcontext devnull kernel_context)
(sidcontext file kernel_context)
(sidcontext file_labels kernel_context)
(sidcontext fs kernel_context)
(sidcontext icmp_socket kernel_context)
(sidcontext igmp_packet kernel_context)
(sidcontext init kernel_context)
(sidcontext kmod kernel_context)
(sidcontext netif kernel_context)
(sidcontext netmsg kernel_context)
(sidcontext node kernel_context)
(sidcontext policy kernel_context)
(sidcontext port kernel_context)
(sidcontext scmp_packet kernel_context)
(sidcontext security kernel_context)
(sidcontext sysctl kernel_context)
(sidcontext sysctl_dev kernel_context)
(sidcontext sysctl_fs kernel_context)
(sidcontext sysctl_kernel kernel_context)
(sidcontext sysctl_modprobe kernel_context)
(sidcontext sysctl_net kernel_context)
(sidcontext sysctl_net_unix kernel_context)
(sidcontext sysctl_vm kernel_context)
(sidcontext tcp_socket kernel_context)
(sidcontext unlabeled kernel_context)

;; this works
;(class process (transition))
;(classorder (unordered process))
;(allow kernel_t self (process (all)))

;; this should work in theory
;; systemd or load_policy will try to load the policy, but the kernel wil=
l
;; return "Invalid argument" and log "SELinux: failed to load policy" to
dmesg.
(class file (read))
(classorder (unordered file))
(allow kernel_t self (file (all)))


