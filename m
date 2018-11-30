Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4F0C64EB4
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 00:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2CA20868
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 00:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TrBpvCcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2CA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeK3MEx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:04:53 -0500
Received: from sonic308-18.consmr.mail.ne1.yahoo.com ([66.163.187.41]:46195
        "EHLO sonic308-18.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeK3MEx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543539445; bh=J4nLeP95WbfL0BkTFk9z/3qeuEz3I6HjDn4j+/BheUU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TrBpvCcBF0hTexebC8KH1EkfEk4bKSvevtkvz8JLTtG+pWIGkTMGJfBN909A+yV/tc0pZGHEnAsQvkQz2HxhEKhoqa0d0xEqo2lhoMKYZvIsezJ3uX0A3xIj5Z1u47v0sQBGfrqdwn4NNWBIJzqQ/NbihnJZR76NdtiF4wsaSRiQMh9ttkwAHa5asWv06vML4bDPz8yMCkLWAyG269o4POvv57If6OvHiJoMhb1XOelOoWJjv2h0XNL/iluVOW1QUf3hfVSEWF1iIDhUhj9m0hCywhqIN5NAHKbiu/sJFeoHCItWGwzAFH25QYCl6vHb/jpCfjXHuZwBFGadXK8Tsg==
X-YMail-OSG: owO.R9UVM1lcYXeKJccy0lRaug4m5xb.SHeVvP63ufn1eD8Pl7vxy5TiU5NKXwi
 SXi1d.WUU5wR7WpH5yudlTLv3quiQ6yvgSeME3Ecb_EIk9.T2dMs5RYiSGLEeb0U9wbFTZCB9mQW
 V0bK4XDbRxFTE_XEHWEKgc4cE6UFMg8TYQj7bL5H8Z14zC0kYsGPGEkg1qz5mAU9HhasuD6VL7Os
 q6e8t7jug29L89O1iA.BYx5wJ7zRNYU6huNu289LXCIeXink13ohUuDidZmTEI0xMaBK8nKJY6CH
 qLIuR2T6rCOTONsAqGYE59iYPiD4KkbeP9mwEoqjTO4shzDuAF_8o4iuna.XR.Yvr7WSIktJTwqv
 JcWenaixAlWOL.sW83y5I5Hv7IsNxHNVLAmK0YJXfKpCDXYact00DsvbXy6s0s37hmC4x4nB2tXe
 zQl38sKFuwiA7aNJagWFbUU.JW1EKNR2.3dUvs65dShGermRq0WPRHacvsDakgRRdAnSOEIOtnWC
 8CEzvGhboiqHDcLucnFs8gQRzPVF8RwV4c9PvScPs6uEladQ7NMxIV5GRsYSIE1qtGB_6wCM8VVH
 cRvsNSKY5NlKDh5j5va1n00mPwl8t3NjkTnW94K340yssRp3fbZFdFptczkXLlmD8cNmmv9aFEIt
 4sbqBHZGpyHu6j1hgPYVd1HwfkSwtQ3tYKhL7jlgg.i5EXC3x6avOO5txZ75gO7GAxjZV3KFhvhs
 7HAqHJA9NcP3tRe0gP__8D3Cfrw1d8KmmyPebOkJGs7p5JmUrTEIqr_9nGRTE7QMsj.OTP2DJh0X
 fN8eZ9hQr9Fs02X0yTRrUuwmaG12rDqpNNLE0lZR_UKVwZeiVv0uhbJLbJFvQmYqqubMRGztXKrJ
 fq.DYpm_lP3vTT0YOcC.jWliXhNV4mjCVKk7nWdN7zbap_VrSRnkLQtIBAQB47o9Uvlq8kSsaHa3
 tDKFSalLhuDn4FfO9lgE3V4U9Ci3p75vs1AoacrY7f5qYevx_xXQDdtYYJl0ubWSaBBC6R_DapPr
 wxBDzUm6.bloc_mn2fqKXNHXXjeheYMn3J.EVHXVDQH8oYvON5dw3Z79WntH3S8y7aFrD77aobvS
 htmL.uAlgZz.g
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Nov 2018 00:57:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 971edec8246d7cdd23c63d2138fa27d5;
          Fri, 30 Nov 2018 00:57:24 +0000 (UTC)
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>
Cc:     omosnace@redhat.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAHC9VhRthWKfgYenGq6Az+jVQ+76wCeBhBcMyo9zZwv+nBhy3A@mail.gmail.com>
 <20181129235130.GI2217@ZenIV.linux.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <84796ec6-2603-7957-b159-e4c8b1e7362c@schaufler-ca.com>
Date:   Thu, 29 Nov 2018 16:57:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129235130.GI2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/2018 3:51 PM, Al Viro wrote:

I've added linux-security-module to the CC list.

> On Thu, Nov 29, 2018 at 05:23:24PM -0500, Paul Moore wrote:
>
>>> OK, I will verify that the SELinux submount fix rebased on top of
>>> vfs/work.mount in the way I suggested above passes the same testing
>>> (seliinux-testsuite + NFS crossmnt reproducer). I am now building two
>>> kernels (vfs/work.mount with and without the fix) to test. Let me know
>>> if there is anything more to do.
>> Thanks.
>>
>> The big thing is just making sure that we don't regress on the fix in
>> selinux/next if/when David's mount rework hits Linus' tree.
> FWIW, the whole thing is getting massaged/reordered/etc. and I would
> like some input from you guys at some point - assuming that I recover
> the ability to talk about LSM without obscenities...
>
> Question: what *should* happen if we try to cross into a submount and find
> that the thing on the other side is already mounted elsewhere, with incompatible
> LSM options?  Ditto for referrals, with an extra twist - what if we are given
> 3 alternatives, the first two already mounted elsewhere with incompatible
> options, the third one not mounted anywhere yet?

I fear that the safe answer and the containers answer are likely
to differ. The safe answer has to be to refuse the mount.

> Incidentally, should smack have ->sb_clone_mnt_opts()?

Probably, but I could never figure out what it was for,
and haven't identified a problem with not using it.

