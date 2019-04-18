Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_CREDIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE570C282DD
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 00:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D37121850
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 00:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ofi1Wc6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfDRAZE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:25:04 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:35384 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387497AbfDRAZC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 20:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555547101; bh=mBy9BHh/XYa8UC5jSaXnQwqfS/EqkKZTklG8JBXPER0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ofi1Wc6PZCwQW4MQOFvLVnr+o8iwjn+vrbpew3r2iL1dGT761kT57At4uSVnI6B8mZTOeR3SXfQthwfsnJiLTp1WLqJMtjN9IpHjFS2OmLqJq1gTPAjGh87wfPTE4Qeb7XL3AmdOFgN6FhRwleFF+C+J1mC0/f6NNEMlmueHlZTdTJNgqRpXEtakrWWDtd2iagw6fHVlSNUET7bZ4o4HLLoag5EncUS/1kTY7efgdQ6ow206nxnfUMzDufz7zbms3b11lmtrxUTN9YG3r9BohosPL1excKoCQizkR/NGInV/Yq6w3ucmS1oMsY3p1PxGiGabZsWfPpfaL+nybv5zWg==
X-YMail-OSG: GpGDIyQVM1kRTOdILqOS0UxWeSRvYAUxaa9RVGCuVRVGYP51LLUjgldNhKOVSd5
 QvTJig2A9E665jc6VF0QGA5oqrbIkU6n0UHpzcV9shCjG8yaWxyUU5QFKaWnbWoIzY3kJDIxXo_u
 Na_3gr8YmBe1.9I2WoVRgybEaVeGXCUYkOtubX7WXf7.g06Tk7aRqOMw4KAA.igs0CsvUd_w_Ejj
 Bu4Fg8WZp5xHFDoOBRCTpyb2.cuHOFG2ZC5kIxM7XpZ.sYEeqrNdLbH6WKM4zhHuWQCv8.UKV2p2
 NFnNIxC9cnamPEO6U_oPRKQnxn6mPjyZOOjXp5x9nZjxE.kn_sUhPHmq8sUY4ETs_4z2d1iVNMa6
 .S5YYMy1xGI3SOq3JvA3.jGXE6X.YgQD91kfC8ENoT8L9uF4SDGgws6_M75GGiS_mATIpULP8XDn
 oXu4nL7bct.EhM6kh2CzpEhmBf.HYcRKuzTyxPT27_PKdO0gCcVGFmPrAxdtbigmkHgkZiYfAShP
 u5zx4P03EdWYDrm9TzsQEW7IKuCHfVodhkdO2HVNDf3ydk4dbpqXOOdYVFZCkqAvFkHUqM1UCr60
 CF_ha.EqJYBZTC4lBc7oLB9Gq1WRXb77ahqIBsEZrMRrxa.rCpEHh6P9h7gF527dkrsBbnhdjO8U
 uj4R_Nsr9bS3ptDSpCagMmyRdG0243Ms08MWBNce896wWMDjY_6xefl6RBk6B1voDpre5eo6nqdX
 uJYUQtTFR4.X_t8LZyLJrqLva15i1TSDs4hglYs7NeBZpvPYXx0ArUYFJVhGxy.w3ukJMyMGleun
 z2QAv_knacgvbtvoDYT_BwGWVPC3tkRNDVXuEUf9xPTCRz036Qz672ihg_kXhgv3sITYZlVXIG.K
 7L5D7OrPTolA2IwaiePEu0X78RcqhQD70PG_Xk1WKRmlJ6JQNP19kuCUpG5TpL2QxcrF_aaJipLp
 afEnk75PO8lwc4abIMMd4tKkj.6C5wOOF8SJz6_SEDly.bLlI59NpSSTbAGSRipXFUArBWlbbvEa
 xms1yT3iFoR4ZSUMuveo.aGYaHXZKwXlRmWNCCRTxIjooiPgMDCeuGWSFKNl5H8AHoMcWG1itAto
 _yWDuYDifpJn8qJEBKoPeP2.h
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Apr 2019 00:25:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 07cd9cf4e6abbb63facae50e124732d9;
          Thu, 18 Apr 2019 00:24:58 +0000 (UTC)
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Paul Moore <paul@paul-moore.com>, Oleg Nesterov <oleg@redhat.com>,
        john.johansen@canonical.com
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
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
 <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
 <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com>
 <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com>
Date:   Wed, 17 Apr 2019 17:24:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/2019 4:39 PM, Paul Moore wrote:
> On Wed, Apr 17, 2019 at 12:27 PM Oleg Nesterov <oleg@redhat.com> wrote:
>> On 04/17, Paul Moore wrote:
>>> On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>>> On 04/17, Paul Moore wrote:
>>>>> I'm tempted to simply return an error in selinux_setprocattr() if
>>>>> the task's credentials are not the same as its real_cred;
>>>> What about other modules? I have no idea what smack_setprocattr() is,
>>>> but it too does prepare_creds/commit creds.
>>>>
>>>> it seems that the simplest workaround should simply add the additional
>>>> cred == real_cred into proc_pid_attr_write().
>>> Yes, that is simple, but I worry about what other LSMs might want to
>>> do.  While I believe failing if the effective creds are not the same
>>> as the real_creds is okay for SELinux (possibly Smack too), I worry
>>> about what other LSMs may want to do.  After all,
>>> proc_pid_attr_write() doesn't change the the creds itself, that is
>>> something the specific LSMs do.
>> Yes, but if proc_pid_attr_write() is called with cred != real_cred then
>> something is already wrong?
> True, or at least I would think so.
>
> Looking at the current tree there are three LSMs which implement
> setprocattr hooks: SELinux, Smack, and AppArmor.  I know Casey has
> already mentioned that he wasn't able to trigger the problem in Smack,
> but looking at smack_setprocattr() I see the similar commit_creds()
> usage so I would expect the same problem in Smack; what say you Casey?

I say that my test program runs without ill effect. I call acct()
with "/proc/self/attr/current", which succeeds and enables accounting
just like it is supposed to. I then have the program open
"/proc/self/attr/current" and read it, all of which goes swimmingly.
When Smack frees a cred it usually does not free any memory of its
own, so it is conceivable that I'm just getting lucky. Or, I may not
have sufficient debug enabled.

>   Looking at apparmor_setprocattr(), it appears that it too could end
> up calling commit_creds() via aa_set_current_hat().
>
> Since it looks like all three LSMs which implement the setprocattr
> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
> a better choice for the cred != read_cred check, but I would want to
> make sure John and Casey are okay with that.
>
> John?
>
> Casey?

I'm fine with the change going into proc_pid_attr_write().

