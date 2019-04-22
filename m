Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C607C10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE980206A3
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aLpmJPMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDVUpN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:45:13 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:45273
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbfDVUpN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 16:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555965911; bh=ICb79giFhCXz8y3j7C1aRtB9+ni1Rx2eAzxOh8Xq09o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aLpmJPMadl6UVCF1b8QF5VCmSDCmSkTD2TpMWyYGIvsd6YRZgkW0PMGKjZoEKZ43ycXcVQE+wNyP9Sysnc+VWd0qVkLWvs/jbM/4CJDHp6BMcAEKke8Z5wIsvHmY2wjPlrQqmqrNrcA1LjwCteZryBtldP6byQlx8MCYCP1FHZXol3Pxr8CJfcj4RtT6opUIj5gEdG/Psfwba6q3fqySpHmXtZ72y1TqkAg0veR2yZtwNp0BIn3wF/wUUTdWX1oKIKK/hJFR6UjG3F5s/cgphrN/WD8qtNxuMyIZV9LaXFfkDEoUUtHogDXKwp5lVM4krZBY1Av2GZZRVSB4toMZSA==
X-YMail-OSG: NidLUq4VM1kit8OuwPHodc41JAydY1VxdaDKUasCTzS95CJfFIqMDBJIeluiqcK
 x7CkGeWXWKxKSU1A9oHUtO9VXDdH5SGhD_7I9De2aUw4Rl0eEvgZ6QMXj3lbJWYgKPXWjurxuO4U
 sqlT1V.XK4L3GP3Nxz1tjlFdEfUkUWqqw0OsWcWUKiR0OO94Ch6bYRx.wzNuQgG_cBbZC.LL0c7j
 dTdeq0Jzn4Vfc2bORRL3dVeUow29ahQ.Go6AMwjRsXjouBH3Z5wzRC8rtLOEAs1cA93PLi8Ur4.u
 TN37JUFmTMogk0tY7XB4xJLYrqlGYvwU6B81ORt261AHma3olsI0bnEFyf72isH_k0o1mib9hVP2
 4QZPi51TCwPuXY1ochM1C8P9HBfJCxFqpkHFDF9W5GK6jDlDhqssy8AiJl6At.LPvcaCBUtJXUcK
 JeIuxBFBSirRl00htbzy7IsoxjvGuG7Ps1UW_SfJI0pteNuT7wWfsY9c2R13XdJUMia0Bod44XVR
 KDrEzxJdmOJ3oosmMEiuPDaTZM1mr5SqHm7tttH5fpsuYYFBeHmlJoE4.R7ysMx7TzQP4QHnk7xf
 SETgQE6.NcY.p7lAFS.cH0EyaX.t_JPQljsL4EW6sTZ0ihqYSijjs7607jTgu.GQaj5WZDVT.JK6
 zuOFCqzDQiVzkd0pr0eVSw7BI1d5rJTdnihiSjMw1cQa8AvEF_MMWeZRIsyGAPgk3gSeuu9ID3qy
 JcluM1uGpc90NXNlWeawFe2aic3lRS0rrnkL_JbV3d53DMuWCj1B9EdSnzsy2zw7oulEr9gvGKZ.
 nD.ruE3eA08voYmClhh091sEkKurJhfp4ADEHL4NEsThS4P0EZPFQVRV8CaWjxd9nU4mRyOsgAYx
 NffF5oRp7TxmvISOo8Q30T7UGi3jIYQhHJXWZIE5TqmD9TgwZHwcrr7uI.ddtkuRq0bJr7uQS3fH
 RicLFvd2pEC..3wtRSculuiAXLBl72jb5wTmHUFwqlruZWxn5_ClQ89F1h8Pb5TqArq7CrsRuRrL
 lHpgaZrLbCIxiNwXGExmGdDpWYGymKVLLAXqys8o0KqUtPqH4dnSF2nyng1Uh6me_DdPasqb.VdV
 _x_Vo60hmka19u5EO.0oxRwB9Fhz3GwOfEFuaJuvu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Apr 2019 20:45:11 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 77c0449adc451cfe94ee60780f1cf6e6;
          Mon, 22 Apr 2019 20:45:09 +0000 (UTC)
Subject: Re: [PATCH 69/90] LSM: Use full security context in
 security_inode_setsecctx
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <20190419004617.64627-70-casey@schaufler-ca.com>
 <04b749f6-097e-4faf-dc87-7892db728e3b@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <57c13f30-2f24-cdc7-52a0-27d791ebe315@schaufler-ca.com>
Date:   Mon, 22 Apr 2019 13:45:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04b749f6-097e-4faf-dc87-7892db728e3b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/22/2019 6:13 AM, Tetsuo Handa wrote:
> On 2019/04/19 9:45, Casey Schaufler wrote:
>> +	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
>> +		if (strncmp(ctx, hp->lsm, strlen(hp->lsm))) {
>> +			WARN_ONCE(1, "security_inode_setsecctx form1 error\n");
>> +			rc = -EINVAL;
>> +			break;
>> +		}
> Will you avoid using WARN*() ?
> Since syzbot tests using panic_on_warn == 1, this WARN_ONCE() will act as panic().

If syzbot hits any of the WARN_ONCE()s in security_inode_setsecctx()
I want it to panic and generate a report. A badly formatted inode secctx
would indicate that kernfs isn't getting the string from
security_inode_getsecctx() or that it is getting corrupted somehow. In
either case, it would be a bug that needs fixing. I used WARN instead of
BUG for the kernfs people, who might break something by accident.

If there's a strong objection to WARN_ONCE() in general, I can pull it.
  

