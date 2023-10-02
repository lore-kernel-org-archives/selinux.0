Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A753E74905
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJBR6c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjJBR6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:58:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772F90
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:58:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a229ac185aso698927b3.1
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1696269508; x=1696874308; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJImh8Lv16g3MKRRsaw/PHvGtUAtph2jLPySc5VfIWA=;
        b=fQz0LY9ddPJttMt5J1pKxFQ5SgOPZr6ER68NBvUNFd/WKmG3QsuQFb3Q+p77qSyH5E
         jtfL+5P3aCYQsq0dHbJnMSqhVg3DRWCTViCg0Ty1Eici/AHi7lgtfkxjX+Y5dt9fwqyM
         3Cl2FlDYNfdSEz6XtYTdh7LkD3J+peE8v3VEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269508; x=1696874308;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BJImh8Lv16g3MKRRsaw/PHvGtUAtph2jLPySc5VfIWA=;
        b=vdFRd8Av0OThLj4DBKIfReaFCMh6lHOjd2aUOARDDbgmJ1FRyhBXCJZsLr7r1KMEGl
         Hwzz8IMR3bF/wGi0xaMDI2Z8PIam0and9Vkg/dt72MqtJqLvXTCc29b3lGIVqu/USdtY
         pdlWabBkkXpXwDFX86uMoRTeWWjbhvFagMGkfkw8LvJoLwmaYbgBhoSMy4eLMU/ydjlK
         gQhvtYi5IFYBg9EkfEYLNzGclq8O5KOjW0XIQ8oeN2kpnjLquCNilz5QIBOnmyesBPN9
         ec/VtaWpycSRtiD4pMKa1ptI4AIpgE8jv/zSfC8Ib/at+ajj6S8jAywSSuh1mGBWQCAm
         Ifug==
X-Gm-Message-State: AOJu0YwBAuNWA2qXyOU/7019IajsoKsQzt1qEA+Mp97H3jFURw+Pgz9V
        GLG19JXYQDcpvihkD3obJ5vHgejw9ajSRgaaI169qxask/cLmZC/QLXz8zwEHQS2g813Lwjylci
        HpYKGj9JrBQwQ12elzL+35aEc0xmmbWdIMJoFl7kfitN04t35JZpZW1NN+T0nIzwtb/DrRqFW
X-Google-Smtp-Source: AGHT+IE7Vu0VZtkFOh/nZAXvvrxcMhQU4Ed8XxI7kDxLthoDqhq2D1xxum1J9XUzuc7qpY6xcOswOw==
X-Received: by 2002:a0d:f685:0:b0:59e:8f6d:92e with SMTP id g127-20020a0df685000000b0059e8f6d092emr13080379ywf.49.1696269508078;
        Mon, 02 Oct 2023 10:58:28 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:a0a:fcbe:4ac2:d85f:c566? ([2601:145:c200:a0a:fcbe:4ac2:d85f:c566])
        by smtp.gmail.com with ESMTPSA id jx18-20020a05622a811200b004180fb5c6adsm6673662qtb.25.2023.10.02.10.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:58:27 -0700 (PDT)
Message-ID: <0a064820-8cd9-544c-0454-79cb53419d41@ieee.org>
Date:   Mon, 2 Oct 2023 13:58:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     SElinux mailing list <selinux@vger.kernel.org>,
        SELinux Reference Policy mailing list 
        <selinux-refpolicy@vger.kernel.org>
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20231002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A new (very overdue) release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20231002

Notable Changes:
* Several Gentoo fixes ported from Gentoo policy
* Fixes for containerd/docker
* Move excessive capabilities in container_t to tunables.
* Various systemd updates and fixes
* Updated object class/permission definitions for recent kernels
* Add support for systemd memory pressure notifications protocol
* Xscreensaver updates for their newest release
* Remove interfaces deprecated before 2021
* Add tunables to control network access in:
  * *_dbusd_t
  * pulseaudio_t
  * spamc_t
  * syslogd_t
  * xdm_t
  * xserver_t

New Modules/Domains:
* crio
* eg25manager
* iiosensorproxy
* kubernetes
* lomemorymonitor
* powerprofiles
* rasdaemon
* switcheroo
* systemd-pcrphrase
* thunderbolt

Full Changelog: 
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20221101...RELEASE_2_20231002

-- 
Chris PeBenito
