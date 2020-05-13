Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D1C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D032204EC
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589386180;
	bh=WdqE4cKf0ccXinlbg1MvpbxgyN4LOmP75On1HjwnySE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eXJhJfS1NEscXjSLT70E/e1gF5zl8eDiw4wfXtTyiG1kye3MPsORXFUJJmrpg9Ft/
	 oYagdNj+gJzmsaV3TMCDQHFada19c1tAg15AWTvMv0VDaZsXcsAPIYdKHUT4LedAB3
	 LDTS+uZZ/I7ML7b9+FKhkwcFTcJu8JA9HbiW9uTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbgEMQJj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 12:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgEMQJj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 13 May 2020 12:09:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB670205CB;
        Wed, 13 May 2020 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589386179;
        bh=WdqE4cKf0ccXinlbg1MvpbxgyN4LOmP75On1HjwnySE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCsO6gbqEaPkje+ceZ0NpYvOXh4pFINJxnLiCkUnjFcYlrkB/1tFYRbX/+8YCbglc
         RvqicPTHZwK14lZl9OdlxuC8F6HA4xisy00wtjjz5GKlPatRkgcBrlpI3oY8eMBOLK
         +2YqkwukULXM8ZIENDPPAlJaQwfu+wMaKaXJQhgI=
Date:   Wed, 13 May 2020 18:09:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        rafael@kernel.org, jeyu@kernel.org, jmorris@namei.org,
        keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] security: add symbol namespace for reading file data
Message-ID: <20200513160936.GC1362525@kroah.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-3-mcgrof@kernel.org>
 <87k11fonbk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k11fonbk.fsf@x220.int.ebiederm.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 10:40:31AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > Certain symbols are not meant to be used by everybody, the security
> > helpers for reading files directly is one such case. Use a symbol
> > namespace for them.
> >
> > This will prevent abuse of use of these symbols in places they were
> > not inteded to be used, and provides an easy way to audit where these
> > types of operations happen as a whole.
> 
> Why not just remove the ability for the firmware loader to be a module?

I agree, it's been a mess of build options to try to keep alive over
time.

> Is there some important use case that requires the firmware loader
> to be a module?

I don't think so anymore.

> We already compile the code in by default.  So it is probably just
> easier to remove the modular support all together.  Which would allow
> the export of the security hooks to be removed as well.

Agreed.

thanks,

greg k-h
