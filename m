Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669DC282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4197A20674
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RDsfW8Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfDQPj7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:39:59 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:41444
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732637AbfDQPj7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 11:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555515598; bh=vh29Dvm9k8Fnp50MU8pjyDd3XXiZKmfUyaX5RhXSI0A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RDsfW8OsWsSAfDHbYKTv/5cKZK84d0f0D50KYdNLomUweMGbThB2L/L3gbk9RmwcjW+o4qV8ufD7Sbjd8sJrYa51cg0mi1ZkqbTPmEOPgeDFvFLuiVbwYsytR3TvnwX9Rae6RYGtWY4i3HZsbkjnWUUdwOUia4GM0PxPyoUfoWGn7zHOtp7zPCc+fegiMZgoCkTaz0ZWQDCdmDX9+fjwjWXm8JI4qx0iZ8Lj25Rtnm20dRDy9lzQ6qY+/D1oaMktR3PczuzzpwjOOeHMchA9Tm3tfpYmlp80keUP5qvKE+yeTBB2nExRyHhqpkODjS5XA7R8yPird4MyKnvicF8PwQ==
X-YMail-OSG: jAfxFuIVM1kIRSHX7L0CCr2YMlASvfc1dIQaMdP4SFX3i_1zUQc0JTTek5WB.Hj
 sFFhm3wNin40BQ0IpJqZZGSn62ETW7yac71rFKAGaZ1ElruIha5078IiB5qIhdD5d0pJOp3GkROT
 0aJFbjNW_qKSjtnRS9ik0EtCE7B_5IS3IM.MB2A0BcD3Z0P4R7ZTHQL2SvUMBm2rJoRWed0WLB1K
 v7rFGoQ3drX4gESBZawOVjPbDH7RJg8X1dMOUhh3MZUWaW55G3s96ss55VOOKIxoOdi.FYXNPzUA
 4ZM499rYbNlpT1IINJR9ILqhNcRpUx.BVR_lDb3vWMP8B_dg02TfvYb0A8EYHJFKIsB2rdz8bKUe
 SAa1T9SUkAA4n_LtBcO1YU10oYzzfLaCM_HIOR7IeCuTj9lzWUIWo0Kb2ECl50SHmzuNpk5MfWYy
 bGhz6y9Lq5EnTVW1wotvcMzi3jAgWivutyNhV1K3AlENZYH_nQEdQGjaJ2s9Hwff5GdY2qUoYB37
 L9iqx6rjXb4RLeqDJX5RVl39j24Ga82zqQGsrM6IQwT6N8kH4COFPLeqR1mATD2PzGBIr0MtovJr
 kzM76QVLsKvFQ395BGHJo2gzo6TEzQKqk6bvUex2Xr.cstk9vfI.9DZbiDISxhK3HeRtElVlpKk2
 Eeae.5WSDx0HLQEgVUt8PxOS487oVs9I511eixGo9fu96aS59szwNdQorVS2pe12t44h84hgoV0P
 Cg9oqJHs3RejygEE0EGJFpF_ezcOvyY.I0vX0iCDQMJipBrb8AjYkjXKrv6vzjavtdMGpZ3iqb_X
 7PwqYF_b5eAYKn0SDciZVpMTWt7btyBhXKTmvlKcBkvX3N_a.4dUsCZ2fasnaJKzH8fahuhVm8mD
 kT691wcvTKol0XrApcoshM_FcNrmaaWyobg1fMUDTzoHRqFDyhEGtRQj4f3Zb1WmiM0.qGDQ4NDm
 c5uKc8N3vOJOzkXU9alqeDJEN_DdBsT908LIzRaa4Vr_tJtaCQ8wtOpKWPVly62TmQW9tSGGMW4u
 X2f9bSX.LrTKBFw08nKF2Rqw4.nz4usRE74kOS..bubD.Uh5Qj.z7R54.wDnUOcjiMpOS0HFG1H4
 qXiPud_ihwVQ3Hrygeu4v4TCor.P8dQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 17 Apr 2019 15:39:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0c7ccd10146cdc242db139b22803b88d;
          Wed, 17 Apr 2019 15:39:57 +0000 (UTC)
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
 <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <18298e7e-373a-faa7-fe18-4992ad440b17@schaufler-ca.com>
Date:   Wed, 17 Apr 2019 08:39:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417145711.GI32622@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/2019 7:57 AM, Oleg Nesterov wrote:
> On 04/17, Paul Moore wrote:
>> I'm tempted to simply return an error in selinux_setprocattr() if
>> the task's credentials are not the same as its real_cred;
> What about other modules? I have no idea what smack_setprocattr() is,
> but it too does prepare_creds/commit creds.

For what it's worth, my test for Smack does not reproduce
the problem.

>
> it seems that the simplest workaround should simply add the additional
> cred == real_cred into proc_pid_attr_write().
>
> Oleg.
>
