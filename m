Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B4C28CC6
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4571626D01
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="stUhYzO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFCV5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:57:17 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:33509 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfFCV5P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 17:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559599033; bh=MqYBVS0X2GKN7bu5a6b7FcKrqVEbRQaK7PCjon7JIvY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=stUhYzO2ywz86JSYnKxaRaxrzNQfWI38oT10/Pq0Hy4Q/4jW5Kg9LNYq8+Ll9cghS5vbHmQlrjU7Qip/CLlMakbj8ae7BBXFxbmxKE9o+nu5QXG+l/lBwvO+ztLAUzWJi767gbtwHdHXGqbuv9w9NPPU1HbLp3O9YvBF6m45axppRg+HyaNj/xgcH8kvVMBkRryFzYpOp788rDazPd8ZsOhy5MYhGAy4zMZVFMtNNFs5ZTKyulybRbSA8UapOFghkknhtY/Xw0lSN4gwfUx/HxXYDAEu+6euUzrRKvT/uaBgh+4ymbPTEh8WO7xe21IxH9JuXoZexw+Ol3QiF00YMw==
X-YMail-OSG: 0TEXN78VM1nnUftZhPli84ZBCo1vsOKsSAsggFjC2k47SOskSOxpp29vlcLSIjw
 W4ZKf6R0BAPvdH5oVAYttbicqSWSkA7Yhp4EjA.tlE0DsXpof.r5Ezk1z3kQf4mwJBIMoHg6FsHE
 L8NiESaps9iu9.zJ7lAdrSbrzxCWDTgFpRz52K.KA2OxMu6dm0Re6EwWj2mYVmDRkd8_z_KRBtcF
 32C_52dGTPczrJbzGnupySlyQBLmWnabuy5tX0zregwvOq8sVPeO8yNPoo53g4mNTnUNeTutlm1X
 aymLSoZOTRiDt3ERVKHexnUZ8aqQvRmctNPAclZvHfxV7dSFJjeSD5JXg39op8FKq9t44_A4JDUa
 nY3TFCmQJVkBnP.Hv1zJWfmJF4ufLldh1Pa.BH1pKvdpKzvIzI7.HgoqxSjUTEDghYtLQafDEnhy
 S_KXekPoDMfkHg5OkKVqviqwBAicNwWd_z5V8OT5T_E9tc1K1aMrC1SKPus6iGp5LwIONkyrp5Oz
 AXJBcv.xCVuC17tKiGT6ylnujaYB5aYWa9hUnDfKg3XX8JwfXlUtj70kLq9zIQvOrYyoXRr1WsT5
 MGdViNTojtGtLkc1pK0M.4N7jwrcixBtHIjjDFpeW7jV2QnkO.2TXhKy5bCpPNCfno9MUYyNziyl
 CgUR4dMmQKAYxS7iAs24y6sACZZ8x.9twFuVBkEsBOwlYWe0fqJsfZvjVzjvxLM9NYpOUqqYRukg
 ZsuMMPx9adT_1Gw9yub_fIo7MigplqarHim6rrKvNGLY9bTEbIJ2VYLMhbyOOGBfbWkE979eqxvU
 AziE9h1bXzFddgtMgtRNM2YaaRTKo_NH82LVrUfRYtD3hITaGefGtlO.oHsR9m0vSMgNx41JLzVw
 mCTA2ZVJM8TzvLe9so_Nqkw1wnv5FfaiA8eP3lNsrKAF4O8v1nU6l6UWvKBV16bw.kf27JJcso1_
 MkTce0Bj.d1Ij6SWNk4yqOa9Z5dzNRcal.U.MOdHBGUiOZlOlmqjpAZ1b8E07IAPGEeXL2WOUjpY
 0W07AYGLcmry5HCtHgz3VKgUKIjM.okcw.GeCK5cipJCezX8ZkasVa2st763rjmcQNQ1ylHDxANJ
 2nhySWCC9kXcA4RG82OqeJb7vQ1TqKrS94dMOC7tLZHjQCyz3ndtkfHQFs_Tf.fz93skgK90xFVI
 yFednVFW37epo57JL1YfMRuoFD7dvZuBtoSCSYJHDtAKxBgQ8nFA5Uz_ZlwcLfXxNpz7CqyY.2Z3
 moIFZesKbJbOabGia
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Jun 2019 21:57:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f3ad74a48ed0e943b0ad35d50423f031;
          Mon, 03 Jun 2019 21:57:12 +0000 (UTC)
Subject: Re: [PATCH 46/58] LSM: Use lsm_context in release_secctx hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-47-casey@schaufler-ca.com>
 <201906011920.C5CC2777@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ddf30b32-d05b-c1cc-f49f-dd5679879bb4@schaufler-ca.com>
Date:   Mon, 3 Jun 2019 14:57:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906011920.C5CC2777@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/1/2019 7:27 PM, Kees Cook wrote:
> On Fri, May 31, 2019 at 04:10:08PM -0700, Casey Schaufler wrote:
>> -void apparmor_release_secctx(char *secdata, u32 seclen)
>> +void apparmor_release_secctx(struct lsm_context *cp)
>>  {
>> -	kfree(secdata);
>> +	kfree(cp->context);
>>  }
> Maybe better to have common helper?
>
> void lsm_context_clear(struct lsm_context *cp)
> {
>     kfree(cp->context);
>     cp->context = NULL;
>     cp->len = 0;
> }

The caller, security_release_secctx(), does a
lsm_context_init after the module specific code.
The helper wouldn't be generic, since Smack does
not do a kfree() on cp->context.

