Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3640AC433E1
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B502070A
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589578182;
	bh=x7AeCB/NMW/ZzWDGMR7CXe91vN9bHMzx7bJOc8s7Sjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uJ2xfryHXfzi22QgwmiqHpgOjnjgCe0jvum/PabRzZpQa3J9Paq2/gGqxS3eX0oGW
	 dssGX/a3E4euPdjRtQ2wv/m6M8l3UH9xhe8DTQW+fGoZoLIDCixiKAcmnJQGJF3f9U
	 zvq9IzVn2a686ljbC99IqpaaLr6mLC74P4LFTa0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEOV3h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:29:37 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40350 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgEOV3g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:29:36 -0400
Received: by mail-pj1-f66.google.com with SMTP id fu13so1558325pjb.5;
        Fri, 15 May 2020 14:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYa0xileFKL+iC5XDDg4dnFXtyyvns7Y/zYemD6hOLM=;
        b=gMTNjZ4bDGtefHm3LrL+FxL97FY9KGd1W+xg4axUYkFCjqSTVOzb2V6U5cVGh9LiRO
         oCi98zFFeFQ2Z6kBEtAEgSh6lNtbRaT+fqIDT9Zcpf7v7XQEOQ84U44yPce7y7YBjz+C
         +9dmQXOgFjEjCcr9ZbQpjbaW4rO09VV6eXThGLwkXmfzY4PV1cfRzlj2rNKginBlo2uS
         8D2t7sR37C0cbGSkHjfm90IVEmgwPPEWOkeoYeSEv8VWh5vUI9BcB2c3BzYvs+/ujh+r
         i3jmgUe8oj3QYDFMCNdfgQasY+kOpbdkFN/bKbzIe/69PVYK9MySfHW9yc/wYdSWVGrR
         7PkQ==
X-Gm-Message-State: AOAM530nJwjojty/LqA4N9iS9t5flIvg1nA6LOxR9jDO7L/soZnqwIj1
        UfKxG+rK3D1XKfXuBOZorAg=
X-Google-Smtp-Source: ABdhPJxPAb82N40CtrgVa22e2Jx7aU8YwsQhmb49exg+lY4xmlnjWtUKTOMO5be5VLroJHQEhh4qMQ==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2mr5435815plq.151.1589578175373;
        Fri, 15 May 2020 14:29:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k5sm2225238pjl.32.2020.05.15.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 14:29:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9F48140246; Fri, 15 May 2020 21:29:33 +0000 (UTC)
Date:   Fri, 15 May 2020 21:29:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200515212933.GD11244@42.do-not-panic.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513181736.GA24342@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> Can you also move kernel_read_* out of fs.h?  That header gets pulled
> in just about everywhere and doesn't really need function not related
> to the general fs interface.

Sure, where should I dump these?

  Luis
