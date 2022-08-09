Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02CC19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiHINoR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHINoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 09:44:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E7318B13
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 06:44:14 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B940210C88A;
        Tue,  9 Aug 2022 06:44:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B940210C88A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660052654;
        bh=hg/JvHF1vjDDaAuHIJx0oo94oTpuzXzynuvoUAIklDQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YdX7088r5DSC1idKs7ZC75umfhCIPHK8y15fRpjhRe5tgN4gS7DUP94cBzHixQ3vq
         AeTZpT8JJLeWEJ8oUt2SzlGumUI+e5QpcPT/E11/LvfGHdIm1wPbyn9MH7mZFvq1Eg
         caAdXDOEd9SgXx4DykBvqQYTybJNvIw6BAdxMzwU=
Message-ID: <9425e028-65b3-853e-98cd-c3238c99bbea@linux.microsoft.com>
Date:   Tue, 9 Aug 2022 09:44:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] libselinux/utils: install into bin PATH
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20220808173547.16638-1-cgzones@googlemail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220808173547.16638-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2022 1:35 PM, Christian Göttsche wrote:
> The libselinux utilities are mostly wrappers around libselinux
> functionality accessing the selinuxfs, which is largely usable for
> unprivileged users.

I can see how some of those tools are sensible for unprivileged users, 
but others (setenforce for example) seem clearly intended for privileged 
users.  On the whole, most of these utilities are dealing with the sort 
of policy details that the "Mandatory" part of MAC tends to want to 
leave to administrators.

And while selinuxfs is mounted with permissive "other" DAC perms, a lot 
of the access tends to be controlled much more granularly in SELinux 
policies.  Obviously a targeted policy with unconfined_t for regular 
users will grant all this access to unprivileged users, but I suspect 
that most implementations with more restrictions would be fairly liberal 
with security_t read access, less liberal with security_t write, and 
much less liberal with the more granular controls in the security object 
class.  A (very) quick skim through permission on my Fedora desktop 
seems to bear this out.

I think that the claim that those utilities that only require security_t 
read are fine for unprivileged users seems reasonable, things like 
setenforce, togglesebool, setfilecon and the compute_* family, to name a 
few all feel more like administrative utilities to me.

As a minor note, setsebool is located in policycoreutils and installed 
in sbin.  Separating setsebool from getsebool and togglesebool feels 
somewhat weird to me.

-Daniel

