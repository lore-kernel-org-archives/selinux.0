Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C1C43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F0206DD
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QXW8gE66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCDR4v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:56:51 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:41077
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbfCDR4v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Mar 2019 12:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551722209; bh=GC069wVlaL0TLFD227ZH92fWAUBkMXO4kaPfz/TDKoA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QXW8gE66dmMl1rt9zIM53upJKN7DUDLMsP+7982OQSYZNEJl1367SZR4UH7tUoW+DQaFHwuekES/w+M2FJCrvYgOSAd3bYVjuMjL3j0GdX2HV+x7AwFhoyMT2tcyrNvHErFaSU3C5Tu2JxeTHgKETbB9SUWICPgKpaT5oMoF4xivkqzC7SNR1l86TS1sNw3uFEqGR5p2t7cTAPm41H35BvkUS2lsb5TWxtmiKeAcIhMAgzeMNHjOEC7rqZnuJtpICU2rAnita2a5PtM6heuBhLIcSxTLHwj/4cXd/jf/A9WVj7u9xdteCxtoenOewrklargYxVtqcGwnUMm5qpghcg==
X-YMail-OSG: AMBDSy0VM1mRDl1r7Q3cCvDCHwVIzHs9HolytX6yVh5mbGzM4MxT8bgAVRJqVoH
 vV9lEiJ0N6zEC.NnbrA7UDX85c5CKXgcauoC7D7nbYFIMooYxIhp9ogamZQp0jxOhcj_QFn4gWBJ
 yF5JD847JRD8sLtARKLqz..gw.I6yLU62j2VbiJDOYgC1SXaVSeiD6MghgcfOCOqFWHPjcxJn5Pg
 lvOgqgpnf.MQyFcAnX8kFnCo2AByZXkX6Ti8UOVJDvK2GTpK6ellW6HHu2qNwXEjKqqxQGofzEYA
 0t7V9buL3za.c5kkK9hwdlvyyABpIJpF_YQyG9K7OUKyniIbQC9G5Sod.QcyYlBZRySbRT1.5xyX
 8bFpk2v9mzrNJ0pzbdPjPOTPoct18b5ZiljzEF3wnlRgqPM7xTY0veep2zL2NX._SgtXj6InA7LR
 aGPLzaG0_GQ2.76CikwE8fvDQidfducay20FVFULMp998cVK5x5_3gmJmLdm9lnplOra9vdYqmMF
 RVAS5_eSQiz_MommxWhjV7Mh0NbuIb2oZmb4_CkBNuszmVW_DLNmpC1SDjU00qu0QhoH2pB5xMV4
 rZa7FePgn55.WbJn9A8Isww4yA.9Wcr7cHyOwCv_A54FanwGdYTayjzvB5ynk8G79M9LpnbVXdM8
 7cF4lbwKevoRrB9_bKN2L0oalPP5_jn9ghjXUAhlDa23fIg34DyV_6CglZLO2K_1JP4V5D9C0NEb
 2gu3gvfLkLN2Vlbv7CiCztfKPniNDCRyNcgO21mkADRNPq_JKJVF7h7BgJ8GHCnA8VXW29TUJ3dx
 PliWV5KaS4BcNaQx_RbK4CzOO6BGl8hdebXQ_ubCb9sDAraIi7BqyX3R8.6K8WZgOYxDOx_.MYkJ
 Qn3OQGcmeKeHZ6RJZexFtI56.dUANGA_Mu77.nJj4MV0iccJ9mkWqX3UkE5yAVvOqgTL6Dm0f_ec
 CVXnoSQAeD8OI7d0APBrtvQ4dduWbjlWCVaqM4BAeop2Z8HupZ4GmqG9wBvjSg46bJF4Xa8C6qgy
 ijF5WZX6D6N2y75sH3k6ujADvdm9b6RryvoU1xHKNSfayltZAZ7gxFrzBbtw_FCar
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 4 Mar 2019 17:56:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bed51b671e44fa380576cbee08ed0a10;
          Mon, 04 Mar 2019 17:56:48 +0000 (UTC)
Subject: Re: overlayfs access checks on underlying layers
To:     Mark Salyzyn <salyzyn@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <20181129134943.GA16762@redhat.com>
 <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6e31bc53-0a27-63d1-2d07-a403dfe36ce1@schaufler-ca.com>
Date:   Mon, 4 Mar 2019 09:56:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/4/2019 9:01 AM, Mark Salyzyn wrote:

Adding linux-security-module to the CC. Please keep the general
LSM community in to loop.


> On 11/29/2018 05:49 AM, Vivek Goyal wrote:
>> So will override_creds=off solve the NFS issue also where all access 
>> will
>> happen with the creds of task now? Though it will stil require more
>> priviliges in task for other operations in overlay to succeed.
>
> NFS problems seems to have ended the discussion, too many 
> stakeholders? too many outstanding questions?
>
> Do we accept the limitations of the override_creds patch as is, and 
> then have the folks more familiar with the NFS scenario(s) build on it?
>
> [TL;DR]
>
> After looking at all this discussion, it feels like a larger audited 
> rewrite of the security model is in order and override_creds=off may 
> be a disservice (although expediently deals with Android's needs) to a 
> correct general solution. I admit I have little idea where to go from 
> here for a general solution.
>
> As far as I see it, the model of creator && caller credentials is a 
> problem for any non-overlapping (MAC) privilege models. This patch 
> allows one to drop any creator privilege escalation, re-introducing 
> the "caller" to the lower layers.
>
> As such I would expect a better model is to _always_ check the caller 
> credentials again in the lower layers, and only check the creator 
> credentials, some without caller credentials, for some special cases? 
> Change an && to an || for some of the checks? What are those special 
> cases? I must admit _none_ of those special cases need attention in 
> the Android usage models though making it difficult for me to do the 
> fight thing for the associated stakeholders.
>
> The lower privileged application access to the directory cache 
> inherited by other callers troubles me (not for Android, but in 
> general) and feels troublesome (flush out the directory cache? how to 
> tag the privileges associated with the current instance of the 
> directory cache?). Some operations (eg: delete a file for incoming, 
> create mknod in upperdir) are special cases requiring the checking of 
> caller credentaisl to function (not a problem for Android as the 
> caller that deletes a file just so happens to have the necessary 
> privileges).
>
> Also, mount namespaces (in upper, lower, etc), how will they affect 
> this all, is there a need for more attention to this as well?
>
> -- Mark
>
