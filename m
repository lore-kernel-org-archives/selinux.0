Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9EEC4332F
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiLVGyK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 01:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiLVGyG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 01:54:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D2724BD0
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:54:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d15so1156459pls.6
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5aLK8AlwZLjFRiA34g5x2IQcgtqjXEH1u29qXl43kM=;
        b=kIj8p/Jg4iKH+jFNOnvlvVL0zqfRwrJoA1ZREnKRfePqGoAtrfmmAffn7sCyjwcqzm
         a5VZXW8Iufc5vqFHi+hp1RbaKhPsOuixaRd6WeK8hPvLfMaz7Kn/G69Vm2k9xCoMC+70
         B8nZxZJZ7EiDlhPs1ObOgkS0HhODVAmbo9unTvYyTC1cvUm8WkBk//APQ0VNJL2VAekI
         +GFWn1g+lF00U10FUnVxZM4X5/8eQPWzc/zcYAuzkZc+0lPVANYyQbTtjB8ieG0S0eYC
         +2JBWFU4LgV5HNNMynOLC/UQAQQL7zimz+9ocBaGiW8DIirjTnRUCfJWFLDD5QHT/fIB
         /1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5aLK8AlwZLjFRiA34g5x2IQcgtqjXEH1u29qXl43kM=;
        b=SyH2ZUEOuViwpdd5L4yuxqB3GBJ/2KH23/InUR9YYLfgjuM3626Jw5IiiO02r4+/GZ
         lJZNMb4r7tn7AZ4M84z6kgwHHVa2uNG2RU5yb7p/wbzTrUD12NQBsAF9H0menaxviasq
         gjD4MJltSMPtHZsq2E5B02mDO5RnWrrYriHeWrMzfOZ/ThFRBKgEPCOWa4GD5mrHVba5
         eaD4WqjCcQeqmb7RqbTn8+doJgNHJiQF+PlElk2eT8EkJFKI5DZBiLsG2y4l4Qy7iZlz
         tQxgjrKMCzgBgY11LH95sNwcR4uu1oSIw9HJTKqL0Rd4ivlvfqHOomzTZNaBu6C/6kUJ
         YR6g==
X-Gm-Message-State: AFqh2kopw6Adp9cJmEwOogRDNsxCPQQI8ZRkTzv7XKrklFrP/3dWtxVG
        I/2R7sOE0Vf7WD7m5mKSwuhgqzKZCwqFjvqqNE0=
X-Google-Smtp-Source: AMrXdXvg+t6DapSMVcXRIarD4AkF0wTQD6Q/GZy4A4TTv//ZwaL9146q+o66W/16LYxOD1nUkVUG2w==
X-Received: by 2002:a17:903:40c1:b0:189:3580:48dd with SMTP id t1-20020a17090340c100b00189358048ddmr5179604pld.37.1671692043514;
        Wed, 21 Dec 2022 22:54:03 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b00190efb4071dsm12567792pli.160.2022.12.21.22.54.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 22:54:02 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:54:02 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] libselinux: Ignore installed when installing python
 bindings to DESTDIR
Message-ID: <Y6P/Cm3zzbQeEqOE@anduin.perfinion.com>
References: <20221222064452.13722-1-jason@perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222064452.13722-1-jason@perfinion.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 21, 2022 at 10:44:51PM -0800, Jason Zaman wrote:
> When the python bindings are installed to a destdir with pip install
> --prefix= --root=, pip tries to uninstall the existing root-owned
> package and fails
> 
> Fixes:
> running build_ext
> python3 -m pip install --prefix=/usr `test -n "/tmp/selinux-release//build-master" && echo --root /tmp/selinux-release//build-master`  .
> Processing /tmp/selinux-release/selinux-master/libselinux/src
>   Preparing metadata (setup.py) ... done
> Building wheels for collected packages: selinux
>   Building wheel for selinux (setup.py) ... done
>   Created wheel for selinux: filename=selinux-3.4-cp310-cp310-linux_x86_64.whl size=725511 sha256=b35e9cdb2a6efce389eeece45446826b4ac6b41f81fdc128893f947036f27e8e
>   Stored in directory: /tmp/pip-ephem-wheel-cache-kemjh99e/wheels/ca/2d/1e/d1ab52426d9add92931471cfa0d2558bcbeed89084af2388c9
> Successfully built selinux
> Installing collected packages: selinux
>   Attempting uninstall: selinux
>     Found existing installation: selinux 3.4
>     Uninstalling selinux-3.4:
> ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied: '__init__.cpython-310.pyc'
> Consider using the `--user` option or check the permissions.
> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 0f6396ab..70ba063a 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,7 +187,7 @@ install: all
>  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
>  
>  install-pywrap: pywrap
> -	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
> +	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py

I ran into this when preparing the 3.5-rc1 release and testing a full
rebuild.
I also forgot to add my signed-off-by. If someone Ack's this, then I
will update with the ack+SoB and push this when I do the release. :)

Wkr,
Jason
