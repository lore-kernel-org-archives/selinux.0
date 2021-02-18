Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A55C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 22:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DB64EB6
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBRWIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:08:45 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45111
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhBRWIm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 17:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613686076; bh=oIoB2sQbZxqS+rQeBnEAeITRdAGhtUR8DLkpInFZQB8=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject:Reply-To; b=Ny1H2eOi+GJ1IsL2funNcukU5TU7F66Lo1PWwdt0Ov0ER0ZSFBIzDfy8NdvvuDLwZ2a5gcnnykiXvYCBLh/Ycu7lYJlWGvXNNhB3kspET6V6mVmvRLVrp5alJgxCiyuq+Pet7OXG8ousA6vERoAdXuAzhv8S2wD46EifebTQKwrj0T8NbPCmNOXJbXMlTgL22c9n2f5GVPd4Q3qUsrN98LS0joYh5IMZOvcYh1tJ3x0x/R7u2vbwmPCNqa9sNsxOxKiwm+ssVBdsDfNZ1xtM4pDs9IlIcLdGKmcR6GClMVPbnlKavyC5hs2cQGjtPT6vRJsxnA07rx0gkNNwDTScFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613686076; bh=WDwI5tSb125ElCjCdSUexQ+FLc0/MLmDEKkkXk7dCcY=; h=X-Sonic-MF:From:Subject:To:Date:From:Subject; b=W5L/OAil1ZuzUIAO4nTU0MqC8EvTtG56euC+9coSkZccgU28Zwb3XxXUAh0jajDaKv1wzp6yAw3iHuCHNGkkELX/jwqIBylaXsDCJzYHe6bdFg1VEiDK1p5DvcM2Lyqix7X+06jSc6CtZkXVUUJEsjzQZ18lodxu2Ef5YQNKwaBfkN9iClBveIqF8hwTQ7LuI9ifTSZ0Yd2RCkp9ltcoFDx3EMTJp6RKnZJF7p5xo25B+T5xWR4tDyhfdiyptnWrmLZ8NQIqEuxXmi1Hi8VIjgzo+gOQYMBq+2WwX4yf5duMHX4uiNDWR5nhkDZet0uJNpu9zC613MWes6dGtNmJ6Q==
X-YMail-OSG: DLQTCFEVM1nDCkvRdXBLT7_yLNmaPUQ1yAhUsyZh1RPdvzbvZ2l32Wf80TqAI0z
 HNsu6gGfvYapBqfWzPxDIB.hxp.HZXiUI.V1ca_D8fPKE1P1WScvJaH5AKys_GAAlE9zmLWNrIxc
 Le5T8uLQaClF6P0_9UqF.dnrV1kj0y6NzJycRFHdsYzGH9zGjHf0fTMFsRUVN_CnrVRvNKyWudaJ
 H58owMuEGd_.diKtwzhHLwWg4Bphsns.vVb02mpqVbZrgSEyjI_.7hK8AGLEb2y0TzyAAuoN2804
 zJnKMUmYOiqr.M6198hf71Qd07lCFYJt9z.nf5dZPKhltCUi_okRDj_tY1BYupuIjEV3n.nI5VDn
 jBkDr5FlbYQuofkutNM8MmaejqwbLs7LPbomA.Z23RIfyow7eKlFn1j6yTzKEBlP.0qsiuBpkLKl
 qbTIT6K49tJkjP5ypWtFFU4nJ8HSFl7BAl6z0864rjzda.bbDgz_nwVJTzPaQmnF0im6oLj5jhkw
 8qiApBSRY5esiDC_ZCzOQIpfYkfL13RU_hq2qmjd1lcjLJNwVjNgMQKhPujv0k_esNJndZwNsr4H
 SKNRPE4ZjeN6oXP0q3teH_t8dqFZH2BVITrcBNoO8ng1GBQxaEGRczQdzFxQwFO_ZoooE9hMl6Vw
 buxLSOsjBhnKCuK4lwXsDoEXhgpUmn5Yj0qo8by7nAiBEvWlptVjv5YRa1sRdd24qMwDxPZGJh0x
 OjXrAmdu8d.sId5S3dMcG0aAqCCDrMxAHBqPHtq98FEciUvUF0AiEv2x0ZAWCtUMj5Zunai6NMK8
 u6uMrwdQsdZLLRc1eWNMh0eVzMxtOLswFgk1MBLXqR4LbGdZQIf21J7X0S04lQ67y2_A_Bq2QQYb
 GZztWiePTYlQnBgE5P7lEjEYGpTEb8EuOFaCmo7EH3.FR7W65EtSwj2j7grU0WkgbYK9E9wyepOV
 QX05z.EYfToqAHFrmzqLNN0u68Lk2ElAx_925LNTVzL3VBoYXktMqyvkB8pRaFr8vxU4YlSE7JTl
 0Yhu2tpTw1D7A4G4GruTPGk6gem8OfPwCA6JSnPvhW1EvRZvdJ8vWN8pEr2HjB0mzqW43BjOVzOS
 KmUkCtVoI7WWrb65vCeoGk54Z2kWiqrxsaqm5ITmE1Ukhsed82.9CiUCfDJrx7P6Yf4DqTqgmge5
 D_nIR9LhSMXoSahi9T7u2Ovk_GVePoMMUBMiiSToOTZMCWNiMTxnutgBWp1xX49Jqpn0zZiIVB7u
 IPqTom9W_Dh4.gpjSe6r8mr1.SvpBgn15OhMFKEvey7lZUB17ilET8foyHX2UTwG4JHinRtlHvVQ
 kTmHuRq7s7Q2wHCup_3KWD3K7pMWXMZ0P7EUFKAMn5jfK_VgmxlfHnsQXQ.Xo.zzb4uF_hueO55A
 p4TUGLyW6e_QXx7g_uyR1vx5cvHPubc0sq9vx90W6mM71jlsQRFTWJcYQZmg9kAgINUuQa6Af4Jf
 ZSHiPr.n3OYygpMnh33FTwFppjlaU9O_F9.Dad50HVe3mabEkJcrW6rE4WedqlTG.VEMAZhf4Llb
 dLYK4B6O8wQSBYMQwJiTkmCcVycU5GCcrx2kdCXanoLM2pmmluit5vzXZX4Kl3BipPMmsvYf9SIo
 AQaqU7WRs04bXpliTzZ9BUH_upjbGNgGaT8wfUA3vFGmjG_3PiJizb2Nmp5aB2X53nNU2f.qXNn.
 h_T4.T2FeTRGQptzV1agsfNbbNtxdXvkIjevimDnQdHZjDmAMDx8Y2DQfP0KNQviHYRqonQh6IV8
 8surF7TK2NLudY7sIqy40N0DiwI6_ORECULX_VIVajOFhmSMUJzZOBnIsunZXHcsfAE5Q.zUMsKq
 g0WLomelogk2_RT5Q7veK3zDhfFlsGyjmfNYg1lPn97XiugFeJxyjTYGVzqL2Jc5P0_KL4TpSbVa
 agnfKUJ1ofWujcJ5bosxC5rjmwL5kzQ3bHeO5e9bQv5vEcL6lTXns0j8O.tPu009LV8e6W7MFdEU
 p4.LGofGLLcSE1gASeIWQj6uSZinGkmYFBFUo1O6Lhv83fp0wXtzb6a5iznmQhGD1LJGc29.4sE0
 cnwWE26MGGPu5IfU8273lfEPjTPrPLRrQtZugL55UmZhUYB2qh7C5hDA5jU1LvukiRUW77jn1kf_
 40emat9M_okifu3mVxSVyuAFitarQ.Z1FtL4eDQyyO.c.i1GTUT08c5GnVUTapkxasV388ZQuK0o
 7tHiu4SAlbYhH.Wu.FfPdZPvKz_rP2x5zTol.uUFviXhOrfEj2D1mPvJI_Qu2j8N8dOYB63NJCPq
 6JDNdE3DFzwl1IYLZGjHjjZJwzC5Srrsz.d4S1WfowpTUitCRLmWH1TG2yyDr3PbMoWRBNqIbx9p
 xXO7uYpGbuh0S.1ZUwrwAVsMFPpy1UaTtmfDd7V6CVwpBiKVJeR2hJMbyN3suX4kT4HUVeDjgUQ_
 YnyAf6CellcwX_rNXC30SFZwOD1FVrwU.l6.hOUS7XKI_nlVA7xD4ddblHpw0geIPugrEbO1RZwt
 U2wtbM19qBK3JQE9ViAPd3FgU7ORM93JJWEe1V.PLp8d950wAjPeQPPXb9TSxqSav4G7Eg.kVbAU
 25HjciPP2dNaFZiCfIuMymbnpvTZB7hfkYjLRk_k-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Feb 2021 22:07:56 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f7e0207a78745023d33a85dae7ffc620;
          Thu, 18 Feb 2021 22:07:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: security_task_getsecid() and subjective vs objective task creds
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Cc:     Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Message-ID: <5f8a424a-2aab-f11a-0e06-f8f075c644f6@schaufler-ca.com>
Date:   Thu, 18 Feb 2021 14:07:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/2021 11:34 AM, Paul Moore wrote:
> Hi all,
>
> When looking into a problem I noticed that audit was recording the
> wrong subject label for a process.  Doing a bit of digging I realized
> this was caused by the SELinux security_task_getsecid() implementation
> returning the objective security label (taken from task->real_cred),
> and not the subjective security label (taken from task->cred).
>
> Looking around at the other LSMs which implement this hook, Smack and
> AppArmor, it appears they both do the same thing: return the objective
> security ID for the process.  Looking quickly at the various non-LSM
> callers of the security_task_getsecid() hook, it unfortunately looks
> like all of them expect the subjective security ID to be returned.
> The only caller I'm not 100% confident in is binder, but from what I
> can tell it looks like they are expecting the subjective ID too.
>
> At least we are consistently wrong :)

We may have come down with a case of helperitis. 

> How do we want to fix this?  The obvious fix is to change the SELinux,
> AppArmor, and Smack security_task_getsecid() implementations to return
> the subjective security ID (->cred), and likely make a note in
> lsm_hooks.h,

That would be my choice.

>  but if someone can see a case where we would need both
> the subjective and objective security labels speak up and we can
> introduce a new hook for the subjective label, and likely add a "_obj"
> to the end of the existing hook to help make it more clear.  If
> neither of those options are acceptable, we could convert all of the
> existing callers to use something like the line below (assumes
> current), but that is the least appealing option as far as I'm
> concerned.
>
>   security_cred_getsecid(current_cred(), &sid);
>
> Opinions?

If the objective cred isn't being used in the access control decision
it seems pointless to add it to the audit record. If there is a case
where the task is being treated as an object, signal delivery comes to
mind, you still want the objective credential. So it seems like care
may be required to ensure that the correct value (sub vs obj) is
used.

