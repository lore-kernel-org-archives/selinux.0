Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B7C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 06:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7DE20679
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 06:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9evPVU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFSGRV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:17:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43801 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSGRV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 02:17:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so9081558pfg.10
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oPRT5pitIyaqpJWQ5QrGCsyZLShQdR3t45xDGgGjmQ=;
        b=J9evPVU2y0FiXdfTVU+l5Eno4oKXzaT8QJjdcPpV8pl0LzS95VccIq2hxsRdWNOF6l
         PwPt+hE9gNct6l7c0TJeN/1MqeBZFXDgkTM98kqJZSrATwXph0+nixyur4JtiMVdE2gz
         J0lykMWgJpaFs74QqQoHSgBw5P8y+IxEIk0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oPRT5pitIyaqpJWQ5QrGCsyZLShQdR3t45xDGgGjmQ=;
        b=mHYi9YrUKAo2CmlRDWVauaRqkGSeETS9uhRiwhQYPQInIw2JJn7nXIlMEhtn+rtfMF
         jXqgFGyb3AHq9QQSLJ008HUD1BZiXEcCQfWSuLjmOhKmMSHK9UfuOf10Rp2+WTa9Ox6V
         JOlOw6kbmDjATG3f5loXvcStfm70Q96D6mFiq+zncVAB/+06ZAZV0a3OLi3BofdLTUjX
         shdWKLbYO38/3cy+lFKQl6JGIJ33QBKBYRIq0wDftPJZf9mjmJVGrIiHaP8JGqWompEQ
         FcNYBfYSWZhf5FxBbZTVuAS9g52YnJIl9OwNF0dZ+opkVo/zX/7FvcBnTQTpbL4JZnpV
         NVUg==
X-Gm-Message-State: APjAAAU03ivPz2m1GU7E07OUk8A8UYKblz+r69Abed2a6GO7OFyNusJk
        8WKKSs8BvFxl4VMeoXMmfpR3hw==
X-Google-Smtp-Source: APXvYqwZ5C29RjH9uVd/m3ixPDRzbfQSb7W8Xz+TrnZaDk/Nr2GOh5RSl6qllovLMNcEuPOsTfcVfQ==
X-Received: by 2002:a62:6344:: with SMTP id x65mr19556573pfb.111.1560925040983;
        Tue, 18 Jun 2019 23:17:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e127sm17854310pfe.98.2019.06.18.23.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 23:17:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:17:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 04/25] LSM: Create and manage the lsmblob data
 structure.
Message-ID: <201906182316.341036E@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-5-casey@schaufler-ca.com>
 <201906182147.0A592CBB62@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906182147.0A592CBB62@keescook>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 09:52:44PM -0700, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:30PM -0700, Casey Schaufler wrote:
> > When more than one security module is exporting data to
> > audit and networking sub-systems a single 32 bit integer
> > is no longer sufficient to represent the data. Add a
> > structure to be used instead.
> > 
> > The lsmblob structure is currently an array of
> > u32 "secids". There is an entry for each of the
> > security modules built into the system that would
> > use secids if active. The system assigns the module
> > a "slot" when it registers hooks. If modules are
> > compiled in but not registered there will be unused
> > slots.
> > 
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/lsm_hooks.h |  1 +
> >  include/linux/security.h  | 62 +++++++++++++++++++++++++++++++++++++++
> >  security/security.c       | 31 ++++++++++++++++++++
> >  3 files changed, 94 insertions(+)
> > 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 3fe39abccc8f..4d1ddf1a2aa6 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -2038,6 +2038,7 @@ struct security_hook_list {
> >  	struct hlist_head		*head;
> >  	union security_list_options	hook;
> >  	char				*lsm;
> > +	int				slot;
> >  } __randomize_layout;
> 
> Hm, this feels redundant (as does the existing "char *lsm") now that we
> have lsm_info. The place for assigned-at-init value is blob_sizes, which
> hangs off of lsm_info (as does the LSM char *)...

Hm, nevermind. lsm_info is __initdata. I will ponder a way to refactor
this in the future. For now, just leave slot in here with char *lsm.

-- 
Kees Cook
