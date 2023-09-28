Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9FE732FD
	for <selinux@archiver.kernel.org>; Thu, 28 Sep 2023 17:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjI1RKu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Sep 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjI1RKi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Sep 2023 13:10:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130BEBF
        for <selinux@vger.kernel.org>; Thu, 28 Sep 2023 10:10:31 -0700 (PDT)
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
        by linux.microsoft.com (Postfix) with ESMTPSA id 38E6020B74C0;
        Thu, 28 Sep 2023 10:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38E6020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695921031;
        bh=cPX4N0fGf1zlCDo6V4lFa6IkbUP27WTFjIEFZ3V6klw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=el+fnYvAVLHOVStrqUtLPCWelM3zoBwJHq8a2HVGnNXnZWfbElSiaX8QEtI5mskDt
         ZZngbzBJiRGKJ9oaF/SklQiXtQjnQ5I3KzPLwBmlVSRZKxHysGmGsOtTl/v5m8iGWi
         Z404Q6D25dBUesPxQitE4ceYmMAYb93dpCgurswE=
Message-ID: <2c0b5552-84b8-fe63-6d4c-0a42c7b8a753@linux.microsoft.com>
Date:   Thu, 28 Sep 2023 13:10:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
References: <20230927190021.1164278-1-jwcart2@gmail.com>
 <20230927190021.1164278-2-jwcart2@gmail.com>
 <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
 <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/2023 4:41 PM, James Carter wrote:
> On Wed, Sep 27, 2023 at 3:27 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>>
>>> @@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(struct cil_tree_node *node)
>>>        return rc;
>>>    }
>>>
>>> -static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
>>> +static int __cil_resolve_ast_node(struct cil_tree_node *node, struct cil_args_resolve *args)
>>>    {
>>>        int rc = SEPOL_OK;
>>> -     struct cil_args_resolve *args = extra_args;
>>> +     struct cil_db *db = args->db;
>>>        enum cil_pass pass = 0;
>>>
>>> -     if (node == NULL || args == NULL) {
>>> -             goto exit;
>>> -     }
>>> -
>>
>> Is deleting the "node == NULL" part of this check intended here?  It
>> seems unrelated to the rest of the commit, and it's not locally obvious
>> that it's safe.
> 
> You are right. It is not related to the rest of the commit. There are
> a bunch of these sorts of checks that are useless and really annoy me.
> The function __cil_resolve_ast_node() is called once from
> __cil_resolve_ast_node_helper() and neither node nor args can be NULL.
> Since I was changing something nearby, I guess I couldn't resist. I
> can leave it in, if people prefer. It doesn't cause any harm, other
> than annoying me.
> 

As is is fine by me.  Your explanation makes sense.  I mostly wanted to 
make sure it was reasoned out rather than an accidental drop, but now 
that you point it out, it does look impossible for this to be NULL.

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
