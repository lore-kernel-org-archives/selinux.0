Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13490C433FE
	for <selinux@archiver.kernel.org>; Mon,  3 Oct 2022 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJCNgp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJCNgo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 09:36:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7576C2E9DD
        for <selinux@vger.kernel.org>; Mon,  3 Oct 2022 06:36:42 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 020C620C33A9;
        Mon,  3 Oct 2022 06:36:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 020C620C33A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664804202;
        bh=N/+QuSiSltDL7Pcsa94I6d7A7CdxaNJ89jM9X0Ekz2o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JbvckBLD9xTyhoYc1EeZNvgr6YDYboWtusXkQnNBG5KyhfxheKigJ4vJyGYe2PHjh
         d9hCfvzWGvGS6+CgE5K/H7Jp0i9nsOIii30mv8wLkyMP+0/9ab32ZT/h0L97qK7MdJ
         J2csQhCT+wvXFuHIKi5oIe8VIb9UyQARsPwR4n/M=
Message-ID: <bf2cf936-1832-bb8d-33fd-b8ff1759e352@linux.microsoft.com>
Date:   Mon, 3 Oct 2022 09:36:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH =v2] docs: update the README.md with a basic SELinux
 description
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <166463207266.6015.2704084637353753709.stgit@olly>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <166463207266.6015.2704084637353753709.stgit@olly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/1/2022 9:47 AM, Paul Moore wrote:
> This is to help meet the OpenSSF Best Practices requirements.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   README.md |   19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 74b0a0c3..e820ac30 100644
> --- a/README.md
> +++ b/README.md
> @@ -7,13 +7,18 @@ SELinux Userspace
>   [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>   [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>   
> -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> -
> -Subscribe by sending "subscribe selinux" in the body of an email
> -to <majordomo@vger.kernel.org>.
> -
> -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
> -
> +SELinux is a flexible Mandatory Access Control (MAC) system built into the
> +Linux Kernel.  SELinux provides administrators with a comprehensive access
> +control mechanism that enables greater access granularity over the existing
> +Linux Discretionary Access Controls (DAC) and is present in many major Linux
> +distributions.  This repository contains the sources for the SELinux utilities
> +and system libraries which allow for the configuration and management of a
> +SELinux-based system.

Probably should be *an* SELinux-based system.

> +
> +Please submit all bug reports and patches to the <selinux@vger.kernel.org>
> +mailing list.  You can subscribe by sending "subscribe selinux" in the body of
> +an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
> +available at https://lore.kernel.org/selinux.
>   
>   Installation
>   ------------

