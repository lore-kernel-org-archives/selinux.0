Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BFC00140
	for <selinux@archiver.kernel.org>; Tue,  2 Aug 2022 13:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHBNzt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiHBNz1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 09:55:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C82DD64C3
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 06:55:22 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 64B0720FEB3D;
        Tue,  2 Aug 2022 06:55:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64B0720FEB3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659448522;
        bh=JO+yQPFofX4ZsnIVUpNQWIuOaWcENamBX5YVYQlIzhA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=MyIygvpu35zK/2G/ktFMxEhNWtt4l1h3CKoQDIH2jbpGPY1BNKPbQ2dnTAsgvMFZ7
         B4A9Tr6OmF1Ssi1El2ULD9sdEc48vFrruopP5GkfGG/jrYvnlG1TT4QCYtdoshZkUi
         d+4Y8MimQZunGcXXTNn0qQQm1rXNOHdDIF2jo/p8=
Message-ID: <402ab967-1d76-40bc-f901-8c0339ef8b45@linux.microsoft.com>
Date:   Tue, 2 Aug 2022 09:55:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH testsuite 08/24] policy: move
 userdom_sysadm_entry_spec_domtrans_to() to general policy
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20220729120229.207584-1-omosnace@redhat.com>
 <20220729120229.207584-9-omosnace@redhat.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220729120229.207584-9-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> This is good to have for pretty much all domains, so remove the
> individual calls and move it to test_general.te.
> 

For whatever reason, test_sysnice.te uses

domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)

instead of userdom_sysadm_entry_spec_domtrans_to().  I think the access 
added in the global attribute here covers that and the 
domain_transition_pattern() there can be deleted as well.

Between that and the change to test_setnice.te in Patch 9, this comment 
above those two lines seems obsolete and can probably be deleted:

# Allow all of these domains to be entered from sysadm domain
# via a shell script in the test directory or by....

-Daniel
