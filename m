Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0AC54EE9
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 20:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGU4n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIGU4n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 16:56:43 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066969DB78
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 13:56:40 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id DEB0EFC09F0;
        Wed,  7 Sep 2022 22:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1662584196;
        bh=QnQpeV5xNLJ+f90ed+rIWnwfaHOQnNlc4/9qEurvPr0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ovNh6xRmUKCUMzYPibH3jq+CxQ29N9MKS78IjaAfbN6ZJNe+ElFf1GObUY8osatn9
         ayDEgMajKG8ZYqtXMErdre5LLLAjobTMoJGcNTyxa1SpjwAUO5BF7X72lh+12xdlA/
         vgCAnismMiOkuKeaE4IzsgHu0KmTymRLgCH8Fh3M=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Subject: Re: context of socket passed between processes
In-Reply-To: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
        (Ted Toth's message of "Wed, 7 Sep 2022 15:18:55 -0500")
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
Date:   Wed, 07 Sep 2022 22:56:35 +0200
Message-ID: <87a67ac398.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ted Toth <txtoth@gmail.com> writes:

> systemd uses a helper process (sd-listen) to create sockets and pass
> their fds back to its parent. I've patched systemd to call semanage to
> get the context for the port if it exists and create a context using
> the returned type when calling setsockcreatecon. Everything looks
> right i.e. the port type is retrieved, the context is created and
> setsockcreatecon is called without errors. However 'netstat -Z' shows
> the listening sockets type as init_t and not the type in the
> setsockcreatecon call, is this the expected behavior? Can anyone help
> me understand why this is happening?

It is probably the context of the process listening on the port and not
the context of the socket that binds to the port

also i doubt you can rely on the presence of (lib)semanage (think small
embedded devices with monolithic policy)

>
> Ted

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
