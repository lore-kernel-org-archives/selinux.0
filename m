Return-Path: <SRS0=unIV=AO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE43C433DF
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5CC206DF
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 18:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLubwD5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCSQt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCSQs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jul 2020 14:16:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C14C061794
        for <selinux@vger.kernel.org>; Fri,  3 Jul 2020 11:16:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d21so18983446lfb.6
        for <selinux@vger.kernel.org>; Fri, 03 Jul 2020 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBmFvpYiV/78DTR+KasHVFfw2jT48R/9+Hv/fNkks3s=;
        b=cLubwD5xRKs4z2srE7hcTGOwHBys+dFf1MlmtQNqTeWDwrRiti6fOR3eLywIE0M/1v
         6D+AodjOSraxmdJ3+HXXpHzBYr62se7a2l1odqmtlE7sjsFpqstP8rg+P7iBgr+SyfPS
         TqisM0wC8ByMxS2/phO57UFDXkjG7rcToqUxUUiETT9/Aqg9SsP7Q/X054YcStyJjndi
         BnU1PC/r3T6Cv8QxFAfHLTZQaLhxGV3Ulj7GHS7ZiBAK0HZ5XiGHdPdQBpTFJgK2/9Qv
         s5KvF9hKDRZtndJD/zOvQOYUF7erba1hJWElBeGnm6LrzI1UQ6sjbSwThjENbtfOdi2S
         7IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBmFvpYiV/78DTR+KasHVFfw2jT48R/9+Hv/fNkks3s=;
        b=PCIpnEwqRM0EBmTrov5WzeQz2p4qjG14Se5KP2CVICxyv+1NeoEEmAXBxyYbQgVcHp
         pAw3Gnsx4aAdS/Q0eiPygoIl32bkBb1rvViZvIHRcxtleNF0XXOfLm6ukCr+GAhTB3tF
         UjxFL4A+/wV3HP1VwAhA4Cd4CikkgnQHTM+9PBA29SgrXlCbNRZX7tC8TFzwhGdkBNWm
         QLsRFldqOKleyU8c3wSJHCdHRqL1O+qI39f1SHLFVenSZufXPmiqAnD8E7/T8ixrDm0O
         FcXOFY2btu0j+OM/c2XB+1I8MiTCP6zkLGGcCq6BGpAZpi7fUwTiA1Jik9+eh52jePS9
         m+CA==
X-Gm-Message-State: AOAM530m6awIXC1BW6JBZr+apytZGSMmh8/0JNaPh+LTlC/OSjORt4l1
        EloBISb+B9TseEdaNl2GlFBudDBD
X-Google-Smtp-Source: ABdhPJyWx4/inzUDvQnrmRYDABWjftWBudNUwzPYIEVN16VBfJSsxmY9IQRDuwM9AhMLyKPlxxb5xQ==
X-Received: by 2002:a19:d44:: with SMTP id 65mr22822180lfn.36.1593800206655;
        Fri, 03 Jul 2020 11:16:46 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id r70sm4909827lff.97.2020.07.03.11.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 11:16:46 -0700 (PDT)
Subject: Re: Strange AVC denials without effect
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <35be1a17-1b72-fca7-55b2-b3f32b4e13aa@gmail.com>
 <CAHC9VhSjso7KxFjUYPDZWKzo8ukLjSSg4WZ2nkCyOSA8hdBGNA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <550612f8-c1d0-bd1b-d5a1-cae24e7c31c0@gmail.com>
Date:   Fri, 3 Jul 2020 21:16:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSjso7KxFjUYPDZWKzo8ukLjSSg4WZ2nkCyOSA8hdBGNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3.7.2020 16.49, Paul Moore wrote:
> On Fri, Jul 3, 2020 at 6:28 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Hello,
>>
>> I renamed SELinux packet types and also without using type attributes
>> (like packet_type etc), so that refpolicy TE rules for packets should
>> not apply. Then I added new rules for the new types one by one as they
>> were needed. But there are lots of audit entries which would seem to
>> indicate that kernel_t is prevented from sending packets:
>>
>> type=AVC msg=audit(1593770235.180:3222): avc:  denied  { send } for
>> pid=408 comm="irq/30-iwlwifi" saddr=10.0.0.3 daddr=1.1.1.1 netif=wlan0
>> scontext=system_u:system_r:kernel_t:s0
>> tcontext=system_u:object_r:my_dns_client_packet_t:s0 tclass=packet
>> permissive=0
>>
>> In reality, the packets are sent. But kernel_t is not permissive and
>> there should not be any rules which would allow the action, so shouldn't
>> this prevent packet transmission?
> 
> Hmm, that is interesting.  Are you 100% certain that the packets which
> are the source of this AVC denial are the ones being sent over the
> wire(less)?
I don't know. The application sending the packets is very likely 
systemd-resolved. What could be the reason for packets originating from 
kernel_t instead of systemd_resolved_t?

 > Based on the permission, this is coming from the SELinux
> postroute hooks which simply return a DROP to the netfilter code, so
> if the packet is really getting sent it might be a case where the
> kernel is ignoring the netfilter hooks ... and that seems fairly
> unlikely to me.

Perhaps the check is fine but packet is incorrectly considered to be 
sent by the kernel (sk == NULL in security/selinux/hooks.c:5728)? Or 
perhaps it is, since the process is "irq/30-iwlwifi"?

> What kernel are you using?

Debian 5.7.0-1-amd64.

-Topi
