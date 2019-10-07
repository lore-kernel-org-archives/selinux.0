Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA854ECE58C
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815DB206C2
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx9cHrXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfJGSbK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:31:10 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33278 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 14:31:09 -0400
Received: by mail-oi1-f174.google.com with SMTP id a15so6534646oic.0
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xNckUU9xIea09fkxSSxiSj380DXZMoepcaxTYxGV58Q=;
        b=Nx9cHrXgZm+2hdhTpljNgLbVLNaF5M38kDyXPjTvWaekdO8uLdlDcLvaZ46rwcDDlG
         fUEox5cIjicjt89+PN1rEV5/CpoOj+W2tTwknV3/wmNkzIYJWodddjme9A2szFzRVVEI
         /4qHPyypk5STUE7iqBrnFm0xzcuiPpsIzy6ZXCwzbcoDLMb/5GcySltRzi2Nbut4t/cD
         vHukGllu4QgZCqYJw8Q66JywpZWM//RFlrZ+a+RzBUHToA+t325hkvdhGa2Z1meNZHNl
         zi1nCZgIfjFeMpDnGKbYVHxh8yCUfDmmKTOLQsSheExs9+mAinuAus7Sn8VtIksjYDOW
         vplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNckUU9xIea09fkxSSxiSj380DXZMoepcaxTYxGV58Q=;
        b=TDJj1WwdyTvlTTjDcY4Lm1qgKi1Ey1ZwUlFJyUo2/uxOCYwj7iWXgDiP3W6+4MWkeU
         IsmmvV6F+u5WwjPafr8pFSA/Xg1XEeOXWfHtRJ2GuW2vxrpn+ozVlMe71TR5YcOdHVlE
         WtQnAdzi+vzkHd82NxGQN7C3qDTnKGwAufItGKfNpQy70EF+7eGWmmQJXjGqk6fdJKpI
         8HuVbBbaapQfUk9m3xBYQr+DbfrCQ+dusCKScO2qSXD70pbBNLtwopmCIVeCdzfEra9c
         Kdb8au5+RsdJL5Tb+Icr87qkZdPXmGDZ7aQQ3HN1U5X7jOphbe0labO+uprl4LnNa7Wc
         ZIQQ==
X-Gm-Message-State: APjAAAXJWVU/jDSyS7h6BN/ikU1SgKPD+wxw7mh0GXIvygoujZGamPAx
        AZ76frWehnb42LUlbBrCsgjTSOyd
X-Google-Smtp-Source: APXvYqxdETBa243+zoTM2A9isBRMbQBf0rRJyS+GbiS++sm53WFN29663PJ5YysnGT3ckVDzLsbhrA==
X-Received: by 2002:aca:48d8:: with SMTP id v207mr522974oia.113.1570473068600;
        Mon, 07 Oct 2019 11:31:08 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-169-186.tx.res.rr.com. [70.119.169.186])
        by smtp.gmail.com with ESMTPSA id k204sm4839412oif.33.2019.10.07.11.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:31:07 -0700 (PDT)
Subject: Re: [systemd SELinux] system status permission
To:     selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
References: <ae9ac0bb-0354-4d5a-fce7-dfc37481f439@gmail.com>
 <20191007165157.GC1088825@brutus.lan> <20191007170941.GD1088825@brutus.lan>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <4309d36c-d15c-1d7c-2e61-5d58e470c1cd@gmail.com>
Date:   Mon, 7 Oct 2019 13:31:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007170941.GD1088825@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/7/19 12:09 PM, Dominick Grift wrote:
> 
> I tried it out with simple `systemctl status`
> 
> Oct 07 19:04:21 myguest systemd[1]: Sent message type=method_return
> sender=org.freedesktop.systemd1 destination=n/a path=n/a
> interface=n/a member=n/a cookie=1 reply_cookie=1 signature=a{sv}
> error-name=n/a error-message=n/a Oct 07 19:04:21 myguest systemd[1]:
> SELinux access check
> scon=wheel.id:sysadm.role:systemctl.sysadm.subj:s0
> tcon=sys.id:sys.role:systemd.system.subj:s0 tclass=system perm=status
> path=(null) cmdline=: 0 Oct 07 19:04:21 myguest systemd[1]: Got
> message type=method_call sender=n/a
> destination=org.freedesktop.systemd1 path=/org/freedesktop/systemd1
> interface=org.freedesktop.DBus.Properties member=GetAll cookie=1
> reply_cookie=0 signature=s error-name=n/a error-message=n/a
> 
> So the method "get all properties from systemd1" was called by
> running that, and that triggered a "system status" check
> 

Thanks for checking this out.  I does indeed seem that this check is
triggered by the 'systemctl status' command (or which I was previously
unaware).  It isn't, however, triggered by 'systemctl status $UNIT';
that check looks like:

Oct 07 13:20:45 c7.penurio.us systemd[1]: SELinux access check 
scon=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
tcon=unconfined_u:object_r:radvd_dynamic_unit_file_t:s0 tclass=service 
perm=status path=/etc/systemd/system/radvd.service cmdline=systemctl 
status radvd.service: 0

I.e. the target context type is that of the unit file.

Looks like this is going to be a dontaudit, since my service has no
business looking at the overall system state.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
