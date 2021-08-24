Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F7C4320E
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D761265
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 15:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhHXPVM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:21:12 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:43312
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238266AbhHXPVE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 11:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629818420; bh=uvaspF3UNTQaPEVUGSx2D+n2VNu547QObeQu/hbpSX0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=rLwjWGHUlrPFSgAGmayrXyVPkFJy3tuH1dchflNaeANbcfCw+IOhzoIDjODedI7yZMFkRUqvnkYnvKNkWb6f/MolHOcCbj4xMfeqcPl0KLvNHhRbyaVhgDOCJQzZmatG4AJM4KY5rybu4UH+fjFO2/3N3P32BKFwAxgQXveiLOtSqSvqDz5G2CgbvrewN3izR9IgjYqYd/f1ygKffs8TW97Ew1GTtpVI37RUzSlrevwTbe5nm14CE6n+FkkhoFMEk9wHZ6f30J4ukvLKreR+wvWKFX+xoy3TxNaK/TwKRNSgI6urUa36UWz12c7McnIsSZ25wJJli+yZF1DKLU3e/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1629818420; bh=3Bgf5nAE2e8Ykow5tPNKsycnXsReYkmVFEyprHkri1q=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=cz1Q0vYVs2UcVXokiwR7wIjIP8YwoRa3bHCEHzJxiJVwONy/gIse0RrDo6v3KnGGVPDPsQ/3b+NE6QEGsiEax/wyW5KqdcXXx3Ys/3G3tWMv7Ijs/nqHMt4kCGB11GO2jeyqpYG3vuVSPQMhJSWOwnqavD00cEeww9qAChJpctq7MpuNdFBMK5qZYNW//thPE8/8uqv+YCuA7NrKkuCL58rfFqeHI6MQ2M+T3L5Ay6pu1IUcft7HFWpcKTfXuXPb+fv8kanFoRH3IQbx5SRSr8u+l/wg8UczQF2PLrAPY+GFglvyGoaFxCyPTWEwGTs4OliFpwXTAIJPXyh4jhDtCA==
X-YMail-OSG: pvtToPcVM1mLfz1wp0DEMllB0oqgcg8nhN75mUWsHIW54dg1PSRr4Y27LOfLpIp
 hLBKL1_8AnxEAbxD7LIzGJ_BR0UTl4N7B9yrYVghnoLR1LjQq7Ks41O780PZyN7drcw2YfxR.R7r
 H7d9vHrOI5HkTiuMi7UDqipvMeeaKm1JIkU0oSjDT0FVsuyBD_f0.A6udhTXkaI2o7g01IxC.V1H
 J44XGB46ym41Z3FSelIKCSf7FjsW_z5NpRXn.WjUWtbyTCX64bWMReW7V0miwD8JUWO2ulaePGjC
 6RFAy2zwzsXjkpiRaSJAGbiAaR4QLwD5PysRPqVMMAArfSyDXOePjvtYFupsn4WNbgBZ.DOvOGXo
 G8BU9idxKKnN0c0PX_19dLDbkf0y3PMfNd3W4uCMi7Lz8PgYlcyXDSzc3nilu1sIliWTOxbO6rZO
 xSSccD3O6hkVXUDt3yo9XDZm0MlE6Gl_D1FjwH0oNsWdAwf0inccU5XIe6Itj_JTqxX641_bzwFA
 aUqcFTNhD8vHfMUnyUWMGOyylEPCcyHhroer_YGhy_fzzO1dMgsF_cNkOfEsabASzObC_aIzSR1H
 M1Jwax9PIWtEQi.NBtfYnCevsrzQ6OaVU3tCtp_7OEIPpQ15lY1RLI33FD6cUZYArnfxtl1c4f9d
 k8ckrfTCRtiriDt8WAy_QUmPdj.F.tDC0EsxZ5qjt72XNimZZy95DbKDD9KnaxvEf1rx.EHOuzUw
 9j7bGOV.vlYBHiYqDIj7gGiAx9vEhOZDHxqM65a0fa2S29l1cIdyC0qufgPg1w5_U2RDfp.4XO1K
 Dcb2w73tpUB6BTzu14yF1t95VU7zCYz1.A32QgO35FG3f1_7U1QohAUN5WYK2_o9hFDLLm7z_gfj
 m3sYtdC92H9zFC.tpZaiQBT9.x_FTH6.M0dRKP6qvpEbRrHZwzLmpErYDkCCD7uElDPvufRWwcA.
 Yqog1gDyiz5CFuQtQV8lFNV0XbJfAZ7m0MxOmBA5h4X5FL6zUCbMiFyZBehEXfdyJT1Ags1.OyMu
 8lsXHI7UKxB3mwDa4d.mI3m_l1FRcVRxejTZQ1jFQkNXmMZRn9_DOvJ7OA_mUu0KkXpKDkiqpiTW
 7WCTyJuSyvTAIyJahwhw24m.tBw29nE2qwU0_Hb0GfReN7vtepCwebxEx0Lsp36YMbUC9_E0pg89
 g8xseNG5m1QuszijqQmfW1ZSJuw2zp5SHoNNGBRpmCAJxV6eHXBW4_6wlO92U56dfDMPNa9ADPcs
 XVyUUVtXAyKORQIqAxNuN5c9cHc5a.cKIRVjvNxAppzsP7CQL8dQcsMIhPGcdRQ3DsQaPYbW9ayB
 7fQZOOEEt2rkpL2IdoEVCsuH9ltEZxebUqn5jjZanPY50S84YhkOE6F8EfysylKGJXsaWNyfu.m3
 _l_9U4HJoyTOduCuEMDjN7JgsJc57ILi1Dx7pLk1QinYTdbYVcz1hmkQm3MLUpHIZfjYb04cOi4o
 p5iWmZFsbsxwukzLzZQjIcjR4igEGUvzolgBoPNi2Qktzx30VrSQwhk25JFRR37e59NRhZIFdvRI
 rDhMOWncHwkVgLf3.NKKfDjv9o0MsJ3ToJ1oXT3nAVE2UTHFpJN3Qqut6SguN.ohdgwlX_WGyiSv
 6z5EgjYtAiBHMt8PkxOY0Ri_6PpyTC4qU5MtfMjDWM8RC.lfGAr97PrJl27756rrmFaEPZsC3AoE
 5lylI4_Gf0uKWx0g.pBSEOJEUoehEnZymNavsFOUsp_1Zv_ctHf4X.rd4JhYcs.U.sIu2gbiK_BN
 WBNMrB_fd6s9GIBH41DpnQLntAj5WtD5C_2GdN1s1Gjiu00PJBXGcYPb88mky3Wv9QukJe2ejuEC
 lpjHNwo3_cc8i4oIMNK8Yd1HImnVlqa_ebRibphEHyU1QC56LHtnwadXRQ5BLkaV5IS6nAweJSUQ
 huDPOvC3vOOTQzigNskhMWwv9orIL4Z4huqQZ_q7G_vpR5jgTzSacPYAMiSuVt8eOJHKm4LxivO2
 V8mROfsVrSIpGx5dHxlpp5zlhnUnGXASGryvnrCvq_.r2bzjDVDxBd7Q0kUn9p7GACC9hOLgPtRY
 DPi0i7pefGilT7bcc2e89XlQk_OPSFjLCmb6A.EDRJh01.wjYxRq9Lx.x2fbecpr8W7Yba_xZQHY
 Pgvgetus8epw.zkmwvPZei0kU6kAjm4BmF1Z2EF25oqG83WWw.nbZNPr6IWlJg3GKEZmgN4QiloS
 Ukth1FOJW9g5Rk0qatOkYaJxQhW85x6HvtQ6OrGuJS40pDOVez3H_Vi.RtQY003f45rvz2zKFCg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Aug 2021 15:20:20 +0000
Received: by kubenode549.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2f120471ee9629852333106d32263ef9;
          Tue, 24 Aug 2021 15:20:17 +0000 (UTC)
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM
 attributes
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com>
 <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com>
 <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com>
 <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
 <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com>
 <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
 <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
 <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com>
 <be20e3c8-a068-4aa2-be52-8601cf2d30a6@schaufler-ca.com>
 <CAHC9VhT-MfsU-azbV4QQ-asQFqdCG8fAeB-BOV3MKAdtSOW8Nw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a44252d1-6a96-def2-e84c-2faec643f5c1@schaufler-ca.com>
Date:   Tue, 24 Aug 2021 08:20:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT-MfsU-azbV4QQ-asQFqdCG8fAeB-BOV3MKAdtSOW8Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18906 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/24/2021 7:45 AM, Paul Moore wrote:
> On Fri, Aug 20, 2021 at 7:48 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>>> On 8/20/2021 12:06 PM, Paul Moore wrote:
>>>> Unless you explicitly enable audit on the kernel cmdline, e.g.
>>>> "audit=3D1", processes started before userspace enables audit will n=
ot
>>>> have a properly allocated audit_context; see the "if
>>>> (likely(!audit_ever_enabled))" check at the top of audit_alloc() for=

>>>> the reason why.
>> I found a hack-around that no one will like. I changed that check to b=
e
>>
>> (likely(!audit_ever_enabled) && !lsm_multiple_contexts())
>>
>> It probably introduces a memory leak and/or performance degradation,
>> but it has the desired affect.
> I can't speak for everyone, but I know I don't like that as a solution
> ;)  I imagine such a change would also draw the ire of the never-audit
> crowd and the distros themselves.  However, I understand the need to
> just get *something* in place so you can continue to test/develop;
> it's fine to keep that for now, but I'm going to be very disappointed
> if that line finds its way into the next posted patchset revision.

As I said, it's a hack-around that demonstrates the scope of the
problem. Had you expressed enthusiastic approval for it I'd have
been very surprised.

> I'm very much open to ideas but my gut feeling is that the end
> solution is going to be changes to audit_log_start() and
> audit_log_end().  In my mind the primary reason for this hunch is that
> support for multiple LSMs[*] needs to be transparent to the various
> callers in the kernel; this means the existing audit pattern of ...
>
>   audit_log_start(...);
>   audit_log_format(...);
>   audit_log_end(...);
>
> ... should be preserved and be unchanged from what it is now.  We've
> already talked in some general terms about what such changes might
> look like, but to summarize the previous discussions, I think we would
> need to think about the following things:

I will give this a shot.

>
> * Adding a timestamp/serial field to the audit_buffer struct, it could
> even be in a union with the audit_context pointer as we would never
> need both at the same time: if the audit_context ptr is non-NULL you
> use that, otherwise you use the timestamp.  The audit_buffer timestamp
> would not eliminate the need for the timestamp info in the
> audit_context struct for what I hope are obvious reasons.
>
> * Additional logic in audit_log_end() to generate additional ancillary
> records for LSM labels.  This will likely mean storing the message
> "type" passed to audit_log_start() in the audit_record struct and
> using that information in audit_log_end() to decide if a LSM ancillary
> record is needed.  Logistically this would likely mean converting the
> existing audit_log_end() function into a static/private
> __audit_log_end() and converting audit_log_end() into something like
> this:
>
>   void audit_log_end(ab)
>   {
>     __audit_log_end(ab); // rm the ab cleanup from __audit_log_end
>     if (ab->anc_mlsm) {
>       // generate the multiple lsm record
>     }
>     audit_buffer_free(ab);
>   }
>
> * Something else that I'm surely forgetting :)
>
> At the end of all this we may find that the "local" audit_context
> concept is no longer needed.  It was originally created to deal with
> grouping ancillary records with non-syscall records into a single
> event; while what we are talking about above is different, I believe
> that our likely solution will also work to solve the original "local"
> audit_context use case as well.  We'll have to see how this goes.

I'll keep that in mind as I fiddle about.

> [*] I expect that the audit container ID work will have similar issues
> and need a similar solution, I'm surprised it hasn't come up yet.

Hmm. That effort has been quiet lately. Too quiet.


