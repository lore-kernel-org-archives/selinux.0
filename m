Return-Path: <SRS0=vE6x=SX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F8C10F14
	for <selinux@archiver.kernel.org>; Sun, 21 Apr 2019 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9326B2080D
	for <selinux@archiver.kernel.org>; Sun, 21 Apr 2019 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i7UhXBII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfDURRC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:17:02 -0400
Received: from sonic317-2.consmr.mail.bf2.yahoo.com ([74.6.129.185]:34960 "EHLO
        sonic317-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfDURRB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Apr 2019 13:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555867020; bh=N3bfeWm1v2xivoHCn7uV0zutksgTiERHgmQB7g5ZtbQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=i7UhXBIIdNEmOgGOoDEh0Ybflf5qPNPLn2tQ+vNSEhtDT56i2CK8KwnJruP3GmhyXhmwxDHyNJa5QA3tIbkt/BHLuca9t04CyqileTt5YbCycg3FtOQUDmkPO3P+dtswNGtKV69BhIaVVsbG1nqNFLP6UbroLiH5OmP6wwfXLTICwGUNS7ak9H8EQEGQOO+phkp3f7UjlP/X4t3jg1QrCYpkQXZDxvhJk3YdeBcA5XSr7ZFWvkELhXX2zIJDRshmXelIo6TDKLvGU4xP9Ib+wpCjXPVBDc5ixV1IA2b7uxreFXaJWvpaZoTS4u74NGWlJkQBsGtFz8lm9Lmap2ye7w==
X-YMail-OSG: _lmLM5wVM1l4Qu9RENfq9xTrMNCJHT4Ry7unPdDMJZEC1o0N13Bwbd9zEoLE6_q
 L8nhKE_ono7jPGAkFv5pIMq91sQUun8Hr4gmPDOM02MGFfX4Dk0mh2JhLzKNGQTl2uPfzDax8QvK
 TFd1k7X4zp_qaszRA_mGnau.U9.lLmcPMr07VZD8cpOfJ2L4OYyUvCoJuSNg.TauxVsxPvv9h_ne
 hd.MvzC67cUADi5FvhIjV_e5YhQmjEGoRLyDWEYa3UH17YQ7SqfDRqdUxDumeWwd5XdKAbEpEkc5
 o6UT5eVw__JvFzr._X6d6GQQ4CdpYGHVMkpQ9eZ2gN7MLPw5j2MLgzkBsJ1GTKaQZMQHHyi7alxQ
 QQ1ylTgZ2QpPiGxSDRt5hPDUlmFTt17OvUAUKGqGA3VvPcEtW.Fd9XpaklJF3_dymfkShIbxxT4v
 3YYeaDCzr6gsjQMyvALB..iIXu3ZT7wY52eljCZvmH1oaNtIKwq7fACzztb4OHxRLXrqDX1OE0kW
 ZIAvfcsocc0TX7db38uKLqAKNo_rVG5IfhmROseVUPUpJi7PJbq0P0JteOlIwOkXNNKaTC4gZpOB
 s0ZATu9rrAxw8IzArjtm1zDo1Cho3XGeIWknjOM6EJ0dpfaxZTMDdt0tNptDxKev7uMbL2GLXE3H
 Cci.ACiOMNeNwnkvE8jbPakm0TP01_g8JsLIPVinDy_wxGxPCHleqTZ2hxVLbO5Y7U7ru9rmQNy8
 Jbz..zRGCe1pkXmwCdBOWnWiVo8P_Sok7OUM1thfLqZgKdQQqCAWszOjmmddu8aydeU3LQF62mzu
 sAqN2FY2rSH1mtvlYiZomAaw3zlcov_XY3s_r7jXQUyF0o.BcW2WZhDF_5vYydOuSyCkfYlTJK.Y
 ea_L4R4lNVoyFbLN49MP2zR3UOAIaZjumVFT4MB0bnI03.GSfXFg6AIEUWGi74fsBFgLLLg0LtAI
 hK2rdEB3jg7xKmzfueCyiHteJSFrxEHWD5oCMOA.eLumlBRba1_DrbcS1OfXfxuDGatbykWrly5C
 iPwmXuFyRQd1XgLjKMQIZSWSSAHJGPaRvWw5XATm.Ss_tVQ_Kr6_Wqo22Kuwq87RUvmr2yB5INAa
 S_hJoZbGgfoqetNVdX9fh8h2KEFgtQ4lv.jJ3BHfD5RafzuCMBJQc0V8w.WaV9TRhJpypIeYCtDx
 oE.gEDNmky_a5pEYswP1WPLUJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Apr 2019 17:17:00 +0000
Received: from 104.129.192.81 (EHLO [172.26.55.93]) ([104.129.192.81])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1a68f048bd2164e9e55dc68d01740e89;
          Sun, 21 Apr 2019 17:14:59 +0000 (UTC)
Subject: Re: [PATCH] proc: prevent changes to overridden credentials
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, cj.chengjian@huawei.com,
        john.johansen@canonical.com
References: <155570011247.27135.12509150054846153288.stgit@chester>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <51d713f7-8f0d-1181-df45-0530f4c3ab0f@schaufler-ca.com>
Date:   Sun, 21 Apr 2019 10:14:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155570011247.27135.12509150054846153288.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/19/2019 11:55 AM, Paul Moore wrote:
> Prevent userspace from changing the the /proc/PID/attr values if the
> task's credentials are currently overriden.  This not only makes sense
> conceptually, it also prevents some really bizarre error cases caused
> when trying to commit credentials to a task with overridden
> credentials.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>   fs/proc/base.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..87ba007b86db 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2539,6 +2539,11 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>   		rcu_read_unlock();
>   		return -EACCES;
>   	}
> +	/* Prevent changes to overridden credentials. */
> +	if (current_cred() != current_real_cred()) {
> +		rcu_read_unlock();
> +		return -EBUSY;
> +	}
>   	rcu_read_unlock();
>   
>   	if (count > PAGE_SIZE)
>
