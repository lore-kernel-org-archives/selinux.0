Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D066C282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 00:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEFD262C2
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 00:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QrCumIla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFDA3t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:29:49 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:44510 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbfFDA3t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 20:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559608187; bh=6t4kaBeGhDyLfz9rAWmlt+HXvekIC8wz5gerx4NtOQY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QrCumIlauHtve/anpQaQ8KxL20ECjglfDF04E4Ihdk3W5KprP8hSKLyNK3Y4/YhC4jrHS/21GDZaWW/HkxjaCv9IaiIU2bghrgA2k+OSKEJfGFxADcMuqxD6bCb7ARMFtJGRNcCrGA69ewbab/+aO24i7Sri1PwkFaA/BlpIwvm7zDOcRFM1rzS1o1LxZO8mskKLZOaLxDkdvD2zyDKhZKWteEwZ+l12k+Cj5oj4AM5yKfatyj+nsd6eu29DrLqQguZh4TtAzFdj24jaRKTuCop+IzUVlCHndEHLChfgRfRekc0Avk+I+J24zk5B6XWNR/peCI4Zl5lWSGaBzitB7w==
X-YMail-OSG: nLybL9IVM1kPECyEPZF32LmOQ9HQJkY3ntfs.B5ifqPMX5B1ZLIrzftllIqetti
 GAnDnGB2rp7loth7f3boyn33ONz7kxIJjElznZkv4doS662PHtOknbYAeO2pRK0jMsAXoBzmCxGo
 MO3Y8hPMwbTf04XUbBPYe7Wb8EmIQeji0uW3OyZduWW7D5z.cA0pwv4WF57tU3vwpceJOh8RTtaX
 O6owNRloXsB.N3jsamx9D2JOM2lhUVz0cLC1EeNHQy83Yxy3aiBUW7vAoBchRJtpbgUmL095kPzg
 nayLjHzNCKjh4ymCrUTLbGM2YTxWIn1iptfApitRp_5kdei4X5vuJqVuOD3pAjAeIAgoMsrqR0A3
 K.AjcXe.Pr42.1_z8482yurgPk5NW5420psshheYLEs5RtbVSwR4BrUZZ1d8006QIUSuNlJKHd.e
 iY56RfDcvajCCNL6ax3Th6lFwmkQODgB_vYcpYDzrCBl00HJQWQQptbObq27Bt9mUgl1u19MHnyx
 OD_o1BMGFwu8fqe24HJrXXzRvb.quaaZOsEBtQ1Vd7mt8WyHAGLHBOQ40nk4oQuxE2p_Vcw.vwDj
 oQUjzva77OZvT5fBtNMsWnncsjEjcwXdBGj0X_z7qmJdzpnW9Rsx5t9SXRUE1eKBt5qW.accRwd7
 hXRURBMTJU19R7ssNliePA.XTIxutcdF1el3OLv6KqYhH1.JzqhH7eZnyUvaB533TqJIieoiX8s5
 07da5HYPHkykNtYTKOo9zNjCCY.dIr1PSN9c_Rnxh.YS6h6YRbvV9zlGIbxELwSacuK7EUFgEf61
 4MA4XpaH1b5THn6PK5An1_Uz3AIJo6vB8Je0M1IjBX7aiicPTnJhqQan4OGy0XM6rfb7ipUDkoGc
 WvSMfhlEFwAnsjDL8jLZEXVVpGSVGWzO1OKHDgLr3lmyWhY.On5uyZN1LouPvyZhNcvtRy94m05m
 iMpuleH.8dB14pF_anth7YkOJnxtglQWroRNoZBRhAv7NlI7bnTrrictce7gdrVL7BHmpGxM3pId
 kySUZeJtJg4YLEpadg2L2IJP5t0k0R05Gkd93z6NkWUrCQHEfwXtTmUuLwFlWRONjlqlDRIwdk7Q
 v6D3U4aRiuVE9PW1GpXWcNbwuahM1Bv0l0I.IKiBYjePJ0tm2L0a4rwmHMwq2SicUPD6P1lFS9FT
 Jxq6zteDZyw_wnSAQO1PEkLM3YKpglv0XbOMZlVWWhdbpF5hrwiiNgmD0o6yVLFt_85KkRgHfMNp
 XkXazbL9rWZvO5ELP4g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 4 Jun 2019 00:29:47 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0fef4bcfb9cb6f5982997fe87fae2d15;
          Tue, 04 Jun 2019 00:29:46 +0000 (UTC)
Subject: Re: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>,
        casey@schaufler-ca.com
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-6-casey@schaufler-ca.com> <201906011845.96774A4@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <46c5cbbb-b703-403f-96dd-d90f49d74e5e@schaufler-ca.com>
Date:   Mon, 3 Jun 2019 17:29:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906011845.96774A4@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/1/2019 6:57 PM, Kees Cook wrote:
> On Fri, May 31, 2019 at 04:09:27PM -0700, Casey Schaufler wrote:
>> Convert the inode_getsecid hooks to use the lsm_export
>> structure instead of a u32 secid. There is some scaffolding
>> involved that will be removed when security_inode_getsecid()
>> is updated.
> So, there are like 20 patches that all have basically identical subject=

> and changelog, but some evolve the API in subtle ways. For example,
> in this patch, there is no mention of adding lsm_export_init(). I would=

> expect all the lsm_export infrastructure and support functions to be
> introduced in patch 4 where struct lsm_export is initially introduced.

Fair enough. I didn't introduce helpers until they were used.
I hoped to avoid the "what is this for?" question that can
come up when you add functions that aren't used.

> Instead, various helper functions are scattered through these patches
> and I'm left struggling to figure out where things are actually
> changing.

I think it's possible that the patches may be too small
to contain enough context for them to be sensible. It may
make things more obvious if I combined

[PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
[PATCH 20/58] LSM: Use lsm_export in security_inode_getsecid

into a single patch. That would reduce the amount of scaffolding
that has to get set up and torn down.

> Also, I find the helper naming to be not easy to follow but this is
> mainly due to me repeatedly trying to parse the helpers as
> noun-verb-noun, so lsm_export_secid() kind of makes sense ("write to
> secid, based on the flags") but then I see smack_export_secid() and thi=
s
> is "write to the internal lsm_export storage, the value of this secid".=

> The direction here is what ends up confusing me. Which direction is the=

> data moving?
>
> lsm_export_to_secid() <- from lsm_export to secid
> smack_secid_to_lsm_export() <- from secid to smack's lsm_export record

The inconsistency is comes from my use of "lsm_export" for
the name of the LSM data structure. This is something you've
commented on elsewhere. The underscore makes the function name
look like it has an lsm_ prefix, rather than just being the
name of the structure. If I changed "struct lsm_export" to
"struct lsmdata" the names:

lsm_lsmdata_to_secid() and smack_secid_to_lsmdata()
would be more consistent.


>> +static inline void selinux_export_secid(struct lsm_export *l, u32 sec=
id)
>> +{
>> +	l->selinux =3D secid;
>> +	l->flags |=3D LSM_EXPORT_SELINUX;
>> +}
> Which brings me to another thing I find awkward here: I feel like an LS=
M
> shouldn't need to do anything with this object: it should be opaque to
> the LSM. The LSM infrastructure knows which LSM it has called into. Why=

> isn't this just like the other blobs?

There's a lot more rework required if the lsm_export has to be
life-cycle managed. The audit code, for example, passes them about,
copying, storing and dropping them without a care. I'm not completely
opposed to taking that on, but it's essentially a rewrite of the
audit LSM handling. The SO_PEERSEC handling probably has issues as
well. I think netlabel would be OK, but there's stuff going on elsewhere
in the networking stack that isn't going to like anything it has to
worry about allocating and/or freeing.


> Anyway, I'll keep reading maybe I just haven't gotten far enough, but
> I'd love some help in the 0/NN cover letter describing what the
> evolution actually does through the series so I can follow along and yo=
u
> can set my expectations about what I'll be looking for in each patch.

OK. Good feedback. The next batch will be better.


