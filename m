Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8103DC433EF
	for <selinux@archiver.kernel.org>; Mon, 20 Jun 2022 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbiFTWWc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbiFTWWN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jun 2022 18:22:13 -0400
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882391FCD0
        for <selinux@vger.kernel.org>; Mon, 20 Jun 2022 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655763688; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CqxXpqmGuSpoRCZtJHy3geLG+7+9aH8RCLjh3RoaXiQ6j930OmzbHjzBkAIvNG9QsuwSzNdPDe5fW7ipPLVOh68aDHve5gfmeLtki7MFc8ACuH8ARYPxsDm7fxkFpb3W7yARd5tgeG1/NWd7YWIaatHlYW/3SfwICX5tqI/XqNw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655763688; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=a0K27eVUac+96+Fq25FOURy3+ZtdV2iEkSC7VwcYYYc=; 
        b=b7FwrcMqvrp/ZxMkiwJWgc+KrhmpOJ9VwfUnQUya/Lb9N0hvzvTjEj1flBMRWg9xMQBg0oLoVyO0m30UugZG3MASGez07ruo90prGm7Ly7TCS77f4SsMlEscDaFz1w2RxUJEJeixYg0xWhnB4svHNH4naYlkz+BnGn/fo3LqpCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1655763685644758.1226300240223; Mon, 20 Jun 2022 15:21:25 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:21:25 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "Petr Lautrbach" <plautrba@redhat.com>
Cc:     "selinux" <selinux@vger.kernel.org>
Message-ID: <1818334d0f5.f7cac46b398301.621270242316399821@elijahpepe.com>
In-Reply-To: <87letrrz32.fsf@redhat.com>
References: <1816aee4f80.1026d4b311254470.8507588530121880177@elijahpepe.com> <87letrrz32.fsf@redhat.com>
Subject: Re: [PATCH] python: remove IOError in certain cases
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 20 Jun 2022 11:04:17 -0700  Petr Lautrbach <plautrba@redhat.com> wrote
> Could you please provide more details about the certain cases,
> preferably with a reproducer?

Yes, I can. In this patch, I change two files: python/semanage/semanage and sandbox/sandbox

In sandbox/sandbox, IOError is unreachable as OSError always takes precedence, so it serves as useless code. The ambiguous nature of IOError and OSError, despite both serving the same purpose, is why I've submitted this patch.

To reproduce, if the Sandbox() function were to be called, and an IOError occurred, OSError would handle the error_exit, not IOError (which is fine enough, since both exceptions lead to the same result, but IOError is redundant here).

On the contrary, if an OSError exception occurred in the createCommandParser() function in python/semanage/semanage file while attempting to call do_parser(), since IOError is an alias of OSError in 3.3, the IOError exception would actually take precedence over the OSError exception. I'm not entirely sure what version SELinux is attempting to target, but the try except block in do_parser() is ambiguous and its implementation should be reconsidered. In that file, I've had OSError directly handle the exception. This, however, does change this function a little bit; the second argument will be displayed as an error, not the error itself. This might need to be changed.

Thanks,
Elijah
