Return-Path: <SRS0=gO7z=PE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54618C43387
	for <selinux@archiver.kernel.org>; Thu, 27 Dec 2018 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C120882
	for <selinux@archiver.kernel.org>; Thu, 27 Dec 2018 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="ptq3nK/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeL0O3P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:29:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33297 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeL0O3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Dec 2018 09:29:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so8851254plo.0
        for <selinux@vger.kernel.org>; Thu, 27 Dec 2018 06:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wv8DQPI8mpd4koXkur2AFa/3VzrAXhBG1RJNRwGpp6Y=;
        b=ptq3nK/gTuVtobTByqxxVD8aKw2jxsBqa06Pr1DIQWdl+mS5T93Zd7rR283HPWoc8I
         RpSMQVgvkVWDn3k9wEcdZpfUHeaKkokQabI37onLI0oz4kDS9Agw8M72Z4pQO2rwan5j
         gy44QgczMd6l2jiGOMcRkkkWJFb21+z44BXz2Zv9DhPKs3MnTK/YpTH/qJDD8F93AAlu
         m7ybri6aVnhAh4hf6xkGxIfP+fVfEUe3iuZQrSsXL7bFOK3YzAeUM0bvcX552vdvTtcL
         1NYu5Vt2iUcJUhKA50WWywIecB2yLqjBIGPXXdakiq7J4/mUDNBBPcACfRcZP3mZzHKe
         L4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wv8DQPI8mpd4koXkur2AFa/3VzrAXhBG1RJNRwGpp6Y=;
        b=GnX5gNbgOGbzbWqePcruEeGrEWB9rr2u0VltEkaNny8Xks+KwKAbKB8IT6RZw4r/Ah
         taQjzfbzve8/x2XDv0unyj6B/jeL7C/TtJLIG/eKUKIDsmXZ1MalFFWL7um69eN1nd+9
         qf/4XWmVkH34ZiwxG8UpV/8jYYD2oY/qqguwCzcoa4SFSCIXdchV4k4aRXpEaI/KE1Rt
         qayApdJIFn+TKAjrL0i9fayXglPdATPcQ2YY2vNqQAVTvLdZK3IDFgqLWdMBDT9tQzUk
         AYqntEMzdylTTJt8MJMzwpZfB2QhqOK5OA4yLngik/CxeOMkuvjWE0Br8hvUFEashQuF
         0+lA==
X-Gm-Message-State: AJcUukf5QCgpZ3xznosRUWUS7iRPK4iKVQm5aswf28gygBcVjMzrbvPv
        kTQDGJA6LBwAqO6xUSEIXeK8ow==
X-Google-Smtp-Source: ALg8bN4a4ZFvpkYV6SVu2AVAHKsYvs94pAf1bfySSt3WrXKXscyYlfZt2e7esil26ac2hICUhoQWLg==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr23741618pld.236.1545920954418;
        Thu, 27 Dec 2018 06:29:14 -0800 (PST)
Received: from localhost ([59.189.206.157])
        by smtp.gmail.com with ESMTPSA id b202sm78105663pfb.88.2018.12.27.06.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 06:29:13 -0800 (PST)
Date:   Thu, 27 Dec 2018 22:29:11 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [V2 PATCH 1/3] Makefile: fix _FORTIFY_SOURCE redefined build
 error
Message-ID: <20181227142911.GA14910@baraddur.perfinion.com>
References: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 26, 2018 at 06:54:26AM -0800, bill.c.roberts@gmail.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> <command-line>:0:0: note: this is the location of the previous definition
> 
> Correct this by undefining it first and redefining it. Also, the previous
> command line option was using -Wp which is passing the value *AS IS* to the
> pre-processor rather than to the compiler driver. The C pre-processor has
> an undocumented interface subject to change per man 1 gcc. Just use the
> -D option to specify this value.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Acked-by: Jason Zaman <jason@perfinion.com>

The whole series looks good to me, go ahead and apply it. I dont think
the other parts have had _FORTIFY_SOURCE so after next release (probably
too soon to apply it now?) we might want to add these same warnings to
everything else not only libselinux.

-- Jason

> ---
>  libselinux/src/Makefile   | 2 +-
>  libselinux/utils/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 977b5c8cfcca..6263d11393e6 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
>  EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
>  	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
>  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
> -	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
> +	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE
>  else
>  EXTRA_CFLAGS = -Wunused-command-line-argument
>  endif
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index d06ffd66893b..890ff36f3bbc 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>            -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
>            -Woverflow -Wpointer-to-int-cast -Wpragmas \
>            -Wno-missing-field-initializers -Wno-sign-compare \
> -          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> +          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE \
>            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls \
> -- 
> 2.7.4
> 
