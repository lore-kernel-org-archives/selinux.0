Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96560C433FE
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 12:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiBAMeo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 07:34:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiBAMem (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 07:34:42 -0500
Received: from [192.168.254.13] (unknown [72.85.44.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id EA16320B6C61;
        Tue,  1 Feb 2022 04:34:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA16320B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643718882;
        bh=nGW3HqhBhqX2EuVnICCxjGmrKk/VP94AUZ2cZ6Oo3Hk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=EaHgUcWro9vs5fTY3P1RFW/0SWHfR5kTs0ijPW1Sf5gaWrrbA7jTbA4vXlbPXwC2i
         J23XfLqse5T2enRRyhxfT0Fy2acB4YSzzU+pAgrYfmt3m7IX2QBD1YQkvftNG3tLSx
         +amKjvzXrFIz/uw+C4CyV7nJUtR39+W1Z5W0xG/s=
Message-ID: <29a0bce7-0260-f403-a5d2-4a079aa14f3c@linux.microsoft.com>
Date:   Tue, 1 Feb 2022 07:34:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: kmod and unsigned modules
Content-Language: en-US
To:     russell@coker.com.au,
        SELinux Reference Policy mailing list 
        <selinux-refpolicy@vger.kernel.org>
References: <8839796.NKUDOvIH9j@xev>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <8839796.NKUDOvIH9j@xev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/1/2022 04:29, Russell Coker wrote:
> [    9.002945] audit: type=1400 audit(1643707510.152:4): avc:  denied  {
> integrity } for  pid=371 comm="modprobe" lockdown_reason="unsigned module
> loading" scontext=system_u:system_r:kmod_t:s0
> tcontext=system_u:system_r:kmod_t:s0 tclass=lockdown permissive=0
> 
> We need to have a boolean for this.  Just sending email so I don't forget it.

Switching to the refpolicy mail list.

The lockdown checks were removed in 5.16.  IMO we should allow all 
domains both lockdown permissions until the lockdown class in the policy 
is removed.


--
Chris PeBenito
