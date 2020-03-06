Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37288C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008FE206CC
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dHMKgSsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFOQ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:16:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39880 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCFOQ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 09:16:59 -0500
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 78D4320B9C02;
        Fri,  6 Mar 2020 06:16:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78D4320B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1583504218;
        bh=O17MwEf+mQU6/rIwNZhvatTwfhEfvcJ1KuBToU/ykiU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dHMKgSszSCmIQHpvhtJyfy3KuKe4pp96WXsO3CCWDmX9DWdPBQtkFwiMlQ90XVg4q
         5ixuEkaOf1jmBN+5Iq7+7LMngfOGBVpNt8c2hNjerzVOhNjZ+TGbFBRbfF9gUyddhA
         lfm1nQxmNLWXOKPNs8jBwuHNAuY0sSwBW+whKBPY=
Subject: Re: [PATCH] checkpolicy: Add --werror flag to checkmodule and
 checkpolicy to treat warnings as errors.
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>,
        Joshua Brindle <joshua.brindle@crunchydata.com>,
        pebenito@ieee.org
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200305184034.165554-1-dburgener@linux.microsoft.com>
 <CAEjxPJ5OZpvvrWq9h1xYudLwZFgHj6nyr-uPnFqxoGEv91fk2A@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <f7d669b6-25bc-699c-5bc7-f7dbc12b3a24@linux.microsoft.com>
Date:   Fri, 6 Mar 2020 09:16:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5OZpvvrWq9h1xYudLwZFgHj6nyr-uPnFqxoGEv91fk2A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/20 8:57 AM, Stephen Smalley wrote:
> On Thu, Mar 5, 2020 at 1:40 PM Daniel Burgener 
> <dburgener@linux.microsoft.com> wrote:
>> When the lexer encounters an unexpected character in a policy source 
>> file, it prints a warning, discards the character and moves on. In 
>> some build environments, these characters could be a symptom of an 
>> earlier problem, such as unintended results of expansion of 
>> preprocessor macros, and the ability to have the compiler halt on 
>> such issues would be helpful for diagnosis. Signed-off-by: Daniel 
>> Burgener <Daniel.Burgener@microsoft.com> 
> I'm trying to remember why this particular case (unmatched character 
> in the lexer) isn't already a fatal error. If there isn't a real 
> reason for it, we could alternatively just switch it to use yyerror() 
> in that case. Otherwise, your description suggests that you only want 
> to make that particular case a fatal error; are you sure you want to 
> treat all warnings as fatal errors?

That's a bug in the description rather than the code.  That particular 
case is what caused me to want this option, but my intent was to add an 
ability to treat all warnings as errors.  I can resubmit with a better 
message if you'd like.

I'm not sure why the behavior is that that particular case is a 
warning.  Git blame shows it as going back to the import from svn, so 
it's been that way for a while.  I'd think that --werror would be 
helpful either way.  If no one has a reason for this particular case to 
be a warning rather than an error, I can submit a patch for that change 
as well.

-Daniel

