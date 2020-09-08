Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEAFC433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27B42068D
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 06:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWUp7C2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgIHG64 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgIHG6u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 02:58:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96429C061573
        for <selinux@vger.kernel.org>; Mon,  7 Sep 2020 23:58:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so8573901lfp.9
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2020 23:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3sJIwUloJ+hjSNvUI+okmTqJlOd7jHUJOXaopaJMOIM=;
        b=jWUp7C2FeYCRKzllwgJrhVn8MtBfkUPzWS4vi7Wc2g7hjml13/nVSEpb0IYulKKmj6
         L5ObH39UFGJyrWcil1zsqL2apa87nymfmwRPgD7IlZLNji++Ipw396w+4TMR7G8kLcDk
         JUOfNU2nUQziR/StFO/Ko25qmIKF1Yc5GsjZRGSfZ+YTw6PDEx7kEAsKv8eLNxdlhAhw
         F1eZr76huosuG00A8HCCt+Uz2DAPMNQceZgXKwM30qha+VMHJUV3cplHoYQbiESvqaGO
         ZsWBevYQUSNqFeApWczX8sPuo2GTk0RInuwUd1Ip/xh58oa+ARqEbk/VILvwpaG2uEE8
         QdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sJIwUloJ+hjSNvUI+okmTqJlOd7jHUJOXaopaJMOIM=;
        b=XklHHFwu92mJ/NzOkrAA54/MMCA9LNEBRe/cbELRE0vGApUhXPbJ6SOhRTCZBpIHfB
         wy791un7rwCVrrxHtrVkvYMC4rLSYIM+uSYEWBHwlkCtAanf95q8RiPodd1kryH3xGWj
         VBd8mEbOuIJo+KLO2GsWTeQI+vFjCjiS/7GZqibqF2ZmA9mJBMbmr7s1xdiAnS4t41ZL
         H21asIqbrU4AYOMKNT+GutcLL8dtDJhjQKbP5gjsvzjKz0wIwyyWYxbU2/IrNI3qg93n
         fnF9e8zgs8gc8jD80rh3jHQhlfEfgFqLgnOv9NCC4Ov5uGWZ/qAwDX2CKhvYxqk8rVue
         I+Hg==
X-Gm-Message-State: AOAM531JypXZfPTEnatEwvJ63QhOZJibx2ArMfW0meX//sapEHSCWBHo
        fQmJXA+FdTWaVYXliLk+9rr6Un7CArw=
X-Google-Smtp-Source: ABdhPJzKzI5DwPrXzOx5XYTNyFtids5iepbxvduyC6ulo9CTxXxOQazryuIGwPXuBhU2c1aEP1UxdA==
X-Received: by 2002:a05:6512:5cd:: with SMTP id o13mr11432739lfo.171.1599548326622;
        Mon, 07 Sep 2020 23:58:46 -0700 (PDT)
Received: from [192.168.1.176] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id g15sm8930008ljj.39.2020.09.07.23.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 23:58:46 -0700 (PDT)
Subject: Re: [PATCH] network_support: Update LibreSwan configuration
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org
References: <20200906152721.16448-1-richard_c_haines@btinternet.com>
 <030e2ae3-0f2e-3fed-a02a-142c3eec681b@gmail.com>
 <ecbced32f4cf284f7a8d7f71369c1330bff6465a.camel@btinternet.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <0a6b47ac-b68b-ba7e-9202-a711a559e30f@gmail.com>
Date:   Tue, 8 Sep 2020 09:58:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ecbced32f4cf284f7a8d7f71369c1330bff6465a.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7.9.2020 18.20, Richard Haines wrote:
> On Sun, 2020-09-06 at 21:11 +0300, Topi Miettinen wrote:
>> On 6.9.2020 18.27, Richard Haines wrote:
>>> Update ipsec.conf file that describes the labeled ipsec entries.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> ---
>>> This was used to test the updated LibreSwan that now supports
>>> selinux_check_access(3) from https://github.com/libreswan/libreswan
>>>
>>>    src/network_support.md | 38 ++++++++++++++++++++++++++++++++++++-
>>> -
>>>    1 file changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/src/network_support.md b/src/network_support.md
>>> index 36af1f4..4a3fd38 100644
>>> --- a/src/network_support.md
>>> +++ b/src/network_support.md
>>> @@ -452,11 +452,45 @@ Context type identifier has never been
>>> defined in any standard. Pluto is
>>>    configurable and defaults to '*32001*', this is the IPSEC
>>> Security
>>>    Association Attribute identifier reserved for private use. Racoon
>>> is
>>>    hard coded to a value of '*10*', therefore the pluto
>>> ***ipsec.conf**(5)*
>>> -file must be configured as follows:
>>> +configuration file *secctx-attr-type* entry must be set as shown
>>> in the
>>> +following example:
>>>    
>>>    ```
>>>    config setup
>>> -        secctx-attr-type=10
>>> +	protostack=netkey
>>> +	plutodebug=all
>>> +	logfile=/var/log/pluto/pluto.log
>>> +	logappend=no
>>> +	# A "secctx-attr-type" MUST be present:
>>> +	secctx-attr-type=10
>>> +	# Labeled IPSEC only supports the following values:
>>> +	#   10 = ECN_TUNNEL - Used by racoon(8)
>>> +	#   32001 = Default - Reserved for private use (see RFC 2407)
>>> +	# These are the "IPSEC Security Association Attributes"
>>> +
>>> +conn selinux_labeled_ipsec_test
>>> +	# ikev2 MUST be "no" as labeled ipsec is not yet supported by
>>> IKEV2
>>> +	# There is a draft IKEV2 labeled ipsec document (July '20) at:
>>> +	#
>>> https://tools.ietf.org/html/draft-ietf-ipsecme-labeled-ipsec-03
>>> +	ikev2=no
>>> +	auto=start
>>> +	rekey=no
>>> +	authby=secret # set in '/etc/ipsec.secrets'
>>> +	type=transport
>>> +	left=192.168.1.198
>>> +	right=192.168.1.148
>>> +	ike=3des-sha1
>>
>> Since this configuration may set an example for less experienced
>> users
>> who may just copy this without much understanding, would it be
>> possible
>> to use a more modern crypto algorithm? Also libreswan documentation
>> tells that sha1 will be obsoleted in near future. Would something
>> like
>> "ike=aes_gcm256-sha2" work? I don't have a working libreswan setup.
>>
>> https://libreswan.org/man/ipsec.conf.5.html
>>
>>> +	phase2=esp
>>> +	phase2alg=3des-sha1
>>
>> How about "phase2alg=aes_gcm256"?
> 
> Thanks for the feedback. It appears that racoon does not support aes
> gcm types so I've changed them to aes256 and added some comments. This
> config does work LibreSwan - Racoon. Is this ok ???

Looks good to me with the caveat that I don't know much about Libreswan, 
Racoon and I'm not a crypto expert.

> 
> ...
> 	ike=aes256-sha2		# See NOTE
> 	phase2=esp
> 	phase2alg=aes256	# See NOTE
> ...
> 
> # NOTE:
> #   The encryption algorithms should be chosen with care and within the
> #   constraints of those available for interoperability.
> #   Racoon is no longer actively supported and has a limited choice of
> #   algorithms compared to LibreSwan.

This is also a great note.

-Topi
