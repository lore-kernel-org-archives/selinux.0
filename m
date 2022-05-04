Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B84C433FE
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 08:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbiEDIOu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 04:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346088AbiEDIOt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 04:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D01A1EAC2
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651651873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yN9+KUzFzJ6nmjszcmP73KwPTVKEirUAJ+KvK3T3Gg=;
        b=A+m5TLki/iNV1Qdw/O6GNNM7zHsc2SsFJr6ySSkcO/1OYXztfhjwlvuIpAu3naguQSGIve
        QCnDtcJqKNA9yKh2GLkcPyBdwXvCjW21e29+9roSmKucQT6vnw2oya4Sqo6EM7yIn1cOCk
        gjAhNZb6pPXRPVvxFhbnRZAo9ih/wvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-Xik4J0nRPMy_1b31vKXKSw-1; Wed, 04 May 2022 04:11:12 -0400
X-MC-Unique: Xik4J0nRPMy_1b31vKXKSw-1
Received: by mail-wm1-f69.google.com with SMTP id o24-20020a05600c379800b003943412e81dso329875wmr.6
        for <selinux@vger.kernel.org>; Wed, 04 May 2022 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=5yN9+KUzFzJ6nmjszcmP73KwPTVKEirUAJ+KvK3T3Gg=;
        b=SAaiv5z8DFF7jOLHzKWfxyWcxnuCf5xjfJGeIgxwBHHNRjqkFYUoqyqXUSXcsiv8bN
         LxixnvJvJcUz4YPffI16SQ2nL36AkFfM/69kl5ICEL2e8oiDWZk1zKS14TGR7Fnhk1JV
         /kqenlSHL/Sngf6E5G+DVRpUZgjYXbYsxt1ZqGZ68SM2k4ZNFrggEnjLXHtWbNUtw76k
         oOY40uPSAXCN6LlZgJxeCMRmaA//g0VYabWketRnsJoZrHSR4xOGcicJsLT8pUghFStO
         XC7lHnCXoCt1eL3bGDXSOTXmqTpkHySRMs5KFIbsFwyWbOQwpZC8+3Fs+m0uGoGozuzf
         7Avw==
X-Gm-Message-State: AOAM531QSGwcIZggqUWZUfgBMN6of8/vwEd5YUynjew51qS7rzsCx1ex
        +Z+fwB1uZDkY4gmLtbrtrKNw70eFmUvz6Ah9QR7aGzT8Qw7cet0ADY0lKky/NZ+dtYM+xnUk872
        MK+MFxA/dl80ECvm/G+7xBekZzE3i0njL9rhEJZerHwjVfppQcNYH/bIOuI3kMP8DDrn8
X-Received: by 2002:a05:600c:4f48:b0:394:44a9:b016 with SMTP id m8-20020a05600c4f4800b0039444a9b016mr6612227wmq.114.1651651870822;
        Wed, 04 May 2022 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNEDE3hizqagOW8BAG4Dbmk7ilyLkJ261GVn64w0/f6i6ryMcfNDf6q07dX2RertjfoSQsHg==
X-Received: by 2002:a05:600c:4f48:b0:394:44a9:b016 with SMTP id m8-20020a05600c4f4800b0039444a9b016mr6612206wmq.114.1651651870541;
        Wed, 04 May 2022 01:11:10 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b003942a244edasm3236588wmq.31.2022.05.04.01.11.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:11:10 -0700 (PDT)
Message-ID: <0704e031-4538-fe3a-9165-dfe49d1d9718@redhat.com>
Date:   Wed, 4 May 2022 10:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] gui: Make sure sepolicy calls are translated properly
Content-Language: en-US
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
References: <20220503114244.39441-1-vmojzis@redhat.com>
In-Reply-To: <20220503114244.39441-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,
please disregard this patch. I am working on an improved solution for 
the issue based on module namespaces.

Sorry for the noise.

On 5/3/22 13:42, Vit Mojzis wrote:
> The policy is generated using sepolicy.generate, but since its
> translations are in a different translation domain (selinux-python as
> opposed to selinux-gui), the confirmation dialog is not translated.
> 
> - Add selinux-python as a fallback translation domain
> - Set the whole "generate()" confirmation as translatable
> - Drop "codeset" parameter since it is deprecated
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>   gui/polgengui.py                     | 7 +++++--
>   python/sepolicy/sepolicy/generate.py | 2 +-
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index 01f541ba..dcd5df47 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -69,10 +69,13 @@ try:
>       kwargs = {}
>       if sys.version_info < (3,):
>           kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                       **kwargs)
> +    t.install()
> +    t.add_fallback(gettext.translation("selinux-python",
> +                    localedir="/usr/share/locale",
> +                    **kwargs))
>   except:
>       try:
>           import builtins
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 43180ca6..42d52109 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1372,7 +1372,7 @@ Warning %s does not exist
>           fd.close()
>   
>       def generate(self, out_dir=os.getcwd()):
> -        out = "Created the following files:\n"
> +        out = _("Created the following files:\n")
>           out += "%s # %s\n" % (self.write_te(out_dir), _("Type Enforcement file"))
>           out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
>           out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))

