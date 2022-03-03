Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A7C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 22:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiCCW4W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiCCW4W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 17:56:22 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9510BBFD
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646348135; bh=txQQL8RfALDMiV61FfDVdACNKZ/Vr42BxSKsxY7Ad5Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cGfEIfUrexHUX/zJLT5HyPS+Jo0iT+odnJEDM+LKOA+cKzS93por5yJIh+Dt8fJVSTzAoUEfJrS7uGCC1P7UMhD17bfPlEN8Bw0Tm0wXIP+U1TfXgVDUJglArIw4N4qgx1jqJFta0X5QHJG2cmPlThg2dzlz/Ynb41i10PP+LjPmx5thDRueQqQSddy11gpKNQPKlvTDqapFF5vjjP3dyX/rF2ZomeqTzw7/GGEE4GuHB6s8M34zgtbquQTEAfUoaB93s597L+MY3Go7o/vzpkjt2moZUvFWSSazSHyxcLaz5nSajsE+E+sgYtZDwFpjbe9yh6k7JNSOYvl984Gziw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646348135; bh=Ixv1UVvJJBB2C66+x6GEHLlYlntMoNMH08qRwsUN+Pa=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CliUyLcA2EEE7DMh9dKdVT9O9MpYLjQTFP+o6wga3BVcM6c7QdzCap/VrNkULiXyt+xuTpDLv25Sy23oI20vQBy7nlwzLXRFSyEmJsIVtGXsCaqOPSniNQbtMoneIxDfcmUzV/+4PtbTJlR4dpek85xFiVgM/GFpvmyisqUHfhWs4o7F6L9BphgyifB4Kkc3Q0D3xrWMbNuH2nB7c8XICtlv3uH7pcx39UoBUOKIdg/PT++ezlTk1b+OuPFTxKD9zLq6nFoi5ylayh0RhGbGQEogkob6j9C4TSSTdGeUAGOtHHZ/ulcaLCXjK5RZNXqBUebpb+vrUNgYKZvW1YByXA==
X-YMail-OSG: JwuReBMVM1lihhBhbJF_moewY1V12YGD0KjDtnhePyKORKFFyFJtyABSN45LnSV
 KJuQSgbmIPCM1LMD_EsJbFlAeSWa35JTyvwFZtX4.ZFPtS_B44O_asRbZxzFHfJNBziLe0PR_dMH
 2nMoa.7uY77gq5uKODEA0miMnTDWPrEu9xNTqBeifsjexIKsDN3jNXgslyay8jhhUhKvelQCFZkj
 zXHR2mCTBbj76368wGs_GDwgWb7NyuuaKYUnHHnbm_JavKqTtED4f9ZsbjziJ.spjDvY8zwM2hgu
 MzSE420WCBrnwm1bTyRPgSOi9Huo8XGIqZPmzVZAFx.Bg.l70CCSKLrUPQnZWygpzRJgnrhkEXJA
 HbYxVHCSiFrSZH4owm.sQPR.uPGwhK4I7TigIlSU76OaAbUdZ2P6LsbbiczFkRMk18LVci8_oCG3
 d6FjNaSEjh2fkLOAuSnRelFFvxSBhBFJPL3.4_13UogBXIiwCpKIj4D0WE8TPK.yUoMf5Sqx53X7
 CoKDGvuPrn5qUGhcYCV_G6eXE3zx7jyoBZRAJRMPXFLkkohtm45LR11RJCHoUSSprIAl8E1l2dVs
 VwBRN7.pwowH0pL1fcXzTlHMJo6Cdsbym7NyADL7sUzo71rZioHQTsFM5ljs9O9hW_KpS93CKclG
 JZGI4n2p8K9GTuavyk4PiHHzkLVsfltlZLb0avYi77FOK1N_m4BC3wNhptDKVprBapAbwkc5MT6C
 SA7tcuvsvkbZuRPjwoEQV.sBW6sjvBUnvMl44ZuonkVY.8kLRFp0NPGdxMpfIaGrgCbk4QF.N.QG
 l25f89hub_VPH7wZVojblSnXJSYV052kdyH0ttCvT.NhCJ4mXfi_qtTwODL4sqUcs31WGG174gG0
 TZoFNQG2islSxkzv3HShcL6BMXw5EJRyAT_sRmCuU3VcJvKfi17drF0Atd4dAbhdVYCU9a7YTzN1
 m7iC1.uANjblYEipByMXX1Wg_wKbPVrq.vkxZ0QQdmXvnQYTx35bviF9.UG.SvbVdspUxKjRuHcI
 Mdj7RlV9sguMngaIu5wn3JA3K.n_jr_tu3tBGv_LYo12JOC.JUknlo3susY8CuhW4VFhspoR2.GV
 ApLJwK9kC4dOAIQEWYoIiZaM.yXn0MkqWIED0pja4ps3Ar1p6dAaP93R2KfxlBFMCKoIaOBeB9z4
 Af3gdCT_AW7q8ffwR0mMgn8ILR0R2oE3NSGVjYdBP5.d4oOMs3Kd0VOfRwxWJtMg0RHmGOqmSGiJ
 vxJ3xrd2tGTQpEFSMeX4su7tURk1SOvud_VzVwccnOsfCooA8eq9bWZiDNKnwsYb6Fl65.HTXtU.
 .KYLc5Ju_lqj1mbklrbyOLrwWPTYXhpGb.7Jl8hpJclJ14jv3worMP_4DzhLPIrEuot2MboQYQhO
 6eU7RsORoMSKaMn00Ybq5W4bMC_jW.AqAuJQF3vDPA2mY9GUeZr0utWNBPKL5TeBbVy6rn6R0Xgr
 HFmHsfJF62OSsuGaoYB4_jWCXE6frdGOKfFtlsyHNXEaxrc7LA6ZcveUtUALmZ.5r1YfsR.nyDe1
 r05W1jqo8jGLMtnxyk2ob1mqh.mbWVGH38cL4QqdpjB9MQriXHgVjbG2rGhIDKs0vUyK8HUyj2X8
 kwxRsx5hfoO82.RsxuByZEnxbciGomOCavjm44BtYpn4rxflQiUNgCL8fwGp5udQoPaTPANoJSiB
 pbQ6jHOcRxPcu002Hp60adG2ZM8Or5XEl6uxFv7tGhEiEPQCjepLDUR5MD0_6Vm77Hvt0zi6NcSa
 B7wTezATw2TQokHWofr51apCIj3T2ep9CWTkuy_NZlX7k9NE5tXWVol1muvBWtvosAJZzgKRwtvH
 dVGCFrVgzGbc6wkrD7h4VLi6WUp7_vDjtC0h2V1VbC5BVDDZmzjT1Wn9bbzlPkIMkQVSrR5sVBoY
 9PVNrw3Dr2D4xTqZdiGDHT_3dZT4mBknEEllrkKQwsedtR_6xekMsbXyCFEQys3wgzDbxTbsTOkr
 nYUDQZ6CQEmKn1_P9e2HsKgopneUso9uawy9jhYbf5UU4xsFgnHY3irkOx7UNRogZU04zATwteFV
 8G0IKXFSgU1uI60LcBRB8uZXrpu.IJ5h6qHnCs2XxzNVm28QRcH6IwzglO3ptru86JiF6N3npp30
 2eguHgsPueAaLowyx4OCf99l7ns7IlVrem_qQUw9A1pPSZ3a.QId52TyaALxfAngIwHiNEfsC.ks
 GoNHWIvPAh19y_8jMkwg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Mar 2022 22:55:35 +0000
Received: by kubenode527.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d3aebffee9441b7d99d276075a2f44a0;
          Thu, 03 Mar 2022 22:55:30 +0000 (UTC)
Message-ID: <c494f8c7-9b5f-2fd7-bfcf-b2cc70274310@schaufler-ca.com>
Date:   Thu, 3 Mar 2022 14:55:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com>
 <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
 <CAHC9VhSzaDJX0cxtorH0AvqUzSKsr0BSbhfGtHEJjFKDRWc7oQ@mail.gmail.com>
 <4e4ef3e2-ab41-12fd-5cd3-77abfc98c6a2@schaufler-ca.com>
 <CAHC9VhQ1J5jFTSJk-EFkdA-dbsjde7BoXJOX_2ZgL=usrpJ5Eg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ1J5jFTSJk-EFkdA-dbsjde7BoXJOX_2ZgL=usrpJ5Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/3/2022 2:43 PM, Paul Moore wrote:
> On Thu, Mar 3, 2022 at 5:33 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/3/2022 2:27 PM, Paul Moore wrote:
>>> On Wed, Mar 2, 2022 at 5:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 2/2/2022 3:53 PM, Casey Schaufler wrote:
>>>>> Add a list for auxiliary record data to the audit_buffer structure.
>>>>> Add the audit_stamp information to the audit_buffer as there's no
>>>>> guarantee that there will be an audit_context containing the stamp
>>>>> associated with the event. At audit_log_end() time create auxiliary
>>>>> records (none are currently defined) as have been added to the list.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> I'm really hoping for either Acks or feedback on this approach.
>>> The only callers that make use of this functionality in this patchset
>>> is in kernel/audit*.c in patches 25/28 and 26/28, yes?
>> Yes.
> Thanks.  I just wanted to make sure you weren't planning on any
> additional callers in a future revision.  I understand that things may
> change, but I just wanted to make sure there wasn't already something
> pending.

I don't have anything I know about. It's possible that something
could be needed when the stacking changes for networking come in,
but that's not going to come in for "some time" yet.

>> I think that the container ID record could use it as well.
>> I haven't looked deeply, but it should be usable for any aux record type.
> Possibly, but I'm intentionally trying to keep that separated at this
> stage as the ordering is uncertain.  If/when both bits of
> functionality land we can reconcile things as needed; it's all
> internal implementation details so we don't have to worry too much
> about changing it later.

Agreed, although I'd hate to duplicate mechanism if someone else
has an equally functional proposal.

