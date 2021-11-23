Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2FC433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 00:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhKWAnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:43:50 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:34977
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229619AbhKWAnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Nov 2021 19:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637628043; bh=44/hrcQ5OR1zus2Q0HJWkZ8d5wsr0BiaJJZXF/0H8U8=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=IncYZ1CvDar61R+gGmL8gX/uBIEEgx7aSP0/hxkInVpjGfEoqqWQvAaPlaJk79cHheYCnavpCL64RkTTA7jjqPcRkiXDTVCVa972t19stiXxAQJM5O4ScKlgu5BdDATFTsVEy6euDw+a7oQ1iXM11AKD9/OsG99mm/mqSIroa/57ZRDVxPUbSp12TUUlgaF/4fiXSdLMwamKt2TLXJiiY/fW1wrsLbgXys3WUDYO2OHH8GcjkgFf6u0474VXwILeTXFnL3F9HHZ5/m5xQUVBsWJoU1tG9JOi8L7s/PiiQmCQbCqxRwj456dQRPlb1cnhGHzOmLZMQJns/aLDyB1E0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637628043; bh=xNmgN4skPXEgZbi2tBbtEoN6mAl2SljWlCCpBLD/3MS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cjhNrsAvzAwzflXlT/i4uBnT/AizvOr3ivOBt2tu4jqK7YBbv91k2wBaEl5w8QIP+RS3XMSKpGOIOvYQrCqI8y/m1VKR+eGpVyRku139S/eJ/0idQnT5h8fO8jVm01Oy64BC9TsZgCDEHIG9hLWp0ZHc0it6c4J9fAie8o4YBdNtEPUSJbyhpcM030LWdEKN/+eyyqrbD3of83l/cmy/ZCn0GzlnEeWUDM24GVRVSywdcCpUQqAxaU/7yUg+RA3B3AzQD5waa+cKbmD2rXNan+qNkrB6DZfV4zvDvHFwKLOrGTEft8mjb9c+Nh1zAJ8y9dU4NiwTcwdzgErWP64xBg==
X-YMail-OSG: MRKK4AoVM1lMoYuPdWrEsPkUhvy2Cajg0b8MWpV.lMVScVXQ0MxjaA9xrE5OzF6
 RTXjirNZ0WggcZNA7brnLWJbqsHoky2qTfOTu4gYI6_Ccz1llFRBkSzefsI708iGd6zUE_81FH63
 Vis6Qh4qA3fa.1IEBC48oQ3Guj1st4UdDSULu_qKAd8tNx3vKIOEEH6ekM8hlmL5uFJD6QPLXMWo
 xQb3bcOIBWq4cpsXtjz5pVB.zO05x81hwZnvRuH6Jf_LfvxxBh9fV3BB5Bz1AyoqkyAwve.11u8m
 WZsdQ7pOHWImWW9TGE1vTfVHnmK7PPLocyYlIpLK9LfULCXjLExqeLEWI1ZzSfJP6Xl1KTg6p7.d
 1ksuxMv_.H6ngNkrBRppfr43ir_vDhvhNX0ElSt.lsHQWj8RNGpNUPhmmBDIunGIpUjvwKIuojrb
 .3HdEFDiSvoEX1GfYpXaTt_DpB_LflT7am5alToG4vs_a5FoGvgPPdVxqSsdms9pW6HVgLp1Olif
 GnaetJW7RRpM_gYuGXThVsTJKSFGaCXVktzyFzFI567vqQz2KWkUGkO.1X9_7kYHQO_VqMHFnL7f
 _SWjnRgVhZKIVtDfmVVJrECmtXMPfIp0onWcI0I4JxXQPjGq3S4oNPggrWIzKUMPYPePD7CJ5KMW
 N4FPikjnrxVlKMQbFU99mv718omEyBR00eXU6qbmfT06aMFwPzHWDXBfMn63zYgb0GV6bJYH9f4E
 l8d0ykk4.fHOI8gci2fdmZvbEHryjzTgWolCXtq7FBTdVF3kyoXYsiPrgn8ok9unrjit4._ancSQ
 E7D0n.0dxmFFFYMiYNRsRswu2xb5tplLCoZrvgIsgxSjg2cq3GoYhlHjGL3rteMKbMMCrkkSCMW6
 oMH2DlnkD1wPUe40haoXTEsMyNyRpKIVhSl_9rIPLcccQ7FDRSUk7a.mIp1OQ0ymO9nYdd.P9C2t
 kQ_Jwb60jBAsvYuhgTubNm7dR17VgKIf0pXYmVhAEVKouVMqMvL94UXSf4e9J0.iIKtbM3yzv8gz
 4ITl.RXyhdqVDKjF7Wr0fhPqyQk4XvZRXBS53R6ccNY5DZdUN5D1NmFKK53Q315spDRs3EFz9XQP
 bXnA3xgAwn.Kdi4Pjfrt5xe_GhzXiH.h5ZVK.XrFOAx4gTFyftEJA7oxdCeiYpe_sjaLvEJDXv0o
 o5lw5LcWi28JMLFEPMknPxnC8IQTS2NPiQZkbPC9gGPFpEpvhxW3rMzCIJGN_fOasVaxoIayGH_M
 kg7xLP4DqFmRzi6ltFpDaG6M_SELKvToB7QVwhVl8yHLIbIpex.wgjLcrhfY2FNipiemBuZSwisa
 z7Ila7iJP34xUjncKdYfeh1EvDgPlIfOmqt.xNaiyTqxXwBkhbsIdjetiJoPTNkwk.G1hYHI35W.
 A.ddgEp7YjRNcu.vFLX5dH5BLY1OhpsOmPXFAidcM1ykL4ciT9tkDlkmz91T_eTvLoTwRbyEKROD
 4MJRCX._Y6WY8y9Gf.JVSor9090gESMJ1hfhJADP4HuPnmKxoXmxCgUhzPNtiPGEkOkLmdjelTJA
 SqhQZK5QQyQYH5HQiY2NA1QV8o0iQyphu9O_tWYuYn315cJAGnpPWQj5fD_3aco2oloS.eIY8ahN
 JIn4fF5lwlxVQCNnEEKb4AOqFHZqnfpNBedhXQxGpDm0e_sUyk2.U_425fomjPWSsVYtZKPUf529
 NFb_2N8DIiCsifZxQ_q0y0K5.4IfOq.VIn01wcy9sTQzQplIxQONuZ8a8bBNfI82qoTUI2wsQuEK
 l4HkpIP0ZUIKROlkk_0aoxZvGYjx6u2CpEhIpIkmPwo_4bAy3lcfzr8Q4sSNVo8edugkheRncgem
 oR5ZdFvEdDFSoha0kTQ8IbjrTT_Zpm83GNxu5FlOdQf6g_lkI9YwrSWlTEUt5Tpm3dqFcQiHJQGB
 HhqW5VdQ8LN9p4KvWntZxkXmlVTAFC4HGePZpEaIVbHZhLEtFkQ3Vlfs2INOhGL_Jzgb8Amta0ok
 tjB.6lr_9J_06IVmFrXF_pgMNZOGIcb2P7PS7E8K3rr0orhHOnCOLYI1nvnR1FHR_bCK4M.Bc48y
 zGKaaaUdd5sr2xVt4e5U7oGMgID6jGGvLa2jpf5su5ZhuPk4HZKgFeK6gXo0Z6n7ZHQHG9qp2TFl
 XBQqPDDkR3cXDuGTL3k.2dB9WT8qC8YeSVOon1ZW9.kbcZVfy6bo_7.Qc8I8L82kkLJxyq7hJL_6
 AN9C.Rw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 Nov 2021 00:40:43 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3d9229986eaf65b3da5088652c338bc0;
          Tue, 23 Nov 2021 00:40:41 +0000 (UTC)
Message-ID: <ec1fa864-6611-41c8-b405-41e3d713d590@schaufler-ca.com>
Date:   Mon, 22 Nov 2021 16:40:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/22/2021 3:12 PM, Paul Moore wrote:
> On Fri, Nov 19, 2021 at 5:52 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
>>> callers to specify a task even though the hook is only safe when the
>>> current task is referenced.  Fix this by removing the task_struct
>>> argument to the hook, requiring LSM implementations to use the
>>> current task.  While we are changing the hook declaration we also
>>> rename the function to security_current_getsecid_subj() in an effort
>>> to reinforce that the hook captures the subjective credentials of the
>>> current task and not an arbitrary task on the system.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>   include/linux/lsm_hook_defs.h         |    3 +--
>>>   include/linux/lsm_hooks.h             |    8 +++-----
>>>   include/linux/security.h              |    4 ++--
>>>   kernel/audit.c                        |    4 ++--
>>>   kernel/auditfilter.c                  |    3 +--
>>>   kernel/auditsc.c                      |   10 +++++++++-
>>>   net/netlabel/netlabel_unlabeled.c     |    2 +-
>>>   net/netlabel/netlabel_user.h          |    2 +-
>>>   security/apparmor/lsm.c               |   13 ++++++++++---
>>>   security/integrity/ima/ima_appraise.c |    2 +-
>>>   security/integrity/ima/ima_main.c     |   14 +++++++-------
>>>   security/security.c                   |    6 +++---
>>>   security/selinux/hooks.c              |   19 +++----------------
>>>   security/smack/smack.h                |   16 ----------------
>>>   security/smack/smack_lsm.c            |    9 ++++-----
>>>   15 files changed, 48 insertions(+), 67 deletions(-)
>> I never saw any comments, positive or negative, on this patch so I'll
>> plan on merging it early next week.  If you've got objections, now is
>> the time to speak up.
> I just merged this patch, with the AppArmor tweak suggested by Serge,
> into selinux/next.  Thanks everyone.

Has the security tree been abandoned as a path for general LSM
changes? Except for the initial Landlock pull and a couple touch-ups
to capabilities nothing has gone in via security this year. This
change should have gone in through security, not selinux. I'm glad
that this change is going in, don't get me wrong on that. I am
somewhat concerned about the LSM infrastructure work I'm doing,
and how it's going to get upstream. The diffstats from that look
a lot like the one here. I seriously doubt that taking the full
set of changes for stacking through the Smack tree is going to fly. ;)

