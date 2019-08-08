Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9239CC41514
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 23:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685982173E
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 23:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j0VLDT5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfHHXi2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:38:28 -0400
Received: from sonic307-14.consmr.mail.gq1.yahoo.com ([98.137.64.38]:41759
        "EHLO sonic307-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733258AbfHHXi1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 19:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565307506; bh=R/GcMBCHaO458YwWDPlA3/wk4IrmwfEW2nPzPAMc2r4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=j0VLDT5mnk4U/zJP32t5Z0ljQJfbOflKUsSTTveIeiB88ETbRVuDOcj6LUPB2Z8TOlx6BYugTqIVhrBqA87XQO1mO3r/xOIMHJbraN9Ma0i5Vgh32mPuhgqFPJtv3dinWZG13fRYyjLkNie1z+Y8SxI0oTkrxT5RFII+N3hirHpy8IOGiCMLzhZRgpLkIHOW6c5HpyeFb70YgZ9LWS/5rrPza5n8CdSx/cMTXWo/iYne8onZenwMewfDg36EnVG33wl/ADg9wKQpcNTvp2NhBCX/x5kcbGlNk0FQS37gE3h9Z1BVMfE8FgImY+seE/KyWbMLjkDkDYacHfekaqTt9g==
X-YMail-OSG: CVWNwhIVM1nHuDbqdLBGujrNPWdZnzusIYk9WiYRRsMsWHGCb8rAo3cAYJgIQyc
 EGSCy7YMtLzB2Vnu8PqtgAK7SLaEzV1R1HBY1hu9PqMQ0R_Y4vg6TV9hOt4JNsrh59iDFMuG4L05
 ucZ4psMg4yv_3YwNRot2vxvKQaXoOVc_PZIghef_0pC8yeELg2pEGSVPsJphmszHfwZl4EPXlDbg
 FAEicC1ewQrJLhCdsNT62o49LqPNXfyci9Ba1CPl5B2ZhzLpWf_SU_u3UqJh2g8Fr4hswxeImW7Q
 eVN0YSV6HMPSfyhEk8sP_aZENMicjWVVfnp6EFbt3ZkrAJtgugUV_1X__Z9D6dz5vfwxL2LnrWxZ
 ACGqxVZi5sGbVfJxPHf112G_FOaaKgxgs08LoOPPxd3kbX1Kflb0GX68s_62RmOhaC7IhZ.XmeJc
 6S3VDVrpHdzfteN7uK7w1DpYvoLN0htuB9lU.GmRZpWOIbHJk.kmn1yFqt510._cAjeL.UDmeDk_
 3et4bC8ku4WF50d1TXzS0EVJdgdT7l.eWCcOmaE2.9h3s4SAd94zJPdJYYruhnRHvw_MCslU7p3r
 fzXVBghIELBrWnCfUqgR9nfXGBUetDQ0K0u34Yp_kp_ktJuR3z_aOFo2wi7nha1Lw6M0EuGcbVqV
 4cG4xUTZK_NTwWBG43lLm1gZnWgrISyujRDQdCuGvfftHnFlfdAQXz4KE9v8supiMhk9lh.VluK6
 jYEblRdAAVYcw8nLZMZvpgG_kHAp9LWLFKTxVGQAxS1_vjmLTmuiYoyyamx4hzykEMPaI8IQos1G
 6RMzFPvyHatUsZ6xU5cx40Ijk715YS8bAtqqEJZrW6OIxRRsdGP9qLI6nRmX2ghg37JKQtGqTwls
 vRA9gMzv0qisWv8Fo343J67eXbb2kdR7Dn2qkWQt5WNIYxKG0WLrmqlY64DQGwtvJb_Yt3kYDXFW
 y.ZaoIDOZdGRgNmzh7xaaiuZVNrJJa3Susak_pQbg.JSMGEt5kyJqz45ZaBuLr6fYF_Dibl6hhIe
 QzQoBjW5YhbzikNC1bhL.iTf3we8.iK601EOFO12tp57wJR71oV9xDPb0DRsr_sEK5S.OmPELF64
 teVeBfHybBB0qr2o.QyQ9v3r5lEJSOAhkrX9lP0Egn2HadhYPloUXDaltliDUHenh8IfGAg136Vy
 fmdJLce5zC0V8hjnUL8.2sqximN4cAe_nVqEFrM6tCBAtHdcRbobPxGNJRvViETe1SWRcOKXwUN5
 _4.3fs5TxPhl58PvSMK2dBhKaPmZjz3vk4v01HLXz.bVNT_MQSr9Z2pM.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 8 Aug 2019 23:38:26 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a6913b45c7b42f38e318ece79b6397a3;
          Thu, 08 Aug 2019 23:38:22 +0000 (UTC)
Subject: Re: [PATCH v7 15/28] LSM: Specify which LSM to display
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-16-casey@schaufler-ca.com>
 <201908081424.21002A3@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a3ffb9ac-3162-046b-542f-8c99f26b97c8@schaufler-ca.com>
Date:   Thu, 8 Aug 2019 16:38:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908081424.21002A3@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2019 2:39 PM, Kees Cook wrote:
> On Wed, Aug 07, 2019 at 12:43:57PM -0700, Casey Schaufler wrote:
>> @@ -1980,10 +2033,48 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>>  			 size_t size)
>>  {
>>  	struct security_hook_list *hp;
>> +	char *term;
>> +	char *cp;
>> +	int *display = current->security;
> So I went down a rat hole looking at setprocattr vs current. It looks
> like everything ignores the $pid part of /proc/$pid/attr/$name and only
> ever operates on "current". Is that the expected interface here?

Yes. procfs enforces the policy that writes can only affect "self".

>
>> +	int rc = -EINVAL;
>> +	int slot = 0;
>> +
>> +	if (!strcmp(name, "display")) {
>> +		if (!capable(CAP_MAC_ADMIN))
>> +			return -EPERM;
>> +		/*
>> +		 * lsm_slot will be 0 if there are no displaying modules.
>> +		 */
>> +		if (lsm_slot == 0 || size == 0)
>> +			return -EINVAL;
> ...
>
>> +		cp = kzalloc(size + 1, GFP_KERNEL);
>> +		if (cp == NULL)
>> +			return -ENOMEM;
>> +		memcpy(cp, value, size);
> Saving one line, the above can be:
>
> 		cp = kmemdup_nul(value, size, GFP_KERNEL);
> 		if (cp == NULL)
> 			return -ENOMEM;

Thanks. That would be better.

>
>> +		term = strchr(cp, ' ');
>> +		if (term == NULL)
>> +			term = strchr(cp, '\n');
> "foo\n " will result in "foo\n". I think you want strsep() instead of
> the above three lines:
>
> 		term = strsep(cp, " \n");

That would be better.

>
>> +		if (term != NULL)
>> +			*term = '\0';
>> +
>> +		for (slot = 0; slot < lsm_slot; slot++)
>> +			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
>> +				*display = lsm_slotlist[slot]->slot;
>> +				rc = size;
>> +				break;
>> +			}
>> +
>> +		kfree(cp);
>> +		return rc;
>> +	}
>>  
>>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
>> +		    *display != hp->lsmid->slot)
>> +			continue;
>>  		return hp->hook.setprocattr(name, value, size);
>>  	}
>>  	return -EINVAL;
> Otherwise, yeah, seems good.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
