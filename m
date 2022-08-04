Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CDAC19F2D
	for <selinux@archiver.kernel.org>; Thu,  4 Aug 2022 13:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiHDNcH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiHDNcF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Aug 2022 09:32:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE1A839BA7
        for <selinux@vger.kernel.org>; Thu,  4 Aug 2022 06:31:59 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 18B9B20FE2E9;
        Thu,  4 Aug 2022 06:31:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18B9B20FE2E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659619919;
        bh=mEcaltxFczLX4+2aYjt5vOmYWakxtX4khb7xbSMEwMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fEgnDAEydtIAN/Xtpf5b3lmJ9WCqwMrklyuJfYxefOWP9870FBXKrrJSddOz/dCz6
         E8nZFDGngFqvuvBDIcWRnKTLmczsnhU0FZLWkGwpetZNFKWrg6OhyRqqEr5fam20Rc
         /3OJwVqx89VjPqlTlnyG9a3fyj9H2mfpH+xsZOxU=
Message-ID: <65929281-c42c-313b-c280-23cbff5dd6b3@linux.microsoft.com>
Date:   Thu, 4 Aug 2022 09:31:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH testsuite 08/24] policy: move
 userdom_sysadm_entry_spec_domtrans_to() to general policy
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20220729120229.207584-1-omosnace@redhat.com>
 <20220729120229.207584-9-omosnace@redhat.com>
 <402ab967-1d76-40bc-f901-8c0339ef8b45@linux.microsoft.com>
 <CAFqZXNtq5-BwaDFjGPX6fPbg304-Mm7eMo0mNy6PrpuK9B7eCQ@mail.gmail.com>
 <CAFqZXNumd2dEFN6BdyAgoLrQ6vUkAx1SGV5LJHBi_6rYZ-mhsg@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAFqZXNumd2dEFN6BdyAgoLrQ6vUkAx1SGV5LJHBi_6rYZ-mhsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/4/2022 7:54 AM, Ondrej Mosnacek wrote:
> On Wed, Aug 3, 2022 at 10:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Tue, Aug 2, 2022 at 3:55 PM Daniel Burgener
>> <dburgener@linux.microsoft.com> wrote:
>>> On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
>>>> This is good to have for pretty much all domains, so remove the
>>>> individual calls and move it to test_general.te.
>>>>
>>>
>>> For whatever reason, test_sysnice.te uses
>>>
>>> domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
>>>
>>> instead of userdom_sysadm_entry_spec_domtrans_to().  I think the access
>>> added in the global attribute here covers that and the
>>> domain_transition_pattern() there can be deleted as well.
>>>
>>> Between that and the change to test_setnice.te in Patch 9, this comment
>>> above those two lines seems obsolete and can probably be deleted:
>>>
>>> # Allow all of these domains to be entered from sysadm domain
>>> # via a shell script in the test directory or by....]
>>
>> Oh, true... I did carefully search and remove all individual
>> references to unconfined* but not sysadm*. I'll try to clean those up,
>> too.
> 
> OK, I pushed a new version (see the GitHub PR) with sysadm* references
> removed + corecmd_* rules also moved to general policy + some groups
> of superfluous macro calls removed as well. There are probably still
> some small cleanup opportunities left, but this is where I'm going to
> stop for now.
> 

Awesome.  I'll aim to take a look through the updated github PR today or 
tomorrow and hopefully add my +1.

-Daniel
