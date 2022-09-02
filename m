Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500DC38145
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 23:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIBX5c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBX5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 19:57:31 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38408DDA9A
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662163049; bh=DHdoJVj06/18+5iHf/brrxOgHnjQxsi2kDDipOsvsmY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mxkQq/V3rFjqWgBamrOniPnLpXNUPROsfIgmhHuANFxfA4tgzNqBASudcOPYa3FT7M7B8iCOg7+2G9UVmPZiv+nIexw6a+EK/4Iy2hNTyRNnXtP77PcfPAlUAUgx+Q/8cowiRCbzLCqGZOXQNakt2J+H1qX+Qe/AaX6VDWyspDwIKP9I2Up2nteo/8fc8zZ4hX8iJA3dBI5NBkyqDJFAQVq9INrlpey1Ewx6GOFyVG7PHP4M0HRnh7o+b8ilKG3f7R2gtnjUDSdKAMD36PQpQ0mWSPcKuFwHLdombyMPH7yw2eEWEjPGHQgqZUJy2vco5aFSsZ1h/8tddpXyXk8ZHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662163049; bh=lzZ+BwleiJlTzulqcRaP0oz2+kLqOG1WXKPQ9D2HrAG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=asblWkJnerzdk+aFEOGfsio6btf2aDnkM2akV53BmQdmFxGMuL+chBZ73OwM+Kagz65XhxTtNMUGWRVl+xSTRj71SWf37086wvRIEvAA2PwzHI+0N0Hz4WWW0ELie34Zym/4ZdomGWR5+YCsDevyPpvP75edLorWYLgK+Z/jQcPR3y56NjnwtErcqsuqMHC6skHgJLG2H+ZjCZ0Z1YK4p5x37y5JbPXGTN15oGFhNsxmd3XN8sCisbAdwTf7k7MFH3JHql1M4HAOQqtzXZ72UL/4hXgzkhYAtALEttEkaI6lSDvx3Q+rFiLxGnRhfD+5lSWP8p4tO7RLnnObyDoDXg==
X-YMail-OSG: kIXA54YVM1lc1eZC9V8dkYgZANt6p66v6tjUXB.iX6FC95EVxbnaJPHItvXCzmn
 1t8oWw_FXj5BoOjXie8SIZHO.Xal2ppKsMtZnt4KVoHNX6eXbXZR93jRNbRORarGcOpL8ZLWFzy8
 W8IgM3xAWnvhcjwEMbQOvtczXgG3nOellzboFHhWvuEPIQJNr36hgHRAl9YpPdWzSwZHi1qhuphz
 aFrxqmdPOGiNvQa59NjxDFvYl63f5QtR18ddj.kPZ1jmEFgxzfa1Bs95SzT0j2_wAklP.MSiSqW3
 kX9cZd.KNBQQz0rlPxf0bYF0tuAp8T1ALxu_aeWxalIbCTVIDu81KBGsrcXrmbmn2iYbGhCNpwiL
 7sKY2UgyWwR4hHK4nlCPaGSa2PDTRdK0FNVZAl8hUlaI7RFbC_GL3VKZ0TfOUfCEA9GT5.PbQc4o
 .VP1q6iGcKh2ofhoMRWJJWcB4Dv3Lfqfm_odFYJmuA9xPAe8gaD9qw6y.qEA6X.qf49gxBrZ9l3k
 X8lwgoDg7dj1rvGNLmObVZtvb2ShyOtCT5v_6V.z_pwasdMRC9o.0mRa7dFNEr5KCOAOkCQTYvW3
 NFpSaA9wYXlyEp30nU9wVS8ibVincKPMIitpuiPKwnYyp.G.NoI2ylVS9G7Ju3Ud6dMgsqpH2eWH
 OINo0xmpPyBpcKiehihdnWDHl3QWwl6TGZJK5O.tdV1fx9VC8ZeXjBvcG0t68FUcwMC6i9Zc3gvO
 D2gORgiCjL7piOizZOue8ryBMvOvz3.QJJzxujJ9PfZoxmajyDmbjJgbcg5Ta7dVCpKy.Q2lxTIA
 2hTFaIGDJqzNr9Yfk7vlB8v.UU9Y31Hviwfh8b1pxiuEQAV7wBPeZTjNWTLVHlYN45fFp974ryY6
 qVqE_4jplbYPvqC9Ecsz64OJtCr_kFzGRO6Grn.XkmGaTq1dSfCW9O6V64VMN15Gv0szg9bC7NYt
 rnPba6uEr37HUtksq1liprAUskukBA2yX.6555nR20fYe3PkAThRabdR3jmxQ9vIC13ZH0UiDyf.
 7W2tm4NoIp0XPys5jSoPA8FB5C8HfzuSBGrqj07nHn26t2CqnEB8X8CZDQyVU6.UIZsfY_Pzh_XW
 5OXpiijMS12UkdRppFuKLed9zVHt_R8fW89FpXRO4hXZmAPtcL6JjqWn51QoNcFb4f0LILKLFJYf
 18289OUh_lscb4E3fehlceO_2o9gbEjpsW2JCt34vrBFNhOSIFA8tJ3MW_wWKnR.aRtel4X8gtxv
 YAN6j4wfRELBYVTN9.KVERj5txhPQcMSRf2FULiC83eY4AkiErDG.3HsDK7HcDQANFbDGAD.7Uza
 lIypB4Wt.st9oLjzAP.Yq6g1_9twCzNoiKdpUs.i2GFtW6ewbhyGo3V71CpIEmJTnEBlOvJx8cO2
 l1efHko64MrjTxH8fp2Pf8QyV7Il0MpgtWganGtZASTv9H8ONkzqIrNRA83YA.xJDrgQBloNFjK8
 AkhmRGZE8pRnV6vomLg_ndOrQc0yek1kihT8sP8FsJXYHhgA.oBgp2gSErOm40dwYRMCthvGWCrC
 i6ia2abxdD8MhiGLDC7ilZqLJE3roZNfKPsLQeahlwI_m6rUs7dnRv9SVcZxQ6_ZvWg75SMBJOow
 wKrv92Q_j.X7Zvj29J.ykOjglr4u608HFE3eJ6.6u4G8y5cfq2AH9y1KmTqdjHp0IYbsxORnGeTA
 lGBgZH7qEQkGK7A8Fff6KFxtHmBvwFazo3uTPGz8LUe_BWt.QaMUtbvWJvQyYoqlw.l2u8W9jF8v
 QeZ3EfvQwgk.qbGitrAVcfoCFRhEIYOLtpAWGGB_0hWLaA.mI76aSB8tR2EeSvfJJSYxhW06grET
 jHXVY1Zis2NhZOhKY0vjdBKXrCsiNnHlzZO_Ceg209q1wUX3LH.3oSANqZ.gBqBTFnRY2cbncwri
 iuJ8reXN1Tr5BmMhzB.9tql1AflHP.IMzCZ6jb0_mkylntR8WxFNyIK_hcfuDvg9BbWb7.hNysF5
 M05meZyupOrw7naA4ojHDtXHzg_hqUVAWDzHkP2J16UNG54BFZOZdzlDPvhHyLpJha8KcNnBS.8w
 Wkm69izP6V6diXnkWnFlr5oVqtYwJwlOwthQnpRDN9wi6miWsEaWrBtULqrGOHxVFK4nykcBuEI8
 ykxDAp3cxTqeIdxpq9e0UV5J7jAg5DtTfQIvNRsZTaJEIkDqKOLmJIid85nc8O.SzR_kmTGWd6S7
 2J0zg6SUre3CKZ9iwErhHoazvJChznZp6WiGtjsUmrv4BhKKCzIrAxYiZYSN8N2LV1wXeATT1atc
 5Qbwc7yZyR.143mk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Sep 2022 23:57:29 +0000
Received: by hermes--production-ne1-544744cc75-fkh7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f5f3b3380822affbe3f1471f6cae7b8;
          Fri, 02 Sep 2022 23:57:26 +0000 (UTC)
Message-ID: <e4683932-a76d-b55a-713f-d0611f882667@schaufler-ca.com>
Date:   Fri, 2 Sep 2022 16:57:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/2/2022 4:14 PM, Casey Schaufler wrote:
> On 9/2/2022 2:30 PM, Paul Moore wrote:
> ...
>> I think it's time to think about a proper set of LSM syscalls.
> At the very least we need a liblsm that preforms a number of useful
> functions

Which would include at least these. I used a different prefix so as
to avoid confusion with Paul's proposal. As these aren't syscalls they
may allocate memory. All can be done today.

struct lsm_context {
	char *lsm;	/* security module name */
	char *context;	/* value for this security module */
};

struct lsm_contexts {
	int count;
	struct lsm_context contexts[];	/* I think this is ok these days */
}

/*
 * lsm_self_contexts - get the security context of this process
 *
 * Returns an allocated lsm_contexts structure, or NULL on error.
 */
struct lsm_contexts *lsm_self_contexts(void)

/*
 * lsm_pid_contexts - get the security context of a process
 * @pid: process id of interest
 *
 * Returns an allocated lsm_contexts structure, or NULL on error.
 */
strcut lsm_contexts *lsm_pid_contexts(int pid)

/*
 * lsm_get_path_contexts - get the security context of a file
 * @path: path of interest
 *
 * Returns an allocated lsm_contexts structure, or NULL on error.
 */
struct lsm_contexts *lsm_get_path_contexts(char *path)

/*
 * lsm_set_path_contexts - set the security context of a file
 * @path: path of interest
 * @ctx: the context
 *
 * Note: needs to have deterministic behavior if 1st entry can be set
 * but 2nd can't.
 *
 * Returns 0 on success, a security module specific error on failure.
 */
int lsm_set_path_contexts(char *path, struct *lsm_contexts)

/*
 * lsm_free_contexts - free a lsm_contexts structure.
 */
void lsm_free_contexts(struct *lsm_contexts)

Also needs interfaces for SO_PEERSEC and SYSVIPC.

