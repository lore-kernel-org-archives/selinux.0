Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FD1C00319
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E95821872
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550523744;
	bh=VNmClyfzxuXRVuqk2NWqj2E+R20XXrYbCsV9fVGVtPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=st5CGq0XgBsoGnAfZ2PxzWjkBiAWG/fGzHEJaWSE9UglKERpSqEF6oFBlbSV5B1je
	 FK/KpcnRLYqxm79oUpsqhQJdgiXo5U6HPR0fAMzCZAQ7Sxj6qv8kbrAmxggrGJxDQT
	 BMECI9S67XpOslkmZkXHpXi5IYQiPhe7HojPYtDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfBRVCW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:02:22 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38461 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfBRVCW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Feb 2019 16:02:22 -0500
Received: by mail-yb1-f193.google.com with SMTP id f196so2430781yba.5;
        Mon, 18 Feb 2019 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mT6WOBgUOWpg3a/IZnk91lzR1wfES7mgilIFWYqcftE=;
        b=Pn0c3YFhpdnAnixNJG0zf8JL95VtoAKHXssMwmUmo2+w9R+jQWYqrmcxLsfyuIbbsl
         d+/ldMSN45dEAXJaWC9uDW/41nZZXoXecyBhB5sGAu7+jmwWLfp1nD2S6kJ+etsmYvFO
         OdCbZD6PmqwLj42e/zFlum/g9C7yia16CZvAeAaHrCMOsAS4PKt7qIYkCf46i+6ziqIJ
         TZmxwpf9LOX2SL2CaekflUqMBTRHibq7KlSmzFDLhrb59QF5NJ4fZcbEfvAtlkwfR8dk
         7GwBoCeheQz1RlmGfOEMs3NgucGSmlquYlusoGge6FF3DU+iIqwIEtSkRNwvnJLTK52j
         Bufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mT6WOBgUOWpg3a/IZnk91lzR1wfES7mgilIFWYqcftE=;
        b=qGEfq8P8vYyPYqRs7uKTue34gt7POc8vWuYN+SpWiFov6BobHh75dnWepns8FRzJkU
         RpvoVHV/YYzu+HWiAJNbbeJ5EOzzb0Hn/rFCowz190umCnIU5B6M7KyqGLNS70GQ7aC3
         JJc9Cv9uibN9Aw706VnhDuKGwgKtr9vjRQHgDJRwEZbNdkCY8GsE4Her5LjS9WdVTowG
         f9xw7y8+p+oV+ZW25eg1FXKE6g5FsYO6z9fvGz8tWRGjpKjKwwE+53fXsrdZIvOSSAfd
         oyLgIhRWWVQ8+sJiGkRO9K6ip1IecRLjxjoN8aOpTmUCbclu73j3Dn8qYhs/vHlTU4+n
         zarA==
X-Gm-Message-State: AHQUAua7udHgdOM+mJttUoOUuzmC9AVz5AwxVkkRMiqDI+W1miTDOAVV
        SfMotz2xXRj1K16U9teENFM=
X-Google-Smtp-Source: AHgI3IbauSa8BsXGLvbMsLV/ibWET/S/Xk3yQP/wZTqf1PJHaHpcgB45vHlIQbugHY0/JC2vlDFN1g==
X-Received: by 2002:a25:6908:: with SMTP id e8mr21350697ybc.324.1550523741341;
        Mon, 18 Feb 2019 13:02:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id s126sm5387720ywc.11.2019.02.18.13.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 13:02:19 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:02:15 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190218210215.GS50184@devbig004.ftw2.facebook.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
 <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com>
 <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Mon, Feb 18, 2019 at 11:03:58AM +0100, Ondrej Mosnacek wrote:
> I don't think there is a way currently to check whether some LSM has
> been enabled at boot or not. I suppose we could add such function for
> this kind of heuristics, but I'm not sure how it would interplay with
> the plans to allow multiple LSM to be enabled simultaneously...
> Perhaps it would be better/easier to just add a
> security_kernfs_needs_init() function, which would simply check if the
> list of registered kernfs_init_security hooks is empty.
> 
> I propose something like the patch below (the whitespace is mangled -
> intended just for visual review). I plan to fold it into the next
> respin if there are no objections to this approach.

Sounds good to me.

Thanks.

-- 
tejun
