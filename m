Return-Path: <SRS0=gxH6=VP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8370FC7618F
	for <selinux@archiver.kernel.org>; Thu, 18 Jul 2019 18:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516DC208C0
	for <selinux@archiver.kernel.org>; Thu, 18 Jul 2019 18:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LFW68dv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbfGRStC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:49:02 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:39856
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfGRStC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jul 2019 14:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563475740; bh=AhvbTBfSg+6DHkVLYrqc7VAMMYYjVOaarm1zPRfg3Q8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LFW68dv+0G65MP1MGQ3poIKBwCvtdaz67WudYTkZIMI4w4NX7tN81hNAQDeA12MKmC139Y5XDrezwJhv2OF0r0eWRaRqOeiSW9k842vFDwDmmjQ4KDstF/69VPj7hVGMDjCXTnmdqHIS8VQFkPQUj+OfzvrLCCiK2ze1OxAXD7ODSis8XHDbP9mnY4heQN+cJdhpfQiyHHnHzcfYkgNZyBv6+wYWeaXOSQcKoNgQslmhm+UajSP2eiBgb8uSZyGnYJuomfusvUlvHE+XF1qAJCjSrCT1D+ajFiaBO2N4QQHAj5cyBRpHP17l5dzanKWPPUwr2j2P3xly5phBjZ9LTg==
X-YMail-OSG: SQQTOdEVM1nrmVotLc88VGZz99G9muOJhTKU5lGnqlDbq0OS1805lEGvQsTxhHA
 UTQoEEdPFHmT8dIZvcL5hx9izYZ3bj8_OBDuFsO_EQKViQIBJoGFZd03LkiIRzuqRWLoWNeGsop0
 RF0qXG.WqUHjzyXiOal.2A.nWURiuieWU_NyBp.yVMk2BHmZAfAldLlpr7flEmWKbSirmeXCWeLb
 GLc03xyUs18O6CLhvX1xWrjeW.6W8McIuZT1KlX106mbZIn5NGalGdqTfdgRvk4IyNXc8.iFiU9g
 Tn7yhl7hElKza47cKuIH8b8mGIobIhiHypW6P6ydLyEB2NXSG5SY5Zzu36AEsCV8mX3JI1VjTifB
 qTI934zdvIXtItaZQxH_tWdV787oFipvO23LCq6A6FlXr0Qq4m4bzDeFqxsRkmaVX6.n_68O7mft
 QaP12x38j0TUxFAsQ9JBNZkQ9OI5jOe.pURbZzh6mzoJF6REQJBO0HIo7TsNI2cm1uvvB2OFq0cC
 Wvtxh89.iOOzIf.CPlwuQwXwu22Ox1nV4jNSbwbwYA_9QN5JHHutE0EjQl6B.syFEcLar0Aq9SJ2
 YGVseaTQmBkCS8cAFhcOnrJUCWBGlRH9eq55FJ03txwk5hA1Yr90lakr5sMbJLE76LIhIkXQSfPD
 4rSFRD2aGLoHs0D5EoMA1fwUxrn3K7uDDIrHre_2lgyy5.hhSp0WxrXwooRltt7giPaDwY_WMwcj
 LcysVrz0tGQR6FRwfCBiQh9t7GfKOqYbcodklLf9NLHilkPtGxh_DCyDDiWT4ZxKKD92NbNX8cGn
 F6DB1mkJwj6GZo4uNCmzt8_Q_EbTvM0AKUXZot0AanuHqnCNxNdvAydrUjwytz6iS93iczEG51nu
 RTxGaB.g8uI1i1UOOI35tiqYd0DQQL..GQoP1iQLL2OnbGIFn7WcXWZ5nL17TXCXtzb3q1n3mgLw
 x.eeDCf9OtuFByiyTpxS4VurLyU3EIyeX1.9LlEJm6X3sNW5.j4G0RZzGtj_34WcmDp_cK7Y6RpC
 pdUeUoj2ts.YiyzTpss1a6l0nQPUDpbn_iA8RODhqfQ1JQOgCIQTw3u5t8srUY0JLRvEewfGsn8T
 NApDVjp7eW4vjFGr5VgN04f3kcEzBPkeThPRFkCGG2yw9OrfXxp4c09vpHmUH_rQPrBBbRrBOc9A
 yRIUyaicuVd8nKLLHJjCkOULfN1UHJEU7FR67.oidFmTsMvw7fgolxTC2VbkqTpyMw1MBtv2YV3z
 NrMQyZWHjk3cjE9YlkbNilrg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2019 18:49:00 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7fd616ac565311b3266d2084cb8770e8;
          Thu, 18 Jul 2019 18:48:58 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        casey@schaufler-ca.com, SELinux <selinux@vger.kernel.org>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com>
 <CAHC9VhSTwvueKcK2yhckwayh9YGou7gt2Gny36DOTaNkrck+Mg@mail.gmail.com>
 <2477603.130G60v5SE@x2>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <CAFftDdrX2Y9Lr7Wi7jvrADTYNup6djc+1EFMHjFJzO0VSJ_Yeg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c5d0d6cc-16b8-bf6a-c24d-19e03889f6d8@schaufler-ca.com>
Date:   Thu, 18 Jul 2019 11:48:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFftDdrX2Y9Lr7Wi7jvrADTYNup6djc+1EFMHjFJzO0VSJ_Yeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/18/2019 8:01 AM, William Roberts wrote:
> <snip>
>
>>>>>>> the following (something between option #2 and #3):
>>>>>>>   subj1_lsm=3Dsmack subj1=3D<smack_label> subj2_lsm=3Dselinux
>>>>>>>
>>>>>>> subj2=3D<selinux_label> ...
>>>>>> If it's not a subj=3D field why use the indirection?
>>>>>>
>>>>>>         subj_smack=3D<smack_label> subj_selinux=3D<selinux_label>
> FWIW +1 on this approach.

Stephen Smalley's original objection was that subj=3D<context> used
the context from the "display" LSM, and that unprivileged users could
change that. Paul Moore suggested using subj=3D? and supplying additional=

subject data at the end of the record, using what has evolved into the
subj_<lsm>=3D<context> format. Steve Grubb points out that searching on
subject contexts gets much harder using this scheme.

If instead of using "subj=3D?" we provide the context used when "display"=

is not specified, subj=3Da:b:c:d when the first registered "display" LSM
in SELinux, and add the subj_<lsm>=3D<context> entries, we have a reasona=
bly
good chance of getting the right results.

User-space code that does not understand that there may be multiple
contexts will get a consistent set of values. They will either be all
right or all wrong. The irreverent side of me thinks this could be an
interesting fuzz test case.

It will be simple to change applications that only work with one LSM
to check if they can expect data to be from that LSM in the audit records=

by reading /sys/kernel/security/lsm to get the stacking order. That
can be done in a wrapper script.

A script could easily replace the subj=3D value from an LSM you don't wan=
t
with the subj_<lsm>=3D value that you do want:

sed -e 's/\(.*\) subj=3D[^ ]*\(.*\) subj_apparmor=3D\([^ ]*\)\(.*\)/\1 su=
bj=3D\2 \3/

isn't quite right, but isn't far off.

Applications that are truly stack aware can use the subj_<lsm>=3D<context=
> values.=20

On a "well configured" system (e.g. out of box Fedora or Ubuntu)
everything continues to work properly.

If AppArmor is added to the Fedora system, in the module list after
SELinux, and any applications that are dealing with AppArmor
understand they aren't "display"ed, it will continue to work.

This also works for Ubuntu, where SELinux would be put after AppArmor,
and SELinux applications would have to know they're not "display"ed.

I'm ignoring applications like id(1) that make explicit checks for a
particular LSM rather than handling the general case, and systemd or dbus=
,
which extend kernel policy into user-space. The topic at hand is audit,
so let's restrict the discussion to that for the moment.


