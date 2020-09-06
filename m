Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1888EC43461
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E12078E
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 18:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEWel3ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIFSLK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgIFSLJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Sep 2020 14:11:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40675C061573
        for <selinux@vger.kernel.org>; Sun,  6 Sep 2020 11:11:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a22so7105986ljp.13
        for <selinux@vger.kernel.org>; Sun, 06 Sep 2020 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9PmFnaxKkNfJ8v58KUJigRrf9AvYoPRj3vICVlWjTf4=;
        b=mEWel3ZAw9sM33oWUnYAJ2ZanJQaqfsjiKbctA2VLRT9QNXa5PFTJa2yfiqsZT/jsh
         9Z2Y8r5PVyTq5HS4lm1vhsHYS19SiHBKB04/Ozm4pXmpp9oRb7sqg5sSFDm84auud4nq
         56stVCEDWUm/LEvEI2INu9PQlIkaQRYXtV64F23BaYDjPOgyCT/zHz/nbHJ0F9IsKV9e
         UUOo8rC/503xSnscSXIboO8XAG/gTq3LRse6oX389GBCTxyKHEKkPjSOFI7cDeSCdquR
         ZoAuHvea1TAVBWfYtMHD7lPtrasxqJJLWvgdqbjpQJmI8RSI+CTlXTzLHYH+XhbpYMk4
         jaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PmFnaxKkNfJ8v58KUJigRrf9AvYoPRj3vICVlWjTf4=;
        b=dqBzAmKDGZ7KBej974S82tIzl6YpHuTuIUpa0r0mdrjFXFlbIo9ytMPRS/BatkB//v
         UWcTyOcyd8ELQwDXHIkQMar1i/qAnJ1abifc1nRI6biXz5cHylTedBVR6wxLkM4KHamR
         jy4jH/Gzxkcl4/po2kAdDtzkshtJ/ok0RJIpHBXBWoULD1uffvFUYVc26NtDNd63lz5E
         TIscSGN2l0AO3X1EvJdHoXiKscHyvBmMGeVL0hws9YVhZGB9dFY0CGdJDyIok4pFxRqJ
         EgBXSOjP9+PBsJKtfMutrRLsi9zWQdqVSHBP9iu6kZppsr6FcemK/KECBaihg8JP7x3O
         SrlQ==
X-Gm-Message-State: AOAM5327qGfsSLjzh3P84oE36+9PO9jJrzEUgxt658miCGBL5s7KkD1K
        xAVHEqzoqMttHukL6pEY/egE7aF+/KY=
X-Google-Smtp-Source: ABdhPJz/Q4erlEkwLTZJy3O19Pzedj69MyiBE9wRwD6Kd5aO5PZtbqMj8GS5f2ginokk3+7ZoSwMKA==
X-Received: by 2002:a2e:390f:: with SMTP id g15mr7843140lja.280.1599415866389;
        Sun, 06 Sep 2020 11:11:06 -0700 (PDT)
Received: from [192.168.1.170] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id n62sm5106020lfa.82.2020.09.06.11.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 11:11:05 -0700 (PDT)
Subject: Re: [PATCH] network_support: Update LibreSwan configuration
To:     Richard Haines <richard_c_haines@btinternet.com>,
        paul@paul-moore.com, selinux@vger.kernel.org
References: <20200906152721.16448-1-richard_c_haines@btinternet.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <030e2ae3-0f2e-3fed-a02a-142c3eec681b@gmail.com>
Date:   Sun, 6 Sep 2020 21:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906152721.16448-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6.9.2020 18.27, Richard Haines wrote:
> Update ipsec.conf file that describes the labeled ipsec entries.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> This was used to test the updated LibreSwan that now supports
> selinux_check_access(3) from https://github.com/libreswan/libreswan
> 
>   src/network_support.md | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/src/network_support.md b/src/network_support.md
> index 36af1f4..4a3fd38 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -452,11 +452,45 @@ Context type identifier has never been defined in any standard. Pluto is
>   configurable and defaults to '*32001*', this is the IPSEC Security
>   Association Attribute identifier reserved for private use. Racoon is
>   hard coded to a value of '*10*', therefore the pluto ***ipsec.conf**(5)*
> -file must be configured as follows:
> +configuration file *secctx-attr-type* entry must be set as shown in the
> +following example:
>   
>   ```
>   config setup
> -        secctx-attr-type=10
> +	protostack=netkey
> +	plutodebug=all
> +	logfile=/var/log/pluto/pluto.log
> +	logappend=no
> +	# A "secctx-attr-type" MUST be present:
> +	secctx-attr-type=10
> +	# Labeled IPSEC only supports the following values:
> +	#   10 = ECN_TUNNEL - Used by racoon(8)
> +	#   32001 = Default - Reserved for private use (see RFC 2407)
> +	# These are the "IPSEC Security Association Attributes"
> +
> +conn selinux_labeled_ipsec_test
> +	# ikev2 MUST be "no" as labeled ipsec is not yet supported by IKEV2
> +	# There is a draft IKEV2 labeled ipsec document (July '20) at:
> +	#   https://tools.ietf.org/html/draft-ietf-ipsecme-labeled-ipsec-03
> +	ikev2=no
> +	auto=start
> +	rekey=no
> +	authby=secret # set in '/etc/ipsec.secrets'
> +	type=transport
> +	left=192.168.1.198
> +	right=192.168.1.148
> +	ike=3des-sha1

Since this configuration may set an example for less experienced users 
who may just copy this without much understanding, would it be possible 
to use a more modern crypto algorithm? Also libreswan documentation 
tells that sha1 will be obsoleted in near future. Would something like 
"ike=aes_gcm256-sha2" work? I don't have a working libreswan setup.

https://libreswan.org/man/ipsec.conf.5.html

> +	phase2=esp
> +	phase2alg=3des-sha1

How about "phase2alg=aes_gcm256"?

-Topi
