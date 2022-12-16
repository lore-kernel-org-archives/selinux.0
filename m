Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3441C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLPITT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLPITF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 03:19:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21F30567
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 00:19:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C6C62035
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 08:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D014BC433EF;
        Fri, 16 Dec 2022 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671178740;
        bh=3FgjfxzR5Z0zLKRyh1AT4YW+UGzT/n2geRCkWtQVWNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhPydDScBtpdi9IV4WZ0BeWyvQ6vrk5DT22KZAbwDq8Xk7RgwxmYLmERRxjYo0Or0
         9W+1JrBk4hSDpJUeccu0LhZ9P6DWfHb1nqrcJZuTe32s4HMSVTxizrBE4OlZBEToB0
         Oz8+AwcOP8AkJ9zcB+7VfSbKMSCj+cR9LeG+MH3E=
Date:   Fri, 16 Dec 2022 09:18:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?7J207LC97ZeM?= <darklight2357@icloud.com>
Cc:     security@kernel.org, selinux@vger.kernel.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Subject: Re: memory leak in inet_create
Message-ID: <Y5wp8UzuxEecE1xh@kroah.com>
References: <8d7c2742-a724-43c9-b8ad-4a0b98a5b8a6@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d7c2742-a724-43c9-b8ad-4a0b98a5b8a6@me.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 08:03:44AM -0000, 이창헌 wrote:
> Attachments available until January 15, 2023.

<snip>

Please do not send HTML email that we can not parse properly.

Also, for normal syzbot found issues, that are only triggered by root
running programs (and not a normal user), report them to the developers
and mailing list for the relevant subsystem like all other syzbot bugs
are reported (we have hundreds of them.)

If the issue can be triggerd by a normal user, and you have a reproducer
or a patch for the issue, we are interested in having that sent to us,
in a format that we can read :)

thanks,

greg k-h
